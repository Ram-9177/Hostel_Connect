// API Service for HostelConnect
// Prefer Vite env var, fallback to local mock API
const API_BASE_URL = (import.meta as any).env?.VITE_API_URL || 'http://localhost:3007/api/v1';

export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  hostelId?: string;
  roomId?: string;
  studentId?: string;
  phone?: string;
  isActive: boolean;
  lastLogin?: string;
  createdAt: string;
}

export interface AuthResponse {
  user: User;
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  message: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  password: string;
  firstName: string;
  lastName: string;
  role: 'STUDENT' | 'WARDEN' | 'CHEF' | 'ADMIN';
  studentId?: string;
  phone?: string;
}

class ApiService {
  private baseURL: string;
  private accessToken: string | null = null;

  constructor(baseURL: string = API_BASE_URL) {
    this.baseURL = baseURL;
    this.accessToken = localStorage.getItem('accessToken');
  }

  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<T> {
    const url = `${this.baseURL}${endpoint}`;
    
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
      ...(options.headers as Record<string, string>),
    };

    if (this.accessToken) {
      headers.Authorization = `Bearer ${this.accessToken}`;
    }

    const response = await fetch(url, {
      ...options,
      headers: headers as HeadersInit,
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
    }

    return response.json();
  }

  // Authentication methods
  async login(credentials: LoginRequest): Promise<AuthResponse> {
    const response = await this.request<AuthResponse>('/auth/login', {
      method: 'POST',
      body: JSON.stringify(credentials),
    });

    this.accessToken = response.accessToken;
    localStorage.setItem('accessToken', response.accessToken);
    localStorage.setItem('refreshToken', response.refreshToken);
    localStorage.setItem('user', JSON.stringify(response.user));

    return response;
  }

  async register(userData: RegisterRequest): Promise<AuthResponse> {
    const response = await this.request<AuthResponse>('/auth/register', {
      method: 'POST',
      body: JSON.stringify(userData),
    });

    this.accessToken = response.accessToken;
    localStorage.setItem('accessToken', response.accessToken);
    localStorage.setItem('refreshToken', response.refreshToken);
    localStorage.setItem('user', JSON.stringify(response.user));

    return response;
  }

  async logout(): Promise<void> {
    this.accessToken = null;
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    localStorage.removeItem('user');
  }

  async refreshToken(): Promise<{ accessToken: string }> {
    const refreshToken = localStorage.getItem('refreshToken');
    if (!refreshToken) {
      throw new Error('No refresh token available');
    }

    const response = await this.request<{ accessToken: string }>('/auth/refresh', {
      method: 'POST',
      body: JSON.stringify({ refreshToken }),
    });

    this.accessToken = response.accessToken;
    localStorage.setItem('accessToken', response.accessToken);

    return response;
  }

  async getProfile(): Promise<{ user: User }> {
    return this.request<{ user: User }>('/auth/profile');
  }

  async forgotPassword(email: string): Promise<{ message: string }> {
    return this.request<{ message: string }>('/auth/forgot-password', {
      method: 'POST',
      body: JSON.stringify({ email }),
    });
  }

  async resetPassword(token: string, newPassword: string): Promise<{ message: string }> {
    return this.request<{ message: string }>('/auth/reset-password', {
      method: 'POST',
      body: JSON.stringify({ token, newPassword }),
    });
  }

  // Gate Pass methods
  async createGatePass(gatePassData: any): Promise<any> {
    return this.request('/gate-passes', {
      method: 'POST',
      body: JSON.stringify(gatePassData),
    });
  }

  async getGatePasses(): Promise<any[]> {
    return this.request('/gate-passes');
  }

  async approveGatePass(id: string, approved: boolean): Promise<any> {
    return this.request(`/gate-passes/${id}/approve`, {
      method: 'POST',
      body: JSON.stringify({ approved }),
    });
  }

  // Attendance methods
  async getAttendanceSessions(): Promise<any[]> {
    return this.request('/attendance/sessions');
  }

  async markAttendance(sessionId: string): Promise<any> {
    return this.request(`/attendance/sessions/${sessionId}/mark`, {
      method: 'POST',
    });
  }

  // Meal methods
  async getMealMenu(): Promise<any> {
    return this.request('/meals/menu');
  }

  async submitMealIntent(intent: any): Promise<any> {
    return this.request('/meals/intent', {
      method: 'POST',
      body: JSON.stringify(intent),
    });
  }

  // Notice methods
  async getNotices(): Promise<any[]> {
    return this.request('/notices');
  }

  async createNotice(notice: any): Promise<any> {
    return this.request('/notices', {
      method: 'POST',
      body: JSON.stringify(notice),
    });
  }

  // Check if user is authenticated
  isAuthenticated(): boolean {
    return !!this.accessToken;
  }

  // Get current user from localStorage
  getCurrentUser(): User | null {
    const userStr = localStorage.getItem('user');
    return userStr ? JSON.parse(userStr) : null;
  }
}

export const apiService = new ApiService();
export default apiService;
