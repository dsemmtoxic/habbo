package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getTimer;
 import flash.utils.setTimeout;
 import flash.utils.clearTimeout;
 import flash.utils.getDefinitionByName;
 public final class Console61 {
  private static var _dates:Dictionary=new Dictionary(true);
  private static var _requests:Object={};
  private static var _renderers:Dictionary=new Dictionary(true);
  public static function stamp(message:Object,seconds:int):void{
   if(message!=null&&seconds>=0&&(int(message.type)==1||int(message.type)==2))_dates[message]=new Date().time-Number(seconds)*1000;
  }
  private static function two(n:int):String{return n<10?"0"+n:String(n);}
  public static function text(message:Object):String{
   return message==null?"":String(message.message);
  }
  public static function clock(message:Object):String {
   if(message==null||_dates[message]==null)return "";var date:Date=new Date(Number(_dates[message]));return two(date.hours)+":"+two(date.minutes);
  }
  private static function dayKey(date:Date):String {return date.fullYear+"-"+date.month+"-"+date.date;}
  public static function day(message:Object):String {
   if(message==null||_dates[message]==null)return "";var sent:Date=new Date(Number(_dates[message]));var now:Date=new Date();
   if(dayKey(sent)==dayKey(now))return "Hoje";var yesterday:Date=new Date(now.fullYear,now.month,now.date-1);if(dayKey(sent)==dayKey(yesterday))return "Ontem";
   return two(sent.date)+"/"+two(sent.month+1)+(sent.fullYear==now.fullYear?"":"/"+sent.fullYear);
  }
  public static function startsDay(renderer:Object,message:Object):Boolean {
   if(message==null||_dates[message]==null)return false;var owner:Object=renderer.owner;var data:Object=owner==null?null:owner.dataProvider;
   if(data==null)return true;for(var i:int=int(renderer.index)-1;i>=0;i--){var previous:Object=data.getItemAt(i);if(previous!=null&&_dates[previous]!=null)return dayKey(new Date(Number(_dates[previous])))!=dayKey(new Date(Number(_dates[message])));}
   return true;
  }
  public static function decorate(renderer:Object,message:Object):void {
   if(renderer==null)return;var label:Object=renderer.consoleText64;var bubble:Object=renderer.consoleBubble64;var state:Object=_renderers[renderer];
   var valid:Boolean=message!=null&&(int(message.type)==1||int(message.type)==2)&&_dates[message]!=null;
   if(!valid){if(state!=null){state.time.visible=state.badge.visible=state.badgeText.visible=false;label.y=state.paddingY;}bubble.y=0;return;}
   if(state==null){state={time:ClientTheme63.text("",16,0x39434f),badge:ClientTheme63.skin("background-transp-dark"),badgeText:ClientTheme63.text("",16,0xd2dce2),paddingY:Number(label.y),last:0,message:message,show:false,day:""};state.badge.touchable=false;state.badge.alpha=0.85;renderer.addChild(state.badge);renderer.addChild(state.badgeText);renderer.addChild(state.time);renderer.addEventListener("removedFromStage",rendererRemoved);renderer.addEventListener("enterFrame",refreshRenderer);_renderers[renderer]=state;}
   var u:Number=ClientTheme63.scale();var show:Boolean=startsDay(renderer,message);var top:Number=show?48*u:0;
   var format:Object=label.textRendererProperties.textFormat;var bodySize:Number=format==null?26*u:Number(format.size);if(!isFinite(bodySize)||bodySize<=0)bodySize=26*u;
   var timeSize:Number=Math.max(14*u,bodySize*0.60);var clockHeight:Number=Math.ceil(timeSize*1.45);var gap:Number=4*u;var padding:Number=Math.max(8*u,Number(label.x)-Number(bubble.x));
   var originalHeight:Number=Number(bubble.height);
   var textHeight:Number=Number(label.height);if(!isFinite(textHeight)||textHeight<=0)textHeight=bodySize*1.2;
   bubble.y=top;bubble.height=originalHeight+clockHeight+gap+2*u;label.y=top+Number(state.paddingY);state.message=message;state.show=show;state.day=day(message);
   state.time.text=clock(message);ClientTheme63.format(state.time,timeSize,int(message.type)==1?0xf8f9fc:0x39434f);state.time.textRendererProperties.textFormat.align="right";state.time.wordWrap=false;
   var clockWidth:Number=Math.max(66*u,Math.ceil(timeSize*3.3));
   ClientTheme63.box(state.time,Math.max(Number(bubble.x)+padding,Number(bubble.x)+Number(bubble.width)-padding-clockWidth),top+Number(state.paddingY)+textHeight+gap,clockWidth,clockHeight);
   state.time.visible=true;state.badge.visible=state.badgeText.visible=show;
   if(show){var badgeWidth:Number=Math.min(178*u,Number(renderer.width)-24*u);var left:Number=(Number(renderer.width)-badgeWidth)/2;ClientTheme63.box(state.badge,left,4*u,badgeWidth,32*u);state.badgeText.text=day(message);ClientTheme63.format(state.badgeText,16*u,0xd2dce2);state.badgeText.textRendererProperties.textFormat.align="center";ClientTheme63.box(state.badgeText,left+5*u,9*u,badgeWidth-10*u,24*u);}
   renderer.height=top+Number(bubble.height);
  }
  public static function rendererRemoved(event:Object):void {clearRenderer(event.currentTarget);}
  public static function refreshRenderer(event:Object):void {var renderer:Object=event.currentTarget;var state:Object=_renderers[renderer];if(state==null||getTimer()-int(state.last)<500)return;state.last=getTimer();if(Boolean(state.show)!=startsDay(renderer,state.message)||String(state.day)!=day(state.message))renderer.invalidate("data");}
  private static function clearRenderer(renderer:Object):void {var state:Object=_renderers[renderer];if(state==null)return;renderer.removeEventListener("removedFromStage",rendererRemoved);renderer.removeEventListener("enterFrame",refreshRenderer);renderer.consoleText64.y=state.paddingY;state.time.removeFromParent(true);state.badge.removeFromParent(true);state.badgeText.removeFromParent(true);delete _renderers[renderer];}
  public static function track(peer:int,state:Object,request:Function):void{
   var entry:Object=_requests[peer];
   if(entry==null||entry.state!==state){release(peer);entry={peer:peer,state:state,request:request,timer:0,automatic:0,retries:0};_requests[peer]=entry;}
   entry.request=request;
  }
  private static function active(entry:Object):Boolean{
   var state:Object=entry.state;
   return _requests[entry.peer]===entry&&state!=null&&state.more&&state.list!=null&&state.conversation!=null&&state.list.dataProvider===state.conversation.messages;
  }
  private static function issue(entry:Object,automatic:Boolean):void{
   if(!active(entry)||entry.state.pending)return;
   if(getTimer()-int(entry.state.last)<350){queue(entry,automatic);return;}
   entry.request(int(entry.peer),entry.state);
   if(automatic&&entry.state.pending)entry.automatic++;
  }
  private static function queue(entry:Object,automatic:Boolean):void{
   if(!active(entry)||entry.timer!=0||entry.state.pending)return;
   entry.timer=setTimeout(resume,400,entry,automatic);
  }
  private static function resume(entry:Object,automatic:Boolean):void{
   entry.timer=0;
   if(active(entry)&&entry.state.list.stage!=null)issue(entry,automatic);
  }
  public static function scrolled(event:Object):void{
   if(HabboTicketLogin.insertingConsoleHistory())return;
   for each(var entry:Object in _requests)if(entry.state.list===event.currentTarget){
    if(entry.state.loaded&&Number(entry.state.list.verticalScrollPosition)<=128)issue(entry,false);
    return;
   }
  }
  public static function received(peer:int):void{
   var entry:Object=_requests[peer];
   if(entry==null||!active(entry)||entry.state.pending||!entry.state.loaded||entry.automatic>=2)return;
   var list:Object=entry.state.list;
   if(Number(list.maxVerticalScrollPosition)<=Math.max(0,Number(list.height)*0.25)||Number(list.verticalScrollPosition)<=128)queue(entry,true);
  }
  public static function timeout(peer:int,state:Object):void{
   var entry:Object=_requests[peer];
   if(entry!=null&&entry.state===state&&!state.loaded&&!state.pending&&entry.retries<1){entry.retries++;queue(entry,false);}
  }
  public static function release(peer:int):void{
   var entry:Object=_requests[peer];if(entry!=null&&entry.timer!=0)clearTimeout(uint(entry.timer));delete _requests[peer];
  }
  public static function reset():void{
   for each(var entry:Object in _requests)if(entry.timer!=0)clearTimeout(uint(entry.timer));
   _requests={};_dates=new Dictionary(true);for(var renderer:Object in _renderers)clearRenderer(renderer);_renderers=new Dictionary(true);
  }
 }
}
