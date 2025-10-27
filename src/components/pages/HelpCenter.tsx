import React, { useState } from "react";
import { motion } from "framer-motion";
import { Card } from "../ui/card";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { Label } from "../ui/label";
import { Textarea } from "../ui/textarea";
import { toast } from "sonner";
import {
  ArrowLeft,
  HelpCircle,
  MessageSquare,
  Phone,
  Mail,
  Clock,
  ChevronDown,
  ChevronUp,
  Send,
  BookOpen,
  AlertCircle,
  CheckCircle,
} from "lucide-react";

interface HelpCenterProps {
  onBack: () => void;
}

interface FAQ {
  question: string;
  answer: string;
  category: string;
}

const faqs: FAQ[] = [
  {
    category: "Gate Pass",
    question: "How do I request a gate pass?",
    answer:
      'Go to the Gate Pass section from your dashboard, click "Request New Pass", fill in the destination and reason, then submit. You will receive a notification once approved.',
  },
  {
    category: "Gate Pass",
    question: "How long does it take to get a gate pass approved?",
    answer:
      "Gate passes are typically approved within 1-2 hours during working hours. Emergency passes may be approved faster. Check the status in your gate pass history.",
  },
  {
    category: "Attendance",
    question: "What if I can't scan the QR code for attendance?",
    answer:
      "You can submit a manual attendance request with a reason. Click on 'Cannot Scan QR?' and fill in the form. The warden will review and approve your attendance.",
  },
  {
    category: "Attendance",
    question: "How do I view my attendance record?",
    answer:
      "Go to the Attendance section and click on 'View History'. You can filter by date range and see your attendance percentage.",
  },
  {
    category: "Meals",
    question: "How do I update my meal preferences?",
    answer:
      "Navigate to the Meals section, click on 'Meal Intent', and select your preference for upcoming meals. You can choose to opt in or out.",
  },
  {
    category: "Meals",
    question: "Can I see the weekly menu?",
    answer:
      "Yes! The Meals section shows the current week's menu. You'll receive daily notifications about upcoming meals.",
  },
  {
    category: "Rooms",
    question: "How do I report a room issue?",
    answer:
      'Go to the Complaints section, select "Room Issue" category, describe the problem, and optionally attach photos. The maintenance team will be notified.',
  },
  {
    category: "Account",
    question: "How do I change my password?",
    answer:
      'Go to Profile > Change Password. Enter your current password and create a new one that meets the security requirements.',
  },
  {
    category: "Account",
    question: "What if I forget my password?",
    answer:
      'Click "Forgot Password" on the login screen. Enter your registered email and you will receive password reset instructions.',
  },
  {
    category: "Notifications",
    question: "How do I turn on/off notifications?",
    answer:
      "Go to Settings > Notifications and toggle the types of notifications you want to receive (gate pass updates, attendance reminders, meal notifications, etc.).",
  },
];

