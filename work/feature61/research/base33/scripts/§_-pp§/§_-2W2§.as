package §_-pp§
{
   import §_-01y§.§_-3XY§;
   import §_-0AB§.§_-0By§;
   import §_-0AS§.§_-2qj§;
   import §_-0D0§.§_-31O§;
   import §_-0Dh§.§_-3dX§;
   import §_-0KT§.§_-1eU§;
   import §_-0iC§.§_-1mt§;
   import §_-0iC§.§_-BX§;
   import §_-0od§.§_-3UO§;
   import §_-0sg§.§_-0I2§;
   import §_-0sg§.§_-2LR§;
   import §_-0sg§.§_-37J§;
   import §_-0sg§.§_-3Ks§;
   import §_-0vk§.§_-3zh§;
   import §_-0zo§.§_-1Tv§;
   import §_-112§.§_-1Ia§;
   import §_-15y§.§_-49B§;
   import §_-1N-§.§_-2mJ§;
   import §_-1WP§.EventDispatcherWrapper;
   import §_-1Xf§.§_-1W5§;
   import §_-1iL§.§_-1QB§;
   import §_-1iL§.§_-Ro§;
   import §_-1iL§.§_-va§;
   import §_-1wF§.§_-59§;
   import §_-249§.§_-pC§;
   import §_-2Pf§.§_-1ja§;
   import §_-2RC§.§_-2WW§;
   import §_-2XI§.§_-1t8§;
   import §_-2lx§.§_-2Jj§;
   import §_-2xS§.LayoutGroup;
   import §_-3Nz§.§_-2ma§;
   import §_-3Wl§.§_-um§;
   import §_-3fm§.§_-0Kr§;
   import §_-3l1§.§_-3Az§;
   import §_-3td§.Core;
   import §_-3wY§.§_-1vP§;
   import §_-42h§.§_-2hU§;
   import §_-4GD§.§_-48P§;
   import §_-4R1§.§_-4iw§;
   import §_-u8§.§_-0cZ§;
   import §_-u8§.§_-1OE§;
   import §_-vL§.§_-0Va§;
   import §_-vL§.§_-1vT§;
   import §_-vL§.§_-3Q9§;
   import §_-vL§.§_-W7§;
   import §_-vL§.§_-no§;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.core.Starling;
   import starling.display.Sprite;
   
   public class §_-2W2§ implements §_-FG§
   {
      
      public static const §_-n6§:int = 1;
      
      private var §_-2o8§:§_-0S9§;
      
      private var _roomEngine:§_-3XY§ = null;
      
      private var §_-32n§:§_-no§ = null;
      
      private var §_-38§:§_-0Va§ = null;
      
      private var §_-49m§:§_-0Kr§ = null;
      
      private var §_-1B3§:§_-2Jj§ = null;
      
      private var §_-0xc§:§_-1vP§;
      
      private var §_-4XR§:§_-pC§ = null;
      
      private var _assets:§_-3dX§ = null;
      
      private var §_-0Bh§:§_-3Q9§ = null;
      
      private var §_-0up§:EventDispatcherWrapper;
      
      private var §_-0hH§:Boolean = true;
      
      private var §_-i7§:Array;
      
      private var _starling:Starling;
      
      private var _view3D:§_-3UO§;
      
      private var §_-4bV§:LayoutGroup;
      
      private var §_-3f8§:LayoutGroup;
      
      private var §_-3Rd§:§_-1Ia§;
      
      private var §_-1Yj§:§_-31O§;
      
      private var §_-4Fr§:§_-1t8§;
      
      private var §_-2UG§:int;
      
      private var §_-3OJ§:§_-2ma§;
      
      public function §_-2W2§(param1:§_-0S9§, param2:Starling, param3:§_-3UO§, param4:§_-3Q9§, param5:§_-3dX§)
      {
         super();
         §_-2o8§ = param1;
         _starling = param2;
         _view3D = param3;
         §_-0up§ = new EventDispatcherWrapper();
         §_-0Bh§ = param4;
         _assets = param5;
         §_-jA§();
      }
      
      public function get §_-22-§() : §_-3Q9§
      {
         return §_-0Bh§;
      }
      
      public function get sessionDataManager() : §_-no§
      {
         return §_-32n§;
      }
      
      public function get events() : IEventDispatcher
      {
         return §_-0up§;
      }
      
      public function get roomEngine() : §_-3XY§
      {
         return _roomEngine;
      }
      
      public function get §_-4Ej§() : §_-0Va§
      {
         return §_-38§;
      }
      
      public function get habboUI() : §_-0S9§
      {
         return §_-2o8§;
      }
      
      public function get §_-3lM§() : §_-0Kr§
      {
         return §_-49m§;
      }
      
      public function get localization() : §_-2Jj§
      {
         return §_-1B3§;
      }
      
      public function get session() : §_-3Q9§
      {
         return §_-0Bh§;
      }
      
      public function get connection() : §_-pC§
      {
         return §_-4XR§;
      }
      
      public function set connection(param1:§_-pC§) : void
      {
         §_-4XR§ = param1;
      }
      
      public function set sessionDataManager(param1:§_-no§) : void
      {
         §_-32n§ = param1;
      }
      
      public function set §_-4Ej§(param1:§_-0Va§) : void
      {
         §_-38§ = param1;
      }
      
      public function set §_-3lM§(param1:§_-0Kr§) : void
      {
         §_-49m§ = param1;
      }
      
      public function set localization(param1:§_-2Jj§) : void
      {
         §_-1B3§ = param1;
      }
      
      public function set §_-4Jh§(param1:§_-1vP§) : void
      {
         §_-0xc§ = param1;
         §_-0xc§.§_-1Sp§(§_-kG§);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(§_-3Rd§)
         {
            §_-3Rd§.visible = param1;
         }
         if(_view3D)
         {
            _view3D.visible = param1;
         }
         if(§_-3Rd§)
         {
            §_-3Rd§.visible = param1;
         }
         if(§_-4bV§)
         {
            §_-4bV§.visible = param1;
         }
         if(§_-1Yj§)
         {
            §_-1Yj§.visible = param1;
         }
         Core.§_-0R5§.§_-1NN§();
      }
      
      public function set roomEngine(param1:§_-3XY§) : void
      {
         _roomEngine = param1;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",§_-1wX§);
            _roomEngine.events.addEventListener("RCLE_FAILURE",§_-1wX§);
            _roomEngine.events.addEventListener("RCLE_CANCEL",§_-1wX§);
            _roomEngine.events.addEventListener("RETWE_OPEN_WIDGET",§_-34L§);
         }
      }
      
      private function §_-jA§() : void
      {
         var _loc2_:§_-49B§ = _view3D.camera;
         _loc2_.position = new Vector3D();
         _loc2_.rotationX = 30;
         _loc2_.rotationY = -45;
         var _loc1_:Number = _view3D.height / (32 * 1.4142135623730951);
         _loc2_.§_-5w§ = new §_-3Az§(_loc1_);
         _loc2_.§_-5w§.near = -500;
         _loc2_.§_-5w§.far = 500;
      }
      
      public function dispose() : void
      {
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.removeEventListener("RCLE_SUCCESS",§_-1wX§);
            _roomEngine.events.removeEventListener("RCLE_FAILURE",§_-1wX§);
            _roomEngine.events.removeEventListener("RCLE_CANCEL",§_-1wX§);
            _roomEngine.events.removeEventListener("RETWE_OPEN_WIDGET",§_-34L§);
         }
         if(§_-1Yj§)
         {
            §_-1Yj§.dispose();
            §_-1Yj§ = null;
         }
         if(§_-4Fr§)
         {
            §_-4Fr§.dispose();
            §_-4Fr§ = null;
         }
         if(§_-3Rd§)
         {
            if(§_-3Rd§ is §_-1eU§)
            {
               §_-2o8§.removeUpdateReceiver(§_-3Rd§ as §_-1eU§);
            }
            §_-3Rd§.dispose();
            §_-3Rd§ = null;
         }
         if(_view3D)
         {
            _view3D.removeChildren();
            _view3D = null;
         }
         if(§_-3f8§)
         {
            §_-3f8§.removeFromParent();
            §_-3f8§.dispose();
            §_-3f8§ = null;
         }
         if(§_-4bV§)
         {
            §_-4bV§.dispose();
            §_-4bV§ = null;
         }
         if(§_-0xc§)
         {
            §_-0xc§.§_-3NO§(§_-kG§);
            §_-0xc§ = null;
         }
         §_-2ih§();
         §_-2o8§ = null;
         _assets = null;
         §_-0up§ = null;
         §_-0Bh§ = null;
         _starling = null;
         §_-4XR§ = null;
         _roomEngine = null;
         §_-1B3§ = null;
         §_-i7§ = null;
         §_-38§ = null;
         §_-32n§ = null;
         §_-49m§ = null;
      }
      
      public function init() : void
      {
         if(_roomEngine != null && §_-0Bh§ != null)
         {
            §_-i7§ = [];
            if(§_-i7§.length > 0)
            {
               §_-0hH§ = false;
            }
            else if(§_-i7§.length == 0)
            {
               §_-0hH§ = true;
               §_-49c§();
            }
         }
      }
      
      private function §_-1wX§(param1:§_-2WW§) : void
      {
         if(§_-i7§ == null || §_-i7§.length == 0)
         {
            return;
         }
         var _loc2_:int = §_-i7§.indexOf(param1.contentType);
         if(_loc2_ != -1)
         {
            §_-i7§.splice(_loc2_,1);
         }
         if(§_-i7§.length == 0)
         {
            §_-0hH§ = true;
            §_-49c§();
         }
      }
      
      private function §_-49c§() : Boolean
      {
         if(§_-38§ != null && §_-0Bh§ != null && §_-0hH§)
         {
            §_-1Yj§ = new §_-31O§(this);
            §_-38§.§_-1fH§(§_-0Bh§);
            return true;
         }
         return false;
      }
      
      public function §_-1oc§(param1:int = 1) : void
      {
         if(§_-0Bh§ == null || _roomEngine == null)
         {
            return;
         }
         if(§_-4bV§)
         {
            throw new Error("Tried to create room view more than once!");
         }
         var _loc5_:int = _starling.stage.stageWidth;
         var _loc6_:int = _starling.stage.stageHeight;
         §_-1Tv§.§_-0R5§.reset();
         §_-4bV§ = new LayoutGroup();
         §_-4bV§.layout = new §_-1mt§();
         §_-3Rd§ = _roomEngine.createRoomCanvas3d(§_-0Bh§.roomId,param1,_loc5_,_loc6_,64);
         (§_-3Rd§ as Object).roomEngine = _roomEngine;
         (§_-3Rd§ as Object).desktop = this;
         §_-3Rd§.§_-2SW§ = _view3D.camera;
         §_-4bV§.addChild(§_-3Rd§.§_-GL§);
         if(§_-3Rd§ is §_-1eU§)
         {
            §_-2o8§.registerUpdateReceiver(§_-3Rd§ as §_-1eU§,0);
         }
         §_-4Fr§ = new §_-1t8§(this,§_-2o8§,§_-49m§,§_-38§,_roomEngine,§_-1B3§,§_-2o8§.communication);
         var _loc2_:§_-0cZ§ = §_-4Fr§.§_-3x4§.canvas;
         _loc2_.layoutData = new §_-BX§(0,0,0,0);
         §_-4bV§.addChild(_loc2_);
         var _loc3_:§_-0cZ§ = §_-4Fr§.§_-3kF§.view;
         var _loc4_:Boolean = §_-2mJ§.§_-17Z§() == 0;
         var _loc7_:int = 0;
         _loc3_.layoutData = new §_-BX§(NaN,NaN,§_-2mJ§.§_-17E§(20),NaN,_loc7_);
         §_-3f8§ = new LayoutGroup();
         §_-3f8§.layout = new §_-1mt§();
         §_-3f8§.layoutData = new §_-BX§(0,0,0,0);
         §_-4bV§.addChild(§_-3f8§);
         _view3D.scene.addChild(§_-3Rd§.§_-12Z§);
         §_-1Yj§.§_-iM§();
         §_-0yk§(_loc5_,_loc6_);
         if(!§_-2o8§.toolbar)
         {
            §_-2o8§.§_-41J§();
         }
         §_-2o8§.toolbar.§_-4jK§(_loc3_);
      }
      
      public function §_-0yk§(param1:int, param2:int) : void
      {
         §_-4bV§.width = param1;
         §_-4bV§.height = param2;
         if(§_-3Rd§)
         {
            §_-3Rd§.§_-1X4§(param1,param2);
         }
      }
      
      public function get §_-3uX§() : Sprite
      {
         return §_-4bV§;
      }
      
      public function get §_-2Ni§() : LayoutGroup
      {
         return §_-3f8§;
      }
      
      public function §_-1w9§() : void
      {
         §_-4Fr§.§_-3x4§.canvas.visible = !§_-4Fr§.§_-3x4§.canvas.visible;
      }
      
      public function §_-OJ§(param1:uint, param2:int) : void
      {
      }
      
      public function §_-YU§(param1:int, param2:int, param3:int) : void
      {
         §_-2UG§ = §_-0By§.§_-1Bw§(((param1 & 0xFF) << 16) + ((param2 & 0xFF) << 8) + (param3 & 0xFF));
      }
      
      public function get §_-2jo§() : uint
      {
         return §_-2UG§;
      }
      
      public function §_-39Z§() : Boolean
      {
         return §_-1Yj§.§_-39Z§();
      }
      
      public function §_-025§() : void
      {
         if(§_-1Yj§)
         {
            §_-1Yj§.§_-025§();
         }
      }
      
      public function §_-QW§(param1:Vector.<§_-Ro§>, param2:Point) : void
      {
         if(!§_-2PB§() && param1.length == 1 && §_-38§.§_-4ke§().§_-1Ti§)
         {
            §_-3ir§(param1[0]);
         }
         else
         {
            §_-1Yj§.§_-QW§(param1,param2);
         }
         §_-1Yj§.§_-1pQ§();
      }
      
      public function §_-39J§() : void
      {
         §_-1Yj§.§_-39J§();
      }
      
      public function §_-3ir§(param1:§_-Ro§) : void
      {
         switch(param1.§_-3YM§())
         {
            case 10:
            case 20:
               §_-N2§(param1);
               break;
            case 100:
               §_-3MB§(param1);
         }
      }
      
      private function §_-N2§(param1:§_-Ro§) : void
      {
         if(§_-2PB§())
         {
            §_-40o§(param1.getId());
            return;
         }
         §_-2o8§.§_-47D§();
         if(§_-1L9§())
         {
            §_-oE§(param1);
         }
         else
         {
            useObject(param1);
         }
      }
      
      public function §_-3MB§(param1:§_-Ro§) : void
      {
         var _loc6_:* = null;
         var _loc4_:Boolean = false;
         var _loc3_:int = param1.getId();
         var _loc2_:§_-1vT§ = §_-38§.§_-4ke§().§_-2gp§.§_-0uJ§(_loc3_);
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:int;
         switch((_loc5_ = _loc2_.type) - 1)
         {
            case 0:
               §_-1uW§(_loc2_);
               break;
            case 1:
               _loc4_ = §_-2o8§.getBoolean("pet.training.enabled");
               if(_loc4_)
               {
                  §_-38§.§_-4ke§().§_-2gp§.§_-3PQ§(_loc2_.§_-1GP§);
               }
               break;
            case 2:
            case 3:
               if(§_-38§.§_-4ke§().§_-0lf§)
               {
                  §_-1LX§(_loc2_.§_-1GP§);
               }
               break;
            default:
               Logger.log("Unknown user type for object activation: " + _loc5_);
         }
      }
      
      public function useObject(param1:§_-Ro§) : void
      {
         var _loc3_:int = 0;
         var _loc2_:§_-1QB§ = null;
         var _loc4_:§_-va§ = param1.getModel();
         var _loc5_:Boolean = §_-ZQ§(param1);
         if(_loc4_)
         {
            _loc3_ = _loc4_.getNumber("furniture_guild_customized_guild_id");
            if(_loc3_ > 0 && !_loc5_)
            {
               §_-2o8§.§_-14C§(_loc3_);
               return;
            }
         }
         if(§_-1L9§() || _loc5_)
         {
            if(_loc3_ > 0)
            {
               §_-2o8§.§_-14C§(_loc3_);
            }
            else
            {
               _loc2_ = param1 as §_-1QB§;
               _loc2_.getEventHandler().useObject();
            }
         }
      }
      
      private function §_-1L9§() : Boolean
      {
         return §_-38§.§_-4ke§().§_-1Ti§;
      }
      
      private function §_-ZQ§(param1:§_-Ro§) : Boolean
      {
         var _loc2_:§_-va§ = param1.getModel();
         return _loc2_.getNumber("furniture_usage_policy") > 0;
      }
      
      public function §_-FS§(param1:int) : void
      {
         var _loc3_:§_-1vT§ = null;
         var _loc2_:§_-W7§ = §_-38§.getSession(_roomEngine.§_-0Y§).§_-2gp§;
         if(_loc2_)
         {
            _loc3_ = _loc2_.§_-0uJ§(param1);
            if(_loc3_)
            {
               §_-2o8§.§_-83§(_loc3_.§_-1GP§,"mode_room");
            }
         }
      }
      
      public function §_-1uW§(param1:§_-1vT§) : void
      {
         if(§_-32n§.userId != param1.§_-1GP§)
         {
            §_-1Yj§.§_-2hi§(param1);
         }
         else
         {
            §_-2o8§.§_-cR§();
         }
      }
      
      public function §_-0NF§() : void
      {
         §_-2ih§();
         §_-3OJ§ = new §_-2ma§(this);
         §_-1OE§.§_-3Dk§(§_-3OJ§.view);
      }
      
      public function §_-2ih§() : void
      {
         if(§_-3OJ§)
         {
            if(§_-1OE§.§_-Kk§(§_-3OJ§.view))
            {
               §_-1OE§.§_-4gZ§(§_-3OJ§.view);
            }
            §_-3OJ§.dispose();
            §_-3OJ§ = null;
         }
      }
      
      public function §_-Kq§() : void
      {
         §_-1OE§.§_-3Dk§(§_-4Fr§.§_-2Bd§.view,true,true,§_-4Fr§.§_-2Bd§.§_-1n0§);
      }
      
      public function §_-0KM§(param1:§_-3Ks§) : Boolean
      {
         if(param1 == null || §_-1Yj§ == null || §_-3f8§ == null || _roomEngine == null)
         {
            return false;
         }
         switch(param1.type)
         {
            case "REOE_SELECTED":
               §_-39J§();
               break;
            case "REOE_ADDED":
            case "REOE_REMOVED":
               break;
            case "REOE_DESELECTED":
               §_-39J§();
               §_-1Yj§.§_-1pQ§();
               break;
            case "RoomEngineObjectInsertInitialized":
               §_-3cJ§(param1 as §_-0I2§);
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function §_-3cJ§(param1:§_-0I2§) : void
      {
         var _loc2_:§_-Ro§ = _roomEngine.§_-46h§(_roomEngine.§_-0Y§,param1.objectId,param1.category);
         §_-1Yj§.§_-4dp§(_loc2_,param1.§_-Cz§,param1.§_-27w§);
         §_-2o8§.§_-38x§(1);
         §_-2o8§.toolbar.§_-09l§(_loc2_,param1.§_-27w§);
      }
      
      public function §_-41F§(param1:int, param2:int, param3:String) : void
      {
         §_-1Yj§.§_-41F§(param1,param2,param3);
      }
      
      private function §_-kG§(param1:Event) : void
      {
         var _loc3_:§_-59§ = null;
         var _loc4_:§_-um§ = null;
         var _loc5_:§_-48P§ = null;
         var _loc7_:§_-4iw§ = null;
         var _loc2_:§_-2hU§ = null;
         var _loc6_:§_-1ja§ = null;
         switch(param1.type)
         {
            case "ROWRE__CREDITFURNI":
               _loc4_ = §_-1Yj§.§_-0jA§();
               _loc4_.§_-3qY§(param1);
               break;
            case "ROWRE__STICKIE":
            case "ROFCAE_STICKIE":
               _loc5_ = §_-1Yj§.§_-2Gm§();
               _loc5_.§_-3qY§(param1);
               break;
            case "ROWRE_PRESENT":
               _loc7_ = §_-1Yj§.§_-0id§();
               _loc7_.§_-3qY§(param1);
               break;
            case "ROWRE_ROOM_LINK":
               _loc2_ = §_-1Yj§.§_-0fN§();
               _loc2_.§_-3qY§(param1);
               break;
            case "ROWRE_PET_PRODUCT_MENU":
               _loc6_ = §_-1Yj§.§_-2l9§();
               _loc6_.§_-3qY§(param1 as §_-2LR§);
               break;
            case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
               _loc3_ = §_-1Yj§.§_-2DY§();
               _loc3_.§_-3qY§(param1 as §_-2LR§);
               break;
            case "ROWRE_FRIEND_FURNITURE_CONFIRM":
               _loc3_ = §_-1Yj§.§_-2DY§();
               _loc3_.§_-3qY§(param1 as §_-2LR§);
         }
      }
      
      private function §_-34L§(param1:§_-37J§) : void
      {
         var _loc2_:§_-Ro§ = null;
         if(param1.type == "RETWE_OPEN_WIDGET")
         {
            switch(param1.widget)
            {
               case "RWE_EXTERNAL_IMAGE":
                  _loc2_ = _roomEngine.§_-46h§(param1.roomId,param1.objectId,param1.category);
                  §_-1Yj§.§_-0d8§(_loc2_);
                  break;
               case "RWE_CRAFTING":
                  §_-1Yj§.§_-4UF§(param1.objectId);
            }
         }
      }
      
      public function §_-4u§(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:§_-4iw§ = §_-1Yj§.§_-0id§();
         _loc4_.§_-2Wu§(param1,param2,param3);
         §_-1Yj§.§_-3tg§();
      }
      
      public function §_-Oa§(param1:int) : void
      {
         var _loc2_:§_-59§ = §_-1Yj§.§_-2DY§();
         §_-4XR§.send(new §_-2qj§(param1,false));
      }
      
      public function §_-rM§(param1:int, param2:Boolean) : void
      {
         var _loc3_:§_-59§ = §_-1Yj§.§_-2DY§();
         if(_loc3_)
         {
            if(param2)
            {
               _loc3_.§_-k8§(param1);
            }
            else
            {
               _loc3_.§_-1d2§(param1);
            }
         }
      }
      
      public function get §_-Im§() : §_-1Ia§
      {
         return §_-3Rd§;
      }
      
      public function get chat() : §_-1t8§
      {
         return §_-4Fr§;
      }
      
      public function §_-1n-§() : void
      {
         §_-1Yj§.§_-3tg§();
      }
      
      public function §_-11s§() : void
      {
         §_-1Yj§.§_-11s§();
      }
      
      public function §_-42K§(param1:String, param2:String, param3:String) : void
      {
         §_-1Yj§.§_-42K§(param1,param2,param3);
      }
      
      public function §_-oE§(param1:§_-Ro§) : void
      {
         roomEngine.§_-0nC§(roomEngine.§_-0Y§,param1.getId(),param1.§_-3YM§(),"OBJECT_MOVE");
         §_-1Yj§.§_-1k3§(param1);
      }
      
      public function §_-3kB§(param1:§_-1W5§) : void
      {
         §_-1Yj§.§_-3kB§(param1);
      }
      
      public function §_-10x§(param1:int, param2:int) : void
      {
         §_-1Yj§.§_-10x§(param1,param2);
      }
      
      public function §_-1LX§(param1:int) : void
      {
         §_-1Yj§.§_-1LX§(param1);
      }
      
      public function §_-1sy§() : void
      {
         §_-1Yj§.camera.§_-1iJ§();
      }
      
      public function §_-32X§() : void
      {
         §_-1Yj§.§_-32X§();
      }
      
      public function §_-325§() : void
      {
         var _loc1_:§_-3zh§ = §_-1Yj§.§_-483§;
         if(_loc1_)
         {
            _loc1_.close();
         }
      }
      
      public function §_-40o§(param1:int) : void
      {
         if(§_-1Yj§.§_-483§)
         {
            §_-1Yj§.§_-483§.§_-40o§(param1);
         }
      }
      
      public function §_-2PB§() : Boolean
      {
         var _loc1_:§_-3zh§ = §_-1Yj§.§_-483§;
         if(_loc1_ && _loc1_.§_-pu§())
         {
            return _loc1_.§_-06T§().parent != null;
         }
         return false;
      }
   }
}

