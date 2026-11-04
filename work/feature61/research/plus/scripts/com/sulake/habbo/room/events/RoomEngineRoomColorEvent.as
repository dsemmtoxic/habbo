package com.sulake.habbo.room.events
{
   public class RoomEngineRoomColorEvent extends RoomEngineEvent
   {
      
      public static const ROOM_COLOR:String = "REE_ROOM_COLOR";
      
      private var _color:uint;
      
      private var _brightness:uint;
      
      private var _bgOnly:Boolean;
      
      public function RoomEngineRoomColorEvent(param1:int, param2:uint, param3:uint, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super("REE_ROOM_COLOR",param1,param5,param6);
         _color = param2;
         _brightness = param3;
         _bgOnly = param4;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return _brightness;
      }
      
      public function get bgOnly() : Boolean
      {
         return _bgOnly;
      }
   }
}

