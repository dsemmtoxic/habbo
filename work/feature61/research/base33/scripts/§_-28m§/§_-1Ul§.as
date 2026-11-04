package §_-28m§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-0By§;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-0Ee§.§_-0WM§;
   import §_-0Ee§.§_-3Yc§;
   import §_-0Ee§.§_-4fX§;
   import §_-0Ee§.§_-Jq§;
   import §_-0gs§.§_-1Ja§;
   import §_-0gs§.§_-1Ry§;
   import §_-0gs§.§_-1cl§;
   import §_-0gs§.§_-35-§;
   import §_-0gs§.§_-4jr§;
   import §_-0gs§.§import§;
   import §_-0sg§.§_-08p§;
   import §_-0sg§.§_-2S8§;
   import §_-0sg§.§_-2oq§;
   import §_-1iL§.§_-K-§;
   import §_-2C1§.§_-0Rb§;
   import §_-2RC§.§_-02u§;
   import §_-2RC§.§_-4YX§;
   import §_-aS§.§_-2rZ§;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import loginpatch.HabboTicketLogin;
   
   public class §_-1Ul§ extends §_-2rZ§
   {
      
      protected var §_-1fh§:§_-4fX§ = null;
      
      private var §_-uN§:§_-0WM§ = null;
      
      private var _color:uint = 16777215;
      
      private var §_-1Nk§:int = 255;
      
      private var §_-9T§:uint = 16777215;
      
      private var §_-tT§:int = 255;
      
      private var §_-4Bm§:uint = 16777215;
      
      private var §_-05q§:int = 255;
      
      private var §_-0wN§:int = 0;
      
      private var §_-4Zq§:int = 1500;
      
      private var §_-38R§:Boolean;
      
      public function §_-1Ul§()
      {
         super();
         §_-1fh§ = new §_-4fX§();
         §_-uN§ = new §_-0WM§();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROE_MOUSE_MOVE","ROE_MOUSE_CLICK"];
         return §_-26y§(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(§_-1fh§ != null)
         {
            §_-1fh§.dispose();
            §_-1fh§ = null;
         }
         if(§_-uN§ != null)
         {
            §_-uN§.dispose();
            §_-uN§ = null;
         }
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc2_:§_-3gO§ = null;
         if(param1 == null || object == null)
         {
            return;
         }
         if(!§_-1fh§.§_-2lo§(param1))
         {
            return;
         }
         var _loc3_:§_-K-§ = object.getModel() as §_-K-§;
         if(_loc3_ != null)
         {
            _loc3_.setString("room_plane_xml",param1.toString());
            _loc3_.setNumber("room_background_color",16777215);
            _loc3_.setNumber("room_floor_visibility",1);
            _loc3_.setNumber("room_wall_visibility",1);
            _loc3_.setNumber("room_landscape_visibility",1);
            _loc2_ = §_-1fh§.§_-0Iu§();
            _loc3_.setNumberArray("room_floor_center",[_loc2_.x,_loc2_.y,_loc2_.z]);
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc3_:§_-K-§ = null;
         var _loc2_:XML = null;
         super.update(param1);
         §_-4cM§(param1);
         if(§_-38R§)
         {
            if(object != null)
            {
               _loc3_ = object.getModel() as §_-K-§;
               if(_loc3_ != null)
               {
                  _loc2_ = §_-1fh§.§_-0k5§();
                  _loc3_.setString("room_plane_xml",_loc2_.toString());
                  _loc3_.setNumber("room_floor_hole_update_time",param1);
                  §_-1fh§.§_-2lo§(_loc2_);
               }
            }
            §_-38R§ = false;
         }
      }
      
      private function §_-4cM§(param1:int) : void
      {
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:int = 0;
         var _loc7_:int = 0;
         var _loc13_:Number = NaN;
         var _loc2_:int = 0;
         var _loc10_:§_-K-§ = null;
         if(object == null)
         {
            return;
         }
         if(§_-0wN§)
         {
            _loc11_ = param1;
            _loc5_ = int(_color);
            _loc9_ = §_-1Nk§;
            if(_loc11_ - §_-0wN§ >= §_-4Zq§)
            {
               _loc5_ = int(§_-4Bm§);
               _loc9_ = §_-05q§;
               §_-0wN§ = 0;
            }
            else
            {
               _loc6_ = §_-9T§ >> 16 & 0xFF;
               _loc3_ = §_-9T§ >> 8 & 0xFF;
               _loc8_ = §_-9T§ & 0xFF;
               _loc4_ = §_-4Bm§ >> 16 & 0xFF;
               _loc12_ = §_-4Bm§ >> 8 & 0xFF;
               _loc7_ = §_-4Bm§ & 0xFF;
               _loc13_ = (_loc11_ - §_-0wN§) / §_-4Zq§;
               _loc6_ += (_loc4_ - _loc6_) * _loc13_;
               _loc3_ += (_loc12_ - _loc3_) * _loc13_;
               _loc8_ += (_loc7_ - _loc8_) * _loc13_;
               _loc5_ = (_loc6_ << 16) + (_loc3_ << 8) + _loc8_;
               _loc9_ = §_-tT§ + (§_-05q§ - §_-tT§) * _loc13_;
               _color = _loc5_;
               §_-1Nk§ = _loc9_;
            }
            _loc2_ = §_-0By§.§_-4Vh§(_loc5_);
            _loc2_ = (_loc2_ & 0xFFFF00) + _loc9_;
            _loc5_ = §_-0By§.§_-1Bw§(_loc2_);
            _loc10_ = object.getModel() as §_-K-§;
            if(_loc10_ == null)
            {
               return;
            }
            _loc10_.setNumber("room_background_color",_loc5_);
         }
      }
      
      private function §_-0Uq§(param1:§_-4jr§, param2:§_-K-§) : void
      {
         switch(param1.type)
         {
            case "RORUM_ROOM_FLOOR_UPDATE":
               param2.setString("room_floor_type",param1.value);
               break;
            case "RORUM_ROOM_WALL_UPDATE":
               param2.setString("room_wall_type",param1.value);
               break;
            case "RORUM_ROOM_LANDSCAPE_UPDATE":
               param2.setString("room_landscape_type",param1.value);
         }
      }
      
      private function §_-3uS§(param1:§_-1cl§, param2:§_-K-§) : void
      {
         var _loc7_:String = null;
         var _loc6_:XML = null;
         var _loc4_:String = null;
         var _loc5_:§_-Jq§ = null;
         var _loc3_:Boolean = false;
         switch(param1.type)
         {
            case "RORMUM_ADD_MASK":
               _loc7_ = "window";
               if(param1.§_-4A9§ == "hole")
               {
                  _loc7_ = "hole";
               }
               §_-uN§.addMask(param1.§_-4VP§,param1.§_-0K3§,param1.§_-1z2§,_loc7_);
               _loc3_ = true;
               break;
            case "RORMUM_ADD_MASK":
               _loc3_ = §_-uN§.§_-4BL§(param1.§_-4VP§);
         }
         if(_loc3_)
         {
            _loc6_ = §_-uN§.§_-0k5§();
            _loc4_ = _loc6_.toXMLString();
            param2.setString("room_plane_mask_xml",_loc4_);
         }
      }
      
      private function §_-2HI§(param1:§_-35-§, param2:§_-K-§) : void
      {
         var _loc3_:int = 0;
         if(param1.visible)
         {
            _loc3_ = 1;
         }
         switch(param1.type)
         {
            case "RORPVUM_FLOOR_VISIBILITY":
               param2.setNumber("room_floor_visibility",_loc3_);
               break;
            case "RORPVUM_WALL_VISIBILITY":
               param2.setNumber("room_wall_visibility",_loc3_);
               param2.setNumber("room_landscape_visibility",_loc3_);
         }
      }
      
      private function §_-2Zu§(param1:§_-1Ja§, param2:§_-K-§) : void
      {
         switch(param1.type)
         {
            case "RORPVUM_FLOOR_THICKNESS":
               param2.setNumber("room_floor_thickness",param1.value);
               break;
            case "RORPPUM_WALL_THICKNESS":
               param2.setNumber("room_wall_thickness",param1.value);
         }
      }
      
      private function §_-0fv§(param1:§_-1Ry§, param2:§_-K-§) : void
      {
         HabboTicketLogin.areaParser32(this.§_-1fh§);
         switch(param1.type)
         {
            case "RORPFHUM_ADD":
               §_-1fh§.§_-as§(param1.id,param1.x,param1.y,param1.width,param1.height);
               §_-38R§ = true;
               break;
            case "RORPFHUM_REMOVE":
               §_-1fh§.§_-3W5§(param1.id);
               §_-38R§ = true;
         }
      }
      
      private function §_-1MB§(param1:§import§, param2:§_-K-§) : void
      {
         var _loc3_:int = int(param1.color);
         var _loc4_:int = int(param1.light);
         param2.setNumber("room_colorize_bg_only",int(param1.§_-0vG§));
         §_-9T§ = _color;
         §_-tT§ = §_-1Nk§;
         §_-4Bm§ = _loc3_;
         §_-05q§ = _loc4_;
         §_-0wN§ = getTimer();
         §_-4Zq§ = 1500;
      }
      
      override public function processUpdateMessage(param1:§_-0Rb§) : void
      {
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc5_:§_-K-§ = object.getModel() as §_-K-§;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:§_-4jr§ = param1 as §_-4jr§;
         if(_loc3_ != null)
         {
            §_-0Uq§(_loc3_,_loc5_);
            return;
         }
         var _loc2_:§_-1cl§ = param1 as §_-1cl§;
         if(_loc2_ != null)
         {
            §_-3uS§(_loc2_,_loc5_);
            return;
         }
         var _loc6_:§_-35-§ = param1 as §_-35-§;
         if(_loc6_ != null)
         {
            §_-2HI§(_loc6_,_loc5_);
            return;
         }
         var _loc4_:§_-1Ja§ = param1 as §_-1Ja§;
         if(_loc4_ != null)
         {
            §_-2Zu§(_loc4_,_loc5_);
            return;
         }
         var _loc8_:§_-1Ry§ = param1 as §_-1Ry§;
         if(_loc8_ != null)
         {
            §_-0fv§(_loc8_,_loc5_);
         }
         var _loc7_:§import§ = param1 as §import§;
         if(_loc7_ != null)
         {
            §_-1MB§(_loc7_,_loc5_);
            return;
         }
      }
      
      override public function mouseEvent(param1:§_-02u§, param2:§_-4hO§) : void
      {
         var _loc20_:String = null;
         var _loc14_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         if(param2 == null)
         {
            return;
         }
         var _loc7_:§_-02u§ = param1;
         if(_loc7_ == null)
         {
            return;
         }
         if(object == null || param1 == null)
         {
            return;
         }
         var _loc9_:§_-K-§ = object.getModel() as §_-K-§;
         if(_loc9_ == null)
         {
            return;
         }
         var _loc10_:int = 0;
         var _loc11_:String = _loc7_.§_-1kb§;
         if(_loc11_ != null && _loc11_.indexOf("@") >= 0)
         {
            _loc10_ = parseInt(_loc11_.substr(_loc11_.indexOf("@") + 1));
         }
         if(_loc10_ < 1 || _loc10_ > §_-1fh§.§_-3uW§)
         {
            if(param1.type == "rollOut")
            {
               _loc9_.setNumber("room_selected_plane",0);
            }
            return;
         }
         _loc10_ -= 1;
         var _loc15_:Point = null;
         var _loc4_:§_-3gO§ = §_-1fh§.§_-1Ae§(_loc10_);
         var _loc8_:§_-3gO§ = §_-1fh§.§_-0-F§(_loc10_);
         var _loc19_:§_-3gO§ = §_-1fh§.§_-1wo§(_loc10_);
         var _loc25_:§_-3gO§ = §_-1fh§.§_-0Wg§(_loc10_);
         var _loc21_:int = §_-1fh§.§_-i§(_loc10_);
         if(_loc4_ == null || _loc8_ == null || _loc19_ == null || _loc25_ == null)
         {
            return;
         }
         var _loc22_:Number = _loc8_.length;
         var _loc5_:Number = _loc19_.length;
         if(_loc22_ == 0 || _loc5_ == 0)
         {
            return;
         }
         var _loc27_:Number = _loc7_.§_-20b§;
         var _loc28_:Number = _loc7_.§_-1ok§;
         var _loc26_:Point = new Point(_loc27_,_loc28_);
         _loc15_ = param2.§_-4RU§(_loc26_,_loc4_,_loc8_,_loc19_);
         if(_loc15_ == null)
         {
            _loc9_.setNumber("room_selected_plane",0);
            return;
         }
         var _loc3_:Vector3d = Vector3d.product(_loc8_,_loc15_.x / _loc22_);
         _loc3_.add(Vector3d.product(_loc19_,_loc15_.y / _loc5_));
         _loc3_.add(_loc4_);
         var _loc16_:Number = _loc3_.x;
         var _loc17_:Number = _loc3_.y;
         var _loc18_:Number = _loc3_.z;
         if(_loc15_.x >= 0 && _loc15_.x < _loc22_ && _loc15_.y >= 0 && _loc15_.y < _loc5_)
         {
            _loc9_.setNumber("room_selected_x",_loc16_);
            _loc9_.setNumber("room_selected_y",_loc17_);
            _loc9_.setNumber("room_selected_z",_loc18_);
            _loc9_.setNumber("room_selected_plane",_loc10_ + 1);
            var _loc6_:String = "";
            var _loc12_:int = 0;
            var _loc13_:§_-4YX§ = null;
            switch(param1.type)
            {
               case "mouseMove":
               case "rollOver":
               case "click":
                  _loc20_ = "";
                  if(param1.type == "mouseMove" || param1.type == "rollOver")
                  {
                     _loc20_ = "ROE_MOUSE_MOVE";
                  }
                  else if(param1.type == "click")
                  {
                     _loc20_ = "ROE_MOUSE_CLICK";
                  }
                  if(eventDispatcher != null)
                  {
                     if(_loc21_ == 1)
                     {
                        _loc13_ = new §_-2oq§(_loc20_,object,param1.§_-XD§,_loc16_,_loc17_,_loc18_,param1.altKey,param1.ctrlKey,param1.shiftKey);
                     }
                     else if(_loc21_ == 2 || _loc21_ == 3)
                     {
                        _loc14_ = 90;
                        if(_loc25_ != null)
                        {
                           _loc14_ = _loc25_.x + 90;
                           if(_loc14_ > 360)
                           {
                              _loc14_ -= 360;
                           }
                        }
                        _loc23_ = _loc8_.length * _loc15_.x / _loc22_;
                        _loc24_ = _loc19_.length * _loc15_.y / _loc5_;
                        _loc13_ = new §_-2S8§(_loc20_,object,param1.§_-XD§,_loc4_,_loc8_,_loc19_,_loc23_,_loc24_,_loc14_);
                     }
                     if(_loc13_ != null)
                     {
                        eventDispatcher.dispatchEvent(_loc13_);
                     }
                  }
            }
            return;
         }
         _loc9_.setNumber("room_selected_plane",0);
      }
      
      override public function handleRoomTouchAtLocation(param1:Point, param2:§_-4hO§, param3:String) : void
      {
         if(!§_-329§(param1,param2,param3))
         {
            if(!§_-4KA§(param1,param2,param3))
            {
               eventDispatcher.dispatchEvent(new §_-08p§(object));
            }
         }
      }
      
      private function §_-4KA§(param1:Point, param2:§_-4hO§, param3:String) : Boolean
      {
         var _loc7_:Point = null;
         var _loc6_:§_-3gO§ = null;
         var _loc12_:§_-3gO§ = null;
         var _loc11_:§_-3gO§ = null;
         var _loc17_:§_-3gO§ = null;
         var _loc14_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:int = 0;
         var _loc4_:§_-3Yc§ = null;
         var _loc5_:Boolean = false;
         var _loc9_:Vector.<§_-3Yc§> = §_-1fh§.§_-2us§();
         var _loc13_:int = int(_loc9_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc13_)
         {
            _loc4_ = _loc9_[_loc10_];
            if(_loc4_.type == 2)
            {
               _loc6_ = _loc4_.§_-UL§;
               _loc12_ = _loc4_.§_-1Jd§;
               _loc11_ = _loc4_.§_-4Gh§;
               _loc17_ = _loc4_.§_-3NR§;
               _loc14_ = _loc12_.length;
               _loc8_ = _loc11_.length;
               if(!(_loc14_ == 0 || _loc8_ == 0 || _loc6_ == null || _loc12_ == null || _loc11_ == null || _loc17_ == null))
               {
                  _loc7_ = param2.§_-4RU§(param1,_loc6_,_loc12_,_loc11_);
                  if(_loc7_ != null)
                  {
                     if(_loc7_.x >= 0 && _loc7_.x < _loc14_ && _loc7_.y >= 0 && _loc7_.y < _loc8_)
                     {
                        _loc5_ = true;
                        break;
                     }
                  }
               }
            }
            _loc10_++;
         }
         if(!_loc5_)
         {
            return false;
         }
         var _loc19_:Number = 90;
         if(_loc17_ != null)
         {
            _loc19_ = _loc17_.x + 90;
            if(_loc19_ > 360)
            {
               _loc19_ -= 360;
            }
         }
         var _loc15_:Number = _loc12_.length * _loc7_.x / _loc14_;
         var _loc16_:Number = _loc11_.length * _loc7_.y / _loc8_;
         var _loc18_:§_-4YX§ = new §_-2S8§(param3,object,"event_id",_loc6_,_loc12_,_loc11_,_loc15_,_loc16_,_loc19_);
         eventDispatcher.dispatchEvent(_loc18_);
         return true;
      }
      
      public function §_-329§(param1:Point, param2:§_-4hO§, param3:String) : Boolean
      {
         var _loc9_:int = 0;
         var _loc4_:§_-3gO§ = null;
         var _loc6_:§_-3gO§ = null;
         var _loc12_:§_-3gO§ = null;
         var _loc5_:Point = null;
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc7_:int = §_-1fh§.§_-3uW§;
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            if(§_-1fh§.§_-i§(_loc9_) == 1)
            {
               _loc4_ = §_-1fh§.§_-1Ae§(_loc9_);
               _loc6_ = §_-1fh§.§_-0-F§(_loc9_);
               _loc12_ = §_-1fh§.§_-1wo§(_loc9_);
               _loc5_ = param2.§_-4RU§(param1,_loc4_,_loc6_,_loc12_);
               if(_loc5_.x > 0 && _loc5_.x <= _loc6_.length && _loc5_.y > 0 && _loc5_.y <= _loc12_.length)
               {
                  _loc8_ = _loc4_.x - _loc5_.x;
                  _loc10_ = _loc4_.y - _loc5_.y;
                  _loc11_ = _loc4_.z;
                  handleFloorTouchAtTileLocation(_loc8_,_loc10_,_loc11_,param3);
                  return true;
               }
            }
            _loc9_++;
         }
         return false;
      }
      
      override public function handleFloorTouchAtTileLocation(param1:int, param2:int, param3:int, param4:String) : void
      {
         if(HabboTicketLogin.areaTileHit(param1,param2,param3,param4))
         {
            return;
         }
         var _loc5_:§_-4YX§ = new §_-2oq§(param4,object,"event_id",param1,param2,param3);
         eventDispatcher.dispatchEvent(_loc5_);
      }
   }
}

