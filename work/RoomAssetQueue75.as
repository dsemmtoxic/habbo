package loginpatch {
 import flash.utils.Dictionary;

 public final class RoomAssetQueue75 {
  private static const MAX_VISUAL_LOADS:int=3;
  private static const _visual:Dictionary=new Dictionary(true);

  public static function markVisual(loader:Object):void {
   _visual[loader]=true;
  }

  public static function take(pending:Array,active:Array):Object {
   var firstVisual:int=-1;
   var i:int=0;
   while(i<pending.length){
    var loader:Object=pending[i];
    if(loader==null||loader.ready||loader.disposed){
     pending.splice(i,1);
     continue;
    }
    if(_visual[loader]!==true){
     pending.splice(i,1);
     return loader;
    }
    if(firstVisual<0)firstVisual=i;
    i++;
   }
   if(firstVisual<0)return null;

   // With four shared slots, leave room for one incoming room asset.
   var visualLoads:int=0;
   for each(var running:Object in active){
    if(_visual[running]===true)visualLoads++;
   }
   if(visualLoads>=MAX_VISUAL_LOADS)return null;
   return pending.splice(firstVisual,1)[0];
  }
 }
}
