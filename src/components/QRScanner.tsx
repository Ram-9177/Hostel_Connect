import React, { useEffect, useRef, useState } from 'react';
import QrScanner from 'qr-scanner';

interface QRScannerProps {
  onScan: (result: string) => void;
  onError?: (error: string) => void;
  isActive: boolean;
}

const QRScanner: React.FC<QRScannerProps> = ({ onScan, onError, isActive }) => {
  const videoRef = useRef<HTMLVideoElement>(null);
  const scannerRef = useRef<QrScanner | null>(null);
  const [isScanning, setIsScanning] = useState(false);
  const [error, setError] = useState<string>('');

  useEffect(() => {
    if (!videoRef.current) return;

    const startScanner = async () => {
      try {
        scannerRef.current = new QrScanner(
          videoRef.current!,
          (result) => {
            console.log('QR Code detected:', result.data);
            onScan(result.data);
            setIsScanning(false);
          },
          {
            onDecodeError: (error) => {
              // Ignore decode errors - they're common when scanning
              console.log('Decode error:', error);
            },
            highlightScanRegion: true,
            highlightCodeOutline: true,
            preferredCamera: 'environment', // Use back camera
          }
        );

        await scannerRef.current.start();
        setIsScanning(true);
        setError('');
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : 'Failed to start camera';
        setError(errorMessage);
        onError?.(errorMessage);
        console.error('QR Scanner error:', err);
      }
    };

    const stopScanner = () => {
      if (scannerRef.current) {
        scannerRef.current.stop();
        scannerRef.current.destroy();
        scannerRef.current = null;
        setIsScanning(false);
      }
    };

    if (isActive) {
      startScanner();
    } else {
      stopScanner();
    }

    return () => {
      stopScanner();
    };
  }, [isActive, onScan, onError]);

  if (!isActive) {
    return (
      <div className="qr-scanner-placeholder">
        <div className="scanner-icon">📷</div>
        <p>Camera not active</p>
      </div>
    );
  }

  return (
    <div className="qr-scanner-container">
      <div className="scanner-header">
        <h3>QR Code Scanner</h3>
        <div className={`scanner-status ${isScanning ? 'active' : 'inactive'}`}>
          {isScanning ? '🟢 Scanning' : '🔴 Stopped'}
        </div>
      </div>
      
      <div className="scanner-video-container">
        <video
          ref={videoRef}
          className="scanner-video"
          playsInline
          muted
        />
        <div className="scanner-overlay">
          <div className="scan-frame">
            <div className="corner top-left"></div>
            <div className="corner top-right"></div>
            <div className="corner bottom-left"></div>
            <div className="corner bottom-right"></div>
          </div>
          <div className="scan-line"></div>
        </div>
      </div>

      {error && (
        <div className="scanner-error">
          <p>❌ {error}</p>
          <button onClick={() => window.location.reload()}>
            Retry Camera Access
          </button>
        </div>
      )}

      <div className="scanner-instructions">
        <p>📱 Position the QR code within the frame</p>
        <p>🔍 Ensure good lighting for better scanning</p>
      </div>
    </div>
  );
};

export default QRScanner;
