package §_-0WW§
{
   import §_-01r§.§_-1Zf§;
   import §_-01r§.§_-3YS§;
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-2iy§.§_-Wc§;
   import §_-309§.§_-YG§;
   import §_-3bt§.§_-2WC§;
   import §_-3qe§.§_-2i1§;
   import §_-3qe§.§_-mj§;
   import §_-44B§.Map;
   import §_-4CJ§.§_-3fx§;
   import §_-4RN§.§_-0cl§;
   import §_-4RN§.§_-17g§;
   import §_-4RN§.§_-1fD§;
   import §_-4RN§.§_-oB§;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class §_-y0§ implements §_-3fx§
   {
      
      public static const §_-Wj§:int = 0;
      
      public static const §_-06§:int = 1;
      
      public static const §_-0aC§:int = 2;
      
      public static const §_-49k§:int = 3;
      
      private static var §_-0TA§:int = 1;
      
      private static const §_-4VD§:Point = new Point(0,0);
      
      private var _disposed:Boolean = false;
      
      private var §_-13W§:int = 0;
      
      private var §_-41d§:Vector3d = null;
      
      private var §_-0sG§:Vector3d = null;
      
      private var §_-0dd§:Vector3d = null;
      
      private var §_-1T6§:Vector3d = null;
      
      private var §_-0Ku§:Vector3d = null;
      
      private var §_-2pD§:Array = [];
      
      private var §_-42d§:int = -1;
      
      private var _type:int = 0;
      
      private var §_-2y9§:Boolean = false;
      
      private var §_-E§:BitmapData = null;
      
      private var §_-3tZ§:Boolean = true;
      
      private var _offset:Point = null;
      
      private var §_-1Kv§:Number = 0;
      
      private var _color:uint = 0;
      
      private var §_-1tv§:§_-Wc§ = null;
      
      private var §_-43i§:§_-1Zf§ = null;
      
      private var §_-1tQ§:String = null;
      
      private var §_-0RW§:String = null;
      
      private var §_-2G4§:int = 0;
      
      private var §_-1FB§:Number = 0;
      
      private var §_-0jb§:Number = 0;
      
      private var §_-3Qm§:Number = 0;
      
      private var §_-1Tw§:Number = 0;
      
      private var §_-3JQ§:Map = null;
      
      private var §_-pH§:§_-2i1§ = null;
      
      private var §_-3G1§:Boolean = false;
      
      private var §_-4Mn§:Array = [];
      
      private var §_-42F§:Array = [];
      
      private var §_-2AJ§:Boolean = false;
      
      private var §_-0HZ§:BitmapData = null;
      
      private var §_-1mw§:BitmapData = null;
      
      private var §_-0hd§:Array = [];
      
      private var §_-0qr§:Array = [];
      
      private var §_-32§:Vector3d = null;
      
      private var §_-1qh§:Vector3d = null;
      
      private var §_-05J§:Vector3d = null;
      
      private var §_-4g1§:Vector3d = null;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var §_-1Si§:Number;
      
      private var §_-1YQ§:Boolean = true;
      
      public function §_-y0§(param1:§_-3gO§, param2:§_-3gO§, param3:§_-3gO§, param4:§_-3gO§, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         var _loc14_:int = 0;
         var _loc15_:§_-3gO§ = null;
         var _loc13_:Vector3d = null;
         super();
         §_-13W§ = param8;
         §_-41d§ = new Vector3d();
         §_-41d§.§_-4Dq§(param1);
         §_-0sG§ = new Vector3d();
         §_-0sG§.§_-4Dq§(param2);
         §_-0dd§ = new Vector3d();
         §_-0dd§.§_-4Dq§(param3);
         §_-1T6§ = new Vector3d();
         §_-1T6§.§_-4Dq§(param4);
         §_-0Ku§ = Vector3d.crossProduct(§_-0dd§,§_-1T6§);
         if(§_-0Ku§.length > 0)
         {
            §_-0Ku§.mul(1 / §_-0Ku§.length);
         }
         if(param7 != null)
         {
            _loc14_ = 0;
            while(_loc14_ < param7.length)
            {
               _loc15_ = param7[_loc14_] as §_-3gO§;
               if(_loc15_ != null)
               {
                  _loc13_ = new Vector3d();
                  _loc13_.§_-4Dq§(_loc15_);
                  §_-2pD§.push(_loc13_);
               }
               _loc14_++;
            }
         }
         _offset = new Point();
         _type = param5;
         §_-3JQ§ = new Map();
         §_-32§ = new Vector3d();
         §_-1qh§ = new Vector3d();
         §_-05J§ = new Vector3d();
         §_-4g1§ = new Vector3d();
         §_-1FB§ = param9;
         §_-0jb§ = param10;
         §_-3Qm§ = param11;
         §_-1Tw§ = param12;
         §_-3G1§ = param6;
         §_-2G4§ = §_-0TA§++;
      }
      
      private static function blend(param1:uint, param2:uint) : uint
      {
         return §_-YG§.§_-08g§(param2,param1 | 0xFF000000) & 0xFFFFFF;
      }
      
      public function get §_-4g4§() : Number
      {
         return §_-1Si§;
      }
      
      public function set §_-4g4§(param1:Number) : void
      {
         §_-1Si§ = param1;
      }
      
      public function set §_-15Z§(param1:Boolean) : void
      {
         if(param1 != §_-1YQ§)
         {
            if(!§_-1YQ§)
            {
               §_-3Ud§();
            }
            §_-1YQ§ = param1;
         }
      }
      
      public function get §_-15Z§() : Boolean
      {
         return §_-1YQ§;
      }
      
      public function get bitmapData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         if(visible)
         {
            if(§_-E§ != null)
            {
               try
               {
                  _loc1_ = §_-E§.clone();
               }
               catch(e:Error)
               {
                  return null;
               }
            }
         }
         return _loc1_;
      }
      
      public function get visible() : Boolean
      {
         return §_-2y9§ && §_-1YQ§;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get relativeDepth() : Number
      {
         return §_-1Kv§;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get §_-1Jd§() : §_-3gO§
      {
         return §_-0dd§;
      }
      
      public function get §_-4Gh§() : §_-3gO§
      {
         return §_-1T6§;
      }
      
      public function get location() : §_-3gO§
      {
         return §_-0sG§;
      }
      
      public function get normal() : §_-3gO§
      {
         return §_-0Ku§;
      }
      
      public function get §_-oc§() : Boolean
      {
         return §_-3tZ§;
      }
      
      public function set §_-oc§(param1:Boolean) : void
      {
         §_-3tZ§ = param1;
      }
      
      public function get rasterizer() : §_-Wc§
      {
         return §_-1tv§;
      }
      
      public function set rasterizer(param1:§_-Wc§) : void
      {
         §_-1tv§ = param1;
      }
      
      public function set §_-0WV§(param1:§_-1Zf§) : void
      {
         §_-43i§ = param1;
      }
      
      public function get id() : String
      {
         return §_-1tQ§;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 != §_-1tQ§)
         {
            §_-3Ud§();
            §_-1tQ§ = param1;
         }
      }
      
      public function get uniqueId() : int
      {
         return §_-2G4§;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:§_-2i1§ = null;
         if(§_-E§ != null)
         {
            §_-E§.dispose();
            §_-E§ = null;
         }
         if(§_-3JQ§ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < §_-3JQ§.length)
            {
               _loc1_ = §_-3JQ§.§_-2DR§(_loc2_) as §_-2i1§;
               if(_loc1_ != null)
               {
                  if(_loc1_.bitmap != null)
                  {
                     _loc1_.bitmap.dispose();
                  }
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            §_-3JQ§.dispose();
            §_-3JQ§ = null;
         }
         §_-pH§ = null;
         §_-0sG§ = null;
         §_-41d§ = null;
         §_-0dd§ = null;
         §_-1T6§ = null;
         §_-0Ku§ = null;
         §_-1tv§ = null;
         §_-32§ = null;
         §_-1qh§ = null;
         §_-05J§ = null;
         §_-4g1§ = null;
         §_-4Mn§ = null;
         §_-42F§ = null;
         if(§_-0HZ§ != null)
         {
            §_-0HZ§.dispose();
            §_-0HZ§ = null;
         }
         if(§_-1mw§ != null)
         {
            §_-1mw§.dispose();
            §_-1mw§ = null;
         }
         _disposed = true;
      }
      
      public function §_-0B-§(param1:BitmapData) : BitmapData
      {
         if(visible)
         {
            if(§_-E§ != null && param1 != null)
            {
               if(§_-E§.width == param1.width && §_-E§.height == param1.height)
               {
                  param1.copyPixels(§_-E§,§_-E§.rect,§_-4VD§);
                  return param1;
               }
            }
         }
         return null;
      }
      
      private function §_-2wV§(param1:String, param2:§_-2i1§) : Boolean
      {
         var _loc3_:§_-2i1§ = §_-3JQ§.remove(param1) as §_-2i1§;
         if(_loc3_ != null)
         {
            if(param2 != null && param2.bitmap != _loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.dispose();
         }
         §_-pH§ = param2;
         §_-3JQ§.add(param1,param2);
         return true;
      }
      
      private function §_-3Ud§(param1:BitmapData = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:§_-2i1§ = null;
         if(§_-3JQ§ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < §_-3JQ§.length)
            {
               _loc2_ = §_-3JQ§.§_-2DR§(_loc3_) as §_-2i1§;
               if(_loc2_ != null)
               {
                  if(_loc2_.bitmap != null && _loc2_.bitmap != param1)
                  {
                     _loc2_.bitmap.dispose();
                  }
                  _loc2_.dispose();
               }
               _loc3_++;
            }
            §_-3JQ§.reset();
         }
         §_-pH§ = null;
      }
      
      private function getTextureIdentifier(param1:Number) : String
      {
         if(§_-1tv§ != null)
         {
            return §_-1tv§.getTextureIdentifier(param1,normal);
         }
         return String(param1);
      }
      
      private function needsNewTexture(param1:§_-4hO§, param2:int) : Boolean
      {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:§_-2i1§ = §_-pH§;
         if(_loc4_ == null)
         {
            _loc3_ = getTextureIdentifier(param1.scale);
            _loc4_ = §_-3JQ§.getValue(_loc3_) as §_-2i1§;
         }
         §_-i3§();
         if(§_-1YQ§ && (_loc4_ == null || _loc4_.timeStamp >= 0 && param2 > _loc4_.timeStamp || §_-2AJ§))
         {
            return true;
         }
         return false;
      }
      
      private function getTexture(param1:§_-4hO§, param2:int) : BitmapData
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc4_:§_-3gO§ = null;
         var _loc6_:BitmapData = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc7_:§_-2i1§ = null;
         var _loc3_:String = null;
         if(needsNewTexture(param1,param2))
         {
            _loc8_ = §_-0dd§.length * param1.scale;
            _loc9_ = §_-1T6§.length * param1.scale;
            _loc4_ = param1.§_-1ke§(§_-0Ku§);
            _loc3_ = getTextureIdentifier(param1.scale);
            if(§_-pH§ != null)
            {
               _loc7_ = §_-pH§;
            }
            else
            {
               _loc7_ = §_-3JQ§.getValue(_loc3_) as §_-2i1§;
            }
            _loc6_ = null;
            if(_loc7_ != null)
            {
               _loc6_ = _loc7_.bitmap;
            }
            if(§_-1tv§ != null)
            {
               _loc7_ = §_-1tv§.render(_loc6_,§_-1tQ§,_loc8_,_loc9_,param1.scale,_loc4_,§_-3tZ§,§_-1FB§,§_-0jb§,§_-3Qm§,§_-1Tw§,param2);
               if(_loc7_ != null)
               {
                  if(_loc6_ != null && _loc7_.bitmap != _loc6_)
                  {
                     _loc6_.dispose();
                  }
               }
            }
            else
            {
               _loc5_ = new BitmapData(_loc8_,_loc9_,true,0xFF000000 | _color);
               _loc7_ = new §_-2i1§(_loc5_,-1);
            }
            if(_loc7_ != null)
            {
               §_-5r§(_loc7_.bitmap,param1);
               §_-2wV§(_loc3_,_loc7_);
            }
         }
         else if(§_-pH§ != null)
         {
            _loc7_ = §_-pH§;
         }
         else
         {
            _loc3_ = getTextureIdentifier(param1.scale);
            _loc7_ = §_-3JQ§.getValue(_loc3_) as §_-2i1§;
         }
         if(_loc7_ != null)
         {
            §_-pH§ = _loc7_;
            return _loc7_.bitmap;
         }
         return null;
      }
      
      private function §_-0WO§(param1:§_-4hO§) : §_-Hq§
      {
         var _loc6_:int = 0;
         var _loc12_:§_-3YS§ = null;
         var _loc10_:String = null;
         var _loc2_:§_-3gO§ = null;
         var _loc13_:§_-2WC§ = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:Point = null;
         if(!§_-3G1§)
         {
            return null;
         }
         var _loc5_:§_-qx§ = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:§_-Hq§ = new §_-Hq§();
         _loc6_ = 0;
         while(_loc6_ < §_-4Mn§.length)
         {
            _loc5_ = §_-4Mn§[_loc6_] as §_-qx§;
            if(_loc5_ != null)
            {
               _loc12_ = §_-43i§.§_-2Ey§(_loc5_.type);
               if(_loc12_ != null)
               {
                  _loc10_ = _loc12_.§_-12r§(param1.scale);
                  if(_loc10_ != null)
                  {
                     _loc2_ = param1.§_-1ke§(§_-0Ku§);
                     _loc13_ = _loc12_.§_-1Xd§(param1.scale,_loc2_);
                     if(_loc13_ != null)
                     {
                        if(§_-0HZ§)
                        {
                           _loc7_ = §_-0HZ§.width;
                           _loc3_ = §_-0HZ§.height;
                        }
                        else
                        {
                           _loc7_ = §_-0dd§.length * param1.scale / 2;
                           _loc3_ = §_-1T6§.length * param1.scale / 2;
                        }
                        _loc8_ = _loc7_ * (1 - _loc5_.§_-1W4§ / §_-0dd§.length);
                        _loc9_ = _loc3_ * (1 - _loc5_.§_-4lf§ / §_-1T6§.length);
                        _loc11_ = new Point(_loc8_ + _loc13_.offsetX,_loc9_ + _loc13_.offsetY);
                        _loc4_.addMask(_loc10_,_loc11_,_loc13_.flipH,_loc13_.flipV);
                     }
                  }
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      private function §_-14F§(param1:§_-4hO§) : int
      {
         var _loc2_:Point = param1.§_-49b§(new Vector3d(0,0,0));
         var _loc3_:Point = param1.§_-49b§(new Vector3d(0,1,0));
         return Math.round(§_-0dd§.length * Math.abs(_loc2_.x - _loc3_.x));
      }
      
      public function §_-44n§(param1:§_-4hO§) : Array
      {
         var _loc4_:§_-Hq§ = null;
         var _loc5_:§_-Hq§ = null;
         var _loc11_:Array = null;
         var _loc10_:§_-0cl§ = null;
         var _loc7_:int = 0;
         var _loc2_:§_-3gO§ = null;
         var _loc8_:§_-oB§ = null;
         var _loc3_:Array = null;
         var _loc12_:String = null;
         var _loc13_:Array = [];
         if(§_-2y9§)
         {
            _loc5_ = null;
            try
            {
               _loc5_ = §_-0WO§(param1);
               _loc11_ = §_-1tv§.§_-2ka§(§_-1tQ§);
               _loc7_ = 0;
               while(_loc7_ < _loc11_.length)
               {
                  _loc10_ = _loc11_[_loc7_] as §_-0cl§;
                  if(_loc10_ != null)
                  {
                     if(§_-3tZ§ && _loc10_.§_-2u-§() != null)
                     {
                        _loc2_ = param1.§_-1ke§(§_-0Ku§);
                        _loc8_ = _loc10_.§_-2u-§().§_-334§(_loc2_);
                        _loc4_ = new §_-Hq§(_loc5_,blend(_color,_loc10_.getColor()),_loc8_.§_-2nh§());
                        _loc4_.z = §_-4g4§;
                        §_-mj§.§_-Bn§(§_-13W§);
                        for each(var _loc6_:§_-1fD§ in _loc8_.§_-37§(§_-14F§(param1)))
                        {
                           _loc3_ = [];
                           for each(var _loc9_:§_-17g§ in _loc6_.§_-0NG§())
                           {
                              _loc12_ = _loc9_.§_-12r§(_loc2_);
                              if(_loc12_ != null)
                              {
                                 _loc3_.push(_loc12_);
                              }
                           }
                           if(_loc3_.length > 0)
                           {
                              if(!_loc6_.§_-04l§())
                              {
                                 _loc3_.push("");
                              }
                              _loc4_.§_-426§(_loc3_);
                           }
                        }
                        if(_loc4_.§_-Jl§.length > 0)
                        {
                           _loc13_.push(_loc4_);
                        }
                     }
                     else
                     {
                        _loc4_ = new §_-Hq§(_loc5_,blend(_color,_loc10_.getColor()));
                        _loc4_.z = §_-4g4§;
                        _loc13_.push(_loc4_);
                     }
                  }
                  _loc7_++;
               }
            }
            catch(e:Error)
            {
               Logger.log("Error in getting RoomPlane drawing data.",e);
            }
            if(_loc13_.length == 0)
            {
               _loc4_ = new §_-Hq§(_loc5_,_color);
               _loc4_.z = §_-4g4§;
               _loc13_.push(_loc4_);
            }
         }
         return _loc13_;
      }
      
      private function §_-0Lo§(param1:§_-2i1§) : void
      {
      }
      
      public function update(param1:§_-4hO§, param2:int) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc9_:int = 0;
         var _loc4_:§_-3gO§ = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         if(param1 == null || _disposed)
         {
            return false;
         }
         var _loc10_:Boolean = false;
         if(§_-42d§ != param1.§_-9l§)
         {
            _loc10_ = true;
         }
         if(!_loc10_ || !§_-1YQ§)
         {
            if(!visible)
            {
               return false;
            }
         }
         if(_loc10_)
         {
            §_-pH§ = null;
            _loc3_ = 0;
            _loc3_ = Vector3d.§_-3E-§(param1.§_-kX§,normal);
            if(_loc3_ > -0.001)
            {
               if(§_-2y9§)
               {
                  §_-2y9§ = false;
                  return true;
               }
               return false;
            }
            _loc9_ = 0;
            while(_loc9_ < §_-2pD§.length)
            {
               _loc3_ = Vector3d.§_-3E-§(param1.§_-kX§,§_-2pD§[_loc9_]);
               if(_loc3_ > -0.001)
               {
                  if(§_-2y9§)
                  {
                     §_-2y9§ = false;
                     return true;
                  }
                  return false;
               }
               _loc9_++;
            }
            §_-4at§(param1);
            _loc4_ = param1.§_-3qs§(§_-41d§);
            _loc5_ = _loc4_.z;
            _loc6_ = Math.max(§_-32§.z,§_-1qh§.z,§_-05J§.z,§_-4g1§.z) - _loc5_;
            if(_type == 2)
            {
               _loc6_ -= (§_-0sG§.z + Math.min(0,§_-0dd§.z,§_-1T6§.z)) * 8;
            }
            if(_type == 3)
            {
               _loc6_ += 0.02;
            }
            §_-1Kv§ = _loc6_;
            §_-2y9§ = true;
            §_-42d§ = param1.§_-9l§;
         }
         _loc7_ = §_-0RW§ != §_-1tQ§;
         §_-0RW§ = §_-1tQ§;
         return _loc10_ || _loc7_;
      }
      
      private function §_-4at§(param1:§_-4hO§) : void
      {
         §_-32§.§_-4Dq§(param1.§_-3qs§(§_-0sG§));
         §_-1qh§.§_-4Dq§(param1.§_-3qs§(Vector3d.sum(§_-0sG§,§_-1T6§)));
         §_-05J§.§_-4Dq§(param1.§_-3qs§(Vector3d.sum(Vector3d.sum(§_-0sG§,§_-0dd§),§_-1T6§)));
         §_-4g1§.§_-4Dq§(param1.§_-3qs§(Vector3d.sum(§_-0sG§,§_-0dd§)));
         _offset = param1.§_-49b§(§_-41d§);
         §_-32§.x = Math.round(§_-32§.x);
         §_-32§.y = Math.round(§_-32§.y);
         §_-1qh§.x = Math.round(§_-1qh§.x);
         §_-1qh§.y = Math.round(§_-1qh§.y);
         §_-05J§.x = Math.round(§_-05J§.x);
         §_-05J§.y = Math.round(§_-05J§.y);
         §_-4g1§.x = Math.round(§_-4g1§.x);
         §_-4g1§.y = Math.round(§_-4g1§.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc3_:Number = Math.min(§_-32§.x,§_-1qh§.x,§_-05J§.x,§_-4g1§.x);
         var _loc5_:Number = Math.max(§_-32§.x,§_-1qh§.x,§_-05J§.x,§_-4g1§.x);
         var _loc2_:Number = Math.min(§_-32§.y,§_-1qh§.y,§_-05J§.y,§_-4g1§.y);
         var _loc4_:Number = Math.max(§_-32§.y,§_-1qh§.y,§_-05J§.y,§_-4g1§.y);
         _loc5_ -= _loc3_;
         _offset.x -= _loc3_;
         §_-32§.x -= _loc3_;
         §_-1qh§.x -= _loc3_;
         §_-05J§.x -= _loc3_;
         §_-4g1§.x -= _loc3_;
         _loc4_ -= _loc2_;
         _offset.y -= _loc2_;
         §_-32§.y -= _loc2_;
         §_-1qh§.y -= _loc2_;
         §_-05J§.y -= _loc2_;
         §_-4g1§.y -= _loc2_;
         _width = _loc5_;
         _height = _loc4_;
      }
      
      private function §_-1NV§(param1:§_-4hO§, param2:BitmapData) : void
      {
         if(§_-32§ == null || §_-1qh§ == null || §_-05J§ == null || §_-4g1§ == null || param2 == null || §_-E§ == null)
         {
            return;
         }
         var _loc8_:Number = §_-4g1§.x - §_-05J§.x;
         var _loc10_:Number = §_-4g1§.y - §_-05J§.y;
         var _loc4_:Number = §_-1qh§.x - §_-05J§.x;
         var _loc3_:Number = §_-1qh§.y - §_-05J§.y;
         if(_type == 1 || _type == 3)
         {
            if(Math.abs(_loc4_ - param2.width) <= 1)
            {
               _loc4_ = param2.width;
            }
            if(Math.abs(_loc3_ - param2.width) <= 1)
            {
               _loc3_ = param2.width;
            }
            if(Math.abs(_loc8_ - param2.height) <= 1)
            {
               _loc8_ = param2.height;
            }
            if(Math.abs(_loc10_ - param2.height) <= 1)
            {
               _loc10_ = param2.height;
            }
         }
         var _loc5_:Number = _loc4_ / param2.width;
         var _loc6_:Number = _loc3_ / param2.width;
         var _loc7_:Number = _loc8_ / param2.height;
         var _loc9_:Number = _loc10_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc5_;
         _loc11_.b = _loc6_;
         _loc11_.c = _loc7_;
         _loc11_.d = _loc9_;
         _loc11_.translate(§_-05J§.x,§_-05J§.y);
         draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(§_-E§ != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (_type == 1 || _type == 3))
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  param2.ty++;
               }
               _loc5_ = 0;
               while(_loc4_ < param1.width)
               {
                  _loc4_++;
                  _loc3_ += Math.abs(param2.b);
                  if(_loc3_ >= 1)
                  {
                     §_-E§.copyPixels(param1,new Rectangle(_loc7_ + _loc6_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
                     _loc7_ = _loc4_;
                     if(param2.b > 0)
                     {
                        _loc5_++;
                     }
                     else
                     {
                        _loc5_--;
                     }
                     _loc3_ = 0;
                  }
               }
               if(_loc3_ > 0)
               {
                  §_-E§.copyPixels(param1,new Rectangle(_loc7_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
               }
               return;
            }
            §_-E§.draw(param1,param2,null,null,null,false);
         }
      }
      
      public function §_-1l0§() : void
      {
         if(_disposed)
         {
            return;
         }
         if(§_-3G1§)
         {
            if(§_-4Mn§.length == 0)
            {
               return;
            }
            §_-2AJ§ = true;
            §_-4Mn§ = [];
         }
      }
      
      public function §_-1FJ§(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:§_-qx§ = null;
         var _loc4_:int = 0;
         if(§_-3G1§)
         {
            _loc5_ = null;
            _loc4_ = 0;
            while(_loc4_ < §_-4Mn§.length)
            {
               _loc5_ = §_-4Mn§[_loc4_] as §_-qx§;
               if(_loc5_ != null)
               {
                  if(_loc5_.type == param1 && _loc5_.§_-1W4§ == param2 && _loc5_.§_-4lf§ == param3)
                  {
                     return false;
                  }
               }
               _loc4_++;
            }
            _loc5_ = new §_-qx§(param1,param2,param3);
            §_-4Mn§.push(_loc5_);
            §_-2AJ§ = true;
            return true;
         }
         return false;
      }
      
      public function §_-35w§() : void
      {
         if(§_-3G1§)
         {
            if(§_-42F§.length == 0)
            {
               return;
            }
            §_-2AJ§ = true;
            §_-42F§ = [];
         }
      }
      
      public function §_-1BI§(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc6_:§_-1p3§ = null;
         var _loc5_:int = 0;
         if(§_-3G1§)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < §_-42F§.length)
            {
               _loc6_ = §_-42F§[_loc5_] as §_-1p3§;
               if(_loc6_ != null)
               {
                  if(_loc6_.§_-1W4§ == param1 && _loc6_.§_-4lf§ == param2 && _loc6_.§_-0RO§ == param3 && _loc6_.§_-V-§ == param4)
                  {
                     return false;
                  }
               }
               _loc5_++;
            }
            _loc6_ = new §_-1p3§(param1,param2,param3,param4);
            §_-42F§.push(_loc6_);
            §_-2AJ§ = true;
            return true;
         }
         return false;
      }
      
      private function §_-i3§() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:§_-qx§ = null;
         if(!§_-2AJ§)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         var _loc7_:§_-qx§ = null;
         var _loc1_:§_-1p3§ = null;
         if(§_-4Mn§.length == §_-0hd§.length)
         {
            _loc4_;
            while(_loc4_ < §_-4Mn§.length)
            {
               _loc7_ = §_-4Mn§[_loc4_] as §_-qx§;
               if(_loc7_ != null)
               {
                  _loc2_ = false;
                  _loc6_;
                  while(_loc6_ < §_-0hd§.length)
                  {
                     _loc3_ = §_-0hd§[_loc6_] as §_-qx§;
                     if(_loc3_ != null)
                     {
                        if(_loc3_.type == _loc7_.type && _loc3_.§_-1W4§ == _loc7_.§_-1W4§ && _loc3_.§_-4lf§ == _loc7_.§_-4lf§)
                        {
                           _loc2_ = true;
                           break;
                        }
                     }
                     _loc6_++;
                  }
                  if(!_loc2_)
                  {
                     _loc5_ = false;
                     break;
                  }
               }
               _loc4_++;
            }
         }
         else
         {
            _loc5_ = false;
         }
         if(§_-42F§.length > §_-0qr§.length)
         {
            _loc5_ = false;
         }
         if(_loc5_)
         {
            §_-2AJ§ = false;
         }
      }
      
      private function §_-5r§(param1:BitmapData, param2:§_-4hO§) : void
      {
         var _loc3_:§_-3gO§ = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         if(!§_-3G1§ || §_-4Mn§.length == 0 && §_-42F§.length == 0 && !§_-2AJ§ || §_-43i§ == null)
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc13_:§_-qx§ = null;
         var _loc4_:§_-1p3§ = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         §_-i3§();
         var _loc12_:Number = param1.width;
         var _loc14_:Number = param1.height;
         if(§_-0HZ§ == null || §_-0HZ§.width != _loc12_ || §_-0HZ§.height != _loc14_)
         {
            if(§_-0HZ§ != null)
            {
               §_-0HZ§.dispose();
               §_-0HZ§ = null;
            }
            try
            {
               §_-0HZ§ = new BitmapData(_loc12_,_loc14_,true,16777215);
            }
            catch(e:Error)
            {
               §_-0HZ§ = null;
               return;
            }
            §_-2AJ§ = true;
         }
         if(§_-2AJ§)
         {
            §_-0hd§ = [];
            §_-0qr§ = [];
            if(§_-0HZ§ != null)
            {
               §_-0HZ§.fillRect(§_-0HZ§.rect,16777215);
            }
            §_-3Ud§(param1);
            _loc3_ = param2.§_-1ke§(§_-0Ku§);
            _loc10_ = 0;
            _loc11_ = 0;
            _loc5_ = 0;
            while(_loc5_ < §_-4Mn§.length)
            {
               _loc13_ = §_-4Mn§[_loc5_] as §_-qx§;
               if(_loc13_ != null)
               {
                  _loc10_ = §_-0HZ§.width - §_-0HZ§.width * _loc13_.§_-1W4§ / §_-0dd§.length;
                  _loc11_ = §_-0HZ§.height - §_-0HZ§.height * _loc13_.§_-4lf§ / §_-1T6§.length;
                  _loc7_ = _loc13_.type;
                  §_-43i§.§_-5r§(§_-0HZ§,_loc7_,param2.scale,_loc3_,_loc10_,_loc11_);
                  §_-0hd§.push(new §_-qx§(_loc7_,_loc13_.§_-1W4§,_loc13_.§_-4lf§));
               }
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < §_-42F§.length)
            {
               _loc4_ = §_-42F§[_loc6_] as §_-1p3§;
               if(_loc4_ != null)
               {
                  _loc10_ = §_-0HZ§.width - §_-0HZ§.width * _loc4_.§_-1W4§ / §_-0dd§.length;
                  _loc11_ = §_-0HZ§.height - §_-0HZ§.height * _loc4_.§_-4lf§ / §_-1T6§.length;
                  _loc9_ = §_-0HZ§.width * _loc4_.§_-0RO§ / §_-0dd§.length;
                  _loc8_ = §_-0HZ§.height * _loc4_.§_-V-§ / §_-1T6§.length;
                  §_-0HZ§.fillRect(new Rectangle(_loc10_ - _loc9_,_loc11_ - _loc8_,_loc9_,_loc8_),4278190080);
                  §_-0qr§.push(new §_-1p3§(_loc4_.§_-0RO§,_loc4_.§_-4lf§,_loc4_.§_-0RO§,_loc4_.§_-V-§));
               }
               _loc6_++;
            }
            §_-2AJ§ = false;
         }
         §_-2Qd§(param1,§_-0HZ§);
      }
      
      private function §_-2Qd§(param1:BitmapData, param2:BitmapData) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(§_-1mw§ != null && (§_-1mw§.width != param1.width || §_-1mw§.height != param1.height))
         {
            §_-1mw§.dispose();
            §_-1mw§ = null;
         }
         if(§_-1mw§ == null)
         {
            try
            {
               §_-1mw§ = new BitmapData(param1.width,param1.height,true,4294967295);
            }
            catch(e:Error)
            {
               if(§_-1mw§)
               {
                  §_-1mw§.dispose();
               }
               §_-1mw§ = null;
               return;
            }
         }
         §_-1mw§.copyChannel(param1,param1.rect,§_-4VD§,8,1);
         §_-1mw§.draw(param2,null,null,"darken");
         param1.copyChannel(§_-1mw§,§_-1mw§.rect,§_-4VD§,1,8);
      }
   }
}

