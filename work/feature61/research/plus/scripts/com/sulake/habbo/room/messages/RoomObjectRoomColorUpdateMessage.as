package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectRoomColorUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const BACKGROUND_COLOR:String = "RORCUM_BACKGROUND_COLOR";
      
      private var _type:String = "";
      
      private var _color:uint = 0;
      
      private var _light:int = 0;
      
      private var _bgOnly:Boolean = true;
      
      public function RoomObjectRoomColorUpdateMessage(param1:String, param2:uint, param3:int, param4:Boolean)
      {
         super(null,null);
         _type = param1;
         _color = param2;
         _light = param3;
         _bgOnly = param4;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get light() : uint
      {
         return _light;
      }
      
      public function get bgOnly() : Boolean
      {
         return _bgOnly;
      }
   }
}

