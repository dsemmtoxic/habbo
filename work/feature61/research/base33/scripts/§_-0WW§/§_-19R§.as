package §_-0WW§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-0Dh§.§_-3yN§;
   import §_-0Dh§.§_-4Da§;
   import §_-0Dh§.§_-fG§;
   import §_-0Ee§.§_-0WM§;
   import §_-0Ee§.§_-4fX§;
   import §_-0XR§.§_-3z0§;
   import §_-1NF§.§_-4Ay§;
   import §_-1iL§.§_-va§;
   import §_-2G7§.§_-211§;
   import §_-2G7§.§_-2kz§;
   import §_-2gz§.§_-3f1§;
   import §_-2gz§.§_-4LN§;
   import §_-2gz§.§_-4T8§;
   import §_-2iy§.§_-Wc§;
   import §_-3g8§.§_-4Dx§;
   import §_-4CJ§.§_-1sl§;
   import §_-4CJ§.§_-2-p§;
   import §_-4CJ§.§_-30A§;
   import §_-4CJ§.§_-3fx§;
   import §_-4CJ§.§_-42b§;
   import §_-4RN§.PlaneVisualization;
   import §_-4RN§.§_-0cl§;
   import §_-4RN§.§_-1Tn§;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.Dictionary;
   import starling.utils.getNextPowerOfTwo;
   
   public class §_-19R§ extends §_-42b§ implements §_-30A§
   {
      
      private static const §_-2OV§:String = "111";
      
      private static const §_-121§:String = "201";
      
      private static const §_-1qE§:String = "1";
      
      public static const §_-3LI§:int = 16777215;
      
      public static const §_-3qU§:int = 14540253;
      
      public static const §_-167§:int = 12303291;
      
      private static const §_-J3§:int = 16777215;
      
      private static const §_-09h§:int = 13421772;
      
      private static const §_-0Hk§:int = 10066329;
      
      private static const §_-4SG§:int = 10066329;
      
      public static const §_-1y7§:int = 8967671;
      
      public static const §_-0R4§:int = 8637934;
      
      public static const §_-129§:int = 6798304;
      
      private static const §_-2R2§:Number = 1000;
      
      protected var §_-0SL§:§_-046§ = null;
      
      private var §_-49j§:§_-3yN§ = null;
      
      private var §_-1fh§:§_-4fX§ = null;
      
      private var §_-1vo§:Array = [];
      
      private var §_-0yU§:Boolean = false;
      
      private var §_-1P2§:Array = [];
      
      private var §_-0Uv§:Array = [];
      
      private var §_-fj§:Rectangle = null;
      
      private var §_-uN§:§_-0WM§ = null;
      
      private var §_-2nd§:String = null;
      
      private var §_-0Z3§:String = null;
      
      private var §_-mf§:String = null;
      
      private var §_-K3§:Number = NaN;
      
      private var §_-0PI§:Number = NaN;
      
      private var §_-32x§:Number = NaN;
      
      private var §_-0-N§:String = null;
      
      private var §_-34§:uint = 16777215;
      
      private var §_-2mE§:int = 255;
      
      private var §_-1jO§:int = 255;
      
      private var §_-0bp§:int = 255;
      
      private var §_-019§:Boolean = true;
      
      private var _assetUpdateCounter:int = 0;
      
      private var §_-42d§:int = -1;
      
      private var §_-1n8§:Number = 0;
      
      private var §_-0R§:Number = 0;
      
      private var §_-0LL§:Number = 0;
      
      private var §_-ST§:Number = 0;
      
      private var §_-2O1§:Array = [];
      
      private var §_-1Vl§:Dictionary;
      
      public function §_-19R§()
      {
         super();
         §_-49j§ = new §_-3yN§("room visualization");
         §_-1fh§ = new §_-4fX§();
         §_-uN§ = new §_-0WM§();
         §_-2O1§[0] = false;
         §_-00x§(true,true,true);
         §_-1Vl§ = new Dictionary();
      }
      
      private static function §_-4WM§(param1:§_-3f1§) : void
      {
         var _loc3_:§_-4T8§ = null;
         var _loc2_:§_-2kz§ = null;
         if(param1 is §_-4T8§)
         {
            _loc3_ = param1 as §_-4T8§;
            _loc2_ = _loc3_.texture as §_-2kz§;
            if(_loc2_)
            {
               _loc2_.bitmapData.dispose();
            }
            _loc3_.texture.dispose();
         }
         param1.dispose();
      }
      
      private static function §_-GP§(param1:BitmapData) : BitmapData
      {
         var _loc2_:int = getNextPowerOfTwo(param1.width);
         var _loc3_:int = getNextPowerOfTwo(param1.height);
         if(_loc2_ == param1.width && _loc3_ == param1.height)
         {
            return param1.clone();
         }
         var _loc4_:BitmapData = new BitmapData(_loc2_,_loc3_);
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(_loc2_ / param1.width,_loc3_ / param1.height);
         _loc4_.draw(param1,_loc5_);
         return _loc4_;
      }
      
      public function get §_-1Hm§() : Number
      {
         return 1000 + 0.1;
      }
      
      public function get §catch§() : Number
      {
         return 1000 + 0.5;
      }
      
      public function get §_-1AJ§() : Number
      {
         return 1000 + 0.49;
      }
      
      public function get §_-3uW§() : int
      {
         return §_-1vo§.length;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:§_-4Da§ = null;
         super.dispose();
         if(§_-49j§ != null)
         {
            _loc1_ = 0;
            while(_loc1_ < §_-49j§.§_-41q§)
            {
               _loc2_ = §_-49j§.§_-4eY§(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            §_-49j§.dispose();
            §_-49j§ = null;
         }
         §_-4Nw§();
         §_-1vo§ = null;
         §_-1P2§ = null;
         §_-0Uv§ = null;
         if(§_-1Vl§)
         {
            for(var _loc3_:Object in §_-1Vl§)
            {
               §_-4WM§(§_-1Vl§[_loc3_]);
               delete §_-1Vl§[_loc3_];
            }
         }
         §_-1Vl§ = null;
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
         if(§_-0SL§ != null)
         {
            §_-0SL§.clearCache();
            §_-0SL§ = null;
         }
      }
      
      private function §_-4Nw§() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:§_-y0§ = null;
         if(§_-1vo§ != null)
         {
            _loc2_ = int(§_-1vo§.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = §_-1vo§[_loc3_] as §_-y0§;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            §_-1vo§ = [];
         }
         §_-0yU§ = false;
         _assetUpdateCounter += 1;
         reset();
      }
      
      override protected function reset() : void
      {
         super.reset();
         §_-2nd§ = null;
         §_-0Z3§ = null;
         §_-mf§ = null;
         §_-0-N§ = null;
         §_-42d§ = -1;
         §_-ST§ = 0;
      }
      
      override public function get boundingRectangle() : Rectangle
      {
         if(§_-fj§ == null)
         {
            §_-fj§ = super.boundingRectangle;
         }
         return new Rectangle(§_-fj§.x,§_-fj§.y,§_-fj§.width,§_-fj§.height);
      }
      
      override public function initialize(param1:§_-1sl§) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is §_-046§))
         {
            return false;
         }
         §_-0SL§ = param1 as §_-046§;
         §_-0SL§.§_-0qU§(§_-12y§);
         return true;
      }
      
      protected function §_-1DO§() : void
      {
         var _loc3_:int = 0;
         var _loc1_:§_-y0§ = null;
         var _loc2_:§_-2-p§ = null;
         var _loc4_:int = int(§_-1vo§.length);
         §_-1ga§(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = §_-1vo§[_loc3_] as §_-y0§;
            _loc2_ = §_-eh§(_loc3_);
            if(_loc2_ != null && _loc1_ != null && _loc1_.§_-1Jd§ != null && _loc1_.§_-4Gh§ != null)
            {
               if(_loc1_.type == 1 && (_loc1_.§_-1Jd§.length < 1 || _loc1_.§_-4Gh§.length < 1))
               {
                  _loc2_.§_-F5§ = 256;
               }
               else
               {
                  _loc2_.§_-F5§ = 128;
               }
               if(_loc1_.type == 1)
               {
                  _loc2_.tag = "plane.wall@" + (_loc3_ + 1);
               }
               else if(_loc1_.type == 2)
               {
                  _loc2_.tag = "plane.floor@" + (_loc3_ + 1);
               }
               else
               {
                  _loc2_.tag = "plane@" + (_loc3_ + 1);
               }
               _loc2_.§_-2Rl§ = §_-4Dx§.§_-3Fv§;
            }
            _loc3_++;
         }
      }
      
      protected function §_-nN§() : Boolean
      {
         var _loc16_:int = 0;
         var _loc2_:§_-3gO§ = null;
         var _loc10_:§_-3gO§ = null;
         var _loc18_:§_-3gO§ = null;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc1_:§_-y0§ = null;
         var _loc14_:§_-3gO§ = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc17_:int = 0;
         var _loc15_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc6_:Number = NaN;
         if(§_-0yU§)
         {
            return false;
         }
         if(!isNaN(§_-K3§))
         {
            §_-1fh§.§_-2Hr§ = §_-K3§;
         }
         if(!isNaN(§_-0PI§))
         {
            §_-1fh§.§_-33a§ = §_-0PI§;
         }
         var _loc4_:String = §_-3Cd§.getModel().getString("room_plane_xml");
         var _loc5_:XML = new XML(_loc4_);
         var _loc12_:Boolean = §_-1fh§.§_-2lo§(_loc5_);
         System.disposeXML(_loc5_);
         _loc5_ = null;
         if(!_loc12_)
         {
            return false;
         }
         var _loc25_:Number = §_-Xt§();
         var _loc9_:Number = §_-4Qe§();
         var _loc24_:Number = 0;
         var _loc21_:int = §_-3Cd§.getModel().getNumber("room_random_seed");
         var _loc11_:int = §_-1fh§.§_-3uW§;
         _loc16_ = 0;
         while(_loc16_ < _loc11_)
         {
            _loc2_ = §_-1fh§.§_-1Ae§(_loc16_);
            _loc10_ = §_-1fh§.§_-0-F§(_loc16_);
            _loc18_ = §_-1fh§.§_-1wo§(_loc16_);
            _loc3_ = §_-1fh§.§_-4dT§(_loc16_);
            _loc7_ = §_-1fh§.§_-i§(_loc16_);
            _loc1_ = null;
            if(!(_loc2_ != null && _loc10_ != null && _loc18_ != null))
            {
               return false;
            }
            _loc14_ = Vector3d.crossProduct(_loc10_,_loc18_);
            _loc21_ = _loc21_ * 7613 + 517;
            _loc1_ = null;
            if(_loc7_ == 1)
            {
               _loc22_ = _loc2_.x + _loc10_.x + 0.5;
               _loc23_ = _loc2_.y + _loc18_.y + 0.5;
               _loc19_ = int(_loc22_) - _loc22_;
               _loc20_ = int(_loc23_) - _loc23_;
               _loc1_ = new §_-y0§(§_-3Cd§.getLocation(),_loc2_,_loc10_,_loc18_,2,true,_loc3_,_loc21_,-_loc19_,-_loc20_);
               if(_loc14_.z != 0)
               {
                  _loc1_.color = 16777215;
               }
               else
               {
                  _loc1_.color = _loc14_.x != 0 ? 12303291 : 14540253;
               }
               if(§_-0SL§ != null)
               {
                  _loc1_.rasterizer = §_-0SL§.§_-4DA§;
               }
            }
            else if(_loc7_ == 2)
            {
               _loc1_ = new §_-y0§(§_-3Cd§.getLocation(),_loc2_,_loc10_,_loc18_,1,true,_loc3_,_loc21_);
               if(_loc10_.length < 1 || _loc18_.length < 1)
               {
                  _loc1_.§_-oc§ = false;
               }
               if(_loc14_.x == 0 && _loc14_.y == 0)
               {
                  _loc1_.color = 10066329;
               }
               else if(_loc14_.y > 0)
               {
                  _loc1_.color = 16777215;
               }
               else if(_loc14_.y == 0)
               {
                  _loc1_.color = 13421772;
               }
               else
               {
                  _loc1_.color = 10066329;
               }
               if(§_-0SL§ != null)
               {
                  _loc1_.rasterizer = §_-0SL§.§_-4bK§;
               }
            }
            else if(_loc7_ == 3)
            {
               _loc1_ = new §_-y0§(§_-3Cd§.getLocation(),_loc2_,_loc10_,_loc18_,3,true,_loc3_,_loc21_,_loc24_,0,_loc25_,_loc9_);
               if(_loc14_.y > 0)
               {
                  _loc1_.color = 8967671;
               }
               else if(_loc14_.y == 0)
               {
                  _loc1_.color = 8637934;
               }
               else
               {
                  _loc1_.color = 6798304;
               }
               if(§_-0SL§ != null)
               {
                  _loc1_.rasterizer = §_-0SL§.§_-4fb§;
               }
               _loc24_ += _loc10_.length;
            }
            else if(_loc7_ == 4)
            {
               _loc1_ = new §_-y0§(§_-3Cd§.getLocation(),_loc2_,_loc10_,_loc18_,1,true,_loc3_,_loc21_);
               if(_loc10_.length < 1 || _loc18_.length < 1)
               {
                  _loc1_.§_-oc§ = false;
               }
               if(_loc14_.x == 0 && _loc14_.y == 0)
               {
                  _loc1_.color = 10066329;
               }
               else if(_loc14_.y > 0)
               {
                  _loc1_.color = 16777215;
               }
               else if(_loc14_.y == 0)
               {
                  _loc1_.color = 13421772;
               }
               else
               {
                  _loc1_.color = 10066329;
               }
               if(§_-0SL§ != null)
               {
                  _loc1_.rasterizer = §_-0SL§.§_-4Ii§;
               }
            }
            if(_loc1_ != null)
            {
               _loc1_.§_-0WV§ = §_-0SL§.§_-0WV§;
               _loc17_ = 0;
               while(_loc17_ < §_-1fh§.§_-2uY§(_loc16_))
               {
                  _loc15_ = §_-1fh§.§_-1Wb§(_loc16_,_loc17_);
                  _loc13_ = §_-1fh§.§_-2iD§(_loc16_,_loc17_);
                  _loc8_ = §_-1fh§.§_-Vn§(_loc16_,_loc17_);
                  _loc6_ = §_-1fh§.§_-0oe§(_loc16_,_loc17_);
                  _loc1_.§_-1BI§(_loc15_,_loc13_,_loc8_,_loc6_);
                  _loc17_++;
               }
               §_-1vo§.push(_loc1_);
            }
            _loc16_++;
         }
         §_-0yU§ = true;
         §_-1DO§();
         return true;
      }
      
      private function §_-Xt§() : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:§_-3gO§ = null;
         var _loc5_:Number = 0;
         var _loc2_:int = §_-1fh§.§_-3uW§;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = §_-1fh§.§_-i§(_loc3_);
            if(_loc4_ == 3)
            {
               _loc1_ = §_-1fh§.§_-0-F§(_loc3_);
               _loc5_ += _loc1_.length;
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      private function §_-4Qe§() : Number
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:§_-3gO§ = null;
         var _loc1_:Number = 0;
         var _loc2_:int = §_-1fh§.§_-3uW§;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = §_-1fh§.§_-i§(_loc3_);
            if(_loc5_ == 3)
            {
               _loc4_ = §_-1fh§.§_-1wo§(_loc3_);
               if(_loc4_.length > _loc1_)
               {
                  _loc1_ = _loc4_.length;
               }
            }
            _loc3_++;
         }
         if(_loc1_ > 5)
         {
            _loc1_ = 5;
         }
         return _loc1_;
      }
      
      override public function update(param1:§_-4hO§, param2:int, param3:Boolean, param4:Boolean, param5:Number, param6:Number) : Boolean
      {
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc18_:int = 0;
         var _loc16_:§_-2-p§ = null;
         var _loc7_:§_-y0§ = null;
         var _loc9_:* = 0;
         var _loc14_:* = 0;
         var _loc8_:* = 0;
         var _loc12_:* = 0;
         var _loc15_:* = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc11_:Boolean = §_-3yL§(param1);
         var _loc17_:§_-va§ = §_-3Cd§.getModel();
         var _loc19_:Boolean = false;
         if(§_-3ZW§(_loc17_))
         {
            _loc19_ = true;
         }
         if(§_-0fv§(_loc17_))
         {
            _loc19_ = true;
         }
         §_-nN§();
         if(§_-d§(_loc17_))
         {
            _loc19_ = true;
         }
         if(§_-3AG§(_loc17_))
         {
            _loc19_ = true;
         }
         if(!_loc11_ && !_loc19_)
         {
            return false;
         }
         if(§_-2pZ§(param1,_loc11_,param5,param2))
         {
            _loc19_ = true;
         }
         if(_loc19_)
         {
            _loc13_ = int(§_-1P2§.length);
            _loc10_ = 0;
            while(_loc10_ < _loc13_)
            {
               _loc18_ = int(§_-0Uv§[_loc10_]);
               _loc16_ = §_-eh§(_loc18_);
               _loc7_ = §_-1P2§[_loc10_] as §_-y0§;
               if(_loc16_ != null && _loc7_ != null && _loc7_.type != 3)
               {
                  if(§_-019§)
                  {
                     _loc9_ = _loc7_.color;
                     _loc14_ = uint((_loc9_ & 0xFF) * §_-0bp§ / 255);
                     _loc8_ = uint((_loc9_ >> 8 & 0xFF) * §_-1jO§ / 255);
                     _loc12_ = uint((_loc9_ >> 16 & 0xFF) * §_-2mE§ / 255);
                     _loc15_ = uint(_loc9_ >> 24);
                     _loc9_ = uint((_loc15_ << 24) + (_loc12_ << 16) + (_loc8_ << 8) + _loc14_);
                     _loc16_.color = _loc9_;
                  }
                  else
                  {
                     _loc16_.color = _loc7_.color;
                  }
               }
               _loc10_++;
            }
            §_-3TD§();
         }
         §_-12p§ = _loc17_.getUpdateID();
         return _loc19_;
      }
      
      private function §_-3yL§(param1:§_-4hO§) : Boolean
      {
         var _loc2_:§_-3gO§ = null;
         var _loc3_:Boolean = false;
         if(param1.§_-9l§ != §_-42d§)
         {
            §_-42d§ = param1.§_-9l§;
            §_-fj§ = null;
            _loc2_ = param1.direction;
            if(_loc2_ != null && (_loc2_.x != §_-1n8§ || _loc2_.y != §_-0R§ || _loc2_.z != §_-0LL§ || param1.scale != §_-ST§))
            {
               §_-1n8§ = _loc2_.x;
               §_-0R§ = _loc2_.y;
               §_-0LL§ = _loc2_.z;
               §_-ST§ = param1.scale;
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      private function §_-d§(param1:§_-va§) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(§_-12p§ != param1.getUpdateID())
         {
            _loc2_ = param1.getString("room_plane_mask_xml");
            if(_loc2_ != §_-0-N§)
            {
               §_-3uS§(_loc2_);
               §_-0-N§ = _loc2_;
               _loc5_ = true;
            }
            _loc3_ = uint(param1.getNumber("room_background_color"));
            if(_loc3_ != §_-34§)
            {
               §_-34§ = _loc3_;
               §_-0bp§ = §_-34§ & 0xFF;
               §_-1jO§ = §_-34§ >> 8 & 0xFF;
               §_-2mE§ = §_-34§ >> 16 & 0xFF;
               _loc5_ = true;
            }
            _loc4_ = param1.getNumber("room_colorize_bg_only") > 0;
            if(_loc4_ != §_-019§)
            {
               §_-019§ = _loc4_;
               _loc5_ = true;
            }
         }
         return _loc5_;
      }
      
      private function §_-3AG§(param1:§_-va§) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc4_:Boolean = false;
         if(§_-12p§ != param1.getUpdateID())
         {
            _loc5_ = param1.getString("room_wall_type");
            _loc6_ = param1.getString("room_floor_type");
            _loc2_ = param1.getString("room_landscape_type");
            §_-36y§(_loc6_,_loc5_,_loc2_);
            _loc3_ = param1.getNumber("room_floor_visibility") > 0;
            _loc7_ = param1.getNumber("room_wall_visibility") > 0;
            _loc4_ = param1.getNumber("room_landscape_visibility") > 0;
            §_-00x§(_loc3_,_loc7_,_loc4_);
            return true;
         }
         return false;
      }
      
      private function §_-3ZW§(param1:§_-va§) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(§_-12p§ != param1.getUpdateID())
         {
            _loc3_ = param1.getNumber("room_floor_thickness");
            _loc2_ = param1.getNumber("room_wall_thickness");
            if(!isNaN(_loc3_) && !isNaN(_loc2_) && (_loc3_ != §_-K3§ || _loc2_ != §_-0PI§))
            {
               §_-K3§ = _loc3_;
               §_-0PI§ = _loc2_;
               §_-4Nw§();
               return true;
            }
         }
         return false;
      }
      
      private function §_-0fv§(param1:§_-va§) : Boolean
      {
         var _loc2_:Number = NaN;
         if(§_-12p§ != param1.getUpdateID())
         {
            _loc2_ = param1.getNumber("room_floor_hole_update_time");
            if(!isNaN(_loc2_) && _loc2_ != §_-32x§)
            {
               §_-32x§ = _loc2_;
               §_-4Nw§();
               return true;
            }
         }
         return false;
      }
      
      protected function §_-36y§(param1:String, param2:String, param3:String) : Boolean
      {
         var _loc6_:int = 0;
         var _loc4_:§_-y0§ = null;
         param1 = §_-jN§(param1);
         param2 = §_-1XT§(param2);
         param3 = §_-3CD§(param3);
         if(param1 != §_-0Z3§)
         {
            §_-0Z3§ = param1;
         }
         else
         {
            param1 = null;
         }
         if(param2 != §_-2nd§)
         {
            §_-2nd§ = param2;
         }
         else
         {
            param2 = null;
         }
         if(param3 != §_-mf§)
         {
            §_-mf§ = param3;
         }
         else
         {
            param3 = null;
         }
         if(param1 == null && param2 == null && param3 == null)
         {
            return false;
         }
         var _loc5_:int = int(§_-1vo§.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = §_-1vo§[_loc6_] as §_-y0§;
            if(_loc4_ != null)
            {
               if(_loc4_.type == 2 && param1 != null)
               {
                  _loc4_.id = param1;
               }
               else if(_loc4_.type == 1 && param2 != null)
               {
                  _loc4_.id = param2;
               }
               else if(_loc4_.type == 3 && param3 != null)
               {
                  _loc4_.id = param3;
               }
            }
            _loc6_++;
         }
         return true;
      }
      
      private function §_-00x§(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param1 != §_-2O1§[2] || param2 != §_-2O1§[1] || param3 != §_-2O1§[3])
         {
            §_-2O1§[2] = param1;
            §_-2O1§[1] = param2;
            §_-2O1§[3] = param3;
            §_-1P2§ = [];
            §_-0Uv§ = [];
         }
      }
      
      protected function §_-2pZ§(param1:§_-4hO§, param2:Boolean, param3:Number, param4:int) : Boolean
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc13_:§_-2-p§ = null;
         var _loc5_:§_-y0§ = null;
         var _loc12_:Number = NaN;
         var _loc14_:String = null;
         if(param1 == null)
         {
            return false;
         }
         _assetUpdateCounter = _assetUpdateCounter + 1;
         if(param2)
         {
            §_-1P2§ = [];
            §_-0Uv§ = [];
         }
         var _loc6_:int = param4;
         var _loc7_:Array = §_-1P2§;
         if(§_-1P2§.length == 0)
         {
            _loc7_ = §_-1vo§;
         }
         var _loc15_:Boolean = false;
         var _loc8_:Boolean = §_-1P2§.length > 0;
         var _loc11_:int = int(_loc7_.length);
         _loc9_ = 0;
         while(_loc9_ < _loc11_)
         {
            _loc10_ = _loc9_;
            if(_loc8_)
            {
               _loc10_ = int(§_-0Uv§[_loc9_]);
            }
            _loc13_ = §_-eh§(_loc10_);
            if(_loc13_ != null)
            {
               _loc5_ = _loc7_[_loc9_] as §_-y0§;
               if(_loc5_ != null)
               {
                  _loc13_.§_-2-N§ = _loc5_.uniqueId;
                  if(_loc5_.update(param1,_loc6_))
                  {
                     if(_loc5_.visible)
                     {
                        _loc12_ = _loc5_.relativeDepth + §_-1Hm§ + _loc10_ / 1000;
                        if(_loc5_.type != 2)
                        {
                           _loc12_ = _loc5_.relativeDepth + §catch§ + _loc10_ / 1000;
                           if(_loc5_.§_-1Jd§.length < 1 || _loc5_.§_-4Gh§.length < 1)
                           {
                              _loc12_ += 1000 * 0.5;
                           }
                        }
                        _loc5_.§_-4g4§ = _loc12_;
                        _loc14_ = "plane " + _loc10_ + " " + param3;
                        §_-0DA§(_loc13_,_loc5_,_loc14_,_loc12_);
                     }
                     _loc15_ = true;
                  }
                  if(_loc13_.visible != (_loc5_.visible && §_-2O1§[_loc5_.type]))
                  {
                     _loc13_.visible = !_loc13_.visible;
                     _loc15_ = true;
                  }
                  if(_loc13_.visible)
                  {
                     if(!_loc8_)
                     {
                        §_-1P2§.push(_loc5_);
                        §_-0Uv§.push(_loc9_);
                     }
                  }
               }
               else
               {
                  _loc13_.§_-2-N§ = 0;
                  if(_loc13_.visible)
                  {
                     _loc13_.visible = false;
                     _loc15_ = true;
                  }
               }
            }
            _loc9_++;
         }
         return _loc15_;
      }
      
      private function §_-0DA§(param1:§_-2-p§, param2:§_-y0§, param3:String, param4:Number) : void
      {
         var _loc5_:Point = param2.offset;
         param1.offsetX = -_loc5_.x;
         param1.offsetY = -_loc5_.y;
         param1.relativeDepth = param4;
         param1.color = param2.color;
         if(param2.type == 2 || param2.type == 1)
         {
            if(param1.mesh)
            {
               param1.mesh.geometry.dispose();
               param1.mesh.dispose();
            }
            param1.mesh = §_-1ii§(param2,param1.color);
         }
      }
      
      private function §_-1ii§(param1:§_-y0§, param2:uint) : §_-3z0§
      {
         var _loc18_:§_-Wc§ = null;
         var _loc3_:§_-1Tn§ = null;
         var _loc7_:PlaneVisualization = null;
         var _loc16_:§_-0cl§ = null;
         var _loc5_:§_-4LN§ = null;
         var _loc12_:BitmapData = null;
         var _loc11_:BitmapData = null;
         var _loc20_:§_-4T8§ = null;
         var _loc13_:* = 0;
         var _loc8_:* = 0;
         var _loc4_:* = 0;
         var _loc9_:ColorTransform = null;
         var _loc6_:§_-211§ = null;
         var _loc17_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc10_:String = (param1.§_-oc§ ? param1.id : "plain" + param1.id) + "_" + param2 + "_" + param1.type;
         var _loc15_:§_-3f1§ = §_-1Vl§[_loc10_];
         if(!_loc15_)
         {
            _loc18_ = param1.rasterizer;
            _loc3_ = _loc18_.§_-4iy§(param1.id);
            _loc7_ = _loc3_.getPlaneVisualization(64);
            _loc16_ = _loc7_.§_-e§;
            if(!param1.§_-oc§)
            {
               _loc5_ = new §_-4LN§(param2);
               _loc5_.colorTransform = _loc16_.colorTransform;
               _loc15_ = _loc5_;
            }
            else
            {
               _loc12_ = _loc16_.material.§_-04W§();
               if(!_loc12_)
               {
                  Logger.log("Could not get room plane material for material id: " + _loc10_);
                  return null;
               }
               _loc11_ = §_-GP§(_loc12_);
               _loc20_ = new §_-4T8§(new §_-2kz§(_loc11_,false),false,true,false);
               _loc20_.colorTransform = _loc16_.colorTransform;
               _loc13_ = uint(param2 >> 16);
               _loc8_ = uint(param2 >> 8 & 0xFF);
               _loc4_ = uint(param2 & 0xFF);
               _loc9_ = new ColorTransform(_loc13_ / 255,_loc8_ / 255,_loc4_ / 255);
               _loc20_.colorTransform.concat(_loc9_);
               _loc15_ = _loc20_;
            }
            _loc15_.mipmap = false;
            §_-1Vl§[_loc10_] = _loc15_;
         }
         var _loc19_:§_-4Ay§ = new §_-382§(param1.location.§_-0C§(),param1.§_-1Jd§.§_-0C§(),param1.§_-4Gh§.§_-0C§());
         var _loc21_:§_-3z0§ = new §_-3z0§(_loc19_,_loc15_);
         if(_loc15_ is §_-4T8§)
         {
            _loc6_ = (_loc15_ as §_-4T8§).texture;
            _loc17_ = param1.§_-1Jd§.length * 32 / _loc6_.width;
            _loc14_ = param1.§_-4Gh§.length * 32 / _loc6_.height;
            _loc19_.scaleUV(_loc17_,_loc14_);
         }
         return _loc21_;
      }
      
      private function getPlaneBitmap(param1:§_-y0§, param2:String) : BitmapData
      {
         var _loc4_:§_-fG§ = §_-49j§.getAssetByName(param2) as §_-fG§;
         if(_loc4_ == null)
         {
            _loc4_ = new §_-fG§(§_-49j§.§_-9H§(§_-fG§));
            §_-49j§.setAsset(param2,_loc4_);
         }
         var _loc5_:BitmapData = _loc4_.content as BitmapData;
         var _loc3_:BitmapData = param1.§_-0B-§(_loc5_);
         if(_loc3_ == null)
         {
            _loc3_ = param1.bitmapData;
            if(_loc3_ != null)
            {
               if(_loc5_ != _loc3_)
               {
                  if(_loc5_ != null)
                  {
                     _loc5_.dispose();
                  }
                  _loc4_.§_-cL§(_loc3_);
               }
            }
         }
         return _loc3_;
      }
      
      protected function §_-3uS§(param1:String) : void
      {
         var _loc16_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:§_-3gO§ = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc19_:§_-3gO§ = null;
         var _loc8_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc15_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc18_:XML = XML(param1);
         §_-uN§.initialize(_loc18_);
         var _loc2_:§_-y0§ = null;
         var _loc14_:Array = [];
         var _loc17_:Array = [];
         var _loc6_:Boolean = false;
         _loc16_ = int(§_-1vo§.length);
         _loc10_ = 0;
         while(_loc10_ < _loc16_)
         {
            _loc2_ = §_-1vo§[_loc10_] as §_-y0§;
            if(_loc2_ != null)
            {
               _loc2_.§_-1l0§();
               if(_loc2_.type == 3)
               {
                  _loc14_.push(_loc10_);
               }
            }
            _loc10_++;
         }
         var _loc20_:int = §_-uN§.§_-23s§;
         _loc11_ = 0;
         while(_loc11_ < _loc20_)
         {
            _loc7_ = §_-uN§.§_-3Ou§(_loc11_);
            _loc9_ = §_-uN§.§_-2uz§(_loc11_);
            _loc12_ = §_-uN§.§_-1f8§(_loc11_);
            if(_loc9_ != null)
            {
               _loc16_ = int(§_-1vo§.length);
               _loc13_ = 0;
               while(_loc13_ < _loc16_)
               {
                  _loc2_ = §_-1vo§[_loc13_] as §_-y0§;
                  if(_loc2_.type == 1 || _loc2_.type == 3)
                  {
                     if(_loc2_ != null && _loc2_.location != null && _loc2_.normal != null)
                     {
                        _loc19_ = Vector3d.§_-1F1§(_loc9_,_loc2_.location);
                        _loc8_ = Math.abs(Vector3d.§_-0rb§(_loc19_,_loc2_.normal));
                        if(_loc8_ < 0.01)
                        {
                           if(_loc2_.§_-1Jd§ != null && _loc2_.§_-4Gh§ != null)
                           {
                              _loc5_ = Vector3d.§_-0rb§(_loc19_,_loc2_.§_-1Jd§);
                              _loc3_ = Vector3d.§_-0rb§(_loc19_,_loc2_.§_-4Gh§);
                              if(_loc2_.type == 1 || _loc2_.type == 3 && _loc12_ == "hole")
                              {
                                 _loc2_.§_-1FJ§(_loc7_,_loc5_,_loc3_);
                              }
                              else if(_loc2_.type == 3)
                              {
                                 if(!_loc2_.§_-15Z§)
                                 {
                                    _loc6_ = true;
                                 }
                                 _loc2_.§_-15Z§ = true;
                                 _loc17_.push(_loc13_);
                              }
                           }
                        }
                     }
                  }
                  _loc13_++;
               }
            }
            _loc11_++;
         }
         _loc16_ = int(_loc14_.length);
         _loc15_ = 0;
         while(_loc15_ < _loc16_)
         {
            _loc4_ = int(_loc14_[_loc15_]);
            if(_loc17_.indexOf(_loc4_) < 0)
            {
               _loc2_ = §_-1vo§[_loc4_] as §_-y0§;
               _loc2_.§_-15Z§ = false;
               _loc6_ = true;
            }
            _loc15_++;
         }
         if(_loc6_)
         {
            §_-1P2§ = [];
            §_-0Uv§ = [];
         }
      }
      
      private function §_-jN§(param1:String) : String
      {
         return §_-0SL§.§_-4DA§.§_-4iy§(param1) != null ? param1 : "111";
      }
      
      private function §_-1XT§(param1:String) : String
      {
         return §_-0SL§.§_-4bK§.§_-4iy§(param1) != null ? param1 : "201";
      }
      
      private function §_-3CD§(param1:String) : String
      {
         return §_-0SL§.§_-4fb§.§_-4iy§(param1) != null ? param1 : "1";
      }
      
      public function get §_-3DT§() : Vector.<§_-3fx§>
      {
         var _loc2_:Vector.<§_-3fx§> = new Vector.<§_-3fx§>(0);
         for each(var _loc1_:§_-y0§ in §_-1P2§)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
   }
}

