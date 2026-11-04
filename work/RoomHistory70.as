package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getTimer;
 public final class RoomHistory70 {
  private static var _dates:Dictionary=new Dictionary(true);
  private static var _rows:Dictionary=new Dictionary(true);
  public static function stamp(item:Object):void {if(item==null)return;var delay:Number=Number(getTimer())-Number(item.timeStamp);_dates[item]=new Date().time-(delay>=0?delay:0);}
  private static function two(n:int):String {return n<10?"0"+n:n.toString();}
  public static function text(item:Object):String {
   if(item==null||_dates[item]==null)return "";var d:Date=new Date(Number(_dates[item]));var now:Date=new Date();
   return two(d.date)+"/"+two(d.month+1)+(d.fullYear==now.fullYear?"":"/"+d.fullYear)+"\n"+two(d.hours)+":"+two(d.minutes);
  }
  public static function decorate(renderer:Object,item:Object,label:Object):void {
   if(renderer==null||label==null)return;var clock:Object=_rows[renderer];if(clock==null){clock=ClientTheme63.text("",16,0xb6c2ce);clock.name="roomChatTime70";clock.wordWrap=false;renderer.addChildAt(clock,0);_rows[renderer]=clock;}
   var value:String=text(item);clock.text=value;clock.visible=clock.includeInLayout=value.length>0;
   var format:Object=label.textRendererProperties.textFormat;var size:Number=format==null?24:Number(format.size);if(!isFinite(size)||size<=0)size=24;
   ClientTheme63.format(clock,Math.max(12,size*0.72),0xb6c2ce);clock.textRendererProperties.textFormat.align="right";clock.width=Math.ceil(Math.max(88,size*4.8));
   renderer.layout.gap=Math.max(12,size*0.65);renderer.layout.verticalAlign="top";
  }
  public static function release(renderer:Object):void {var clock:Object=_rows[renderer];if(clock!=null)clock.removeFromParent(true);delete _rows[renderer];}
  public static function reset():void {_dates=new Dictionary(true);for(var row:Object in _rows)release(row);_rows=new Dictionary(true);}
 }
}
