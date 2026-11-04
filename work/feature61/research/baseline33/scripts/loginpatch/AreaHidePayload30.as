package loginpatch
{
   import §_-0tl§.§_-15i§;
   
   public final class AreaHidePayload30 implements §_-15i§
   {
      
      private var _data:Array;
      
      public function AreaHidePayload30(id:int, x:int, y:int, width:int, height:int, invisible:Boolean, wallitems:Boolean, invert:Boolean)
      {
         super();
         _data = [id,x,y,width,height,invisible,wallitems,invert];
      }
      
      public function §_-0tq§() : Array
      {
         return _data;
      }
      
      public function dispose() : void
      {
      }
   }
}

