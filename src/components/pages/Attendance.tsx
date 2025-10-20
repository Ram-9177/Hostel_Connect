import { useState } from "react";
import { ArrowLeft, Camera, CheckCircle2, Upload, QrCode, PieChart } from "lucide-react";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "../ui/dialog";
import { Label } from "../ui/label";
import { Textarea } from "../ui/textarea";
import { UpdatedTime } from "../UpdatedTime";
import { toast } from "sonner@2.0.3";
import { motion } from "motion/react";

interface AttendanceProps {
  onBack: () => void;
}

export function Attendance({ onBack }: AttendanceProps) {
  const [scanning, setScanning] = useState(false);
  const [scanSuccess, setScanSuccess] = useState(false);
  const [manualDialog, setManualDialog] = useState(false);

  const handleScan = () => {
    setScanning(true);
    setTimeout(() => {
      setScanning(false);
      setScanSuccess(true);
      toast.success("Attendance marked successfully!");
      setTimeout(() => setScanSuccess(false), 2000);
    }, 2000);
  };

  const handleManualSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    toast.success("Manual attendance request submitted");
    setManualDialog(false);
  };

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Enhanced Header */}
      <div className="bg-gradient-to-r from-green-600 via-green-600 to-green-700 text-white p-5 shadow-lg relative overflow-hidden">
        <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-16 translate-x-16" />
        <div className="relative flex items-center gap-3">
          <motion.button 
            onClick={onBack} 
            className="p-2 bg-white/20 rounded-xl hover:bg-white/30 transition-colors"
            whileTap={{ scale: 0.9 }}
          >
            <ArrowLeft className="h-5 w-5" />
          </motion.button>
          <div>
            <h1 className="text-xl mb-1">Attendance</h1>
            <p className="text-xs opacity-90">Mark your daily presence</p>
          </div>
        </div>
      </div>

      <div className="p-4">
        <Tabs defaultValue="scan" className="w-full">
          <TabsList className="grid w-full grid-cols-2 mb-5 h-12">
            <TabsTrigger value="scan" className="text-base">Scan QR</TabsTrigger>
            <TabsTrigger value="summary" className="text-base">My Stats</TabsTrigger>
          </TabsList>

          <TabsContent value="scan" className="space-y-4">
            {/* Enhanced Kiosk Scan Card */}
            <Card className="p-6 space-y-5 border-0 shadow-lg">
              <div className="text-center space-y-3">
                <div className="w-16 h-16 bg-green-100 dark:bg-green-950 rounded-2xl flex items-center justify-center mx-auto">
                  <QrCode className="h-9 w-9 text-green-600" />
                </div>
                <div>
                  <h3 className="mb-2">Mark Your Attendance</h3>
                  <p className="text-sm text-muted-foreground">
                    Scan the QR code at hostel kiosk
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">
                    హాజరు గుర్తించండి
                  </p>
                </div>
              </div>

              {/* Enhanced Camera Preview Area */}
              <div className="relative bg-gradient-to-br from-gray-900 to-gray-800 rounded-2xl overflow-hidden aspect-square shadow-inner">
                {/* Decorative corner markers */}
                <div className="absolute top-4 left-4 w-8 h-8 border-t-4 border-l-4 border-white/30 rounded-tl-xl" />
                <div className="absolute top-4 right-4 w-8 h-8 border-t-4 border-r-4 border-white/30 rounded-tr-xl" />
                <div className="absolute bottom-4 left-4 w-8 h-8 border-b-4 border-l-4 border-white/30 rounded-bl-xl" />
                <div className="absolute bottom-4 right-4 w-8 h-8 border-b-4 border-r-4 border-white/30 rounded-br-xl" />

                {!scanning && !scanSuccess && (
                  <div className="absolute inset-0 flex items-center justify-center">
                    <div className="text-center text-white space-y-4">
                      <Camera className="h-20 w-20 mx-auto opacity-50" />
                      <div>
                        <p className="text-sm opacity-75">Camera preview</p>
                        <p className="text-xs opacity-60 mt-1">Tap button below to activate</p>
                      </div>
                    </div>
                  </div>
                )}

                {scanning && (
                  <div className="absolute inset-0 flex items-center justify-center bg-black/50">
                    <motion.div
                      animate={{ opacity: [0.3, 1, 0.3] }}
                      transition={{ duration: 1.5, repeat: Infinity }}
                      className="text-white text-center space-y-4"
                    >
                      <div className="w-56 h-56 border-4 border-green-400 rounded-2xl mx-auto relative">
                        <motion.div
                          className="absolute inset-x-0 h-1 bg-green-400"
                          animate={{ y: [0, 220, 0] }}
                          transition={{ duration: 2, repeat: Infinity, ease: "linear" }}
                        />
                      </div>
                      <p className="text-base font-medium">Scanning QR Code...</p>
                    </motion.div>
                  </div>
                )}

                {scanSuccess && (
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ type: "spring", stiffness: 200 }}
                    className="absolute inset-0 bg-gradient-to-br from-green-600 to-green-700 flex items-center justify-center"
                  >
                    <div className="text-center text-white space-y-4">
                      <motion.div
                        initial={{ scale: 0 }}
                        animate={{ scale: 1 }}
                        transition={{ delay: 0.2 }}
                      >
                        <CheckCircle2 className="h-28 w-28 mx-auto" />
                      </motion.div>
                      <div>
                        <h3 className="text-2xl mb-2">Success!</h3>
                        <p className="text-base">Attendance marked ✓</p>
                        <p className="text-sm opacity-90 mt-2">
                          {new Date().toLocaleTimeString('en-IN', { 
                            hour: '2-digit', 
                            minute: '2-digit',
                            timeZone: 'Asia/Kolkata'
                          })} IST
                        </p>
                      </div>
                    </div>
                  </motion.div>
                )}
              </div>

              <motion.div whileTap={{ scale: 0.98 }}>
                <Button
                  onClick={handleScan}
                  disabled={scanning}
                  className="w-full bg-green-600 hover:bg-green-700 h-14 text-base shadow-lg"
                >
                  {scanning ? "Scanning..." : "🔍 Start Scanning"}
                </Button>
              </motion.div>
            </Card>

            {/* Enhanced Manual Attendance Option */}
            <Card className="p-5 border-0 shadow-md bg-gradient-to-br from-amber-50 to-amber-100 dark:from-amber-950 dark:to-amber-900">
              <div className="space-y-4">
                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 bg-amber-600 rounded-xl flex items-center justify-center flex-shrink-0">
                    <Upload className="h-5 w-5 text-white" />
                  </div>
                  <div className="flex-1">
                    <h4 className="mb-1">Manual Attendance</h4>
                    <p className="text-sm text-muted-foreground">
                      Can't scan QR? Request warden verification
                    </p>
                    <p className="text-xs text-muted-foreground mt-1">
                      Response within 2 hours
                    </p>
                  </div>
                </div>
                <motion.div whileTap={{ scale: 0.98 }}>
                  <Button
                    onClick={() => setManualDialog(true)}
                    variant="outline"
                    className="w-full h-12 border-2 border-amber-600 hover:bg-amber-600 hover:text-white"
                  >
                    Request Manual Verification
                  </Button>
                </motion.div>
              </div>
            </Card>
          </TabsContent>

          <TabsContent value="summary" className="space-y-4">
            <div className="flex items-center justify-between mb-2">
              <div>
                <h3 className="mb-1">This Month Stats</h3>
                <p className="text-xs text-muted-foreground">October 2025</p>
              </div>
              <UpdatedTime />
            </div>

            {/* Enhanced Summary Cards */}
            <div className="grid grid-cols-2 gap-4">
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.1 }}
              >
                <Card className="p-5 space-y-2 border-0 shadow-lg bg-gradient-to-br from-green-50 to-green-100 dark:from-green-950 dark:to-green-900">
                  <p className="text-sm text-muted-foreground">Present Days</p>
                  <p className="text-4xl text-green-600">25</p>
                  <p className="text-xs text-green-700 dark:text-green-400 font-medium">of 30 days</p>
                </Card>
              </motion.div>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
              >
                <Card className="p-5 space-y-2 border-0 shadow-lg bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-950 dark:to-blue-900">
                  <p className="text-sm text-muted-foreground">Attendance %</p>
                  <p className="text-4xl text-primary">83%</p>
                  <p className="text-xs text-green-700 dark:text-green-400 font-medium">✓ Above 75%</p>
                </Card>
              </motion.div>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
              >
                <Card className="p-5 space-y-2 border-0 shadow-lg bg-gradient-to-br from-amber-50 to-amber-100 dark:from-amber-950 dark:to-amber-900">
                  <p className="text-sm text-muted-foreground">Manual Entry</p>
                  <p className="text-4xl text-amber-600">3</p>
                  <p className="text-xs text-muted-foreground">12% of total</p>
                </Card>
              </motion.div>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
              >
                <Card className="p-5 space-y-2 border-0 shadow-lg bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-950 dark:to-purple-900">
                  <p className="text-sm text-muted-foreground">Outpass Days</p>
                  <p className="text-4xl text-purple-600">5</p>
                  <p className="text-xs text-muted-foreground">Not counted</p>
                </Card>
              </motion.div>
            </div>

            {/* Breakdown Card */}
            <Card className="p-5 space-y-4 border-0 shadow-sm">
              <div className="flex items-center justify-between">
                <h4>Attendance Breakdown</h4>
                <PieChart className="h-5 w-5 text-muted-foreground" />
              </div>

              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className="w-3 h-3 rounded-full bg-green-600" />
                    <span className="text-sm">Kiosk Scan</span>
                  </div>
                  <span>22 days</span>
                </div>

                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className="w-3 h-3 rounded-full bg-amber-600" />
                    <span className="text-sm">Warden Manual</span>
                  </div>
                  <span>3 days</span>
                </div>

                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className="w-3 h-3 rounded-full bg-blue-600" />
                    <span className="text-sm">Outpass (Excused)</span>
                  </div>
                  <span>5 days</span>
                </div>
              </div>

              {/* Simple Pie Chart Visualization */}
              <div className="flex gap-1 h-4 rounded-full overflow-hidden">
                <div className="bg-green-600" style={{ width: "73.3%" }} />
                <div className="bg-amber-600" style={{ width: "10%" }} />
                <div className="bg-blue-600" style={{ width: "16.7%" }} />
              </div>
            </Card>

            {/* Session Summary */}
            <Card className="p-5 space-y-3 border-0 shadow-sm">
              <h4>Session Summary</h4>
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Total Days:</span>
                  <span>30</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Outpass Days:</span>
                  <span>5</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Effective Present:</span>
                  <span className="text-green-600">25 (Total - Outpass)</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Manual %:</span>
                  <span className="text-amber-600">12%</span>
                </div>
              </div>
            </Card>
          </TabsContent>
        </Tabs>
      </div>

      {/* Manual Attendance Dialog */}
      <Dialog open={manualDialog} onOpenChange={setManualDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Manual Attendance Request</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleManualSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="reason">Reason</Label>
              <Textarea
                id="reason"
                placeholder="Why can't you scan the QR code?"
                rows={3}
                required
              />
            </div>

            <div className="space-y-2">
              <Label>Upload Photo (Optional)</Label>
              <Button type="button" variant="outline" className="w-full">
                <Upload className="h-4 w-4 mr-2" />
                Choose Photo
              </Button>
            </div>

            <Button type="submit" className="w-full bg-green-600 hover:bg-green-700">
              Submit Request
            </Button>
          </form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
