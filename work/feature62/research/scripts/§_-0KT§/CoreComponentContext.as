package §_-0KT§
{
   import §_-0Dh§.§_-4jy§;
   import §_-0od§.§_-3UO§;
   import §_-0xp§.Stage3DProxy;
   import §_-1WP§.§_-3lj§;
   import §_-2AK§.§_-234§;
   import §_-3td§.Core;
   import §_-44B§.§_-1R3§;
   import §_-44B§.§_-3gf§;
   import §_-44B§.§_-3sc§;
   import §_-44B§.§_-40J§;
   import §_-44B§.§_-oG§;
   import §_-9C§.§_-2h8§;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   
   public final class CoreComponentContext extends §_-0En§ implements §_-12s§
   {
      
      private static var §_-3c7§:§_-oG§;
      
      private static const §_-0cN§:uint = 3;
      
      private static const §_-KN§:String = "asset-libraries";
      
      private static const §_-1u4§:String = "library";
      
      private static const §_-333§:String = "service-libraries";
      
      private static const §_-36N§:String = "library";
      
      private static const §_-HU§:String = "component-libraries";
      
      private static const §_-29R§:String = "library";
      
      private var §_-13Y§:§_-3sc§;
      
      private var §_-3k8§:IEventDispatcher;
      
      private var §_-0Wn§:uint;
      
      private var §_-4bg§:Function;
      
      private var §_-2PY§:§_-23I§;
      
      private var §_-3Mf§:§_-3rt§;
      
      private var §_-480§:Array;
      
      private var §_-1IP§:Array;
      
      private var _lastUpdateTimeMs:uint;
      
      private var _flags:uint = 0;
      
      private var §_-4kz§:int = -1;
      
      private var §_-1Vr§:uint;
      
      private var _starling:Starling;
      
      private var _stage3DProxy:Stage3DProxy;
      
      private var _view3D:§_-3UO§;
      
      private var §_-YO§:§_-2tN§;
      
      private var §_-3Ak§:Boolean;
      
      private var §_-30T§:Boolean;
      
      private var §_-RR§:Boolean;
      
      private var §_-34o§:DisplayObject;
      
      private var §_-38J§:Rectangle;
      
      private var §_-0GX§:Function;
      
      public function CoreComponentContext(param1:DisplayObjectContainer, param2:§_-3rt§, param3:uint)
      {
         var _loc4_:* = 0;
         super(this,2,new §_-4jy§("_core_assets"));
         _flags = param3;
         §_-2OU§ = (param3 & 0x0F) == 15;
         §_-480§ = [];
         §_-1IP§ = [];
         §_-4d2§ = param1;
         §_-3Mf§ = param2;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            §_-480§.push([]);
            §_-1IP§.push(0);
            _loc4_++;
         }
         _lastUpdateTimeMs = getTimer();
         §_-0iy§(this,[new §_-1DF§()]);
         §_-4d2§.addEventListener("enterFrame",onEnterFrame);
         switch(param3 & 0x0F)
         {
            case 0:
               debug("Core; using simple frame update handler");
               §_-4bg§ = §_-0Ba§;
               break;
            case 1:
               debug("Core; using complex frame update handler");
               §_-4bg§ = §_-3Ba§;
               break;
            case 2:
               debug("Core; using profiler frame update handler");
               §_-4bg§ = §_-1-z§;
               §_-2PY§ = new §_-23I§(this);
               §_-0iy§(§_-2PY§,[new §_-3pd§()]);
               §_-4d2§.addChild(new §_-234§(§_-2PY§));
               break;
            case 4:
               debug("Core; using experimental frame update handler");
               §_-4bg§ = §_-27-§;
               break;
            case 15:
               debug("Core; using debug frame update handler");
               §_-4bg§ = §_-34m§;
         }
      }
      
      private static function §_-Vh§(param1:String, param2:Object) : Boolean
      {
         var _loc3_:§_-oG§ = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = Core.§_-0R5§.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeObject(param2);
               _loc3_.§_-1z0§(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when writing Object (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private static function §_-qD§(param1:String) : Object
      {
         var _loc2_:§_-oG§ = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = Core.§_-0R5§.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.§_-0PJ§(param1);
               if(_loc3_)
               {
                  return _loc3_.readObject();
               }
            }
            return null;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function set fileProxy(param1:§_-oG§) : void
      {
         §_-3c7§ = param1;
      }
      
      public function get fileProxy() : §_-oG§
      {
         return §_-3c7§;
      }
      
      public function §_-0Zv§() : uint
      {
         return §_-13Y§.length;
      }
      
      public function §_-1R7§() : uint
      {
         return §_-0Wn§ - §_-0Zv§();
      }
      
      public function §_-4BO§(param1:Stage3DProxy, param2:Starling, param3:§_-3UO§, param4:§_-2tN§) : void
      {
         _stage3DProxy = param1;
         _starling = param2;
         _view3D = param3;
         §_-YO§ = param4;
      }
      
      public function initialize() : void
      {
         if(§_-3YH§())
         {
            events.addEventListener("COMPONENT_EVENT_UNLOCKED",§_-3CZ§);
         }
         else
         {
            §_-12B§();
         }
      }
      
      private function §_-3CZ§(param1:Event) : void
      {
         if(!§_-3YH§())
         {
            events.removeEventListener("COMPONENT_EVENT_UNLOCKED",§_-3CZ§);
            §_-12B§();
         }
      }
      
      private function §_-12B§() : void
      {
         events.dispatchEvent(new Event("COMPONENT_EVENT_RUNNING"));
         §_-1R3§.start();
      }
      
      public function §_-3YH§() : Boolean
      {
         if(§_-35i§ != null)
         {
            for each(var _loc1_:§_-4P2§ in §_-35i§)
            {
               if(_loc1_.§_-4EP§)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         var _loc2_:Array = null;
         var _loc1_:* = undefined;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(!disposed)
         {
            debug("Disposing core");
            §_-1R3§.stop();
            try
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _loc2_ = §_-480§[_loc4_] as Array;
                  _loc3_ = uint(_loc2_.length);
                  while(_loc3_-- > 0)
                  {
                     _loc1_ = _loc2_.pop();
                     if(_loc1_ is UpdateDelegate)
                     {
                        UpdateDelegate(_loc1_).dispose();
                     }
                  }
                  _loc4_++;
               }
            }
            catch(e:Error)
            {
            }
            if(§_-4d2§)
            {
               §_-4d2§.removeEventListener("enterFrame",onEnterFrame);
               §_-4d2§ = null;
            }
            if(§_-13Y§ != null)
            {
               §_-13Y§.dispose();
               §_-13Y§ = null;
            }
            super.dispose();
         }
      }
      
      public function §_-357§() : §_-3UO§
      {
         return _view3D;
      }
      
      public function §_-4n2§() : Starling
      {
         return _starling;
      }
      
      public function §_-11l§(param1:uint, param2:uint) : void
      {
         if(§_-YO§ != null)
         {
            §_-YO§.colors(param1,param2);
         }
      }
      
      public function §_-4k1§(param1:BitmapData) : void
      {
         if(§_-YO§ != null)
         {
            §_-YO§.§_-37r§(param1);
         }
      }
      
      public function §_-1EC§(param1:String) : void
      {
         if(§_-YO§ != null)
         {
            §_-YO§.mode = param1;
         }
      }
      
      override public function warning(param1:String) : void
      {
         super.warning(param1);
         §_-3Mf§.logError(param1,false);
      }
      
      override public function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
      {
         super.error(param1,param2,param3,param4);
         if(param4)
         {
            Logger.log(param4.getStackTrace());
         }
         §_-3Mf§.logError(param1,param2,param3,param4);
         var _loc5_:Boolean = false;
         if(_loc5_)
         {
            dispose();
         }
      }
      
      public function §_-3Fz§(param1:XML, param2:IEventDispatcher = null) : void
      {
         var _loc3_:XML = null;
         var _loc7_:XMLList = null;
         var _loc4_:* = null;
         var _loc8_:String = null;
         var _loc5_:§_-40J§ = null;
         var _loc6_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         debug("Parsing config document");
         §_-3k8§ = param2;
         if(§_-13Y§ == null)
         {
            §_-13Y§ = new §_-3sc§(§_-2OU§);
         }
         _loc3_ = param1.child("asset-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new §_-40J§(_loc6_,true,§_-2OU§);
               assets.loadFromFile(_loc5_,true);
               _loc5_.load(new URLRequest(_loc8_));
               §_-13Y§.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",§_-0GM§);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",§_-4Mb§);
               §_-0Wn§ = §_-0Wn§ + 1;
            }
         }
         _loc3_ = param1.child("service-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new §_-40J§(_loc6_,true,§_-2OU§);
               _loc5_.load(new URLRequest(_loc8_));
               §_-13Y§.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",§_-0GM§);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",§_-4Mb§);
               §_-0Wn§ = §_-0Wn§ + 1;
            }
         }
         _loc3_ = param1.child("component-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new §_-40J§(_loc6_,true,§_-2OU§);
               _loc5_.load(new URLRequest(_loc8_));
               §_-13Y§.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",§_-0GM§);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",§_-4Mb§);
               §_-0Wn§ = §_-0Wn§ + 1;
            }
         }
         if(!disposed)
         {
            §_-0GM§();
         }
      }
      
      public function §_-3Eh§(param1:String, param2:Dictionary) : Boolean
      {
         return §_-Vh§(param1,param2);
      }
      
      public function §_-AZ§(param1:String) : Dictionary
      {
         return §_-qD§(param1) as Dictionary;
      }
      
      public function §_-db§(param1:String, param2:XML) : Boolean
      {
         return §_-Vh§(param1,param2);
      }
      
      public function §_-0yv§(param1:String) : XML
      {
         return §_-qD§(param1) as XML;
      }
      
      public function §_-2zv§(param1:String) : String
      {
         var _loc2_:§_-oG§ = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = Core.§_-0R5§.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.§_-0PJ§(param1);
               if(_loc3_)
               {
                  return _loc3_.readUTFBytes(_loc3_.length);
               }
            }
            return null;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function §_-4Y6§(param1:String, param2:String) : Boolean
      {
         var _loc3_:§_-oG§ = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = Core.§_-0R5§.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeUTFBytes(param2);
               _loc3_.§_-1z0§(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when writing String (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private function §_-4Mb§(param1:§_-3gf§ = null) : void
      {
         var _loc2_:§_-40J§ = §_-40J§(param1.target);
         error("Failed to download library \"" + _loc2_.url + "\" HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal + " : " + _loc2_.getLastErrorMessage(),true,2);
         if(!disposed)
         {
            §_-0GM§(param1);
         }
      }
      
      private function §_-09T§() : void
      {
         if(§_-3k8§ != null)
         {
            §_-3k8§.dispatchEvent(new Event("complete"));
            §_-3k8§ = null;
         }
      }
      
      private function §_-2VW§(param1:§_-3gf§ = null) : void
      {
         var _loc2_:§_-40J§ = null;
         if(§_-3k8§ != null)
         {
            _loc2_ = param1.target as §_-40J§;
            §_-3k8§.dispatchEvent(new §_-3lj§(_loc2_.url,param1.bytesLoaded,param1.bytesTotal,_loc2_.elapsedTime));
         }
      }
      
      private function §_-0GM§(param1:§_-3gf§ = null) : void
      {
         var _loc2_:§_-40J§ = null;
         var _loc3_:String = null;
         if(param1 != null)
         {
            if(param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" || param1.type == "LIBRARY_LOADER_EVENT_ERROR")
            {
               _loc2_ = param1.target as §_-40J§;
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",§_-0GM§);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",§_-4Mb§);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS",§_-2VW§);
               _loc3_ = _loc2_.url;
               debug("Loading library \"" + _loc3_ + "\" " + (param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" ? "ready" : "failed\n" + _loc2_.getLastErrorMessage()));
               _loc2_.dispose();
               if(!disposed)
               {
                  if(§_-3k8§ != null)
                  {
                     §_-3k8§.dispatchEvent(new §_-3lj§(_loc2_.url,§_-0Wn§ - §_-13Y§.length,§_-0Wn§,_loc2_.elapsedTime));
                  }
               }
            }
         }
         if(!disposed)
         {
            if(§_-13Y§.length == 0)
            {
               §_-09T§();
               debug("All libraries loaded, Core is now running");
            }
         }
      }
      
      override public function registerUpdateReceiver(param1:§_-1eU§, param2:uint) : void
      {
         removeUpdateReceiver(param1);
         param2 = uint(param2 >= 3 ? 3 - 1 : param2);
         var _loc3_:int = int(§_-2PY§ ? 2 : _flags & 0x0F);
         if(_loc3_ == 4)
         {
            §_-480§[param2].push(new UpdateDelegate(param1,this,param2));
         }
         else
         {
            §_-480§[param2].push(param1);
         }
      }
      
      override public function removeUpdateReceiver(param1:§_-1eU§) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         if(disposed)
         {
            return;
         }
         var _loc3_:int = int(§_-2PY§ ? 2 : _flags & 0x0F);
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc4_ = §_-480§[_loc6_] as Array;
            if(_loc3_ == 4)
            {
               for each(var _loc2_:UpdateDelegate in _loc4_)
               {
                  if(_loc2_.receiver == param1)
                  {
                     _loc2_.dispose();
                     return;
                  }
               }
            }
            else
            {
               _loc5_ = int(_loc4_.indexOf(param1));
               if(_loc5_ > -1)
               {
                  _loc4_[_loc5_] = null;
                  return;
               }
            }
            _loc6_++;
         }
      }
      
      public function §_-0LK§(param1:int, param2:int = 1) : void
      {
         if(!§_-1rL§)
         {
            §_-1R3§.stop();
            §_-4kz§ = param1;
            §_-1Vr§ = 1000 / param2;
         }
      }
      
      public function resume() : void
      {
         if(§_-1rL§)
         {
            §_-1R3§.start();
            §_-4kz§ = -1;
         }
      }
      
      private function get §_-1rL§() : Boolean
      {
         return §_-4kz§ > -1;
      }
      
      private function get §_-1sj§() : uint
      {
         return §_-1rL§ ? §_-4kz§ + 1 : 3;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_stage3DProxy)
         {
            _stage3DProxy.clear();
         }
         if(§_-30T§)
         {
            §_-4d2§.removeEventListener("enterFrame",onEnterFrame);
            §_-30T§ = false;
            events.dispatchEvent(new Event("COMPONENT_EVENT_REBOOT"));
            return;
         }
         var _loc3_:uint = uint(getTimer());
         var _loc2_:uint = _loc3_ - _lastUpdateTimeMs;
         if(!§_-1rL§ || _loc2_ > §_-1Vr§)
         {
            §_-4bg§(_loc3_,_loc2_);
            _lastUpdateTimeMs = _loc3_;
         }
         if(_stage3DProxy)
         {
            if(!_stage3DProxy.§_-3hs§())
            {
               Logger.log("Stage 3D proxy is recovering");
               return;
            }
            if(§_-RR§)
            {
               §_-0IJ§();
            }
            if(§_-YO§ && !§_-2h8§.§_-0g9§ && !§_-2h8§.§_-40z§)
            {
               §_-YO§.render();
            }
            if(_view3D)
            {
               _view3D.render();
            }
            if(_starling)
            {
               _starling.nextFrame();
            }
            if(§_-3Ak§)
            {
               §_-3Ak§ = false;
            }
            else
            {
               _stage3DProxy.present();
            }
         }
      }
      
      private function §_-0IJ§() : void
      {
         var _loc1_:Stage = null;
         var _loc3_:BitmapData = null;
         var _loc2_:BitmapData = null;
         if(_stage3DProxy)
         {
            if(§_-YO§)
            {
               §_-YO§.render();
            }
            if(_view3D)
            {
               _view3D.render();
            }
            _stage3DProxy.context3D.setDepthTest(false,"always");
            _stage3DProxy.context3D.setCulling("none");
            §_-34o§.render(_starling.renderSupport,1);
            _starling.renderSupport.finishQuadBatch();
            _loc1_ = Starling.current.stage;
            _loc3_ = new BitmapData(_loc1_.stageWidth,_loc1_.stageHeight);
            _stage3DProxy.context3D.drawToBitmapData(_loc3_);
            _loc2_ = new BitmapData(§_-38J§.width,§_-38J§.height);
            _loc2_.copyPixels(_loc3_,§_-38J§,new Point(0,0));
            _loc3_.dispose();
            §_-0GX§(_loc2_);
            §_-38J§ = null;
            §_-0GX§ = null;
            §_-34o§ = null;
            §_-RR§ = false;
         }
      }
      
      public function §_-1NN§() : void
      {
         §_-3Ak§ = true;
      }
      
      public function §_-rS§(param1:DisplayObject, param2:Rectangle, param3:Function) : void
      {
         §_-RR§ = true;
         §_-34o§ = param1;
         §_-38J§ = param2;
         §_-0GX§ = param3;
      }
      
      private function §_-0Ba§(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:§_-1eU§ = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < §_-1sj§)
         {
            §_-1IP§[_loc7_] = 0;
            _loc4_ = §_-480§[_loc7_];
            _loc6_ = 0;
            _loc5_ = uint(_loc4_.length);
            while(_loc6_ != _loc5_)
            {
               _loc3_ = §_-1eU§(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     _loc3_.update(param2);
                  }
                  catch(e:Error)
                  {
                     Logger.log(e.getStackTrace());
                     error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e);
                     return;
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      private function §_-3Ba§(param1:uint, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc6_:Array = null;
         var _loc4_:§_-1eU§ = null;
         var _loc7_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Boolean = false;
         var _loc5_:* = 0;
         var _loc3_:Boolean = true;
         var _loc8_:uint = 1000 / §_-4d2§.stage.frameRate;
         _loc11_ = 0;
         while(_loc11_ < §_-1sj§)
         {
            _loc5_ = uint(getTimer());
            _loc10_ = false;
            if(_loc5_ - param1 > _loc8_)
            {
               if(§_-1IP§[_loc11_] < _loc11_)
               {
                  §_-1IP§[_loc11_]++;
                  _loc10_ = true;
               }
            }
            if(!_loc10_)
            {
               §_-1IP§[_loc11_] = 0;
               _loc6_ = §_-480§[_loc11_];
               _loc9_ = 0;
               _loc7_ = uint(_loc6_.length);
               while(_loc9_ != _loc7_ && _loc3_)
               {
                  _loc4_ = §_-1eU§(_loc6_[_loc9_]);
                  if(_loc4_ == null || Boolean(_loc4_.disposed))
                  {
                     _loc6_.splice(_loc9_,1);
                     _loc7_--;
                  }
                  else
                  {
                     try
                     {
                        _loc4_.update(param2);
                     }
                     catch(e:Error)
                     {
                        Logger.log(e.getStackTrace());
                        error("Error in update receiver \"" + getQualifiedClassName(_loc4_) + "\": " + e,true,e.errorID,e);
                        _loc3_ = false;
                     }
                     _loc9_++;
                  }
               }
            }
            _loc11_++;
         }
      }
      
      private function §_-1-z§(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:§_-1eU§ = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         §_-2PY§.start();
         _loc7_ = 0;
         while(_loc7_ < §_-1sj§)
         {
            §_-1IP§[_loc7_] = 0;
            _loc4_ = §_-480§[_loc7_];
            _loc6_ = 0;
            _loc5_ = uint(_loc4_.length);
            while(_loc6_ != _loc5_)
            {
               _loc3_ = §_-1eU§(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     §_-2PY§.update(_loc3_,param2);
                  }
                  catch(e:Error)
                  {
                     error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e);
                     return;
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
         §_-2PY§.stop();
      }
      
      private function §_-27-§(param1:uint, param2:uint) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = §_-480§[_loc5_];
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ > -1)
            {
               if(_loc3_[_loc4_].disposed)
               {
                  _loc3_.splice(_loc4_,1);
               }
               _loc4_--;
            }
            _loc5_++;
         }
      }
      
      private function §_-34m§(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:§_-1eU§ = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < §_-1sj§)
         {
            §_-1IP§[_loc7_] = 0;
            _loc4_ = §_-480§[_loc7_];
            _loc6_ = 0;
            _loc5_ = uint(_loc4_.length);
            while(_loc6_ != _loc5_)
            {
               _loc3_ = §_-1eU§(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  _loc3_.update(param2);
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function §_-uk§(param1:Boolean) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            §_-4bg§ = §_-1-z§;
            if(!§_-2PY§ || §_-2PY§.disposed)
            {
               §_-2PY§ = new §_-23I§(this);
            }
            §_-0iy§(§_-2PY§,[new §_-3pd§()]);
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc3_ = §_-480§[_loc5_];
               _loc4_ = _loc3_.length - 1;
               while(_loc4_ > -1)
               {
                  _loc2_ = _loc3_[_loc4_];
                  if(_loc2_ is UpdateDelegate)
                  {
                     _loc3_[_loc4_] = UpdateDelegate(_loc2_).receiver;
                     UpdateDelegate(_loc2_).dispose();
                  }
                  _loc4_--;
               }
               _loc5_++;
            }
         }
         else
         {
            §_-02o§(§_-2PY§);
            switch(_flags & 0x0F)
            {
               case 0:
                  §_-4bg§ = §_-0Ba§;
                  break;
               case 1:
                  §_-4bg§ = §_-3Ba§;
                  break;
               case 4:
                  §_-4bg§ = §_-27-§;
                  _loc5_ = 0;
                  while(_loc5_ < 3)
                  {
                     _loc3_ = §_-480§[_loc5_];
                     _loc4_ = _loc3_.length - 1;
                     while(_loc4_ > -1)
                     {
                        _loc2_ = _loc3_[_loc4_];
                        if(_loc2_ is §_-1eU§)
                        {
                           _loc3_[_loc4_] = new UpdateDelegate(§_-1eU§(_loc2_),this,_loc5_);
                        }
                        _loc4_--;
                     }
                     _loc5_++;
                  }
                  break;
               default:
                  §_-4bg§ = §_-34m§;
            }
         }
      }
      
      public function §_-02h§() : void
      {
         §_-30T§ = true;
      }
      
      public function set errorLogger(param1:§_-2f7§) : void
      {
         if(§_-3Mf§ != null)
         {
            §_-3Mf§.errorLogger = param1;
         }
      }
   }
}

import §_-0KT§.§_-1eU§;
import §_-0KT§.§_-2eb§;
import §_-0KT§.§_-40S§;
import flash.events.Event;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

class UpdateDelegate implements §_-2eb§
{
   
   private var _receiver:§_-1eU§;
   
   private var _context:§_-40S§;
   
   private var _priority:int;
   
   private var _lastUpdateTimeMs:uint;
   
   private var _framesSkipped:uint = 0;
   
   public function UpdateDelegate(param1:§_-1eU§, param2:§_-40S§, param3:int)
   {
      super();
      if(param2 && param1)
      {
         _receiver = param1;
         _context = param2;
         _priority = param3;
         param2.displayObjectContainer.stage.addEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _lastUpdateTimeMs = getTimer();
      }
   }
   
   public function get priority() : int
   {
      return _priority;
   }
   
   public function get receiver() : §_-1eU§
   {
      return _receiver;
   }
   
   public function get disposed() : Boolean
   {
      return _receiver ? _receiver.disposed : true;
   }
   
   public function dispose() : void
   {
      if(_receiver)
      {
         _receiver = null;
         _context.displayObjectContainer.stage.removeEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _context = null;
      }
   }
   
   private function onFrameUpdate(param1:Event) : void
   {
      var _loc2_:* = 0;
      if(!disposed)
      {
         _loc2_ = uint(getTimer());
         var _loc3_:uint = _loc2_ - _lastUpdateTimeMs;
         _lastUpdateTimeMs = _loc2_;
         if(_priority > 0 && _framesSkipped < _priority)
         {
            if(_loc3_ > 1000 / _context.displayObjectContainer.stage.frameRate)
            {
               _framesSkipped = Number(_framesSkipped) + 1;
               return;
            }
         }
         _framesSkipped = 0;
         try
         {
            _receiver.update(_loc3_);
         }
         catch(e:Error)
         {
            _context.error("Error in update receiver \"" + getQualifiedClassName(_receiver) + "\": " + e.message,true,e.errorID,e);
         }
      }
   }
}
