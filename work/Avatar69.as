package loginpatch {
 public final class Avatar69 {
  public static function filterHits(hits:Object):void {if(hits==null)return;for(var i:int=int(hits.length)-1;i>=0;i--)if(hits[i]!=null&&int(hits[i]["_-3YM"]())==100)hits.splice(i,1);}
  public static function longPress(hits:Object,desktop:Object,point:Object,session:Object):Boolean {
   if(hits==null||desktop==null||session==null||Boolean(session["_-3f-"]))return false;
   for(var i:int=0;i<int(hits.length);i++)if(hits[i]!=null&&int(hits[i]["_-3YM"]())==100){desktop["_-QW"](hits,point);return true;}return false;
  }
  public static function ignore(event:Object,engine:Object):Boolean {return event!=null&&engine!=null&&int(engine["_-3bO"](String(event["_-1eT"])))==100;}
  public static function menu(items:Object):void {
   if(items==null)return;var C:Class=ClientTheme63.klass("_-1mZ::_-20D");var item:Object=new C(69001);item.action="click69";item.localization=Text68.get("Clicar");items.push(item);
  }
  public static function action(event:Object,context:Object,userId:int):Boolean {
   if(event==null||event.data==null||event.data.action!="click69")return false;
   if(context==null||context.disposed||context.roomEngine==null||context.communication.connection==null)return true;
   var engine:Object=context.roomEngine;var room:int=int(engine["_-0Y"]);var session:Object=context["_-4Ej"].getSession(room);if(session==null||session.disposed)return true;
   var user:Object=session["_-2gp"]["_-0ju"](userId);if(user==null||int(user.type)!=1||int(user["_-Oi"])==int(session["_-4kZ"]))return true;
   var index:int=int(user["_-Oi"]);var avatar:Object=engine["_-46h"](room,index,100);if(avatar==null)return true;
   var C:Class=ClientTheme63.klass("loginpatch::UserClick69");context.communication.connection.send(new C(index));
   var L:Class=ClientTheme63.klass("_-0Wy::_-3CN");var location:Object=avatar.getLocation();context.communication.connection.send(new L(int(location.x),int(location.y)));return true;
  }
 }
}
