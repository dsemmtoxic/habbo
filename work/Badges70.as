package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getTimer;
 import flash.utils.setTimeout;
 import flash.utils.clearTimeout;
 public final class Badges70 {
  private static var _connections:Dictionary=new Dictionary(true);
  private static var _selectors:Dictionary=new Dictionary(true);
  private static function notice(key:String):void {var A:Class=ClientTheme63.klass("_-2xS::Alert");A.show(Text68.get(key),Text68.get("Emblemas"));}
  private static function entry(slot:Object):Object {
   if(slot==null||!slot.badgeEditable70)return null;var communication:Object=slot.badgeCommunication70;var manager:Object=slot.badgeManager70;if(communication==null||communication.connection==null||manager==null)return null;
   var state:Object=_connections[communication];if(state==null){var C:Class=ClientTheme63.klass("_-1jR::_-4kW");var event:Object=new C(received);state={communication:communication,manager:manager,event:event,loading:false,loaded:false,last:-10000,timer:0,fragments:{},count:0,total:0,badges:null,pending:null};_connections[communication]=state;communication["_-2jM"](event);}return state;
  }
  public static function prepare(slot:Object,editable:Boolean):void {if(!editable)return;var state:Object=entry(slot);if(state!=null)request(state);}
  private static function request(state:Object):void {
   if(state.loading||getTimer()-int(state.last)<5000)return;state.last=getTimer();state.loading=true;state.fragments={};state.count=0;state.total=0;
   var M:Class=ClientTheme63.klass("_-44B::Map");if(state.badges!=null)state.badges.dispose();state.badges=new M();
   var C:Class=ClientTheme63.klass("loginpatch::BadgesQuery70");if(!state.communication.connection.send(new C())){timeout(state);return;}
   state.timer=setTimeout(timeout,10000,state);
  }
  public static function wait(selector:Object,image:Object,index:int):Boolean {
   if(selector==null)return false;var slot:Object=selector.badgeSlot70;var state:Object=entry(slot);if(state==null)return false;
   var codes:Object=state.manager["_-0FE"];if(codes!=null&&codes.length>0)return false;
   if(state.loaded&&!state.loading){notice("Você ainda não tem emblemas.");return true;}
   state.pending={selector:selector,image:image,index:index};_selectors[selector]=state;request(state);return true;
  }
  public static function received(event:Object):void {
   var state:Object=null;for each(var candidate:Object in _connections)if(candidate.event===event){state=candidate;break;}if(state==null||!state.loading||event.getParser()==null)return;
   var parser:Object=event.getParser();var total:int=Math.max(1,int(parser["_-0m6"]));var index:int=int(parser["_-10A"]);if(index<0||index>=total)return;
   if(state.total!=0&&int(state.total)!=total)return;state.total=total;var fragment:Object=parser["_-4Iq"];if(fragment==null)return;
   var keys:Array=fragment["_-Kz"]();for each(var code:String in keys)state.badges.add(code,fragment.getValue(code));
   var key:String=index.toString();if(state.fragments[key]!==true){state.fragments[key]=true;state.count++;}if(int(state.count)<total)return;
   state.loading=false;state.loaded=true;if(state.timer!=0)clearTimeout(uint(state.timer));state.timer=0;
   var all:Array=state.badges["_-Kz"]();var codes:Vector.<String> = new Vector.<String>();for each(var badge:String in all)codes.push(badge);
   state.manager["_-41D"](state.badges,codes);state.badges=null;
   var pending:Object=state.pending;state.pending=null;if(pending!=null){delete _selectors[pending.selector];if(pending.image!=null&&pending.image.stage!=null)pending.selector["_-4AP"](pending.image,int(pending.index));}
  }
  public static function timeout(state:Object):void {if(state==null||!state.loading)return;state.timer=0;state.loading=false;state.last=-10000;var pending:Object=state.pending;state.pending=null;if(pending!=null){delete _selectors[pending.selector];notice("Não foi possível carregar os emblemas. Tente novamente.");}}
  public static function touch(slot:Object,event:Object,items:Object):void {
   if(slot==null||event==null||items==null||event.currentTarget==null||event.touches==null)return;var ended:Boolean=false;for each(var touch:Object in event.touches)if(touch.phase=="ended")ended=true;if(!ended)return;
   var image:Object=event.currentTarget;var index:int=int(items.getChildIndex(image));if(index<0||index>=5)return;var code:String=image.name;
   if(slot.badgeEditable70&&(code==null||code.length==0))slot["_-1Ge"]["_-4AP"](image,index);else if(code!=null&&code.length>0)slot.badgeInfo70(code,image,Boolean(slot.badgeEditable70));
  }
  public static function releaseSelector(selector:Object):void {var state:Object=_selectors[selector];if(state!=null&&state.pending!=null&&state.pending.selector===selector)state.pending=null;delete _selectors[selector];}
  public static function releaseSlot(slot:Object):void {for(var selector:Object in _selectors)if(selector.badgeSlot70===slot)releaseSelector(selector);}
  public static function reset():void {
   for each(var state:Object in _connections){if(state.timer!=0)clearTimeout(uint(state.timer));state.communication["_-21R"](state.event);if(state.badges!=null)state.badges.dispose();}
   _connections=new Dictionary(true);_selectors=new Dictionary(true);
  }
 }
}
