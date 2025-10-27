import React, { useState } from 'react';
import { toast } from 'react-hot-toast';

interface BulkStudentUploadProps {
  token: string;
  onUploadComplete?: () => void;
}

interface UploadResult {
  success: boolean;
  message: string;
  created: number;
  errors: Array<{ hallTicket: string; error: string }>;
}

const BulkStudentUpload: React.FC<BulkStudentUploadProps> = ({ token, onUploadComplete }) => {
  const [file, setFile] = useState<File | null>(null);
  const [uploading, setUploading] = useState(false);
  const [result, setResult] = useState<UploadResult | null>(null);

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      const selectedFile = e.target.files[0];
      
      // Validate file type
      if (!selectedFile.name.endsWith('.csv')) {
        toast.error('Please select a CSV file');
        return;
      }

      setFile(selectedFile);
      setResult(null);
    }
  };

  const handleUpload = async () => {
    if (!file) {
      toast.error('Please select a file');
      return;
    }

    setUploading(true);
    setResult(null);

    try {
      const formData = new FormData();
      formData.append('file', file);

      const response = await fetch('/api/v1/students/bulk-upload', {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      if (!response.ok) {
        throw new Error('Upload failed');
      }

      const data: UploadResult = await response.json();
      setResult(data);

      if (data.created > 0) {
        toast.success(`Successfully created ${data.created} student(s)`);
      }

      if (data.errors.length > 0) {
        toast.error(`${data.errors.length} error(s) occurred`);
      }

      // Clear file input
      setFile(null);

      // Call callback if provided
      if (onUploadComplete) {
        onUploadComplete();
      }
    } catch (error) {
      toast.error('Failed to upload file');
      console.error(error);
    } finally {
      setUploading(false);
    }
  };

  const downloadSampleCSV = () => {
    const csv = `Name,Hall Ticket,College code,Number,Hostel Name
John Doe,21CS001,CS,9876543210,Boys Hostel A
Jane Smith,21CS002,CS,9876543211,Girls Hostel B
Mike Johnson,21EC003,EC,9876543212,Boys Hostel A`;

    const blob = new Blob([csv], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'sample_students.csv';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
    
    toast.success('Sample CSV downloaded');
  };

  return (
    <div className="max-w-4xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      <h2 className="text-2xl font-bold mb-6 text-gray-800">Bulk Student Upload</h2>

      {/* Instructions */}
      <div className="mb-6 p-4 bg-blue-50 border border-blue-200 rounded-lg">
        <h3 className="font-semibold text-blue-900 mb-2">📋 Instructions:</h3>
        <ul className="list-disc list-inside text-sm text-blue-800 space-y-1">
          <li>Prepare a CSV file with columns: Name, Hall Ticket, College code, Number, Hostel Name</li>
          <li>Hostel names must match exactly with existing hostels in the system</li>
          <li>Default password will be the Hall Ticket number</li>
          <li>Email will be auto-generated as: hall_ticket@student.college.edu</li>
        </ul>
        <button
          onClick={downloadSampleCSV}
          className="mt-3 text-blue-600 hover:text-blue-800 underline text-sm font-medium"
        >
          Download Sample CSV
        </button>
      </div>

      {/* File Upload */}
      <div className="mb-6">
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Select CSV File
        </label>
        <input
          type="file"
          accept=".csv"
          onChange={handleFileChange}
          className="block w-full text-sm text-gray-500
            file:mr-4 file:py-2 file:px-4
            file:rounded-lg file:border-0
            file:text-sm file:font-semibold
            file:bg-blue-50 file:text-blue-700
            hover:file:bg-blue-100
            cursor-pointer"
        />
        {file && (
          <p className="mt-2 text-sm text-gray-600">
            Selected: {file.name} ({(file.size / 1024).toFixed(2)} KB)
          </p>
        )}
      </div>

      {/* Upload Button */}
      <button
        onClick={handleUpload}
        disabled={!file || uploading}
        className="w-full bg-green-600 text-white py-3 px-4 rounded-lg hover:bg-green-700 disabled:bg-gray-400 disabled:cursor-not-allowed transition-colors font-medium"
      >
        {uploading ? (
          <span className="flex items-center justify-center">
            <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Uploading...
          </span>
        ) : (
          'Upload Students'
        )}
      </button>

      {/* Results */}
      {result && (
        <div className="mt-6">
          <div className={`p-4 rounded-lg ${result.created > 0 ? 'bg-green-50 border border-green-200' : 'bg-gray-50 border border-gray-200'}`}>
            <h3 className="font-semibold text-gray-900 mb-2">Upload Results:</h3>
            <p className="text-sm text-gray-700">
              ✅ Successfully created: <strong>{result.created}</strong> student(s)
            </p>
            <p className="text-sm text-gray-700">
              ❌ Errors: <strong>{result.errors.length}</strong>
            </p>
          </div>

          {/* Error Details */}
          {result.errors.length > 0 && (
            <div className="mt-4">
              <h4 className="font-semibold text-red-900 mb-2">Error Details:</h4>
              <div className="max-h-64 overflow-y-auto bg-red-50 border border-red-200 rounded-lg p-4">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-red-200">
                      <th className="text-left py-2 px-2">Hall Ticket</th>
                      <th className="text-left py-2 px-2">Error</th>
                    </tr>
                  </thead>
                  <tbody>
                    {result.errors.map((error, index) => (
                      <tr key={index} className="border-b border-red-100">
                        <td className="py-2 px-2 font-mono">{error.hallTicket}</td>
                        <td className="py-2 px-2 text-red-700">{error.error}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      )}

      {/* CSV Format Reference */}
      <div className="mt-6 p-4 bg-gray-50 border border-gray-200 rounded-lg">
        <h3 className="font-semibold text-gray-900 mb-2">CSV Format:</h3>
        <pre className="text-xs bg-white p-3 rounded border border-gray-300 overflow-x-auto">
          <code>
Name,Hall Ticket,College code,Number,Hostel Name
John Doe,21CS001,CS,9876543210,Boys Hostel A
Jane Smith,21CS002,CS,9876543211,Girls Hostel B
          </code>
        </pre>
      </div>
    </div>
  );
};

export default BulkStudentUpload;
