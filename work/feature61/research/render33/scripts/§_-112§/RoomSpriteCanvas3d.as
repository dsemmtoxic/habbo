package §_-112§
{
   import §_-01y§.§_-3XY§;
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-296§;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-0KT§.§_-1eU§;
   import §_-0XR§.§_-3z0§;
   import §_-0od§.§_-49n§;
   import §_-0r1§.§_-2BE§;
   import §_-0r1§.§_-9t§;
   import §_-0r1§.§_-LL§;
   import §_-0sg§.§_-3Ks§;
   import §_-0zo§.§_-1Tv§;
   import §_-0zo§.gpu_debug;
   import §_-15y§.§_-49B§;
   import §_-1N-§.§_-2mJ§;
   import §_-1NF§.§_-4Ay§;
   import §_-1iL§.§_-Ro§;
   import §_-1wh§.§_-Wg§;
   import §_-2EC§.§_-1au§;
   import §_-2gz§.§_-3f1§;
   import §_-381§.§_-Vg§;
   import §_-3l1§.§_-3Az§;
   import §_-44B§.§_-iA§;
   import §_-4CJ§.§_-2-p§;
   import §_-4CJ§.§_-4bR§;
   import §_-9m§.§_-4UD§;
   import §_-pp§.§_-FG§;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import loginpatch.HabboTicketLogin;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   
   use namespace gpu_debug;
   
   public class RoomSpriteCanvas3d implements §_-1Ia§, §_-1eU§
   {
      
      public static const §_-3mB§:String = "RSC3D_TOP";
      
      public static const §_-3CL§:String = "RSC3D_BOTTOM";
      
      public static const §_-3Sq§:String = "RSC3D_DOOR";
      
      private static const §_-0Bx§:int = 300;
      
      public static const §_-2Mt§:Class = room_door_png;
      
      private var _disposed:Boolean;
      
      private var §_-0zB§:Sprite;
      
      private var §_-uR§:Quad;
      
      private var §_-1QM§:Sprite;
      
      private var §_-K9§:Sprite;
      
      private var §_-0Wh§:QuadBatch;
      
      private var §_-39D§:Dictionary;
      
      private var §_-4hI§:Dictionary;
      
      private var §_-2IH§:uint;
      
      private var §_-2Zq§:§_-2m4§;
      
      private var §_-H-§:Boolean;
      
      private var §_-12F§:§_-49n§;
      
      private var §_-3ea§:Dictionary;
      
      private var §_-CJ§:Dictionary;
      
      private var §_-sP§:Dictionary;
      
      private var §_-086§:§_-49B§;
      
      private var §_-3dC§:§_-0AJ§;
      
      private var §_-4BW§:§_-0hD§;
      
      private var §_-Pk§:§_-Vg§;
      
      private var §_-4M8§:String;
      
      private var §_-1ac§:int;
      
      private var §_-Gc§:int;
      
      private var _wd2:int;
      
      private var _ht2:int;
      
      private var §_-ya§:§_-296§;
      
      private var §_-42d§:uint;
      
      private var §_-zW§:§_-9t§;
      
      private var §_-zX§:Boolean;
      
      private var §_-10J§:Boolean;
      
      private var §_-240§:int;
      
      private var §_-3US§:int;
      
      private var §_-2yC§:Boolean;
      
      private var §_-1Lp§:Number = 1;
      
      private var §_-2We§:Number = 1;
      
      private var §_-1Qb§:Boolean;
      
      private var §_-1xX§:§_-Ro§;
      
      private var _roomEngine:§_-3XY§;
      
      private var §_-3x9§:§_-FG§;
      
      private var §_-0WL§:Number;
      
      private var §_-15P§:Number;
      
      private var §_-Zm§:Number;
      
      private var §_-0xH§:Number;
      
      private var §_-4AN§:§_-3gO§;
      
      private var §_-2jT§:Number;
      
      private var §_-1Kj§:Boolean;
      
      private var §_-3P9§:Image;
      
      private var §_-1Mx§:Sprite;
      
      private var §_-3BW§:Array;
      
      private var §_-4Wr§:§_-Ro§;
      
      private var §_-2rh§:Boolean;
      
      private var §_-33V§:Boolean = true;
      
      public function RoomSpriteCanvas3d(param1:§_-0AJ§, param2:String, param3:int, param4:int, param5:int)
      {
         var _loc6_:Point = null;
         var _loc8_:Point = null;
         super();
         §_-3dC§ = param1;
         §_-4M8§ = param2;
         §_-0zB§ = new Sprite();
         §_-0zB§.blendMode = "normal";
         §_-0zB§.alpha = 0.9999;
         §_-uR§ = new Quad(param3,param4);
         §_-uR§.alpha = 0;
         §_-uR§.blendMode = "none";
         §_-0zB§.addChild(§_-uR§);
         §_-1QM§ = new Sprite();
         §_-1QM§.touchable = false;
         §_-0zB§.addChild(§_-1QM§);
         §_-1Mx§ = new Sprite();
         §_-1Mx§.alpha = 0.9999;
         §_-1Mx§.blendMode = "normal";
         §_-1Mx§.name = "RSC3D_DOOR";
         §_-1QM§.addChild(§_-1Mx§);
         §_-0Wh§ = new QuadBatch();
         §_-0Wh§.alpha = 0.9999;
         §_-0Wh§.blendMode = "normal";
         §_-0Wh§.name = "RSC3D_BOTTOM";
         §_-0Wh§.touchable = false;
         §_-1QM§.addChild(§_-0Wh§);
         §_-K9§ = new Sprite();
         §_-K9§.blendMode = "normal";
         §_-K9§.alpha = 0.9999;
         §_-K9§.name = "RSC3D_TOP";
         §_-K9§.touchable = false;
         §_-1QM§.addChild(§_-K9§);
         §_-1Tv§.§_-0R5§.addEventListener("STE_compressed",§_-3-l§);
         §_-39D§ = new Dictionary();
         §_-4hI§ = new Dictionary();
         §_-12F§ = new §_-49n§();
         §_-12F§.mouseEnabled = false;
         §_-3ea§ = new Dictionary();
         §_-CJ§ = new Dictionary();
         §_-ya§ = new §_-296§(param5,new Vector3d(-135,30,0),new Vector3d(0,0,0),new Vector3d(-135,0.5,0));
         var _loc7_:String = null;
         if(§_-3dC§ != null)
         {
            _loc7_ = §_-3dC§.§_-0nh§;
         }
         §_-zW§ = new §_-9t§(_loc7_);
         §_-4BW§ = new §_-0hD§(this,§_-1QM§,§_-uR§,§_-4hI§);
         §_-1X4§(param3,param4);
         if(§_-2mJ§.§_-1nG§)
         {
            _loc6_ = new Point(_wd2,_ht2);
            _loc8_ = §_-1QM§.globalToLocal(_loc6_);
            §_-2fO§(2,_loc6_,_loc8_);
            §_-2We§ = 2;
         }
         §_-3BW§ = [];
         §_-2Zq§ = new §_-2m4§(this);
         Starling.current.stage.addEventListener("resize",onStageResize);
      }
      
      private static function §_-Ie§(param1:Image) : void
      {
         param1.removeFromParent();
         param1.dispose();
      }
      
      public function pause() : void
      {
         §_-10J§ = true;
      }
      
      public function resume() : void
      {
         §_-10J§ = false;
      }
      
      public function set roomEngine(param1:§_-3XY§) : void
      {
         _roomEngine = param1;
         if(_roomEngine)
         {
            _roomEngine.events.addEventListener("REOE_REMOVED",§_-2WQ§);
         }
         var _temp_3:* = _roomEngine;
         var _temp_2:* = _roomEngine.§_-0Y§;
         §_-1xX§ = _temp_3.§_-46h§(HabboTicketLogin.floorRoomId(_temp_2,this),-1,0);
         if(§_-4BW§)
         {
            §_-4BW§.roomEngine = param1;
         }
         var _temp_5:* = _roomEngine.§_-0Y§;
         var _loc6_:int = HabboTicketLogin.floorRoomId(_temp_5,this);
         var _loc8_:Number = _roomEngine.§_-1Jo§(_loc6_,"room_door_x");
         var _loc7_:Number = _roomEngine.§_-1Jo§(_loc6_,"room_door_y");
         var _loc4_:Number = _roomEngine.§_-1Jo§(_loc6_,"room_door_z");
         var _loc2_:Number = _roomEngine.§_-1Jo§(_loc6_,"room_door_dir");
         var _loc3_:Vector3d = new Vector3d(_loc8_,_loc7_,_loc4_);
         var _loc5_:Vector3d = null;
         if(_loc2_ == 90)
         {
            _loc5_ = new Vector3d(-2000,0,0);
         }
         if(_loc2_ == 180)
         {
            _loc5_ = new Vector3d(0,-2000,0);
         }
         §_-ya§.§_-1-m§(_loc3_,_loc5_);
         center();
         HabboTicketLogin.rememberRoomCanvas(this,param1);
      }
      
      public function set desktop(param1:§_-FG§) : void
      {
         §_-3x9§ = param1;
      }
      
      public function §_-KR§() : Vector.<§_-Wg§>
      {
         var _loc1_:* = null;
         var _loc2_:Vector.<§_-Wg§> = new Vector.<§_-Wg§>(0);
         for each(_loc1_ in §_-39D§)
         {
            _loc2_.push(_loc1_.§_-Nf§());
         }
         for each(_loc1_ in §_-4hI§)
         {
            _loc2_.push(_loc1_.§_-Nf§());
         }
         return _loc2_;
      }
      
      public function §_-3iO§() : Array
      {
         return §_-zW§.§_-3iO§();
      }
      
      public function get roomEngine() : §_-3XY§
      {
         return _roomEngine;
      }
      
      public function get desktop() : §_-FG§
      {
         return §_-3x9§;
      }
      
      public function get roomObject() : §_-Ro§
      {
         return §_-1xX§;
      }
      
      public function get container() : §_-0AJ§
      {
         return §_-3dC§;
      }
      
      public function get canvas() : Sprite
      {
         return §_-0zB§;
      }
      
      public function get §_-GE§() : QuadBatch
      {
         return §_-0Wh§;
      }
      
      public function get §_-4gI§() : Sprite
      {
         return §_-K9§;
      }
      
      public function get §_-2ne§() : Sprite
      {
         return §_-1QM§;
      }
      
      public function get §_-14B§() : Dictionary
      {
         return §_-4hI§;
      }
      
      public function get §_-0dA§() : Dictionary
      {
         return §_-39D§;
      }
      
      public function get §_-1Gf§() : int
      {
         return _wd2;
      }
      
      public function get §_-1cn§() : int
      {
         return _ht2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         HabboTicketLogin.disposeRoomCanvas(this);
         Starling.current.stage.removeEventListener("resize",onStageResize);
         §_-1Tv§.§_-0R5§.removeEventListener("STE_compressed",§_-3-l§);
         if(§_-2Zq§)
         {
            §_-2Zq§.dispose();
            §_-2Zq§ = null;
         }
         if(§_-39D§ != null)
         {
            for(var _loc1_:String in §_-39D§)
            {
               delete §_-39D§[_loc1_];
            }
            §_-39D§ = null;
         }
         if(§_-4hI§ != null)
         {
            for(var _loc2_:String in §_-4hI§)
            {
               delete §_-4hI§[_loc2_];
            }
            §_-4hI§ = null;
         }
         §_-1Mx§ = null;
         §_-1gP§();
         §_-CJ§ = null;
         §_-3ea§ = null;
         §_-086§ = null;
         if(§_-4BW§)
         {
            §_-4BW§.dispose();
            §_-4BW§ = null;
         }
         if(§_-Pk§)
         {
            §_-Pk§.dispose();
            §_-Pk§ = null;
         }
         if(§_-0zB§)
         {
            §_-0zB§.removeFromParent();
            §_-0zB§.dispose();
            §_-0zB§ = null;
         }
         if(§_-12F§)
         {
            §_-12F§.§_-1dM§();
            §_-12F§ = null;
         }
         if(_roomEngine && _roomEngine.events)
         {
            _roomEngine.events.removeEventListener("REOE_REMOVED",§_-2WQ§);
         }
         _roomEngine = null;
         §_-3x9§ = null;
         _disposed = true;
      }
      
      public function set visible(param1:Boolean) : void
      {
         §_-0zB§.visible = param1;
         §_-12F§.visible = param1;
      }
      
      private function §_-2WQ§(param1:§_-3Ks§) : void
      {
         var _loc2_:int = param1.category;
         if(_loc2_ == 10 || _loc2_ == 20)
         {
            §_-H-§ = true;
         }
      }
      
      private function §_-3-l§(param1:Event) : void
      {
         if(_disposed)
         {
            return;
         }
         if(!§_-1QM§)
         {
            return;
         }
         if(§_-4hI§ != null)
         {
            for(var _loc2_:String in §_-4hI§)
            {
               delete §_-4hI§[_loc2_];
            }
         }
         if(§_-0Wh§)
         {
            §_-0Wh§.reset();
         }
         §_-zX§ = true;
         §_-BU§();
         render(getTimer());
      }
      
      private function §_-BU§() : void
      {
         var _loc1_:§_-4bR§ = null;
         var _loc2_:§_-2-p§ = null;
         var _loc3_:§_-Ro§ = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Texture = null;
         var _loc6_:int = §_-3dC§.§_-2vx§();
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = §_-3dC§.§_-2Fe§(_loc5_);
            if(_loc3_ != §_-1xX§)
            {
               _loc1_ = _loc3_.§_-Eq§() as §_-4bR§;
               _loc7_ = _loc1_.§_-06r§;
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  _loc2_ = _loc1_.§_-eh§(_loc8_);
                  if(!(!_loc2_ || _loc2_.§_-M2§ || !_loc2_.image || _loc2_.§_-05T§ == null))
                  {
                     _loc4_ = §_-1Tv§.§_-0R5§.§_-4nG§(_loc2_.§_-05T§);
                     if(!_loc4_)
                     {
                        Logger.log("Warning, no texture found when updating dirty textures: " + _loc2_.§_-05T§);
                     }
                     else
                     {
                        _loc2_.image.texture = _loc4_;
                        _loc2_.image.readjustSize();
                     }
                  }
                  _loc8_++;
               }
            }
            _loc5_++;
         }
      }
      
      public function update(param1:uint) : void
      {
         if(§_-2yC§ || §_-1Qb§)
         {
            §_-1QM§.x = §_-240§;
            §_-1QM§.y = §_-3US§;
            §_-1QM§.scaleX = §_-1Lp§;
            §_-1QM§.scaleY = §_-1Lp§;
            §_-4fU§();
            §_-0ns§();
            §_-2yC§ = false;
            §_-1Qb§ = false;
         }
      }
      
      public function render(param1:int, param2:Boolean = false) : void
      {
         var _loc16_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc22_:int = 0;
         var _loc10_:§_-Ro§ = null;
         var _loc4_:§_-4bR§ = null;
         var _loc12_:Boolean = false;
         var _loc17_:int = 0;
         var _loc19_:§_-LL§ = null;
         var _loc15_:§_-2BE§ = null;
         var _loc11_:§_-3gO§ = null;
         var _loc26_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc27_:Boolean = false;
         var _loc3_:§_-3gO§ = null;
         var _loc31_:int = 0;
         var _loc24_:int = 0;
         var _loc20_:§_-2-p§ = null;
         var _loc21_:int = 0;
         var _loc18_:§_-4UD§ = null;
         var _loc13_:Boolean = false;
         var _loc8_:Boolean = false;
         if(_disposed || !§_-0zB§.visible)
         {
            return;
         }
         if(§_-10J§)
         {
            return;
         }
         var _loc6_:Boolean = §_-ya§.§_-9l§ != §_-42d§;
         if(_loc6_)
         {
            §_-42d§ = §_-ya§.§_-9l§;
            §_-2rh§ = true;
            §_-4fU§();
         }
         if(§_-2rh§)
         {
            §_-4dH§.§_-2Kd§(§_-4hI§,§_-0Wh§);
            §_-2rh§ = false;
            §_-zX§ = true;
         }
         var _loc9_:§_-iA§ = §_-3dC§.§_-2Bl§();
         var _loc14_:Array = _loc9_.§_-3Yb§();
         var _loc29_:int = int(_loc14_.length);
         var _loc7_:Boolean = true;
         var _loc5_:Number = §_-ya§.scale;
         var _loc30_:Number = §_-ya§.direction.x;
         _loc22_ = 0;
         while(_loc22_ < _loc29_)
         {
            _loc10_ = _loc14_[_loc22_];
            _loc4_ = _loc10_.§_-Eq§() as §_-4bR§;
            _loc12_ = Boolean(_loc4_.update(§_-ya§,param1,true,false,_loc5_,_loc30_));
            if(!(!§_-zX§ && !_loc6_ && !_loc12_))
            {
               _loc17_ = _loc10_.§_-3YM§();
               if(_loc17_ == 0 && (_loc6_ || _loc12_))
               {
                  §_-1gP§();
                  §_-1Ie§();
               }
               _loc19_ = §_-zW§.§_-Ua§(_loc10_.§_-4he§());
               _loc15_ = _loc19_.location;
               _loc11_ = _loc15_.§_-079§(_loc10_,§_-ya§);
               _loc25_ = _loc11_.x;
               _loc26_ = _loc11_.y;
               _loc28_ = _loc11_.z;
               _loc27_ = false;
               if(§_-1Kj§ && _loc17_ == 100)
               {
                  _loc3_ = _loc10_.getLocation();
                  _loc27_ = _loc3_.x == §_-4AN§.x && _loc3_.y == §_-4AN§.y;
               }
               _loc31_ = _loc4_.§_-06r§;
               _loc24_ = 0;
               for(; _loc24_ < _loc31_; _loc24_++)
               {
                  _loc20_ = _loc4_.§_-eh§(_loc24_);
                  if(!(!_loc20_ || (_loc20_.§_-M2§ || !_loc20_.image && !_loc20_.mesh)))
                  {
                     if(_loc20_.mesh)
                     {
                        if(_loc20_.visible)
                        {
                           §_-13g§(_loc20_);
                        }
                     }
                     else
                     {
                        _loc21_ = _loc20_.§_-3Oy§;
                        _loc18_ = §_-39D§[_loc21_];
                        if(_loc18_ && _loc18_.disposed)
                        {
                           delete §_-39D§[_loc21_];
                           _loc18_ = null;
                        }
                        else if(!_loc18_)
                        {
                           _loc18_ = §_-4hI§[_loc21_];
                           if(_loc18_)
                           {
                              _loc16_ = true;
                              if(_loc18_.disposed)
                              {
                                 delete §_-4hI§[_loc21_];
                                 continue;
                              }
                           }
                        }
                        if(!_loc18_)
                        {
                           _loc8_ = _loc10_.getId() == -1 || §_-3BW§.indexOf(_loc10_.getId()) != -1;
                           _loc18_ = §_-2Zq§.createImage(_loc10_,_loc20_,_loc4_,_loc21_,_loc24_,_loc25_,_loc26_,_loc28_,_loc8_);
                           _loc13_ = true;
                        }
                        else if(_loc18_.§_-9l§ != _loc20_.§_-9l§ || §_-zX§)
                        {
                           _loc18_.x = _loc25_ + _loc20_.offsetX + _wd2;
                           _loc18_.y = _loc26_ + _loc20_.offsetY + _ht2;
                           _loc18_.z = _loc28_ + _loc20_.relativeDepth + 3.7e-11 * _loc24_;
                           if(_loc20_.flipH)
                           {
                              _loc18_.scaleX = -1;
                              _loc18_.x += _loc18_.width;
                           }
                           else
                           {
                              _loc18_.scaleX = 1;
                           }
                           _loc18_.§_-05y§ = _loc20_.offsetX;
                           _loc18_.§_-1nN§ = _loc20_.offsetY;
                           _loc18_.§_-9l§ = _loc20_.§_-9l§;
                           _loc13_ = true;
                        }
                        if(§_-1Kj§ && _loc27_)
                        {
                           if(_loc18_.parent != §_-1Mx§)
                           {
                              §_-1Mx§.addChild(_loc18_ as starling.display.DisplayObject);
                              _loc23_ = true;
                           }
                        }
                        else if(_loc18_.parent == §_-1Mx§)
                        {
                           §_-K9§.addChild(_loc18_ as starling.display.DisplayObject);
                        }
                        if(_loc13_)
                        {
                           §_-02t§(_loc18_);
                           if(_loc10_ == §_-4Wr§ && !§_-4BW§.§_-0XT§() && !§_-4BW§.§_-1Ih§())
                           {
                              §_-0b1§();
                           }
                        }
                     }
                  }
               }
               if(!§_-zX§ && getTimer() - param1 > 300)
               {
                  _loc7_ = false;
                  break;
               }
            }
            _loc22_++;
         }
         §_-3sP§();
         if(§_-H-§)
         {
            for each(_loc18_ in §_-4hI§)
            {
               if(_loc18_ && _loc18_.disposed)
               {
                  delete §_-4hI§[_loc18_.§_-Hi§];
                  _loc16_ = true;
               }
            }
            §_-H-§ = false;
         }
         §_-2IH§ = §_-2IH§ + 1;
         if(§_-2IH§ >= 15)
         {
            §_-K9§.sortChildren(§_-4dH§.§_-3Sb§);
            §_-2IH§ = 0;
         }
         if(_loc7_ && (§_-2Zq§.§_-3Fo§() || _loc16_))
         {
            §_-4dH§.§_-4a4§(§_-4hI§,§_-0Wh§);
            §_-2Zq§.§_-266§();
         }
         if(_loc23_)
         {
            §_-1Mx§.sortChildren(§_-4dH§.§_-3Sb§);
         }
         §_-zX§ = false;
      }
      
      private function §_-0ns§() : void
      {
         var _loc2_:Number = 1 / §_-1QM§.scaleX;
         §_-0WL§ = -§_-1QM§.x * _loc2_;
         §_-15P§ = -§_-1QM§.y * _loc2_;
         §_-Zm§ = (§_-1ac§ - §_-1QM§.x) * _loc2_;
         §_-0xH§ = (§_-Gc§ - §_-1QM§.y) * _loc2_;
         for each(var _loc1_:§_-4UD§ in §_-39D§)
         {
            §_-02t§(_loc1_);
         }
      }
      
      private function §_-02t§(param1:§_-4UD§) : void
      {
         var _loc2_:Number = param1.scaleX == -1 ? -param1.width : 0;
         param1.visible = !(param1.x + _loc2_ > §_-Zm§ || param1.x + param1.width + _loc2_ < §_-0WL§ || param1.y > §_-0xH§ || param1.y + param1.height < §_-15P§);
      }
      
      private function §_-1gP§() : void
      {
         var _loc1_:Object = null;
         if(!§_-12F§)
         {
            return;
         }
         while(§_-12F§.numChildren > 0)
         {
            §_-12F§.removeChildAt(0);
         }
         if(§_-CJ§)
         {
            for each(var _loc2_:§_-3z0§ in §_-CJ§)
            {
               _loc2_.geometry.dispose();
               _loc2_.dispose();
            }
            for(_loc1_ in §_-CJ§)
            {
               delete §_-CJ§[_loc1_];
            }
         }
         if(§_-3ea§)
         {
            for(_loc1_ in §_-3ea§)
            {
               delete §_-3ea§[_loc1_];
            }
         }
         §_-3ea§ = new Dictionary();
         §_-CJ§ = new Dictionary();
      }
      
      private function §_-13g§(param1:§_-2-p§) : void
      {
         if(§_-3ea§[param1.§_-3Oy§])
         {
            return;
         }
         var _loc3_:§_-3z0§ = param1.mesh;
         if(!§_-sP§)
         {
            §_-sP§ = new Dictionary();
         }
         var _loc2_:Vector.<§_-3z0§> = §_-sP§[_loc3_.material];
         if(!_loc2_)
         {
            _loc2_ = new Vector.<§_-3z0§>();
            §_-sP§[_loc3_.material] = _loc2_;
         }
         _loc2_.push(_loc3_);
         §_-3ea§[param1.§_-3Oy§] = _loc3_;
      }
      
      private function §_-3sP§() : void
      {
         var _loc4_:* = undefined;
         var _loc2_:§_-3f1§ = null;
         var _loc1_:§_-3z0§ = null;
         if(!§_-sP§)
         {
            return;
         }
         var _loc3_:§_-1au§ = new §_-1au§();
         for(var _loc5_:Object in §_-sP§)
         {
            _loc4_ = §_-sP§[_loc5_];
            _loc2_ = _loc5_ as §_-3f1§;
            _loc1_ = §_-CJ§[_loc2_];
            if(!_loc1_)
            {
               _loc1_ = new §_-3z0§(new §_-4Ay§(),_loc2_);
               §_-12F§.addChild(_loc1_);
               §_-CJ§[_loc2_] = _loc1_;
            }
            _loc3_.§_-0kT§(_loc1_,_loc4_);
         }
         §_-sP§ = null;
      }
      
      private function §_-4fU§() : void
      {
         var _loc1_:Point = §_-ya§.§_-49b§(new Vector3d());
         var _loc4_:Number = 32 * §_-1Lp§;
         var _loc3_:Number = (_loc1_.x + §_-240§ + _wd2 * (§_-1Lp§ - 1)) / _loc4_;
         var _loc2_:Number = (_loc1_.y + §_-3US§ + _ht2 * (§_-1Lp§ - 1)) / _loc4_ + _loc3_ / 2;
         §_-086§.z = -_loc3_;
         §_-086§.y = _loc2_ * Math.sqrt(0.6666666666666666);
         (§_-086§.§_-5w§ as §_-3Az§).§_-2Et§ = §_-Gc§ / (_loc4_ * 1.4142135623730951);
      }
      
      private function §_-1Ie§() : void
      {
         var _loc1_:Point = null;
         var _temp_1:* = _roomEngine.§_-0Y§;
         var _loc3_:int = HabboTicketLogin.floorRoomId(_temp_1,this);
         var _loc5_:Number = _roomEngine.§_-1Jo§(_loc3_,"room_door_x");
         var _loc4_:Number = _roomEngine.§_-1Jo§(_loc3_,"room_door_y");
         var _loc2_:Number = _roomEngine.§_-1Jo§(_loc3_,"room_door_z");
         §_-4AN§ = new Vector3d(_loc5_,_loc4_,_loc2_);
         §_-2jT§ = _roomEngine.§_-1Jo§(_loc3_,"room_door_dir");
         §_-1Kj§ = §_-1xX§.getModel().getNumber("room_wall_visibility") > 0;
         if(§_-1Kj§)
         {
            if(!§_-3P9§)
            {
               §_-3P9§ = new Image(Texture.fromBitmap(new §_-2Mt§(),false));
               §_-3P9§.smoothing = "none";
               §_-1QM§.addChildAt(§_-3P9§,0);
            }
            _loc1_ = §_-ya§.§_-49b§(§_-4AN§);
            §_-3P9§.x = _loc1_.x + _wd2;
            §_-3P9§.y = _loc1_.y + _ht2 - §_-3P9§.height + 16;
            §_-1Mx§.clipRect = new Rectangle(_loc1_.x + _wd2,_loc1_.y + _ht2 - 70,64,128);
         }
         else
         {
            if(§_-3P9§)
            {
               §_-3P9§.removeFromParent();
               §_-3P9§.dispose();
               §_-3P9§ = null;
            }
            §_-1Mx§.clipRect = null;
         }
      }
      
      public function get §_-2Qb§() : flash.display.DisplayObject
      {
         return null;
      }
      
      public function get displayObjectContainer() : DisplayObjectContainer
      {
         return null;
      }
      
      public function get §_-GL§() : starling.display.DisplayObject
      {
         return §_-0zB§;
      }
      
      public function get §_-12Z§() : §_-49n§
      {
         return §_-12F§;
      }
      
      public function set §_-2vY§(param1:Boolean) : void
      {
      }
      
      public function §_-1X4§(param1:int, param2:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         §_-1ac§ = param1;
         §_-Gc§ = param2;
         _wd2 = §_-1ac§ / 2;
         _ht2 = §_-Gc§ / 2;
         §_-uR§.width = param1;
         §_-uR§.height = param2;
         §_-0ns§();
         §_-2yC§ = true;
      }
      
      public function get width() : int
      {
         return §_-1ac§;
      }
      
      public function get height() : int
      {
         return §_-Gc§;
      }
      
      public function §_-4Xo§(param1:int, param2:int) : void
      {
         §_-240§ = param1;
         §_-3US§ = param2;
         §_-2yC§ = true;
      }
      
      public function set §_-1Ky§(param1:int) : void
      {
         §_-240§ = param1;
         §_-2yC§ = true;
      }
      
      public function set §_-0CN§(param1:int) : void
      {
         §_-3US§ = param1;
         §_-2yC§ = true;
      }
      
      public function get §_-1Ky§() : int
      {
         return §_-240§;
      }
      
      public function get §_-0CN§() : int
      {
         return §_-3US§;
      }
      
      public function get geometry() : §_-4hO§
      {
         return §_-ya§;
      }
      
      public function set §_-2Ta§(param1:§_-1HA§) : void
      {
      }
      
      public function §_-2A6§(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         §_-4BW§.§_-168§(new Point(param1,param2));
         return true;
      }
      
      public function set §_-2SW§(param1:§_-49B§) : void
      {
         §_-086§ = param1;
         §_-4fU§();
      }
      
      public function get scale() : Number
      {
         return §_-1Lp§;
      }
      
      public function get §_-3TR§() : Number
      {
         return §_-2We§;
      }
      
      public function §_-2fO§(param1:Number, param2:Point = null, param3:Point = null, param4:Boolean = false) : void
      {
         if(param1 == §_-1Lp§ || !§_-33V§)
         {
            return;
         }
         §_-1Lp§ = param1;
         §_-1Qb§ = true;
         if(param2 == null)
         {
            param2 = §_-1QM§.globalToLocal(new Point(§_-1QM§.stage.stageWidth / 2,§_-1QM§.stage.stageHeight / 2));
         }
         if(param3 == null)
         {
            param3 = param2;
         }
         if(param2 && param3)
         {
            §_-4Xo§(param3.x - param2.x * param1,param3.y - param2.y * param1);
         }
      }
      
      public function center() : void
      {
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(!§_-1xX§)
         {
            return;
         }
         var _loc6_:Array = §_-1xX§.getModel().getNumberArray("room_floor_center");
         if(_loc6_ && _loc6_.length == 3)
         {
            _loc8_ = §_-ya§.§_-49b§(new Vector3d(_loc6_[0],_loc6_[1],_loc6_[2]));
            if(§_-4Wr§)
            {
               _loc9_ = §_-ya§.§_-49b§(§_-4Wr§.getLocation());
               _loc3_ = _loc9_.x - _loc8_.x;
               _loc7_ = §_-1Gf§ / §_-1Lp§ - 64;
               if(_loc3_ > _loc7_)
               {
                  _loc3_ -= _loc7_;
               }
               else if(_loc3_ < -_loc7_)
               {
                  _loc3_ += _loc7_;
               }
               else
               {
                  _loc3_ = 0;
               }
               _loc4_ = _loc9_.y - _loc8_.y;
               _loc5_ = §_-1cn§ / §_-1Lp§ - 128;
               if(_loc4_ > _loc5_)
               {
                  _loc4_ -= _loc5_;
               }
               else if(_loc4_ < -_loc5_)
               {
                  _loc4_ += _loc5_;
               }
               else
               {
                  _loc4_ = 0;
               }
               _loc8_.offset(_loc3_,_loc4_);
            }
            _loc1_ = §_-1ac§ * (1 - §_-1Lp§) / 2 - _loc8_.x * §_-1Lp§;
            _loc2_ = §_-Gc§ * (1 - §_-1Lp§) / 2 - _loc8_.y * §_-1Lp§;
            §_-4Xo§(_loc1_,_loc2_);
         }
      }
      
      private function §_-0b1§() : void
      {
         if(!§_-4Wr§)
         {
            return;
         }
         var _loc1_:Point = §_-ya§.§_-49b§(§_-4Wr§.getLocation());
         var _loc2_:Number = §_-240§ + (§_-1Gf§ + _loc1_.x) * §_-1Lp§;
         var _loc3_:Number = §_-3US§ + (§_-1cn§ + _loc1_.y) * §_-1Lp§;
         if(_loc2_ < 0 || _loc2_ > §_-1ac§ || _loc3_ < 0 || _loc3_ > §_-Gc§)
         {
            center();
         }
      }
      
      gpu_debug function §_-05s§() : void
      {
         §_-4dH§.§_-4a4§(§_-4hI§,§_-0Wh§);
      }
      
      public function §_-2qv§(param1:§_-Ro§, param2:Boolean) : void
      {
         if(param2)
         {
            §_-263§(param1);
         }
         else
         {
            §_-2hf§(param1);
         }
      }
      
      public function §_-263§(param1:§_-Ro§) : void
      {
         var _loc2_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:§_-2-p§ = null;
         if(!param1)
         {
            return;
         }
         if(§_-3BW§.indexOf(param1.getId) == -1)
         {
            §_-3BW§.push(param1.getId());
         }
         var _loc3_:§_-4bR§ = param1.§_-Eq§() as §_-4bR§;
         if(!_loc3_)
         {
            return;
         }
         var _loc5_:int = _loc3_.§_-06r§;
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = _loc3_.§_-eh§(_loc7_);
            if(§_-2Zq§.§_-2YL§(_loc4_.image,_loc6_))
            {
               _loc2_ = true;
               _loc6_++;
            }
            _loc7_++;
         }
         if(_loc2_)
         {
            §_-2rh§ = true;
         }
      }
      
      public function §_-2hf§(param1:§_-Ro§) : void
      {
         var _loc6_:int = 0;
         var _loc3_:§_-2-p§ = null;
         var _loc4_:int = §_-3BW§.indexOf(param1.getId());
         if(_loc4_ != -1)
         {
            §_-3BW§.splice(_loc4_,1);
         }
         var _loc2_:§_-4bR§ = param1.§_-Eq§() as §_-4bR§;
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:int = _loc2_.§_-06r§;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc2_.§_-eh§(_loc6_);
            §_-2Zq§.§_-2re§(_loc3_.image);
            _loc6_++;
         }
      }
      
      public function §_-0uF§() : void
      {
         if(!§_-Pk§)
         {
            §_-Pk§ = new §_-Vg§(this);
            §_-0zB§.addChild(§_-Pk§);
         }
         else
         {
            §_-Pk§.visible = !§_-Pk§.visible;
         }
      }
      
      public function §_-Gf§(param1:Point) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:Texture = HitchTheme.getTexture("room-click-highlighter");
         var _loc3_:Image = new Image(_loc4_);
         §_-1QM§.addChild(_loc3_);
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.pivotX = _loc4_.width / 2;
         _loc3_.pivotY = _loc4_.height / 2;
         var _loc2_:Tween = new Tween(_loc3_,0.4,"easeOut");
         _loc2_.animate("scaleX",2);
         _loc2_.animate("scaleY",2);
         _loc2_.animate("alpha",0);
         _loc2_.onComplete = §_-Ie§;
         _loc2_.onCompleteArgs = [_loc3_];
         Starling.juggler.add(_loc2_);
      }
      
      public function §_-3E2§(param1:§_-Ro§) : void
      {
         §_-4Wr§ = param1;
      }
      
      public function onStageResize(param1:Event) : void
      {
         var _loc2_:Rectangle = Starling.current.viewPort;
         §_-1X4§(_loc2_.width,_loc2_.height);
         §_-zX§ = true;
         §_-1Ie§();
      }
      
      public function §_-rS§() : BitmapData
      {
         return null;
      }
      
      public function §_-4W§(param1:Boolean) : void
      {
         §_-33V§ = param1;
      }
   }
}

