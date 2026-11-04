package loginpatch {
 import flash.display.Shape;
 import flash.display.BitmapData;
 import flash.geom.Matrix;
 import flash.filters.GlowFilter;
 import flash.text.TextFormat;
 import flash.utils.Dictionary;
 import starling.textures.Texture;
 import starling.display.Image;
 import starling.text.TextField;
 public final class ModernUI65 {
  private static var _buttons:Dictionary=new Dictionary(true);
  private static var _textures:Object={};
  private static var _bitmaps:Object={};
  public static function text(value:String,size:Number=24,color:uint=0xffffff,bold:Boolean=true):Object {
   var item:TextField=new TextField(1,1,value,"Ubuntu",size,color,bold);item.touchable=false;item.autoScale=true;item.hAlign="left";item.vAlign="center";item.nativeFilters=[new GlowFilter(0,0.95,3,3,5,2,false,false)];return item;
  }
  public static function format(item:Object,size:Number,color:uint=0xffffff,bold:Boolean=true):void {item.fontName="Ubuntu";item.fontSize=size;item.color=color;item.bold=bold;}
  private static function texture(w:int,h:int,color:uint,border:uint,alpha:Number,radius:Number,pressed:Boolean):Texture {
   w=Math.max(2,w);h=Math.max(2,h);var key:String=w+":"+h+":"+color+":"+border+":"+alpha+":"+radius+":"+pressed;
   if(_textures[key]!=null)return _textures[key] as Texture;
   var shape:Shape=new Shape();var matrix:Matrix=new Matrix();matrix.createGradientBox(w,h,Math.PI/2);
   shape.graphics.lineStyle(1,border,0.65,true);var shade:uint=pressed?uint((color&0xfefefe)>>1):color;
   shape.graphics.beginGradientFill("linear",[color,shade],[alpha,alpha],[0,255],matrix);shape.graphics.drawRoundRect(1,1,w-2,h-2,radius*2,radius*2);shape.graphics.endFill();
   var bitmap:BitmapData=new BitmapData(w,h,true,0);bitmap.draw(shape);var result:Texture=Texture.fromBitmapData(bitmap,false);_bitmaps[key]=bitmap;_textures[key]=result;return result;
  }
  public static function paint(button:Object,w:Number,h:Number,kind:String="glass",selected:Boolean=false,color:uint=0):void {
   var border:uint=selected?0xffffff:0xc9dae8;var fill:uint=kind=="primary"?0x2f8af5:kind=="color"?color:kind=="tab"?(selected?0x326bdd:0x18263d):0x18263d;var alpha:Number=kind=="glass"?0.50:kind=="tab"?(selected?0.85:0.32):1;
   var radius:Number=kind=="color"?7:12;var key:String=Math.round(w)+":"+Math.round(h)+":"+kind+":"+selected+":"+color;
   if(_buttons[button]==key)return;_buttons[button]=key;button.validate();button.stateToSkinFunction=null;button.minWidth=button.minHeight=0;button.padding=4;if(kind=="color")button.defaultIcon=null;
   button.defaultSkin=new Image(texture(Math.round(w),Math.round(h),fill,border,alpha,radius,false));button.downSkin=new Image(texture(Math.round(w),Math.round(h),fill,border,alpha,radius,true));button.defaultLabelProperties.textFormat=new TextFormat("Ubuntu",Math.max(14,h*0.32),0xffffff,true);button.defaultLabelProperties.embedFonts=true;
  }
  public static function swatch(button:Object,color:uint,selected:Boolean):void {paint(button,Number(button.width),Number(button.height),"color",selected,color);}
  public static function release(button:Object):void {delete _buttons[button];}
 }
}
