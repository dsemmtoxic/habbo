package loginpatch {
 import flash.utils.Dictionary;

 public final class AvatarClick78 {
  private static const targets:Dictionary = new Dictionary(true);

  public static function remember(peer:Object, context:Object, index:int, userId:int):void {
   delete targets[peer];
   var session:Object = activeSession(context);
   if (session == null || index < 0 || index == int(session["_-4kZ"])) return;
   targets[peer] = {session: session, index: index, userId: userId};
  }

  public static function composer(peer:Object, context:Object):UserClick69 {
   var target:Object = targets[peer];
   var session:Object = activeSession(context);
   if (target == null || session == null || session !== target.session) return null;

   // The room menu was built from the room's index-to-user mapping.
   // Check the slot still belongs to the same user before sending.
   var user:Object = session["_-2gp"]["_-0uJ"](target.index);
   if (user == null || int(user["_-1GP"]) != int(target.userId)) return null;
   return new UserClick69(int(target.index));
  }

  private static function activeSession(context:Object):Object {
   if (context == null || context.disposed) return null;
   var manager:Object = context["_-4Ej"];
   if (manager == null) return null;
   var session:Object = manager["_-4ke"]();
   return session == null || session.disposed ? null : session;
  }
 }
}
