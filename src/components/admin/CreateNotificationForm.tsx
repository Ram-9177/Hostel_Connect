import React, { useState } from 'react';
import { toast } from 'react-hot-toast';

interface CreateNotificationFormProps {
  token: string;
}

interface Hostel {
  id: string;
  name: string;
}

interface Block {
  id: string;
  name: string;
}

interface Room {
  id: string;
  roomNumber: string;
}

const CreateNotificationForm: React.FC<CreateNotificationFormProps> = ({ token }) => {
  const [formData, setFormData] = useState({
    title: '',
    body: '',
    type: 'announcement',
    priority: 'medium',
    targetType: 'all',
    hostelId: '',
    blockId: '',
    floor: '',
    roomId: '',
  });

  const [hostels, setHostels] = useState<Hostel[]>([]);
  const [blocks, setBlocks] = useState<Block[]>([]);
  const [rooms, setRooms] = useState<Room[]>([]);
  const [loading, setLoading] = useState(false);

  // Fetch hostels on mount
  React.useEffect(() => {
    fetchHostels();
  }, []);

  const fetchHostels = async () => {
    try {
      const response = await fetch('/api/v1/hostels', {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await response.json();
      setHostels(data);
    } catch (error) {
      console.error('Failed to fetch hostels:', error);
    }
  };

  const fetchBlocks = async (hostelId: string) => {
    try {
      const response = await fetch(`/api/v1/hostels/${hostelId}/blocks`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await response.json();
      setBlocks(data);
    } catch (error) {
      console.error('Failed to fetch blocks:', error);
    }
  };

  const fetchRooms = async (blockId: string) => {
    try {
      const response = await fetch(`/api/v1/rooms?blockId=${blockId}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      const data = await response.json();
      setRooms(data);
    } catch (error) {
      console.error('Failed to fetch rooms:', error);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.title || !formData.body) {
      toast.error('Please fill in all required fields');
      return;
    }

    setLoading(true);

    try {
      const payload: any = {
        title: formData.title,
        body: formData.body,
        type: formData.type,
        priority: formData.priority,
        targetType: formData.targetType,
      };

      // Add conditional fields based on target type
      if (formData.targetType === 'hostel' || formData.targetType === 'block' || formData.targetType === 'floor') {
        payload.hostelId = formData.hostelId;
      }

      if (formData.targetType === 'block' || formData.targetType === 'floor') {
        payload.blockId = formData.blockId;
      }

      if (formData.targetType === 'floor') {
        payload.floor = parseInt(formData.floor);
      }

      if (formData.targetType === 'room') {
        payload.roomId = formData.roomId;
      }

      const response = await fetch('/api/v1/notifications/send-targeted', {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });

      if (!response.ok) {
        throw new Error('Failed to send notification');
      }

      const result = await response.json();
      toast.success(result.message);

      // Reset form
      setFormData({
        title: '',
        body: '',
        type: 'announcement',
        priority: 'medium',
        targetType: 'all',
        hostelId: '',
        blockId: '',
        floor: '',
        roomId: '',
      });
    } catch (error) {
      toast.error('Failed to send notification');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const handleTargetTypeChange = (targetType: string) => {
    setFormData({
      ...formData,
      targetType,
      hostelId: '',
      blockId: '',
      floor: '',
      roomId: '',
    });
    setBlocks([]);
    setRooms([]);
  };

  const handleHostelChange = (hostelId: string) => {
    setFormData({ ...formData, hostelId, blockId: '', floor: '', roomId: '' });
    if (hostelId) {
      fetchBlocks(hostelId);
    }
    setRooms([]);
  };

  const handleBlockChange = (blockId: string) => {
    setFormData({ ...formData, blockId, floor: '', roomId: '' });
    if (blockId) {
      fetchRooms(blockId);
    }
  };

  return (
    <div className="max-w-2xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      <h2 className="text-2xl font-bold mb-6 text-gray-800">Create Notification</h2>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Title */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Title *
          </label>
          <input
            type="text"
            value={formData.title}
            onChange={(e) => setFormData({ ...formData, title: e.target.value })}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            placeholder="Enter notification title"
            required
          />
        </div>

        {/* Body */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Message *
          </label>
          <textarea
            value={formData.body}
            onChange={(e) => setFormData({ ...formData, body: e.target.value })}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            placeholder="Enter notification message"
            rows={4}
            required
          />
        </div>

        {/* Type and Priority */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Type
            </label>
            <select
              value={formData.type}
              onChange={(e) => setFormData({ ...formData, type: e.target.value })}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="announcement">Announcement</option>
              <option value="notice">Notice</option>
              <option value="system">System</option>
              <option value="meal_intent">Meal Intent</option>
              <option value="gate_pass">Gate Pass</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Priority
            </label>
            <select
              value={formData.priority}
              onChange={(e) => setFormData({ ...formData, priority: e.target.value })}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="low">Low</option>
              <option value="medium">Medium</option>
              <option value="high">High</option>
              <option value="urgent">Urgent</option>
            </select>
          </div>
        </div>

        {/* Target Type */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Send To
          </label>
          <select
            value={formData.targetType}
            onChange={(e) => handleTargetTypeChange(e.target.value)}
            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          >
            <option value="all">All Students</option>
            <option value="hostel">Specific Hostel</option>
            <option value="block">Specific Block</option>
            <option value="floor">Specific Floor</option>
            <option value="room">Specific Room</option>
          </select>
        </div>

        {/* Conditional fields based on target type */}
        {(formData.targetType === 'hostel' || formData.targetType === 'block' || formData.targetType === 'floor') && (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Select Hostel
            </label>
            <select
              value={formData.hostelId}
              onChange={(e) => handleHostelChange(e.target.value)}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              required
            >
              <option value="">-- Select Hostel --</option>
              {hostels.map((hostel) => (
                <option key={hostel.id} value={hostel.id}>
                  {hostel.name}
                </option>
              ))}
            </select>
          </div>
        )}

        {(formData.targetType === 'block' || formData.targetType === 'floor') && formData.hostelId && (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Select Block
            </label>
            <select
              value={formData.blockId}
              onChange={(e) => handleBlockChange(e.target.value)}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              required
            >
              <option value="">-- Select Block --</option>
              {blocks.map((block) => (
                <option key={block.id} value={block.id}>
                  {block.name}
                </option>
              ))}
            </select>
          </div>
        )}

        {formData.targetType === 'floor' && formData.blockId && (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Floor Number
            </label>
            <input
              type="number"
              value={formData.floor}
              onChange={(e) => setFormData({ ...formData, floor: e.target.value })}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              placeholder="Enter floor number"
              min="0"
              required
            />
          </div>
        )}

        {formData.targetType === 'room' && (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Select Room
            </label>
            <select
              value={formData.roomId}
              onChange={(e) => setFormData({ ...formData, roomId: e.target.value })}
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              required
            >
              <option value="">-- Select Room --</option>
              {rooms.map((room) => (
                <option key={room.id} value={room.id}>
                  Room {room.roomNumber}
                </option>
              ))}
            </select>
          </div>
        )}

        {/* Submit Button */}
        <button
          type="submit"
          disabled={loading}
          className="w-full bg-blue-600 text-white py-3 px-4 rounded-lg hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed transition-colors font-medium"
        >
          {loading ? 'Sending...' : 'Send Notification'}
        </button>
      </form>
    </div>
  );
};

export default CreateNotificationForm;