export const HelpCenter: React.FC<HelpCenterProps> = ({ onBack }) => {
  const [selectedCategory, setSelectedCategory] = useState<string>("All");
  const [expandedFAQ, setExpandedFAQ] = useState<number | null>(null);
  const [ticketForm, setTicketForm] = useState({
    subject: "",
    category: "",
    description: "",
    priority: "normal",
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [activeTab, setActiveTab] = useState<"faq" | "contact" | "ticket">("faq");

  const categories = ["All", ...Array.from(new Set(faqs.map((faq) => faq.category)))];

  const filteredFAQs =
    selectedCategory === "All"
      ? faqs
      : faqs.filter((faq) => faq.category === selectedCategory);

  const toggleFAQ = (index: number) => {
    setExpandedFAQ(expandedFAQ === index ? null : index);
  };

  const handleSubmitTicket = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!ticketForm.subject || !ticketForm.category || !ticketForm.description) {
      toast.error("Please fill in all required fields");
      return;
    }

    setIsSubmitting(true);

    try {
      // Simulate API call - replace with actual endpoint
      await new Promise((resolve) => setTimeout(resolve, 1500));

      toast.success("Support ticket submitted successfully! We'll get back to you soon.");
      
      // Reset form
      setTicketForm({
        subject: "",
        category: "",
        description: "",
        priority: "normal",
      });
    } catch (error) {
      console.error("Error submitting ticket:", error);
      toast.error("Failed to submit ticket. Please try again.");
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-4 md:p-8">
      <div className="max-w-6xl mx-auto">
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
          <h1 className="text-3xl font-bold text-gray-900 flex items-center gap-3">
            <HelpCircle className="h-8 w-8 text-blue-600" />
            Help & Support Center
          </h1>
          <p className="text-gray-600 mt-2">
            Find answers to common questions or get in touch with our support team
          </p>
        </motion.div>

        {/* Tab Navigation */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="p-2 shadow-lg border-0">
            <div className="flex gap-2">
              <Button
                variant={activeTab === "faq" ? "default" : "ghost"}
                onClick={() => setActiveTab("faq")}
                className="flex-1"
              >
                <BookOpen className="h-4 w-4 mr-2" />
                FAQs
              </Button>
              <Button
                variant={activeTab === "contact" ? "default" : "ghost"}
                onClick={() => setActiveTab("contact")}
                className="flex-1"
              >
                <Phone className="h-4 w-4 mr-2" />
                Contact
              </Button>
              <Button
                variant={activeTab === "ticket" ? "default" : "ghost"}
                onClick={() => setActiveTab("ticket")}
                className="flex-1"
              >
                <MessageSquare className="h-4 w-4 mr-2" />
                Submit Ticket
              </Button>
            </div>
          </Card>
        </motion.div>

        {/* FAQ Tab */}
        {activeTab === "faq" && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="space-y-6"
          >
            {/* Category Filter */}
            <Card className="p-4 shadow-lg border-0">
              <h3 className="font-semibold text-gray-900 mb-3">Filter by Category</h3>
              <div className="flex flex-wrap gap-2">
                {categories.map((category) => (
                  <Button
                    key={category}
                    variant={selectedCategory === category ? "default" : "outline"}
                    size="sm"
                    onClick={() => setSelectedCategory(category)}
                  >
                    {category}
                  </Button>
                ))}
              </div>
            </Card>

            {/* FAQ List */}
            <div className="space-y-3">
              {filteredFAQs.map((faq, index) => (
                <motion.div
                  key={index}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.05 }}
                >
                  <Card className="shadow-lg border-0 overflow-hidden">
                    <button
                      onClick={() => toggleFAQ(index)}
                      className="w-full p-5 text-left hover:bg-gray-50 transition-colors"
                    >
                      <div className="flex items-start justify-between gap-4">
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            <span className="text-xs font-medium text-blue-600 bg-blue-50 px-2 py-1 rounded">
                              {faq.category}
                            </span>
                          </div>
                          <h4 className="font-semibold text-gray-900">
                            {faq.question}
                          </h4>
                        </div>
                        {expandedFAQ === index ? (
                          <ChevronUp className="h-5 w-5 text-gray-500 flex-shrink-0" />
                        ) : (
                          <ChevronDown className="h-5 w-5 text-gray-500 flex-shrink-0" />
                        )}
                      </div>
                    </button>
                    {expandedFAQ === index && (
                      <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: "auto", opacity: 1 }}
                        exit={{ height: 0, opacity: 0 }}
                        className="px-5 pb-5 bg-gray-50"
                      >
                        <p className="text-gray-700 leading-relaxed">{faq.answer}</p>
                      </motion.div>
                    )}
                  </Card>
                </motion.div>
              ))}
            </div>
          </motion.div>
        )}

        {/* Contact Tab */}
        {activeTab === "contact" && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="grid grid-cols-1 md:grid-cols-2 gap-6"
          >
            {/* Contact Cards */}
            <Card className="p-6 shadow-xl border-0">
              <div className="text-center">
                <div className="inline-flex items-center justify-center w-16 h-16 bg-blue-100 rounded-full mb-4">
                  <Phone className="h-8 w-8 text-blue-600" />
                </div>
                <h3 className="font-semibold text-gray-900 mb-2">Call Us</h3>
                <p className="text-gray-600 mb-4">Available 24/7 for emergencies</p>
                <a
                  href="tel:+911234567890"
                  className="text-blue-600 hover:text-blue-700 font-medium text-lg"
                >
                  +91 123 456 7890
                </a>
              </div>
            </Card>

            <Card className="p-6 shadow-xl border-0">
              <div className="text-center">
                <div className="inline-flex items-center justify-center w-16 h-16 bg-green-100 rounded-full mb-4">
                  <Mail className="h-8 w-8 text-green-600" />
                </div>
                <h3 className="font-semibold text-gray-900 mb-2">Email Us</h3>
                <p className="text-gray-600 mb-4">We'll respond within 24 hours</p>
                <a
                  href="mailto:support@hostelconnect.com"
                  className="text-green-600 hover:text-green-700 font-medium"
                >
                  support@hostelconnect.com
                </a>
              </div>
            </Card>

            {/* Support Hours */}
            <Card className="p-6 shadow-xl border-0 md:col-span-2">
              <div className="flex items-start gap-4">
                <div className="inline-flex items-center justify-center w-12 h-12 bg-amber-100 rounded-full flex-shrink-0">
                  <Clock className="h-6 w-6 text-amber-600" />
                </div>
                <div>
                  <h3 className="font-semibold text-gray-900 mb-3">Support Hours</h3>
                  <div className="space-y-2 text-sm text-gray-700">
                    <p>
                      <strong>General Support:</strong> Monday - Friday, 9:00 AM - 6:00 PM
                    </p>
                    <p>
                      <strong>Emergency Line:</strong> Available 24/7 for urgent issues
                    </p>
                    <p>
                      <strong>Gate Pass Approvals:</strong> 6:00 AM - 11:00 PM (Daily)
                    </p>
                  </div>
                </div>
              </div>
            </Card>

            {/* Quick Tips */}
            <Card className="p-6 shadow-xl border-0 md:col-span-2 bg-blue-50 border-blue-200">
              <h3 className="font-semibold text-blue-900 mb-3 flex items-center gap-2">
                <AlertCircle className="h-5 w-5" />
                Before You Contact Us
              </h3>
              <ul className="space-y-2 text-sm text-blue-800">
                <li className="flex items-start gap-2">
                  <CheckCircle className="h-4 w-4 text-blue-600 mt-0.5" />
                  <span>Check the FAQs above - most questions are answered there</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle className="h-4 w-4 text-blue-600 mt-0.5" />
                  <span>Have your student ID ready for faster support</span>
                </li>
                <li className="flex items-start gap-2">
                  <CheckCircle className="h-4 w-4 text-blue-600 mt-0.5" />
                  <span>For technical issues, include screenshots if possible</span>
                </li>
              </ul>
            </Card>
          </motion.div>
        )}

        {/* Submit Ticket Tab */}
        {activeTab === "ticket" && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
          >
            <Card className="p-6 md:p-8 shadow-xl border-0">
              <h3 className="font-semibold text-gray-900 mb-6 text-lg">
                Submit a Support Ticket
              </h3>
              <form onSubmit={handleSubmitTicket} className="space-y-5">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                  {/* Subject */}
                  <div className="space-y-2 md:col-span-2">
                    <Label htmlFor="subject">Subject *</Label>
                    <Input
                      id="subject"
                      placeholder="Brief summary of your issue"
                      value={ticketForm.subject}
                      onChange={(e) =>
                        setTicketForm({ ...ticketForm, subject: e.target.value })
                      }
                      required
                    />
                  </div>

                  {/* Category */}
                  <div className="space-y-2">
                    <Label htmlFor="category">Category *</Label>
                    <select
                      id="category"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      value={ticketForm.category}
                      onChange={(e) =>
                        setTicketForm({ ...ticketForm, category: e.target.value })
                      }
                      required
                    >
                      <option value="">Select a category</option>
                      <option value="gate-pass">Gate Pass</option>
                      <option value="attendance">Attendance</option>
                      <option value="meals">Meals</option>
                      <option value="rooms">Rooms & Maintenance</option>
                      <option value="account">Account & Login</option>
                      <option value="notifications">Notifications</option>
                      <option value="technical">Technical Issue</option>
                      <option value="other">Other</option>
                    </select>
                  </div>

                  {/* Priority */}
                  <div className="space-y-2">
                    <Label htmlFor="priority">Priority</Label>
                    <select
                      id="priority"
                      className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      value={ticketForm.priority}
                      onChange={(e) =>
                        setTicketForm({ ...ticketForm, priority: e.target.value })
                      }
                    >
                      <option value="low">Low</option>
                      <option value="normal">Normal</option>
                      <option value="high">High</option>
                      <option value="urgent">Urgent</option>
                    </select>
                  </div>
                </div>

                {/* Description */}
                <div className="space-y-2">
                  <Label htmlFor="description">Description *</Label>
                  <Textarea
                    id="description"
                    placeholder="Please provide detailed information about your issue..."
                    rows={6}
                    value={ticketForm.description}
                    onChange={(e) =>
                      setTicketForm({ ...ticketForm, description: e.target.value })
                    }
                    required
                  />
                  <p className="text-xs text-gray-500">
                    Include any relevant details, error messages, or steps to reproduce the issue
                  </p>
                </div>

                {/* Submit Button */}
                <div className="pt-4">
                  <Button
                    type="submit"
                    className="w-full bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-medium py-6 text-base"
                    disabled={isSubmitting}
                  >
                    {isSubmitting ? (
                      <div className="flex items-center gap-2">
                        <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        <span>Submitting...</span>
                      </div>
                    ) : (
                      <>
                        <Send className="h-5 w-5 mr-2" />
                        Submit Ticket
                      </>
                    )}
                  </Button>
                </div>
              </form>
            </Card>

            {/* Response Time Info */}
            <Card className="mt-6 p-6 bg-green-50 border-green-200">
              <h3 className="font-semibold text-green-900 mb-2 flex items-center gap-2">
                <CheckCircle className="h-5 w-5" />
                What Happens Next?
              </h3>
              <ul className="space-y-2 text-sm text-green-800">
                <li className="flex items-start gap-2">
                  <span className="text-green-600 mt-1">1.</span>
                  <span>You'll receive a confirmation email with your ticket number</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-green-600 mt-1">2.</span>
                  <span>Our support team will review your ticket within 24 hours</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-green-600 mt-1">3.</span>
                  <span>You'll get updates via email and in-app notifications</span>
                </li>
                <li className="flex items-start gap-2">
                  <span className="text-green-600 mt-1">4.</span>
                  <span>Urgent tickets are prioritized and handled within 2-4 hours</span>
                </li>
              </ul>
            </Card>
          </motion.div>
        )}
      </div>
    </div>
  );
};
