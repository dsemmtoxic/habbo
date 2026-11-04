package loginpatch
{
   import flash.utils.Dictionary;
   
   public final class RoomIdentity30
   {
      
      private static var _rooms:Dictionary = new Dictionary(true);
      
      public function RoomIdentity30()
      {
         super();
      }
      
      public static function reset() : void
      {
         _rooms = new Dictionary(true);
      }
      
      public static function dropRoom(engine:Object, room:int) : void
      {
         var rooms:Object = _rooms[engine];
         if(rooms != null)
         {
            delete rooms[room];
         }
      }
      
      public static function seen(engine:Object, room:int, webId:int, index:int, userType:int) : void
      {
         if(engine == null || room < 0 || index < 0)
         {
            return;
         }
         var rooms:Object = _rooms[engine];
         if(rooms == null)
         {
            rooms = {};
            _rooms[engine] = rooms;
         }
         var state:Object = rooms[room];
         if(state == null)
         {
            state = {
               "byWeb":{},
               "byIndex":{}
            };
            rooms[room] = state;
         }
         var occupant:Object = state.byIndex[index];
         if(occupant != null && int(occupant) != webId)
         {
            delete state.byWeb[occupant];
            delete state.byIndex[index];
         }
         if(userType != 1 || webId <= 0)
         {
            return;
         }
         var current:Object = engine["_-46h"](room,index,100);
         if(current == null)
         {
            return;
         }
         var previous:Object = state.byWeb[webId];
         if(previous != null && int(previous.index) != index)
         {
            var old:Object = engine["_-46h"](room,int(previous.index),100);
            if(old != null && old === previous.object)
            {
               engine["_-1t9"](room,int(previous.index));
            }
            delete state.byIndex[int(previous.index)];
         }
         state.byWeb[webId] = {
            "index":index,
            "object":current
         };
         state.byIndex[index] = webId;
      }
   }
}

