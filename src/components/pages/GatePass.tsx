import { useState } from "react";
import { ArrowLeft, Calendar, Clock, MapPin, FileText, Filter } from "lucide-react";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { Label } from "../ui/label";
import { Textarea } from "../ui/textarea";
import { Card } from "../ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Badge } from "../ui/badge";
import { UpdatedTime } from "../UpdatedTime";
import { FullScreenAd } from "../FullScreenAd";
import { QRCodeDisplay } from "../QRCodeDisplay";
import { toast } from "sonner@2.0.3";

interface GatePassProps {
  onBack: () => void;
}

export function GatePass({ onBack }: GatePassProps) {
  const [view, setView] = useState<"list" | "form" | "ad" | "qr">("list");
  const [selectedPass, setSelectedPass] = useState<any>(null);

  const passes = [
    { id: "GP2024001", date: "2024-10-19", time: "14:00", destination: "City Market", status: "approved", reason: "Shopping" },
    { id: "GP2024002", date: "2024-10-20", time: "10:00", destination: "Hospital", status: "pending", reason: "Medical checkup" },
    { id: "GP2024003", date: "2024-10-18", time: "18:00", destination: "Friend's Place", status: "expired", reason: "Social visit" },
    { id: "GP2024004", date: "2024-10-17", time: "15:00", destination: "Bank", status: "rejected", reason: "Personal work" },
  ];

  const getStatusColor = (status: string) => {
    switch (status) {
      case "approved":
        return "bg-green-100 text-green-700 border-green-200";
      case "pending":
        return "bg-yellow-100 text-yellow-700 border-yellow-200";
      case "rejected":
        return "bg-red-100 text-red-700 border-red-200";
      case "expired":
        return "bg-gray-100 text-gray-700 border-gray-200";
      default:
        return "bg-gray-100 text-gray-700 border-gray-200";
    }
  };

  const handleUsePass = (pass: any) => {
    setSelectedPass(pass);
    setView("ad");
  };

  const handleAdComplete = () => {
    setView("qr");
  };

  const handleQRExpire = () => {
    toast.success("Gate pass used successfully");
    setView("list");
    setSelectedPass(null);
  };

  const handleSubmitForm = (e: React.FormEvent) => {
    e.preventDefault();
    toast.success("Gate pass request submitted for approval");
    setView("list");
  };

  if (view === "ad") {
    return <FullScreenAd duration={20} onComplete={handleAdComplete} onSkip={handleAdComplete} />;
  }

  if (view === "qr" && selectedPass) {
    return (
      <div className="min-h-screen bg-background flex flex-col">
        <div className="p-4 border-b border-border flex items-center gap-3">
          <button onClick={() => { setView("list"); setSelectedPass(null); }}>
            <ArrowLeft className="h-5 w-5" />
          </button>
          <h2>Gate Pass QR Code</h2>
        </div>
        <div className="flex-1 flex items-center justify-center">
          <QRCodeDisplay passId={selectedPass.id} onExpire={handleQRExpire} duration={30} />
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary to-secondary text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <h1 className="text-xl">Gate Pass</h1>
      </div>

      <div className="p-4">
        <Tabs defaultValue="active" className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-4">
            <TabsTrigger value="active">Active</TabsTrigger>
            <TabsTrigger value="history">History</TabsTrigger>
            <TabsTrigger value="new">New Request</TabsTrigger>
          </TabsList>

          <TabsContent value="active" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Your Gate Passes</h3>
              <UpdatedTime />
            </div>

            {passes
              .filter((p) => p.status === "approved" || p.status === "pending")
              .map((pass) => (
                <Card key={pass.id} className="p-4 space-y-3 border-0 shadow-sm">
                  <div className="flex items-start justify-between">
                    <div className="space-y-1">
                      <p className="font-mono text-sm text-muted-foreground">
                        {pass.id}
                      </p>
                      <h4>{pass.destination}</h4>
                    </div>
                    <Badge className={getStatusColor(pass.status)}>
                      {pass.status}
                    </Badge>
                  </div>

                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div className="flex items-center gap-2">
                      <Calendar className="h-4 w-4 text-muted-foreground" />
                      <span>{pass.date}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Clock className="h-4 w-4 text-muted-foreground" />
                      <span>{pass.time}</span>
                    </div>
                  </div>

                  <div className="flex items-start gap-2 text-sm">
                    <FileText className="h-4 w-4 text-muted-foreground mt-0.5" />
                    <span className="text-muted-foreground">{pass.reason}</span>
                  </div>

                  {pass.status === "approved" && (
                    <Button
                      onClick={() => handleUsePass(pass)}
                      className="w-full bg-primary hover:bg-primary/90"
                    >
                      Use This Pass
                    </Button>
                  )}
                </Card>
              ))}
          </TabsContent>

          <TabsContent value="history" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Pass History</h3>
              <button className="flex items-center gap-2 text-sm text-primary">
                <Filter className="h-4 w-4" />
                Filter
              </button>
            </div>

            {passes
              .filter((p) => p.status === "expired" || p.status === "rejected")
              .map((pass) => (
                <Card key={pass.id} className="p-4 space-y-3 border-0 shadow-sm opacity-75">
                  <div className="flex items-start justify-between">
                    <div className="space-y-1">
                      <p className="font-mono text-sm text-muted-foreground">
                        {pass.id}
                      </p>
                      <h4>{pass.destination}</h4>
                    </div>
                    <Badge className={getStatusColor(pass.status)}>
                      {pass.status}
                    </Badge>
                  </div>

                  <div className="grid grid-cols-2 gap-3 text-sm">
                    <div className="flex items-center gap-2">
                      <Calendar className="h-4 w-4 text-muted-foreground" />
                      <span>{pass.date}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Clock className="h-4 w-4 text-muted-foreground" />
                      <span>{pass.time}</span>
                    </div>
                  </div>
                </Card>
              ))}
          </TabsContent>

          <TabsContent value="new">
            <Card className="p-5 border-0 shadow-sm">
              <form onSubmit={handleSubmitForm} className="space-y-5">
                <div className="space-y-2">
                  <Label htmlFor="destination">Destination</Label>
                  <div className="relative">
                    <MapPin className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                    <Input
                      id="destination"
                      placeholder="Enter destination"
                      className="pl-10"
                      required
                    />
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="date">Date</Label>
                    <Input id="date" type="date" required />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="time">Time</Label>
                    <Input id="time" type="time" required />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="reason">Reason</Label>
                  <Textarea
                    id="reason"
                    placeholder="Brief reason for gate pass"
                    rows={3}
                    required
                  />
                </div>

                <Button type="submit" className="w-full bg-primary hover:bg-primary/90">
                  Submit Request
                </Button>
              </form>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
