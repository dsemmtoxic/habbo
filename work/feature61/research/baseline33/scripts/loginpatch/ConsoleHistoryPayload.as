package loginpatch
{
   import §_-0tl§.§_-15i§;
   
   public final class ConsoleHistoryPayload implements §_-15i§
   {
      
      private var _payload:Array;
      
      public function ConsoleHistoryPayload(chatId:int, beforeId:String)
      {
         super();
         _payload = [chatId,beforeId];
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

