package
{
   import §_-06i§.§_-4OD§;
   import §_-06i§.§_-EV§;
   import §_-0KT§.CoreComponentContext;
   import §_-0KT§.§_-12s§;
   import §_-0KT§.§_-2-W§;
   import §_-0KT§.§_-CG§;
   import §_-0m8§.§_-2N4§;
   import §_-0od§.§_-3UO§;
   import §_-0qJ§.§_-11I§;
   import §_-0qJ§.§_-4-K§;
   import §_-0xp§.Stage3DManager;
   import §_-0xp§.Stage3DProxy;
   import §_-15s§.HabboTracking;
   import §_-1N-§.§_-2mJ§;
   import §_-1WP§.§_-J-§;
   import §_-1vA§.§_-36p§;
   import §_-2Sz§.§_-0Fb§;
   import §_-2xS§.Alert;
   import §_-309§.§_-2Yt§;
   import §_-3HY§.§_-Nv§;
   import §_-3td§.Core;
   import §_-4Fu§.DeviceCapabilities;
   import §_-4cH§.§_-46f§;
   import §_-4dh§.§_-2b8§;
   import §_-9C§.§_-0T3§;
   import §_-9C§.§_-2h8§;
   import §_-9C§.§_-3up§;
   import §_-QV§.§_-3zD§;
   import com.mesmotronic.ane.AndroidFullScreen;
   import com.sulake.air.AssetEmbedProxy;
   import com.sulake.core.runtime.CoreComponentContext;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboCommunicationDemo;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.desktop.NativeApplication;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.InvokeEvent;
   import flash.events.KeyboardEvent;
   import flash.filesystem.File;
   import flash.system.Capabilities;
   import flash.system.System;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.utils.SystemUtil;
   
   [SecureSWF(rename="false")]
   public class HabboTabletMain extends flash.display.Sprite
   {
      
      private static const LOADING_PROGRESS_STAGE_1:Number = 0.2;
      
      private static const LOADING_PROGRESS_STAGE_2:Number = 0.4;
      
      private static const LOADING_PROGRESS_STAGE_3:Number = 0.6;
      
      private static const LOADING_PROGRESS_STAGE_4:Number = 0.8;
      
      private static const LOADING_PROGRESS_STAGE_COMPLETE:Number = 1;
      
      private static var _lowMemoryWarnCount:int;
      
      public static var ubuntu_regular:Class = §Ubuntu-R_ttf$5bae8f5702fc0439bcf0f3af29e9ebd61031082117§;
      
      public static var ubuntu_bold:Class = §Ubuntu-B_ttf$d35e24a2b1b31e186299e9bdcee32cb11958698349§;
      
      public static var ubuntu_italic:Class = §Ubuntu-I_ttf$204fed506ea928adb0a69b4f44d7c46b20089687§;
      
      public static var ubuntu_bold_italic:Class = §Ubuntu-BI_ttf$aab2b25e732344262c9803c521124772897694205§;
      
      public static var ubuntu_condensed:Class = §Ubuntu-C_ttf$89fe4d9da3d229c276f2f43670b888e61430458534§;
      
      private var CONTEXT_3D_PROFILE:String = "auto";
      
      private var _core:§_-12s§;
      
      private var _preloader:HabboTablet;
      
      private var _tracking:HabboTracking;
      
      private var _configurationManager:§_-46f§;
      
      private var _starling:Starling;
      
      private var _stage3DManager:Stage3DManager;
      
      private var _stage3DProxy:Stage3DProxy;
      
      private var _view3D:§_-3UO§;
      
      private var _theme:HitchTheme;
      
      private var _memoryMonitor:§_-Nv§;
      
      private var _lowMemoryAlert:Alert;
      
      private var _gradientRenderer:§_-2b8§;
      
      public function HabboTabletMain()
      {
         super();
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("complete",onCompleteEvent);
         NativeApplication.nativeApplication.addEventListener("invoke",invokeHandler);
      }
      
      private static function receiveQueuedInterface(param1:§_-2-W§, param2:§_-CG§) : void
      {
         §_-4-K§.localizationManager = param2 as §_-3zD§;
         §_-11I§.localizationManager = param2 as §_-3zD§;
      }
      
      private function invokeHandler(param1:InvokeEvent) : void
      {
         Logger.log("InvokeHandler " + param1.reason + ". Arguments: " + param1.arguments[0]);
         if(param1.arguments && param1.arguments.length)
         {
            for(var _loc2_ in param1.arguments[0])
            {
               Logger.log("param " + _loc2_ + ": " + param1.arguments[0][_loc2_]);
            }
         }
      }
      
      public function dispose() : void
      {
         Core.dispose();
         _core = null;
         _tracking = null;
         _configurationManager = null;
         if(_theme)
         {
            _theme.dispose();
            _theme = null;
         }
         if(_starling)
         {
            _starling.dispose();
            _starling = null;
         }
         _stage3DManager = null;
         if(_stage3DManager)
         {
            _stage3DProxy.dispose();
            _stage3DProxy = null;
         }
         if(_view3D)
         {
            _view3D.dispose();
            _view3D = null;
         }
         if(_lowMemoryAlert)
         {
            _lowMemoryAlert.removeFromParent();
            _lowMemoryAlert.dispose();
            _lowMemoryAlert = null;
         }
         if(§_-2mJ§.§_-1Bn§)
         {
            §_-2mJ§.§_-1Bn§.dispose();
            §_-2mJ§.§_-1Bn§ = null;
         }
         NativeApplication.nativeApplication.removeEventListener("keyDown",onKeyDown);
         NativeApplication.nativeApplication.removeEventListener("deactivate",onApplicationDeactivated);
         NativeApplication.nativeApplication.removeEventListener("activate",onApplicationActivated);
      }
      
      protected function onAddedToStage(param1:flash.events.Event = null) : void
      {
         var _loc3_:XML = NativeApplication.nativeApplication.applicationDescriptor;
         var _loc5_:Namespace = _loc3_.namespace();
         var _loc2_:String = _loc3_._loc5_::copyright;
         var _loc4_:String = _loc3_._loc5_::versionLabel;
         var _loc6_:String = _loc3_._loc5_::versionNumber;
         Logger.log("AIR Runtime version: " + NativeApplication.nativeApplication.runtimeVersion);
         Logger.log("Application ID: " + NativeApplication.nativeApplication.applicationID);
         Logger.log("Copyright: " + _loc2_);
         Logger.log("Version: " + _loc4_);
         Logger.log("VersionNumber: " + _loc6_);
         Logger.log("Application Directory: " + File.applicationDirectory.nativePath);
         Logger.log("Application Storage: " + File.applicationStorageDirectory.nativePath);
         Logger.log("OS: " + Capabilities.os);
         Logger.log("Architecture: " + Capabilities.cpuArchitecture);
         Logger.log("Manufacturer: " + Capabilities.manufacturer);
         Logger.log("PlayerType: " + Capabilities.playerType);
         Logger.log("Debug: " + Capabilities.isDebugger);
         Logger.log("Language: " + Capabilities.language);
         Logger.log("Languages: " + Capabilities.languages);
         Logger.log("Pixel Aspect Ratio: " + Capabilities.pixelAspectRatio);
         Logger.log("ScreenDPI: " + Capabilities.screenDPI);
         Logger.log("ScreenResX: " + Capabilities.screenResolutionX);
         Logger.log("ScreenResY: " + Capabilities.screenResolutionY);
         Logger.log("ScreenRatio: " + Capabilities.screenResolutionX / (Capabilities.screenResolutionY * 1));
         Logger.log("StageWidth: " + stage.fullScreenWidth);
         Logger.log("StageHeight: " + stage.fullScreenHeight);
         Logger.log("AIR Version: " + Capabilities.version);
         Logger.log("Using 3D profile: " + CONTEXT_3D_PROFILE);
         Logger.log("Core version: " + Core.version);
         Logger.log("DeviceCapabilities.dpi: " + DeviceCapabilities.§_-0gX§);
         Logger.log("DeviceCapabilities.isPhone: " + DeviceCapabilities.§_-15z§(stage));
         Logger.log("DeviceCapabilities.isTablet: " + DeviceCapabilities.§_-4Wn§(stage));
         Logger.log("DeviceCapabilities.screenInchesX: " + DeviceCapabilities.§_-1uo§(stage));
         Logger.log("DeviceCapabilities.screenInchesY: " + DeviceCapabilities.§_-08D§(stage));
         Logger.log("DeviceCapabilities.screenPixelWidth: " + DeviceCapabilities.§_-0Sw§);
         Logger.log("DeviceCapabilities.screenPixelHeight: " + DeviceCapabilities.§_-3gd§);
         Logger.log("DeviceCapabilities.tabletScreenMinimumInches: " + DeviceCapabilities.§_-xS§);
         goFullScreen();
         init();
      }
      
      private function goFullScreen() : void
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = Capabilities.version.toLowerCase();
            if(_loc1_.indexOf("and") > -1)
            {
               if(AndroidFullScreen.isSupported)
               {
                  if(AndroidFullScreen.isImmersiveModeSupported)
                  {
                     stage.displayState = "fullScreenInteractive";
                     AndroidFullScreen.immersiveMode();
                  }
                  else
                  {
                     stage.displayState = "fullScreenInteractive";
                  }
               }
               else
               {
                  stage.displayState = "fullScreenInteractive";
               }
            }
         }
         catch(error:Error)
         {
            Logger.log("Not Supported on iOS");
         }
      }
      
      private function init() : void
      {
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:String = Capabilities.version.toLowerCase();
         if(_loc2_.indexOf("win") > -1 || _loc2_.indexOf("mac") > -1)
         {
            DeviceCapabilities.§_-0gX§ = 132;
         }
         stage.addEventListener("resize",onStageResize);
         updateLoadingProgressTo(0.2);
         if(_stage3DManager == null)
         {
            _stage3DManager = Stage3DManager.getInstance(stage);
            _stage3DProxy = _stage3DManager.§_-Ds§(false,CONTEXT_3D_PROFILE);
            if(_stage3DProxy.profile == null)
            {
               _stage3DProxy = _stage3DManager.§_-Ds§(false);
            }
            _stage3DProxy.addEventListener("Context3DCreated",onContext3DCreated);
            _stage3DProxy.addEventListener("Context3DRecreated",onContext3DProxyRecreated);
            _stage3DProxy.addEventListener("Context3DDisposed",onContext3DDisposed);
            _stage3DProxy.addEventListener("error",onStage3DError);
            _stage3DProxy.§_-0FJ§ = 0;
            _stage3DProxy.§_-2SB§ = true;
         }
         else
         {
            onContext3DCreated();
         }
      }
      
      private function onMemoryWarning(param1:flash.events.Event) : void
      {
         SystemUtil.executeWhenApplicationIsActive(onMemoryWarningBufferedCall);
      }
      
      private function onMemoryWarningBufferedCall() : void
      {
         if(_lowMemoryAlert)
         {
            _lowMemoryAlert.removeFromParent();
            _lowMemoryAlert.dispose();
         }
         _lowMemoryWarnCount = _lowMemoryWarnCount + 1;
         if(_core && _core.events)
         {
            _core.events.dispatchEvent(new §_-J-§(_lowMemoryWarnCount));
         }
      }
      
      private function onAlertClosed(param1:starling.events.Event) : void
      {
         (param1.target as Alert).dispose();
      }
      
      private function onStageResize(param1:flash.events.Event) : void
      {
         if(!stage)
         {
            return;
         }
         var _loc2_:int = stage.stageWidth;
         var _loc3_:int = stage.stageHeight;
         if(_stage3DProxy)
         {
            _stage3DProxy.width = _loc2_;
            _stage3DProxy.height = _loc3_;
         }
         if(_view3D)
         {
            _view3D.width = _loc2_;
            _view3D.height = _loc3_;
         }
         if(_starling)
         {
            _starling.stage.stageWidth = _loc2_;
            _starling.stage.stageHeight = _loc3_;
            _starling.viewPort.width = _loc2_;
            _starling.viewPort.height = _loc3_;
         }
      }
      
      protected function onStage3DError(param1:ErrorEvent) : void
      {
         Logger.log("Hello, error!" + param1);
      }
      
      private function onContext3DDisposed(param1:§_-2N4§ = null) : void
      {
         Logger.log("Context 3d was Disposed!");
      }
      
      private function onContext3DProxyRecreated(param1:§_-2N4§ = null) : void
      {
         Logger.log("Context 3d Proxy was recreated!");
      }
      
      private function onContext3DCreated(param1:§_-2N4§ = null) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(_view3D == null)
         {
            _view3D = new §_-3UO§(null,null,null,false,CONTEXT_3D_PROFILE);
            _view3D.stage3DProxy = _stage3DProxy;
            _view3D.shareContext = true;
            _view3D.§_-0FJ§ = 0;
            _view3D.mouseEnabled = false;
            _view3D.mouseChildren = false;
            stage.addChild(_view3D);
         }
         if(_starling == null)
         {
            Starling.multitouchEnabled = false;
            _loc3_ = Capabilities.version.toLowerCase();
            if(_loc3_.indexOf("and") > -1)
            {
               Starling.handleLostContext = true;
            }
            else
            {
               Starling.handleLostContext = false;
            }
            _loc2_ = _stage3DProxy.context3D.profile;
            Logger.log("Creating Starling with profile " + _loc2_);
            _starling = new Starling(starling.display.Sprite,stage,_stage3DProxy.viewPort,_stage3DProxy.stage3D,"auto",_loc2_);
            _starling.showStats = false;
            _starling.shareContext = true;
            _starling.enableErrorChecking = false;
            _starling.addEventListener("context3DCreate",onStarlingContext3DCreated);
            Logger.log("Created Starling with \n\tprofile " + _starling.profile + " \n\tshared: " + _starling.shareContext + " \n\tcontext: " + _starling.context);
            §_-36p§.§_-4Uq§ = new §_-0Fb§(stage);
            §_-36p§.§_-7y§(DisplayObject,new §_-EV§());
            §_-36p§.§_-3Wt§(new §_-4OD§(_starling),-1);
         }
         else
         {
            onStarlingRootCreated();
         }
         goFullScreen();
      }
      
      protected function onStarlingContext3DCreated(param1:starling.events.Event) : void
      {
         _starling.removeEventListener("context3DCreate",onStarlingContext3DCreated);
         if(!_starling.context)
         {
         }
         if(!_starling.isStarted)
         {
            _starling.start();
         }
         _starling.addEventListener("rootCreated",onStarlingRootCreated);
      }
      
      private function onContext3DRecreated(param1:starling.events.Event = null) : void
      {
         if(_gradientRenderer && _stage3DProxy)
         {
            if(_stage3DProxy.context3D.profile != null || _stage3DProxy.context3D.driverInfo != null)
            {
               _gradientRenderer.context = _stage3DProxy.context3D;
            }
            §_-2mJ§.init();
         }
      }
      
      private function onStarlingRootCreated(param1:starling.events.Event = null) : void
      {
         §_-2mJ§.init();
         _starling.removeEventListener("rootCreated",onStarlingRootCreated);
         if(§_-2mJ§.isAndroid())
         {
            NativeApplication.nativeApplication.addEventListener("keyDown",onKeyDown,false,0,true);
            NativeApplication.nativeApplication.addEventListener("deactivate",onApplicationDeactivated);
            NativeApplication.nativeApplication.addEventListener("activate",onApplicationActivated);
         }
         if(_theme == null)
         {
            _theme = new HitchTheme();
         }
         if(!_gradientRenderer)
         {
            _gradientRenderer = new §_-2b8§(_stage3DProxy.context3D);
            _gradientRenderer.colors(527374,1318180);
         }
         _starling.addEventListener("context3DCreate",onContext3DRecreated);
         var _loc2_:Boolean = true;
         if(_loc2_)
         {
            prepareCore();
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode != 16777238)
         {
            return;
         }
         param1.preventDefault();
         param1.stopImmediatePropagation();
      }
      
      private function onApplicationDeactivated(param1:flash.events.Event) : void
      {
         Logger.log("Application deactivated");
      }
      
      private function onApplicationActivated(param1:flash.events.Event) : void
      {
         Logger.log("Application activated");
         if(Starling.current != null && Starling.current.context != null)
         {
            Starling.current.context.clear();
            Starling.current.context.present();
         }
         goFullScreen();
      }
      
      private function onEnterFrame(param1:flash.events.Event) : void
      {
         if(_stage3DProxy && _starling)
         {
            _stage3DProxy.clear();
            _starling.nextFrame();
            _stage3DProxy.present();
         }
      }
      
      private function onCachedErrorAlertClosed(param1:starling.events.Event) : void
      {
         (param1.target as Alert).dispose();
         removeEventListener("enterFrame",onEnterFrame);
         prepareCore();
      }
      
      private function prepareCore() : void
      {
         var _loc1_:* = 0;
         try
         {
            _loc1_ = 1;
            _core = Core.§_-3u7§(stage,_loc1_,new HabboCoreErrorReporter());
            _core.events.addEventListener("COMPONENT_EVENT_ERROR",onCoreError);
            _core.events.addEventListener("COMPONENT_EVENT_REBOOT",onCoreReboot);
            (_core as §_-0KT§.CoreComponentContext).§_-4BO§(_stage3DProxy,_starling,_view3D,_gradientRenderer);
            (_core as §_-0KT§.CoreComponentContext).fileProxy = new §_-3up§();
            if(§_-0T3§.isSupported())
            {
               §_-2Yt§.§_-2AR§ = new §_-0T3§();
            }
            if(§_-2mJ§.§_-1Bn§)
            {
               §_-2mJ§.§_-1Bn§.dispose();
            }
            §_-2mJ§.§_-1Bn§ = new §_-2h8§();
            _core.queueInterface(new IIDHabboCommunicationDemo(),onCommunicationDemoReady);
            _core.queueInterface(new IIDHabboConfigurationManager(),onConfigurationManagerReady);
            _core.queueInterface(new IIDCoreLocalizationManager(),receiveQueuedInterface);
            _core.§_-2TJ§(CoreCommunicationFrameworkLib);
            _core.§_-2TJ§(RoomManagerLib);
            _core.§_-2TJ§(RoomSpriteRendererLib);
            _core.§_-2TJ§(HabboConfigurationCom);
            _core.§_-2TJ§(HabboLocalizationCom);
            _core.§_-2TJ§(HabboCommunicationCom);
            _core.§_-2TJ§(HabboCommunicationDemoCom,1);
            _core.§_-2TJ§(HabboTrackingLib);
            _core.§_-2TJ§(HabboUI3dCom);
            _core.§_-2TJ§(HabboRoomEngineCom,2 | 1 | 4);
            _core.§_-2TJ§(HabboRoomSessionManagerLib);
            _core.§_-2TJ§(HabboRoomObjectLogicLib);
            _core.§_-2TJ§(HabboRoomObjectVisualizationLib);
            _core.§_-2TJ§(HabboSessionDataManagerLib);
            _core.§_-2TJ§(HabboAvatarRenderLib);
            _core.§_-2TJ§(HabboTabletNavigatorCom);
            _core.§_-2TJ§(HabboAdManagerCom);
            _core.§_-2TJ§(HabboTabletInventoryCom);
            _core.§_-2TJ§(HabboTabletCatalogCom);
            _core.§_-2TJ§(HabboSoundManagerFlash10Com);
            _core.§_-2TJ§(HabboUserDefinedRoomEventsCom);
            _core.§_-2TJ§(HabboQuestEngineCom);
            _tracking = HabboTracking.getInstance();
            updateLoadingProgressTo(0.4);
            _core.§_-3Fz§(new XML(),this);
         }
         catch(error:Error)
         {
            Core.dispose();
         }
      }
      
      private function onCommunicationDemoReady(param1:§_-2-W§, param2:§_-CG§) : void
      {
         updateLoadingProgressTo(1);
         if(_preloader)
         {
            _preloader.hideLoadingScreen();
         }
         param2.release(param1);
      }
      
      private function onConfigurationManagerReady(param1:§_-2-W§, param2:§_-46f§) : void
      {
         _configurationManager = param2;
         _configurationManager.events.addEventListener("complete",onConfigurationsReady);
      }
      
      private function onConfigurationsReady(param1:flash.events.Event) : void
      {
         _configurationManager.events.removeEventListener("complete",onConfigurationsReady);
         if(_configurationManager.getBoolean("tablet.low_mem_event.enabled"))
         {
            _memoryMonitor = new §_-Nv§();
            _memoryMonitor.addEventListener("MemoryWarning",onMemoryWarning);
         }
      }
      
      private function onCoreReboot(param1:flash.events.Event) : void
      {
         Logger.log("Reboot application! " + System.privateMemory,System.totalMemory,System.totalMemoryNumber);
         Core.dispose();
         _core = null;
         Logger.log("Application ready for restart! " + System.privateMemory,System.totalMemory,System.totalMemoryNumber);
         init();
      }
      
      public function set preloader(param1:HabboTablet) : void
      {
         _preloader = param1;
      }
      
      private function updateLoadingProgressTo(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(_preloader)
         {
            _loc2_ = 0.7 + param1 * (1 - 0.7);
            Logger.log("**** Updating after core ratio to: " + _loc2_);
            _preloader.updateLoadingBarProgressTo(_loc2_);
         }
      }
      
      private function onCompleteEvent(param1:flash.events.Event) : void
      {
         updateLoadingProgressTo(0.8);
         initializeCore();
      }
      
      private function initializeCore() : void
      {
         try
         {
            _core.initialize();
         }
         catch(error:Error)
         {
            Core.§_-3wa§("Failed to initialize the core: " + error.message,10,error);
         }
      }
      
      public function onCoreError(param1:flash.events.Event) : void
      {
         Logger.log("TabletMain: onCoreError " + param1.type);
      }
   }
}

import §_-0KT§.§_-2f7§;
import §_-0KT§.§_-3rt§;

class HabboCoreErrorReporter implements §_-3rt§
{
   
   private var _logger:§_-2f7§;
   
   public function HabboCoreErrorReporter()
   {
      super();
   }
   
   public function logError(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
   {
      HabboTablet.reportCrash(param1,param3,param2,param4,_logger);
   }
   
   public function set errorLogger(param1:§_-2f7§) : void
   {
      _logger = param1;
   }
}
