import React, { useState } from 'react';
import { AlertTriangle, Heart, Home, BookOpen, Utensils, Clock, User, Phone, MapPin } from 'lucide-react';
import './EmergencyRequests.css';

interface EmergencyRequest {
  id: string;
  studentId: string;
  studentName: string;
  roomNumber: string;
  hostelName: string;
  requestType: 'HEALTH' | 'FAMILY' | 'ACADEMIC' | 'FOOD' | 'OTHER';
  priority: 'LOW' | 'MEDIUM' | 'HIGH' | 'URGENT';
  title: string;
  description: string;
  contactNumber: string;
  emergencyContact: string;
  location?: string;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'IN_PROGRESS' | 'COMPLETED';
  requestedAt: string;
  approvedBy?: string;
  approvedAt?: string;
  completedAt?: string;
  notes?: string;
}

const EmergencyRequests: React.FC = () => {
  const [requests, setRequests] = useState<EmergencyRequest[]>([
    {
      id: '1',
      studentId: 'STU001',
      studentName: 'John Student',
      roomNumber: 'A-101',
      hostelName: 'Boys Hostel A',
      requestType: 'HEALTH',
      priority: 'URGENT',
      title: 'Medical Emergency - Chest Pain',
      description: 'Experiencing severe chest pain and shortness of breath. Need immediate medical attention.',
      contactNumber: '+91-9876543210',
      emergencyContact: '+91-9876543211 (Father)',
      location: 'Room A-101',
      status: 'PENDING',
      requestedAt: new Date(Date.now() - 5 * 60 * 1000).toISOString()
    },
    {
      id: '2',
      studentId: 'STU002',
      studentName: 'Jane Student',
      roomNumber: 'B-205',
      hostelName: 'Girls Hostel B',
      requestType: 'FOOD',
      priority: 'MEDIUM',
      title: 'Food Allergy Emergency',
      description: 'Accidentally consumed food with nuts. Having allergic reaction. Need antihistamine.',
      contactNumber: '+91-9876543212',
      emergencyContact: '+91-9876543213 (Mother)',
      location: 'Mess Hall',
      status: 'IN_PROGRESS',
      requestedAt: new Date(Date.now() - 15 * 60 * 1000).toISOString(),
      approvedBy: 'Warden Smith',
      approvedAt: new Date(Date.now() - 10 * 60 * 1000).toISOString(),
      notes: 'First aid administered. Monitoring condition.'
    },
    {
      id: '3',
      studentId: 'STU003',
      studentName: 'Mike Student',
      roomNumber: 'A-102',
      hostelName: 'Boys Hostel A',
      requestType: 'FAMILY',
      priority: 'HIGH',
      title: 'Family Emergency - Hospital Visit',
      description: 'Father admitted to hospital. Need to visit immediately.',
      contactNumber: '+91-9876543214',
      emergencyContact: '+91-9876543215 (Sister)',
      location: 'City Hospital',
      status: 'APPROVED',
      requestedAt: new Date(Date.now() - 30 * 60 * 1000).toISOString(),
      approvedBy: 'Warden Johnson',
      approvedAt: new Date(Date.now() - 25 * 60 * 1000).toISOString()
    }
  ]);

  const [selectedRequest, setSelectedRequest] = useState<EmergencyRequest | null>(null);
  const [filterType, setFilterType] = useState('all');
  const [filterPriority, setFilterPriority] = useState('all');
  const [filterStatus, setFilterStatus] = useState('all');

  const handleApprove = (id: string) => {
    setRequests(prev => prev.map(req => 
      req.id === id 
        ? { 
            ...req, 
            status: 'APPROVED' as const,
            approvedBy: 'Current Warden',
            approvedAt: new Date().toISOString()
          }
        : req
    ));
  };

  const handleReject = (id: string, reason: string) => {
    setRequests(prev => prev.map(req => 
      req.id === id 
        ? { 
            ...req, 
            status: 'REJECTED' as const,
            notes: reason
          }
        : req
    ));
  };

  const handleComplete = (id: string) => {
    setRequests(prev => prev.map(req => 
      req.id === id 
        ? { 
            ...req, 
            status: 'COMPLETED' as const,
            completedAt: new Date().toISOString()
          }
        : req
    ));
  };

  const getRequestTypeIcon = (type: string) => {
    switch (type) {
      case 'HEALTH': return <Heart className="type-icon" />;
      case 'FAMILY': return <Home className="type-icon" />;
      case 'ACADEMIC': return <BookOpen className="type-icon" />;
      case 'FOOD': return <Utensils className="type-icon" />;
      case 'OTHER': return <AlertTriangle className="type-icon" />;
      default: return <AlertTriangle className="type-icon" />;
    }
  };

  const getRequestTypeColor = (type: string) => {
    switch (type) {
      case 'HEALTH': return '#dc3545';
      case 'FAMILY': return '#17a2b8';
      case 'ACADEMIC': return '#6f42c1';
      case 'FOOD': return '#fd7e14';
      case 'OTHER': return '#6c757d';
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

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING': return '#ffc107';
      case 'APPROVED': return '#28a745';
      case 'REJECTED': return '#dc3545';
      case 'IN_PROGRESS': return '#17a2b8';
      case 'COMPLETED': return '#6c757d';
      default: return '#6c757d';
    }
  };

  const formatTime = (timestamp: string) => {
    return new Date(timestamp).toLocaleString();
  };

  const filteredRequests = requests.filter(req => {
    const typeMatch = filterType === 'all' || req.requestType === filterType;
    const priorityMatch = filterPriority === 'all' || req.priority === filterPriority;
    const statusMatch = filterStatus === 'all' || req.status === filterStatus;
    return typeMatch && priorityMatch && statusMatch;
  });

  return (
    <div className="emergency-requests">
      {/* Header */}
      <div className="requests-header">
        <div className="header-content">
          <h1>🚨 Emergency Requests</h1>
          <p>Manage student emergency requests and urgent needs</p>
        </div>
        <div className="header-stats">
          <div className="stat-item urgent">
            <span className="stat-value">{requests.filter(r => r.priority === 'URGENT').length}</span>
            <span className="stat-label">Urgent</span>
          </div>
          <div className="stat-item pending">
            <span className="stat-value">{requests.filter(r => r.status === 'PENDING').length}</span>
            <span className="stat-label">Pending</span>
          </div>
          <div className="stat-item in-progress">
            <span className="stat-value">{requests.filter(r => r.status === 'IN_PROGRESS').length}</span>
            <span className="stat-label">In Progress</span>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="filters-section">
        <div className="filter-controls">
          <select 
            value={filterType} 
            onChange={(e) => setFilterType(e.target.value)}
            className="filter-select"
          >
            <option value="all">All Types</option>
            <option value="HEALTH">Health</option>
            <option value="FAMILY">Family</option>
            <option value="ACADEMIC">Academic</option>
            <option value="FOOD">Food</option>
            <option value="OTHER">Other</option>
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
          
          <select 
            value={filterStatus} 
            onChange={(e) => setFilterStatus(e.target.value)}
            className="filter-select"
          >
            <option value="all">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="APPROVED">Approved</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="COMPLETED">Completed</option>
            <option value="REJECTED">Rejected</option>
          </select>
        </div>
      </div>

      {/* Requests List */}
      <div className="requests-section">
        <div className="section-header">
          <h2>📋 Emergency Requests ({filteredRequests.length})</h2>
        </div>

        <div className="requests-grid">
          {filteredRequests.map((request) => (
            <div key={request.id} className="request-card">
              <div className="card-header">
                <div className="request-info">
                  <div className="request-title">{request.title}</div>
                  <div className="student-details">
                    {request.studentName} • {request.studentId} • {request.roomNumber}
                  </div>
                </div>
                <div className="card-badges">
                  <span 
                    className="priority-badge"
                    style={{ backgroundColor: getPriorityColor(request.priority) }}
                  >
                    {request.priority}
                  </span>
                  <span 
                    className="status-badge"
                    style={{ backgroundColor: getStatusColor(request.status) }}
                  >
                    {request.status.replace('_', ' ')}
                  </span>
                </div>
              </div>

              <div className="card-content">
                <div className="request-type">
                  <div 
                    className="type-indicator"
                    style={{ color: getRequestTypeColor(request.requestType) }}
                  >
                    {getRequestTypeIcon(request.requestType)}
                    <span className="type-text">{request.requestType}</span>
                  </div>
                </div>

                <div className="description-section">
                  <p className="description">{request.description}</p>
                </div>

                <div className="contact-section">
                  <div className="contact-item">
                    <Phone className="contact-icon" />
                    <span className="contact-text">{request.contactNumber}</span>
                  </div>
                  <div className="contact-item">
                    <User className="contact-icon" />
                    <span className="contact-text">{request.emergencyContact}</span>
                  </div>
                  {request.location && (
                    <div className="contact-item">
                      <MapPin className="contact-icon" />
                      <span className="contact-text">{request.location}</span>
                    </div>
                  )}
                </div>

                <div className="time-section">
                  <Clock className="time-icon" />
                  <span className="time-text">
                    Requested: {formatTime(request.requestedAt)}
                  </span>
                </div>
              </div>

              <div className="card-actions">
                <button 
                  className="view-btn"
                  onClick={() => setSelectedRequest(request)}
                >
                  View Details
                </button>
                
                {request.status === 'PENDING' && (
                  <>
                    <button 
                      className="approve-btn"
                      onClick={() => handleApprove(request.id)}
                    >
                      Approve
                    </button>
                    <button 
                      className="reject-btn"
                      onClick={() => {
                        const reason = prompt('Enter rejection reason:');
                        if (reason) handleReject(request.id, reason);
                      }}
                    >
                      Reject
                    </button>
                  </>
                )}
                
                {request.status === 'APPROVED' && (
                  <button 
                    className="progress-btn"
                    onClick={() => handleComplete(request.id)}
                  >
                    Mark Complete
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Request Detail Modal */}
      {selectedRequest && (
        <div className="modal-overlay" onClick={() => setSelectedRequest(null)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Emergency Request Details</h3>
              <button className="close-btn" onClick={() => setSelectedRequest(null)}>×</button>
            </div>
            <div className="modal-body">
              <div className="detail-grid">
                <div className="detail-item">
                  <label>Student Name:</label>
                  <span>{selectedRequest.studentName}</span>
                </div>
                <div className="detail-item">
                  <label>Student ID:</label>
                  <span>{selectedRequest.studentId}</span>
                </div>
                <div className="detail-item">
                  <label>Room:</label>
                  <span>{selectedRequest.roomNumber}</span>
                </div>
                <div className="detail-item">
                  <label>Hostel:</label>
                  <span>{selectedRequest.hostelName}</span>
                </div>
                <div className="detail-item">
                  <label>Request Type:</label>
                  <span style={{ color: getRequestTypeColor(selectedRequest.requestType) }}>
                    {getRequestTypeIcon(selectedRequest.requestType)}
                    {selectedRequest.requestType}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Priority:</label>
                  <span 
                    className="priority-text"
                    style={{ color: getPriorityColor(selectedRequest.priority) }}
                  >
                    {selectedRequest.priority}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Title:</label>
                  <span>{selectedRequest.title}</span>
                </div>
                <div className="detail-item full-width">
                  <label>Description:</label>
                  <span>{selectedRequest.description}</span>
                </div>
                <div className="detail-item">
                  <label>Contact Number:</label>
                  <span>{selectedRequest.contactNumber}</span>
                </div>
                <div className="detail-item">
                  <label>Emergency Contact:</label>
                  <span>{selectedRequest.emergencyContact}</span>
                </div>
                {selectedRequest.location && (
                  <div className="detail-item">
                    <label>Location:</label>
                    <span>{selectedRequest.location}</span>
                  </div>
                )}
                <div className="detail-item">
                  <label>Status:</label>
                  <span 
                    className="status-text"
                    style={{ color: getStatusColor(selectedRequest.status) }}
                  >
                    {selectedRequest.status.replace('_', ' ')}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Requested At:</label>
                  <span>{formatTime(selectedRequest.requestedAt)}</span>
                </div>
                {selectedRequest.approvedBy && (
                  <div className="detail-item">
                    <label>Approved By:</label>
                    <span>{selectedRequest.approvedBy}</span>
                  </div>
                )}
                {selectedRequest.approvedAt && (
                  <div className="detail-item">
                    <label>Approved At:</label>
                    <span>{formatTime(selectedRequest.approvedAt)}</span>
                  </div>
                )}
                {selectedRequest.completedAt && (
                  <div className="detail-item">
                    <label>Completed At:</label>
                    <span>{formatTime(selectedRequest.completedAt)}</span>
                  </div>
                )}
                {selectedRequest.notes && (
                  <div className="detail-item full-width">
                    <label>Notes:</label>
                    <span>{selectedRequest.notes}</span>
                  </div>
                )}
              </div>
            </div>
            <div className="modal-footer">
              {selectedRequest.status === 'PENDING' && (
                <>
                  <button 
                    className="approve-btn"
                    onClick={() => {
                      handleApprove(selectedRequest.id);
                      setSelectedRequest(null);
                    }}
                  >
                    Approve Request
                  </button>
                  <button 
                    className="reject-btn"
                    onClick={() => {
                      const reason = prompt('Enter rejection reason:');
                      if (reason) {
                        handleReject(selectedRequest.id, reason);
                        setSelectedRequest(null);
                      }
                    }}
                  >
                    Reject Request
                  </button>
                </>
              )}
              {selectedRequest.status === 'APPROVED' && (
                <button 
                  className="progress-btn"
                  onClick={() => {
                    handleComplete(selectedRequest.id);
                    setSelectedRequest(null);
                  }}
                >
                  Mark Complete
                </button>
              )}
              <button 
                className="close-modal-btn"
                onClick={() => setSelectedRequest(null)}
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

export default EmergencyRequests;
