import { ArrowLeft, BookOpen, Users, Clock, MapPin, Calendar, Check, X } from "lucide-react";
import { Card } from "../ui/card";
import { Badge } from "../ui/badge";
import { Button } from "../ui/button";
import { useState } from "react";
import { toast } from "sonner";
import { premiumColors, roleColors, premiumShadows } from "../../styles/premium-design-tokens";

interface StudyRoomProps {
  onBack: () => void;
}

interface Room {
  id: string;
  name: string;
  capacity: number;
  currentOccupancy: number;
  floor: string;
  amenities: string[];
  available: boolean;
  nextAvailable?: string;
}

interface Booking {
  id: string;
  roomName: string;
  date: string;
  startTime: string;
  endTime: string;
  status: "active" | "upcoming" | "completed";
}

const STUDY_ROOMS: Room[] = [
  { 
    id: "SR-101", 
    name: "Study Room 1", 
    capacity: 6, 
    currentOccupancy: 4, 
    floor: "Floor 1", 
    amenities: ["WiFi", "Whiteboard", "AC"],
    available: true 
  },
  { 
    id: "SR-102", 
    name: "Study Room 2", 
    capacity: 8, 
    currentOccupancy: 8, 
    floor: "Floor 1", 
    amenities: ["WiFi", "Projector", "AC"],
    available: false,
    nextAvailable: "03:00 PM"
  },
  { 
    id: "SR-201", 
    name: "Study Room 3", 
    capacity: 10, 
    currentOccupancy: 0, 
    floor: "Floor 2", 
    amenities: ["WiFi", "Whiteboard", "Projector", "AC"],
    available: true 
  },
  { 
    id: "SR-202", 
    name: "Study Room 4", 
    capacity: 4, 
    currentOccupancy: 2, 
    floor: "Floor 2", 
    amenities: ["WiFi", "Whiteboard"],
    available: true 
  },
  { 
    id: "SR-301", 
    name: "Group Study Hall", 
    capacity: 20, 
    currentOccupancy: 12, 
    floor: "Floor 3", 
    amenities: ["WiFi", "Multiple Whiteboards", "Projector", "AC", "Sound System"],
    available: true 
  },
];

const MY_BOOKINGS: Booking[] = [
  {
    id: "BK-001",
    roomName: "Study Room 1",
    date: "Oct 27, 2025",
    startTime: "02:00 PM",
    endTime: "04:00 PM",
    status: "active"
  },
  {
    id: "BK-002",
    roomName: "Study Room 3",
    date: "Oct 28, 2025",
    startTime: "10:00 AM",
    endTime: "12:00 PM",
    status: "upcoming"
  },
];

