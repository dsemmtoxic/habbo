package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.IntArrayStuffData;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureRoomBackgroundColorLogic extends FurnitureMultiStateLogic
   {
      
      private var UnknownVarFromFurnitureRoomBackgroundColorLogic_Boolean_1:Boolean = false;
      
      public function FurnitureRoomBackgroundColorLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_BACKGROUND_COLOR","ROHSLCEE_ROOM_BACKGROUND_COLOR"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null && _loc2_.data != null)
         {
            _loc2_.data.writeRoomObjectModel(object.getModelController());
            if(object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               setupObject();
            }
         }
      }
      
      private function setupObject() : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc2_:IntArrayStuffData = new IntArrayStuffData();
         _loc2_.initializeFromRoomObjectModel(object.getModel());
         var _loc5_:int = _loc2_.getValue(0);
         var _loc4_:int = _loc2_.getValue(1);
         var _loc1_:int = _loc2_.getValue(2);
         var _loc3_:int = _loc2_.getValue(3);
         if(_loc5_ > -1 && _loc4_ > -1 && _loc1_ > -1 && _loc3_ > -1)
         {
            object.getModelController().setNumber("furniture_room_background_color_hue",_loc4_);
            object.getModelController().setNumber("furniture_room_background_color_saturation",_loc1_);
            object.getModelController().setNumber("furniture_room_background_color_lightness",_loc3_);
            object.setState(_loc5_,0);
            if(eventDispatcher != null && object != null)
            {
               eventDispatcher.dispatchEvent(new RoomObjectHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR",object,Boolean(_loc5_),_loc4_,_loc1_,_loc3_));
            }
            UnknownVarFromFurnitureRoomBackgroundColorLogic_Boolean_1 = true;
         }
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromFurnitureRoomBackgroundColorLogic_Boolean_1)
         {
            if(eventDispatcher != null && object != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR",object,false,0,0,0));
               }
            }
            UnknownVarFromFurnitureRoomBackgroundColorLogic_Boolean_1 = false;
         }
         super.dispose();
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:RoomObjectEvent = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:String = param1.type;
         if("doubleClick" !== _loc4_)
         {
            super.mouseEvent(param1,param2);
         }
         else if(eventDispatcher != null && object != null)
         {
            _loc3_ = new RoomObjectWidgetRequestEvent("ROWRE_BACKGROUND_COLOR",object);
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}

