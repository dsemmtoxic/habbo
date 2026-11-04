package loginpatch
{
   public class FloorPlanModel22
   {
      
      public var rows:Array = [];
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public var entryX:int = -1;
      
      public var entryY:int = -1;
      
      public var direction:int = 2;
      
      public var wallHeight:int = -1;
      
      public var wallThickness:int = 0;
      
      public var floorThickness:int = 0;
      
      public var occupied:Object = {};
      
      public var largePlans:Boolean = false;
      
      public var changed:Boolean = false;
      
      public function FloorPlanModel22(text:String = "", fixed:int = -1)
      {
         super();
         wallHeight = fixed;
         if(text != null && text != "")
         {
            load(text);
         }
      }
      
      public function load(text:String) : void
      {
         var input:Array = text.toLowerCase().replace(/\n/g,"").split("\r");
         while(input.length > 0 && input[input.length - 1] === "")
         {
            input.pop();
         }
         if(input.length == 0 || input.length > 64)
         {
            throw new ArgumentError("Invalid floor heightmap");
         }
         var w:int = 0;
         for each(var line:String in input)
         {
            if(!/^[0-9a-tx]*$/.test(line))
            {
               throw new ArgumentError("Invalid floor height");
            }
            w = Math.max(w,line.length);
         }
         if(w < 1 || w > 64)
         {
            throw new ArgumentError("Invalid floor width");
         }
         rows = [];
         for each(line in input)
         {
            while(line.length < w)
            {
               line += "x";
            }
            rows.push(line);
         }
         width = w;
         height = rows.length;
         changed = false;
      }
      
      public function getHeight(x:int, y:int) : int
      {
         if(x < 0 || y < 0 || x >= width || y >= height)
         {
            return -1;
         }
         var c:String = String(rows[y]).charAt(x);
         return c == "x" ? -1 : parseInt(c,36);
      }
      
      public function blocked(x:int, y:int) : Boolean
      {
         return occupied[x + ":" + y] === true;
      }
      
      public function setOccupied(tiles:Array) : void
      {
         occupied = {};
         if(tiles != null)
         {
            for each(var t:Object in tiles)
            {
               if(t.x >= 0 && t.y >= 0 && t.x < 64 && t.y < 64)
               {
                  occupied[int(t.x) + ":" + int(t.y)] = true;
               }
            }
         }
      }
      
      private function expand(w:int, h:int) : Boolean
      {
         if(w > 64 || h > 64 || !largePlans && (w - 1) * (h - 1) > 3025)
         {
            return false;
         }
         var y:int = 0;
         while(y < height)
         {
            var line:String = String(rows[y]);
            while(line.length < w)
            {
               line += "x";
            }
            rows[y] = line;
            y++;
         }
         line = "";
         var x:int = 0;
         while(x < w)
         {
            line += "x";
            x++;
         }
         while(rows.length < h)
         {
            rows.push(line);
         }
         width = w;
         height = h;
         return true;
      }
      
      public function setHeight(x:int, y:int, value:int) : Boolean
      {
         if(x < 0 || y < 0 || x >= 64 || y >= 64 || value < -1 || value > 29 || blocked(x,y) || getHeight(x,y) == value)
         {
            return false;
         }
         if(value >= 0 && x == 0)
         {
            var yy:int = 0;
            while(yy < height)
            {
               if(yy != y && getHeight(0,yy) >= 0)
               {
                  return false;
               }
               yy++;
            }
         }
         if(value >= 0 && y == 0)
         {
            var xx:int = 0;
            while(xx < width)
            {
               if(xx != x && getHeight(xx,0) >= 0)
               {
                  return false;
               }
               xx++;
            }
         }
         if(!expand(Math.max(width,x + 1),Math.max(height,y + 1)))
         {
            return false;
         }
         var line:String = String(rows[y]);
         rows[y] = line.substr(0,x) + (value < 0 ? "x" : value.toString(36)) + line.substr(x + 1);
         changed = true;
         return true;
      }
      
      public function draw(x:int, y:int, mode:String, level:int) : Boolean
      {
         var old:int = getHeight(x,y);
         if(mode == "entry")
         {
            if(old < 0 || entryX == x && entryY == y)
            {
               return false;
            }
            entryX = x;
            entryY = y;
            changed = true;
            return true;
         }
         if(mode == "remove")
         {
            return setHeight(x,y,-1);
         }
         if(mode == "raise")
         {
            return old < 0 ? false : setHeight(x,y,Math.min(29,old + 1));
         }
         if(mode == "lower")
         {
            return old < 0 ? false : setHeight(x,y,Math.max(0,old - 1));
         }
         if(mode == "fill")
         {
            return fill(x,y,level);
         }
         return setHeight(x,y,level);
      }
      
      public function fill(x:int, y:int, level:int) : Boolean
      {
         var target:int = getHeight(x,y);
         if(target < 0 || target == level || blocked(x,y))
         {
            return false;
         }
         var q:Array = [{
            "x":x,
            "y":y
         }];
         var seen:Object = {};
         var result:Boolean = false;
         var i:int = 0;
         while(i < q.length)
         {
            var p:Object = q[i++];
            var k:String = p.x + ":" + p.y;
            if(!seen[k])
            {
               seen[k] = true;
               if(!(getHeight(p.x,p.y) != target || blocked(p.x,p.y)))
               {
                  if(setHeight(p.x,p.y,level))
                  {
                     result = true;
                  }
                  if(p.x > 0)
                  {
                     q.push({
                        "x":p.x - 1,
                        "y":p.y
                     });
                  }
                  if(p.y > 0)
                  {
                     q.push({
                        "x":p.x,
                        "y":p.y - 1
                     });
                  }
                  if(p.x + 1 < width)
                  {
                     q.push({
                        "x":p.x + 1,
                        "y":p.y
                     });
                  }
                  if(p.y + 1 < height)
                  {
                     q.push({
                        "x":p.x,
                        "y":p.y + 1
                     });
                  }
               }
            }
         }
         return result;
      }
      
      public function rotate() : int
      {
         direction = (direction + 1) % 8;
         changed = true;
         return direction;
      }
      
      public function countTiles() : int
      {
         var n:int = 0;
         var y:int = 0;
         while(y < height)
         {
            var x:int = 0;
            while(x < width)
            {
               if(getHeight(x,y) >= 0)
               {
                  n++;
               }
               x++;
            }
            y++;
         }
         return n;
      }
      
      public function errorKey() : String
      {
         if(width < 1 || height < 1 || countTiles() == 0)
         {
            return "effective_height_is_0";
         }
         if(width > 64 || height > 64 || !largePlans && (width - 1) * (height - 1) > 3025)
         {
            return "too_large_area";
         }
         if(entryX < 0 || entryY < 0 || entryX >= width || entryY >= height)
         {
            return "entry_tile_outside_map";
         }
         if(getHeight(entryX,entryY) < 0)
         {
            return "entry_not_on_tile";
         }
         if(direction < 0 || direction > 7)
         {
            return "invalid_entry_tile_direction";
         }
         if(wallThickness < -2 || wallThickness > 1)
         {
            return "invalid_wall_thickness";
         }
         if(floorThickness < -2 || floorThickness > 1)
         {
            return "invalid_floor_thickness";
         }
         if(wallHeight < -1 || wallHeight > 16)
         {
            return "invalid_walls_fixed_height";
         }
         var a:int = 0;
         var b:int = 0;
         var x:int = 0;
         while(x < width)
         {
            if(getHeight(x,0) >= 0)
            {
               a++;
            }
            x++;
         }
         var y:int = 0;
         while(y < height)
         {
            if(getHeight(0,y) >= 0)
            {
               b++;
            }
            y++;
         }
         if(a > 1 || b > 1)
         {
            return "invalid_door_setup";
         }
         return "";
      }
      
      public function data() : String
      {
         return rows.join("\r") + "\r";
      }
      
      public function payload() : Array
      {
         var a:Array = [data(),entryX,entryY,direction,wallThickness,floorThickness];
         if(wallHeight >= 0)
         {
            a.push(wallHeight);
         }
         return a;
      }
      
      public function snapshot() : Object
      {
         return {
            "text":data(),
            "entryX":entryX,
            "entryY":entryY,
            "direction":direction,
            "wallHeight":wallHeight,
            "wallThickness":wallThickness,
            "floorThickness":floorThickness,
            "changed":changed
         };
      }
      
      public function restore(o:Object) : void
      {
         load(o.text);
         entryX = o.entryX;
         entryY = o.entryY;
         direction = o.direction;
         wallHeight = o.wallHeight;
         wallThickness = o.wallThickness;
         floorThickness = o.floorThickness;
         changed = Boolean(o.changed);
      }
   }
}

