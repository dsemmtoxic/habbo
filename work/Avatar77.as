package loginpatch {
 public final class Avatar77 {
  private static function target(context:Object, userId:int):Object {
   if (context == null || context.disposed || context.roomEngine == null) return null;
   var engine:Object = context.roomEngine;
   var room:int = int(engine["_-0Y"]);
   var session:Object = context["_-4Ej"].getSession(room);
   if (session == null || session.disposed) return null;
   var user:Object = session["_-2gp"]["_-0ju"](userId);
   if (user == null || int(user.type) != 1) return null;
   var index:int = int(user["_-Oi"]);
   if (index < 0 || index == int(session["_-4kZ"])) return null;
   return engine["_-46h"](room, index, 100);
  }

  public static function face(context:Object, userId:int):void {
   var avatar:Object = target(context, userId);
   if (avatar == null || context.roomEngine.connection == null) return;
   var location:Object = avatar.getLocation();
   if (location == null) return;
   var LookTo:Class = ClientTheme63.klass("_-0Wy::_-3CN");
   context.roomEngine.connection.send(new LookTo(int(location.x), int(location.y)));
  }

  public static function action(event:Object, context:Object, userId:int):Boolean {
   if (event == null || event.data == null || event.data.action != "click69") return false;
   var avatar:Object = target(context, userId);
   if (avatar == null || context.roomEngine.connection == null) return true;

   // Air Plus sends the clicked room object's ID. Do not send a LookTo after
   // this packet, since it can replace a turn performed by the Wired stack.
   context.roomEngine.connection.send(new UserClick69(int(avatar.getId())));
   return true;
  }
 }
}
