import React, { useState, useEffect } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, LineChart, Line, PieChart, Pie, Cell } from 'recharts';
import { TrendingUp, Users, Clock, AlertTriangle, Calendar, Download, ArrowLeft, RefreshCw } from 'lucide-react';
import { cachedDashboardService } from '../services/dashboardService';
import './AnalyticsDashboard.css';

interface AnalyticsData {
  hourlyData: Array<{
    hour: string;
    entries: number;
    exits: number;
  }>;
  dailyData: Array<{
    date: string;
    entries: number;
    exits: number;
    total: number;
  }>;
  weeklyData: Array<{
    week: string;
    entries: number;
    exits: number;
  }>;
  monthlyData: Array<{
    month: string;
    entries: number;
    exits: number;
  }>;
  hostelDistribution: Array<{
    name: string;
    value: number;
    color: string;
  }>;
  peakHours: Array<{
    hour: string;
    count: number;
  }>;
  averageStats: {
    timeOutside: number;
    entriesPerDay: number;
    exitsPerDay: number;
    lateReturns: number;
    earlyReturns: number;
  };
}

const AnalyticsDashboard: React.FC = () => {
  const [analyticsData, setAnalyticsData] = useState<AnalyticsData | null>(null);
  const [selectedPeriod, setSelectedPeriod] = useState('daily');
  const [loading, setLoading] = useState(true);

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockData: AnalyticsData = {
      hourlyData: [
        { hour: '06:00', entries: 2, exits: 0 },
        { hour: '07:00', entries: 5, exits: 1 },
        { hour: '08:00', entries: 8, exits: 2 },
        { hour: '09:00', entries: 12, exits: 3 },
        { hour: '10:00', entries: 15, exits: 5 },
        { hour: '11:00', entries: 18, exits: 8 },
        { hour: '12:00', entries: 20, exits: 12 },
        { hour: '13:00', entries: 22, exits: 15 },
        { hour: '14:00', entries: 25, exits: 18 },
        { hour: '15:00', entries: 28, exits: 20 },
        { hour: '16:00', entries: 30, exits: 22 },
        { hour: '17:00', entries: 35, exits: 25 },
        { hour: '18:00', entries: 40, exits: 30 },
        { hour: '19:00', entries: 45, exits: 35 },
        { hour: '20:00', entries: 50, exits: 40 },
        { hour: '21:00', entries: 55, exits: 45 },
        { hour: '22:00', entries: 60, exits: 50 },
        { hour: '23:00', entries: 65, exits: 55 },
      ],
      dailyData: [
        { date: 'Mon', entries: 45, exits: 38, total: 83 },
        { date: 'Tue', entries: 52, exits: 41, total: 93 },
        { date: 'Wed', entries: 48, exits: 39, total: 87 },
        { date: 'Thu', entries: 55, exits: 43, total: 98 },
        { date: 'Fri', entries: 62, exits: 48, total: 110 },
        { date: 'Sat', entries: 35, exits: 28, total: 63 },
        { date: 'Sun', entries: 28, exits: 22, total: 50 },
      ],
      weeklyData: [
        { week: 'Week 1', entries: 315, exits: 249, total: 564 },
        { week: 'Week 2', entries: 328, exits: 261, total: 589 },
        { week: 'Week 3', entries: 342, exits: 275, total: 617 },
        { week: 'Week 4', entries: 335, exits: 268, total: 603 },
      ],
      monthlyData: [
        { month: 'Jan', entries: 1200, exits: 950, total: 2150 },
        { month: 'Feb', entries: 1350, exits: 1080, total: 2430 },
        { month: 'Mar', entries: 1420, exits: 1150, total: 2570 },
        { month: 'Apr', entries: 1380, exits: 1120, total: 2500 },
      ],
      hostelDistribution: [
        { name: 'Boys Hostel A', value: 45, color: '#8884d8' },
        { name: 'Boys Hostel B', value: 35, color: '#82ca9d' },
        { name: 'Girls Hostel A', value: 30, color: '#ffc658' },
        { name: 'Girls Hostel B', value: 25, color: '#ff7c7c' },
        { name: 'PG Hostel', value: 15, color: '#8dd1e1' },
      ],
      peakHours: [
        { hour: '18:00', count: 70 },
        { hour: '19:00', count: 80 },
        { hour: '20:00', count: 90 },
        { hour: '21:00', count: 100 },
        { hour: '22:00', count: 110 },
      ],
      averageStats: {
        timeOutside: 95,
        entriesPerDay: 45,
        exitsPerDay: 38,
        lateReturns: 5,
        earlyReturns: 12,
      }
    };

    setAnalyticsData(mockData);
    setLoading(false);
  }, []);

  const getChartData = () => {
    if (!analyticsData) return [];
    
    switch (selectedPeriod) {
      case 'hourly':
        return analyticsData.hourlyData;
      case 'daily':
        return analyticsData.dailyData;
      case 'weekly':
        return analyticsData.weeklyData;
      case 'monthly':
        return analyticsData.monthlyData;
      default:
        return analyticsData.dailyData;
    }
  };

  const exportAnalytics = () => {
    if (!analyticsData) return;
    
    const csvContent = [
      ['Period', 'Entries', 'Exits', 'Total'],
      ...getChartData().map(item => [
        item.hour || item.date || item.week || item.month,
        item.entries,
        item.exits,
        item.total || (item.entries + item.exits)
      ])
    ].map(row => row.join(',')).join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `analytics_${selectedPeriod}_${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };

  if (loading) {
    return (
      <div className="analytics-loading">
        <div className="loading-spinner"></div>
        <p>Loading analytics data...</p>
      </div>
    );
  }

  if (!analyticsData) {
    return (
      <div className="analytics-error">
        <AlertTriangle className="error-icon" />
        <p>Failed to load analytics data</p>
      </div>
    );
  }

  return (
    <div className="analytics-dashboard">
      {/* Header */}
      <div className="analytics-header">
        <div className="header-content">
          <h1>📈 Analytics Dashboard</h1>
          <p>Comprehensive insights into student movement patterns</p>
        </div>
        <div className="header-actions">
          <select 
            value={selectedPeriod} 
            onChange={(e) => setSelectedPeriod(e.target.value)}
            className="period-selector"
          >
            <option value="hourly">Hourly</option>
            <option value="daily">Daily</option>
            <option value="weekly">Weekly</option>
            <option value="monthly">Monthly</option>
          </select>
          <button className="export-btn" onClick={exportAnalytics}>
            <Download className="icon" />
            Export
          </button>
        </div>
      </div>

      {/* Key Metrics */}
      <div className="metrics-grid">
        <div className="metric-card">
          <div className="metric-icon">
            <TrendingUp className="icon" />
          </div>
          <div className="metric-content">
            <div className="metric-value">{analyticsData.averageStats.entriesPerDay}</div>
            <div className="metric-label">Avg Entries/Day</div>
          </div>
        </div>
        <div className="metric-card">
          <div className="metric-icon">
            <Users className="icon" />
          </div>
          <div className="metric-content">
            <div className="metric-value">{analyticsData.averageStats.exitsPerDay}</div>
            <div className="metric-label">Avg Exits/Day</div>
          </div>
        </div>
        <div className="metric-card">
          <div className="metric-icon">
            <Clock className="icon" />
          </div>
          <div className="metric-content">
            <div className="metric-value">{analyticsData.averageStats.timeOutside}m</div>
            <div className="metric-label">Avg Time Outside</div>
          </div>
        </div>
        <div className="metric-card">
          <div className="metric-icon">
            <AlertTriangle className="icon" />
          </div>
          <div className="metric-content">
            <div className="metric-value">{analyticsData.averageStats.lateReturns}</div>
            <div className="metric-label">Late Returns</div>
          </div>
        </div>
      </div>

      {/* Charts Grid */}
      <div className="charts-grid">
        {/* Movement Trends Chart */}
        <div className="chart-container">
          <div className="chart-header">
            <h3>📊 Movement Trends</h3>
            <p>Student entries and exits over time</p>
          </div>
          <div className="chart-content">
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={getChartData()}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey={selectedPeriod === 'hourly' ? 'hour' : selectedPeriod === 'daily' ? 'date' : selectedPeriod === 'weekly' ? 'week' : 'month'} />
                <YAxis />
                <Tooltip />
                <Bar dataKey="entries" fill="#28a745" name="Entries" />
                <Bar dataKey="exits" fill="#dc3545" name="Exits" />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Hostel Distribution */}
        <div className="chart-container">
          <div className="chart-header">
            <h3>🏠 Hostel Distribution</h3>
            <p>Student distribution across hostels</p>
          </div>
          <div className="chart-content">
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie
                  data={analyticsData.hostelDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {analyticsData.hostelDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Peak Hours */}
        <div className="chart-container">
          <div className="chart-header">
            <h3>⏰ Peak Hours</h3>
            <p>Most active hours for student movement</p>
          </div>
          <div className="chart-content">
            <ResponsiveContainer width="100%" height={300}>
              <LineChart data={analyticsData.peakHours}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="hour" />
                <YAxis />
                <Tooltip />
                <Line type="monotone" dataKey="count" stroke="#007bff" strokeWidth={3} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Weekly Comparison */}
        <div className="chart-container">
          <div className="chart-header">
            <h3>📅 Weekly Comparison</h3>
            <p>Week-over-week movement comparison</p>
          </div>
          <div className="chart-content">
            <ResponsiveContainer width="100%" height={300}>
              <LineChart data={analyticsData.weeklyData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="week" />
                <YAxis />
                <Tooltip />
                <Line type="monotone" dataKey="entries" stroke="#28a745" strokeWidth={2} name="Entries" />
                <Line type="monotone" dataKey="exits" stroke="#dc3545" strokeWidth={2} name="Exits" />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Insights Section */}
      <div className="insights-section">
        <h2>💡 Key Insights</h2>
        <div className="insights-grid">
          <div className="insight-card">
            <div className="insight-icon">📈</div>
            <div className="insight-content">
              <h4>Peak Activity</h4>
              <p>Most student movement occurs between 6 PM - 10 PM, with peak at 10 PM</p>
            </div>
          </div>
          <div className="insight-card">
            <div className="insight-icon">🏠</div>
            <div className="insight-content">
              <h4>Hostel Distribution</h4>
              <p>Boys Hostel A has the highest student activity with 45% of total movements</p>
            </div>
          </div>
          <div className="insight-card">
            <div className="insight-icon">⏰</div>
            <div className="insight-content">
              <h4>Average Time Outside</h4>
              <p>Students spend an average of 95 minutes outside the hostel per trip</p>
            </div>
          </div>
          <div className="insight-card">
            <div className="insight-icon">📊</div>
            <div className="insight-content">
              <h4>Weekly Pattern</h4>
              <p>Friday shows the highest activity with 110 total movements</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AnalyticsDashboard;
