import 'package:flutter/material.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/features/ads/presentation/widgets/interstitial_ad.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class GatePassPage extends StatefulWidget {
  const GatePassPage({super.key});

  @override
  State<GatePassPage> createState() => _GatePassPageState();
}

class _GatePassPageState extends State<GatePassPage> {
  bool _adWatched = false;
  bool _showAd = false;

  void _requestGatePass() {
    if (!_adWatched) {
      setState(() {
        _showAd = true;
      });
    } else {
      _createGatePass();
    }
  }

  void _onAdComplete() {
    setState(() {
      _adWatched = true;
      _showAd = false;
    });
    _createGatePass();
  }

  void _createGatePass() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gate pass request submitted!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        appBar: AppBar(
          title: Text(HTeluguTheme.getTeluguLabel('outpass', englishFallback: 'Gate Pass')),
          backgroundColor: HTeluguTheme.primary,
          foregroundColor: HTeluguTheme.onPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              padding: EdgeInsets.all(HTokens.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(HTokens.lg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [HTokens.primary, HTokens.primary.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(HTokens.cardRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request Gate Pass',
                          style: TextStyle(
                            fontSize: r.isXS ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: HTokens.sm),
                        Text(
                          'Fill the form below to request a gate pass',
                          style: TextStyle(
                            fontSize: r.isXS ? 14 : 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: HTokens.lg),
                  
                  // Form
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(HTokens.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gate Pass Details',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: HTokens.lg),
                          
                          // Type selection
                          Text('Type', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: HTokens.sm),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Outing'),
                                  value: 'OUTING',
                                  groupValue: 'OUTING',
                                  onChanged: (value) {},
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Emergency'),
                                  value: 'EMERGENCY',
                                  groupValue: 'OUTING',
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: HTokens.lg),
                          
                          // Date and time
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Start Time', style: Theme.of(context).textTheme.titleMedium),
                                    SizedBox(height: HTokens.sm),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Select start time',
                                        suffixIcon: Icon(Icons.access_time),
                                      ),
                                      readOnly: true,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: HTokens.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('End Time', style: Theme.of(context).textTheme.titleMedium),
                                    SizedBox(height: HTokens.sm),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Select end time',
                                        suffixIcon: Icon(Icons.access_time),
                                      ),
                                      readOnly: true,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: HTokens.lg),
                          
                          // Reason
                          Text('Reason', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(height: HTokens.sm),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter reason for gate pass',
                            ),
                            maxLines: 3,
                          ),
                          
                          SizedBox(height: HTokens.xl),
                          
                          // Submit button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _requestGatePass,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HTokens.primary,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: HTokens.lg),
                              ),
                              child: Text(
                                _adWatched ? 'Submit Request' : 'Watch Ad & Submit',
                                style: TextStyle(fontSize: r.isXS ? 16 : 18),
                              ),
                            ),
                          ),
                          
                          if (_adWatched)
                            Padding(
                              padding: EdgeInsets.only(top: HTokens.md),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: HTokens.success),
                                  SizedBox(width: HTokens.sm),
                                  Text(
                                    'Ad watched! You can submit your request.',
                                    style: TextStyle(color: HTokens.success),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Interstitial Ad Overlay
            if (_showAd)
              InterstitialAdView(
                duration: 20,
                onComplete: _onAdComplete,
              ),
          ],
        ),
      );
    });
  }
}
