package loginpatch {
 import flash.display.BitmapData;
 import starling.display.Image;
 import starling.display.Sprite;
 import starling.textures.Texture;

 public final class Portrait74 extends Sprite {
  private var _renderer:Object;
  private var _figure:String;
  private var _part:String;
  private var _direction:int;
  private var _width:Number;
  private var _height:Number;
  private var _bitmap:BitmapData;
  private var _texture:Texture;
  private var _image:Image;
  private var _disposed:Boolean;

  public function Portrait74(renderer:Object,figure:String,part:String,direction:int,w:Number,h:Number) {
   _renderer=renderer;
   _figure=figure;
   _part=part;
   _direction=direction;
   _width=w;
   _height=h;
   touchable=false;
   refresh();
  }

  public function get disposed():Boolean {return _disposed;}

  // The build binds this callback to the native avatar renderer interface.
  public function avatarReady(figure:String):void {
   if(figure==_figure)refresh();
  }

  private function refresh():void {
   if(_disposed||_renderer==null||_figure==null||_figure.length==0)return;
   var avatar:Object=_renderer["_-4QF"](_figure,"h",null,this);
   if(avatar==null)return;
   var bitmap:BitmapData;
   var mirrored:Boolean;
   try {
    if(avatar.isPlaceholder())return;
    avatar.setDirection("full",_direction);
    avatar["_-3fO"]();
    avatar["_-3cz"]();
    bitmap=avatar["_-4Th"](_part) as BitmapData;
    mirrored=avatar["_-3Ub"]();
   } finally {
    avatar.dispose();
   }
   if(bitmap==null)return;
   releaseImage();
   _bitmap=bitmap;
   _texture=Texture.fromBitmapData(bitmap,false);
   _image=new Image(_texture);
   _image.smoothing="none";
   var scale:Number=Math.min(_width/bitmap.width,_height/bitmap.height,
     _part=="head"?_width/44:_height/100);
   _image.scaleX=mirrored?-scale:scale;
   _image.scaleY=scale;
   _image.x=Math.round((_width-bitmap.width*scale)/2)+(mirrored?bitmap.width*scale:0);
   _image.y=Math.round((_height-bitmap.height*scale)/2);
   addChild(_image);
  }

  private function releaseImage():void {
   if(_image!=null)_image.removeFromParent(true);
   if(_texture!=null)_texture.dispose();
   if(_bitmap!=null)_bitmap.dispose();
   _image=null;
   _texture=null;
   _bitmap=null;
  }

  override public function dispose():void {
   _disposed=true;
   _renderer=null;
   releaseImage();
   super.dispose();
  }
 }
}
