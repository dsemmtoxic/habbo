package §_-01y§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-1rr§;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-0KT§.§_-4P2§;
   import §_-0Wy§.§_-3CN§;
   import §_-0gs§.§_-0sL§;
   import §_-0gs§.§_-10s§;
   import §_-0gs§.§_-1YS§;
   import §_-0gs§.§_-3Ii§;
   import §_-0gs§.§_-Pr§;
   import §_-0sg§.§_-08p§;
   import §_-0sg§.§_-0Tq§;
   import §_-0sg§.§_-0tm§;
   import §_-0sg§.§_-0us§;
   import §_-0sg§.§_-1ET§;
   import §_-0sg§.§_-1Zo§;
   import §_-0sg§.§_-1b-§;
   import §_-0sg§.§_-1kC§;
   import §_-0sg§.§_-1mH§;
   import §_-0sg§.§_-2S8§;
   import §_-0sg§.§_-2lh§;
   import §_-0sg§.§_-2oq§;
   import §_-0sg§.§_-2qu§;
   import §_-0sg§.§_-37J§;
   import §_-0sg§.§_-3Ks§;
   import §_-0sg§.§_-4Au§;
   import §_-0sg§.§_-4RT§;
   import §_-0sg§.§_-4Zk§;
   import §_-0sg§.§_-j6§;
   import §_-0sg§.§_-nU§;
   import §_-112§.§_-1HA§;
   import §_-1iL§.§_-1QB§;
   import §_-1iL§.§_-K-§;
   import §_-1iL§.§_-Ro§;
   import §_-1iL§.§_-va§;
   import §_-26z§.§_-04k§;
   import §_-26z§.§_-0an§;
   import §_-26z§.§_-1zX§;
   import §_-26z§.§_-2sQ§;
   import §_-26z§.§_-3UX§;
   import §_-26z§.§_-N6§;
   import §_-26z§.§_-x1§;
   import §_-2C1§.§_-0Rb§;
   import §_-2RC§.§_-02u§;
   import §_-2RC§.§_-3d-§;
   import §_-2RC§.§_-4YX§;
   import §_-3MC§.§_-24h§;
   import §_-3MC§.§_-4C-§;
   import §_-3MC§.§_-se§;
   import §_-3MC§.§_-vW§;
   import §_-3eU§.MoveObjectMessageComposer;
   import §_-3eU§.§_-00Z§;
   import §_-3eU§.§_-06g§;
   import §_-3eU§.§_-0PW§;
   import §_-3eU§.§_-1Iq§;
   import §_-3eU§.§_-1QK§;
   import §_-3eU§.§_-2ca§;
   import §_-3eU§.§_-2gW§;
   import §_-3eU§.§_-2k§;
   import §_-3eU§.§_-3D8§;
   import §_-3eU§.§_-3e4§;
   import §_-3eU§.§_-3rp§;
   import §_-3eU§.§_-43T§;
   import §_-3eU§.§_-MH§;
   import §_-3eU§.§_-p0§;
   import §_-3wY§.§_-0FA§;
   import §_-44B§.Map;
   import §_-4cd§.§_-2WF§;
   import §_-GW§.§_-Ps§;
   import §_-vL§.§_-1vT§;
   import §_-vL§.§_-3Q9§;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class §_-Qs§ implements §_-1HA§, §_-0du§
   {
      
      private static const §_-3FZ§:Number = 0.5;
      
      private static const §_-1Lc§:Number = 1;
      
      private var _roomEngine:§_-3yd§ = null;
      
      private var §_-4Zi§:Map = null;
      
      private var §_-4mu§:int = -1;
      
      private var §_-0t6§:int = -1;
      
      private var §_-2DG§:int = -2;
      
      private var §_-qJ§:Boolean;
      
      private var §_-3fY§:Boolean = true;
      
      private var §_-1of§:String;
      
      public function §_-Qs§(param1:§_-3yd§)
      {
         super();
         §_-4Zi§ = new Map();
         _roomEngine = param1;
      }
      
      protected function get roomEngine() : §_-3yd§
      {
         return _roomEngine;
      }
      
      public function dispose() : void
      {
         if(§_-4Zi§ != null)
         {
            §_-4Zi§.dispose();
            §_-4Zi§ = null;
         }
         _roomEngine = null;
      }
      
      public function §_-1Tl§(param1:String, param2:int, param3:int, param4:int, param5:int, param6:String = null, param7:§_-0z5§ = null, param8:int = -1, param9:int = -1, param10:String = null) : Boolean
      {
         §_-1of§ = param1;
         var _loc11_:§_-3gO§ = new Vector3d(-100,-100);
         var _loc12_:§_-3gO§ = new Vector3d(0);
         §_-2u0§(param2,param3,param4,_loc11_,_loc12_,"OBJECT_PLACE",param5,param6,param7,param8,param9,param10);
         if(_roomEngine != null)
         {
            _roomEngine.§_-0zH§(param5,param4,false,param6,param7,param8,param9,param10);
            _roomEngine.§_-12k§(false);
            _roomEngine.§_-1AI§(false);
         }
         §_-qJ§ = true;
         return true;
      }
      
      public function §_-2Zf§(param1:int) : Boolean
      {
         §_-D0§(param1);
         §_-qJ§ = false;
         return true;
      }
      
      public function §_-1ll§() : Boolean
      {
         return §_-qJ§;
      }
      
      private function getSelectedObjectData(param1:int) : §_-vW§
      {
         if(_roomEngine == null)
         {
            return null;
         }
         var _loc2_:§_-4ik§ = _roomEngine.getSelectedObjectData(param1);
         return _loc2_ as §_-vW§;
      }
      
      private function §_-2u0§(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:§_-3gO§, param6:String, param7:int = 0, param8:String = null, param9:§_-0z5§ = null, param10:int = -1, param11:int = -1, param12:String = null) : void
      {
         §_-D0§(param1);
         if(_roomEngine == null)
         {
            return;
         }
         var _loc13_:§_-vW§ = new §_-vW§(param2,param3,param6,param4,param5,param7,param8,param9,param10,param11,param12);
         _roomEngine.§_-2u0§(param1,_loc13_);
      }
      
      private function §_-2oR§(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:§_-3gO§, param6:String, param7:int = 0, param8:String = null, param9:§_-0z5§ = null, param10:int = -1, param11:int = -1, param12:String = null) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc13_:§_-vW§ = new §_-vW§(param2,param3,param6,param4,param5,param7,param8,param9,param10,param11,param12);
         _roomEngine.§_-2u0§(param1,_loc13_);
      }
      
      private function §_-D0§(param1:int) : void
      {
         var _loc5_:§_-1QB§ = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_roomEngine == null)
         {
            return;
         }
         if(_roomEngine != null)
         {
            _roomEngine.§_-2NF§();
         }
         var _loc2_:§_-vW§ = getSelectedObjectData(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.§_-2u7§ == "OBJECT_MOVE" || _loc2_.§_-2u7§ == "OBJECT_MOVE_TO")
            {
               _loc5_ = _roomEngine.§_-46h§(param1,_loc2_.id,_loc2_.category) as §_-1QB§;
               if(_loc5_ != null && _loc2_.§_-2u7§ != "OBJECT_MOVE_TO")
               {
                  _loc5_.setLocation(_loc2_.§_-UL§);
                  _loc5_.setDirection(_loc2_.dir);
               }
               §_-13i§(_loc5_,1);
               if(_loc2_.category == 20)
               {
                  _roomEngine.§_-1bN§(param1,_loc2_.id,true);
               }
               §_-2oR§(param1,_loc2_.id,_loc2_.category,_loc2_.§_-UL§,_loc2_.dir,"OBJECT_MOVE",_loc2_.§_-3Ss§,_loc2_.§_-0YL§,_loc2_.§_-3-z§,_loc2_.state,_loc2_.§_-2RJ§,_loc2_.posture);
            }
            if(_loc2_.§_-2u7§ == "OBJECT_PLACE")
            {
               _loc3_ = _loc2_.id;
               switch(_loc4_ = _loc2_.category)
               {
                  case 10:
                     _roomEngine.§_-3M0§(param1,_loc3_);
                     break;
                  case 20:
                     _roomEngine.§_-0He§(param1,_loc3_);
                     break;
                  case 100:
                     _roomEngine.§_-1t9§(param1,_loc3_);
               }
            }
            _roomEngine.§_-2u0§(param1,null);
         }
      }
      
      public function §_-1cN§(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:§_-1QB§ = null;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc4_:IEventDispatcher = _roomEngine.events;
         if(_loc4_ == null)
         {
            return;
         }
         switch(param3)
         {
            case 100:
            case 10:
            case 20:
               if(param3 == 100)
               {
                  §_-1qw§(param1);
                  §_-2H3§(param1,param2,true);
               }
               else
               {
                  §_-2H3§(param1,0,false);
                  if(param2 != §_-0t6§)
                  {
                     §_-1qw§(param1);
                     _loc5_ = _roomEngine.§_-46h§(param1,param2,param3) as §_-1QB§;
                     if(_loc5_ != null && _loc5_.getEventHandler() != null)
                     {
                        _loc5_.getEventHandler().processUpdateMessage(new §_-3Ii§(true));
                        §_-0t6§ = param2;
                        §_-2DG§ = param3;
                     }
                  }
               }
               _loc4_.dispatchEvent(new §_-3Ks§("REOE_SELECTED",param1,param2,param3));
         }
      }
      
      private function §_-1qw§(param1:int) : void
      {
         var _loc2_:§_-1QB§ = null;
         if(§_-0t6§ != -1)
         {
            _loc2_ = _roomEngine.§_-46h§(param1,§_-0t6§,§_-2DG§) as §_-1QB§;
            if(_loc2_ != null && _loc2_.getEventHandler() != null)
            {
               _loc2_.getEventHandler().processUpdateMessage(new §_-3Ii§(false));
               §_-0t6§ = -1;
               §_-2DG§ = -2;
            }
         }
      }
      
      public function §_-4SB§(param1:§_-02u§, param2:§_-Ro§, param3:§_-4hO§) : void
      {
         if(§_-1rr§.§_-6-§())
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc7_:String = param2.getType();
         var _loc6_:int;
         var _loc4_:int = _loc6_ = _roomEngine.§_-3bO§(_loc7_);
         if(_loc6_ != 0)
         {
            if(!_roomEngine.§_-4L-§())
            {
               _loc6_ = -2;
            }
            else if(_loc6_ != 100)
            {
               _loc6_ = -2;
            }
         }
         var _loc5_:String = §_-03X§(_loc6_,param1.type);
         if(_loc5_ == param1.§_-XD§)
         {
            if(param1.type == "click" || param1.type == "doubleClick" || param1.type == "mouseDown" || param1.type == "mouseUp" || param1.type == "mouseMove")
            {
               return;
            }
         }
         else if(param1.§_-XD§ != null)
         {
            §_-32j§(_loc6_,param1.type,param1.§_-XD§);
         }
         if(param2.§_-a1§() != null)
         {
            param2.§_-a1§().mouseEvent(param1,param3);
         }
      }
      
      public function §_-02k§(param1:§_-4YX§, param2:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1 is §_-3d-§)
         {
            return §_-4Ci§(param1 as §_-3d-§,param2);
         }
         switch(param1.type)
         {
            case "ROSCE_STATE_CHANGE":
               §_-4gG§(param1 as §_-1Zo§,param2);
               break;
            case "ROSCE_STATE_RANDOM":
               §_-4e7§(param1 as §_-1Zo§,param2);
               break;
            case "RODSUE_DIMMER_STATE":
               §_-2rx§(param1,param2);
               break;
            case "ROME_POSITION_CHANGED":
               §_-0AR§(param1,param2);
               break;
            case "ROME_OBJECT_REMOVED":
               §_-40X§(param1,param2);
               break;
            case "ROWRE_OPEN_WIDGET":
            case "ROWRE_CLOSE_WIDGET":
            case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
            case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
            case "ROWRE_PLACEHOLDER":
            case "ROWRE__CREDITFURNI":
            case "ROWRE__STICKIE":
            case "ROWRE_PRESENT":
            case "ROWRE_TROPHY":
            case "ROWRE_TEASER":
            case "ROWRE_ECOTRONBOX":
            case "ROWRE_DIMMER":
            case "ROWRE_WIDGET_REMOVE_DIMMER":
            case "ROWRE_CLOTHING_CHANGE":
            case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
            case "ROWRE_MANNEQUIN":
            case "ROWRE_PET_PRODUCT_MENU":
            case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
            case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
            case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
            case "ROWRE_BACKGROUND_COLOR":
            case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
            case "ROWRE_EFFECTBOX_OPEN_DIALOG":
            case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
            case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
            case "ROWRE_FRIEND_FURNITURE_CONFIRM":
            case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
            case "ROWRE_BADGE_DISPLAY_ENGRAVING":
            case "ROWRE_HIGH_SCORE_DISPLAY":
            case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
            case "ROWRE_INTERNAL_LINK":
            case "ROWRE_ROOM_LINK":
               §_-2nQ§(param1,param2);
               break;
            case "ROFCAE_DICE_ACTIVATE":
            case "ROFCAE_DICE_OFF":
            case "ROFCAE_USE_HABBOWHEEL":
            case "ROFCAE_STICKIE":
            case "ROFCAE_ENTER_ONEWAYDOOR":
               §_-1xr§(param1,param2);
               break;
            case "ROFCAE_SOUND_MACHINE_INIT":
            case "ROFCAE_SOUND_MACHINE_START":
            case "ROFCAE_SOUND_MACHINE_STOP":
            case "ROFCAE_SOUND_MACHINE_DISPOSE":
               §_-0Vb§(param1,param2);
               break;
            case "ROFCAE_JUKEBOX_INIT":
            case "ROFCAE_JUKEBOX_START":
            case "ROFCAE_JUKEBOX_MACHINE_STOP":
            case "ROFCAE_JUKEBOX_DISPOSE":
               §_-Qy§(param1,param2);
               break;
            case "ROFHO_ADD_HOLE":
            case "ROFHO_REMOVE_HOLE":
               §_-1B5§(param1,param2);
               break;
            case "RORAE_ROOM_AD_FURNI_CLICK":
            case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
            case "RORAE_ROOM_AD_TOOLTIP_SHOW":
            case "RORAE_ROOM_AD_TOOLTIP_HIDE":
            case "RORAE_ROOM_AD_LOAD_IMAGE":
               §_-2QV§(param1,param2);
               break;
            case "ROGBE_LOAD_BADGE":
               §_-148§(param1,param2);
               break;
            case "ROFCAE_MOUSE_ARROW":
            case "ROFCAE_MOUSE_BUTTON":
               §_-3ZG§(param1,param2);
               break;
            case "ROPSIE_PLAY_SOUND":
            case "ROPSIE_PLAY_SOUND_AT_PITCH":
               §_-0RR§(§_-0tm§(param1),param2);
               break;
            case "ROPSPE_ROOM_OBJECT_INITIALIZED":
            case "ROPSPE_ROOM_OBJECT_DISPOSED":
            case "ROPSPE_PLAY_SAMPLE":
               §_-2cl§(§_-4Au§(param1),param2);
               break;
            case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
               §_-3uQ§(§_-4RT§(param1),param2);
               break;
            case "RODRE_CURRENT_USER_ID":
            case "RODRE_URL_PREFIX":
               §_-0eN§(param1,param2);
               break;
            default:
               Logger.log("*** Unhandled room object event in RoomObjectEventHandler::handleRoomObjectEvent !!! ***");
         }
         return false;
      }
      
      private function §_-32j§(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:Map = §_-4Zi§.getValue(String(param1)) as Map;
         if(_loc4_ == null)
         {
            _loc4_ = new Map();
            §_-4Zi§.add(param1,_loc4_);
         }
         _loc4_.remove(param2);
         _loc4_.add(param2,param3);
      }
      
      private function §_-03X§(param1:int, param2:String) : String
      {
         var _loc4_:Map = §_-4Zi§.getValue(String(param1)) as Map;
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.getValue(param2) as String;
      }
      
      private function §_-4Ci§(param1:§_-3d-§, param2:int) : Boolean
      {
         switch(param1.type)
         {
            case "ROE_MOUSE_CLICK":
               return §_-1bd§(param1,param2);
            case "ROE_MOUSE_MOVE":
               §_-tG§(param1,param2);
               break;
            case "ROE_MOUSE_DOWN":
               §_-2f0§(param1,param2);
               break;
            case "ROE_MOUSE_ENTER":
               §_-05N§(param1,param2);
               break;
            case "ROE_MOUSE_LEAVE":
               §_-0g2§(param1,param2);
         }
         return false;
      }
      
      public function §_-1bd§(param1:§_-3d-§, param2:int) : Boolean
      {
         var _loc8_:§_-vW§ = null;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc6_:String = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc9_:Boolean = false;
         var _loc5_:String = "OBJECT_UNDEFINED";
         var _loc15_:int = param1.objectId;
         var _loc12_:String = param1.§_-1eT§;
         var _loc14_:int = _roomEngine.§_-3bO§(_loc12_);
         if(_loc14_ == 0)
         {
            _loc8_ = null;
            if(_loc8_ != null)
            {
               _loc5_ = _loc8_.§_-2u7§;
            }
         }
         if(§_-3fY§)
         {
            if(_loc5_ == null || _loc5_ == "OBJECT_UNDEFINED")
            {
               _loc9_ = §_-0I1§(param2,param1);
            }
         }
         var _loc3_:String = param1.§_-XD§;
         var _loc13_:§_-2oq§ = param1 as §_-2oq§;
         var _loc4_:§_-2S8§ = param1 as §_-2S8§;
         var _loc16_:Boolean = false;
         var _loc7_:IEventDispatcher = _roomEngine.events;
         switch(_loc5_)
         {
            case "OBJECT_MOVE":
               if(_loc14_ == 0)
               {
                  if(_loc8_ != null)
                  {
                     §_-0nC§(param2,_loc8_.id,_loc8_.category,"OBJECT_MOVE_TO");
                  }
               }
               else if(_loc14_ == 100)
               {
                  if(_loc8_ != null && _loc12_ == "monsterplant")
                  {
                     §_-0nC§(param2,_loc8_.id,_loc8_.category,"OBJECT_MOVE_TO");
                  }
                  if(_loc3_ != null)
                  {
                     §_-32j§(0,"click",_loc3_);
                  }
                  §_-0xK§(param2,_loc15_,_loc14_);
               }
               _loc16_ = true;
               if(_loc15_ != -1)
               {
                  §_-1cN§(param2,_loc15_,_loc14_);
               }
               break;
            case "OBJECT_PLACE":
               if(_loc14_ == 0)
               {
                  §_-3rn§(param2);
               }
               else if(_loc14_ == 100)
               {
                  switch(_loc12_)
                  {
                     case "monsterplant":
                     case "rentable_bot":
                        §_-3rn§(param2);
                        break;
                     default:
                        if(_loc3_ != null)
                        {
                           §_-32j§(0,"click",_loc3_);
                        }
                        §_-0xK§(param2,_loc15_,_loc14_);
                  }
               }
               break;
            case "OBJECT_UNDEFINED":
               if(_loc14_ == 0)
               {
                  if(_loc13_ != null && !_loc9_)
                  {
                     §_-4To§(param2,_loc13_);
                  }
               }
               else
               {
                  §_-1cN§(param2,_loc15_,_loc14_);
                  _loc10_ = false;
                  if(_loc14_ == 100)
                  {
                     return false;
                  }
                  if(_loc14_ == 10 || _loc14_ == 20)
                  {
                     if((param1.altKey || param1.ctrlKey || param1.shiftKey) && !_roomEngine.§_-06t§)
                     {
                        if(!param1.ctrlKey && !param1.altKey && param1.shiftKey)
                        {
                           if(_loc14_ == 10)
                           {
                              if(_loc7_ != null)
                              {
                                 _loc7_.dispatchEvent(new §_-3Ks§("REOE_REQUEST_ROTATE",param2,_loc15_,_loc14_));
                              }
                           }
                        }
                        else if(param1.ctrlKey && !param1.altKey && !param1.shiftKey)
                        {
                           §_-0nC§(param2,_loc15_,_loc14_,"OBJECT_PICKUP");
                        }
                        if(!_roomEngine.§_-4L-§())
                        {
                           _loc9_ = true;
                        }
                        else
                        {
                           _loc10_ = true;
                        }
                     }
                  }
                  if(_loc3_ != null)
                  {
                     if(_loc9_)
                     {
                        §_-32j§(0,"click",_loc3_);
                     }
                     if(_loc10_)
                     {
                        §_-32j§(-2,"click",_loc3_);
                     }
                  }
               }
         }
         if(_loc14_ == 0)
         {
            _loc11_ = §_-03X§(-2,"click");
            _loc6_ = §_-03X§(100,"click");
            if(_loc11_ != _loc3_ && _loc6_ != _loc3_ && !_loc16_)
            {
               §_-1qw§(param2);
               if(_loc7_ != null)
               {
                  _loc7_.dispatchEvent(new §_-3Ks§("REOE_DESELECTED",param2,-1,-2));
               }
               §_-2H3§(param2,0,false);
            }
         }
         return _loc9_;
      }
      
      private function §_-tG§(param1:§_-3d-§, param2:int) : void
      {
         var _loc7_:§_-1QB§ = null;
         var _loc5_:§_-1YS§ = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 is §_-08p§)
         {
            _roomEngine.§_-1AI§(false);
            return;
         }
         var _loc3_:String = "OBJECT_UNDEFINED";
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.§_-2u7§;
         }
         var _loc8_:String = param1.§_-1eT§;
         var _loc6_:int = _roomEngine.§_-3bO§(_loc8_);
         if(_roomEngine != null)
         {
            _loc7_ = _roomEngine.§_-3bi§(param2);
            if(_loc7_ != null && _loc7_.getEventHandler() != null)
            {
               if(param1 is §_-2oq§)
               {
                  _loc5_ = §_-2D3§(param1 as §_-2oq§,param2);
               }
               else if(param1.object != null && param1.object.getId() != -1)
               {
                  if(§_-3fY§)
                  {
                     _loc5_ = §_-1S6§(_loc6_,param2,param1);
                  }
               }
               else
               {
                  _loc5_ = new §_-1YS§(null,0,false,param1.§_-XD§);
               }
               _loc7_.getEventHandler().processUpdateMessage(_loc5_);
            }
         }
         switch(_loc3_)
         {
            case "OBJECT_MOVE":
               if(_loc6_ == 0)
               {
                  §_-3Uy§(param1,param2);
               }
               break;
            case "OBJECT_PLACE":
               if(_loc6_ == 0)
               {
                  §_-20B§(param1,param2);
               }
         }
      }
      
      private function §_-2D3§(param1:§_-2oq§, param2:int) : §_-1YS§
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:§_-0FA§ = null;
         var _loc3_:§_-4NV§ = null;
         var _loc8_:§_-Ro§ = null;
         var _loc4_:§_-2v0§ = null;
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         if(§_-3fY§)
         {
            return new §_-1YS§(new Vector3d(param1.§_-44j§,param1.§_-1G§,param1.§_-0Tc§),0,true,param1.§_-XD§);
         }
         var _loc9_:§_-1QB§ = _roomEngine.§_-3bi§(param2);
         if(_loc9_ != null && _loc9_.getEventHandler() != null)
         {
            _loc5_ = param1.§_-44j§;
            _loc6_ = param1.§_-1G§;
            _loc7_ = param1.§_-0Tc§;
            _loc11_ = _roomEngine.§_-2Wp§(param2);
            if(_loc11_ != null)
            {
               _loc3_ = _roomEngine.§_-0Cn§(param2);
               if(_loc3_)
               {
                  _loc8_ = _loc3_.§_-3dm§(_loc5_,_loc6_);
                  _loc4_ = _roomEngine.§_-3-C§(param2);
                  if(_loc4_)
                  {
                     if(_loc8_ && _loc8_.getModel() && _loc8_.getModel().getNumber("furniture_is_variable_height") > 0)
                     {
                        _loc12_ = _loc4_.§_-4-t§(_loc5_,_loc6_);
                        _loc10_ = _roomEngine.§_-2J-§(param2).§_-4-t§(_loc5_,_loc6_);
                        return new §_-1YS§(new Vector3d(_loc5_,_loc6_,_loc7_),_loc12_ - _loc10_,true,param1.§_-XD§);
                     }
                     return new §_-1YS§(new Vector3d(_loc5_,_loc6_,_loc7_),0,true,param1.§_-XD§);
                  }
               }
            }
         }
         return null;
      }
      
      private function §_-1S6§(param1:int, param2:int, param3:§_-3d-§) : §_-1YS§
      {
         var _loc5_:Vector3d = null;
         var _loc6_:§_-2v0§ = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc4_:§_-Ro§ = null;
         if(param1 == 10)
         {
            _loc4_ = _roomEngine.§_-46h§(param2,param3.objectId,10);
            if(_loc4_)
            {
               _loc5_ = §_-0gP§(_loc4_,param3,true);
               if(_loc5_)
               {
                  _loc6_ = _roomEngine.§_-3-C§(param2);
                  if(_loc6_)
                  {
                     _loc7_ = _loc5_.x;
                     _loc8_ = _loc5_.y;
                     _loc9_ = _loc5_.z;
                     return new §_-1YS§(new Vector3d(_loc7_,_loc8_,_loc4_.getLocation().z),_loc9_,true,param3.§_-XD§);
                  }
               }
            }
         }
         return null;
      }
      
      private function §_-05N§(param1:§_-3d-§, param2:int) : void
      {
         var _loc6_:String = param1.§_-1eT§;
         var _loc4_:int = param1.objectId;
         var _loc3_:int = _roomEngine.§_-3bO§(_loc6_);
         if(_loc3_ != 0)
         {
            if(_loc3_ == 100)
            {
               §_-1G9§(_loc4_,param1,param2);
            }
         }
         var _loc5_:IEventDispatcher = _roomEngine.events;
         if(_loc5_ != null)
         {
            _loc5_.dispatchEvent(new §_-3Ks§("REOE_MOUSE_ENTER",param2,param1.objectId,_roomEngine.§_-3bO§(param1.§_-1eT§)));
         }
      }
      
      private function §_-0g2§(param1:§_-3d-§, param2:int) : void
      {
         var _loc4_:§_-1QB§ = null;
         var _loc5_:§_-Pr§ = null;
         var _loc7_:String = param1.§_-1eT§;
         var _loc3_:int = _roomEngine.§_-3bO§(_loc7_);
         if(_loc3_ != 0)
         {
            if(_loc3_ == 100)
            {
               _loc4_ = _roomEngine.§_-3bi§(param2);
               if(_loc4_)
               {
                  _loc5_ = new §_-Pr§(0,null);
                  _loc4_.getEventHandler().processUpdateMessage(_loc5_);
               }
            }
         }
         var _loc6_:IEventDispatcher = _roomEngine.events;
         if(_loc6_ != null)
         {
            _loc6_.dispatchEvent(new §_-3Ks§("REOE_MOUSE_LEAVE",param2,param1.objectId,_roomEngine.§_-3bO§(param1.§_-1eT§)));
         }
      }
      
      private function §_-2f0§(param1:§_-3d-§, param2:int) : void
      {
         var _loc7_:IEventDispatcher = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = "OBJECT_UNDEFINED";
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.§_-2u7§;
         }
         var _loc6_:int = param1.objectId;
         var _loc8_:String = param1.§_-1eT§;
         var _loc5_:int = _roomEngine.§_-3bO§(_loc8_);
         var _loc9_:String = _loc3_;
         if("OBJECT_UNDEFINED" === _loc9_)
         {
            if(_loc5_ == 10 || _loc5_ == 20 || _loc8_ == "monsterplant")
            {
               if((param1.altKey && !param1.ctrlKey && !param1.shiftKey || §_-2Bc§(param1)) && !_roomEngine.§_-06t§)
               {
                  _loc7_ = _roomEngine.events;
                  if(_loc7_ != null)
                  {
                     _loc7_.dispatchEvent(new §_-3Ks§("REOE_REQUEST_MOVE",param2,_loc6_,_loc5_));
                  }
               }
            }
         }
      }
      
      private function §_-2Bc§(param1:§_-3d-§) : Boolean
      {
         return _roomEngine.§_-08m§ && !(param1.ctrlKey || param1.shiftKey);
      }
      
      private function §_-3Uy§(param1:§_-3d-§, param2:int) : void
      {
         var _loc14_:Boolean = false;
         var _loc9_:§_-24h§ = null;
         var _loc10_:§_-2oq§ = null;
         var _loc3_:§_-2S8§ = null;
         var _loc12_:§_-3gO§ = null;
         var _loc8_:§_-3gO§ = null;
         var _loc6_:§_-3gO§ = null;
         var _loc11_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc15_:IEventDispatcher = _roomEngine.events;
         if(_loc15_ == null)
         {
            return;
         }
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:§_-1QB§ = _roomEngine.§_-46h§(param2,_loc4_.id,_loc4_.category) as §_-1QB§;
         if(_loc5_ != null)
         {
            _loc14_ = true;
            if(_loc4_.category == 10 || _loc4_.category == 100)
            {
               _loc9_ = _roomEngine.§_-3-C§(param2) as §_-24h§;
               _loc10_ = param1 as §_-2oq§;
               if(!(_loc10_ != null && §_-x3§(_loc5_,_loc4_,_loc10_.§_-1G5§ + 0.5,_loc10_.§_-1js§ + 0.5,_loc9_)))
               {
                  §_-x3§(_loc5_,_loc4_,_loc4_.§_-UL§.x,_loc4_.§_-UL§.y,_loc9_);
                  _loc14_ = false;
               }
            }
            else if(_loc4_.category == 20)
            {
               _loc14_ = false;
               _loc3_ = param1 as §_-2S8§;
               if(_loc3_ != null)
               {
                  _loc12_ = _loc3_.§_-TY§;
                  _loc8_ = _loc3_.§_-1LQ§;
                  _loc6_ = _loc3_.wallHeight;
                  _loc11_ = _loc3_.x;
                  _loc13_ = _loc3_.y;
                  _loc7_ = _loc3_.direction;
                  if(§_-171§(_loc5_,_loc4_,_loc12_,_loc8_,_loc6_,_loc11_,_loc13_,_loc7_))
                  {
                     _loc14_ = true;
                  }
               }
               if(!_loc14_)
               {
                  _loc5_.setLocation(_loc4_.§_-UL§);
                  _loc5_.setDirection(_loc4_.dir);
               }
               _roomEngine.§_-1bN§(param2,_loc4_.id,_loc14_);
            }
            if(_loc14_)
            {
               §_-13i§(_loc5_,0.5);
               _roomEngine.§_-12k§(false);
               _roomEngine.§_-1AI§(true);
            }
            else
            {
               §_-13i§(_loc5_,0);
               _roomEngine.§_-12k§(true);
               _roomEngine.§_-1AI§(false);
            }
         }
      }
      
      private function §_-20B§(param1:§_-3d-§, param2:int) : void
      {
         var _loc5_:Boolean = false;
         var _loc11_:§_-24h§ = null;
         var _loc13_:§_-3gO§ = null;
         var _loc9_:§_-3gO§ = null;
         var _loc7_:§_-3gO§ = null;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param1 == null || _roomEngine == null)
         {
            return;
         }
         var _loc15_:IEventDispatcher = _roomEngine.events;
         if(_loc15_ == null)
         {
            return;
         }
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc6_:§_-1QB§ = _roomEngine.§_-46h§(param2,_loc4_.id,_loc4_.category) as §_-1QB§;
         var _loc10_:§_-2oq§ = param1 as §_-2oq§;
         var _loc3_:§_-2S8§ = param1 as §_-2S8§;
         if(_loc6_ == null)
         {
            _loc6_ = §_-gy§(param2,_loc4_);
         }
         if(_loc6_ != null)
         {
            _loc5_ = true;
            _loc11_ = _roomEngine.§_-3-C§(param2) as §_-24h§;
            if(_loc4_.category == 10)
            {
               if(!(_loc10_ != null && §_-x3§(_loc6_,_loc4_,_loc10_.§_-1G5§ + 0.5,_loc10_.§_-1js§ + 0.5,_loc11_)))
               {
                  _roomEngine.§_-3M0§(param2,_loc4_.id);
                  _loc5_ = false;
               }
            }
            else if(_loc4_.category == 20)
            {
               _loc5_ = false;
               if(_loc3_ != null)
               {
                  _loc13_ = _loc3_.§_-TY§;
                  _loc9_ = _loc3_.§_-1LQ§;
                  _loc7_ = _loc3_.wallHeight;
                  _loc12_ = _loc3_.x;
                  _loc14_ = _loc3_.y;
                  _loc8_ = _loc3_.direction;
                  if(§_-171§(_loc6_,_loc4_,_loc13_,_loc9_,_loc7_,_loc12_,_loc14_,_loc8_))
                  {
                     _loc5_ = true;
                  }
               }
               if(!_loc5_)
               {
                  _roomEngine.§_-0He§(param2,_loc4_.id);
               }
               _roomEngine.§_-1bN§(param2,_loc4_.id,_loc5_);
            }
            else if(_loc4_.category == 100)
            {
               if(!(_loc10_ != null && §_-2LI§(_loc6_,_loc10_.§_-1G5§ + 0.5,_loc10_.§_-1js§ + 0.5,_roomEngine.§_-2J-§(param2))))
               {
                  _roomEngine.§_-1t9§(param2,_loc4_.id);
                  _loc5_ = false;
               }
            }
            _roomEngine.§_-12k§(!_loc5_);
            _roomEngine.§_-1AI§(_loc5_);
         }
      }
      
      public function §_-gy§(param1:int, param2:§_-vW§) : §_-1QB§
      {
         var _loc6_:§_-Ro§ = null;
         var _loc3_:§_-K-§ = null;
         var _loc5_:Array = null;
         var _loc4_:§_-3gO§ = null;
         if(param2.category == 10)
         {
            _roomEngine.§_-1E3§(param1,param2.id,param2.§_-3Ss§,param2.§_-UL§,param2.dir,0,param2.§_-3-z§,Number(param2.§_-0YL§),-1,0,0,"",false);
         }
         else if(param2.category == 20)
         {
            _roomEngine.§_-2M3§(param1,param2.id,param2.§_-3Ss§,param2.§_-UL§,param2.dir,0,param2.§_-0YL§,0);
         }
         else if(param2.category == 100)
         {
            _roomEngine.§_-2Kl§(param1,param2.id,new Vector3d(),new Vector3d(180),180,param2.§_-3Ss§,param2.§_-0YL§);
            _loc6_ = _roomEngine.§_-46h§(param1,param2.id,param2.category);
            if(_loc6_)
            {
               _loc3_ = _loc6_.getModel() as §_-K-§;
               if(_loc3_ != null && param2.posture != null)
               {
                  _loc3_.setString("figure_posture",param2.posture);
               }
            }
         }
         var _loc7_:§_-1QB§ = _roomEngine.§_-46h§(param1,param2.id,param2.category) as §_-1QB§;
         if(_loc7_ != null)
         {
            if(param2.category == 10)
            {
               if(_loc7_.getModel() != null)
               {
                  _loc5_ = _loc7_.getModel().getNumberArray("furniture_allowed_directions");
                  if(_loc5_ != null && _loc5_.length > 0)
                  {
                     _loc4_ = new Vector3d(_loc5_[0]);
                     _loc7_.setDirection(_loc4_);
                     §_-2oR§(param1,param2.id,param2.category,param2.§_-UL§,_loc4_,param2.§_-2u7§,param2.§_-3Ss§,param2.§_-0YL§,param2.§_-3-z§,param2.state,param2.§_-2RJ§,param2.posture);
                  }
               }
            }
         }
         §_-13i§(_loc7_,0.5);
         _roomEngine.§_-12k§(true);
         _roomEngine.§_-1AI§(false);
         return _loc7_;
      }
      
      public function §_-0I1§(param1:int, param2:§_-4YX§) : Boolean
      {
         var _loc4_:§_-Ro§ = _roomEngine.§_-46h§(param1,param2.objectId,10);
         var _loc3_:Vector3d = §_-0gP§(_loc4_,param2 as §_-3d-§,true);
         if(_loc3_)
         {
            §_-4j1§(_loc3_.x,_loc3_.y);
            return true;
         }
         return false;
      }
      
      public function §_-0CQ§(param1:int, param2:§_-4YX§) : Boolean
      {
         var _loc4_:§_-Ro§ = null;
         var _loc5_:§_-Ro§ = _roomEngine.§_-46h§(param1,param2.objectId,10);
         var _loc3_:Vector3d = §_-0gP§(_loc5_,param2 as §_-3d-§,false);
         if(_loc3_ != null)
         {
            _loc4_ = _roomEngine.§_-46h§(_roomEngine.§_-0Y§,-1,0);
            _loc4_.§_-a1§().handleFloorTouchAtTileLocation(_loc3_.x,_loc3_.y,0,"ROE_MOUSE_MOVE");
         }
         return _loc3_ != null;
      }
      
      private function §_-0gP§(param1:§_-Ro§, param2:§_-3d-§, param3:Boolean) : Vector3d
      {
         var _loc17_:int = 0;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         if(param1.§_-3YM§() != 10)
         {
            return null;
         }
         var _loc19_:§_-2WF§ = _roomEngine.sessionDataManager.getFloorItemDataByName(param1.getType());
         if(_loc19_ == null)
         {
            return null;
         }
         if(param3 && !(_loc19_.§_-4IK§ || _loc19_.§_-4nS§ || _loc19_.§_-4D-§))
         {
            return null;
         }
         var _loc21_:§_-va§ = param1.getModel();
         if(_loc21_ == null)
         {
            return null;
         }
         var _loc16_:int = param1.getLocation().x;
         var _loc14_:int = param1.getLocation().y;
         var _loc15_:int = _loc21_.getNumber("furniture_size_x");
         var _loc13_:int = _loc21_.getNumber("furniture_size_y");
         var _loc12_:Number = _loc21_.getNumber("furniture_size_z");
         var _loc10_:int = param1.getDirection().x;
         if(_loc10_ == 90 || _loc10_ == 270)
         {
            _loc17_ = _loc15_;
            _loc15_ = _loc13_;
            _loc13_ = _loc17_;
         }
         if(_loc15_ < 1)
         {
            _loc15_ = 1;
         }
         if(_loc13_ < 1)
         {
            _loc13_ = 1;
         }
         if(_roomEngine.§_-3V4§() == null)
         {
            return null;
         }
         var _loc6_:int = _roomEngine.§_-3V4§().geometry.scale;
         var _loc18_:Boolean = _loc19_.§_-4nS§;
         var _loc20_:Number = _loc18_ ? 0.5 : 0;
         var _loc7_:Number = (_loc6_ / 2 + param2.§_-05y§ + param2.localX) / (_loc6_ / 4);
         var _loc8_:Number = (param2.§_-1nN§ + param2.localY + (_loc12_ - _loc20_) * _loc6_ / 2) / (_loc6_ / 4);
         var _loc4_:Number = (_loc7_ + 2 * _loc8_) / 4;
         var _loc11_:Number = (_loc7_ - 2 * _loc8_) / 4;
         var _loc9_:int = Math.floor(_loc16_ + _loc4_);
         var _loc5_:int = Math.floor(_loc14_ - _loc11_ + 1);
         var _loc22_:Boolean = false;
         if(_loc9_ < _loc16_ || _loc9_ >= _loc16_ + _loc15_)
         {
            _loc22_ = true;
         }
         else if(_loc5_ < _loc14_ || _loc5_ >= _loc14_ + _loc13_)
         {
            _loc22_ = true;
         }
         var _loc23_:Number = _loc18_ ? _loc12_ - 0.5 : _loc12_;
         if(!_loc22_)
         {
            return new Vector3d(_loc9_,_loc5_,_loc23_);
         }
         return null;
      }
      
      protected function §_-4gG§(param1:§_-1Zo§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         §_-2Os§(param2,param1.objectId,param1.§_-1eT§,param1.param,false);
      }
      
      private function §_-4e7§(param1:§_-1Zo§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         §_-2Os§(param2,param1.objectId,param1.§_-1eT§,param1.param,true);
      }
      
      private function §_-2nQ§(param1:§_-4YX§, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         if(_roomEngine == null || param1 == null)
         {
            return;
         }
         var _loc7_:int = param1.objectId;
         var _loc9_:String = param1.§_-1eT§;
         var _loc5_:int = _roomEngine.§_-3bO§(_loc9_);
         var _loc8_:IEventDispatcher = _roomEngine.events;
         if(_loc8_ != null)
         {
            switch(param1.type)
            {
               case "ROWRE_OPEN_WIDGET":
                  _loc3_ = §_-1QB§(param1.object).getEventHandler().widget;
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_OPEN_WIDGET",param2,_loc7_,_loc5_,_loc3_));
                  break;
               case "ROWRE_CLOSE_WIDGET":
                  _loc3_ = §_-1QB§(param1.object).getEventHandler().widget;
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_CLOSE_WIDGET",param2,_loc7_,_loc5_,_loc3_));
                  break;
               case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
                  _loc4_ = §_-1QB§(param1.object).getEventHandler().contextMenu;
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_OPEN_FURNI_CONTEXT_MENU",param2,_loc7_,_loc5_,_loc4_));
                  break;
               case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_CLOSE_FURNI_CONTEXT_MENU",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PLACEHOLDER":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_PLACEHOLDER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE__CREDITFURNI":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_CREDITFURNI",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE__STICKIE":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_STICKIE",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PRESENT":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_PRESENT",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_TROPHY":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_TROPHY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_TEASER":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_TEASER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ECOTRONBOX":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_ECOTRONBOX",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_DIMMER":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_DIMMER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_WIDGET_REMOVE_DIMMER":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REMOVE_DIMMER",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_CLOTHING_CHANGE":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_CLOTHING_CHANGE",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_PLAYLIST_EDITOR",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MANNEQUIN":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_MANNEQUIN",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
                  _loc8_.dispatchEvent(new §_-37J§("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_PET_PRODUCT_MENU":
                  _loc8_.dispatchEvent(new §_-2qu§("ROSM_USE_PRODUCT_FROM_ROOM",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
                  _loc6_ = param1.object.getModel().getNumber("furniture_guild_customized_guild_id");
                  _roomEngine.connection.send(new §_-1zX§(param1.objectId,_loc6_));
                  break;
               case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
                  _loc8_.dispatchEvent(new §_-37J§("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_BACKGROUND_COLOR":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_BACKGROUND_COLOR",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_EFFECTBOX_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
                  _roomEngine.connection.send(new §_-Ps§(param1.objectId,0));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_FRIEND_FURNITURE_CONFIRM":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_FRIEND_FURNITURE_CONFIRM",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_BADGE_DISPLAY_ENGRAVING":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_HIGH_SCORE_DISPLAY":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_HIGH_SCORE_DISPLAY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_INTERNAL_LINK":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_INTERNAL_LINK",param2,_loc7_,_loc5_));
                  break;
               case "ROWRE_ROOM_LINK":
                  _loc8_.dispatchEvent(new §_-37J§("RETWE_REQUEST_ROOM_LINK",param2,_loc7_,_loc5_));
            }
         }
      }
      
      private function §_-2QV§(param1:§_-4YX§, param2:int) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         if(_roomEngine == null || _roomEngine.events == null || param1 == null)
         {
            return;
         }
         var _loc9_:int = param1.objectId;
         var _loc10_:String = param1.§_-1eT§;
         var _loc8_:int = _roomEngine.§_-3bO§(_loc10_);
         var _loc5_:§_-1kC§ = param1 as §_-1kC§;
         switch(param1.type)
         {
            case "RORAE_ROOM_AD_FURNI_CLICK":
               _roomEngine.events.dispatchEvent(param1);
               if(_loc5_ != null)
               {
                  if(_loc5_.clickUrl != "")
                  {
                     (_roomEngine as §_-4P2§).context.createLinkEvent(_loc5_.clickUrl);
                  }
               }
               _loc7_ = "RERAE_FURNI_CLICK";
               break;
            case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
               if(_loc5_ != null)
               {
                  _loc3_ = _loc5_.clickUrl;
                  _loc6_ = "CATALOG_PAGE:";
                  if(_loc3_ && _loc3_.indexOf(_loc6_) == 0)
                  {
                     _loc4_ = _loc3_.substr(_loc6_.length);
                  }
               }
               _loc7_ = "RERAE_FURNI_DOUBLE_CLICK";
               break;
            case "RORAE_ROOM_AD_TOOLTIP_SHOW":
               _loc7_ = "RERAE_TOOLTIP_SHOW";
               break;
            case "RORAE_ROOM_AD_TOOLTIP_HIDE":
               _loc7_ = "RERAE_TOOLTIP_HIDE";
               break;
            case "RORAE_ROOM_AD_LOAD_IMAGE":
               if(_loc5_ != null)
               {
                  _roomEngine.§_-1xK§(param2,_loc9_,_loc8_,_loc5_.imageUrl,_loc5_.clickUrl,_loc5_.§_-2LC§);
               }
         }
         if(_loc7_ == null)
         {
            return;
         }
         _roomEngine.events.dispatchEvent(new §_-3Ks§(_loc7_,param2,_loc9_,_loc8_));
      }
      
      private function §_-1xr§(param1:§_-4YX§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         useObject(param2,param1.objectId,param1.§_-1eT§,param1.type);
      }
      
      private function §_-0Vb§(param1:§_-4YX§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.§_-3bO§(param1.§_-1eT§);
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            if(_loc4_.category == _loc3_ && _loc4_.id == param1.objectId)
            {
               if(_loc4_.§_-2u7§ == "OBJECT_PLACE")
               {
                  return;
               }
            }
         }
         switch(param1.type)
         {
            case "ROFCAE_SOUND_MACHINE_INIT":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_SOUND_MACHINE_INIT",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_START":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_SOUND_MACHINE_SWITCHED_ON",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_STOP":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_SOUND_MACHINE_SWITCHED_OFF",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_SOUND_MACHINE_DISPOSE":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_SOUND_MACHINE_DISPOSE",param2,param1.objectId,_loc3_));
         }
      }
      
      private function §_-Qy§(param1:§_-4YX§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.§_-3bO§(param1.§_-1eT§);
         var _loc4_:§_-vW§ = getSelectedObjectData(param2);
         if(_loc4_ != null)
         {
            if(_loc4_.category == _loc3_ && _loc4_.id == param1.objectId)
            {
               if(_loc4_.§_-2u7§ == "OBJECT_PLACE")
               {
                  return;
               }
            }
         }
         switch(param1.type)
         {
            case "ROFCAE_JUKEBOX_INIT":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_JUKEBOX_INIT",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_START":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_JUKEBOX_SWITCHED_ON",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_MACHINE_STOP":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_JUKEBOX_SWITCHED_OFF",param2,param1.objectId,_loc3_));
               break;
            case "ROFCAE_JUKEBOX_DISPOSE":
               _roomEngine.events.dispatchEvent(new §_-4Zk§("ROSM_JUKEBOX_DISPOSE",param2,param1.objectId,_loc3_));
         }
      }
      
      private function §_-148§(param1:§_-4YX§, param2:int) : void
      {
         var _loc3_:§_-j6§ = null;
         if(_roomEngine == null || _roomEngine.events == null || param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.objectId;
         var _loc6_:String = param1.§_-1eT§;
         var _loc4_:int = _roomEngine.§_-3bO§(_loc6_);
         if(param1.type == "ROGBE_LOAD_BADGE")
         {
            _loc3_ = param1 as §_-j6§;
            if(_loc3_ != null)
            {
               _roomEngine.§_-G2§(param2,_loc5_,_loc4_,_loc3_.§_-3OA§,_loc3_.§_-3K9§);
            }
         }
      }
      
      private function §_-1B5§(param1:§_-4YX§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "ROFHO_ADD_HOLE":
               _roomEngine.§_-as§(param2,param1.objectId);
               break;
            case "ROFHO_REMOVE_HOLE":
               _roomEngine.§_-3W5§(param2,param1.objectId);
         }
      }
      
      private function §_-3ZG§(param1:§_-4YX§, param2:int) : void
      {
         _roomEngine.§_-2LD§(param1.type,param1.objectId,param1.§_-1eT§);
      }
      
      private function §_-2rx§(param1:§_-4YX§, param2:int) : void
      {
         var _loc4_:§_-2lh§ = null;
         var _loc3_:§_-1ET§ = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.objectId;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            var _loc6_:String = param1.type;
            if("RODSUE_DIMMER_STATE" === _loc6_)
            {
               _loc4_ = param1 as §_-2lh§;
               if(_loc4_ != null)
               {
                  _loc3_ = new §_-1ET§(param2,_loc4_.state,_loc4_.§_-3r0§,_loc4_.§_-22W§,_loc4_.color,_loc4_.§_-2a2§);
                  _roomEngine.events.dispatchEvent(_loc3_);
               }
            }
         }
      }
      
      private function §_-0RR§(param1:§_-0tm§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.§_-3bO§(param1.§_-1eT§);
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(param1.type)
            {
               case "ROPSIE_PLAY_SOUND":
                  _roomEngine.events.dispatchEvent(new §_-1b-§("REPSE_PLAY_SOUND",param2,param1.objectId,_loc3_,param1.§_-4dR§,param1.§_-1LE§));
                  break;
               case "ROPSIE_PLAY_SOUND_AT_PITCH":
                  _roomEngine.events.dispatchEvent(new §_-1b-§("REPSE_PLAY_SOUND_AT_PITCH",param2,param1.objectId,_loc3_,param1.§_-4dR§,param1.§_-1LE§));
            }
         }
      }
      
      private function §_-2cl§(param1:§_-4Au§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = _roomEngine.§_-3bO§(param1.§_-1eT§);
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(param1.type)
            {
               case "ROPSPE_ROOM_OBJECT_INITIALIZED":
                  _roomEngine.events.dispatchEvent(new §_-1mH§("REOSPE_ROOM_OBJECT_INITIALIZED",param2,param1.objectId,_loc3_,param1.§_-9g§,param1.§_-1LE§));
                  break;
               case "ROPSPE_ROOM_OBJECT_DISPOSED":
                  _roomEngine.events.dispatchEvent(new §_-1mH§("REOSPE_ROOM_OBJECT_DISPOSED",param2,param1.objectId,_loc3_,param1.§_-9g§,param1.§_-1LE§));
                  break;
               case "ROPSPE_PLAY_SAMPLE":
                  _roomEngine.events.dispatchEvent(new §_-1mH§("REOSPE_PLAY_SAMPLE",param2,param1.objectId,_loc3_,param1.§_-9g§,param1.§_-1LE§));
            }
         }
      }
      
      private function §_-3uQ§(param1:§_-4RT§, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            var _loc3_:String = param1.type;
            if("ROHSLCEE_ROOM_BACKGROUND_COLOR" === _loc3_)
            {
               _roomEngine.events.dispatchEvent(new §_-nU§("ROHSLCEE_ROOM_BACKGROUND_COLOR",param2,param1.§_-1-v§,param1.§_-fW§,param1.§_-3Is§,param1.§_-VZ§));
            }
         }
      }
      
      private function §_-0eN§(param1:§_-4YX§, param2:int) : void
      {
         if(_roomEngine == null || param1 == null || param1.object == null)
         {
            return;
         }
         var _loc3_:§_-K-§ = param1.object.getModel() as §_-K-§;
         switch(param1.type)
         {
            case "RODRE_CURRENT_USER_ID":
               _loc3_.setNumber("session_current_user_id",_roomEngine.sessionDataManager.userId);
               break;
            case "RODRE_URL_PREFIX":
               _loc3_.setString("session_url_prefix",_roomEngine.configuration.getProperty("url.prefix"));
         }
      }
      
      private function §_-0AR§(param1:§_-4YX§, param2:int) : void
      {
         var _loc3_:§_-3gO§ = null;
         var _loc8_:§_-0Rb§ = null;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc7_:int = param1.objectId;
         var _loc9_:String = param1.§_-1eT§;
         var _loc6_:int = _roomEngine.§_-3bO§(_loc9_);
         var _loc4_:§_-1QB§ = _roomEngine.§_-46h§(param2,_loc7_,_loc6_) as §_-1QB§;
         var _loc5_:§_-1QB§ = _roomEngine.§_-2-m§(param2);
         if(_loc4_ != null && _loc5_ != null && _loc5_.getEventHandler() != null)
         {
            _loc3_ = _loc4_.getLocation();
            _loc8_ = new §_-0Rb§(_loc3_,null);
            _loc5_.getEventHandler().processUpdateMessage(_loc8_);
         }
      }
      
      private function §_-40X§(param1:§_-4YX§, param2:int) : void
      {
         §_-2H3§(param2,0,false);
      }
      
      private function §_-x3§(param1:§_-1QB§, param2:§_-vW§, param3:int, param4:int, param5:§_-24h§) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc6_:Vector3d = new Vector3d();
         _loc6_.§_-4Dq§(param1.getDirection());
         param1.setDirection(param2.dir);
         var _loc8_:Vector3d = new Vector3d(param3,param4,0);
         var _loc7_:Vector3d = new Vector3d();
         _loc7_.§_-4Dq§(param1.getDirection());
         var _loc9_:Vector3d = §_-4C-§.§_-0CE§(param1,_loc8_,param2.§_-UL§,param2.dir,param5);
         if(_loc9_ == null)
         {
            _loc7_.x = §_-wU§(param1,true);
            param1.setDirection(_loc7_);
            _loc9_ = §_-4C-§.§_-0CE§(param1,_loc8_,param2.§_-UL§,param2.dir,param5);
         }
         if(_loc9_ == null)
         {
            param1.setDirection(_loc6_);
            return false;
         }
         param1.setLocation(_loc9_);
         if(_loc7_)
         {
            param1.setDirection(_loc7_);
         }
         return true;
      }
      
      private function §_-171§(param1:§_-1QB§, param2:§_-vW§, param3:§_-3gO§, param4:§_-3gO§, param5:§_-3gO§, param6:Number, param7:Number, param8:Number) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc9_:Vector3d = new Vector3d(param8);
         var _loc10_:Vector3d = §_-4C-§.§_-1bV§(param1,param3,param4,param5,param6,param7);
         if(_loc10_ == null)
         {
            return false;
         }
         param1.setLocation(_loc10_);
         param1.setDirection(_loc9_);
         return true;
      }
      
      private function §_-2LI§(param1:§_-1QB§, param2:int, param3:int, param4:§_-se§) : Boolean
      {
         if(!param4.§_-2Zc§(param2,param3))
         {
            return false;
         }
         param1.setLocation(new Vector3d(param2,param3,param4.§_-4-t§(param2,param3)));
         return true;
      }
      
      private function §_-13i§(param1:§_-1QB§, param2:Number) : void
      {
         if(param1 != null && param1.getModelController() != null)
         {
            param1.getModelController().setNumber("furniture_alpha_multiplier",param2);
         }
      }
      
      public function §_-2H3§(param1:int, param2:int, param3:Boolean) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc6_:int = 100;
         var _loc7_:§_-1QB§ = _roomEngine.§_-46h§(param1,§_-4mu§,_loc6_) as §_-1QB§;
         if(_loc7_ != null && _loc7_.getEventHandler() != null)
         {
            _loc7_.getEventHandler().processUpdateMessage(new §_-0sL§(false));
            §_-4mu§ = -1;
         }
         var _loc4_:Boolean = false;
         if(param3)
         {
            _loc7_ = _roomEngine.§_-46h§(param1,param2,_loc6_) as §_-1QB§;
            if(_loc7_ != null && _loc7_.getEventHandler() != null)
            {
               _loc7_.getEventHandler().processUpdateMessage(new §_-0sL§(true));
               _loc4_ = true;
               §_-4mu§ = param2;
               try
               {
                  _roomEngine.connection.send(new §_-3CN§(_loc7_.getLocation().x,_loc7_.getLocation().y));
               }
               catch(e:Error)
               {
               }
            }
         }
         var _loc5_:§_-1QB§ = _roomEngine.§_-2-m§(param1);
         if(_loc5_ != null && _loc5_.getEventHandler() != null)
         {
            if(_loc4_ && !_roomEngine.§_-4L-§())
            {
               _loc5_.getEventHandler().processUpdateMessage(new §_-10s§("ROVUM_ENABLED"));
            }
            else
            {
               _loc5_.getEventHandler().processUpdateMessage(new §_-10s§("ROVUM_DISABLED"));
            }
         }
      }
      
      public function §_-0un§() : int
      {
         return §_-4mu§;
      }
      
      private function §_-wU§(param1:§_-1QB§, param2:Boolean) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null || param1.getModel() == null)
         {
            return 0;
         }
         var _loc3_:Array = null;
         var _loc6_:String = param1.getType();
         if(param1.getModel() != null)
         {
            if(_loc6_ == "monsterplant")
            {
               _loc3_ = param1.getModel().getNumberArray("pet_allowed_directions");
            }
            else
            {
               _loc3_ = param1.getModel().getNumberArray("furniture_allowed_directions");
            }
         }
         var _loc7_:int = int(param1.getDirection().x);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc4_ = _loc3_.indexOf(_loc7_);
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc7_ <= _loc3_[_loc5_])
                  {
                     break;
                  }
                  _loc4_++;
                  _loc5_++;
               }
               _loc4_ %= _loc3_.length;
            }
            if(param2)
            {
               _loc4_ = (_loc4_ + 1) % _loc3_.length;
            }
            else
            {
               _loc4_ = (_loc4_ - 1 + _loc3_.length) % _loc3_.length;
            }
            _loc7_ = int(_loc3_[_loc4_]);
         }
         return _loc7_;
      }
      
      public function §_-16P§(param1:int, param2:int, param3:int, param4:String, param5:Map) : Boolean
      {
         if(_roomEngine == null)
         {
            return false;
         }
         var _loc6_:§_-1QB§ = _roomEngine.§_-46h§(param1,param2,param3) as §_-1QB§;
         if(_loc6_ == null)
         {
            return false;
         }
         var _loc7_:String = param4;
         if("OBJECT_SAVE_STUFF_DATA" !== _loc7_)
         {
            Logger.log("could not modify room object data, unknown operation " + param4);
         }
         else if(_roomEngine.connection)
         {
            _roomEngine.connection.send(new §_-3e4§(param2,param5));
         }
         return true;
      }
      
      public function §_-0nC§(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         var _loc14_:int = 0;
         var _loc20_:§_-vW§ = null;
         var _loc21_:§_-3gO§ = null;
         var _loc8_:§_-3gO§ = null;
         var _loc15_:Vector3d = null;
         var _loc9_:§_-24h§ = null;
         var _loc6_:§_-vW§ = null;
         var _loc7_:int = 0;
         var _loc16_:§_-se§ = null;
         var _loc11_:String = null;
         if(_roomEngine == null)
         {
            return false;
         }
         var _loc17_:§_-1QB§ = _roomEngine.§_-46h§(param1,param2,param3) as §_-1QB§;
         if(_loc17_ == null)
         {
            return false;
         }
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc18_:int = 0;
         var _loc13_:Boolean = true;
         var _loc19_:§_-3Q9§ = null;
         var _loc5_:§_-1vT§ = null;
         switch(param4)
         {
            case "OBJECT_ROTATE_POSITIVE":
            case "OBJECT_ROTATE_NEGATIVE":
               if(_roomEngine.connection)
               {
                  _loc13_ = false;
                  if(param4 == "OBJECT_ROTATE_NEGATIVE")
                  {
                     _loc18_ = §_-wU§(_loc17_,false);
                  }
                  else
                  {
                     _loc18_ = §_-wU§(_loc17_,true);
                  }
                  _loc10_ = int(_loc17_.getLocation().x);
                  _loc12_ = int(_loc17_.getLocation().y);
                  if(§_-4C-§.§_-0fA§(_loc17_,new Vector3d(_loc18_),_roomEngine.§_-3-C§(param1)))
                  {
                     _loc14_ = _loc18_ / 45;
                     if(_loc17_.getType() == "monsterplant")
                     {
                        _loc19_ = _roomEngine.§_-4Ej§.getSession(param1);
                        if(_loc19_ != null)
                        {
                           _loc5_ = _loc19_.§_-2gp§.§_-0uJ§(param2);
                           if(_loc5_ != null)
                           {
                              _roomEngine.connection.send(new §_-00Z§(_loc5_.§_-1GP§,_loc10_,_loc12_,_loc14_));
                              _loc13_ = true;
                           }
                        }
                     }
                     else
                     {
                        _loc20_ = getSelectedObjectData(param1);
                        if(_loc20_ != null)
                        {
                           _loc21_ = _loc20_.dir as §_-3gO§;
                           _loc8_ = _loc17_.getLocation();
                           _loc15_ = new Vector3d(_loc18_);
                           _loc9_ = _roomEngine.§_-3-C§(param1) as §_-24h§;
                           _loc20_.dir = _loc15_ as Vector3d;
                           if(§_-x3§(_loc17_,_loc20_,_loc8_.x,_loc8_.y,_loc9_))
                           {
                              _loc17_.setDirection(_loc15_);
                           }
                           else
                           {
                              _loc17_.setDirection(_loc21_);
                           }
                           _loc20_.dir = _loc21_ as Vector3d;
                        }
                     }
                  }
               }
               break;
            case "OBJECT_EJECT":
            case "OBJECT_PICKUP":
               if(_roomEngine.connection)
               {
                  _roomEngine.connection.send(new §_-MH§(param2,param3));
               }
               break;
            case "OBJECT_PICKUP_PET":
               if(_roomEngine.connection)
               {
                  _loc19_ = _roomEngine.§_-4Ej§.getSession(param1);
                  if(_loc19_ != null)
                  {
                     _loc5_ = _loc19_.§_-2gp§.§_-0uJ§(param2);
                     _loc19_.§_-4R§(_loc5_.§_-1GP§);
                  }
               }
               break;
            case "OBJECT_PICKUP_BOT":
               if(_roomEngine.connection)
               {
                  _loc19_ = _roomEngine.§_-4Ej§.getSession(param1);
                  if(_loc19_ != null)
                  {
                     _loc5_ = _loc19_.§_-2gp§.§_-0uJ§(param2);
                     if(_loc5_ != null)
                     {
                        _roomEngine.connection.send(new §_-06g§(_loc5_.§_-1GP§));
                     }
                  }
               }
               break;
            case "OBJECT_MOVE":
               _loc13_ = false;
               §_-13i§(_loc17_,0.5);
               §_-2u0§(param1,_loc17_.getId(),param3,_loc17_.getLocation(),_loc17_.getDirection(),param4);
               _roomEngine.§_-0zH§(_loc17_.getId(),param3,true);
               _roomEngine.§_-12k§(false);
               _roomEngine.§_-1AI§(true);
               break;
            case "OBJECT_MOVE_TO":
               _loc6_ = getSelectedObjectData(param1);
               if(_loc6_)
               {
                  §_-2oR§(param1,_loc6_.id,_loc6_.category,_loc6_.§_-UL§,_loc6_.dir,"OBJECT_MOVE_TO",_loc6_.§_-3Ss§,_loc6_.§_-0YL§,_loc6_.§_-3-z§,_loc6_.state,_loc6_.§_-2RJ§,_loc6_.posture);
               }
               §_-13i§(_loc17_,1);
               _roomEngine.§_-2NF§();
               if(_roomEngine.connection)
               {
                  if(param3 == 10)
                  {
                     _loc18_ = int(_loc17_.getDirection().x) % 360;
                     _loc10_ = int(_loc17_.getLocation().x);
                     _loc12_ = int(_loc17_.getLocation().y);
                     _loc18_ /= 45;
                     _roomEngine.connection.send(new §_-3eU§.MoveObjectMessageComposer(param2,_loc10_,_loc12_,_loc18_));
                  }
                  else if(param3 == 100)
                  {
                     _loc18_ = int(_loc17_.getDirection().x) % 360;
                     _loc10_ = int(_loc17_.getLocation().x);
                     _loc12_ = int(_loc17_.getLocation().y);
                     _loc18_ /= 45;
                     _loc7_ = parseInt(_loc17_.getModel().getString("race"));
                     _loc19_ = _roomEngine.§_-4Ej§.getSession(param1);
                     if(_loc19_ != null)
                     {
                        _loc5_ = _loc19_.§_-2gp§.§_-0uJ§(param2);
                        if(_loc5_ != null)
                        {
                           _roomEngine.connection.send(new §_-00Z§(_loc5_.§_-1GP§,_loc10_,_loc12_,_loc18_));
                        }
                     }
                  }
                  else if(param3 == 20)
                  {
                     _loc18_ = int(_loc17_.getDirection().x) % 360;
                     _loc16_ = _roomEngine.§_-2J-§(param1);
                     if(_roomEngine.connection && _loc16_)
                     {
                        _loc11_ = _loc16_.§_-el§(_loc17_.getLocation(),_loc18_);
                        if(_loc11_ != null)
                        {
                           _roomEngine.connection.send(new §_-43T§(param2,20,_loc11_));
                        }
                     }
                  }
               }
         }
         if(_loc13_)
         {
            §_-D0§(param1);
         }
         return true;
      }
      
      private function §_-0xK§(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:§_-vW§ = getSelectedObjectData(param1);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:§_-1QB§ = _roomEngine.§_-46h§(param1,param2,param3) as §_-1QB§;
         if(_loc5_ == null)
         {
            return;
         }
         if(_roomEngine && _roomEngine.events)
         {
            _roomEngine.events.dispatchEvent(new §_-0us§("REOE_PLACED_ON_USER",param1,param2,param3,_loc4_.id,_loc4_.category));
         }
      }
      
      public function §_-3rn§(param1:int) : void
      {
         var _loc5_:§_-1QB§ = null;
         var _loc4_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc2_:§_-3gO§ = null;
         var _loc16_:§_-se§ = null;
         var _loc9_:Boolean = false;
         var _loc3_:§_-vW§ = getSelectedObjectData(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc14_:int = _loc3_.id;
         var _loc15_:int = _loc3_.category;
         var _loc11_:String = "";
         var _loc10_:Number = 0;
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc6_:int = 0;
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            _loc5_ = _roomEngine.§_-46h§(param1,_loc14_,_loc15_) as §_-1QB§;
            if(_loc5_ != null)
            {
               _loc6_ = int(_loc5_.getDirection().x);
               _loc2_ = _loc5_.getLocation();
               if(_loc15_ == 10 || _loc15_ == 100)
               {
                  _loc10_ = _loc2_.x;
                  _loc12_ = _loc2_.y;
                  _loc13_ = _loc2_.z;
                  _loc4_ = true;
               }
               else if(_loc15_ == 20)
               {
                  _loc10_ = _loc2_.x;
                  _loc12_ = _loc2_.y;
                  _loc13_ = _loc2_.z;
                  _loc16_ = _roomEngine.§_-2J-§(param1);
                  if(_loc16_ != null)
                  {
                     _loc11_ = _loc16_.§_-el§(_loc2_,_loc6_);
                  }
                  _loc7_ = true;
               }
               _loc6_ = (_loc6_ / 45 % 8 + 8) % 8;
               if(_loc5_.getType() == "free_placement_room" && roomEngine.§_-2Wp§(param1).§_-2oN§("free_placement_room",10) > 1)
               {
                  return;
               }
               if(_loc14_ < 0 && _loc15_ == 100)
               {
                  _loc14_ *= -1;
               }
               if(§_-1of§ != "catalog")
               {
                  if(_loc15_ == 100 && _loc3_.§_-3Ss§ == 2)
                  {
                     _roomEngine.connection.send(new §_-0PW§(_loc14_,int(_loc10_),int(_loc12_)));
                  }
                  else if(_loc15_ == 100 && _loc3_.§_-3Ss§ == 4)
                  {
                     _roomEngine.connection.send(new §_-p0§(_loc14_,int(_loc10_),int(_loc12_)));
                  }
                  else if(_loc5_.getModelController().getString("furniture_is_stickie") != null)
                  {
                     _roomEngine.connection.send(new §_-3UX§(_loc14_,_loc11_));
                  }
                  else
                  {
                     _roomEngine.connection.send(new §_-2k§(_loc14_,_loc15_,_loc11_,int(_loc10_),int(_loc12_),_loc6_));
                  }
               }
            }
         }
         var _loc8_:§_-vW§ = new §_-vW§(_loc3_.id,_loc3_.category,null,null,null);
         _roomEngine.§_-328§(param1,_loc8_);
         §_-D0§(param1);
         if(_roomEngine && _roomEngine.events)
         {
            _loc9_ = _loc5_ && _loc5_.getId() == _loc3_.id;
            _roomEngine.events.dispatchEvent(new §_-0Tq§("REOE_PLACED",param1,_loc14_,_loc15_,_loc11_,_loc10_,_loc12_,_loc13_,_loc6_,_loc9_,_loc4_,_loc7_,_loc3_.§_-0YL§));
         }
      }
      
      private function §_-2Os§(param1:int, param2:int, param3:String, param4:int, param5:Boolean) : void
      {
         var _loc6_:int = _roomEngine.§_-3bO§(param3);
         §_-0dX§(param1,param2,_loc6_,param4,param5);
      }
      
      private function §_-0dX§(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : Boolean
      {
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            if(param3 == 10)
            {
               if(!param5)
               {
                  _roomEngine.connection.send(new §_-3D8§(param2,param4));
               }
               else
               {
                  _roomEngine.connection.send(new §_-0an§(param2,param4));
               }
            }
            else if(param3 == 20)
            {
               _roomEngine.connection.send(new §_-2gW§(param2,param4));
            }
         }
         return true;
      }
      
      private function useObject(param1:int, param2:int, param3:String, param4:String) : void
      {
         if(_roomEngine != null && _roomEngine.connection != null)
         {
            switch(param4)
            {
               case "ROFCAE_DICE_ACTIVATE":
                  _roomEngine.connection.send(new §_-N6§(param2));
                  break;
               case "ROFCAE_DICE_OFF":
                  _roomEngine.connection.send(new §_-x1§(param2));
                  break;
               case "ROFCAE_USE_HABBOWHEEL":
                  _roomEngine.connection.send(new §_-2sQ§(param2));
                  break;
               case "ROFCAE_STICKIE":
                  _roomEngine.connection.send(new §_-3rp§(param2));
                  break;
               case "ROFCAE_ENTER_ONEWAYDOOR":
                  _roomEngine.connection.send(new §_-04k§(param2));
            }
         }
      }
      
      public function §_-2LY§(param1:int, param2:int, param3:String, param4:String) : Boolean
      {
         if(_roomEngine == null || _roomEngine.connection == null)
         {
            return false;
         }
         _roomEngine.connection.send(new §_-2ca§(param2,param3,param4));
         return true;
      }
      
      public function §_-1Qm§(param1:int, param2:int) : Boolean
      {
         if(_roomEngine == null || _roomEngine.connection == null)
         {
            return false;
         }
         _roomEngine.connection.send(new §_-1QK§(param2));
         return true;
      }
      
      private function §_-4To§(param1:int, param2:§_-2oq§) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(_roomEngine.§_-08m§)
         {
            return;
         }
         if(!_roomEngine.§_-4Ej§)
         {
            return;
         }
         var _loc3_:§_-3Q9§ = _roomEngine.§_-4Ej§.getSession(param1);
         if(_loc3_ != null && _loc3_.§_-0rn§)
         {
            return;
         }
         §_-4j1§(param2.§_-44j§,param2.§_-1G§);
      }
      
      private function §_-4j1§(param1:int, param2:int) : void
      {
         if(_roomEngine.connection)
         {
            _roomEngine.connection.send(new §_-1Iq§(param1,param2));
            _roomEngine.events.dispatchEvent(new Event("REE_WALKING_TO"));
         }
      }
      
      private function §_-0CL§(param1:int, param2:§_-3d-§) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(roomEngine.§_-08m§)
         {
            return;
         }
      }
      
      private function §_-1G9§(param1:int, param2:§_-3d-§, param3:int) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(roomEngine.§_-08m§)
         {
            return;
         }
      }
   }
}

