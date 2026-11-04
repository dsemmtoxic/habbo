package loginpatch {
 import flash.text.TextFormat;
 import starling.core.Starling;
 import starling.display.Sprite;

 public final class FriendLock74 {
  public static function mount(root:Object,ui:Object,renderer:Object,close:Function,
      left:String,right:String,date:String,leftFigure:String,rightFigure:String):void {
   var stage:Object=Starling.current.stage;
   root.width=stage.stageWidth;
   root.height=stage.stageHeight;
   var card:Sprite=new Sprite();
   var u:Number=Math.min(1.25*ClientTheme63.scale(),(stage.stageWidth-24)/375,(stage.stageHeight-24)/210);
   card.scaleX=card.scaleY=u;
   card.x=Math.round((stage.stageWidth-375*u)/2);
   card.y=Math.round((stage.stageHeight-210*u)/2);
   root.addChild(card);

   var Loader:Class=ClientTheme63.klass("_-2xS::_-1aX");
   var background:Object=new Loader();
   ClientTheme63.box(background,0,0,375,210);
   background.source=ui.getProperty("image.library.url")+"furniextras/loveLock_engraving.png";
   background.touchable=false;
   card.addChild(background);

   var first:Portrait74=new Portrait74(renderer,leftFigure,"full",2,70,115);
   first.x=115;
   first.y=7;
   card.addChild(first);
   var second:Portrait74=new Portrait74(renderer,rightFigure,"full",4,70,115);
   second.x=186;
   second.y=7;
   card.addChild(second);

   label(card,"${lovelock.engraving.caption}",65,124,245,"center");
   label(card,date,108,147,159,"center");
   label(card,left,21,172,148,"right");
   label(card,right,199,172,153,"left");

   var button:Object=ClientTheme63.close(close);
   var size:Number=ClientTheme63.scale();
   ClientTheme63.box(button,stage.stageWidth-72*size,12*size,60*size,48*size);
   root.addChild(button);
  }

  private static function label(card:Sprite,value:String,x:Number,y:Number,w:Number,align:String):void {
   var item:Object=ClientTheme63.text(Text68.clean(value==null?"":value),14,0x59224a,true);
   var format:TextFormat=new TextFormat("UbuntuBold",14,0x59224a);
   format.align=align;
   item.textRendererProperties.textFormat=format;
   ClientTheme63.box(item,x,y,w,22);
   card.addChild(item);
  }
 }
}
