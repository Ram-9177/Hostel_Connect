/**
 * Dashboard API Service
 * Handles all dashboard-related API calls to the backend
 */

// Get API base URL from environment or use default
const API_BASE_URL = (import.meta as any).env?.VITE_API_URL || 'http://localhost:3000/api/v1';

/**
 * Get authentication token from localStorage
 */
const getAuthToken = (): string | null => {
  return localStorage.getItem('token');
};

/**
 * Common headers for API requests
 */
const getHeaders = (): HeadersInit => {
  const token = getAuthToken();
  return {
    'Content-Type': 'application/json',
    ...(token ? { Authorization: `Bearer ${token}` } : {}),
  };
};

/**
 * Handle API response and errors
 */
const handleResponse = async <T>(response: Response): Promise<T> => {
  if (!response.ok) {
    const error = await response.json().catch(() => ({ message: 'Request failed' }));
    throw new Error(error.message || `HTTP ${response.status}: ${response.statusText}`);
  }
  return response.json();
};

/**
 * Dashboard Service Interface
 */
export const dashboardService = {
  /**
   * Get live hostel dashboard data
   * @param hostelId - Optional hostel ID to filter by specific hostel
   */
  async getHostelLive(hostelId?: string): Promise<any> {
    const url = hostelId 
      ? `${API_BASE_URL}/dash/hostel-live/${hostelId}`
      : `${API_BASE_URL}/dash/hostel-live`;
    
    const response = await fetch(url, {
      headers: getHeaders(),
    });
    
    return handleResponse(response);
  },

  /**
   * Get analytics dashboard data
   * @param hostelId - Hostel ID
   * @param period - Time period (daily, weekly, monthly)
   */
  async getAnalytics(hostelId: string, period: string = 'daily'): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/analytics/dashboard?hostelId=${hostelId}&period=${period}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get gate pass funnel analytics
   * @param hostelId - Optional hostel ID
   * @param days - Number of days to analyze (default: 7)
   */
  async getGateFunnel(hostelId?: string, days: number = 7): Promise<any> {
    const params = new URLSearchParams({ days: days.toString() });
    if (hostelId) params.append('hostelId', hostelId);
    
    const response = await fetch(
      `${API_BASE_URL}/dash/gate-funnel?${params}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get attendance session summary
   * @param sessionId - Attendance session ID
   */
  async getAttendanceSessionSummary(sessionId: string): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/dash/attendance/session/${sessionId}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get gate pass statistics
   * @param hostelId - Hostel ID
   * @param from - Start date (optional)
   * @param to - End date (optional)
   */
  async getGatePassStatistics(hostelId: string, from?: Date, to?: Date): Promise<any> {
    const params = new URLSearchParams({ hostelId });
    if (from) params.append('from', from.toISOString());
    if (to) params.append('to', to.toISOString());
    
    const response = await fetch(
      `${API_BASE_URL}/gatepass/statistics/${hostelId}?${params}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get meal statistics
   * @param hostelId - Hostel ID
   * @param date - Date for statistics
   */
  async getMealStatistics(hostelId: string, date?: Date): Promise<any> {
    const params = new URLSearchParams({ hostelId });
    if (date) params.append('date', date.toISOString());
    
    const response = await fetch(
      `${API_BASE_URL}/meals/statistics?${params}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get attendance statistics
   * @param hostelId - Hostel ID
   * @param from - Start date (optional)
   * @param to - End date (optional)
   */
  async getAttendanceStatistics(hostelId: string, from?: Date, to?: Date): Promise<any> {
    const params = new URLSearchParams({ hostelId });
    if (from) params.append('from', from.toISOString());
    if (to) params.append('to', to.toISOString());
    
    const response = await fetch(
      `${API_BASE_URL}/attendance/statistics?${params}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get live dashboard tiles
   * @param hostelId - Hostel ID
   */
  async getLiveDashboardTiles(hostelId: string): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/reports/dashboard/live/${hostelId}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get daily analytics
   * @param hostelId - Hostel ID
   * @param date - Date for analytics
   */
  async getDailyAnalytics(hostelId: string, date: Date): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/reports/analytics/daily/${hostelId}?date=${date.toISOString()}`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Refresh live dashboard tiles
   * @param hostelId - Hostel ID
   * @param tileIds - Optional array of specific tile IDs to refresh
   */
  async refreshLiveDashboardTiles(hostelId: string, tileIds?: string[]): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/reports/dashboard/live/${hostelId}/refresh`,
      {
        method: 'POST',
        headers: getHeaders(),
        body: JSON.stringify({ tileIds }),
      }
    );
    
    return handleResponse(response);
  },

  /**
   * Get student dashboard data
   * @param studentId - Student ID
   */
  async getStudentDashboard(studentId: string): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/students/${studentId}/dashboard`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },

  /**
   * Get warden dashboard data
   * @param wardenId - Warden ID
   */
  async getWardenDashboard(wardenId: string): Promise<any> {
    const response = await fetch(
      `${API_BASE_URL}/wardens/${wardenId}/dashboard`,
      { headers: getHeaders() }
    );
    
    return handleResponse(response);
  },
};

/**
 * Cache management for dashboard data
 * Prevents excessive API calls by caching data for 5 minutes
 */
const CACHE_DURATION = 5 * 60 * 1000; // 5 minutes

interface CacheEntry<T> {
  data: T;
  timestamp: number;
}

const cache = new Map<string, CacheEntry<any>>();

/**
 * Cached dashboard service
 * Automatically caches responses to reduce API calls
 */
export const cachedDashboardService = {
  /**
   * Get cached data or fetch fresh data
   */
  async getCached<T>(
    key: string,
    fetchFn: () => Promise<T>,
    forceRefresh: boolean = false
  ): Promise<T> {
    const now = Date.now();
    const cached = cache.get(key);

    if (!forceRefresh && cached && now - cached.timestamp < CACHE_DURATION) {
      return cached.data as T;
    }

    const data = await fetchFn();
    cache.set(key, { data, timestamp: now });
    return data;
  },

  /**
   * Clear all cached data
   */
  clearCache(): void {
    cache.clear();
  },

  /**
   * Clear specific cache entry
   */
  clearCacheEntry(key: string): void {
    cache.delete(key);
  },

  /**
   * Get hostel live data (cached)
   */
  async getHostelLive(hostelId?: string, forceRefresh: boolean = false): Promise<any> {
    const key = `hostel-live-${hostelId || 'all'}`;
    return this.getCached(key, () => dashboardService.getHostelLive(hostelId), forceRefresh);
  },

  /**
   * Get analytics data (cached)
   */
  async getAnalytics(
    hostelId: string,
    period: string = 'daily',
    forceRefresh: boolean = false
  ): Promise<any> {
    const key = `analytics-${hostelId}-${period}`;
    return this.getCached(key, () => dashboardService.getAnalytics(hostelId, period), forceRefresh);
  },

  /**
   * Get gate funnel data (cached)
   */
  async getGateFunnel(
    hostelId?: string,
    days: number = 7,
    forceRefresh: boolean = false
  ): Promise<any> {
    const key = `gate-funnel-${hostelId || 'all'}-${days}`;
    return this.getCached(key, () => dashboardService.getGateFunnel(hostelId, days), forceRefresh);
  },
};

export default dashboardService;
