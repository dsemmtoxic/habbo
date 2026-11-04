package §_-0xp§
{
   import §_-0m8§.§_-2N4§;
   import §_-2Zm§.§_-3UE§;
   import away3d.arcane;
   import flash.display.Shape;
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.display3D.Context3DClearMask;
   import flash.display3D.Program3D;
   import flash.display3D.textures.TextureBase;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   use namespace arcane;
   
   public class Stage3DProxy extends EventDispatcher
   {
      
      private static var §_-1b4§:Shape = new Shape();
      
      arcane var §_-In§:Context3D;
      
      arcane var _stage3DIndex:int = -1;
      
      private var §_-2Vr§:Boolean;
      
      private var §_-0dL§:String;
      
      private var _stage3D:Stage3D;
      
      private var §_-4K2§:Program3D;
      
      private var _stage3DManager:Stage3DManager;
      
      private var §_-0EJ§:int;
      
      private var §_-04S§:int;
      
      private var §_-07n§:int;
      
      private var §_-0mp§:Boolean;
      
      private var §_-I4§:Boolean = true;
      
      private var §_-3bK§:Boolean;
      
      private var §_-4Iu§:TextureBase;
      
      private var §_-0H3§:int;
      
      private var §_-108§:Rectangle;
      
      private var _color:uint;
      
      private var §_-3PZ§:Boolean;
      
      private var §_-8h§:Rectangle;
      
      private var §_-FT§:Event;
      
      private var §_-TF§:Event;
      
      private var §_-0Vu§:§_-2N4§;
      
      private var §_-4ZC§:Boolean;
      
      private var §_-gw§:Boolean;
      
      private var §_-1SV§:§_-3gQ§;
      
      private var §_-3py§:§_-0SC§;
      
      public function Stage3DProxy(param1:int, param2:Stage3D, param3:Stage3DManager, param4:Boolean = false, param5:String = "baseline")
      {
         super();
         arcane::_stage3DIndex = param1;
         _stage3D = param2;
         _stage3D.x = 0;
         _stage3D.y = 0;
         _stage3D.visible = true;
         _stage3DManager = param3;
         §_-8h§ = new Rectangle();
         §_-0mp§ = true;
         _stage3D.addEventListener("context3DCreate",§_-4Ug§,false,1000,false);
         §_-0zr§(param4,param5);
      }
      
      private function §_-0Sd§() : void
      {
         if(§_-4ZC§)
         {
            return;
         }
         §_-4ZC§ = true;
         if(!hasEventListener("ViewportUpdated"))
         {
            return;
         }
         §_-0Vu§ = new §_-2N4§("ViewportUpdated");
         dispatchEvent(§_-0Vu§);
      }
      
      private function §_-3t0§() : void
      {
         if(!hasEventListener("enterFrame"))
         {
            return;
         }
         if(!§_-FT§)
         {
            §_-FT§ = new Event("enterFrame");
         }
         dispatchEvent(§_-FT§);
      }
      
      private function §_-6A§() : void
      {
         if(!hasEventListener("exitFrame"))
         {
            return;
         }
         if(!§_-TF§)
         {
            §_-TF§ = new Event("exitFrame");
         }
         dispatchEvent(§_-TF§);
      }
      
      public function get profile() : String
      {
         return §_-0dL§;
      }
      
      public function dispose() : void
      {
         _stage3DManager.§_-0Wq§(this);
         _stage3D.removeEventListener("context3DCreate",§_-4Ug§);
         §_-4Xs§();
         _stage3D = null;
         _stage3DManager = null;
         _stage3DIndex = -1;
      }
      
      public function configureBackBuffer(param1:int, param2:int, param3:int) : void
      {
         if(param1 < 50)
         {
            param1 = 50;
         }
         if(param2 < 50)
         {
            param2 = 50;
         }
         var _loc5_:uint = uint(§_-0EJ§);
         var _loc4_:uint = uint(§_-04S§);
         §_-0EJ§ = §_-8h§.width = param1;
         §_-04S§ = §_-8h§.height = param2;
         if(_loc5_ != §_-0EJ§ || _loc4_ != §_-04S§)
         {
            §_-0Sd§();
         }
         §_-07n§ = param3;
         if(arcane::§_-In§)
         {
            arcane::§_-In§.configureBackBuffer(param1,param2,param3,§_-I4§);
         }
      }
      
      public function get §_-2SB§() : Boolean
      {
         return §_-0mp§;
      }
      
      public function set §_-2SB§(param1:Boolean) : void
      {
         §_-0mp§ = param1;
         §_-3PZ§ = true;
      }
      
      public function get renderTarget() : TextureBase
      {
         return §_-4Iu§;
      }
      
      public function get §_-4MV§() : int
      {
         return §_-0H3§;
      }
      
      public function setRenderTarget(param1:TextureBase, param2:Boolean = false, param3:int = 0) : void
      {
         if(§_-4Iu§ == param1 && param3 == §_-0H3§ && §_-0mp§ == param2)
         {
            return;
         }
         §_-4Iu§ = param1;
         §_-0H3§ = param3;
         §_-0mp§ = param2;
         if(param1)
         {
            arcane::§_-In§.setRenderToTexture(param1,param2,§_-07n§,param3);
         }
         else
         {
            arcane::§_-In§.setRenderToBackBuffer();
         }
      }
      
      public function clear() : void
      {
         if(!arcane::§_-In§)
         {
            return;
         }
         if(§_-3PZ§)
         {
            configureBackBuffer(§_-0EJ§,§_-04S§,§_-07n§);
            §_-3PZ§ = false;
         }
         arcane::§_-In§.clear((_color >> 16 & 0xFF) / 255,(_color >> 8 & 0xFF) / 255,(_color & 0xFF) / 255,(_color >> 24 & 0xFF) / 255);
         §_-gw§ = true;
      }
      
      public function present() : void
      {
         if(!arcane::§_-In§)
         {
            return;
         }
         arcane::§_-In§.present();
         §_-4K2§ = null;
         if(§_-1SV§)
         {
            §_-1SV§.§_-1Ii§();
         }
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if((param1 == "enterFrame" || param1 == "exitFrame") && !§_-1b4§.hasEventListener("enterFrame"))
         {
            §_-1b4§.addEventListener("enterFrame",onEnterFrame,param3,param4,param5);
         }
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
         if(!hasEventListener("enterFrame") && !hasEventListener("exitFrame") && §_-1b4§.hasEventListener("enterFrame"))
         {
            §_-1b4§.removeEventListener("enterFrame",onEnterFrame,param3);
         }
      }
      
      public function get scissorRect() : Rectangle
      {
         return §_-108§;
      }
      
      public function set scissorRect(param1:Rectangle) : void
      {
         §_-108§ = param1;
         arcane::§_-In§.setScissorRectangle(§_-108§);
      }
      
      public function get stage3DIndex() : int
      {
         return _stage3DIndex;
      }
      
      public function get stage3D() : Stage3D
      {
         return _stage3D;
      }
      
      public function get context3D() : Context3D
      {
         return arcane::§_-In§;
      }
      
      public function get driverInfo() : String
      {
         return arcane::§_-In§ ? arcane::§_-In§.driverInfo : null;
      }
      
      public function get §_-PH§() : Boolean
      {
         return §_-2Vr§;
      }
      
      public function get x() : Number
      {
         return _stage3D.x;
      }
      
      public function set x(param1:Number) : void
      {
         if(§_-8h§.x == param1)
         {
            return;
         }
         _stage3D.x = §_-8h§.x = param1;
         §_-0Sd§();
      }
      
      public function get y() : Number
      {
         return _stage3D.y;
      }
      
      public function set y(param1:Number) : void
      {
         if(§_-8h§.y == param1)
         {
            return;
         }
         _stage3D.y = §_-8h§.y = param1;
         §_-0Sd§();
      }
      
      public function get width() : int
      {
         return §_-0EJ§;
      }
      
      public function set width(param1:int) : void
      {
         if(§_-8h§.width == param1)
         {
            return;
         }
         if(param1 < 50)
         {
            param1 = 50;
         }
         §_-0EJ§ = §_-8h§.width = param1;
         §_-3PZ§ = true;
         §_-0Sd§();
      }
      
      public function get height() : int
      {
         return §_-04S§;
      }
      
      public function set height(param1:int) : void
      {
         if(§_-8h§.height == param1)
         {
            return;
         }
         if(param1 < 50)
         {
            param1 = 50;
         }
         §_-04S§ = §_-8h§.height = param1;
         §_-3PZ§ = true;
         §_-0Sd§();
      }
      
      public function get §_-0FJ§() : int
      {
         return §_-07n§;
      }
      
      public function set §_-0FJ§(param1:int) : void
      {
         §_-07n§ = param1;
         §_-3PZ§ = true;
      }
      
      public function get viewPort() : Rectangle
      {
         §_-4ZC§ = false;
         return §_-8h§;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get visible() : Boolean
      {
         return _stage3D.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _stage3D.visible = param1;
      }
      
      public function get §_-36M§() : Boolean
      {
         return §_-gw§;
      }
      
      public function set §_-36M§(param1:Boolean) : void
      {
         §_-gw§ = param1;
      }
      
      public function get §_-2Ik§() : §_-3gQ§
      {
         return §_-1SV§;
      }
      
      public function set §_-2Ik§(param1:§_-3gQ§) : void
      {
         §_-1SV§ = param1;
      }
      
      public function get §_-4Ga§() : §_-0SC§
      {
         return §_-3py§;
      }
      
      public function set §_-4Ga§(param1:§_-0SC§) : void
      {
         §_-3py§ = param1;
      }
      
      private function §_-4Xs§() : void
      {
         if(arcane::§_-In§)
         {
            arcane::§_-In§.dispose();
            dispatchEvent(new §_-2N4§("Context3DDisposed"));
         }
         §_-In§ = null;
      }
      
      private function §_-4Ug§(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(_stage3D.context3D)
         {
            _loc2_ = arcane::§_-In§ != null;
            §_-In§ = _stage3D.context3D;
            §_-0dL§ = arcane::§_-In§.profile;
            arcane::§_-In§.enableErrorChecking = §_-3UE§.active;
            §_-2Vr§ = arcane::§_-In§.driverInfo.indexOf("Software") == 0;
            if(§_-0EJ§ && §_-04S§)
            {
               arcane::§_-In§.configureBackBuffer(§_-0EJ§,§_-04S§,§_-07n§,§_-I4§);
            }
            dispatchEvent(new §_-2N4§(_loc2_ ? "Context3DRecreated" : "Context3DCreated"));
            return;
         }
         throw new Error("Rendering context lost!");
      }
      
      private function §_-0zr§(param1:Boolean = false, param2:String = "baseline") : void
      {
         var _loc4_:* = undefined;
         if(!§_-2Vr§)
         {
            §_-2Vr§ = param1;
         }
         §_-0dL§ = param2;
         var _loc3_:String = param1 ? "software" : "auto";
         if(param2 == "baseline")
         {
            _stage3D.requestContext3D(_loc3_);
         }
         else
         {
            try
            {
               if(param2 != "auto")
               {
                  _stage3D["requestContext3D"](_loc3_,param2);
               }
               else
               {
                  _loc4_ = new Vector.<String>();
                  _loc4_.push("baselineExtended");
                  _loc4_.push("baseline");
                  _loc4_.push("baselineConstrained");
                  _stage3D["requestContext3DMatchingProfiles"](_loc4_);
               }
            }
            catch(error:Error)
            {
               throw "An error occurred creating a context using the given profile. Profiles are not supported for the SDK this was compiled with.";
            }
         }
         §_-3bK§ = true;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!arcane::§_-In§)
         {
            return;
         }
         clear();
         §_-3t0§();
         present();
         §_-6A§();
      }
      
      public function §_-3hs§() : Boolean
      {
         if(!arcane::§_-In§)
         {
            return false;
         }
         if(arcane::§_-In§.driverInfo == "Disposed")
         {
            §_-In§ = null;
            dispatchEvent(new §_-2N4§("Context3DDisposed"));
            return false;
         }
         return true;
      }
      
      public function §_-4P1§() : void
      {
         if(!arcane::§_-In§)
         {
            return;
         }
         arcane::§_-In§.clear(0,0,0,1,1,0,Context3DClearMask.DEPTH);
      }
      
      public function get §_-1pl§() : Boolean
      {
         return §_-I4§;
      }
      
      public function set §_-1pl§(param1:Boolean) : void
      {
         §_-I4§ = param1;
         §_-3PZ§ = true;
      }
   }
}

