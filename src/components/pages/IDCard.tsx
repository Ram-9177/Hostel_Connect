import React, { useRef, useState } from "react";
import { motion } from "framer-motion";
import { Card } from "../ui/card";
import { Button } from "../ui/button";
import { toast } from "sonner";
import {
  ArrowLeft,
  Download,
  User,
  QrCode,
  Mail,
  Phone,
  Home,
  Calendar,
  Hash,
} from "lucide-react";
import QRCode from "qrcode";
import html2canvas from "html2canvas";
import jsPDF from "jspdf";

interface IDCardProps {
  onBack: () => void;
}

export const IDCard: React.FC<IDCardProps> = ({ onBack }) => {
  const cardRef = useRef<HTMLDivElement>(null);
  const [qrCodeData, setQrCodeData] = useState("");
  const [isGenerating, setIsGenerating] = useState(false);

  // Get user data from localStorage
  const userStr = localStorage.getItem("user");
  const user = userStr ? JSON.parse(userStr) : null;

  // Generate QR code when component mounts
  React.useEffect(() => {
    if (user) {
      const studentData = JSON.stringify({
        id: user.id,
        studentId: user.studentId,
        name: `${user.firstName} ${user.lastName}`,
        email: user.email,
      });

      QRCode.toDataURL(studentData, {
        width: 200,
        margin: 1,
        color: {
          dark: "#000000",
          light: "#ffffff",
        },
      }).then((url: string) => {
        setQrCodeData(url);
      });
    }
  }, [user]);

  const downloadAsPNG = async () => {
    if (!cardRef.current) return;

    setIsGenerating(true);
    try {
      const canvas = await html2canvas(cardRef.current, {
        scale: 3,
        backgroundColor: "#ffffff",
        logging: false,
      });

      const link = document.createElement("a");
      link.download = `student-id-${user?.studentId || "card"}.png`;
      link.href = canvas.toDataURL("image/png");
      link.click();

      toast.success("ID Card downloaded as PNG!");
    } catch (error) {
      console.error("Error generating PNG:", error);
      toast.error("Failed to generate PNG");
    } finally {
      setIsGenerating(false);
    }
  };

  const downloadAsPDF = async () => {
    if (!cardRef.current) return;

    setIsGenerating(true);
    try {
      const canvas = await html2canvas(cardRef.current, {
        scale: 3,
        backgroundColor: "#ffffff",
        logging: false,
      });

      const imgData = canvas.toDataURL("image/png");
      const pdf = new jsPDF({
        orientation: "portrait",
        unit: "mm",
        format: "a4",
      });

      // Calculate dimensions to center the card
      const imgWidth = 85.6; // 3.37 inches = 85.6mm (standard CR80 card width)
      const imgHeight = 53.98; // 2.125 inches = 53.98mm (standard CR80 card height)
      const pageWidth = pdf.internal.pageSize.getWidth();
      const pageHeight = pdf.internal.pageSize.getHeight();
      const x = (pageWidth - imgWidth) / 2;
      const y = (pageHeight - imgHeight) / 2;

      pdf.addImage(imgData, "PNG", x, y, imgWidth, imgHeight);
      pdf.save(`student-id-${user?.studentId || "card"}.pdf`);

      toast.success("ID Card downloaded as PDF!");
    } catch (error) {
      console.error("Error generating PDF:", error);
      toast.error("Failed to generate PDF");
    } finally {
      setIsGenerating(false);
    }
  };

  if (!user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-4 flex items-center justify-center">
        <Card className="p-8 text-center">
          <p className="text-gray-600">Please log in to view your ID card</p>
          <Button onClick={onBack} className="mt-4">
            Go Back
          </Button>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-4 md:p-8">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6"
        >
          <Button variant="ghost" onClick={onBack} className="mb-4 -ml-2">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back
          </Button>
          <h1 className="text-3xl font-bold text-gray-900">Student ID Card</h1>
          <p className="text-gray-600 mt-2">
            Download your digital student ID card
          </p>
        </motion.div>

        {/* ID Card Preview */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <div className="flex justify-center">
            <div
              ref={cardRef}
              className="bg-white rounded-2xl shadow-2xl overflow-hidden"
              style={{
                width: "337px",
                height: "213px",
              }}
            >
              {/* Card Front */}
              <div className="h-full relative bg-gradient-to-br from-blue-600 via-blue-700 to-indigo-800 p-4">
                {/* Header */}
                <div className="text-center mb-3">
                  <h2 className="text-white font-bold text-lg">
                    HostelConnect
                  </h2>
                  <p className="text-blue-200 text-xs">Student ID Card</p>
                </div>

                {/* Content Grid */}
                <div className="grid grid-cols-3 gap-3 h-[calc(100%-60px)]">
                  {/* Left: Photo */}
                  <div className="col-span-1 flex items-center justify-center">
                    <div className="bg-white rounded-lg p-1.5 shadow-lg">
                      <div className="w-16 h-16 bg-gradient-to-br from-blue-100 to-blue-200 rounded flex items-center justify-center">
                        <User className="w-10 h-10 text-blue-600" />
                      </div>
                    </div>
                  </div>

                  {/* Middle: Details */}
                  <div className="col-span-1 flex flex-col justify-center text-white space-y-1">
                    <div>
                      <p className="text-[10px] text-blue-200 uppercase tracking-wide">
                        Name
                      </p>
                      <p className="text-xs font-semibold leading-tight">
                        {user.firstName}
                      </p>
                      <p className="text-xs font-semibold leading-tight">
                        {user.lastName}
                      </p>
                    </div>
                    <div>
                      <p className="text-[10px] text-blue-200 uppercase tracking-wide">
                        ID
                      </p>
                      <p className="text-xs font-bold">{user.studentId}</p>
                    </div>
                    <div>
                      <p className="text-[10px] text-blue-200 uppercase tracking-wide">
                        Role
                      </p>
                      <p className="text-xs font-medium capitalize">
                        {user.role.toLowerCase()}
                      </p>
                    </div>
                  </div>

                  {/* Right: QR Code */}
                  <div className="col-span-1 flex items-center justify-center">
                    {qrCodeData && (
                      <div className="bg-white p-1 rounded shadow-lg">
                        <img
                          src={qrCodeData}
                          alt="Student QR Code"
                          className="w-16 h-16"
                        />
                      </div>
                    )}
                  </div>
                </div>

                {/* Footer */}
                <div className="absolute bottom-2 left-4 right-4">
                  <div className="text-center">
                    <p className="text-[9px] text-blue-200">
                      Valid ID • Issued {new Date().getFullYear()}
                    </p>
                  </div>
                </div>

                {/* Decorative Elements */}
                <div className="absolute top-0 right-0 w-32 h-32 bg-blue-500 rounded-full opacity-10 -mr-16 -mt-16"></div>
                <div className="absolute bottom-0 left-0 w-24 h-24 bg-indigo-500 rounded-full opacity-10 -ml-12 -mb-12"></div>
              </div>
            </div>
          </div>
        </motion.div>

        {/* Download Buttons */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="p-6 shadow-xl border-0">
            <h3 className="font-semibold text-gray-900 mb-4">
              Download Options
            </h3>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Button
                onClick={downloadAsPNG}
                disabled={isGenerating}
                className="bg-blue-600 hover:bg-blue-700 text-white h-14"
              >
                {isGenerating ? (
                  <div className="flex items-center gap-2">
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                    <span>Generating...</span>
                  </div>
                ) : (
                  <>
                    <Download className="h-5 w-5 mr-2" />
                    Download as PNG
                  </>
                )}
              </Button>
              <Button
                onClick={downloadAsPDF}
                disabled={isGenerating}
                variant="outline"
                className="h-14 border-2"
              >
                {isGenerating ? (
                  <div className="flex items-center gap-2">
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-blue-600"></div>
                    <span>Generating...</span>
                  </div>
                ) : (
                  <>
                    <Download className="h-5 w-5 mr-2" />
                    Download as PDF
                  </>
                )}
              </Button>
            </div>
          </Card>
        </motion.div>

        {/* Student Information Card */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <Card className="mt-6 p-6 shadow-xl border-0">
            <h3 className="font-semibold text-gray-900 mb-4">
              Student Information
            </h3>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <Hash className="h-5 w-5 text-blue-600" />
                <div>
                  <p className="text-xs text-gray-500">Student ID</p>
                  <p className="font-semibold text-gray-900">
                    {user.studentId}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <User className="h-5 w-5 text-green-600" />
                <div>
                  <p className="text-xs text-gray-500">Full Name</p>
                  <p className="font-semibold text-gray-900">
                    {user.firstName} {user.lastName}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <Mail className="h-5 w-5 text-purple-600" />
                <div>
                  <p className="text-xs text-gray-500">Email</p>
                  <p className="font-semibold text-gray-900 text-sm">
                    {user.email}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <Home className="h-5 w-5 text-amber-600" />
                <div>
                  <p className="text-xs text-gray-500">Role</p>
                  <p className="font-semibold text-gray-900 capitalize">
                    {user.role.toLowerCase()}
                  </p>
                </div>
              </div>
            </div>
          </Card>
        </motion.div>

        {/* Usage Instructions */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
        >
          <Card className="mt-6 p-6 bg-blue-50 border-blue-200">
            <h3 className="font-semibold text-blue-900 mb-3 flex items-center gap-2">
              <QrCode className="h-5 w-5" />
              How to Use Your ID Card
            </h3>
            <ul className="space-y-2 text-sm text-blue-800">
              <li className="flex items-start gap-2">
                <span className="text-blue-600 mt-1">•</span>
                <span>Present the QR code for quick attendance scanning</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-600 mt-1">•</span>
                <span>Show to security guards for hostel entry verification</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-600 mt-1">•</span>
                <span>Keep a digital copy on your phone for convenience</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-blue-600 mt-1">•</span>
                <span>
                  Print the PDF for a physical ID card (recommended size: CR80 -
                  3.37" × 2.125")
                </span>
              </li>
            </ul>
          </Card>
        </motion.div>
      </div>
    </div>
  );
};
