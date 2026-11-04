package loginpatch
{
   import §_-0tl§.§_-15i§;
   
   public final class WiredPayloadTrigger implements §_-15i§
   {
      
      private var _payload:Array;
      
      public function WiredPayloadTrigger(payload:Array)
      {
         super();
         _payload = payload;
      }
      
      public function §_-0tq§() : Array
      {
         return _payload;
      }
      
      public function dispose() : void
      {
         _payload = null;
      }
      
      public function get disposed() : Boolean
      {
         return _payload == null;
      }
   }
}

