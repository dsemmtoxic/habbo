package §_-pp§
{
   import §_-0KT§.CoreComponentContext;
   import §_-0Xf§.§_-0ha§;
   import §_-0iC§.§_-1mt§;
   import §_-0iC§.§_-pG§;
   import §_-1WP§.§_-0q3§;
   import §_-2xS§.LayoutGroup;
   import flash.text.TextField;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   import starling.events.Event;
   
   public class §_-2o9§ implements §_-0q3§
   {
      
      public static const §_-1D1§:int = 0;
      
      public static const §_-0uo§:int = 1;
      
      public static const §_-4Qx§:int = 2;
      
      private static const §_-1yM§:int = 1;
      
      private static const §_-27M§:int = 2;
      
      private static const §_-3WN§:int = 3;
      
      private static const §_-3fI§:Array = [1,2,3];
      
      private var §_-33k§:§_-0S9§;
      
      private var _starling:Starling;
      
      private var §_-Lk§:LayoutGroup;
      
      private var §_-2Q4§:LayoutGroup;
      
      private var §_-3-Q§:LayoutGroup;
      
      private var §_-1vq§:LayoutGroup;
      
      private var §_-13I§:Vector.<§_-0ha§>;
      
      private var §_-0gJ§:§_-0ha§;
      
      private var §_-1Ya§:TextField;
      
      private var §_-02-§:Vector.<int>;
      
      public function §_-2o9§(param1:§_-0S9§, param2:Starling)
      {
         super();
         §_-33k§ = param1;
         _starling = param2;
         §_-3NH§();
         §_-2Rx§();
         §_-33k§.context.addLinkEventTracker(this);
      }
      
      private function §_-2Rx§() : void
      {
         §_-13I§ = new Vector.<§_-0ha§>();
         §_-13I§.push(new §_-0ha§(-2,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(-1,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(1,[1,2,3],new <uint>[791578]));
         §_-13I§.push(new §_-0ha§(2,[1],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(3,[1],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(4,[1],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(5,[1],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(7,[1],new Vector.<uint>(0),false));
         §_-13I§.push(new §_-0ha§(9,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(8,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(10,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(11,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(12,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(13,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(15,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(16,[1,3],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(17,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(18,[1],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(19,[],new Vector.<uint>(0)));
         §_-13I§.push(new §_-0ha§(20,[1],new Vector.<uint>(0)));
         §_-02-§ = new Vector.<int>();
      }
      
      public function §_-38x§(param1:int, param2:Boolean = false, param3:Boolean = true) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = 0;
         if(§_-33k§.§_-LD§)
         {
            return;
         }
         if(param2)
         {
            §_-3XL§(param1);
         }
         if(param3)
         {
            §_-33k§.§_-47D§();
         }
         for each(var _loc8_:§_-0ha§ in §_-13I§)
         {
            if(_loc8_.id != param1)
            {
               §_-oX§(_loc8_.id);
            }
            else
            {
               §_-0gJ§ = _loc8_;
            }
         }
         §_-7-§(param1);
         var _loc6_:Array = §_-0gJ§.§_-0Ti§;
         for each(_loc5_ in §_-3fI§)
         {
            if(_loc6_.indexOf(_loc5_) == -1)
            {
               §_-15A§(_loc5_);
            }
         }
         var _loc7_:Vector.<uint> = §_-0gJ§.§_-sr§;
         if(_loc7_ && _loc7_.length > 0)
         {
            _loc4_ = _loc7_.length > 1 ? _loc7_[1] : _loc7_[0];
            (§_-33k§.context.root as CoreComponentContext).§_-11l§(_loc7_[0],_loc4_);
         }
         else
         {
            (§_-33k§.context.root as CoreComponentContext).§_-1EC§("image");
         }
         for each(_loc5_ in _loc6_)
         {
            §_-1LF§(_loc5_);
         }
      }
      
      private function §_-3XL§(param1:int) : void
      {
         if(!§_-0gJ§ || §_-0gJ§.id == 16 || §_-0gJ§.id <= 1)
         {
            return;
         }
         if(§_-0gJ§.id != param1 && §_-02-§.indexOf(§_-0gJ§.id) == -1)
         {
            §_-02-§.push(§_-0gJ§.id);
         }
      }
      
      public function §_-26u§() : void
      {
         var _loc1_:int = 0;
         if(§_-02-§.length == 0)
         {
            if(§_-33k§.desktop)
            {
               §_-38x§(1);
            }
            else
            {
               §_-38x§(16);
            }
         }
         else
         {
            _loc1_ = §_-02-§.pop();
            §_-38x§(_loc1_,false,§_-0gJ§.§_-47D§);
         }
      }
      
      private function §_-7-§(param1:int) : void
      {
         switch(param1)
         {
            case 2:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Navigator");
               §_-08s§(§_-33k§.navigator,"NAVIGATOR",true);
               break;
            case 3:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Inventory");
               §_-08s§(§_-33k§.inventory,"INVENTORY",true);
               break;
            case 4:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Catalog");
               §_-33k§.catalog.§_-bK§("NORMAL");
               §_-08s§(§_-33k§.catalog,"CATALOG",true);
               break;
            case 20:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Catalog");
               §_-33k§.catalog.§_-bK§("BUILDERS_CLUB");
               §_-08s§(§_-33k§.catalog,"CATALOG",true);
               break;
            case 7:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","AvatarEditor");
               §_-08s§(§_-33k§.avatarEditor);
               break;
            case 9:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Help");
               §_-08s§(§_-33k§.help as §_-s6§);
               break;
            case 5:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Friends");
               §_-08s§(§_-33k§.§_-0dH§,"FRIENDS",true);
               break;
            case 8:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Accounts");
               §_-f-§();
               break;
            case 10:
               §_-08s§(§_-33k§.catalog.§_-1Uq§);
               break;
            case 13:
               if(!§_-33k§.§_-4Ej§.§_-4ke§())
               {
                  §_-38x§(1);
                  return;
               }
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Wired");
               §_-08s§(§_-33k§.§_-4KK§);
               break;
            case 11:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","SMS Verification");
               §_-08s§(§_-33k§.§_-4h5§);
               break;
            case 12:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Citizenship");
               §_-08s§(§_-33k§.citizenship,null,true);
               break;
            case 14:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Safetylock");
               §_-08s§(§_-33k§.§_-0i6§);
               break;
            case 15:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Campaign");
               §_-08s§(§_-33k§.§_-18A§);
               break;
            case 17:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","HCCenter");
               §_-08s§(§_-33k§.§_-2jg§);
               break;
            case 1:
               if(§_-33k§.desktop)
               {
                  §_-3Or§();
                  §_-2YN§();
               }
               else
               {
                  §_-U6§();
                  §_-0Om§();
               }
               break;
            case 16:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Landingview");
               §_-cg§();
               break;
            case 18:
               §_-33k§.tracking.trackGoogle("Application","OPEN_VIEW","Whats New");
               §_-08s§(§_-33k§.§_-4Ud§,"WHATS_NEW",true);
               break;
            case 19:
               §_-08s§(§_-33k§.§_-1Ci§);
         }
         §_-33k§.events.dispatchEvent(new §_-29F§("main-view-changed",param1));
      }
      
      private function §_-oX§(param1:int) : void
      {
         switch(param1)
         {
            case 2:
               §_-3JI§(§_-33k§.navigator,"NAVIGATOR");
               break;
            case 3:
               §_-3JI§(§_-33k§.inventory,"INVENTORY");
               break;
            case 20:
            case 4:
               §_-3JI§(§_-33k§.catalog,"CATALOG");
               break;
            case 5:
               §_-3JI§(§_-33k§.§_-0dH§,"FRIENDS");
               break;
            case 7:
               §_-3JI§(§_-33k§.avatarEditor);
               break;
            case 9:
               §_-3JI§(§_-33k§.help as §_-s6§);
               break;
            case 10:
               §_-3JI§(§_-33k§.catalog.§_-1Uq§);
               break;
            case 13:
               §_-3JI§(§_-33k§.§_-4KK§);
               break;
            case 11:
               §_-3JI§(§_-33k§.§_-4h5§);
               break;
            case 12:
               §_-1vq§.removeChild(§_-Lk§);
               §_-3JI§(§_-33k§.citizenship);
               break;
            case 14:
               §_-3JI§(§_-33k§.§_-0i6§);
               break;
            case 15:
               §_-3JI§(§_-33k§.§_-18A§);
               break;
            case 17:
               §_-3JI§(§_-33k§.§_-2jg§);
               break;
            case 1:
               §_-U6§();
               §_-3Or§();
               break;
            case 16:
               §_-3c1§();
               break;
            case 18:
               §_-3JI§(§_-33k§.§_-4Ud§,"WHATS_NEW");
               break;
            case 19:
               §_-3JI§(§_-33k§.§_-1Ci§);
         }
      }
      
      private function §_-1LF§(param1:int) : void
      {
         switch(param1 - 1)
         {
            case 0:
               §_-33k§.§_-41J§();
               break;
            case 1:
               §_-33k§.§_-nQ§();
               break;
            case 2:
               §_-33k§.§_-kY§(true);
         }
      }
      
      private function §_-15A§(param1:int) : void
      {
         switch(param1 - 1)
         {
            case 0:
               §_-2qV§();
               break;
            case 1:
               §_-33k§.§_-1A4§();
               break;
            case 2:
               §_-33k§.§_-kY§(false);
         }
      }
      
      public function get §_-419§() : int
      {
         return §_-0gJ§ ? §_-0gJ§.id : -2;
      }
      
      public function §_-Vx§() : Boolean
      {
         if(§_-02-§.length == 0)
         {
            return false;
         }
         §_-26u§();
         return true;
      }
      
      private function §_-2qV§() : void
      {
         §_-33k§.§_-2qV§();
      }
      
      private function §_-2YN§() : void
      {
         if(!§_-33k§.desktop || !§_-33k§.desktop.§_-3uX§)
         {
            return;
         }
         if(!§_-33k§.desktop.§_-3uX§.parent)
         {
            §_-3-Q§.addChild(§_-33k§.desktop.§_-3uX§);
         }
         §_-33k§.desktop.visible = true;
         if(§_-33k§.desktop.§_-Im§)
         {
            §_-33k§.desktop.§_-Im§.resume();
         }
      }
      
      private function §_-U6§() : void
      {
         if(!§_-33k§.desktop)
         {
            return;
         }
         §_-33k§.desktop.visible = false;
         if(§_-33k§.desktop.§_-Im§)
         {
            §_-33k§.desktop.§_-Im§.pause();
         }
      }
      
      private function §_-f-§() : void
      {
         §_-33k§.§_-f-§();
      }
      
      private function §_-cg§() : void
      {
         §_-33k§.§_-cg§();
      }
      
      private function §_-3c1§() : void
      {
         §_-33k§.§_-3c1§();
      }
      
      private function §_-0Om§() : void
      {
         §_-33k§.§_-0Om§();
      }
      
      private function §_-3Or§() : void
      {
         §_-33k§.§_-3Or§();
      }
      
      private function §_-08s§(param1:§_-s6§, param2:String = null, param3:Boolean = false) : void
      {
         if(param1 != null)
         {
            if(param3)
            {
               §_-1vq§.addChildAt(§_-Lk§,0);
            }
            param1.§_-0m-§(§_-1vq§);
            if(§_-33k§.toolbar && param2 != null)
            {
               §_-33k§.toolbar.§_-3Tp§(param2,true);
            }
         }
      }
      
      private function §_-3JI§(param1:§_-s6§, param2:String = null) : void
      {
         if(param1 != null)
         {
            param1.§_-Lh§();
            §_-1vq§.removeChild(§_-Lk§);
            if(§_-33k§.toolbar && param2 != null)
            {
               §_-33k§.toolbar.§_-3Tp§(param2,false);
            }
         }
      }
      
      public function §_-3NH§() : void
      {
         var _loc3_:§_-pG§ = null;
         var _loc1_:int = _starling.stage.stageWidth;
         var _loc2_:int = _starling.stage.stageHeight;
         if(§_-Lk§ == null)
         {
            §_-Lk§ = new LayoutGroup();
            §_-Lk§.backgroundSkin = new Quad(2,2,0);
            §_-Lk§.alpha = 0.5;
            §_-Lk§.width = _loc1_;
            §_-Lk§.height = _loc2_;
         }
         if(§_-2Q4§ == null)
         {
            §_-2Q4§ = new LayoutGroup();
            §_-2Q4§.clipContent = false;
            _loc3_ = new §_-pG§();
            _loc3_.horizontalAlign = "center";
            _loc3_.verticalAlign = "middle";
            §_-2Q4§.layout = _loc3_;
            §_-2Q4§.width = _loc1_;
            §_-2Q4§.height = _loc2_;
         }
         (_starling.root as DisplayObjectContainer).addChild(§_-2Q4§);
         if(§_-3-Q§ == null)
         {
            §_-3-Q§ = new LayoutGroup();
            §_-3-Q§.layout = new §_-1mt§();
         }
         (_starling.root as DisplayObjectContainer).addChild(§_-3-Q§);
         if(§_-1vq§ == null)
         {
            §_-1vq§ = new LayoutGroup();
            §_-1vq§.layout = new §_-1mt§();
            §_-1vq§.width = _loc1_;
            §_-1vq§.height = _loc2_;
            §_-1vq§.isQuickHitAreaEnabled = false;
         }
         (_starling.root as DisplayObjectContainer).addChild(§_-1vq§);
         _starling.stage.addEventListener("resize",onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         var _loc3_:int = _starling.stage.stageWidth;
         var _loc4_:int = _starling.stage.stageHeight;
         var _loc5_:Array = [§_-1vq§,§_-2Q4§];
         for each(var _loc2_:DisplayObject in _loc5_)
         {
            _loc2_.width = _loc3_;
            _loc2_.height = _loc4_;
         }
         if(§_-33k§ && §_-33k§.desktop)
         {
            §_-33k§.desktop.§_-0yk§(_loc3_,_loc4_);
         }
      }
      
      public function §_-3d7§() : void
      {
      }
      
      public function dispose() : void
      {
         if(§_-13I§)
         {
            §_-13I§ = null;
         }
         if(§_-2Q4§)
         {
            §_-2Q4§.removeFromParent();
            §_-2Q4§.dispose();
            §_-2Q4§ = null;
         }
         if(§_-3-Q§)
         {
            §_-3-Q§.removeFromParent();
            §_-3-Q§.dispose();
            §_-3-Q§ = null;
         }
         if(§_-1vq§)
         {
            §_-1vq§.removeFromParent();
            §_-1vq§.dispose();
            §_-1vq§ = null;
         }
         if(_starling && _starling.stage)
         {
            _starling.stage.removeEventListener("resize",onResize);
         }
         _starling = null;
         §_-33k§ = null;
      }
      
      public function §_-0Qu§(param1:int) : DisplayObjectContainer
      {
         switch(param1)
         {
            case 0:
               return §_-2Q4§;
            case 1:
               return §_-3-Q§;
            case 2:
               return §_-1vq§;
            default:
               return null;
         }
      }
      
      public function get §_-2XA§() : String
      {
         return "openView/";
      }
      
      public function §_-Hx§(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "catalog":
               §_-38x§(4);
               break;
            case "citizenship":
               §_-38x§(12);
               break;
            case "avatarEditor":
               §_-38x§(7);
               break;
            case "calendar":
               §_-38x§(15);
               break;
            case "hccenter":
               §_-38x§(17);
         }
      }
   }
}

