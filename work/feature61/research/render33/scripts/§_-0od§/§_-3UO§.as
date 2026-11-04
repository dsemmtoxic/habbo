package §_-0od§
{
   import §_-0m8§.§_-1d5§;
   import §_-0m8§.§_-2N4§;
   import §_-0m8§.§_-2mP§;
   import §_-0xp§.Stage3DManager;
   import §_-0xp§.Stage3DProxy;
   import §_-0xp§.§_-0SC§;
   import §_-0xp§.§_-3gQ§;
   import §_-0xp§.§_-Da§;
   import §_-15y§.§_-49B§;
   import §_-2G7§.§_-211§;
   import §_-2kP§.§_-2At§;
   import §_-2kP§.§_-3pD§;
   import §_-2kP§.§_-45r§;
   import §_-2kP§.§_-UQ§;
   import §_-3Z8§.§_-0ls§;
   import §_-4k4§.§_-eg§;
   import away3d.arcane;
   import flash.display.Sprite;
   import flash.display3D.Context3D;
   import flash.display3D.textures.Texture;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   import flash.geom.Vector3D;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.getTimer;
   
   use namespace arcane;
   
   public class §_-3UO§ extends Sprite
   {
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var §_-3Ex§:Point = new Point();
      
      private var §_-0n-§:Point = new Point();
      
      private var §_-3rG§:Boolean;
      
      protected var §_-4Cf§:§_-38d§;
      
      protected var §_-h8§:§_-49B§;
      
      protected var §_-0ac§:§_-0ls§;
      
      protected var §_-4n0§:Number;
      
      private var §_-0kU§:Number = 0;
      
      private var §_-09p§:uint;
      
      private var §_-34§:uint = 0;
      
      private var §_-0I3§:Number = 1;
      
      protected var §_-1SV§:§_-3gQ§;
      
      protected var §_-3py§:§_-0SC§;
      
      protected var §_-37g§:§_-45r§;
      
      private var §_-0vF§:§_-2At§;
      
      private var §_-45b§:Boolean;
      
      private var §_-0W0§:Boolean;
      
      protected var §_-1Ht§:§_-3pD§;
      
      protected var §_-4Rw§:Boolean;
      
      protected var §_-vc§:Texture;
      
      private var §_-TU§:Boolean = true;
      
      private var §_-0yX§:Sprite;
      
      protected var get:Boolean;
      
      private var §_-ze§:§_-211§;
      
      protected var _stage3DProxy:Stage3DProxy;
      
      protected var §_-1lx§:Boolean = true;
      
      private var §_-07n§:uint;
      
      protected var §_-1AM§:§_-Da§;
      
      private var §_-3In§:Boolean = true;
      
      private var §_-1SH§:String;
      
      private var _menu0:ContextMenuItem;
      
      private var _menu1:ContextMenuItem;
      
      private var §_-4VI§:ContextMenu;
      
      protected var §_-37W§:Boolean = false;
      
      protected var §_-108§:Rectangle;
      
      private var §_-2Ym§:Boolean = true;
      
      private var §_-4ZC§:Boolean = true;
      
      private var §_-3Jf§:Boolean;
      
      private var §_-0dL§:String;
      
      private var §_-0LX§:Boolean = false;
      
      public function §_-3UO§(param1:§_-38d§ = null, param2:§_-49B§ = null, param3:§_-45r§ = null, param4:Boolean = false, param5:String = "baseline")
      {
         super();
         §_-0dL§ = param5;
         §_-4Cf§ = param1 || new §_-38d§();
         §_-4Cf§.addEventListener("partitionChanged",§_-4As§);
         §_-h8§ = param2 || new §_-49B§();
         §_-37g§ = param3 || new §_-UQ§();
         §_-0vF§ = new §_-2At§();
         §_-0W0§ = param4;
         §_-0ac§ = §_-37g§.§_-1AW§();
         §_-0ac§.camera = §_-h8§;
         §_-108§ = new Rectangle();
         §_-Qg§();
         §_-1SV§ = new §_-3gQ§();
         §_-1SV§.§_-42Y§(this);
         §_-3py§ = new §_-0SC§();
         §_-3py§.view = this;
         §_-3py§.§_-0MR§(this);
         addEventListener("addedToStage",onAddedToStage,false,0,true);
         addEventListener("added",§_-22U§,false,0,true);
         §_-h8§.addEventListener("lensChanged",§_-0-9§);
         §_-h8§.§_-MQ§ = §_-4Cf§.§_-MQ§;
         §_-Vv§();
      }
      
      private function §_-4Gi§(param1:ContextMenuEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest(§_-1SH§);
         try
         {
            navigateToURL(_loc2_,"_blank");
         }
         catch(error:Error)
         {
         }
      }
      
      public function get §_-3vI§() : Boolean
      {
         return §_-3Jf§;
      }
      
      public function set §_-3vI§(param1:Boolean) : void
      {
         §_-3Jf§ = param1;
      }
      
      private function §_-00C§(param1:ContextMenuEvent) : void
      {
         var _loc3_:String = "http://www.away3d.com";
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         try
         {
            navigateToURL(_loc2_);
         }
         catch(error:Error)
         {
         }
      }
      
      private function §_-Vv§() : void
      {
         _menu0 = new ContextMenuItem("Away3D.com\tv4.1.6",true,true,true);
         _menu1 = new ContextMenuItem("View Source",true,true,true);
         _menu0.addEventListener("menuItemSelect",§_-00C§);
         _menu1.addEventListener("menuItemSelect",§_-4Gi§);
         §_-4VI§ = new ContextMenu();
         §_-3QI§();
      }
      
      private function §_-3QI§() : void
      {
         if(§_-3In§)
         {
            §_-4VI§.customItems = §_-1SH§ ? [_menu0,_menu1] : [_menu0];
         }
         else
         {
            §_-4VI§.customItems = [];
         }
         contextMenu = §_-4VI§;
      }
      
      private function §_-4As§(param1:§_-2mP§) : void
      {
         if(§_-h8§)
         {
            §_-h8§.§_-MQ§ = scene.§_-MQ§;
         }
      }
      
      public function get §_-2vK§() : Boolean
      {
         return §_-3In§;
      }
      
      public function set §_-2vK§(param1:Boolean) : void
      {
         §_-3In§ = param1;
         §_-3QI§();
      }
      
      public function get stage3DProxy() : Stage3DProxy
      {
         return _stage3DProxy;
      }
      
      public function set stage3DProxy(param1:Stage3DProxy) : void
      {
         if(_stage3DProxy)
         {
            _stage3DProxy.removeEventListener("ViewportUpdated",§_-nT§);
            _stage3DProxy.removeEventListener("Context3DRecreated",onContext3DRecreated);
         }
         _stage3DProxy = param1;
         _stage3DProxy.addEventListener("ViewportUpdated",§_-nT§);
         _stage3DProxy.addEventListener("Context3DRecreated",onContext3DRecreated);
         §_-37g§.stage3DProxy = §_-0vF§.stage3DProxy = _stage3DProxy;
         §_-3rG§ = true;
         §_-1lx§ = true;
      }
      
      private function onContext3DRecreated(param1:§_-2N4§) : void
      {
         §_-TU§ = true;
      }
      
      public function get §_-4jT§() : Boolean
      {
         return §_-1SV§.§_-4jT§;
      }
      
      public function set §_-4jT§(param1:Boolean) : void
      {
         §_-1SV§.§_-4jT§ = param1;
         §_-3py§.§_-3qk§ = param1;
      }
      
      public function get background() : §_-211§
      {
         return §_-ze§;
      }
      
      public function set background(param1:§_-211§) : void
      {
         §_-ze§ = param1;
         §_-37g§.background = §_-ze§;
      }
      
      public function get §_-0jG§() : Boolean
      {
         return §_-0LX§;
      }
      
      public function set §_-0jG§(param1:Boolean) : void
      {
         §_-0LX§ = param1;
      }
      
      private function §_-Qg§() : void
      {
         §_-0yX§ = new Sprite();
         §_-0yX§.alpha = 0;
         §_-0yX§.doubleClickEnabled = true;
         §_-0yX§.graphics.beginFill(0);
         §_-0yX§.graphics.drawRect(0,0,100,100);
         addChild(§_-0yX§);
      }
      
      override public function get filters() : Array
      {
         throw new Error("filters is not supported in View3D. Use filters3d instead.");
      }
      
      override public function set filters(param1:Array) : void
      {
         throw new Error("filters is not supported in View3D. Use filters3d instead.");
      }
      
      public function get filters3d() : Array
      {
         return §_-1Ht§ ? §_-1Ht§.filters : null;
      }
      
      public function set filters3d(param1:Array) : void
      {
         if(param1 && param1.length == 0)
         {
            param1 = null;
         }
         if(§_-1Ht§ && !param1)
         {
            §_-1Ht§.dispose();
            §_-1Ht§ = null;
         }
         else if(!§_-1Ht§ && param1)
         {
            §_-1Ht§ = new §_-3pD§(stage3DProxy);
            §_-1Ht§.filters = param1;
         }
         if(§_-1Ht§)
         {
            §_-1Ht§.filters = param1;
            §_-4Rw§ = §_-1Ht§.requireDepthRender;
         }
         else
         {
            §_-4Rw§ = false;
            if(§_-vc§)
            {
               §_-vc§.dispose();
               §_-vc§ = null;
            }
         }
      }
      
      public function get renderer() : §_-45r§
      {
         return §_-37g§;
      }
      
      public function set renderer(param1:§_-45r§) : void
      {
         §_-37g§.dispose();
         §_-37g§ = param1;
         §_-0ac§ = §_-37g§.§_-1AW§();
         §_-0ac§.camera = §_-h8§;
         §_-37g§.stage3DProxy = _stage3DProxy;
         §_-37g§.§_-0FJ§ = §_-07n§;
         §_-37g§.backgroundR = (§_-34§ >> 16 & 0xFF) / 255;
         §_-37g§.backgroundG = (§_-34§ >> 8 & 0xFF) / 255;
         §_-37g§.backgroundB = (§_-34§ & 0xFF) / 255;
         §_-37g§.§_-0Jy§ = §_-0I3§;
         §_-37g§.§_-3OY§ = _width;
         §_-37g§.§_-0Cu§ = _height;
         §_-1lx§ = true;
      }
      
      public function get backgroundColor() : uint
      {
         return §_-34§;
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         §_-34§ = param1;
         §_-37g§.backgroundR = (param1 >> 16 & 0xFF) / 255;
         §_-37g§.backgroundG = (param1 >> 8 & 0xFF) / 255;
         §_-37g§.backgroundB = (param1 & 0xFF) / 255;
      }
      
      public function get §_-0Jy§() : Number
      {
         return §_-0I3§;
      }
      
      public function set §_-0Jy§(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         else if(param1 < 0)
         {
            param1 = 0;
         }
         §_-37g§.§_-0Jy§ = param1;
         §_-0I3§ = param1;
      }
      
      public function get camera() : §_-49B§
      {
         return §_-h8§;
      }
      
      public function set camera(param1:§_-49B§) : void
      {
         §_-h8§.removeEventListener("lensChanged",§_-0-9§);
         §_-h8§ = param1;
         §_-0ac§.camera = §_-h8§;
         if(§_-4Cf§)
         {
            §_-h8§.§_-MQ§ = §_-4Cf§.§_-MQ§;
         }
         §_-h8§.addEventListener("lensChanged",§_-0-9§);
         §_-2Ym§ = true;
         §_-4ZC§ = true;
      }
      
      public function get scene() : §_-38d§
      {
         return §_-4Cf§;
      }
      
      public function set scene(param1:§_-38d§) : void
      {
         §_-4Cf§.removeEventListener("partitionChanged",§_-4As§);
         §_-4Cf§ = param1;
         §_-4Cf§.addEventListener("partitionChanged",§_-4As§);
         if(§_-h8§)
         {
            §_-h8§.§_-MQ§ = §_-4Cf§.§_-MQ§;
         }
      }
      
      public function get §_-4LZ§() : uint
      {
         return §_-09p§;
      }
      
      override public function get width() : Number
      {
         return _width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_stage3DProxy && _stage3DProxy.§_-PH§ && param1 > 2048)
         {
            param1 = 2048;
         }
         if(_width == param1)
         {
            return;
         }
         if(§_-1AM§)
         {
            §_-1AM§.§_-3OY§ = param1;
         }
         §_-0yX§.width = param1;
         _width = param1;
         §_-4n0§ = _width / _height;
         §_-h8§.§_-5w§.aspectRatio = §_-4n0§;
         §_-TU§ = true;
         §_-37g§.§_-3OY§ = param1;
         §_-108§.width = param1;
         §_-1lx§ = true;
         §_-2Ym§ = true;
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(_stage3DProxy && _stage3DProxy.§_-PH§ && param1 > 2048)
         {
            param1 = 2048;
         }
         if(_height == param1)
         {
            return;
         }
         if(§_-1AM§)
         {
            §_-1AM§.§_-0Cu§ = param1;
         }
         §_-0yX§.height = param1;
         _height = param1;
         §_-4n0§ = _width / _height;
         §_-h8§.§_-5w§.aspectRatio = §_-4n0§;
         §_-TU§ = true;
         §_-37g§.§_-0Cu§ = param1;
         §_-108§.height = param1;
         §_-1lx§ = true;
         §_-2Ym§ = true;
      }
      
      override public function set x(param1:Number) : void
      {
         if(x == param1)
         {
            return;
         }
         §_-3Ex§.x = super.x = param1;
         §_-0n-§.x = parent ? parent.localToGlobal(§_-3Ex§).x : param1;
         §_-3rG§ = true;
      }
      
      override public function set y(param1:Number) : void
      {
         if(y == param1)
         {
            return;
         }
         §_-3Ex§.y = super.y = param1;
         §_-0n-§.y = parent ? parent.localToGlobal(§_-3Ex§).y : param1;
         §_-3rG§ = true;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(_stage3DProxy && !§_-37W§)
         {
            _stage3DProxy.visible = param1;
         }
      }
      
      public function get §_-0FJ§() : uint
      {
         return §_-07n§;
      }
      
      public function set §_-0FJ§(param1:uint) : void
      {
         §_-07n§ = param1;
         §_-37g§.§_-0FJ§ = param1;
         §_-1lx§ = true;
      }
      
      public function get §_-2Yk§() : uint
      {
         return §_-0ac§.§_-3Dr§;
      }
      
      public function get shareContext() : Boolean
      {
         return §_-37W§;
      }
      
      public function set shareContext(param1:Boolean) : void
      {
         if(§_-37W§ == param1)
         {
            return;
         }
         §_-37W§ = param1;
         §_-3rG§ = true;
      }
      
      protected function §_-1s4§() : void
      {
         if(_stage3DProxy.context3D && !§_-37W§)
         {
            if(_width && _height)
            {
               if(_stage3DProxy.§_-PH§)
               {
                  if(_width > 2048)
                  {
                     _width = 2048;
                  }
                  if(_height > 2048)
                  {
                     _height = 2048;
                  }
               }
               _stage3DProxy.configureBackBuffer(_width,_height,§_-07n§);
               §_-1lx§ = false;
            }
            else
            {
               width = stage.stageWidth;
               height = stage.stageHeight;
            }
         }
      }
      
      public function §_-224§(param1:String) : void
      {
         §_-1SH§ = param1;
         §_-3QI§();
      }
      
      public function render() : void
      {
         var _loc1_:Point = null;
         if(!stage3DProxy.§_-3hs§())
         {
            §_-1lx§ = true;
            return;
         }
         if(§_-1lx§)
         {
            §_-1s4§();
         }
         if(§_-37W§ && §_-0LX§)
         {
            stage3DProxy.§_-4P1§();
         }
         if(!get)
         {
            _loc1_ = parent.localToGlobal(§_-3Ex§);
            if(§_-0n-§.x != _loc1_.x || §_-0n-§.y != _loc1_.y)
            {
               §_-0n-§ = _loc1_;
               §_-3rG§ = true;
            }
         }
         if(§_-3rG§)
         {
            §_-1AY§();
         }
         §_-Ox§();
         §_-46O§();
         §_-0ac§.clear();
         §_-4Cf§.§_-3AE§(§_-0ac§);
         §_-1SV§.§_-1G3§(this);
         §_-3py§.§_-1G3§();
         if(§_-4Rw§)
         {
            §_-2d3§(§_-0ac§);
         }
         if(§_-3Jf§)
         {
            §_-IG§(§_-0ac§);
         }
         §_-37g§.§_-0g8§ = !§_-3Jf§;
         if(§_-1Ht§ && _stage3DProxy.§_-In§)
         {
            §_-37g§.render(§_-0ac§,§_-1Ht§.getMainInputTexture(_stage3DProxy),§_-1AM§.§_-1Ib§);
            §_-1Ht§.render(_stage3DProxy,camera,§_-vc§);
         }
         else
         {
            §_-37g§.shareContext = §_-37W§;
            if(§_-37W§)
            {
               §_-37g§.render(§_-0ac§,null,§_-108§);
            }
            else
            {
               §_-37g§.render(§_-0ac§);
            }
         }
         if(!§_-37W§)
         {
            stage3DProxy.present();
            §_-1SV§.§_-1Ii§();
            §_-3py§.§_-XN§();
         }
         §_-0ac§.cleanUp();
         stage3DProxy.§_-36M§ = false;
      }
      
      protected function §_-1AY§() : void
      {
         §_-3rG§ = false;
         if(!_stage3DProxy)
         {
            return;
         }
         if(§_-37W§)
         {
            §_-108§.x = §_-0n-§.x - _stage3DProxy.x;
            §_-108§.y = §_-0n-§.y - _stage3DProxy.y;
         }
         else
         {
            §_-108§.x = 0;
            §_-108§.y = 0;
            _stage3DProxy.x = §_-0n-§.x;
            _stage3DProxy.y = §_-0n-§.y;
         }
         §_-2Ym§ = true;
      }
      
      protected function §_-Ox§() : void
      {
         var _loc1_:Number = getTimer();
         if(§_-0kU§ == 0)
         {
            §_-0kU§ = _loc1_;
         }
         §_-09p§ = _loc1_ - §_-0kU§;
         §_-0kU§ = _loc1_;
      }
      
      protected function §_-46O§() : void
      {
         §_-h8§.§_-5w§.aspectRatio = §_-4n0§;
         if(§_-2Ym§)
         {
            §_-2Ym§ = false;
            §_-h8§.§_-5w§.§_-3ym§(§_-108§.x,§_-108§.y,§_-108§.width,§_-108§.height);
         }
         if(§_-4ZC§)
         {
            §_-4ZC§ = false;
            §_-h8§.§_-5w§.§_-0g5§(_stage3DProxy.viewPort.x,_stage3DProxy.viewPort.y,_stage3DProxy.viewPort.width,_stage3DProxy.viewPort.height);
         }
         if(§_-1Ht§ || §_-37g§.renderToTexture)
         {
            §_-37g§.§_-41v§ = §_-1AM§.§_-41v§;
            §_-37g§.§_-0SY§ = §_-1AM§.§_-0SY§;
         }
         else
         {
            §_-37g§.§_-41v§ = 1;
            §_-37g§.§_-0SY§ = 1;
         }
      }
      
      protected function §_-IG§(param1:§_-0ls§) : void
      {
         §_-0vF§.§_-3BK§ = true;
         if(§_-1Ht§ || §_-37g§.renderToTexture)
         {
            §_-0vF§.§_-41v§ = §_-1AM§.§_-41v§;
            §_-0vF§.§_-0SY§ = §_-1AM§.§_-0SY§;
            §_-0vF§.render(param1,§_-1Ht§.getMainInputTexture(_stage3DProxy),§_-1AM§.§_-1Ib§);
         }
         else
         {
            §_-0vF§.§_-41v§ = 1;
            §_-0vF§.§_-0SY§ = 1;
            §_-0vF§.render(param1);
         }
         §_-0vF§.§_-3BK§ = false;
      }
      
      protected function §_-2d3§(param1:§_-0ls§) : void
      {
         if(§_-TU§ || !§_-vc§)
         {
            §_-1o-§(_stage3DProxy.§_-In§);
         }
         §_-0vF§.§_-41v§ = §_-1AM§.§_-41v§;
         §_-0vF§.§_-0SY§ = §_-1AM§.§_-0SY§;
         §_-0vF§.render(param1,§_-vc§);
      }
      
      private function §_-1o-§(param1:Context3D) : void
      {
         §_-TU§ = false;
         if(§_-vc§)
         {
            §_-vc§.dispose();
         }
         §_-vc§ = param1.createTexture(§_-1AM§.textureWidth,§_-1AM§.textureHeight,"bgra",true);
      }
      
      public function dispose() : void
      {
         _stage3DProxy.removeEventListener("ViewportUpdated",§_-nT§);
         _stage3DProxy.removeEventListener("Context3DRecreated",onContext3DRecreated);
         if(!shareContext)
         {
            _stage3DProxy.dispose();
         }
         §_-37g§.dispose();
         if(§_-vc§)
         {
            §_-vc§.dispose();
         }
         if(§_-1AM§)
         {
            §_-1AM§.dispose();
         }
         §_-1SV§.§_-2Py§(this);
         §_-1SV§.dispose();
         §_-3py§.§_-3pe§(this);
         §_-3py§.dispose();
         §_-1AM§ = null;
         §_-vc§ = null;
         §_-1SV§ = null;
         §_-3py§ = null;
         §_-0vF§ = null;
         _stage3DProxy = null;
         §_-37g§ = null;
         §_-0ac§ = null;
      }
      
      public function §_-3ZO§(param1:Vector3D) : Vector3D
      {
         var _loc2_:Vector3D = §_-h8§.§_-3ZO§(param1);
         _loc2_.x = (_loc2_.x + 1) * _width / 2;
         _loc2_.y = (_loc2_.y + 1) * _height / 2;
         return _loc2_;
      }
      
      public function unproject(param1:Number, param2:Number, param3:Number, param4:Vector3D = null) : Vector3D
      {
         return §_-h8§.unproject((param1 * 2 - _width) / _stage3DProxy.width,(param2 * 2 - _height) / _stage3DProxy.height,param3,param4);
      }
      
      public function §_-4ll§(param1:Number, param2:Number, param3:Number) : Vector3D
      {
         return §_-h8§.§_-4ll§((param1 * 2 - _width) / _width,(param2 * 2 - _height) / _height,param3);
      }
      
      public function get §_-0AP§() : §_-eg§
      {
         return §_-1SV§.§_-0AP§;
      }
      
      public function set §_-0AP§(param1:§_-eg§) : void
      {
         §_-1SV§.§_-0AP§ = param1;
      }
      
      public function get §_-AN§() : §_-eg§
      {
         return §_-3py§.§_-AN§;
      }
      
      public function set §_-AN§(param1:§_-eg§) : void
      {
         §_-3py§.§_-AN§ = param1;
      }
      
      arcane function get §_-0eX§() : §_-0ls§
      {
         return §_-0ac§;
      }
      
      private function §_-0-9§(param1:§_-1d5§) : void
      {
         §_-2Ym§ = true;
         §_-4ZC§ = true;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         if(§_-45b§)
         {
            return;
         }
         §_-45b§ = true;
         if(!_stage3DProxy)
         {
            _stage3DProxy = Stage3DManager.getInstance(stage).§_-Ds§(§_-0W0§,§_-0dL§);
            _stage3DProxy.addEventListener("ViewportUpdated",§_-nT§);
            _stage3DProxy.addEventListener("Context3DRecreated",onContext3DRecreated);
         }
         §_-3rG§ = true;
         §_-1AM§ = §_-Da§.getInstance(_stage3DProxy);
         §_-37g§.stage3DProxy = §_-0vF§.stage3DProxy = _stage3DProxy;
         if(_width == 0)
         {
            width = stage.stageWidth;
         }
         else
         {
            §_-1AM§.§_-3OY§ = _width;
         }
         if(_height == 0)
         {
            height = stage.stageHeight;
         }
         else
         {
            §_-1AM§.§_-0Cu§ = _height;
         }
         if(§_-37W§)
         {
            §_-1SV§.§_-2y1§(this);
         }
      }
      
      private function §_-22U§(param1:Event) : void
      {
         get = parent == stage;
         §_-0n-§ = parent.localToGlobal(§_-3Ex§);
         §_-3rG§ = true;
      }
      
      private function §_-nT§(param1:§_-2N4§) : void
      {
         if(§_-37W§)
         {
            §_-108§.x = §_-0n-§.x - _stage3DProxy.x;
            §_-108§.y = §_-0n-§.y - _stage3DProxy.y;
            §_-2Ym§ = true;
         }
         §_-4ZC§ = true;
      }
      
      override public function set z(param1:Number) : void
      {
      }
      
      override public function set scaleZ(param1:Number) : void
      {
      }
      
      override public function set rotation(param1:Number) : void
      {
      }
      
      override public function set rotationX(param1:Number) : void
      {
      }
      
      override public function set rotationY(param1:Number) : void
      {
      }
      
      override public function set rotationZ(param1:Number) : void
      {
      }
      
      override public function set transform(param1:Transform) : void
      {
      }
      
      override public function set scaleX(param1:Number) : void
      {
      }
      
      override public function set scaleY(param1:Number) : void
      {
      }
   }
}

