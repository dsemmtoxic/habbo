package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getTimer;
 public final class RoomUI68 {
  private static var _ends:Dictionary=new Dictionary(true);
  private static var _promoted:Dictionary=new Dictionary(true);
  private static var _details:Dictionary=new Dictionary(true);
  private static var _labels:Dictionary=new Dictionary(true);
  private static var _live:Object={};
  public static function capture(room:Object,source:Object=null):void {
   if(room==null||room.disposed||source!=null&&int(source["_-48W"])!=int(room["_-48W"]))return;var minutes:int=int(room["_-L9"]);
   _ends[room]=source!=null&&_ends[source]!=null?Number(_ends[source]):Number(getTimer())+Math.max(0,minutes)*60000;
  }
  public static function search(result:Object):void {if(result==null)return;var type:int=int(result["_-Xc"]);for each(var room:Object in result.rooms)_promoted[room]=type==16||type==17;}
  public static function listTitle(room:Object,label:Object):void {
   if(label==null)return;if(room==null){label.text="";return;}
   var name:String=String(room["_-2wn"]);label.text=_promoted[room]&&name.length>0?name:String(room.roomName);
  }
  public static function roomEvent(data:Object,currentRoom:Object):void {
   var id:int=data==null?(currentRoom==null?-1:int(currentRoom["_-48W"])):int(data["_-48W"]);if(id<0)return;
   _live[id]=data==null?{name:"",end:0}:{name:String(data.eventName),end:Number(getTimer())+Math.max(0,Number(data["_-kk"].time)-new Date().time)};
  }
  private static function info(room:Object):Object {
   if(room==null)return null;var live:Object=_live[int(room["_-48W"])];if(live!=null)return live;
   return {name:String(room["_-2wn"]),end:_ends[room]==null?Number(getTimer()):Number(_ends[room])};
  }
  public static function remaining(end:Number,now:Number):String {
   var total:int=Math.max(0,Math.floor((end-now)/60000));var hours:int=int(total/60);var minutes:int=total%60;
   return (hours<10?"0":"")+hours+"h"+(minutes<10?"0":"")+minutes+"min";
  }
  private static function unit(n:Number):Number {return ClientTheme63.klass("_-1N-::_-2mJ")["_-17E"](n);}
  private static function line(text:String,bold:Boolean=false):Object {var label:Object=ClientTheme63.text(text,unit(64),0xffffff,bold);label.wordWrap=false;label.textRendererProperties.wordWrap=false;return label;}
  public static function details(renderer:Object,room:Object,anchor:Object):void {
   if(renderer==null||anchor==null)return;var row:Object=_details[renderer];var state:Object;
   if(row==null){var C:Class=ClientTheme63.klass("_-2xS::LayoutGroup");row=new C();row.name="roomPromotion68";row.clipContent=true;row.touchable=false;state={prefix:line("",true),name:line(""),time:line("")};row.addChild(state.prefix);row.addChild(state.name);row.addChild(state.time);row.addEventListener("enterFrame",tick);renderer.addChild(row);_details[renderer]=row;_labels[row]=state;}
   state=_labels[row];state.room=room;state.last=-1;state.renderer=renderer;
   var A:Class=ClientTheme63.klass("_-2YJ::_-bQ");row.layoutData=A["_-2lz"](unit(14),0,NaN,0,anchor);row.height=unit(80);refresh(row);
  }
  private static function refresh(row:Object):void {
   var state:Object=_labels[row];if(state==null)return;var now:int=getTimer();var second:int=int(now/1000);var width:Number=Number(state.renderer.width);if(state.last==second&&state.width==width)return;state.last=second;state.width=width;
   var event:Object=info(state.room);var show:Boolean=event!=null&&String(event.name).length>0&&Number(event.end)>now;
   row.visible=row.includeInLayout=show;if(!show)return;
   state.prefix.text=Text68.get("Evento")+":";state.name.text=String(event.name);state.time.text=remaining(Number(event.end),now);
   state.prefix.validate();state.time.validate();var gap:Number=unit(14);row.width=width;
   state.prefix.x=state.prefix.y=state.name.y=state.time.y=0;state.name.x=state.prefix.width+gap;state.time.x=Math.max(state.name.x,width-state.time.width);
   state.name.width=Math.max(1,state.time.x-state.name.x-gap);state.name.height=row.height;
  }
  public static function tick(event:Object):void {refresh(event.currentTarget);}
  public static function release(renderer:Object):void {var label:Object=_details[renderer];if(label==null)return;label.removeEventListener("enterFrame",tick);delete _labels[label];delete _details[renderer];}
  public static function reset():void {_ends=new Dictionary(true);_promoted=new Dictionary(true);_live={};}
 }
}
