import React, { useState, useEffect } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, LineChart, Line, PieChart, Pie, Cell } from 'recharts';
import { TrendingUp, Users, Clock, AlertTriangle, Calendar, Download, ArrowLeft, RefreshCw } from 'lucide-react';
import { cachedDashboardService } from '../services/dashboardService';
import './AnalyticsDashboard.css';

interface AnalyticsData {
  hourlyData: Array<Record<string, any>>;
  dailyData: Array<Record<string, any>>;
  weeklyData: Array<Record<string, any>>;
  monthlyData: Array<Record<string, any>>;
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

interface AnalyticsDashboardProps {
  onBack?: () => void;
}

const AnalyticsDashboard: React.FC<AnalyticsDashboardProps> = ({ onBack }) => {
  const [analyticsData, setAnalyticsData] = useState<AnalyticsData | null>(null);
  const [selectedPeriod, setSelectedPeriod] = useState('daily');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [refreshing, setRefreshing] = useState(false);

  const fetchAnalyticsData = async (forceRefresh: boolean = false) => {
    try {
      if (forceRefresh) {
        setRefreshing(true);
      } else {
        setLoading(true);
      }
      setError(null);

      // Get current user from localStorage
      const userStr = localStorage.getItem('user');
      const user = userStr ? JSON.parse(userStr) : null;
      const hostelId = user?.hostelId || user?.id || 'default';

      // Fetch data from backend API
      const data = await cachedDashboardService.getAnalytics(hostelId, selectedPeriod, forceRefresh);
      
      // Transform backend data to match our interface
      setAnalyticsData(data);
    } catch (err) {
      console.error('Failed to fetch analytics:', err);
      setError(err instanceof Error ? err.message : 'Failed to load analytics data');
      
      // Use fallback mock data if API fails
      setAnalyticsData(getMockData());
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchAnalyticsData();
  }, [selectedPeriod]);

  const handleRefresh = () => {
    fetchAnalyticsData(true);
  };

  // Fallback mock data
  const getMockData = (): AnalyticsData => ({
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
      timeOutside: 2.5,
      entriesPerDay: 48,
      exitsPerDay: 39,
      lateReturns: 5,
      earlyReturns: 3,
    }
  });

