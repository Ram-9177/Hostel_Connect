/// Notice API Service
/// Handles notice-related API calls
class NoticeApiService {
  /// Mark notice as read
  Future<void> markNoticeAsRead(String noticeId, String userId, DateTime readAt) async {
    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 300));
    // In real implementation, make HTTP request to backend
  }
}