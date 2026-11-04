package §_-0Ee§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-Xq§;
   import §_-44B§.Map;
   import flash.geom.Point;
   import loginpatch.HabboTicketLogin;
   
   public class §_-4fX§
   {
      
      private static const §_-2wp§:Number = 0.25;
      
      private static const §_-0oJ§:Number = 0.25;
      
      private static const §_-01X§:Number = 20;
      
      public static const §_-00E§:int = -110;
      
      public static const §_-1nx§:int = -100;
      
      private var §for §:Array = [];
      
      private var §_-0j4§:Array = [];
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var §_-2Yi§:int = 0;
      
      private var §_-2GI§:int = 0;
      
      private var §_-cy§:int = 0;
      
      private var §_-1M9§:int = 0;
      
      private var §_-1vo§:Vector.<§_-3Yc§>;
      
      private var §_-2-2§:Number = 0;
      
      private var §_-0PI§:Number = 1;
      
      private var §_-K3§:Number = 1;
      
      private var §_-4md§:int = -1;
      
      private var §_-2sX§:Number = 0;
      
      private var §_-3ON§:Map = null;
      
      private var §_-04K§:Array = [];
      
      public function §_-4fX§()
      {
         super();
         §_-2-2§ = 3.6;
         §_-0PI§ = 1;
         §_-K3§ = 1;
         §_-3ON§ = new Map();
         §_-1vo§ = new Vector.<§_-3Yc§>();
      }
      
      private static function §_-1my§(param1:Array) : Number
      {
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = null;
         var _loc9_:int = int(param1.length);
         var _loc4_:int = 0;
         if(_loc9_ == 0)
         {
            return 0;
         }
         var _loc8_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc3_ = param1[_loc6_] as Array;
            _loc2_ = int(_loc3_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc7_ = Number(_loc3_[_loc5_]);
               if(_loc7_ > _loc8_)
               {
                  _loc8_ = _loc7_;
               }
               _loc5_++;
            }
            _loc6_++;
         }
         return _loc8_;
      }
      
      private static function §_-3Vo§(param1:Array) : Point
      {
         return null;
      }
      
      private static function §_-0mM§(param1:Vector.<Vector.<int>>) : Vector.<Vector.<int>>
      {
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc17_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:int = 0;
         var _loc15_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:uint = uint(param1.length);
         var _loc16_:uint = uint(param1[0].length);
         var _loc7_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(_loc5_ * 4);
         _loc13_ = 0;
         while(_loc13_ < _loc5_ * 4)
         {
            _loc7_[_loc13_] = new Vector.<int>(_loc16_ * 4);
            _loc13_++;
         }
         var _loc8_:int = 0;
         _loc13_ = 0;
         while(_loc13_ < _loc5_)
         {
            _loc6_ = 0;
            _loc12_ = 0;
            while(_loc12_ < _loc16_)
            {
               _loc11_ = param1[_loc13_][_loc12_];
               if(_loc11_ < 0 || _loc11_ <= 255)
               {
                  _loc4_ = 0;
                  while(_loc4_ < 4)
                  {
                     _loc3_ = 0;
                     while(_loc3_ < 4)
                     {
                        _loc7_[_loc8_ + _loc4_][_loc6_ + _loc3_] = _loc11_ < 0 ? _loc11_ : _loc11_ * 4;
                        _loc3_++;
                     }
                     _loc4_++;
                  }
               }
               else
               {
                  _loc17_ = (_loc11_ & 0xFF) * 4;
                  _loc14_ = _loc17_ + (_loc11_ >> 11 & 1) * 3;
                  _loc9_ = _loc17_ + (_loc11_ >> 10 & 1) * 3;
                  _loc15_ = _loc17_ + (_loc11_ >> 9 & 1) * 3;
                  _loc10_ = _loc17_ + (_loc11_ >> 8 & 1) * 3;
                  _loc3_ = 0;
                  while(_loc3_ < 3)
                  {
                     _loc2_ = _loc3_ + 1;
                     _loc7_[_loc8_][_loc6_ + _loc3_] = (_loc14_ * (3 - _loc3_) + _loc9_ * _loc3_) / 3;
                     _loc7_[_loc8_ + 3][_loc6_ + _loc2_] = (_loc15_ * (3 - _loc2_) + _loc10_ * _loc2_) / 3;
                     _loc7_[_loc8_ + _loc2_][_loc6_] = (_loc14_ * (3 - _loc2_) + _loc15_ * _loc2_) / 3;
                     _loc7_[_loc8_ + _loc3_][_loc6_ + 3] = (_loc9_ * (3 - _loc3_) + _loc10_ * _loc3_) / 3;
                     _loc3_++;
                  }
                  _loc7_[_loc8_ + 1][_loc6_ + 1] = _loc14_ > _loc17_ ? _loc17_ + 2 : _loc17_ + 1;
                  _loc7_[_loc8_ + 1][_loc6_ + 2] = _loc9_ > _loc17_ ? _loc17_ + 2 : _loc17_ + 1;
                  _loc7_[_loc8_ + 2][_loc6_ + 1] = _loc15_ > _loc17_ ? _loc17_ + 2 : _loc17_ + 1;
                  _loc7_[_loc8_ + 2][_loc6_ + 2] = _loc10_ > _loc17_ ? _loc17_ + 2 : _loc17_ + 1;
               }
               _loc6_ += 4;
               _loc12_++;
            }
            _loc8_ += 4;
            _loc13_++;
         }
         return _loc7_;
      }
      
      private static function §_-7T§(param1:Vector.<Vector.<int>>) : void
      {
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc17_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:uint = param1.length - 1;
         var _loc16_:uint = param1[0].length - 1;
         _loc15_ = 1;
         while(_loc15_ < _loc10_)
         {
            _loc14_ = 1;
            while(_loc14_ < _loc16_)
            {
               _loc17_ = param1[_loc15_][_loc14_];
               if(_loc17_ >= 0)
               {
                  _loc4_ = param1[_loc15_ - 1][_loc14_ - 1] & 0xFF;
                  _loc5_ = param1[_loc15_ - 1][_loc14_] & 0xFF;
                  _loc6_ = param1[_loc15_ - 1][_loc14_ + 1] & 0xFF;
                  _loc7_ = param1[_loc15_][_loc14_ - 1] & 0xFF;
                  _loc8_ = param1[_loc15_][_loc14_ + 1] & 0xFF;
                  _loc9_ = param1[_loc15_ + 1][_loc14_ - 1] & 0xFF;
                  _loc11_ = param1[_loc15_ + 1][_loc14_] & 0xFF;
                  _loc12_ = param1[_loc15_ + 1][_loc14_ + 1] & 0xFF;
                  _loc3_ = _loc17_ + 1;
                  _loc2_ = _loc17_ - 1;
                  _loc13_ = (_loc4_ == _loc3_ || _loc5_ == _loc3_ || _loc7_ == _loc3_ ? 8 : 0) | (_loc6_ == _loc3_ || _loc5_ == _loc3_ || _loc8_ == _loc3_ ? 4 : 0) | (_loc9_ == _loc3_ || _loc11_ == _loc3_ || _loc7_ == _loc3_ ? 2 : 0) | (_loc12_ == _loc3_ || _loc11_ == _loc3_ || _loc8_ == _loc3_ ? 1 : 0);
                  if(_loc13_ == 15)
                  {
                     _loc13_ = 0;
                  }
                  param1[_loc15_][_loc14_] = _loc17_ | _loc13_ << 8;
               }
               _loc14_++;
            }
            _loc15_++;
         }
      }
      
      private static function §_-3Cm§(param1:Vector.<Vector.<int>>) : void
      {
         param1.shift();
         param1.pop();
         for each(var _loc2_:Vector.<int> in param1)
         {
            _loc2_.shift();
            _loc2_.pop();
         }
      }
      
      private static function §_-0x3§(param1:Vector.<Vector.<int>>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>(0);
         var _loc3_:Vector.<int> = new Vector.<int>(0);
         for each(var _loc5_:Vector.<int> in param1)
         {
            _loc5_.push(-110);
            _loc5_.unshift(-110);
         }
         var _loc6_:int = int(param1[0].length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc2_.push(-110);
            _loc3_.push(-110);
            _loc4_++;
         }
         param1.push(_loc3_);
         param1.unshift(_loc2_);
      }
      
      public function get minX() : int
      {
         return §_-2Yi§;
      }
      
      public function get maxX() : int
      {
         return §_-2GI§;
      }
      
      public function get minY() : int
      {
         return §_-cy§;
      }
      
      public function get maxY() : int
      {
         return §_-1M9§;
      }
      
      public function get §_-16N§() : int
      {
         return _width;
      }
      
      public function get §_-3WC§() : int
      {
         return _height;
      }
      
      public function get §_-3uW§() : int
      {
         return §_-1vo§.length;
      }
      
      public function get §_-1pm§() : Number
      {
         if(§_-4md§ != -1)
         {
            return §_-4md§;
         }
         return §_-2sX§;
      }
      
      public function get wallHeight() : Number
      {
         if(§_-4md§ != -1)
         {
            return §_-4md§ + 3.6;
         }
         return §_-2-2§;
      }
      
      public function set wallHeight(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         §_-2-2§ = param1;
      }
      
      public function get §_-33a§() : Number
      {
         return §_-0PI§;
      }
      
      public function set §_-33a§(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         §_-0PI§ = param1;
      }
      
      public function get §_-2Hr§() : Number
      {
         return §_-K3§;
      }
      
      public function set §_-2Hr§(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         §_-K3§ = param1;
      }
      
      public function dispose() : void
      {
         §_-1vo§ = null;
         §for § = null;
         §_-0j4§ = null;
         §_-04K§ = null;
         if(§_-3ON§ != null)
         {
            §_-3ON§.dispose();
            §_-3ON§ = null;
         }
      }
      
      public function reset() : void
      {
         for each(var _loc1_:§_-3Yc§ in §_-1vo§)
         {
            _loc1_.dispose();
         }
         §_-1vo§ = new Vector.<§_-3Yc§>();
         §for § = [];
         §_-0j4§ = [];
         §for § = [];
         §_-0j4§ = [];
         _width = 0;
         _height = 0;
         §_-2Yi§ = 0;
         §_-2GI§ = 0;
         §_-cy§ = 0;
         §_-1M9§ = 0;
         §_-2sX§ = 0;
         §_-04K§ = [];
      }
      
      public function §_-x7§(param1:int, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc7_:Array = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         §for § = [];
         §_-0j4§ = [];
         §_-04K§ = [];
         _loc4_ = 0;
         while(_loc4_ < param2)
         {
            _loc7_ = [];
            _loc3_ = [];
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < param1)
            {
               _loc7_[_loc6_] = -110;
               _loc3_[_loc6_] = -110;
               _loc5_[_loc6_] = false;
               _loc6_++;
            }
            §for §.push(_loc7_);
            §_-0j4§.push(_loc3_);
            §_-04K§.push(_loc5_);
            _loc4_++;
         }
         _width = param1;
         _height = param2;
         §_-2Yi§ = _width;
         §_-2GI§ = -1;
         §_-cy§ = _height;
         §_-1M9§ = -1;
         return true;
      }
      
      public function §_-1yQ§(param1:int, param2:int, param3:Number) : Boolean
      {
         var _loc8_:Array = null;
         var _loc5_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         if(param1 >= 0 && param1 < _width && param2 >= 0 && param2 < _height)
         {
            _loc8_ = §for §[param2] as Array;
            _loc8_[param1] = param3;
            if(param3 >= 0)
            {
               if(param1 < §_-2Yi§)
               {
                  §_-2Yi§ = param1;
               }
               if(param1 > §_-2GI§)
               {
                  §_-2GI§ = param1;
               }
               if(param2 < §_-cy§)
               {
                  §_-cy§ = param2;
               }
               if(param2 > §_-1M9§)
               {
                  §_-1M9§ = param2;
               }
            }
            else
            {
               if(param1 == §_-2Yi§ || param1 == §_-2GI§)
               {
                  _loc5_ = false;
                  _loc7_ = §_-cy§;
                  while(_loc7_ < §_-1M9§)
                  {
                     if(§_-302§(param1,_loc7_) >= 0)
                     {
                        _loc5_ = true;
                        break;
                     }
                     _loc7_++;
                  }
                  if(!_loc5_)
                  {
                     if(param1 == §_-2Yi§)
                     {
                        §_-2Yi§ = §_-2Yi§ + 1;
                     }
                     if(param1 == §_-2GI§)
                     {
                        §_-2GI§ = §_-2GI§ - 1;
                     }
                  }
               }
               if(param2 == §_-cy§ || param2 == §_-1M9§)
               {
                  _loc4_ = false;
                  _loc6_ = §_-2Yi§;
                  while(_loc6_ < §_-2GI§)
                  {
                     if(§_-4-t§(_loc6_,param2) >= 0)
                     {
                        _loc4_ = true;
                        break;
                     }
                     _loc6_++;
                  }
                  if(!_loc4_)
                  {
                     if(param2 == §_-cy§)
                     {
                        §_-cy§ = §_-cy§ + 1;
                     }
                     if(param2 == §_-1M9§)
                     {
                        §_-1M9§ = §_-1M9§ - 1;
                     }
                  }
               }
            }
            return true;
         }
         return false;
      }
      
      public function §_-4-t§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return -110;
         }
         var _loc3_:Array = §for §[param2] as Array;
         return Math.abs(_loc3_[param1] as Number);
      }
      
      private function §_-17j§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return -110;
         }
         if(§_-04K§[param2][param1])
         {
            return -100;
         }
         var _loc3_:Array = §_-0j4§[param2] as Array;
         return _loc3_[param1] as Number;
      }
      
      private function §_-302§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return -110;
         }
         var _loc3_:Array = §for §[param2] as Array;
         return _loc3_[param1] as Number;
      }
      
      public function §_-2n8§(param1:int = -1) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         §_-4md§ = param1;
         _loc3_ = 0;
         while(_loc3_ < _height)
         {
            _loc2_ = 0;
            while(_loc2_ < _width)
            {
               §_-0j4§[_loc3_][_loc2_] = §for §[_loc3_][_loc2_];
               _loc2_++;
            }
            _loc3_++;
         }
         var _loc4_:Point = §_-3Vo§(§for §);
         _loc3_ = 0;
         while(_loc3_ < _height)
         {
            _loc2_ = 0;
            while(_loc2_ < _width)
            {
               if(§_-04K§[_loc3_][_loc2_])
               {
                  §_-1yQ§(_loc2_,_loc3_,-100);
               }
               _loc2_++;
            }
            _loc3_++;
         }
         var _temp_2:* = initialize(_loc4_);
         HabboTicketLogin.clipRoomPlanes32(this);
         return _temp_2;
      }
      
      private function initialize(param1:Point) : Boolean
      {
         var _loc5_:int = 0;
         if(param1 != null)
         {
            _loc5_ = §_-4-t§(param1.x,param1.y);
            §_-1yQ§(param1.x,param1.y,-110);
         }
         §_-2sX§ = §_-1my§(§for §);
         §_-3XP§();
         var _loc3_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(0);
         for each(var _loc4_:Array in §for §)
         {
            _loc3_.push(Vector.<int>(_loc4_));
         }
         §_-0x3§(_loc3_);
         §_-7T§(_loc3_);
         §_-3Cm§(_loc3_);
         var _loc2_:Vector.<Vector.<int>> = §_-0mM§(_loc3_);
         §_-3Sn§(_loc2_);
         if(param1 != null)
         {
            §_-1yQ§(param1.x,param1.y,_loc5_);
            §_-0fo§(new Vector3d(param1.x + 0.5,param1.y + 0.5,_loc5_),new Vector3d(-1,0,0),new Vector3d(0,-1,0),false,false,false,false);
         }
         return true;
      }
      
      private function §_-As§(param1:Point, param2:Boolean) : §_-c2§
      {
         var _loc3_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc12_:int = 0;
         var _loc11_:Point = null;
         var _loc8_:int = 0;
         var _loc4_:§_-c2§ = new §_-c2§();
         var _loc5_:Array = [§_-1UN§,§_-0JW§,§_-4Ax§,§_-3S4§];
         var _loc6_:int = 0;
         var _loc10_:Point = new Point(param1.x,param1.y);
         var _loc7_:int = 0;
         while(_loc7_++ < 1000)
         {
            _loc3_ = false;
            _loc9_ = false;
            _loc12_ = _loc6_;
            if(_loc10_.x < minX || _loc10_.x > maxX || _loc10_.y < minY || _loc10_.y > maxY)
            {
               _loc3_ = true;
            }
            _loc11_ = _loc5_[_loc6_](_loc10_,param2);
            if(_loc11_ == null)
            {
               return null;
            }
            _loc8_ = Math.abs(_loc11_.x - _loc10_.x) + Math.abs(_loc11_.y - _loc10_.y);
            if(_loc10_.x == _loc11_.x || _loc10_.y == _loc11_.y)
            {
               _loc6_ = (_loc6_ - 1 + _loc5_.length) % _loc5_.length;
               _loc8_ += 1;
               _loc9_ = true;
            }
            else
            {
               _loc6_ = (_loc6_ + 1) % _loc5_.length;
               _loc8_ -= 1;
            }
            _loc4_.§_-a8§(_loc10_,_loc12_,_loc8_,_loc3_,_loc9_);
            if(_loc11_.x == param1.x && _loc11_.y == param1.y && (_loc11_.x != _loc10_.x || _loc11_.y != _loc10_.y))
            {
               break;
            }
            _loc10_ = _loc11_;
         }
         if(_loc4_.count == 0)
         {
            return null;
         }
         return _loc4_;
      }
      
      private function §_-0UC§(param1:§_-c2§) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = param1.count;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc5_;
            _loc3_ = _loc5_;
            _loc8_ = 0;
            _loc6_ = false;
            while(!param1.§_-20E§(_loc5_) && _loc5_ < _loc4_)
            {
               if(param1.§_-2IK§(_loc5_))
               {
                  _loc8_++;
               }
               else if(_loc8_ > 0)
               {
                  _loc8_--;
               }
               if(_loc8_ > 1)
               {
                  _loc6_ = true;
               }
               _loc3_ = _loc5_;
               _loc5_++;
            }
            if(_loc6_)
            {
               _loc7_ = _loc2_;
               while(_loc7_ <= _loc3_)
               {
                  param1.§_-1Wz§(_loc7_,true);
                  _loc7_++;
               }
            }
            _loc5_++;
         }
      }
      
      private function §_-1Lg§(param1:§_-c2§) : void
      {
         var _loc8_:int = 0;
         var _loc4_:Point = null;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:§_-3gO§ = null;
         var _loc3_:§_-3gO§ = null;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = param1.count;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(!param1.§_-1RD§(_loc8_))
            {
               _loc4_ = param1.§_-ep§(_loc8_);
               _loc10_ = param1.getDirection(_loc8_);
               _loc7_ = param1.§_-36R§(_loc8_);
               _loc5_ = §_-c2§.§_-3ZE§[_loc10_];
               _loc3_ = §_-c2§.§_-1-H§[_loc10_];
               _loc2_ = 0;
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  if(§_-302§(_loc4_.x + _loc9_ * _loc5_.x - _loc3_.x,_loc4_.y + _loc9_ * _loc5_.y - _loc3_.y) == -100)
                  {
                     if(_loc9_ > 0 && _loc2_ == 0)
                     {
                        param1.§_-0rH§(_loc8_,_loc9_);
                        break;
                     }
                     _loc2_++;
                  }
                  else if(_loc2_ > 0)
                  {
                     param1.§_-4Z-§(_loc8_,_loc2_);
                     break;
                  }
                  _loc9_++;
               }
               if(_loc2_ == _loc7_)
               {
                  param1.§_-1Wz§(_loc8_,true);
               }
            }
            _loc8_++;
         }
      }
      
      private function §_-1wR§(param1:Point, param2:Point, param3:§_-c2§) : int
      {
         var _loc7_:int = 0;
         var _loc14_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:int = int(Math.min(param1.y,param2.y));
         var _loc4_:int = int(Math.max(param1.y,param2.y));
         var _loc13_:int = int(Math.min(param1.x,param2.x));
         var _loc5_:int = int(Math.max(param1.x,param2.x));
         var _loc6_:int = param3.count;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc14_ = param3.§_-ep§(_loc7_);
            _loc10_ = param3.§_-S3§(_loc7_);
            if(param1.x == param2.x)
            {
               if(_loc14_.x == param1.x && _loc10_.x == param1.x)
               {
                  _loc11_ = int(Math.min(_loc14_.y,_loc10_.y));
                  _loc8_ = int(Math.max(_loc14_.y,_loc10_.y));
                  if(_loc11_ <= _loc12_ && _loc4_ <= _loc8_)
                  {
                     return _loc7_;
                  }
               }
            }
            else if(param1.y == param2.y)
            {
               if(_loc14_.y == param1.y && _loc10_.y == param1.y)
               {
                  _loc15_ = int(Math.min(_loc14_.x,_loc10_.x));
                  _loc9_ = int(Math.max(_loc14_.x,_loc10_.x));
                  if(_loc15_ <= _loc13_ && _loc5_ <= _loc9_)
                  {
                     return _loc7_;
                  }
               }
            }
            _loc7_++;
         }
         return -1;
      }
      
      private function §_-2BY§(param1:§_-c2§, param2:§_-c2§) : void
      {
         var _loc8_:int = 0;
         var _loc6_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:§_-3gO§ = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = param1.count;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            if(!param1.§_-1RD§(_loc8_))
            {
               _loc6_ = param1.§_-ep§(_loc8_);
               _loc3_ = new Point(_loc6_.x,_loc6_.y);
               _loc4_ = §_-c2§.§_-3ZE§[param1.getDirection(_loc8_)];
               _loc7_ = param1.§_-36R§(_loc8_);
               _loc3_.x += _loc4_.x * _loc7_;
               _loc3_.y += _loc4_.y * _loc7_;
               _loc9_ = §_-1wR§(_loc6_,_loc3_,param2);
               if(_loc9_ >= 0)
               {
                  if(param2.§_-1RD§(_loc9_))
                  {
                     param1.§_-1Wz§(_loc8_,true);
                  }
               }
               else
               {
                  param1.§_-1Wz§(_loc8_,true);
               }
            }
            _loc8_++;
         }
      }
      
      private function §_-17J§(param1:§_-c2§, param2:§_-c2§) : void
      {
         §_-0UC§(param2);
         §_-1Lg§(param1);
         §_-2BY§(param1,param2);
      }
      
      private function §_-1cW§(param1:§_-c2§, param2:§_-c2§) : void
      {
         var _loc25_:int = 0;
         var _loc14_:int = 0;
         var _loc17_:int = 0;
         var _loc10_:Point = null;
         var _loc13_:int = 0;
         var _loc16_:int = 0;
         var _loc11_:§_-3gO§ = null;
         var _loc6_:§_-3gO§ = null;
         var _loc20_:Number = NaN;
         var _loc18_:int = 0;
         var _loc27_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc3_:Vector3d = null;
         var _loc4_:Number = NaN;
         var _loc9_:Vector3d = null;
         var _loc19_:Vector3d = null;
         var _loc12_:int = 0;
         var _loc8_:Vector3d = null;
         var _loc21_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc15_:int = param1.count;
         var _loc23_:int = param2.count;
         _loc17_ = 0;
         while(_loc17_ < _loc15_)
         {
            if(!param1.§_-1RD§(_loc17_))
            {
               _loc10_ = param1.§_-ep§(_loc17_);
               _loc13_ = param1.getDirection(_loc17_);
               _loc16_ = param1.§_-36R§(_loc17_);
               _loc11_ = §_-c2§.§_-3ZE§[_loc13_];
               _loc6_ = §_-c2§.§_-1-H§[_loc13_];
               _loc20_ = -1;
               _loc18_ = 0;
               while(_loc18_ < _loc16_)
               {
                  _loc27_ = §_-302§(_loc10_.x + _loc18_ * _loc11_.x + _loc6_.x,_loc10_.y + _loc18_ * _loc11_.y + _loc6_.y);
                  if(_loc27_ >= 0 && (_loc27_ < _loc20_ || _loc20_ < 0))
                  {
                     _loc20_ = _loc27_;
                  }
                  _loc18_++;
               }
               _loc24_ = _loc20_;
               _loc3_ = new Vector3d(_loc10_.x,_loc10_.y,_loc24_);
               _loc3_ = Vector3d.sum(_loc3_,Vector3d.product(_loc6_,0.5));
               _loc3_ = Vector3d.sum(_loc3_,Vector3d.product(_loc11_,-0.5));
               _loc4_ = wallHeight + Math.min(20,§_-1pm§) - _loc20_;
               _loc9_ = Vector3d.product(_loc11_,-_loc16_);
               _loc19_ = new Vector3d(0,0,_loc4_);
               _loc3_ = Vector3d.§_-1F1§(_loc3_,_loc9_);
               _loc12_ = §_-1wR§(_loc10_,param1.§_-S3§(_loc17_),param2);
               if(_loc12_ >= 0)
               {
                  _loc25_ = param2.getDirection((_loc12_ + 1) % _loc23_);
                  _loc14_ = param2.getDirection((_loc12_ - 1 + _loc23_) % _loc23_);
               }
               else
               {
                  _loc25_ = param1.getDirection((_loc17_ + 1) % _loc15_);
                  _loc14_ = param1.getDirection((_loc17_ - 1 + _loc15_) % _loc15_);
               }
               _loc8_ = null;
               if((_loc25_ - _loc13_ + 4) % 4 == 3)
               {
                  _loc8_ = §_-c2§.§_-1-H§[_loc25_];
               }
               else if((_loc13_ - _loc14_ + 4) % 4 == 3)
               {
                  _loc8_ = §_-c2§.§_-1-H§[_loc14_];
               }
               _loc21_ = param1.§_-2IK§(_loc17_);
               _loc7_ = param1.§_-2IK§((_loc17_ - 1 + _loc15_) % _loc15_);
               _loc26_ = param1.§_-1RD§((_loc17_ + 1) % _loc15_);
               _loc5_ = param1.§_-3dy§(_loc17_);
               _loc22_ = param1.§_-0Uz§(_loc17_);
               §_-a8§(_loc3_,_loc9_,_loc19_,_loc8_,!_loc7_ || _loc5_,!_loc21_ || _loc22_,!_loc26_);
            }
            _loc17_++;
         }
      }
      
      private function §_-3XP§() : Boolean
      {
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:Array = §for §;
         if(_loc6_ == null)
         {
            return false;
         }
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc14_:int = int(_loc6_.length);
         var _loc8_:int = 0;
         if(_loc14_ == 0)
         {
            return false;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc14_)
         {
            _loc1_ = _loc6_[_loc4_] as Array;
            if(_loc1_ == null || _loc1_.length == 0)
            {
               return false;
            }
            if(_loc8_ > 0)
            {
               _loc8_ = int(Math.min(_loc8_,_loc1_.length));
            }
            else
            {
               _loc8_ = int(_loc1_.length);
            }
            _loc4_++;
         }
         var _loc13_:Number = Number(Math.min(20,§_-4md§ != -1 ? §_-4md§ : §_-1my§(_loc6_)));
         var _loc9_:int = minX;
         var _loc10_:int = minY;
         _loc10_ = minY;
         while(_loc10_ <= maxY)
         {
            if(§_-302§(_loc9_,_loc10_) > -100)
            {
               _loc10_--;
               break;
            }
            _loc10_++;
         }
         if(_loc10_ > maxY)
         {
            return false;
         }
         var _loc2_:Point = new Point(_loc9_,_loc10_);
         var _loc7_:§_-c2§ = §_-As§(_loc2_,true);
         var _loc12_:§_-c2§ = §_-As§(_loc2_,false);
         if(_loc7_ != null)
         {
            _loc3_ = _loc7_.count;
            _loc11_ = _loc12_.count;
            §_-17J§(_loc7_,_loc12_);
            §_-1cW§(_loc7_,_loc12_);
         }
         _loc5_ = 0;
         while(_loc5_ < §_-3WC§)
         {
            _loc4_ = 0;
            while(_loc4_ < §_-16N§)
            {
               if(§_-302§(_loc4_,_loc5_) < 0)
               {
                  §_-1yQ§(_loc4_,_loc5_,-(_loc13_ + wallHeight));
               }
               _loc4_++;
            }
            _loc5_++;
         }
         return true;
      }
      
      private function §_-1UN§(param1:Point, param2:Boolean) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = 1;
         var _loc4_:int = -100;
         if(!param2)
         {
            _loc4_ = -110;
         }
         while(_loc3_ < 1000)
         {
            if(§_-302§(param1.x + _loc3_,param1.y) > _loc4_)
            {
               return new Point(param1.x + _loc3_ - 1,param1.y);
            }
            if(§_-302§(param1.x + _loc3_,param1.y + 1) <= _loc4_)
            {
               return new Point(param1.x + _loc3_,param1.y + 1);
            }
            _loc3_++;
         }
         return null;
      }
      
      private function §_-0JW§(param1:Point, param2:Boolean) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = 1;
         var _loc4_:int = -100;
         if(!param2)
         {
            _loc4_ = -110;
         }
         while(_loc3_ < 1000)
         {
            if(§_-302§(param1.x,param1.y + _loc3_) > _loc4_)
            {
               return new Point(param1.x,param1.y + (_loc3_ - 1));
            }
            if(§_-302§(param1.x - 1,param1.y + _loc3_) <= _loc4_)
            {
               return new Point(param1.x - 1,param1.y + _loc3_);
            }
            _loc3_++;
         }
         return null;
      }
      
      private function §_-4Ax§(param1:Point, param2:Boolean) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = 1;
         var _loc4_:int = -100;
         if(!param2)
         {
            _loc4_ = -110;
         }
         while(_loc3_ < 1000)
         {
            if(§_-302§(param1.x - _loc3_,param1.y) > _loc4_)
            {
               return new Point(param1.x - (_loc3_ - 1),param1.y);
            }
            if(§_-302§(param1.x - _loc3_,param1.y - 1) <= _loc4_)
            {
               return new Point(param1.x - _loc3_,param1.y - 1);
            }
            _loc3_++;
         }
         return null;
      }
      
      private function §_-3S4§(param1:Point, param2:Boolean) : Point
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:int = 1;
         var _loc4_:int = -100;
         if(!param2)
         {
            _loc4_ = -110;
         }
         while(_loc3_ < 1000)
         {
            if(§_-302§(param1.x,param1.y - _loc3_) > _loc4_)
            {
               return new Point(param1.x,param1.y - (_loc3_ - 1));
            }
            if(§_-302§(param1.x + 1,param1.y - _loc3_) <= _loc4_)
            {
               return new Point(param1.x + 1,param1.y - _loc3_);
            }
            _loc3_++;
         }
         return null;
      }
      
      private function §_-a8§(param1:§_-3gO§, param2:§_-3gO§, param3:§_-3gO§, param4:§_-3gO§, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc12_:Vector3d = null;
         §_-1Fb§(2,param1,param2,param3,[param4]);
         §_-1Fb§(3,param1,param2,param3,[param4]);
         var _loc10_:Number = 0.25 * §_-0PI§;
         var _loc8_:Number = 0.25 * §_-K3§;
         var _loc11_:Vector3d = Vector3d.crossProduct(param2,param3);
         var _loc9_:Vector3d = Vector3d.product(_loc11_,1 / _loc11_.length * -_loc10_);
         §_-1Fb§(2,Vector3d.sum(param1,param3),param2,_loc9_,[_loc11_,param4]);
         if(param5)
         {
            §_-1Fb§(2,Vector3d.sum(Vector3d.sum(param1,param2),param3),Vector3d.product(param3,-(param3.length + _loc8_) / param3.length),_loc9_,[_loc11_,param4]);
         }
         if(param6)
         {
            §_-1Fb§(2,Vector3d.sum(param1,Vector3d.product(param3,-_loc8_ / param3.length)),Vector3d.product(param3,(param3.length + _loc8_) / param3.length),_loc9_,[_loc11_,param4]);
            if(param7)
            {
               _loc12_ = Vector3d.product(param2,_loc10_ / param2.length);
               §_-1Fb§(2,Vector3d.sum(Vector3d.sum(param1,param3),Vector3d.product(_loc12_,-1)),_loc12_,_loc9_,[_loc11_,param2,param4]);
            }
         }
      }
      
      private function §_-0fo§(param1:§_-3gO§, param2:§_-3gO§, param3:§_-3gO§, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc10_:Number = NaN;
         var _loc9_:Vector3d = null;
         var _loc8_:Vector3d = null;
         var _loc11_:§_-3Yc§ = §_-1Fb§(1,param1,param2,param3);
         if(_loc11_ != null)
         {
            _loc10_ = 0.25 * §_-K3§;
            _loc9_ = new Vector3d(0,0,_loc10_);
            _loc8_ = Vector3d.§_-1F1§(param1,_loc9_);
            if(param6)
            {
               §_-1Fb§(1,_loc8_,param2,_loc9_);
            }
            if(param7)
            {
               §_-1Fb§(1,Vector3d.sum(_loc8_,Vector3d.sum(param2,param3)),Vector3d.product(param2,-1),_loc9_);
            }
            if(param4)
            {
               §_-1Fb§(1,Vector3d.sum(_loc8_,param3),Vector3d.product(param3,-1),_loc9_);
            }
            if(param5)
            {
               §_-1Fb§(1,Vector3d.sum(_loc8_,param2),param3,_loc9_);
            }
         }
      }
      
      public function §_-2lo§(param1:XML) : Boolean
      {
         var _loc7_:int = 0;
         var _loc16_:XML = null;
         var _loc15_:XMLList = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc13_:XML = null;
         var _loc19_:Number = NaN;
         var _loc9_:XML = null;
         var _loc11_:XMLList = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:XML = null;
         if(param1 == null)
         {
            return false;
         }
         reset();
         §_-367§();
         if(!§_-Xq§.§_-2Sx§(param1.tileMap[0],["width","height","wallHeight"]))
         {
            return false;
         }
         var _loc12_:int = int(parseInt(param1.tileMap.@width));
         var _loc18_:int = int(parseInt(param1.tileMap.@height));
         var _loc17_:Number = Number(parseFloat(param1.tileMap.@wallHeight));
         var _loc3_:int = int(parseInt(param1.tileMap.@fixedWallsHeight));
         §_-x7§(_loc12_,_loc18_);
         var _loc14_:XMLList = param1.tileMap.tileRow;
         var _loc2_:int = int(_loc14_.length());
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc16_ = _loc14_[_loc7_];
            _loc15_ = _loc16_.tile;
            _loc4_ = int(_loc15_.length());
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc13_ = _loc15_[_loc6_];
               _loc19_ = Number(parseFloat(_loc13_.@height));
               §_-1yQ§(_loc6_,_loc7_,_loc19_);
               _loc6_++;
            }
            _loc7_++;
         }
         if(param1.holeMap.length() > 0)
         {
            _loc9_ = param1.holeMap[0];
            _loc11_ = _loc9_.hole;
            _loc5_ = int(_loc11_.length());
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc10_ = _loc11_[_loc8_];
               if(§_-Xq§.§_-2Sx§(_loc10_,["id","x","y","width","height"]))
               {
                  §_-as§(_loc10_.@id,_loc10_.@x,_loc10_.@y,_loc10_.@width,_loc10_.@height);
               }
               _loc8_++;
            }
            §_-26O§();
         }
         this.wallHeight = _loc17_;
         §_-2n8§(_loc3_);
         return true;
      }
      
      private function §_-1Fb§(param1:int, param2:§_-3gO§, param3:§_-3gO§, param4:§_-3gO§, param5:Array = null) : §_-3Yc§
      {
         if(param3.length == 0 || param4.length == 0)
         {
            return null;
         }
         var _loc6_:§_-3Yc§ = new §_-3Yc§(param1,param2,param3,param4,param5);
         §_-1vo§.push(_loc6_);
         return _loc6_;
      }
      
      public function §_-0k5§() : XML
      {
         var _loc5_:int = 0;
         var _loc1_:XML = null;
         var _loc13_:Array = null;
         var _loc3_:int = 0;
         var _loc15_:Number = NaN;
         var _loc4_:XML = null;
         var _loc7_:int = 0;
         var _loc8_:§_-0N7§ = null;
         var _loc14_:int = 0;
         var _loc2_:XML = null;
         var _loc10_:XML = <tileMap width={_width} height={_height} wallHeight={§_-2-2§} fixedWallsHeight={§_-4md§}/>
			;
         _loc5_ = 0;
         while(_loc5_ < _height)
         {
            _loc1_ = <tileRow/>
				;
            _loc13_ = §_-0j4§[_loc5_];
            _loc3_ = 0;
            while(_loc3_ < _width)
            {
               _loc15_ = Number(_loc13_[_loc3_]);
               _loc4_ = <tile height={_loc15_}/>
					;
               _loc1_.appendChild(_loc4_);
               _loc3_++;
            }
            _loc10_.appendChild(_loc1_);
            _loc5_++;
         }
         var _loc12_:XML = <holeMap/>
			;
         var _loc9_:int = int(§_-3ON§.length);
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc8_ = §_-3ON§.§_-2DR§(_loc7_);
            if(_loc8_ != null)
            {
               _loc14_ = §_-3ON§.§_-2Bo§(_loc7_);
               _loc2_ = <hole id={_loc14_} x={_loc8_.x} y={_loc8_.y} width={_loc8_.width} height={_loc8_.height}/>
					;
               _loc12_.appendChild(_loc2_);
            }
            _loc7_++;
         }
         var _loc11_:XML = <roomData/>
			;
         _loc11_.appendChild(_loc10_);
         _loc11_.appendChild(_loc12_);
         var _loc6_:XML = <dimensions minX={minX} maxX={maxX} minY={minY} maxY={maxY} />
			;
         _loc11_.appendChild(_loc6_);
         return _loc11_;
      }
      
      public function §_-2us§() : Vector.<§_-3Yc§>
      {
         return §_-1vo§;
      }
      
      public function §_-1Ae§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-UL§;
         }
         return null;
      }
      
      public function §_-1fn§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.normal;
         }
         return null;
      }
      
      public function §_-0-F§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-1Jd§;
         }
         return null;
      }
      
      public function §_-1wo§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-4Gh§;
         }
         return null;
      }
      
      public function §_-0Wg§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-3NR§;
         }
         return null;
      }
      
      public function §_-4dT§(param1:int) : Array
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return null;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            _loc3_ = [];
            _loc5_ = _loc2_.§_-1yp§;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc3_.push(_loc2_.§_-1r3§(_loc4_));
               _loc4_++;
            }
            return _loc3_;
         }
         return null;
      }
      
      public function §_-i§(param1:int) : int
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return 0;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.type;
         }
         return 0;
      }
      
      public function §_-2uY§(param1:int) : int
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return 0;
         }
         var _loc2_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-23s§;
         }
         return 0;
      }
      
      public function §_-1Wb§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return -1;
         }
         var _loc3_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc3_ != null)
         {
            return _loc3_.§_-21y§(param2);
         }
         return -1;
      }
      
      public function §_-2iD§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return -1;
         }
         var _loc3_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc3_ != null)
         {
            return _loc3_.§_-2OL§(param2);
         }
         return -1;
      }
      
      public function §_-Vn§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return -1;
         }
         var _loc3_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc3_ != null)
         {
            return _loc3_.§_-44K§(param2);
         }
         return -1;
      }
      
      public function §_-0oe§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= §_-3uW§)
         {
            return -1;
         }
         var _loc3_:§_-3Yc§ = §_-1vo§[param1] as §_-3Yc§;
         if(_loc3_ != null)
         {
            return _loc3_.§_-1D7§(param2);
         }
         return -1;
      }
      
      public function §_-as§(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         §_-3W5§(param1);
         var _loc6_:§_-0N7§ = new §_-0N7§(param2,param3,param4,param5);
         §_-3ON§.add(param1,_loc6_);
      }
      
      public function §_-3W5§(param1:int) : void
      {
         §_-3ON§.remove(param1);
      }
      
      public function §_-367§() : void
      {
         §_-3ON§.reset();
      }
      
      private function §_-26O§() : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Array = null;
         var _loc8_:int = 0;
         var _loc1_:§_-0N7§ = null;
         var _loc4_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _height)
         {
            _loc9_ = §_-04K§[_loc7_];
            _loc6_ = 0;
            while(_loc6_ < _width)
            {
               _loc9_[_loc6_] = false;
               _loc6_++;
            }
            _loc7_++;
         }
         var _loc2_:int = int(§_-3ON§.length);
         _loc8_ = 0;
         while(_loc8_ < _loc2_)
         {
            _loc1_ = §_-3ON§.§_-2DR§(_loc8_);
            if(_loc1_ != null)
            {
               _loc4_ = _loc1_.x;
               _loc10_ = _loc1_.x + _loc1_.width - 1;
               _loc3_ = _loc1_.y;
               _loc5_ = _loc1_.y + _loc1_.height - 1;
               _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
               _loc10_ = int(_loc10_ >= _width ? _width - 1 : _loc10_);
               _loc3_ = int(_loc3_ < 0 ? 0 : _loc3_);
               _loc5_ = int(_loc5_ >= _height ? _height - 1 : _loc5_);
               _loc7_ = _loc3_;
               while(_loc7_ <= _loc5_)
               {
                  _loc9_ = §_-04K§[_loc7_];
                  _loc6_ = _loc4_;
                  while(_loc6_ <= _loc10_)
                  {
                     _loc9_[_loc6_] = true;
                     _loc6_++;
                  }
                  _loc7_++;
               }
            }
            _loc8_++;
         }
      }
      
      private function §_-3Sn§(param1:Vector.<Vector.<int>>) : void
      {
         var _loc3_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc13_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc5_:uint = uint(param1.length);
         var _loc19_:uint = uint(param1[0].length);
         var _loc2_:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(_loc5_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc2_[_loc3_] = new Vector.<Boolean>(_loc19_);
            _loc3_++;
         }
         _loc17_ = 0;
         while(_loc17_ < _loc5_)
         {
            _loc18_ = 0;
            while(_loc18_ < _loc19_)
            {
               _loc6_ = param1[_loc17_][_loc18_];
               if(!(_loc6_ < 0 || _loc2_[_loc17_][_loc18_]))
               {
                  _loc9_ = _loc18_ == 0 || param1[_loc17_][_loc18_ - 1] != _loc6_;
                  _loc4_ = _loc17_ == 0 || param1[_loc17_ - 1][_loc18_] != _loc6_;
                  _loc12_ = int(_loc18_ + 1);
                  while(_loc12_ < _loc19_)
                  {
                     if(param1[_loc17_][_loc12_] != _loc6_ || _loc2_[_loc17_][_loc12_] || _loc17_ > 0 && param1[_loc17_ - 1][_loc12_] == _loc6_ == _loc4_)
                     {
                        break;
                     }
                     _loc12_++;
                  }
                  _loc14_ = _loc12_ == _loc19_ || param1[_loc17_][_loc12_] != _loc6_;
                  _loc13_ = false;
                  _loc8_ = _loc17_ + 1;
                  while(_loc8_ < _loc5_ && !_loc13_)
                  {
                     _loc20_ = param1[_loc8_][_loc18_] != _loc6_;
                     _loc13_ = _loc20_ || _loc18_ > 0 && param1[_loc8_][_loc18_ - 1] == _loc6_ == _loc9_ || _loc12_ < _loc19_ && param1[_loc8_][_loc12_] == _loc6_ == _loc14_;
                     _loc15_ = _loc18_;
                     while(_loc15_ < _loc12_)
                     {
                        if(param1[_loc8_][_loc15_] == _loc6_ == _loc20_)
                        {
                           _loc13_ = true;
                           _loc12_ = _loc15_;
                           break;
                        }
                        _loc15_++;
                     }
                     if(_loc13_)
                     {
                        break;
                     }
                     _loc8_++;
                  }
                  if(!_loc20_)
                  {
                     _loc20_ = _loc8_ == _loc5_;
                  }
                  _loc14_ = _loc12_ == _loc19_ || param1[_loc17_][_loc12_] != _loc6_;
                  _loc16_ = _loc17_;
                  while(_loc16_ < _loc8_)
                  {
                     _loc15_ = _loc18_;
                     while(_loc15_ < _loc12_)
                     {
                        _loc2_[_loc16_][_loc15_] = true;
                        _loc15_++;
                     }
                     _loc16_++;
                  }
                  _loc7_ = _loc18_ / 4 - 0.5;
                  _loc10_ = _loc17_ / 4 - 0.5;
                  _loc11_ = (_loc12_ - _loc18_) / 4;
                  _loc21_ = (_loc8_ - _loc17_) / 4;
                  §_-0fo§(new Vector3d(_loc7_ + _loc11_,_loc10_ + _loc21_,_loc6_ / 4),new Vector3d(-_loc11_,0,0),new Vector3d(0,-_loc21_,0),_loc14_,_loc9_,_loc20_,_loc4_);
               }
               _loc18_++;
            }
            _loc17_++;
         }
      }
      
      public function §_-0Iu§() : §_-3gO§
      {
         var _loc2_:§_-3gO§ = null;
         var _loc1_:Vector3d = null;
         var _loc8_:Number = 0;
         var _loc3_:Number = 0;
         for each(var _loc4_:§_-3Yc§ in §_-1vo§)
         {
            if(!(_loc4_.type != 1 || _loc4_.normal.z == 0))
            {
               _loc2_ = _loc4_.§_-UL§;
               if(_loc2_.z > _loc3_)
               {
                  _loc3_ = _loc2_.z;
               }
               _loc1_ = new Vector3d();
               _loc1_.add(_loc2_);
               _loc1_.add(_loc4_.§_-1Jd§);
               _loc1_.add(_loc4_.§_-4Gh§);
               if(_loc1_.z < _loc8_)
               {
                  _loc8_ = _loc1_.z;
               }
            }
         }
         var _loc5_:Number = (§_-2GI§ + §_-2Yi§) / 2;
         var _loc6_:Number = (§_-1M9§ + §_-cy§) / 2;
         var _loc7_:Number = (_loc3_ + _loc8_) / 2;
         return new Vector3d(_loc5_,_loc6_,_loc7_);
      }
   }
}

