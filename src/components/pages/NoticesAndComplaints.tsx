import { useState } from "react";
import { ArrowLeft, Megaphone, MessageSquare, Send, Image as ImageIcon } from "lucide-react";
import { Card } from "../ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Badge } from "../ui/badge";
import { Button } from "../ui/button";
import { Textarea } from "../ui/textarea";
import { Label } from "../ui/label";
import { Input } from "../ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../ui/select";
import { UpdatedTime } from "../UpdatedTime";
import { toast } from "sonner@2.0.3";

interface NoticesAndComplaintsProps {
  onBack: () => void;
}

export function NoticesAndComplaints({ onBack }: NoticesAndComplaintsProps) {
  const [showComplaintForm, setShowComplaintForm] = useState(false);

  const notices = [
    {
      id: 1,
      title: "Mess Menu Updated for Next Week",
      content: "New continental dishes added to the menu. Check the notice board for details.",
      date: "2 hours ago",
      category: "Mess",
      priority: "medium",
    },
    {
      id: 2,
      title: "Holiday Announcement - Diwali Break",
      content: "Hostel will remain open during Diwali. Special dinner on Oct 31st.",
      date: "5 hours ago",
      category: "General",
      priority: "high",
    },
    {
      id: 3,
      title: "Room Inspection Schedule",
      content: "Room inspection will be conducted on Friday, Oct 25. Please keep rooms clean.",
      date: "1 day ago",
      category: "Maintenance",
      priority: "medium",
    },
    {
      id: 4,
      title: "WiFi Maintenance",
      content: "Internet will be down from 2 AM to 4 AM on Thursday for upgrades.",
      date: "1 day ago",
      category: "Facilities",
      priority: "low",
    },
  ];

  const complaints = [
    {
      id: "CMP001",
      title: "AC not working in Room 205",
      category: "Maintenance",
      status: "in-progress",
      date: "Oct 18",
    },
    {
      id: "CMP002",
      title: "Water leakage in bathroom",
      category: "Plumbing",
      status: "resolved",
      date: "Oct 15",
    },
    {
      id: "CMP003",
      title: "Mess food quality issue",
      category: "Mess",
      status: "pending",
      date: "Oct 19",
    },
  ];

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "high":
        return "bg-red-100 text-red-700 border-red-200";
      case "medium":
        return "bg-yellow-100 text-yellow-700 border-yellow-200";
      case "low":
        return "bg-blue-100 text-blue-700 border-blue-200";
      default:
        return "bg-gray-100 text-gray-700 border-gray-200";
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "resolved":
        return "bg-green-100 text-green-700 border-green-200";
      case "in-progress":
        return "bg-blue-100 text-blue-700 border-blue-200";
      case "pending":
        return "bg-yellow-100 text-yellow-700 border-yellow-200";
      default:
        return "bg-gray-100 text-gray-700 border-gray-200";
    }
  };

  const handleSubmitComplaint = (e: React.FormEvent) => {
    e.preventDefault();
    toast.success("Complaint submitted successfully");
    setShowComplaintForm(false);
  };

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary to-secondary text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <h1 className="text-xl">Notices & Complaints</h1>
      </div>

      <div className="p-4">
        <Tabs defaultValue="notices" className="w-full">
          <TabsList className="grid w-full grid-cols-2 mb-4">
            <TabsTrigger value="notices">Notices</TabsTrigger>
            <TabsTrigger value="complaints">Complaints</TabsTrigger>
          </TabsList>

          <TabsContent value="notices" className="space-y-4">
            <div className="flex items-center justify-between">
              <h3>Latest Notices</h3>
              <UpdatedTime />
            </div>

            {/* Notices Feed */}
            <div className="space-y-3">
              {notices.map((notice, index) => (
                <Card
                  key={notice.id}
                  className="p-4 border-0 shadow-sm hover:shadow-md transition-shadow"
                >
                  <div className="space-y-3">
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <Megaphone className="h-4 w-4 text-primary" />
                          <Badge className={getPriorityColor(notice.priority)}>
                            {notice.priority}
                          </Badge>
                          <Badge variant="outline">{notice.category}</Badge>
                        </div>
                        <h4>{notice.title}</h4>
                        <p className="text-sm text-muted-foreground mt-2">
                          {notice.content}
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center justify-between text-xs text-muted-foreground pt-2 border-t border-border">
                      <span>{notice.date}</span>
                      <button className="text-primary hover:underline">
                        Read More
                      </button>
                    </div>
                  </div>
                </Card>
              ))}

              {/* Ad Card Slot */}
              {notices.length > 2 && (
                <Card className="p-4 border-0 shadow-sm bg-gradient-to-r from-accent/20 to-accent/10">
                  <div className="flex items-center justify-between">
                    <div className="flex-1">
                      <p className="text-sm">
                        Campus Bookstore: 15% off on all notebooks!
                      </p>
                      <p className="text-xs text-muted-foreground mt-1">
                        Valid till Oct 25
                      </p>
                    </div>
                    <Button size="sm" variant="outline">
                      View
                    </Button>
                  </div>
                </Card>
              )}
            </div>
          </TabsContent>

          <TabsContent value="complaints" className="space-y-4">
            {!showComplaintForm ? (
              <>
                <div className="flex items-center justify-between">
                  <h3>Your Complaints</h3>
                  <Button
                    onClick={() => setShowComplaintForm(true)}
                    size="sm"
                    className="bg-primary hover:bg-primary/90"
                  >
                    <Send className="h-4 w-4 mr-2" />
                    New
                  </Button>
                </div>

                {/* Complaints List */}
                <div className="space-y-3">
                  {complaints.map((complaint) => (
                    <Card key={complaint.id} className="p-4 border-0 shadow-sm">
                      <div className="space-y-3">
                        <div className="flex items-start justify-between">
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                              <MessageSquare className="h-4 w-4 text-primary" />
                              <span className="font-mono text-xs text-muted-foreground">
                                {complaint.id}
                              </span>
                            </div>
                            <h4>{complaint.title}</h4>
                            <div className="flex items-center gap-2 mt-2">
                              <Badge variant="outline">{complaint.category}</Badge>
                              <Badge className={getStatusColor(complaint.status)}>
                                {complaint.status}
                              </Badge>
                            </div>
                          </div>
                        </div>

                        <div className="flex items-center justify-between text-xs text-muted-foreground pt-2 border-t border-border">
                          <span>Submitted on {complaint.date}</span>
                          <button className="text-primary hover:underline">
                            View Details
                          </button>
                        </div>
                      </div>
                    </Card>
                  ))}
                </div>

                {/* Status Tracker */}
                <Card className="p-5 space-y-3 border-0 shadow-sm bg-blue-50 dark:bg-blue-950">
                  <h4>Complaint Status Guide</h4>
                  <div className="space-y-2 text-sm">
                    <div className="flex items-center gap-2">
                      <div className="w-3 h-3 rounded-full bg-yellow-500" />
                      <span>Pending - Under review by warden</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <div className="w-3 h-3 rounded-full bg-blue-500" />
                      <span>In Progress - Being resolved</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <div className="w-3 h-3 rounded-full bg-green-500" />
                      <span>Resolved - Issue fixed</span>
                    </div>
                  </div>
                </Card>
              </>
            ) : (
              /* Complaint Form */
              <Card className="p-5 border-0 shadow-sm">
                <form onSubmit={handleSubmitComplaint} className="space-y-4">
                  <div className="flex items-center justify-between mb-2">
                    <h3>New Complaint</h3>
                    <button
                      type="button"
                      onClick={() => setShowComplaintForm(false)}
                      className="text-sm text-muted-foreground hover:text-foreground"
                    >
                      Cancel
                    </button>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="category">Category</Label>
                    <Select required>
                      <SelectTrigger>
                        <SelectValue placeholder="Select category" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="maintenance">Maintenance</SelectItem>
                        <SelectItem value="plumbing">Plumbing</SelectItem>
                        <SelectItem value="electrical">Electrical</SelectItem>
                        <SelectItem value="mess">Mess</SelectItem>
                        <SelectItem value="facilities">Facilities</SelectItem>
                        <SelectItem value="other">Other</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="title">Title</Label>
                    <Input
                      id="title"
                      placeholder="Brief description of issue"
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="description">Detailed Description</Label>
                    <Textarea
                      id="description"
                      placeholder="Provide details about the complaint..."
                      rows={4}
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Attach Photo (Optional)</Label>
                    <Button type="button" variant="outline" className="w-full">
                      <ImageIcon className="h-4 w-4 mr-2" />
                      Upload Photo
                    </Button>
                  </div>

                  <Button
                    type="submit"
                    className="w-full bg-primary hover:bg-primary/90"
                  >
                    <Send className="h-4 w-4 mr-2" />
                    Submit Complaint
                  </Button>
                </form>
              </Card>
            )}
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