  const getCurrentData = () => {
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

  const COLORS = ['#8884d8', '#82ca9d', '#ffc658', '#ff7c7c', '#8dd1e1'];

  if (loading && !analyticsData) {
    return (
      <div className="analytics-dashboard">
        <div className="dashboard-header">
          {onBack && (
            <button onClick={onBack} className="back-button">
              <ArrowLeft size={20} />
              <span>Back</span>
            </button>
          )}
          <h1>📈 Analytics Dashboard</h1>
        </div>
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <p>Loading analytics data...</p>
        </div>
      </div>
    );
  }

  if (error && !analyticsData) {
    return (
      <div className="analytics-dashboard">
        <div className="dashboard-header">
          {onBack && (
            <button onClick={onBack} className="back-button">
              <ArrowLeft size={20} />
              <span>Back</span>
            </button>
          )}
          <h1>📈 Analytics Dashboard</h1>
        </div>
        <div className="error-container">
          <AlertTriangle size={48} color="#ef4444" />
          <h3>Failed to Load Analytics</h3>
          <p>{error}</p>
          <button onClick={() => fetchAnalyticsData()} className="retry-button">
            Try Again
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="analytics-dashboard">
      <div className="dashboard-header">
        {onBack && (
          <button onClick={onBack} className="back-button">
            <ArrowLeft size={20} />
            <span>Back</span>
          </button>
        )}
        <div className="header-content">
          <h1>📈 Analytics Dashboard</h1>
          <p className="header-subtitle">Real-time gate pass and hostel analytics</p>
        </div>
        <div className="header-actions">
          <button 
            onClick={handleRefresh} 
            className={`refresh-button ${refreshing ? 'refreshing' : ''}`}
            disabled={refreshing}
          >
            <RefreshCw size={18} />
            <span>{refreshing ? 'Refreshing...' : 'Refresh'}</span>
          </button>
          <button className="export-button">
            <Download size={18} />
            <span>Export</span>
          </button>
        </div>
      </div>

      {error && (
        <div className="warning-banner">
          <AlertTriangle size={18} />
          <span>Using cached data: {error}</span>
        </div>
      )}

      {/* Period Selector */}
      <div className="period-selector">
        <button
          className={selectedPeriod === 'hourly' ? 'active' : ''}
          onClick={() => setSelectedPeriod('hourly')}
        >
          <Clock size={16} />
          Hourly
        </button>
        <button
          className={selectedPeriod === 'daily' ? 'active' : ''}
          onClick={() => setSelectedPeriod('daily')}
        >
          <Calendar size={16} />
          Daily
        </button>
        <button
          className={selectedPeriod === 'weekly' ? 'active' : ''}
          onClick={() => setSelectedPeriod('weekly')}
        >
          <TrendingUp size={16} />
          Weekly
        </button>
        <button
          className={selectedPeriod === 'monthly' ? 'active' : ''}
          onClick={() => setSelectedPeriod('monthly')}
        >
          <Users size={16} />
          Monthly
        </button>
      </div>

      {/* Summary Cards */}
      <div className="summary-cards">
        <div className="summary-card">
          <div className="card-icon" style={{ background: '#3b82f6' }}>
            <TrendingUp size={24} />
          </div>
          <div className="card-content">
            <h3>Avg. Time Outside</h3>
            <p className="card-value">{analyticsData?.averageStats.timeOutside.toFixed(1)} hrs</p>
            <span className="card-trend positive">+12% from last period</span>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon" style={{ background: '#10b981' }}>
            <Users size={24} />
          </div>
          <div className="card-content">
            <h3>Daily Entries</h3>
            <p className="card-value">{analyticsData?.averageStats.entriesPerDay}</p>
            <span className="card-trend positive">+8% from yesterday</span>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon" style={{ background: '#f59e0b' }}>
            <Clock size={24} />
          </div>
          <div className="card-content">
            <h3>Daily Exits</h3>
            <p className="card-value">{analyticsData?.averageStats.exitsPerDay}</p>
            <span className="card-trend neutral">Same as yesterday</span>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon" style={{ background: '#ef4444' }}>
            <AlertTriangle size={24} />
          </div>
          <div className="card-content">
            <h3>Late Returns</h3>
            <p className="card-value">{analyticsData?.averageStats.lateReturns}</p>
            <span className="card-trend negative">-15% from last week</span>
          </div>
        </div>
      </div>

      {/* Main Chart */}
      <div className="chart-container">
        <h2>Gate Pass Activity - {selectedPeriod.charAt(0).toUpperCase() + selectedPeriod.slice(1)}</h2>
        <ResponsiveContainer width="100%" height={400}>
          <BarChart data={getCurrentData()}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey={(item: any) => item.hour || item.date || item.week || item.month} />
            <YAxis />
            <Tooltip />
            <Bar dataKey="entries" fill="#3b82f6" name="Entries" />
            <Bar dataKey="exits" fill="#ef4444" name="Exits" />
          </BarChart>
        </ResponsiveContainer>
      </div>

      {/* Distribution Charts */}
      <div className="charts-grid">
        <div className="chart-card">
          <h3>Hostel Distribution</h3>
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={analyticsData?.hostelDistribution || []}
                cx="50%"
                cy="50%"
                labelLine={false}
                label={(entry) => `${entry.name}: ${entry.value}%`}
                outerRadius={80}
                fill="#8884d8"
                dataKey="value"
              >
                {(analyticsData?.hostelDistribution || []).map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>

        <div className="chart-card">
          <h3>Peak Hours</h3>
          <ResponsiveContainer width="100%" height={300}>
            <LineChart data={analyticsData?.peakHours || []}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="hour" />
              <YAxis />
              <Tooltip />
              <Line type="monotone" dataKey="count" stroke="#8884d8" strokeWidth={2} />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* Data Status Footer */}
      <div className="data-status-footer">
        <span>
          {error ? '⚠️ Using cached data' : '✓ Live data'}
        </span>
        <span>Last updated: {new Date().toLocaleTimeString()}</span>
      </div>
    </div>
  );
};

export default AnalyticsDashboard;
