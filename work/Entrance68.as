package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getDefinitionByName;
 import starling.display.Sprite;
 public final class Entrance68 {
  private static var _masks:Dictionary=new Dictionary(true);
  public static function update(canvas:Object):void {
   if(canvas==null)return;var layer:Object=canvas.entryLayer68;var view:Object=canvas.entryView68;var geometry:Object=canvas.geometry;
   if(layer==null||view==null||geometry==null||layer.parent==null||!canvas.entryEnabled68){release(canvas);return;}
   var openings:Array=RoomEntry65.openings68(view);if(openings.length==0){release(canvas);return;}
   var V:Class=getDefinitionByName("_-0AB::Vector3d") as Class;var polygons:Array=[];var key:String="";
   for each(var state:Object in openings)for each(var hole:Array in state.holes){
    var points:Array=[];
    for each(var uv:Array in [[hole[0],hole[2]],[hole[1],hole[2]],[hole[0],hole[3]],[hole[1],hole[3]]]){
     var u:Number=Number(uv[0]);var v:Number=Number(uv[1]);
     var world:Object=new V(Number(state.origin[0])+u*Number(state.left[0])+v*Number(state.right[0]),Number(state.origin[1])+u*Number(state.left[1])+v*Number(state.right[1]),Number(state.origin[2])+u*Number(state.left[2])+v*Number(state.right[2]));
     var point:Object=geometry["_-49b"](world);if(point==null){release(canvas);return;}
     var x:Number=Number(point.x)+Number(canvas.entryOffsetX68);var y:Number=Number(point.y)+Number(canvas.entryOffsetY68);
     if(!isFinite(x)||!isFinite(y)){release(canvas);return;}
     points.push(x,y);key+=x.toFixed(3)+","+y.toFixed(3)+";";
    }
    polygons.push(points);
   }
   var old:Object=_masks[canvas];if(old!=null&&old.key==key){if(old.mask.parent!==layer.parent)layer.parent.addChild(old.mask);return;}
   release(canvas);var mask:Sprite=new Sprite();mask.name="doorOpeningMask68";mask.touchable=false;
   for each(points in polygons)mask.addChild(new DoorQuad68(points));
   layer.parent.addChild(mask);layer.mask=mask;_masks[canvas]={layer:layer,mask:mask,key:key};
  }
  public static function release(canvas:Object):void {var state:Object=_masks[canvas];if(state==null)return;state.layer.mask=null;state.mask.removeFromParent(true);delete _masks[canvas];}
 }
}
