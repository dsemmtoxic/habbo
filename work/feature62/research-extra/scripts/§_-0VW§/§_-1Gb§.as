package §_-0VW§
{
   import §_-01y§.§_-0z5§;
   import §_-0tl§.§_-41a§;
   import §_-1iL§.§_-K-§;
   import §_-1iL§.§_-va§;
   
   public class §_-1Gb§ extends §_-45P§ implements §_-0z5§
   {
      
      public static const §_-463§:int = 5;
      
      private static const §_-0Mm§:int = 0;
      
      private var §_-0SL§:Array = [];
      
      public function §_-1Gb§()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:§_-41a§) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         §_-0SL§ = [];
         var _loc2_:int = param1.§_-0u0§();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.§_-0u0§();
            §_-0SL§.push(_loc4_);
            _loc3_++;
         }
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:§_-va§) : void
      {
         super.initializeFromRoomObjectModel(param1);
         §_-0SL§ = param1.getNumberArray("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:§_-K-§) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",5);
         param1.setNumberArray("furniture_data",§_-0SL§);
      }
      
      override public function getLegacyString() : String
      {
         if(!§_-0SL§)
         {
            return "";
         }
         return §_-0SL§[0];
      }
      
      public function getValue(param1:int) : int
      {
         if(§_-0SL§ && param1 < §_-0SL§.length)
         {
            return §_-0SL§[param1];
         }
         return -1;
      }
      
      public function §_-4IF§(param1:Array) : void
      {
         §_-0SL§ = param1;
      }
      
      override public function compare(param1:§_-0z5§) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:§_-1Gb§ = param1 as §_-1Gb§;
         if(!_loc2_)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < §_-0SL§.length)
         {
            if(_loc3_ != 0)
            {
               if(§_-0SL§[_loc3_] != _loc2_.getValue(_loc3_))
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return true;
      }
   }
}

