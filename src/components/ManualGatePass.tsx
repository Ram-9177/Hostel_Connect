import React, { useState } from 'react';
import { Calendar, Clock, User, MapPin, AlertTriangle, CheckCircle, XCircle, Eye } from 'lucide-react';
import './ManualGatePass.css';

interface GatePassApplication {
  id: string;
  studentId: string;
  studentName: string;
  roomNumber: string;
  hostelName: string;
  reason: string;
  description: string;
  startTime: string;
  endTime: string;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'ACTIVE' | 'COMPLETED';
  appliedAt: string;
  approvedBy?: string;
  approvedAt?: string;
  rejectedBy?: string;
  rejectedAt?: string;
  rejectionReason?: string;
  emergencyType?: 'HEALTH' | 'FAMILY' | 'ACADEMIC' | 'OTHER';
  priority: 'LOW' | 'MEDIUM' | 'HIGH' | 'URGENT';
}

const ManualGatePass: React.FC = () => {
  const [applications, setApplications] = useState<GatePassApplication[]>([
    {
      id: '1',
      studentId: 'STU001',
      studentName: 'John Student',
      roomNumber: 'A-101',
      hostelName: 'Boys Hostel A',
      reason: 'Medical Emergency',
      description: 'Need to visit hospital for urgent medical checkup',
      startTime: new Date(Date.now() + 30 * 60 * 1000).toISOString(),
      endTime: new Date(Date.now() + 4 * 60 * 60 * 1000).toISOString(),
      status: 'PENDING',
      appliedAt: new Date(Date.now() - 10 * 60 * 1000).toISOString(),
      emergencyType: 'HEALTH',
      priority: 'URGENT'
    },
    {
      id: '2',
      studentId: 'STU002',
      studentName: 'Jane Student',
      roomNumber: 'B-205',
      hostelName: 'Girls Hostel B',
      reason: 'Family Visit',
      description: 'Parents visiting from out of town',
      startTime: new Date(Date.now() + 2 * 60 * 60 * 1000).toISOString(),
      endTime: new Date(Date.now() + 8 * 60 * 60 * 1000).toISOString(),
      status: 'APPROVED',
      appliedAt: new Date(Date.now() - 30 * 60 * 1000).toISOString(),
      approvedBy: 'Warden Smith',
      approvedAt: new Date(Date.now() - 5 * 60 * 1000).toISOString(),
      emergencyType: 'FAMILY',
      priority: 'MEDIUM'
    }
  ]);

  const [selectedApplication, setSelectedApplication] = useState<GatePassApplication | null>(null);
  const [filterStatus, setFilterStatus] = useState('all');
  const [filterPriority, setFilterPriority] = useState('all');

  const handleApprove = (id: string) => {
    setApplications(prev => prev.map(app => 
      app.id === id 
        ? { 
            ...app, 
            status: 'APPROVED' as const,
            approvedBy: 'Current Warden',
            approvedAt: new Date().toISOString()
          }
        : app
    ));
  };

  const handleReject = (id: string, reason: string) => {
    setApplications(prev => prev.map(app => 
      app.id === id 
        ? { 
            ...app, 
            status: 'REJECTED' as const,
            rejectedBy: 'Current Warden',
            rejectedAt: new Date().toISOString(),
            rejectionReason: reason
          }
        : app
    ));
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING': return '#ffc107';
      case 'APPROVED': return '#28a745';
      case 'REJECTED': return '#dc3545';
      case 'ACTIVE': return '#17a2b8';
      case 'COMPLETED': return '#6c757d';
      default: return '#6c757d';
    }
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'URGENT': return '#dc3545';
      case 'HIGH': return '#fd7e14';
      case 'MEDIUM': return '#ffc107';
      case 'LOW': return '#28a745';
      default: return '#6c757d';
    }
  };

  const getEmergencyIcon = (type: string) => {
    switch (type) {
      case 'HEALTH': return '🏥';
      case 'FAMILY': return '👨‍👩‍👧‍👦';
      case 'ACADEMIC': return '📚';
      case 'OTHER': return '📋';
      default: return '📋';
    }
  };

  const formatTime = (timestamp: string) => {
    return new Date(timestamp).toLocaleString();
  };

  const filteredApplications = applications.filter(app => {
    const statusMatch = filterStatus === 'all' || app.status === filterStatus;
    const priorityMatch = filterPriority === 'all' || app.priority === filterPriority;
    return statusMatch && priorityMatch;
  });

  return (
    <div className="manual-gate-pass">
      {/* Header */}
      <div className="gate-pass-header">
        <div className="header-content">
          <h1>🚪 Manual Gate Pass Applications</h1>
          <p>Review and approve student gate pass requests</p>
        </div>
        <div className="header-stats">
          <div className="stat-item">
            <span className="stat-value">{applications.filter(a => a.status === 'PENDING').length}</span>
            <span className="stat-label">Pending</span>
          </div>
          <div className="stat-item">
            <span className="stat-value">{applications.filter(a => a.status === 'APPROVED').length}</span>
            <span className="stat-label">Approved</span>
          </div>
          <div className="stat-item">
            <span className="stat-value">{applications.filter(a => a.priority === 'URGENT').length}</span>
            <span className="stat-label">Urgent</span>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="filters-section">
        <div className="filter-controls">
          <select 
            value={filterStatus} 
            onChange={(e) => setFilterStatus(e.target.value)}
            className="filter-select"
          >
            <option value="all">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="APPROVED">Approved</option>
            <option value="REJECTED">Rejected</option>
            <option value="ACTIVE">Active</option>
            <option value="COMPLETED">Completed</option>
          </select>
          
          <select 
            value={filterPriority} 
            onChange={(e) => setFilterPriority(e.target.value)}
            className="filter-select"
          >
            <option value="all">All Priority</option>
            <option value="URGENT">Urgent</option>
            <option value="HIGH">High</option>
            <option value="MEDIUM">Medium</option>
            <option value="LOW">Low</option>
          </select>
        </div>
      </div>

      {/* Applications List */}
      <div className="applications-section">
        <div className="section-header">
          <h2>📋 Gate Pass Applications ({filteredApplications.length})</h2>
        </div>

        <div className="applications-grid">
          {filteredApplications.map((application) => (
            <div key={application.id} className="application-card">
              <div className="card-header">
                <div className="student-info">
                  <div className="student-name">{application.studentName}</div>
                  <div className="student-details">
                    {application.studentId} • {application.roomNumber}
                  </div>
                </div>
                <div className="card-badges">
                  <span 
                    className="priority-badge"
                    style={{ backgroundColor: getPriorityColor(application.priority) }}
                  >
                    {application.priority}
                  </span>
                  <span 
                    className="status-badge"
                    style={{ backgroundColor: getStatusColor(application.status) }}
                  >
                    {application.status}
                  </span>
                </div>
              </div>

              <div className="card-content">
                <div className="reason-section">
                  <div className="reason-header">
                    <span className="emergency-icon">
                      {getEmergencyIcon(application.emergencyType || 'OTHER')}
                    </span>
                    <span className="reason-text">{application.reason}</span>
                  </div>
                  <p className="description">{application.description}</p>
                </div>

                <div className="time-section">
                  <div className="time-item">
                    <Clock className="time-icon" />
                    <div className="time-details">
                      <span className="time-label">Start Time</span>
                      <span className="time-value">{formatTime(application.startTime)}</span>
                    </div>
                  </div>
                  <div className="time-item">
                    <Clock className="time-icon" />
                    <div className="time-details">
                      <span className="time-label">End Time</span>
                      <span className="time-value">{formatTime(application.endTime)}</span>
                    </div>
                  </div>
                </div>

                <div className="applied-section">
                  <Calendar className="applied-icon" />
                  <span className="applied-text">
                    Applied: {formatTime(application.appliedAt)}
                  </span>
                </div>
              </div>

              <div className="card-actions">
                <button 
                  className="view-btn"
                  onClick={() => setSelectedApplication(application)}
                >
                  <Eye className="icon" />
                  View Details
                </button>
                
                {application.status === 'PENDING' && (
                  <>
                    <button 
                      className="approve-btn"
                      onClick={() => handleApprove(application.id)}
                    >
                      <CheckCircle className="icon" />
                      Approve
                    </button>
                    <button 
                      className="reject-btn"
                      onClick={() => {
                        const reason = prompt('Enter rejection reason:');
                        if (reason) handleReject(application.id, reason);
                      }}
                    >
                      <XCircle className="icon" />
                      Reject
                    </button>
                  </>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Application Detail Modal */}
      {selectedApplication && (
        <div className="modal-overlay" onClick={() => setSelectedApplication(null)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Gate Pass Application Details</h3>
              <button className="close-btn" onClick={() => setSelectedApplication(null)}>×</button>
            </div>
            <div className="modal-body">
              <div className="detail-grid">
                <div className="detail-item">
                  <label>Student Name:</label>
                  <span>{selectedApplication.studentName}</span>
                </div>
                <div className="detail-item">
                  <label>Student ID:</label>
                  <span>{selectedApplication.studentId}</span>
                </div>
                <div className="detail-item">
                  <label>Room:</label>
                  <span>{selectedApplication.roomNumber}</span>
                </div>
                <div className="detail-item">
                  <label>Hostel:</label>
                  <span>{selectedApplication.hostelName}</span>
                </div>
                <div className="detail-item">
                  <label>Reason:</label>
                  <span>{selectedApplication.reason}</span>
                </div>
                <div className="detail-item">
                  <label>Description:</label>
                  <span>{selectedApplication.description}</span>
                </div>
                <div className="detail-item">
                  <label>Emergency Type:</label>
                  <span>
                    {getEmergencyIcon(selectedApplication.emergencyType || 'OTHER')} 
                    {selectedApplication.emergencyType}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Priority:</label>
                  <span 
                    className="priority-text"
                    style={{ color: getPriorityColor(selectedApplication.priority) }}
                  >
                    {selectedApplication.priority}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Start Time:</label>
                  <span>{formatTime(selectedApplication.startTime)}</span>
                </div>
                <div className="detail-item">
                  <label>End Time:</label>
                  <span>{formatTime(selectedApplication.endTime)}</span>
                </div>
                <div className="detail-item">
                  <label>Status:</label>
                  <span 
                    className="status-text"
                    style={{ color: getStatusColor(selectedApplication.status) }}
                  >
                    {selectedApplication.status}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Applied At:</label>
                  <span>{formatTime(selectedApplication.appliedAt)}</span>
                </div>
                {selectedApplication.approvedBy && (
                  <div className="detail-item">
                    <label>Approved By:</label>
                    <span>{selectedApplication.approvedBy}</span>
                  </div>
                )}
                {selectedApplication.approvedAt && (
                  <div className="detail-item">
                    <label>Approved At:</label>
                    <span>{formatTime(selectedApplication.approvedAt)}</span>
                  </div>
                )}
                {selectedApplication.rejectionReason && (
                  <div className="detail-item">
                    <label>Rejection Reason:</label>
                    <span>{selectedApplication.rejectionReason}</span>
                  </div>
                )}
              </div>
            </div>
            <div className="modal-footer">
              {selectedApplication.status === 'PENDING' && (
                <>
                  <button 
                    className="approve-btn"
                    onClick={() => {
                      handleApprove(selectedApplication.id);
                      setSelectedApplication(null);
                    }}
                  >
                    <CheckCircle className="icon" />
                    Approve Application
                  </button>
                  <button 
                    className="reject-btn"
                    onClick={() => {
                      const reason = prompt('Enter rejection reason:');
                      if (reason) {
                        handleReject(selectedApplication.id, reason);
                        setSelectedApplication(null);
                      }
                    }}
                  >
                    <XCircle className="icon" />
                    Reject Application
                  </button>
                </>
              )}
              <button 
                className="close-modal-btn"
                onClick={() => setSelectedApplication(null)}
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default ManualGatePass;
