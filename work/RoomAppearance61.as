package loginpatch {
 import flash.utils.getDefinitionByName;
 import flash.utils.Dictionary;
 import starling.core.Starling;
 import starling.display.Quad;
 public final class RoomAppearance61 {
  private static var _desktop:Object;
  private static var _object:Object;
  private static var _room:int=-1;
  private static var _category:int=10;
  private static var _popup:Object;
  private static var _controls:Array=[];
  private static var _preview:Quad;
  private static var _status:Object;
  private static var _toggle:Object;
  private static var _coloredDesktop:Object;
  private static var _coloredView:Object;
  private static var _proxyColors:Dictionary=new Dictionary(true);
  private static var _viewColors:Dictionary=new Dictionary(true);
  private static var _gradientStates:Dictionary=new Dictionary(true);
  private static var _coloredGradient:Object;
  private static var _roomColors:Object={};
  private static var _roomOrder:Array=[];
  private static function klass(name:String):Class{return getDefinitionByName(name) as Class;}
  private static function unit(n:Number):Number{return n*Math.max(0.65,Starling.current.stage.stageHeight/720);}
  private static function label(value:String):Object{
   var C:Class=klass("_-2xS::_-Fk");var item:Object=new C();item.styleNameList.add("LABEL_M_CONDENSED_LIGHT_GRAY");item.text=value;item.wordWrap=true;return item;
  }
  private static function button(value:String,action:Function):Object{
   var C:Class=klass("_-2xS::Button");var item:Object=new C();item.label=value;item.styleNameList.add("alternate-blue-button");item.addEventListener("triggered",action);return item;
  }
  private static function column(gap:Number=8):Object{
   var U:Class=klass("_-2YJ::_-0iF");return U["_-3zA"](unit(gap));
  }
  public static function roomColor(desktop:Object,event:Object):Boolean{
   if(event==null||event.type!="ROHSLCEE_ROOM_BACKGROUND_COLOR")return false;
   var id:int=int(event.roomId);
   if(_roomColors[id]==null){_roomOrder.push(id);if(_roomOrder.length>2)delete _roomColors[int(_roomOrder.shift())];}
   _roomColors[id]={on:Boolean(event["_-1-v"]),h:int(event["_-fW"]),s:int(event["_-3Is"]),l:int(event["_-VZ"])};
   // Keep an early state until the desktop exists, and do not let disposal
   // of the previous room repaint the new room.
   return desktop!=null&&desktop["_-22-"]!=null&&int(desktop["_-22-"].roomId)!=id;
  }
  public static function mount(desktop:Object,view:Object,fallback:uint):void{
   klass("loginpatch::RoomLighting63").bind(desktop);ClientSettings63.bind(desktop);
   if(desktop==null||desktop["_-22-"]==null)return;
   var state:Object=_roomColors[int(desktop["_-22-"].roomId)];
   if(state!=null)desktop["_-YU"](state.on?int(state.h):0,state.on?int(state.s):0,state.on?int(state.l):0);
   else color(desktop,view,fallback);
  }
  public static function viewChanged(mode:int):void{
   if(mode!=1||_coloredDesktop==null||_coloredView==null)return;
   var session:Object=_coloredDesktop["_-22-"];
   if(session!=null&&!session.disposed)color(_coloredDesktop,_coloredView,uint(_coloredDesktop["_-2jo"]));
  }
  public static function recolor():void {if(_coloredDesktop!=null&&_coloredView!=null)color(_coloredDesktop,_coloredView,uint(_coloredDesktop["_-2jo"]));}
  public static function color(desktop:Object,view:Object,rgb:uint):void{
   if(view==null)return;
   if(desktop!=null&&desktop["_-22-"]!=null)rgb=klass("loginpatch::RoomLighting63").background(int(desktop["_-22-"].roomId),rgb);
   var ui:Object=desktop==null?null:desktop.habboUI;
   var context:Object=ui==null?null:ui.context;
   if(context!=null)context=context.root;
   var gradient:Object=context!=null&&"roomBackgroundRenderer62" in context?context.roomBackgroundRenderer62:null;
   if(gradient!=null){
    var current:Array=gradient.roomBackgroundState62 as Array;
    if(!(gradient in _gradientStates))_gradientStates[gradient]=current;
    if(uint(current[0])!=rgb||uint(current[1])!=rgb||String(current[2])!="colors")gradient.colors(rgb,rgb);
    _coloredGradient=gradient;
   }
   var proxy:Object=view.stage3DProxy;
   if(proxy!=null){
    if(!(proxy in _proxyColors))_proxyColors[proxy]=proxy.color;
    // HabboTabletMain clears the shared context through this proxy every
    // frame. Its color is ARGB; alpha must stay opaque for the room background.
    proxy.color=uint(0xff000000|(rgb&0xffffff));
   }
   if(view.renderer!=null){if(!(view in _viewColors))_viewColors[view]=view.backgroundColor;view.backgroundColor=rgb;}
   _coloredDesktop=desktop;_coloredView=view;
  }
  private static function allowed(desktop:Object):Boolean{
   if(desktop==null)return false;var session:Object=desktop["_-22-"];
   if(session==null||session.disposed)return false;
   if(Boolean(session["_-0lf"])||Boolean(session["_-1Ti"]))return true;
   var manager:Object=desktop.sessionDataManager;
   return manager!=null&&"isAnyRoomController" in manager&&Boolean(manager["isAnyRoomController"]);
  }
  private static function valid():Boolean{
   return allowed(_desktop)&&int(_desktop["_-22-"].roomId)==_room&&_object!=null&&_desktop.roomEngine.connection!=null&&_desktop.roomEngine["_-46h"](_room,int(_object.getId()),_category)===_object;
  }
  public static function request(desktop:Object,event:Object):Boolean {return klass("loginpatch::RoomLighting63").request(desktop,event);}
  public static function rgb(h:int,s:int,l:int):uint{
   var C:Class=klass("_-0AB::_-0By");return uint(C["_-1Bw"](((h&255)<<16)|((s&255)<<8)|(l&255)));
  }
  public static function changed(event:Object):void{
   if(_preview!=null&&_controls.length==3)_preview.color=rgb(int(_controls[0].value),int(_controls[1].value),int(_controls[2].value));
  }
  public static function save(event:Object):void{
   if(!valid()){close(null);return;}
   var C:Class=klass("_-26z::_-120");
   var sent:Boolean=Boolean(_desktop.roomEngine.connection.send(new C(int(_object.getId()),int(_controls[0].value),int(_controls[1].value),int(_controls[2].value))));
   _status.text=sent?"Configuração enviada.":"Não foi possível enviar a configuração.";
  }
  public static function toggle(event:Object):void{
   if(!valid()){close(null);return;}var C:Class=klass("_-3eU::_-3D8");_desktop.roomEngine.connection.send(new C(int(_object.getId())));
  }
  public static function refresh(event:Object):void{
   if(!valid()){close(null);return;}_toggle.label=int(_object.getState(0))==0?"Ligar":"Desligar";
  }
  public static function close(event:Object):void{
   if(_popup!=null){_popup.removeEventListener("enterFrame",refresh);_popup.removeFromParent(true);}
   _popup=null;_desktop=null;_object=null;_room=-1;_controls=[];_preview=null;_status=null;_toggle=null;
  }
  public static function release(desktop:Object):void{
   klass("loginpatch::RoomLighting63").release(desktop);ClientSettings63.release(desktop);
   if(_desktop===desktop)close(null);
   if(_coloredDesktop!==desktop)return;
   var view:Object=_coloredView;_coloredDesktop=null;_coloredView=null;
   var gradient:Object=_coloredGradient;_coloredGradient=null;
   if(gradient!=null&&gradient in _gradientStates){
    var previous:Array=_gradientStates[gradient] as Array;
    gradient.colors(uint(previous[0]),uint(previous[1]));gradient.mode=String(previous[2]);
    delete _gradientStates[gradient];
   }
   if(desktop!=null&&desktop["_-22-"]!=null)delete _roomColors[int(desktop["_-22-"].roomId)];
   if(view==null)return;var proxy:Object=view.stage3DProxy;
   if(proxy!=null&&proxy in _proxyColors){proxy.color=uint(_proxyColors[proxy]);delete _proxyColors[proxy];}
   if(view in _viewColors){if(view.renderer!=null)view.backgroundColor=uint(_viewColors[view]);delete _viewColors[view];}
  }
 }
}
