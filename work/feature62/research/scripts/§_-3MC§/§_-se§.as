package §_-3MC§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-0KT§.§_-2eb§;
   
   public class §_-se§ implements §_-2eb§
   {
      
      private static const §_-37Y§:String = "l";
      
      private static const §_-0PK§:String = "r";
      
      private var §_-101§:Boolean = false;
      
      private var §_-1Lp§:int = 64;
      
      private var §_-04i§:Array = [];
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var §_-2sX§:int = 0;
      
      public function §_-se§()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return §_-101§;
      }
      
      public function get scale() : int
      {
         return §_-1Lp§;
      }
      
      public function set scale(param1:int) : void
      {
         §_-1Lp§ = param1;
      }
      
      public function dispose() : void
      {
         reset();
         §_-101§ = true;
      }
      
      public function initialize(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 <= _width && param2 <= _height)
         {
            _width = param1;
            _height = param2;
            §_-2sX§ = param3;
            return;
         }
         reset();
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc4_ = [];
            §_-04i§.push(_loc4_);
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc4_.push(0);
               _loc5_++;
            }
            _loc6_++;
         }
         _width = param1;
         _height = param2;
         §_-2sX§ = param3;
      }
      
      private function reset() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         if(§_-04i§ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < §_-04i§.length)
            {
               _loc1_ = §_-04i§[_loc2_] as Array;
               _loc2_++;
            }
            §_-04i§ = [];
         }
      }
      
      public function §_-1yQ§(param1:int, param2:int, param3:Number) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return false;
         }
         var _loc4_:Array = §_-04i§[param2] as Array;
         if(_loc4_ != null)
         {
            _loc4_[param1] = param3;
            return true;
         }
         return false;
      }
      
      public function §_-4-t§(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return 0;
         }
         var _loc3_:Array = §_-04i§[param2] as Array;
         if(_loc3_ != null)
         {
            return _loc3_[param1] as Number;
         }
         return 0;
      }
      
      public function getLocation(param1:int, param2:int, param3:int, param4:int, param5:String) : §_-3gO§
      {
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         if(param1 == 0 && param2 == 0)
         {
            param1 = _width;
            param2 = _height;
            _loc11_ = int(Math.round(scale / 10));
            if(param5 == "r")
            {
               _loc8_ = _width - 1;
               while(_loc8_ >= 0)
               {
                  _loc10_ = 1;
                  while(_loc10_ < _height)
                  {
                     if(§_-4-t§(_loc8_,_loc10_) <= §_-2sX§)
                     {
                        if(_loc10_ - 1 < param2)
                        {
                           param1 = _loc8_;
                           param2 = int(_loc10_ - 1);
                        }
                        break;
                     }
                     _loc10_++;
                  }
                  _loc8_--;
               }
               param4 += scale / 4 - _loc11_ / 2;
               param3 += scale / 2;
            }
            else
            {
               _loc10_ = _height - 1;
               while(_loc10_ >= 0)
               {
                  _loc8_ = 1;
                  while(_loc8_ < _width)
                  {
                     if(§_-4-t§(_loc8_,_loc10_) <= §_-2sX§)
                     {
                        if(_loc8_ - 1 < param1)
                        {
                           param1 = int(_loc8_ - 1);
                           param2 = _loc10_;
                        }
                        break;
                     }
                     _loc8_++;
                  }
                  _loc10_--;
               }
               param4 += scale / 4 - _loc11_ / 2;
               param3 -= _loc11_;
            }
         }
         var _loc7_:Number = param1;
         var _loc9_:Number = param2;
         var _loc12_:Number = §_-4-t§(param1,param2);
         if(param5 == "r")
         {
            _loc7_ += param3 / (§_-1Lp§ / 2) - 0.5;
            _loc9_ += 0.5;
            _loc12_ -= (param4 - param3 / 2) / (§_-1Lp§ / 2);
         }
         else
         {
            _loc9_ += (§_-1Lp§ / 2 - param3) / (§_-1Lp§ / 2) - 0.5;
            _loc7_ += 0.5;
            _loc12_ -= (param4 - (§_-1Lp§ / 2 - param3) / 2) / (§_-1Lp§ / 2);
         }
         return new Vector3d(_loc7_,_loc9_,_loc12_);
      }
      
      public function §_-4Gn§(param1:Number, param2:Number, param3:String) : §_-3gO§
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:Number = 0;
         var _loc4_:Number = 0;
         _loc7_ = int(Math.ceil(param1));
         _loc5_ = _loc7_ - param1;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _width)
         {
            if(_loc7_ >= 0 && _loc7_ < _height)
            {
               if(§_-4-t§(_loc6_,_loc7_) <= §_-2sX§)
               {
                  _loc8_ = int(_loc6_ - 1);
                  _loc9_ = _loc7_;
                  _loc4_ = _loc6_;
                  param3 = "l";
                  break;
               }
               if(§_-4-t§(_loc6_,_loc7_ + 1) <= §_-2sX§)
               {
                  _loc8_ = _loc6_;
                  _loc9_ = _loc7_;
                  _loc4_ = _loc9_ - param1;
                  param3 = "r";
                  break;
               }
            }
            _loc7_++;
            _loc6_++;
         }
         _loc12_ = scale / 2 * _loc5_;
         var _loc10_:Number = -_loc4_ * scale / 2;
         _loc10_ = _loc10_ + -param2 * 18 / 32 * scale / 2;
         _loc13_ = §_-4-t§(_loc8_,_loc9_);
         _loc11_ = _loc13_ * scale / 2 + _loc10_;
         if(param3 == "r")
         {
            _loc11_ += _loc5_ * scale / 4;
         }
         else
         {
            _loc11_ += (1 - _loc5_) * scale / 4;
         }
         return getLocation(_loc8_,_loc9_,_loc12_,_loc11_,param3);
      }
      
      public function §_-28i§(param1:§_-3gO§, param2:Number) : Array
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc7_:Number = 0;
         var _loc5_:Number = 0;
         var _loc8_:String = "";
         var _loc6_:Number = 0;
         if(param2 == 90)
         {
            _loc3_ = Number(Math.floor(param1.x - 0.5));
            _loc4_ = Number(Math.floor(param1.y + 0.5));
            _loc6_ = §_-4-t§(_loc3_,_loc4_);
            _loc7_ = §_-1Lp§ / 2 - (param1.y - _loc4_ + 0.5) * (§_-1Lp§ / 2);
            _loc5_ = (_loc6_ - param1.z) * (§_-1Lp§ / 2) + (§_-1Lp§ / 2 - _loc7_) / 2;
            _loc8_ = "l";
         }
         else
         {
            if(param2 != 180)
            {
               return null;
            }
            _loc3_ = Number(Math.floor(param1.x + 0.5));
            _loc4_ = Number(Math.floor(param1.y - 0.5));
            _loc6_ = §_-4-t§(_loc3_,_loc4_);
            _loc7_ = (param1.x + 0.5 - _loc3_) * (§_-1Lp§ / 2);
            _loc5_ = (_loc6_ - param1.z) * (§_-1Lp§ / 2) + _loc7_ / 2;
            _loc8_ = "r";
         }
         return [_loc3_,_loc4_,_loc7_,_loc5_,_loc8_];
      }
      
      public function §_-el§(param1:§_-3gO§, param2:Number) : String
      {
         var _loc3_:Array = §_-28i§(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:int = int(_loc3_[0]);
         var _loc5_:int = int(_loc3_[1]);
         var _loc9_:int = int(_loc3_[2]);
         var _loc6_:int = int(_loc3_[3]);
         var _loc8_:String = _loc3_[4];
         return ":w=" + _loc4_ + "," + _loc5_ + " l=" + _loc9_ + "," + _loc6_ + " " + _loc8_;
      }
      
      public function getDirection(param1:String) : Number
      {
         if(param1 == "r")
         {
            return 180;
         }
         return 90;
      }
      
      public function §_-2jS§(param1:int, param2:int) : Number
      {
         var _loc4_:int = §_-4-t§(param1,param2);
         var _loc3_:int = _loc4_ + 1;
         return _loc4_ + (int(§_-4-t§(param1 - 1,param2 - 1)) == _loc3_ || int(§_-4-t§(param1,param2 - 1)) == _loc3_ || int(§_-4-t§(param1 + 1,param2 - 1)) == _loc3_ || int(§_-4-t§(param1 - 1,param2)) == _loc3_ || int(§_-4-t§(param1 + 1,param2)) == _loc3_ || int(§_-4-t§(param1 - 1,param2 + 1)) == _loc3_ || int(§_-4-t§(param1,param2 + 1)) == _loc3_ || int(§_-4-t§(param1 + 1,param2 + 1)) == _loc3_ ? 0.5 : 0);
      }
      
      public function §_-2Zc§(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param1 < _width && param2 >= 0 && param2 < _height && §_-04i§[param2][param1] >= 0;
      }
   }
}

