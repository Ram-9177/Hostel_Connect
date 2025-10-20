import { HelpCircle, ChevronDown } from "lucide-react";
import { Card } from "./ui/card";
import { Badge } from "./ui/badge";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "./ui/accordion";

interface HelpFAQProps {
  context?: "gatepass" | "attendance" | "meals" | "rooms" | "complaints" | "general";
}

export function HelpFAQ({ context = "general" }: HelpFAQProps) {
  const gatepassFAQs = [
    {
      question: "How do I apply for a gate pass?",
      answer: "Tap the 'New Gate Pass' button, fill in your destination, purpose, and dates. You'll receive a notification once your warden approves it.",
      telugu: "కొత్త గేట్ పాస్ బటన్ నొక్కండి, మీ గమ్యం, ఉద్దేశం మరియు తేదీలను పూరించండి.",
    },
    {
      question: "How long does approval take?",
      answer: "Gate pass approvals typically take 2-4 hours during working hours. Emergency passes are prioritized.",
      telugu: "సాధారణంగా 2-4 గంటల్లో అనుమతి లభిస్తుంది.",
    },
    {
      question: "Can I cancel a gate pass?",
      answer: "Yes, you can cancel a pending or approved pass from the gate pass history screen before your departure time.",
      telugu: "అవును, మీరు బయలుదేరే సమయం ముందు రద్దు చేయవచ్చు.",
    },
    {
      question: "What happens if I return late?",
      answer: "Late returns are automatically flagged. Contact your warden immediately if you expect a delay.",
      telugu: "ఆలస్యంగా వస్తే స్వయంచాలకంగా గుర్తించబడుతుంది.",
    },
  ];

  const attendanceFAQs = [
    {
      question: "When should I mark attendance?",
      answer: "Mark attendance during morning roll call (7:00-8:00 AM) and evening roll call (6:30-7:30 PM) by scanning the QR code at the attendance kiosk.",
      telugu: "ఉదయం 7:00-8:00 మరియు సాయంత్రం 6:30-7:30 మధ్య హాజరు వేయండి.",
    },
    {
      question: "What if I miss attendance?",
      answer: "Missing attendance without a valid gate pass results in an 'Absent' mark. Contact your warden with a valid reason.",
      telugu: "గేట్ పాస్ లేకుండా హాజరు తప్పితే 'గైర్హాజరు' గుర్తు పడుతుంది.",
    },
    {
      question: "Can I mark attendance remotely?",
      answer: "No, you must physically scan the QR code at the hostel kiosk. This ensures accurate tracking.",
      telugu: "లేదు, మీరు హాస్టల్ కియోస్క్ వద్ద QR కోడ్ స్కాన్ చేయాలి.",
    },
  ];

  const mealsFAQs = [
    {
      question: "How do I opt out of a meal?",
      answer: "Go to Meals page, select the meal type and date, then tap 'Opt Out'. You must do this at least 6 hours before the meal.",
      telugu: "భోజనం పేజీకి వెళ్లి, భోజన రకం మరియు తేదీని ఎంచుకోండి.",
    },
    {
      question: "Can I get a refund for opted-out meals?",
      answer: "This is a management app focused on operations. Please contact the hostel office for any financial matters.",
      telugu: "ఆర్థిక విషయాల కోసం హాస్టల్ కార్యాలయాన్ని సంప్రదించండి.",
    },
    {
      question: "When is the meal menu updated?",
      answer: "The weekly menu is updated every Sunday evening by the chef. You'll receive a notification when it's available.",
      telugu: "వారపు మెనూ ప్రతి ఆదివారం సాయంత్రం నవీకరించబడుతుంది.",
    },
  ];

  const roomsFAQs = [
    {
      question: "How are rooms allotted?",
      answer: "Room allotment is managed by the warden based on availability, preferences, and hostel policies.",
      telugu: "వార్డెన్ లభ్యత మరియు ప్రాధాన్యతల ఆధారంగా రూములు కేటాయిస్తారు.",
    },
    {
      question: "Can I request a room change?",
      answer: "Yes, contact your warden with a valid reason. Room changes are subject to availability.",
      telugu: "అవును, సరైన కారణంతో వార్డెన్‌ను సంప్రదించండి.",
    },
  ];

  const complaintsFAQs = [
    {
      question: "How do I file a complaint?",
      answer: "Go to Notices & Complaints, tap 'New Complaint', select category, describe the issue, and submit. You'll get updates via notifications.",
      telugu: "నోటీసులు & ఫిర్యాదుల పేజీకి వెళ్లి కొత్త ఫిర్యాదు సమర్పించండి.",
    },
    {
      question: "How long does it take to resolve?",
      answer: "Resolution time depends on the issue type. Minor issues: 1-2 days, major issues: 3-7 days. Emergency issues are prioritized.",
      telugu: "చిన్న సమస్యలు: 1-2 రోజులు, పెద్ద సమస్యలు: 3-7 రోజులు.",
    },
  ];

  const generalFAQs = [
    {
      question: "How do I change my language preference?",
      answer: "Go to Settings (from your Profile) and toggle between English and Telugu.",
      telugu: "సెట్టింగ్స్‌లో భాషను మార్చుకోవచ్చు.",
    },
    {
      question: "What if I lose my phone?",
      answer: "Immediately inform your warden. You can temporarily use biometric authentication at the kiosk for attendance.",
      telugu: "వెంటనే మీ వార్డెన్‌కు తెలియజేయండి.",
    },
    {
      question: "Is my data secure?",
      answer: "Yes, all data is encrypted and stored securely. We follow strict privacy guidelines for hostel management.",
      telugu: "అవును, మీ డేటా సురక్షితంగా ఎన్క్రిప్ట్ చేయబడింది.",
    },
  ];

  const getFAQs = () => {
    switch (context) {
      case "gatepass":
        return gatepassFAQs;
      case "attendance":
        return attendanceFAQs;
      case "meals":
        return mealsFAQs;
      case "rooms":
        return roomsFAQs;
      case "complaints":
        return complaintsFAQs;
      default:
        return generalFAQs;
    }
  };

  const faqs = getFAQs();

  return (
    <Card className="p-5 border-0 shadow-md">
      <div className="flex items-center gap-3 mb-4">
        <div className="p-2 bg-blue-100 rounded-lg">
          <HelpCircle className="h-5 w-5 text-blue-600" />
        </div>
        <div className="flex-1">
          <h3 className="font-semibold">Frequently Asked Questions</h3>
          <p className="text-sm text-muted-foreground">తరచుగా అడిగే ప్రశ్నలు</p>
        </div>
        <Badge variant="secondary">{faqs.length}</Badge>
      </div>

      <Accordion type="single" collapsible className="w-full">
        {faqs.map((faq, index) => (
          <AccordionItem key={index} value={`item-${index}`}>
            <AccordionTrigger className="text-left text-sm hover:no-underline">
              {faq.question}
            </AccordionTrigger>
            <AccordionContent className="text-sm text-muted-foreground">
              <p>{faq.answer}</p>
              {"telugu" in faq && (
                <p className="mt-2 text-blue-600 italic">{faq.telugu}</p>
              )}
            </AccordionContent>
          </AccordionItem>
        ))}
      </Accordion>
    </Card>
  );
}
