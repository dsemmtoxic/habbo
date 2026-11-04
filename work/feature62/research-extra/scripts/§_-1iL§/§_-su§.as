package §_-1iL§
{
   import §_-44B§.Map;
   import flash.utils.Dictionary;
   
   public class §_-su§ implements §_-K-§
   {
      
      private static const §_-CU§:String = "ROMC_MAP_KEYS_";
      
      private static const §_-454§:String = "ROMC_MAP_VALUES_";
      
      private var §_-2jm§:Dictionary;
      
      private var §_-Rm§:Dictionary;
      
      private var §_-1cr§:Dictionary;
      
      private var §_-2PH§:Dictionary;
      
      private var §_-2xT§:Array;
      
      private var §_-Dm§:Array;
      
      private var §_-3ta§:Array;
      
      private var §_-3vV§:Array;
      
      private var §_-19f§:int;
      
      public function §_-su§()
      {
         super();
         §_-2jm§ = new Dictionary();
         §_-Rm§ = new Dictionary();
         §_-1cr§ = new Dictionary();
         §_-2PH§ = new Dictionary();
         §_-2xT§ = [];
         §_-Dm§ = [];
         §_-3ta§ = [];
         §_-3vV§ = [];
         §_-19f§ = 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         if(§_-2jm§ != null)
         {
            for(_loc1_ in §_-2jm§)
            {
               delete §_-2jm§[_loc1_];
            }
            §_-2jm§ = null;
         }
         if(§_-Rm§ != null)
         {
            for(_loc1_ in §_-Rm§)
            {
               delete §_-Rm§[_loc1_];
            }
            §_-Rm§ = null;
         }
         if(§_-1cr§ != null)
         {
            for(_loc1_ in §_-1cr§)
            {
               delete §_-1cr§[_loc1_];
            }
            §_-1cr§ = null;
         }
         if(§_-2PH§ != null)
         {
            for(_loc1_ in §_-2PH§)
            {
               delete §_-2PH§[_loc1_];
            }
            §_-2PH§ = null;
         }
         §_-Dm§ = [];
         §_-2xT§ = [];
         §_-3vV§ = [];
         §_-3ta§ = [];
      }
      
      public function hasNumber(param1:String) : Boolean
      {
         return §_-2jm§[param1] != null;
      }
      
      public function §_-3Ma§(param1:String) : Boolean
      {
         return §_-1cr§[param1] != null;
      }
      
      public function hasString(param1:String) : Boolean
      {
         return §_-Rm§[param1] != null;
      }
      
      public function §_-3AZ§(param1:String) : Boolean
      {
         return §_-2PH§[param1] != null;
      }
      
      public function getNumber(param1:String) : Number
      {
         return §_-2jm§[param1];
      }
      
      public function getString(param1:String) : String
      {
         return §_-Rm§[param1];
      }
      
      public function getNumberArray(param1:String) : Array
      {
         var _loc2_:Array = §_-1cr§[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function §_-SS§(param1:String) : Array
      {
         var _loc2_:Array = §_-2PH§[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringToStringMap(param1:String) : Map
      {
         var _loc7_:Map = null;
         var _loc5_:int = 0;
         var _loc3_:Array = §_-2PH§["ROMC_MAP_KEYS_" + param1];
         var _loc4_:Array = §_-2PH§["ROMC_MAP_VALUES_" + param1];
         var _loc2_:int = int(_loc3_ ? _loc3_.length : 0);
         var _loc6_:int = int(_loc4_ ? _loc4_.length : 0);
         if(_loc2_ > 0 && _loc2_ == _loc6_)
         {
            _loc7_ = new Map();
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc7_.add(_loc3_[_loc5_],_loc4_[_loc5_]);
               _loc5_++;
            }
         }
         return _loc7_;
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(§_-2xT§.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            §_-2xT§.push(param1);
         }
         if(§_-2jm§[param1] != param2)
         {
            §_-2jm§[param1] = param2;
            §_-19f§ = §_-19f§ + 1;
         }
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(§_-Dm§.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            §_-Dm§.push(param1);
         }
         if(§_-Rm§[param1] != param2)
         {
            §_-Rm§[param1] = param2;
            §_-19f§ = §_-19f§ + 1;
         }
      }
      
      public function setNumberArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(§_-3ta§.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            §_-3ta§.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is Number)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = §_-1cr§[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as Number != _loc5_[_loc7_] as Number)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         §_-1cr§[param1] = _loc6_;
         §_-19f§ = §_-19f§ + 1;
      }
      
      public function setStringArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(§_-3vV§.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            §_-3vV§.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is String)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = §_-2PH§[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as String != _loc5_[_loc7_] as String)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         §_-2PH§[param1] = _loc6_;
         §_-19f§ = §_-19f§ + 1;
      }
      
      public function §_-3hn§(param1:String, param2:Map, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         setStringArray("ROMC_MAP_KEYS_" + param1,param2.§_-Kz§(),param3);
         setStringArray("ROMC_MAP_VALUES_" + param1,param2.§_-21a§(),param3);
      }
      
      public function getUpdateID() : int
      {
         return §_-19f§;
      }
   }
}