export function StudyRoom({ onBack }: StudyRoomProps) {
  const [selectedTab, setSelectedTab] = useState<"available" | "bookings">("available");
  const [selectedRoom, setSelectedRoom] = useState<Room | null>(null);
  const [showBookingModal, setShowBookingModal] = useState(false);
  const studentColors = roleColors.STUDENT;

  const handleBookRoom = (room: Room) => {
    setSelectedRoom(room);
    setShowBookingModal(true);
  };

  const handleConfirmBooking = () => {
    toast.success(`Successfully booked ${selectedRoom?.name}!`);
    setShowBookingModal(false);
    setSelectedRoom(null);
  };

  const handleCancelBooking = (bookingId: string) => {
    toast.success("Booking cancelled successfully");
  };

  const availableRooms = STUDY_ROOMS.filter(room => room.available);
  const occupiedRooms = STUDY_ROOMS.filter(room => !room.available);

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Premium Header */}
      <div 
        className="text-white p-4 pb-8"
        style={{
          background: studentColors.gradient,
          boxShadow: premiumShadows.primaryGlow,
        }}
      >
        <div className="flex items-center gap-3 mb-6">
          <button 
            onClick={onBack} 
            className="p-2 hover:bg-white/10 rounded-lg transition-colors"
          >
            <ArrowLeft className="h-5 w-5" />
          </button>
          <div className="flex-1">
            <h1 className="text-xl font-semibold">Study Rooms</h1>
            <p className="text-xs opacity-90 mt-0.5">Book Your Study Space</p>
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-3 gap-3 bg-white/10 backdrop-blur-sm rounded-2xl p-4">
          <div className="text-center">
            <p className="text-2xl font-bold mb-1">{availableRooms.length}</p>
            <p className="text-xs opacity-90">Available</p>
          </div>
          <div className="text-center border-x border-white/20">
            <p className="text-2xl font-bold mb-1">{MY_BOOKINGS.filter(b => b.status === "active").length}</p>
            <p className="text-xs opacity-90">Active</p>
          </div>
          <div className="text-center">
            <p className="text-2xl font-bold mb-1">{STUDY_ROOMS.length}</p>
            <p className="text-xs opacity-90">Total Rooms</p>
          </div>
        </div>
      </div>

      <div className="p-4 space-y-4">
        {/* Tabs */}
        <div className="flex gap-2">
          <button
            onClick={() => setSelectedTab("available")}
            className={`flex-1 py-3 rounded-xl font-semibold transition-all ${
              selectedTab === "available"
                ? 'text-white shadow-lg'
                : 'bg-muted hover:bg-muted/80'
            }`}
            style={selectedTab === "available" ? {
              background: studentColors.gradient,
              boxShadow: premiumShadows.sm,
            } : {}}
          >
            Available Rooms
          </button>
          <button
            onClick={() => setSelectedTab("bookings")}
            className={`flex-1 py-3 rounded-xl font-semibold transition-all ${
              selectedTab === "bookings"
                ? 'text-white shadow-lg'
                : 'bg-muted hover:bg-muted/80'
            }`}
            style={selectedTab === "bookings" ? {
              background: studentColors.gradient,
              boxShadow: premiumShadows.sm,
            } : {}}
          >
            My Bookings ({MY_BOOKINGS.length})
          </button>
        </div>

        {/* Available Rooms Tab */}
        {selectedTab === "available" && (
          <div className="space-y-4">
            {/* Available Rooms */}
            <div className="space-y-3">
              <h2 className="font-semibold">Available Now</h2>
              {availableRooms.map((room) => (
                <Card
                  key={room.id}
                  className="p-4 border-0 hover:shadow-xl transition-all"
                  style={{ boxShadow: premiumShadows.md }}
                >
                  <div className="flex items-start justify-between gap-3 mb-3">
                    <div className="flex items-start gap-3 flex-1">
                      <div 
                        className="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
                        style={{ 
                          background: `linear-gradient(135deg, ${premiumColors.success[600]} 0%, ${premiumColors.success[500]} 100%)`,
                          boxShadow: premiumShadows.sm,
                        }}
                      >
                        <BookOpen className="h-6 w-6 text-white" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold text-base mb-1">{room.name}</h3>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground">
                          <MapPin className="h-3 w-3" />
                          <span>{room.floor}</span>
                        </div>
                      </div>
                    </div>
                    <Badge variant="outline" className="whitespace-nowrap" style={{ borderColor: premiumColors.success[600], color: premiumColors.success[600] }}>
                      Available
                    </Badge>
                  </div>

                  <div className="space-y-2 mb-3">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2 text-sm">
                        <Users className="h-4 w-4 text-muted-foreground" />
                        <span className="text-muted-foreground">Capacity:</span>
                        <span className="font-semibold">{room.capacity} people</span>
                      </div>
                      <div className="text-sm">
                        <span className="font-semibold" style={{ color: premiumColors.primary[600] }}>
                          {room.currentOccupancy}/{room.capacity}
                        </span>
                        <span className="text-muted-foreground ml-1">occupied</span>
                      </div>
                    </div>
                    
                    <div className="flex flex-wrap gap-1.5">
                      {room.amenities.map((amenity, idx) => (
                        <Badge key={idx} variant="secondary" className="text-xs">
                          {amenity}
                        </Badge>
                      ))}
                    </div>
                  </div>

                  <Button 
                    className="w-full"
                    style={{
                      background: studentColors.gradient,
                      boxShadow: premiumShadows.sm,
                    }}
                    onClick={() => handleBookRoom(room)}
                  >
                    <Calendar className="h-4 w-4 mr-2" />
                    Book This Room
                  </Button>
                </Card>
              ))}
            </div>

            {/* Occupied Rooms */}
            {occupiedRooms.length > 0 && (
              <div className="space-y-3">
                <h2 className="font-semibold text-muted-foreground">Currently Occupied</h2>
                {occupiedRooms.map((room) => (
                  <Card
                    key={room.id}
                    className="p-4 border-0 opacity-75"
                    style={{ boxShadow: premiumShadows.sm }}
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex items-start gap-3 flex-1">
                        <div className="w-12 h-12 rounded-xl bg-muted flex items-center justify-center flex-shrink-0">
                          <BookOpen className="h-6 w-6 text-muted-foreground" />
                        </div>
                        <div className="flex-1 min-w-0">
                          <h3 className="font-semibold text-base mb-1">{room.name}</h3>
                          <div className="flex items-center gap-2 text-xs text-muted-foreground mb-2">
                            <MapPin className="h-3 w-3" />
                            <span>{room.floor}</span>
                          </div>
                          {room.nextAvailable && (
                            <div className="flex items-center gap-2 text-xs">
                              <Clock className="h-3 w-3" style={{ color: premiumColors.warning[600] }} />
                              <span className="text-muted-foreground">Available at</span>
                              <span className="font-semibold" style={{ color: premiumColors.warning[600] }}>
                                {room.nextAvailable}
                              </span>
                            </div>
                          )}
                        </div>
                      </div>
                      <Badge variant="outline" className="whitespace-nowrap" style={{ borderColor: premiumColors.error[600], color: premiumColors.error[600] }}>
                        Full
                      </Badge>
                    </div>
                  </Card>
                ))}
              </div>
            )}
          </div>
        )}

        {/* My Bookings Tab */}
        {selectedTab === "bookings" && (
          <div className="space-y-3">
            <h2 className="font-semibold">Your Bookings</h2>
            {MY_BOOKINGS.map((booking) => (
              <Card
                key={booking.id}
                className="p-4 border-0 hover:shadow-xl transition-all"
                style={{ boxShadow: premiumShadows.md }}
              >
                <div className="flex items-start justify-between gap-3 mb-3">
                  <div className="flex items-start gap-3 flex-1">
                    <div 
                      className="w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0"
                      style={{ 
                        background: booking.status === "active" 
                          ? `linear-gradient(135deg, ${premiumColors.success[600]} 0%, ${premiumColors.success[500]} 100%)`
                          : `linear-gradient(135deg, ${premiumColors.primary[600]} 0%, ${premiumColors.primary[500]} 100%)`,
                        boxShadow: premiumShadows.sm,
                      }}
                    >
                      <BookOpen className="h-6 w-6 text-white" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-base mb-1">{booking.roomName}</h3>
                      <div className="flex items-center gap-2 text-xs text-muted-foreground">
                        <Calendar className="h-3 w-3" />
                        <span>{booking.date}</span>
                      </div>
                    </div>
                  </div>
                  <Badge 
                    variant="outline" 
                    className="whitespace-nowrap" 
                    style={{ 
                      borderColor: booking.status === "active" ? premiumColors.success[600] : premiumColors.primary[600],
                      color: booking.status === "active" ? premiumColors.success[600] : premiumColors.primary[600]
                    }}
                  >
                    {booking.status === "active" ? "Active" : "Upcoming"}
                  </Badge>
                </div>

                <div className="flex items-center gap-2 text-sm mb-3">
                  <Clock className="h-4 w-4 text-muted-foreground" />
                  <span className="text-muted-foreground">Time:</span>
                  <span className="font-semibold">{booking.startTime} - {booking.endTime}</span>
                </div>

                <Button 
                  variant="outline" 
                  className="w-full"
                  onClick={() => handleCancelBooking(booking.id)}
                  style={{ borderColor: premiumColors.error[600], color: premiumColors.error[600] }}
                >
                  <X className="h-4 w-4 mr-2" />
                  Cancel Booking
                </Button>
              </Card>
            ))}
          </div>
        )}
      </div>

      {/* Booking Modal */}
      {showBookingModal && selectedRoom && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50">
          <Card className="w-full max-w-md p-6 border-0" style={{ boxShadow: premiumShadows.xl }}>
            <h2 className="text-xl font-bold mb-4">Book {selectedRoom.name}</h2>
            
            <div className="space-y-4 mb-6">
              <div>
                <label className="text-sm text-muted-foreground mb-2 block">Date</label>
                <input 
                  type="date" 
                  className="w-full p-3 border rounded-xl"
                  defaultValue={new Date().toISOString().split('T')[0]}
                />
              </div>
              
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="text-sm text-muted-foreground mb-2 block">Start Time</label>
                  <input 
                    type="time" 
                    className="w-full p-3 border rounded-xl"
                    defaultValue="14:00"
                  />
                </div>
                <div>
                  <label className="text-sm text-muted-foreground mb-2 block">End Time</label>
                  <input 
                    type="time" 
                    className="w-full p-3 border rounded-xl"
                    defaultValue="16:00"
                  />
                </div>
              </div>

              <div>
                <label className="text-sm text-muted-foreground mb-2 block">Purpose (Optional)</label>
                <textarea 
                  className="w-full p-3 border rounded-xl resize-none"
                  rows={3}
                  placeholder="Group study, project work, etc."
                />
              </div>
            </div>

            <div className="flex gap-3">
              <Button 
                variant="outline" 
                className="flex-1"
                onClick={() => setShowBookingModal(false)}
              >
                Cancel
              </Button>
              <Button 
                className="flex-1"
                style={{
                  background: studentColors.gradient,
                  boxShadow: premiumShadows.sm,
                }}
                onClick={handleConfirmBooking}
              >
                <Check className="h-4 w-4 mr-2" />
                Confirm
              </Button>
            </div>
          </Card>
        </div>
      )}
    </div>
  );
}
