package loginpatch {
 import flash.utils.Dictionary;
 import starling.core.Starling;
 import starling.display.Image;
 public final class ChatStyles70 {
  private static var _root:Object;
  private static var _body:Object;
  private static var _title:Object;
  private static var _close:Object;
  private static var _input:Object;
  private static var _choices:Dictionary=new Dictionary(true);
  public static function open(input:Object):void {
   close(null);if(input==null||input.chatStyleDisposed70)return;var data:Object=input.chatStyleItems70;if(data==null||data.length==0)return;
   _input=input;_root=ClientTheme63.group();_root.name="chatStyles70";
   _title=ClientTheme63.text("Estilos de balão",27,0xffffff,true);_root.addChild(_title);
   _close=ClientTheme63.close(close);_root.addChild(_close);
   var C:Class=ClientTheme63.klass("_-2xS::_-4Mu");_body=new C();_body.horizontalScrollPolicy="off";_body.verticalScrollPolicy="auto";_root.addChild(_body);
   var current:Object=input.chatCurrentStyle70;
   for(var i:int=0;i<int(data.length);i++){
    var style:Object=data.getItemAt(i);if(style==null)continue;var selected:Boolean=current!=null&&int(current["_-0U8"])==int(style["_-0U8"]);
    var button:Object=ClientTheme63.button("",choose,selected?"green":"blue");button.name="chatStyle70_"+int(style["_-0U8"]);button.padding=0;
    if(style.selectorPreview!=null){var icon:Image=new Image(style.selectorPreview);icon.touchable=false;button.defaultIcon=icon;}
    _choices[button]={style:style,index:i};_body.addChild(button);
   }
   ClientTheme63.popup(_root,true);Starling.current.stage.addEventListener("resize",resize);resize(null);
  }
  public static function resize(event:Object):void {
   if(_root==null)return;var u:Number=ClientTheme63.scale();var sw:Number=Starling.current.stage.stageWidth;var sh:Number=Starling.current.stage.stageHeight;
   var w:Number=Math.min(1380*u,sw-32*u);var h:Number=Math.min(630*u,sh-32*u);_root.width=w;_root.height=h;_root.x=Math.round((sw-w)/2);_root.y=Math.round((sh-h)/2);
   ClientTheme63.box(_title,24*u,17*u,w-110*u,42*u);ClientTheme63.format(_title,27*u,0xffffff,true);ClientTheme63.box(_close,w-64*u,12*u,48*u,45*u);
   ClientTheme63.box(_body,20*u,76*u,w-40*u,h-96*u);var gap:Number=12*u;var columns:int=Math.max(1,int((_body.width+gap)/(150*u+gap)));var cw:Number=(_body.width-gap*(columns-1))/columns;var ch:Number=72*u;
   for(var b:Object in _choices){var state:Object=_choices[b];var at:int=int(state.index);ClientTheme63.box(b,(at%columns)*(cw+gap),int(at/columns)*(ch+gap),cw,ch);
    var image:Object=b.defaultIcon;if(image!=null){var ratio:Number=Math.min((cw-24*u)/image.texture.width,(ch-22*u)/image.texture.height);image.width=image.texture.width*ratio;image.height=image.texture.height*ratio;}
   }
   ClientTheme63.frame(_root);
  }
  public static function choose(event:Object):void {var state:Object=_choices[event.currentTarget];if(state==null||_input==null||_input.chatStyleDisposed70)return;var input:Object=_input;var style:Object=state.style;close(null);input.chatPickStyle70(style);}
  public static function release(input:Object):void {if(input===_input)close(null);}
  public static function close(event:Object):void {
   if(_root!=null){Starling.current.stage.removeEventListener("resize",resize);ClientTheme63.releaseFrame(_root);_root.removeFromParent(true);}
   _root=_body=_title=_close=_input=null;_choices=new Dictionary(true);
  }
 }
}
