package loginpatch {
 import flash.utils.getDefinitionByName;
 import flash.utils.Dictionary;
 import flash.text.TextFormat;
 import starling.core.Starling;
 import starling.display.Image;
 public final class ClientTheme63 {
  private static var _paints:Dictionary=new Dictionary(true);
  private static var _switches:Dictionary=new Dictionary(true);
  private static var _frames:Dictionary=new Dictionary(true);
  public static function klass(name:String):Class {return getDefinitionByName(name) as Class;}
  private static function displayText(value:String):String{return klass("loginpatch::Text68").get(value);}
  public static function scale():Number {return Math.max(0.65,Math.min(1.3,Starling.current.stage.stageHeight/680,Starling.current.stage.stageWidth/440));}
  public static function skin(asset:String):Object {var T:Class=klass("HitchTheme");return T.skin63(asset);}
  public static function group():Object {var C:Class=klass("_-2xS::LayoutGroup");var g:Object=new C();g.styleNameList.add("alternate-blue-with-border-bg");return g;}
  public static function frame(group:Object):void {
   var inset:Number=Math.max(6,7*scale());var fill:Object=_frames[group];
   if(fill==null){group.validate();group.backgroundSkin=skin("callout-background-skin-blue");group.backgroundSkin.touchable=false;fill=skin("infostand_background-skin");fill.touchable=false;group.addChildAt(fill,0);_frames[group]=fill;}
   box(fill,inset,inset,group.width-inset*2,group.height-inset*2);
  }
  public static function releaseFrame(group:Object):void {if(group!=null)delete _frames[group];}
  public static function text(value:String,size:Number=20,color:uint=0xe6edf0,bold:Boolean=false):Object {
   var C:Class=klass("_-2xS::_-Fk");var item:Object=new C();item.validate();item.text=displayText(value);item.wordWrap=true;item.touchable=false;format(item,size,color,bold);return item;
  }
  public static function format(item:Object,size:Number,color:uint,bold:Boolean=false):void {
   item.textRendererProperties.textFormat=new TextFormat(bold?"UbuntuBold":"Ubuntu",size,color);item.textRendererProperties.embedFonts=true;
  }
  public static function box(item:Object,x:Number,y:Number,w:Number,h:Number):void {item.x=Math.round(x);item.y=Math.round(y);item.width=Math.max(1,Math.round(w));item.height=Math.max(1,Math.round(h));}
  public static function button(value:String,action:Function,kind:String="blue"):Object {
   var C:Class=klass("_-2xS::Button");var b:Object=new C();b.label=displayText(value);if(action!=null)b.addEventListener("triggered",action);paint(b,kind);return b;
  }
  public static function paint(b:Object,kind:String="blue",size:Number=20):void {
   var previous:Object=_paints[b];if(previous!=null&&previous.kind==kind&&Number(previous.size)==size)return;_paints[b]={kind:kind,size:size};
   b.validate();b.stateToSkinFunction=null;b.minWidth=b.minHeight=0;b.padding=6;
   var stem:String=kind=="green"?"button":kind=="red"?"button-danger":"button-blue";
   b.defaultSkin=skin(stem+"-up-skin");b.downSkin=skin(stem+"-down-skin");
   b.defaultLabelProperties.textFormat=new TextFormat("UbuntuBold",size,0xffffff);b.defaultLabelProperties.embedFonts=true;
  }
  public static function icon(asset:String):Object {var T:Class=klass("HitchTheme");var i:Image=new Image(T.getTexture(asset));i.touchable=false;i.smoothing="none";return i;}
  public static function settings(action:Function):Object {var b:Object=button("",action);b.defaultIcon=icon("settings_small");return b;}
  public static function close(action:Function):Object {var b:Object=button("",action,"red");b.defaultIcon=icon("check_invalid");return b;}
  public static function switchState(b:Object,on:Boolean,size:Number=18):void {
   paint(b,on?"green":"red",size);if(_switches[b]===on)return;_switches[b]=on;b.label=on?"ON":"OFF";b.defaultIcon=icon("toggle_round_dark_button_up");b.defaultIcon.width=size*1.55;b.defaultIcon.height=size*1.62;b["_-e5"]=on?"right":"left";b.gap=8;
  }
  public static function popup(root:Object,modal:Boolean=true):void {var P:Class=klass("_-u8::_-1OE");P["_-3Dk"](root,modal,false);}
 }
}
