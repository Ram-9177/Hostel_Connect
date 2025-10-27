import React, { useState, useEffect } from 'react';
import { Calendar, Clock, User, MapPin, Filter, Download, RefreshCw, Search, Eye, AlertTriangle } from 'lucide-react';
import './StudentInOutDashboard.css';

interface StudentRecord {
  id: string;
  studentId: string;
  studentName: string;
  hostelId: string;
  hostelName: string;
  roomNumber: string;
  eventType: 'IN' | 'OUT';
  timestamp: string;
  location: string;
  gatePassId?: string;
  reason?: string;
  status: 'SUCCESS' | 'FAILED' | 'PENDING';
  securityGuardId?: string;
  securityGuardName?: string;
  duration?: number; // minutes spent outside
  isLate?: boolean;
  isEarly?: boolean;
}

interface DashboardStats {
  totalStudents: number;
  studentsIn: number;
  studentsOut: number;
  todayEntries: number;
  todayExits: number;
  lateReturns: number;
  earlyReturns: number;
  averageTimeOutside: number;
  mostActiveHours: string[];
}

const StudentInOutDashboard: React.FC = () => {
  const [records, setRecords] = useState<StudentRecord[]>([]);
  const [filteredRecords, setFilteredRecords] = useState<StudentRecord[]>([]);
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [dateFilter, setDateFilter] = useState('today');
  const [eventTypeFilter, setEventTypeFilter] = useState('all');
  const [statusFilter, setStatusFilter] = useState('all');
  const [selectedStudent, setSelectedStudent] = useState<StudentRecord | null>(null);

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockRecords: StudentRecord[] = [
      {
        id: '1',
        studentId: 'STU001',
        studentName: 'John Student',
        hostelId: 'HOSTEL_A',
        hostelName: 'Boys Hostel A',
        roomNumber: 'A-101',
        eventType: 'OUT',
        timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
        location: 'Main Gate',
        gatePassId: 'GP001',
        reason: 'Medical Emergency',
        status: 'SUCCESS',
        securityGuardId: 'SG001',
        securityGuardName: 'Security Guard 1',
        duration: 120,
        isLate: false,
        isEarly: false
      },
      {
        id: '2',
        studentId: 'STU002',
        studentName: 'Jane Student',
        hostelId: 'HOSTEL_B',
        hostelName: 'Girls Hostel B',
        roomNumber: 'B-205',
        eventType: 'IN',
        timestamp: new Date(Date.now() - 1 * 60 * 60 * 1000).toISOString(),
        location: 'Main Gate',
        gatePassId: 'GP002',
        reason: 'Library Visit',
        status: 'SUCCESS',
        securityGuardId: 'SG001',
        securityGuardName: 'Security Guard 1',
        duration: 90,
        isLate: true,
        isEarly: false
      },
      {
        id: '3',
        studentId: 'STU003',
        studentName: 'Mike Student',
        hostelId: 'HOSTEL_A',
        hostelName: 'Boys Hostel A',
        roomNumber: 'A-102',
        eventType: 'OUT',
        timestamp: new Date(Date.now() - 30 * 60 * 1000).toISOString(),
        location: 'Main Gate',
        gatePassId: 'GP003',
        reason: 'Family Visit',
        status: 'PENDING',
        securityGuardId: 'SG002',
        securityGuardName: 'Security Guard 2',
        duration: 0,
        isLate: false,
        isEarly: false
      }
    ];

    const mockStats: DashboardStats = {
      totalStudents: 150,
      studentsIn: 120,
      studentsOut: 30,
      todayEntries: 45,
      todayExits: 38,
      lateReturns: 5,
      earlyReturns: 12,
      averageTimeOutside: 95,
      mostActiveHours: ['18:00', '19:00', '20:00', '21:00']
    };

    setRecords(mockRecords);
    setStats(mockStats);
    setLoading(false);
  }, []);

  // Filter records based on search and filters
  useEffect(() => {
    let filtered = records;

    // Search filter
    if (searchTerm) {
      filtered = filtered.filter(record =>
        record.studentName.toLowerCase().includes(searchTerm.toLowerCase()) ||
        record.studentId.toLowerCase().includes(searchTerm.toLowerCase()) ||
        record.roomNumber.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    // Event type filter
    if (eventTypeFilter !== 'all') {
      filtered = filtered.filter(record => record.eventType === eventTypeFilter);
    }

    // Status filter
    if (statusFilter !== 'all') {
      filtered = filtered.filter(record => record.status === statusFilter);
    }

    // Date filter
    if (dateFilter !== 'all') {
      const now = new Date();
      const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
      
      if (dateFilter === 'today') {
        filtered = filtered.filter(record => new Date(record.timestamp) >= today);
      } else if (dateFilter === 'yesterday') {
        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);
        filtered = filtered.filter(record => {
          const recordDate = new Date(record.timestamp);
          return recordDate >= yesterday && recordDate < today;
        });
      } else if (dateFilter === 'week') {
        const weekAgo = new Date(today);
        weekAgo.setDate(weekAgo.getDate() - 7);
        filtered = filtered.filter(record => new Date(record.timestamp) >= weekAgo);
      }
    }

    setFilteredRecords(filtered);
  }, [records, searchTerm, dateFilter, eventTypeFilter, statusFilter]);

  const formatTime = (timestamp: string) => {
    return new Date(timestamp).toLocaleString();
  };

  const formatDuration = (minutes: number) => {
    if (minutes < 60) {
      return `${minutes}m`;
    }
    const hours = Math.floor(minutes / 60);
    const remainingMinutes = minutes % 60;
    return `${hours}h ${remainingMinutes}m`;
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'SUCCESS': return 'success';
      case 'FAILED': return 'error';
      case 'PENDING': return 'warning';
      default: return 'default';
    }
  };

  const getEventTypeColor = (eventType: string) => {
    return eventType === 'IN' ? 'in' : 'out';
  };

  const exportData = () => {
    const csvContent = [
      ['Student ID', 'Student Name', 'Room', 'Event Type', 'Timestamp', 'Location', 'Status', 'Reason', 'Duration'],
      ...filteredRecords.map(record => [
        record.studentId,
        record.studentName,
        record.roomNumber,
        record.eventType,
        formatTime(record.timestamp),
        record.location,
        record.status,
        record.reason || '',
        record.duration ? formatDuration(record.duration) : ''
      ])
    ].map(row => row.join(',')).join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `student_records_${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };

  const refreshData = () => {
    setLoading(true);
    // Simulate API call
    setTimeout(() => {
      setLoading(false);
    }, 1000);
  };

  if (loading) {
    return (
      <div className="dashboard-loading">
        <div className="loading-spinner"></div>
        <p>Loading dashboard data...</p>
      </div>
    );
  }

  return (
    <div className="student-in-out-dashboard">
      {/* Header */}
      <div className="dashboard-header">
        <div className="header-content">
          <h1>📊 Student In/Out Dashboard</h1>
          <p>Real-time tracking of student movements and gate activities</p>
        </div>
        <div className="header-actions">
          <button className="refresh-btn" onClick={refreshData}>
            <RefreshCw className="icon" />
            Refresh
          </button>
          <button className="export-btn" onClick={exportData}>
            <Download className="icon" />
            Export
          </button>
        </div>
      </div>

      {/* Statistics Cards */}
      {stats && (
        <div className="stats-grid">
          <div className="stat-card total">
            <div className="stat-icon">👥</div>
            <div className="stat-content">
              <div className="stat-value">{stats.totalStudents}</div>
              <div className="stat-label">Total Students</div>
            </div>
          </div>
          <div className="stat-card in">
            <div className="stat-icon">🏠</div>
            <div className="stat-content">
              <div className="stat-value">{stats.studentsIn}</div>
              <div className="stat-label">Students In</div>
            </div>
          </div>
          <div className="stat-card out">
            <div className="stat-icon">🚶‍♂️</div>
            <div className="stat-content">
              <div className="stat-value">{stats.studentsOut}</div>
              <div className="stat-label">Students Out</div>
            </div>
          </div>
          <div className="stat-card entries">
            <div className="stat-icon">📥</div>
            <div className="stat-content">
              <div className="stat-value">{stats.todayEntries}</div>
              <div className="stat-label">Today's Entries</div>
            </div>
          </div>
          <div className="stat-card exits">
            <div className="stat-icon">📤</div>
            <div className="stat-content">
              <div className="stat-value">{stats.todayExits}</div>
              <div className="stat-label">Today's Exits</div>
            </div>
          </div>
          <div className="stat-card late">
            <div className="stat-icon">⏰</div>
            <div className="stat-content">
              <div className="stat-value">{stats.lateReturns}</div>
              <div className="stat-label">Late Returns</div>
            </div>
          </div>
        </div>
      )}

      {/* Filters */}
      <div className="filters-section">
        <div className="search-box">
          <Search className="search-icon" />
          <input
            type="text"
            placeholder="Search students, room numbers..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
        
        <div className="filter-controls">
          <select value={dateFilter} onChange={(e) => setDateFilter(e.target.value)}>
            <option value="all">All Time</option>
            <option value="today">Today</option>
            <option value="yesterday">Yesterday</option>
            <option value="week">This Week</option>
          </select>
          
          <select value={eventTypeFilter} onChange={(e) => setEventTypeFilter(e.target.value)}>
            <option value="all">All Events</option>
            <option value="IN">Entry Only</option>
            <option value="OUT">Exit Only</option>
          </select>
          
          <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)}>
            <option value="all">All Status</option>
            <option value="SUCCESS">Success</option>
            <option value="FAILED">Failed</option>
            <option value="PENDING">Pending</option>
          </select>
        </div>
      </div>

      {/* Records Table */}
      <div className="records-section">
        <div className="section-header">
          <h2>📋 Student Records ({filteredRecords.length})</h2>
          <div className="record-summary">
            <span className="summary-item">
              <span className="summary-label">Entries:</span>
              <span className="summary-value">{filteredRecords.filter(r => r.eventType === 'IN').length}</span>
            </span>
            <span className="summary-item">
              <span className="summary-label">Exits:</span>
              <span className="summary-value">{filteredRecords.filter(r => r.eventType === 'OUT').length}</span>
            </span>
          </div>
        </div>

        <div className="records-table-container">
          <table className="records-table">
            <thead>
              <tr>
                <th>Student</th>
                <th>Room</th>
                <th>Event</th>
                <th>Time</th>
                <th>Location</th>
                <th>Status</th>
                <th>Duration</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredRecords.map((record) => (
                <tr key={record.id} className={`record-row ${getEventTypeColor(record.eventType)}`}>
                  <td>
                    <div className="student-info">
                      <div className="student-name">{record.studentName}</div>
                      <div className="student-id">{record.studentId}</div>
                    </div>
                  </td>
                  <td>
                    <div className="room-info">
                      <div className="room-number">{record.roomNumber}</div>
                      <div className="hostel-name">{record.hostelName}</div>
                    </div>
                  </td>
                  <td>
                    <div className={`event-type ${record.eventType.toLowerCase()}`}>
                      {record.eventType === 'IN' ? '🔽 Entry' : '🔼 Exit'}
                    </div>
                  </td>
                  <td>
                    <div className="timestamp">
                      <div className="time">{formatTime(record.timestamp)}</div>
                      {record.isLate && <span className="late-indicator">Late</span>}
                      {record.isEarly && <span className="early-indicator">Early</span>}
                    </div>
                  </td>
                  <td>
                    <div className="location">
                      <MapPin className="location-icon" />
                      {record.location}
                    </div>
                  </td>
                  <td>
                    <span className={`status ${getStatusColor(record.status)}`}>
                      {record.status}
                    </span>
                  </td>
                  <td>
                    {record.duration ? formatDuration(record.duration) : '-'}
                  </td>
                  <td>
                    <button 
                      className="view-btn"
                      onClick={() => setSelectedStudent(record)}
                    >
                      <Eye className="icon" />
                      View
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Student Detail Modal */}
      {selectedStudent && (
        <div className="modal-overlay" onClick={() => setSelectedStudent(null)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Student Record Details</h3>
              <button className="close-btn" onClick={() => setSelectedStudent(null)}>×</button>
            </div>
            <div className="modal-body">
              <div className="detail-grid">
                <div className="detail-item">
                  <label>Student Name:</label>
                  <span>{selectedStudent.studentName}</span>
                </div>
                <div className="detail-item">
                  <label>Student ID:</label>
                  <span>{selectedStudent.studentId}</span>
                </div>
                <div className="detail-item">
                  <label>Room:</label>
                  <span>{selectedStudent.roomNumber}</span>
                </div>
                <div className="detail-item">
                  <label>Hostel:</label>
                  <span>{selectedStudent.hostelName}</span>
                </div>
                <div className="detail-item">
                  <label>Event Type:</label>
                  <span className={`event-type ${selectedStudent.eventType.toLowerCase()}`}>
                    {selectedStudent.eventType}
                  </span>
                </div>
                <div className="detail-item">
                  <label>Timestamp:</label>
                  <span>{formatTime(selectedStudent.timestamp)}</span>
                </div>
                <div className="detail-item">
                  <label>Location:</label>
                  <span>{selectedStudent.location}</span>
                </div>
                <div className="detail-item">
                  <label>Status:</label>
                  <span className={`status ${getStatusColor(selectedStudent.status)}`}>
                    {selectedStudent.status}
                  </span>
                </div>
                {selectedStudent.reason && (
                  <div className="detail-item">
                    <label>Reason:</label>
                    <span>{selectedStudent.reason}</span>
                  </div>
                )}
                {selectedStudent.duration && (
                  <div className="detail-item">
                    <label>Duration:</label>
                    <span>{formatDuration(selectedStudent.duration)}</span>
                  </div>
                )}
                {selectedStudent.securityGuardName && (
                  <div className="detail-item">
                    <label>Security Guard:</label>
                    <span>{selectedStudent.securityGuardName}</span>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default StudentInOutDashboard;
