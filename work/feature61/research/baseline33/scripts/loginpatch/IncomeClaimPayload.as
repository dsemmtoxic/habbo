package loginpatch
{
   import §_-0tl§.§_-15i§;
   
   public final class IncomeClaimPayload implements §_-15i§
   {
      
      private var _category:int;
      
      public function IncomeClaimPayload(category:int)
      {
         super();
         _category = category;
      }
      
      public function §_-0tq§() : Array
      {
         return [_category];
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

