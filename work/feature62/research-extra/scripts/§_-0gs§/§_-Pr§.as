package §_-0gs§
{
   import §_-01y§.§_-0z5§;
   import §_-2C1§.§_-0Rb§;
   
   public class §_-Pr§ extends §_-0Rb§
   {
      
      private var _state:int;
      
      private var §_-0SL§:§_-0z5§ = null;
      
      private var §_-3am§:Number = NaN;
      
      public function §_-Pr§(param1:int, param2:§_-0z5§, param3:Number = NaN)
      {
         super(null,null);
         _state = param1;
         §_-0SL§ = param2;
         §_-3am§ = param3;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get data() : §_-0z5§
      {
         return §_-0SL§;
      }
      
      public function get extra() : Number
      {
         return §_-3am§;
      }
   }
}

