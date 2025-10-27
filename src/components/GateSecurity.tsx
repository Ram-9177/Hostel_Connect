import React, { useState, useEffect } from 'react';
import QRScanner from './QRScanner';
import './GateSecurity.css';

interface GatePass {
  id: string;
  studentId: string;
  studentName: string;
  hostelId: string;
  reason: string;
  startTime: string;
  endTime: string;
  status: 'APPROVED' | 'PENDING' | 'REJECTED';
  qrCode: string;
  createdAt: string;
}

interface GateEvent {
  id: string;
  gatePassId: string;
  studentId: string;
  studentName: string;
  eventType: 'IN' | 'OUT';
  timestamp: string;
  location: string;
  status: 'SUCCESS' | 'FAILED';
  reason?: string;
}

interface GateSecurityProps {
  onNavigate?: (page: string) => void;
}

const GateSecurity: React.FC<GateSecurityProps> = ({ onNavigate }) => {
  const [isScanning, setIsScanning] = useState(false);
  const [currentPass, setCurrentPass] = useState<GatePass | null>(null);
  const [recentEvents, setRecentEvents] = useState<GateEvent[]>([]);
  const [scanResult, setScanResult] = useState<string>('');
  const [scanStatus, setScanStatus] = useState<'idle' | 'scanning' | 'processing' | 'success' | 'error'>('idle');
  const [errorMessage, setErrorMessage] = useState<string>('');

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockEvents: GateEvent[] = [
      {
        id: '1',
        gatePassId: 'pass_001',
        studentId: 'STU001',
        studentName: 'John Student',
        eventType: 'OUT',
        timestamp: new Date(Date.now() - 300000).toISOString(),
        location: 'Main Gate',
        status: 'SUCCESS'
      },
      {
        id: '2',
        gatePassId: 'pass_002',
        studentId: 'STU002',
        studentName: 'Jane Student',
        eventType: 'IN',
        timestamp: new Date(Date.now() - 600000).toISOString(),
        location: 'Main Gate',
        status: 'SUCCESS'
      }
    ];
    setRecentEvents(mockEvents);
  }, []);

  const handleQRScan = async (qrData: string) => {
    setScanStatus('processing');
    setScanResult(qrData);
    
    try {
      // Parse QR code data
      const passData = JSON.parse(qrData);
      
      // Validate gate pass
      const validationResult = await validateGatePass(passData);
      
      if (validationResult.valid) {
        setCurrentPass(validationResult.pass);
        
        // Determine if this is IN or OUT
        const eventType = determineEventType(validationResult.pass);
        
        // Record gate event
        const gateEvent = await recordGateEvent(validationResult.pass, eventType);
        
        setRecentEvents(prev => [gateEvent, ...prev]);
        setScanStatus('success');
        
        // Show success message
        setTimeout(() => {
          setScanStatus('idle');
          setCurrentPass(null);
          setScanResult('');
        }, 3000);
        
      } else {
        setErrorMessage(validationResult.reason);
        setScanStatus('error');
        
        setTimeout(() => {
          setScanStatus('idle');
          setErrorMessage('');
        }, 3000);
      }
      
    } catch (error) {
      setErrorMessage('Invalid QR code format');
      setScanStatus('error');
      
      setTimeout(() => {
        setScanStatus('idle');
        setErrorMessage('');
      }, 3000);
    }
  };

  const validateGatePass = async (passData: any): Promise<{valid: boolean, pass?: GatePass, reason?: string}> => {
    try {
      // Mock API call - replace with actual API
      const response = await fetch('/api/v1/gate-passes/validate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ qrCode: passData.qrCode || passData })
      });

      if (!response.ok) {
        return { valid: false, reason: 'Gate pass not found or expired' };
      }

      const pass = await response.json();
      
      // Check if pass is approved
      if (pass.status !== 'APPROVED') {
        return { valid: false, reason: 'Gate pass not approved' };
      }

      // Check if pass is within valid time range
      const now = new Date();
      const startTime = new Date(pass.startTime);
      const endTime = new Date(pass.endTime);

      if (now < startTime) {
        return { valid: false, reason: 'Gate pass not yet valid' };
      }

      if (now > endTime) {
        return { valid: false, reason: 'Gate pass has expired' };
      }

      return { valid: true, pass };
      
    } catch (error) {
      return { valid: false, reason: 'Failed to validate gate pass' };
    }
  };

  const determineEventType = (pass: GatePass): 'IN' | 'OUT' => {
    // Check recent events to determine if student is currently out
    const recentOutEvent = recentEvents.find(
      event => event.studentId === pass.studentId && 
               event.eventType === 'OUT' && 
               new Date(event.timestamp) > new Date(Date.now() - 24 * 60 * 60 * 1000) // Last 24 hours
    );

    const recentInEvent = recentEvents.find(
      event => event.studentId === pass.studentId && 
               event.eventType === 'IN' && 
               event.timestamp > recentOutEvent?.timestamp
    );

    // If there's a recent OUT event without a corresponding IN event, this should be IN
    if (recentOutEvent && !recentInEvent) {
      return 'IN';
    }

    // Otherwise, this should be OUT
    return 'OUT';
  };

  const recordGateEvent = async (pass: GatePass, eventType: 'IN' | 'OUT'): Promise<GateEvent> => {
    const gateEvent: GateEvent = {
      id: `event_${Date.now()}`,
      gatePassId: pass.id,
      studentId: pass.studentId,
      studentName: pass.studentName,
      eventType,
      timestamp: new Date().toISOString(),
      location: 'Main Gate',
      status: 'SUCCESS'
    };

    // Mock API call - replace with actual API
    try {
      await fetch('/api/v1/gate/scan', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(gateEvent)
      });
    } catch (error) {
      console.error('Failed to record gate event:', error);
    }

    return gateEvent;
  };

  const handleScanError = (error: string) => {
    setErrorMessage(error);
    setScanStatus('error');
  };

  const toggleScanner = () => {
    setIsScanning(!isScanning);
    setScanStatus('idle');
    setErrorMessage('');
  };

  const formatTime = (timestamp: string) => {
    return new Date(timestamp).toLocaleString();
  };

  return (
    <div className="gate-security">
      <div className="gate-header">
        <h1>🚪 Gate Security Dashboard</h1>
        <div className="gate-status">
          <span className={`status-indicator ${isScanning ? 'active' : 'inactive'}`}>
            {isScanning ? '🟢 Scanning Active' : '🔴 Scanner Off'}
          </span>
          <button 
            onClick={() => onNavigate?.('settings')} 
            className="settings-btn"
            style={{ marginLeft: '12px', padding: '8px 16px', background: '#6366f1', color: 'white', border: 'none', borderRadius: '6px', cursor: 'pointer' }}
          >
            ⚙️ Settings
          </button>
        </div>
      </div>

      <div className="gate-content">
        {/* QR Scanner Section */}
        <div className="scanner-section">
          <div className="scanner-controls">
            <button 
              className={`scanner-toggle ${isScanning ? 'stop' : 'start'}`}
              onClick={toggleScanner}
            >
              {isScanning ? '🛑 Stop Scanner' : '📷 Start Scanner'}
            </button>
          </div>

          <QRScanner
            onScan={handleQRScan}
            onError={handleScanError}
            isActive={isScanning}
          />

          {/* Scan Status */}
          {scanStatus !== 'idle' && (
            <div className={`scan-status ${scanStatus}`}>
              {scanStatus === 'processing' && (
                <div className="processing">
                  <div className="spinner"></div>
                  <p>Processing QR code...</p>
                </div>
              )}
              
              {scanStatus === 'success' && currentPass && (
                <div className="success">
                  <div className="success-icon">✅</div>
                  <h3>Gate Pass Valid!</h3>
                  <div className="pass-details">
                    <p><strong>Student:</strong> {currentPass.studentName}</p>
                    <p><strong>ID:</strong> {currentPass.studentId}</p>
                    <p><strong>Reason:</strong> {currentPass.reason}</p>
                    <p><strong>Valid Until:</strong> {formatTime(currentPass.endTime)}</p>
                  </div>
                </div>
              )}
              
              {scanStatus === 'error' && (
                <div className="error">
                  <div className="error-icon">❌</div>
                  <h3>Scan Failed</h3>
                  <p>{errorMessage}</p>
                </div>
              )}
            </div>
          )}
        </div>

        {/* Recent Events */}
        <div className="events-section">
          <h2>📋 Recent Gate Events</h2>
          <div className="events-list">
            {recentEvents.length === 0 ? (
              <div className="no-events">
                <p>No recent gate events</p>
              </div>
            ) : (
              recentEvents.map((event) => (
                <div key={event.id} className={`event-item ${event.eventType.toLowerCase()}`}>
                  <div className="event-icon">
                    {event.eventType === 'IN' ? '🔽' : '🔼'}
                  </div>
                  <div className="event-details">
                    <div className="event-header">
                      <span className="student-name">{event.studentName}</span>
                      <span className={`event-type ${event.eventType.toLowerCase()}`}>
                        {event.eventType}
                      </span>
                    </div>
                    <div className="event-meta">
                      <span className="timestamp">{formatTime(event.timestamp)}</span>
                      <span className="location">{event.location}</span>
                      <span className={`status ${event.status.toLowerCase()}`}>
                        {event.status}
                      </span>
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
        </div>

        {/* Quick Stats */}
        <div className="stats-section">
          <h2>📊 Today's Statistics</h2>
          <div className="stats-grid">
            <div className="stat-card">
              <div className="stat-icon">🚶‍♂️</div>
              <div className="stat-value">
                {recentEvents.filter(e => e.eventType === 'OUT').length}
              </div>
              <div className="stat-label">Students Out</div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">🏠</div>
              <div className="stat-value">
                {recentEvents.filter(e => e.eventType === 'IN').length}
              </div>
              <div className="stat-label">Students In</div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">✅</div>
              <div className="stat-value">
                {recentEvents.filter(e => e.status === 'SUCCESS').length}
              </div>
              <div className="stat-label">Successful Scans</div>
            </div>
            <div className="stat-card">
              <div className="stat-icon">❌</div>
              <div className="stat-value">
                {recentEvents.filter(e => e.status === 'FAILED').length}
              </div>
              <div className="stat-label">Failed Scans</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GateSecurity;
