package §_-2mk§
{
   import §_-0AB§.§_-4hO§;
   import §_-0VW§.§_-1Gb§;
   import §_-0gs§.§_-Pr§;
   import §_-0sg§.§_-2LR§;
   import §_-0sg§.§_-4RT§;
   import §_-2C1§.§_-0Rb§;
   import §_-2RC§.§_-02u§;
   import §_-2RC§.§_-4YX§;
   
   public class §_-0we§ extends §_-2NW§
   {
      
      private var §_-1un§:Boolean = false;
      
      public function §_-0we§()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_BACKGROUND_COLOR","ROHSLCEE_ROOM_BACKGROUND_COLOR"];
         return §_-26y§(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:§_-0Rb§) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:§_-Pr§ = param1 as §_-Pr§;
         if(_loc2_ != null && _loc2_.data != null)
         {
            _loc2_.data.writeRoomObjectModel(object.getModelController());
            if(object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               §_-Sc§();
            }
         }
      }
      
      private function §_-Sc§() : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc2_:§_-1Gb§ = new §_-1Gb§();
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
               eventDispatcher.dispatchEvent(new §_-4RT§("ROHSLCEE_ROOM_BACKGROUND_COLOR",object,Boolean(_loc5_),_loc4_,_loc1_,_loc3_));
            }
            §_-1un§ = true;
         }
      }
      
      override public function dispose() : void
      {
         if(§_-1un§)
         {
            if(eventDispatcher != null && object != null)
            {
               if(object.getModelController().getNumber("furniture_real_room_object") == 1)
               {
                  eventDispatcher.dispatchEvent(new §_-4RT§("ROHSLCEE_ROOM_BACKGROUND_COLOR",object,false,0,0,0));
               }
            }
            §_-1un§ = false;
         }
         super.dispose();
      }
      
      override public function mouseEvent(param1:§_-02u§, param2:§_-4hO§) : void
      {
         var _loc3_:§_-4YX§ = null;
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
            _loc3_ = new §_-2LR§("ROWRE_BACKGROUND_COLOR",object);
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}

