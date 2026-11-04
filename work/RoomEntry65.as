package loginpatch {
 import flash.display.BitmapData;
 import flash.geom.Rectangle;
 import flash.utils.Dictionary;
 public final class RoomEntry65 {
  private static var _views:Dictionary=new Dictionary(true);
  private static var _geometry:Dictionary=new Dictionary(true);
  private static var _bounds:Dictionary=new Dictionary(true);
  private static var _entrances68:Dictionary=new Dictionary(true);
  public static function openings68(view:Object):Array {
   var map:Object=_entrances68[view];var result:Array=[];if(map==null)return result;
   for(var plane:Object in map)if(!plane.entryDisposed68&&plane.visible)result.push(map[plane]);return result;
  }
  public static function bind(view:Object,geometry:Object):void {if(view!=null&&geometry!=null)_views[view]=geometry;}
  private static function darkBounds(bitmap:BitmapData):Rectangle {
   var saved:Rectangle=_bounds[bitmap] as Rectangle;if(saved!=null)return saved;
   var left:int=bitmap.width;var right:int=-1;var top:int=bitmap.height;var bottom:int=-1;
   for(var y:int=0;y<bitmap.height;y++)for(var x:int=0;x<bitmap.width;x++){var pixel:uint=bitmap.getPixel32(x,y);if((pixel>>>24)>127&&(pixel>>16&255)<128){left=Math.min(left,x);right=Math.max(right,x);top=Math.min(top,y);bottom=Math.max(bottom,y);}}
   saved=right<left?new Rectangle():new Rectangle(left,top,right-left+1,bottom-top+1);_bounds[bitmap]=saved;return saved;
  }
  public static function configure(view:Object,plane:Object,geometry:Object):void {
   var oldMap:Object=_entrances68[view];if(oldMap!=null&&plane!=null)delete oldMap[plane];
   if(plane==null||int(plane.type)!=1||geometry==null)return;
   var roomGeometry:Object=_views[view];var masks:Array=plane.entryMasks65 as Array;var manager:Object=plane.entryMaskManager65;
   if(roomGeometry==null||masks==null||manager==null)return;
   var left:Object=plane["_-1Jd"];var right:Object=plane["_-4Gh"];var origin:Object=plane.location;if(left==null||right==null||origin==null||Number(left.length)<=0||Number(right.length)<=0)return;
   // The native 3D mask path uses half-scale plane dimensions before a 2D
   // texture exists (RoomPlane._-0WO), then reuses the allocated mask bitmap.
   var maskBitmap:BitmapData=plane.entryMaskBitmap65 as BitmapData;var width:int=maskBitmap!=null?maskBitmap.width:int(Number(left.length)*Number(roomGeometry.scale)/2);var height:int=maskBitmap!=null?maskBitmap.height:int(Number(right.length)*Number(roomGeometry.scale)/2);if(width<=0||height<=0)return;
   var holes:Array=[];
   for each(var mask:Object in masks){
    if(mask==null||String(mask.type)!="door")continue;var type:Object=manager["_-2Ey"]("door");if(type==null)continue;var asset:Object=type["_-1Xd"](Number(roomGeometry.scale),roomGeometry["_-1ke"](plane.normal));if(asset==null||asset.asset==null)continue;
    var bitmap:BitmapData=asset.asset.content as BitmapData;if(bitmap==null)continue;var bounds:Rectangle=darkBounds(bitmap);if(bounds.width<=0||bounds.height<=0)continue;
    var anchorX:int=int(width*(1-Number(mask["_-1W4"])/Number(left.length)));var anchorY:int=int(height*(1-Number(mask["_-4lf"])/Number(right.length)));
    var x0:Number=anchorX+Number(asset.offsetX)+(asset.flipH?bitmap.width-bounds.right:bounds.left);var x1:Number=x0+bounds.width;
    var y0:Number=anchorY+Number(asset.offsetY)+(asset.flipV?bitmap.height-bounds.bottom:bounds.top);var y1:Number=y0+bounds.height;
    var u0:Number=Math.max(0,1-x1/width);var u1:Number=Math.min(1,1-x0/width);var v0:Number=Math.max(0,1-y1/height);var v1:Number=Math.min(1,1-y0/height);
    if(u1-u0>0.00001&&v1-v0>0.00001)holes.push([u0,u1,v0,v1]);
   }
   if(holes.length==0)return;
   var state:Object={origin:[Number(origin.x),Number(origin.y),Number(origin.z)],left:[Number(left.x),Number(left.y),Number(left.z)],right:[Number(right.x),Number(right.y),Number(right.z)],quads:rectangles(holes),holes:holes};
   _geometry[geometry]=state;var entranceMap:Dictionary=_entrances68[view];if(entranceMap==null){entranceMap=new Dictionary(true);_entrances68[view]=entranceMap;}entranceMap[plane]=state;
  }
  public static function rectangles(holes:Array):Array {
   var us:Array=[0,1];var vs:Array=[0,1];for each(var h:Array in holes){for each(var u:Number in [Number(h[0]),Number(h[1])])if(u>0&&u<1&&us.indexOf(u)<0)us.push(u);for each(var v:Number in [Number(h[2]),Number(h[3])])if(v>0&&v<1&&vs.indexOf(v)<0)vs.push(v);}
   us.sort(Array.NUMERIC);vs.sort(Array.NUMERIC);var quads:Array=[];
   for(var i:int=0;i<us.length-1;i++)for(var j:int=0;j<vs.length-1;j++){var centerU:Number=(Number(us[i])+Number(us[i+1]))/2;var centerV:Number=(Number(vs[j])+Number(vs[j+1]))/2;var hidden:Boolean=false;for each(h in holes)if(centerU>Number(h[0])&&centerU<Number(h[1])&&centerV>Number(h[2])&&centerV<Number(h[3])){hidden=true;break;}if(!hidden)quads.push([Number(us[i]),Number(us[i+1]),Number(vs[j]),Number(vs[j+1])]);}
   return quads;
  }
  public static function build(geometry:Object,target:Object):Boolean {
   var state:Object=_geometry[geometry];if(state==null)return false;var quads:Array=state.quads;var stride:int=int(target.vertexStride);var vertices:Vector.<Number> =new Vector.<Number>(quads.length*4*stride,true);var indices:Vector.<uint> =new Vector.<uint>(quads.length*6,true);var vertex:int=0;var index:int=0;
   for each(var quad:Array in quads){var first:int=vertex;for each(var point:Array in [[quad[0],quad[2]],[quad[1],quad[2]],[quad[1],quad[3]],[quad[0],quad[3]]]){var u:Number=Number(point[0]);var v:Number=Number(point[1]);var offset:int=vertex++*stride;vertices[offset]=Number(state.origin[0])+u*Number(state.left[0])+v*Number(state.right[0]);vertices[offset+1]=(Number(state.origin[2])+u*Number(state.left[2])+v*Number(state.right[2]))*Math.sqrt(2/3);vertices[offset+2]=-(Number(state.origin[1])+u*Number(state.left[1])+v*Number(state.right[1]));}for each(var local:int in [0,1,2,0,2,3])indices[index++]=uint(first+local);}
   geometry.entryInvalidateUVs65();target["_-0AZ"](vertices);target["_-2I1"](indices);return true;
  }
  public static function uvs(geometry:Object,target:Object):Boolean {
   var state:Object=_geometry[geometry];if(state==null)return false;var stride:int=int(target.UVStride);var offset:int=int(target.UVOffset);var values:Vector.<Number> =target.UVData as Vector.<Number>;if(values==null||values.length!=state.quads.length*4*stride)return false;var index:int=0;
   for each(var quad:Array in state.quads)for each(var point:Array in [[quad[0],quad[2]],[quad[1],quad[2]],[quad[1],quad[3]],[quad[0],quad[3]]]){var at:int=index++*stride+offset;values[at]=1-Number(point[0]);values[at+1]=1-Number(point[1]);}
   target["_-0AZ"](values);return true;
  }
 }
}
