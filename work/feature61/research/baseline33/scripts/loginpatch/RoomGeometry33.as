package loginpatch
{
   import flash.geom.Point;
   
   public final class RoomGeometry33
   {
      
      public function RoomGeometry33()
      {
         super();
      }
      
      private static function floor(value:Number) : Boolean
      {
         return Boolean(isFinite(value)) && value >= 0 && value < 100;
      }
      
      public static function connectedEntrance(map:Object, x:int, y:int, direction:int) : Boolean
      {
         if(map == null || direction != 90 && direction != 180)
         {
            return false;
         }
         return floor(Number(map["_-4-t"](x,y))) && floor(Number(map["_-4-t"](x + (direction == 90 ? 1 : 0),y + (direction == 180 ? 1 : 0))));
      }
      
      public static function findEntrance(map:Array) : Point
      {
         if(map == null || map.length < 3)
         {
            return null;
         }
         var first:Array = [];
         var y:int = 0;
         while(y < map.length)
         {
            var row:Array = map[y] as Array;
            if(row == null || row.length == 0)
            {
               return null;
            }
            var x:int = 0;
            while(x < row.length && !floor(Number(row[x])))
            {
               x++;
            }
            first.push(x < row.length ? x : row.length + 1);
            y++;
         }
         y = 1;
         while(y < map.length - 1)
         {
            x = int(first[y]);
            row = map[y] as Array;
            if(x <= int(first[y - 1]) - 1 && x <= int(first[y + 1]) - 1 && x + 1 < row.length && floor(Number(row[x])) && floor(Number(row[x + 1])))
            {
               return new Point(x,y);
            }
            y++;
         }
         return null;
      }
   }
}

