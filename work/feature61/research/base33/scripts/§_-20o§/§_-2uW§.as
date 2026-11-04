package §_-20o§
{
   import §_-309§.§_-4dL§;
   import flash.utils.getTimer;
   
   public class §_-2uW§
   {
      
      public static const §_-0Id§:int = 1;
      
      public static const §_-42P§:int = 2;
      
      public static const §_-7m§:int = 3;
      
      public static const §_-4UL§:int = 4;
      
      public static const §_-4j§:int = 5;
      
      private var _type:int;
      
      private var §_-4Aw§:int;
      
      private var §_-3i2§:String;
      
      private var §_-43c§:int;
      
      private var §_-2R9§:int;
      
      private var §_-4N0§:Boolean;
      
      public function §_-2uW§(param1:int, param2:int, param3:String, param4:int)
      {
         super();
         _type = param1;
         §_-4Aw§ = param2;
         §_-3i2§ = param3;
         §_-43c§ = param4;
         §_-2R9§ = getTimer();
      }
      
      public function get label() : String
      {
         return §_-3i2§;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get §_-0UP§() : int
      {
         return §_-4Aw§;
      }
      
      public function get message() : String
      {
         if(§_-4N0§)
         {
            return §_-4dL§.§_-4nr§(§_-4bn§.localization,§_-3y9§,".ago");
         }
         return §_-3i2§;
      }
      
      public function get §_-3y9§() : int
      {
         var _loc1_:int = (getTimer() - §_-2R9§) / 1000;
         return §_-43c§ + _loc1_;
      }
      
      public function set §_-2Vw§(param1:Boolean) : void
      {
         §_-4N0§ = param1;
      }
      
      public function §_-SD§(param1:String) : void
      {
         §_-3i2§ = param1 + "\n" + §_-3i2§;
      }
   }
}

