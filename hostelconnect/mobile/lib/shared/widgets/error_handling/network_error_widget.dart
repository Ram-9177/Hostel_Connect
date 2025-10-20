import 'package:flutter/material.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_config.dart';

class NetworkErrorWidget extends StatelessWidget {
  final String? error;
  final VoidCallback? onRetry;
  final String? title;

  const NetworkErrorWidget({
    super.key,
    this.error,
    this.onRetry,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              title ?? 'Network Error',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error ?? 'Unable to connect to the server',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry ?? () => _showNetworkDiagnostics(context),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _showNetworkDiagnostics(context),
              child: const Text('Network Diagnostics'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNetworkDiagnostics(BuildContext context) async {
    final diagnostics = await NetworkConfig.getNetworkDiagnostics();
    
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Network Diagnostics'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDiagnosticItem('Internet Connection', diagnostics['hasInternet'] ? 'Connected' : 'Disconnected'),
                _buildDiagnosticItem('Connection Type', diagnostics['connectivityType']),
                _buildDiagnosticItem('API Connectivity', diagnostics['apiConnectivity'] ? 'Connected' : 'Failed'),
                _buildDiagnosticItem('API URL', diagnostics['apiUrl']),
                _buildDiagnosticItem('Platform', diagnostics['deviceInfo']['platform']),
                _buildDiagnosticItem('Model', diagnostics['deviceInfo']['model']),
                _buildDiagnosticItem('Version', diagnostics['deviceInfo']['version']),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry?.call();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDiagnosticItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'Unknown',
              style: TextStyle(
                color: value == true ? Colors.green : 
                       value == false ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorHandler {
  static Widget handleError(dynamic error, {VoidCallback? onRetry}) {
    if (error is NetworkException) {
      return NetworkErrorWidget(
        error: error.message,
        onRetry: onRetry,
      );
    } else if (error is ApiException) {
      return NetworkErrorWidget(
        error: error.message,
        onRetry: onRetry,
        title: 'API Error',
      );
    } else {
      return NetworkErrorWidget(
        error: error.toString(),
        onRetry: onRetry,
        title: 'Unknown Error',
      );
    }
  }
}
