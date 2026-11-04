package §_-0Ee§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-Xq§;
   import §_-44B§.Map;
   
   public class §_-0WM§
   {
      
      private var _masks:Map = null;
      
      public function §_-0WM§()
      {
         super();
         _masks = new Map();
      }
      
      public function get §_-23s§() : int
      {
         return _masks.length;
      }
      
      public function dispose() : void
      {
         if(_masks != null)
         {
            reset();
            _masks.dispose();
            _masks = null;
         }
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc3_:int = 0;
         var _loc14_:XML = null;
         var _loc12_:String = null;
         var _loc5_:String = null;
         var _loc10_:Vector3d = null;
         var _loc13_:String = null;
         var _loc6_:XMLList = null;
         var _loc11_:XML = null;
         var _loc2_:§_-Jq§ = null;
         if(param1 == null)
         {
            return false;
         }
         _masks.reset();
         var _loc7_:Array = ["id","type","category"];
         var _loc8_:Array = ["x","y","z"];
         var _loc9_:XMLList = null;
         var _loc4_:XMLList = param1.planeMask;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length())
         {
            _loc14_ = _loc4_[_loc3_];
            if(!§_-Xq§.§_-2Sx§(_loc14_,_loc7_))
            {
               return false;
            }
            _loc12_ = _loc14_.@id;
            _loc5_ = _loc14_.@type;
            _loc10_ = null;
            _loc13_ = _loc14_.@category;
            _loc6_ = _loc14_.location;
            if(_loc6_.length() != 1)
            {
               return false;
            }
            _loc11_ = _loc6_[0];
            if(!§_-Xq§.§_-2Sx§(_loc11_,_loc8_))
            {
               return false;
            }
            _loc10_ = new Vector3d(Number(_loc11_.@x),Number(_loc11_.@y),Number(_loc11_.@z));
            _loc2_ = new §_-Jq§(_loc5_,_loc10_,_loc13_);
            _masks.add(_loc12_,_loc2_);
            _loc3_++;
         }
         return true;
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:§_-Jq§ = null;
         _loc1_ = 0;
         while(_loc1_ < _masks.length)
         {
            _loc2_ = _masks.§_-2DR§(_loc1_) as §_-Jq§;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            _loc1_++;
         }
         _masks.reset();
      }
      
      public function addMask(param1:String, param2:String, param3:§_-3gO§, param4:String) : void
      {
         var _loc5_:§_-Jq§ = new §_-Jq§(param2,param3,param4);
         _masks.remove(param1);
         _masks.add(param1,_loc5_);
      }
      
      public function §_-4BL§(param1:String) : Boolean
      {
         var _loc2_:§_-Jq§ = _masks.remove(param1) as §_-Jq§;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            return true;
         }
         return false;
      }
      
      public function §_-0k5§() : XML
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:XML = null;
         var _loc1_:§_-3gO§ = null;
         var _loc2_:XML = <planeMasks/>
			
			;
         _loc4_ = 0;
         while(_loc4_ < §_-23s§)
         {
            _loc5_ = §_-3Ou§(_loc4_);
            _loc6_ = §_-1f8§(_loc4_);
            _loc3_ = <planeMask id={_loc4_} type={_loc5_} category={_loc6_}/>
				;
            _loc1_ = §_-2uz§(_loc4_);
            if(_loc1_ != null)
            {
               _loc3_.appendChild(<location x={_loc1_.x} y={_loc1_.y} z={_loc1_.z}/> );
               _loc2_.appendChild(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function §_-2uz§(param1:int) : §_-3gO§
      {
         if(param1 < 0 || param1 >= §_-23s§)
         {
            return null;
         }
         var _loc2_:§_-Jq§ = _masks.§_-2DR§(param1) as §_-Jq§;
         if(_loc2_ != null)
         {
            return _loc2_.§_-UL§;
         }
         return null;
      }
      
      public function §_-3Ou§(param1:int) : String
      {
         if(param1 < 0 || param1 >= §_-23s§)
         {
            return null;
         }
         var _loc2_:§_-Jq§ = _masks.§_-2DR§(param1) as §_-Jq§;
         if(_loc2_ != null)
         {
            return _loc2_.type;
         }
         return null;
      }
      
      public function §_-1f8§(param1:int) : String
      {
         if(param1 < 0 || param1 >= §_-23s§)
         {
            return null;
         }
         var _loc2_:§_-Jq§ = _masks.§_-2DR§(param1) as §_-Jq§;
         if(_loc2_ != null)
         {
            return _loc2_.category;
         }
         return null;
      }
   }
}

