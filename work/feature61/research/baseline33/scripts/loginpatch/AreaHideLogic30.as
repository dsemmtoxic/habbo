package loginpatch
{
   import §_-0AB§.§_-4hO§;
   import §_-0gs§.§_-Pr§;
   import §_-0sg§.§_-1Zo§;
   import §_-2C1§.§_-0Rb§;
   import §_-2RC§.§_-02u§;
   import §_-2mk§.§_-2NW§;
   
   public class AreaHideLogic30 extends §_-2NW§
   {
      
      public function AreaHideLogic30()
      {
         super();
      }
      
      override public function processUpdateMessage(message:§_-0Rb§) : void
      {
         super.processUpdateMessage(message);
         if(message is §_-Pr§)
         {
            AreaHide30.syncObject(object);
         }
      }
      
      override public function useObject() : void
      {
         HabboTicketLogin.openAreaHide30(object);
      }
      
      override public function mouseEvent(event:§_-02u§, geometry:§_-4hO§) : void
      {
         if(event == null || geometry == null || object == null)
         {
            return;
         }
         if(event.type == "doubleClick")
         {
            if(event.spriteTag == "turn_on" || event.spriteTag == "turn_off")
            {
               if(eventDispatcher != null)
               {
                  eventDispatcher.dispatchEvent(new §_-1Zo§("ROSCE_STATE_CHANGE",object));
               }
            }
            else
            {
               useObject();
            }
         }
         else
         {
            super.mouseEvent(event,geometry);
         }
      }
      
      override public function tearDown() : void
      {
         AreaHide30.removeObject(object);
         super.tearDown();
      }
   }
}

