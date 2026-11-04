package loginpatch
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public final class FloorPreview25
   {
      
      private static var _key:String = "";
      
      private static var _planes:Array = [];
      
      public function FloorPreview25()
      {
         super();
      }
      
      public static function reset() : void
      {
         _key = "";
         _planes = [];
      }
      
      private static function point(v:Object) : Object
      {
         return {
            "x":Number(v.x),
            "y":Number(v.y),
            "z":Number(v.z)
         };
      }
      
      private static function plus(a:Object, b:Object) : Object
      {
         return {
            "x":a.x + b.x,
            "y":a.y + b.y,
            "z":a.z + b.z
         };
      }
      
      private static function facing(v:Object) : Boolean
      {
         return v != null && Number(v.x) + Number(v.y) + Number(v.z) * 2 > 0.001;
      }
      
      public static function geometry(model:Object) : Array
      {
         var P:Class;
         var p:Object;
         var out:Array;
         var y:int;
         var x:int;
         var count:int;
         var i:int;
         var type:int;
         var normal:Object;
         var secondary:Array;
         var visible:Boolean;
         var side:Object;
         var a:Object;
         var left:Object;
         var right:Object;
         var b:Object;
         var d:Object;
         var c:Object;
         var top:Boolean;
         var color:uint;
         var key:String = model.data() + ":" + model.wallHeight + ":" + model.wallThickness + ":" + model.floorThickness;
         if(key == _key)
         {
            return _planes;
         }
         if(model.countTiles() == 0)
         {
            _key = key;
            _planes = [];
            return _planes;
         }
         P = getDefinitionByName("_-0Ee::_-4fX") as Class;
         p = new P();
         out = [];
         try
         {
            if(!p["_-x7"](model.width,model.height))
            {
               throw new ArgumentError("Invalid preview dimensions");
            }
            y = 0;
            while(y < model.height)
            {
               x = 0;
               while(x < model.width)
               {
                  if(model.getHeight(x,y) >= 0)
                  {
                     p["_-1yQ"](x,y,model.getHeight(x,y));
                  }
                  x++;
               }
               y++;
            }
            p["_-33a"] = Math.pow(2,model.wallThickness);
            p["_-2Hr"] = Math.pow(2,model.floorThickness);
            if(!p["_-2n8"](model.wallHeight))
            {
               throw new ArgumentError("Invalid preview model");
            }
            count = int(p["_-3uW"]);
            i = 0;
            while(i < count)
            {
               type = int(p["_-i"](i));
               if(!(type != 1 && type != 2))
               {
                  normal = p["_-1fn"](i);
                  if(facing(normal))
                  {
                     secondary = p["_-4dT"](i);
                     visible = true;
                     for each(side in secondary)
                     {
                        if(!facing(side))
                        {
                           visible = false;
                           break;
                        }
                     }
                     if(visible)
                     {
                        a = point(p["_-1Ae"](i));
                        left = point(p["_-0-F"](i));
                        right = point(p["_-1wo"](i));
                        b = plus(a,left);
                        d = plus(a,right);
                        c = plus(b,right);
                        top = type == 1 && Math.abs(Number(normal.z)) > 0.001;
                        color = uint(type == 1 ? (top ? 10263909 : (Math.abs(Number(normal.x)) > Math.abs(Number(normal.y)) ? 7961165 : 9013846)) : (Math.abs(Number(normal.x)) > Math.abs(Number(normal.y)) ? 9737637 : 12106440));
                        out.push({
                           "points":[a,b,c,d],
                           "left":left,
                           "right":right,
                           "type":type,
                           "top":top,
                           "color":color,
                           "depth":planeDepth([a,b,c,d],type)
                        });
                     }
                  }
               }
               i++;
            }
         }
         finally
         {
            p.dispose();
         }
         out.sortOn("depth",Array.NUMERIC);
         _key = key;
         _planes = out;
         return out;
      }
      
      private static function planeDepth(points:Array, type:int) : Number
      {
         var far:Number = 100000000000000000000;
         var bottom:Number = 100000000000000000000;
         for each(var p:Object in points)
         {
            far = Math.min(far,(p.x + p.y + p.z) / Math.sqrt(3));
            bottom = Math.min(bottom,p.z);
         }
         return far + (type == 1 ? bottom * 8 - 0.1 : -0.5);
      }
      
      public static function render(model:Object, width:int, height:int, zoom:Number = 1, offset:Point = null) : BitmapData
      {
         var planes:Array = geometry(model);
         var data:BitmapData = new BitmapData(width,height,false,0);
         if(planes.length == 0)
         {
            return data;
         }
         var minX:Number = 100000000000000000000;
         var minY:Number = 100000000000000000000;
         var maxX:Number = -100000000000000000000;
         var maxY:Number = -100000000000000000000;
         for each(var plane:Object in planes)
         {
            for each(var v:Object in plane.points)
            {
               var xx:Number = (v.x - v.y) * 16;
               var yy:Number = (v.x + v.y) * 8 - v.z * 16;
               minX = Math.min(minX,xx);
               maxX = Math.max(maxX,xx);
               minY = Math.min(minY,yy);
               maxY = Math.max(maxY,yy);
            }
         }
         var scale:Number = Math.min((width - 36) / Math.max(1,maxX - minX),(height - 36) / Math.max(1,maxY - minY)) * zoom;
         var ox:Number = width / 2 - (minX + maxX) * scale / 2 + (offset == null ? 0 : offset.x);
         var oy:Number = height / 2 - (minY + maxY) * scale / 2 + (offset == null ? 0 : offset.y);
         var shape:Shape = new Shape();
         var g:Object = shape.graphics;
         for each(plane in planes)
         {
            g.lineStyle(0.45,plane.type == 1 ? 8750675 : 8684947);
            g.beginFill(plane.color);
            var i:int = 0;
            while(i < 5)
            {
               v = plane.points[i % 4];
               xx = ox + (v.x - v.y) * 16 * scale;
               yy = oy + ((v.x + v.y) * 8 - v.z * 16) * scale;
               if(i == 0)
               {
                  g.moveTo(xx,yy);
               }
               else
               {
                  g.lineTo(xx,yy);
               }
               i++;
            }
            g.endFill();
            if(plane.top === true)
            {
               var a:Object = plane.points[0];
               var l:Object = plane.left;
               var r:Object = plane.right;
               var nl:Number = Math.sqrt(l.x * l.x + l.y * l.y + l.z * l.z);
               var nr:Number = Math.sqrt(r.x * r.x + r.y * r.y + r.z * r.z);
               g.lineStyle(0.35,9277020,0.6);
               var k:int = 1;
               while(k < Math.min(65,Math.floor(nl)))
               {
                  line(g,a,plus(a,r),l,k / nl,scale,ox,oy);
                  k++;
               }
               k = 1;
               while(k < Math.min(65,Math.floor(nr)))
               {
                  line(g,a,plus(a,l),r,k / nr,scale,ox,oy);
                  k++;
               }
            }
         }
         data.draw(shape);
         return data;
      }
      
      private static function line(g:Object, a:Object, b:Object, d:Object, t:Number, s:Number, ox:Number, oy:Number) : void
      {
         var x:Number = a.x + d.x * t;
         var y:Number = a.y + d.y * t;
         var z:Number = a.z + d.z * t;
         g.moveTo(ox + (x - y) * 16 * s,oy + ((x + y) * 8 - z * 16) * s);
         x = b.x + d.x * t;
         y = b.y + d.y * t;
         z = b.z + d.z * t;
         g.lineTo(ox + (x - y) * 16 * s,oy + ((x + y) * 8 - z * 16) * s);
      }
   }
}

