import { useState } from "react";
import { ArrowLeft, Users, RefreshCw, History, Square } from "lucide-react";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../ui/tabs";
import { Badge } from "../ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "../ui/dialog";
import { UpdatedTime } from "../UpdatedTime";

interface RoomsProps {
  onBack: () => void;
}

export function Rooms({ onBack }: RoomsProps) {
  const [selectedRoom, setSelectedRoom] = useState<any>(null);
  const [showHistory, setShowHistory] = useState(false);

  // Generate room data
  const floors = [1, 2, 3];
  const roomsPerFloor = 20;

  const getRoomStatus = () => {
    const rand = Math.random();
    if (rand < 0.6) return "occupied";
    if (rand < 0.85) return "vacant";
    return "blocked";
  };

  const rooms = floors.flatMap((floor) =>
    Array.from({ length: roomsPerFloor }).map((_, i) => ({
      number: `${floor}${String(i + 1).padStart(2, "0")}`,
      floor,
      status: getRoomStatus(),
      occupants: Math.floor(Math.random() * 3) + 1,
      capacity: 3,
    }))
  );

  const getStatusColor = (status: string) => {
    switch (status) {
      case "vacant":
        return "bg-green-500";
      case "occupied":
        return "bg-blue-500";
      case "blocked":
        return "bg-red-500";
      default:
        return "bg-gray-500";
    }
  };

  const getStatusLabel = (status: string) => {
    switch (status) {
      case "vacant":
        return "Vacant";
      case "occupied":
        return "Occupied";
      case "blocked":
        return "Blocked";
      default:
        return "Unknown";
    }
  };

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Header */}
      <div className="bg-gradient-to-r from-secondary to-primary text-white p-4 flex items-center gap-3 shadow-sm">
        <button onClick={onBack} className="p-1">
          <ArrowLeft className="h-5 w-5" />
        </button>
        <h1 className="text-xl">Rooms & Allotment</h1>
      </div>

      <div className="p-4">
        <Tabs defaultValue="floor1" className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-4">
            <TabsTrigger value="floor1">Floor 1</TabsTrigger>
            <TabsTrigger value="floor2">Floor 2</TabsTrigger>
            <TabsTrigger value="floor3">Floor 3</TabsTrigger>
          </TabsList>

          {floors.map((floor) => (
            <TabsContent key={floor} value={`floor${floor}`} className="space-y-4">
              <div className="flex items-center justify-between">
                <h3>Floor {floor}</h3>
                <UpdatedTime />
              </div>

              {/* Statistics */}
              <div className="grid grid-cols-3 gap-3">
                <Card className="p-3 text-center border-0 shadow-sm">
                  <div className="w-3 h-3 bg-green-500 rounded-full mx-auto mb-2" />
                  <p className="text-xl">
                    {rooms.filter((r) => r.floor === floor && r.status === "vacant").length}
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">Vacant</p>
                </Card>

                <Card className="p-3 text-center border-0 shadow-sm">
                  <div className="w-3 h-3 bg-blue-500 rounded-full mx-auto mb-2" />
                  <p className="text-xl">
                    {rooms.filter((r) => r.floor === floor && r.status === "occupied").length}
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">Occupied</p>
                </Card>

                <Card className="p-3 text-center border-0 shadow-sm">
                  <div className="w-3 h-3 bg-red-500 rounded-full mx-auto mb-2" />
                  <p className="text-xl">
                    {rooms.filter((r) => r.floor === floor && r.status === "blocked").length}
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">Blocked</p>
                </Card>
              </div>

              {/* Room Grid */}
              <Card className="p-4 border-0 shadow-sm">
                <div className="grid grid-cols-5 gap-2">
                  {rooms
                    .filter((room) => room.floor === floor)
                    .map((room) => (
                      <button
                        key={room.number}
                        onClick={() => setSelectedRoom(room)}
                        className={`aspect-square rounded-lg ${getStatusColor(
                          room.status
                        )} text-white flex flex-col items-center justify-center text-xs hover:opacity-80 transition-opacity`}
                      >
                        <span>{room.number}</span>
                        {room.status === "occupied" && (
                          <span className="text-[10px] mt-0.5">
                            {room.occupants}/{room.capacity}
                          </span>
                        )}
                      </button>
                    ))}
                </div>
              </Card>

              {/* Actions */}
              <div className="grid grid-cols-2 gap-3">
                <Button variant="outline" className="w-full">
                  <Users className="h-4 w-4 mr-2" />
                  Allocate
                </Button>
                <Button variant="outline" className="w-full">
                  <RefreshCw className="h-4 w-4 mr-2" />
                  Swap
                </Button>
              </div>
            </TabsContent>
          ))}
        </Tabs>

        {/* Legend */}
        <Card className="p-4 mt-4 border-0 shadow-sm">
          <h4 className="mb-3">Legend</h4>
          <div className="space-y-2">
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 bg-green-500 rounded" />
              <span className="text-sm">Vacant - Available for allocation</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 bg-blue-500 rounded" />
              <span className="text-sm">Occupied - Currently allotted</span>
            </div>
            <div className="flex items-center gap-2">
              <div className="w-4 h-4 bg-red-500 rounded" />
              <span className="text-sm">Blocked - Under maintenance</span>
            </div>
          </div>
        </Card>
      </div>

      {/* Room Details Dialog */}
      <Dialog open={!!selectedRoom} onOpenChange={() => setSelectedRoom(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Room {selectedRoom?.number}</DialogTitle>
          </DialogHeader>

          {selectedRoom && (
            <div className="space-y-4">
              <div className="flex items-center gap-2">
                <Badge className={getStatusColor(selectedRoom.status) + " text-white"}>
                  {getStatusLabel(selectedRoom.status)}
                </Badge>
              </div>

              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Floor:</span>
                  <span>Floor {selectedRoom.floor}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Capacity:</span>
                  <span>{selectedRoom.capacity} students</span>
                </div>
                {selectedRoom.status === "occupied" && (
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Current Occupants:</span>
                    <span>{selectedRoom.occupants} students</span>
                  </div>
                )}
              </div>

              {selectedRoom.status === "occupied" && (
                <div className="space-y-2">
                  <h4 className="text-sm">Students</h4>
                  <div className="space-y-2">
                    {Array.from({ length: selectedRoom.occupants }).map((_, i) => (
                      <div
                        key={i}
                        className="flex items-center gap-3 p-2 bg-muted/30 rounded-lg"
                      >
                        <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center">
                          <Users className="h-4 w-4 text-primary" />
                        </div>
                        <div className="flex-1">
                          <p className="text-sm">Student {i + 1}</p>
                          <p className="text-xs text-muted-foreground">
                            Since Jan 2025
                          </p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              <Button
                onClick={() => setShowHistory(true)}
                variant="outline"
                className="w-full"
              >
                <History className="h-4 w-4 mr-2" />
                View History
              </Button>

              {selectedRoom.status === "vacant" && (
                <Button className="w-full bg-primary hover:bg-primary/90">
                  Allocate Room
                </Button>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
