package loginpatch {
 import starling.display.Quad;
 public final class DoorQuad68 extends Quad {
  public function DoorQuad68(points:Array) {
   super(1,1,0xffffff);
   for(var i:int=0;i<4;i++)mVertexData.setPosition(i,Number(points[i*2]),Number(points[i*2+1]));
   onVertexDataChanged();touchable=false;
  }
 }
}
