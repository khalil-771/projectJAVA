-- Run this to update your multiplayer schema
USE quiztests;

-- Add time_taken column if it doesn't exist
ALTER TABLE room_players ADD COLUMN IF NOT EXISTS time_taken INT DEFAULT 0;
