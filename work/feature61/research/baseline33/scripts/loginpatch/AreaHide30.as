package loginpatch
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public final class AreaHide30
   {
      
      private static var _engine:Object;
      
      private static var _applying:Object;
      
      private static var _header:int = 0;
      
      private static var _room:int = -1;
      
      private static var _rooms:Dictionary = new Dictionary(true);
      
      private static var _owners:Dictionary = new Dictionary(true);
      
      private static var _parsers:Dictionary = new Dictionary(true);
      
      public function AreaHide30()
      {
         super();
      }
      
      private static function klass(name:String) : Class
      {
         return getDefinitionByName(name) as Class;
      }
      
      public static function initialize(header:int) : void
      {
         _header = header;
      }
      
      public static function reset() : void
      {
         _engine = null;
         _room = -1;
         _rooms = new Dictionary(true);
         _owners = new Dictionary(true);
         _parsers = new Dictionary(true);
         _applying = null;
      }
      
      private static function roomState(engine:Object, room:int) : Object
      {
         if(engine == null || room < 0)
         {
            return null;
         }
         var rooms:Object = _rooms[engine];
         if(rooms == null)
         {
            rooms = {};
            _rooms[engine] = rooms;
         }
         var state:Object = rooms[room];
         if(state == null)
         {
            state = {
               "areas":{},
               "applied":[],
               "roomObject":null,
               "width":64,
               "height":64,
               "next":-1
            };
            rooms[room] = state;
         }
         return state;
      }
      
      public static function bindRoom(engine:Object, room:int) : void
      {
         _engine = engine;
         _room = room;
         roomState(engine,room);
      }
      
      public static function dropRoom(engine:Object, room:int) : void
      {
         var rooms:Object = _rooms[engine];
         if(rooms != null)
         {
            delete rooms[room];
         }
         if(engine === _engine && room == _room)
         {
            _engine = null;
            _room = -1;
         }
      }
      
      private static function readArea(wrapper:Object) : Object
      {
         return {
            "id":int(wrapper["_-0u0"]()),
            "on":Boolean(wrapper.readBoolean()),
            "x":int(wrapper["_-0u0"]()),
            "y":int(wrapper["_-0u0"]()),
            "width":int(wrapper["_-0u0"]()),
            "height":int(wrapper["_-0u0"]()),
            "invert":Boolean(wrapper.readBoolean())
         };
      }
      
      public static function floorMap(parser:Object, wrapper:Object) : void
      {
         var state:Object = roomState(_engine,_room);
         if(state == null)
         {
            return;
         }
         state.width = int(parser.width);
         state.height = int(parser.height);
         state.areas = {};
         if(wrapper.bytesAvailable >= 4)
         {
            var count:int = int(wrapper["_-0u0"]());
            if(count < 0 || count > 4096)
            {
               throw new ArgumentError("Invalid area-hide count");
            }
            var i:int = 0;
            while(i < count)
            {
               var area:Object = readArea(wrapper);
               state.areas[area.id] = area;
               i++;
            }
         }
      }
      
      public static function incoming(wrapper:Object) : Boolean
      {
         if(_header == 0 || int(wrapper["_-2Dk"]()) != _header)
         {
            return false;
         }
         var area:Object = readArea(wrapper);
         var state:Object = roomState(_engine,_room);
         if(state != null)
         {
            var previous:Object = state.areas[area.id];
            area.wallitems = previous != null && previous.wallitems === true;
            state.areas[area.id] = area;
            applyRoomMasks(_engine,_room);
         }
         klass("loginpatch::HabboTicketLogin").areaHideState30(area.id,area.on);
         return true;
      }
      
      public static function rememberObject(object:Object, engine:Object, room:int) : void
      {
         if(object == null || String(object.getType()).indexOf("conf_area_hide") != 0)
         {
            return;
         }
         _owners[object] = {
            "engine":engine,
            "room":room
         };
         syncObject(object);
      }
      
      public static function syncObject(object:Object) : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var model:Object = object.getModelController();
         var data:Array = model.getNumberArray("furniture_data");
         if(data == null || data.length < 8 || Number(model.getNumber("furniture_real_room_object")) != 1)
         {
            return;
         }
         model.setNumber("furniture_area_hide_root_x",int(data[1]));
         model.setNumber("furniture_area_hide_root_y",int(data[2]));
         model.setNumber("furniture_area_hide_width",int(data[3]));
         model.setNumber("furniture_area_hide_length",int(data[4]));
         model.setNumber("furniture_area_hide_invisibility",int(data[5]));
         model.setNumber("furniture_area_hide_wallitems",int(data[6]));
         model.setNumber("furniture_area_hide_invert",int(data[7]));
         object.setState(int(data[0]),0);
         var owner:Object = _owners[object];
         if(owner == null)
         {
            return;
         }
         var state:Object = roomState(owner.engine,owner.room);
         var id:int = int(object.getId());
         state.areas[id] = {
            "id":id,
            "on":int(data[0]) != 0,
            "x":int(data[1]),
            "y":int(data[2]),
            "width":int(data[3]),
            "height":int(data[4]),
            "wallitems":int(data[6]) == 1,
            "invert":int(data[7]) == 1
         };
         applyRoomMasks(owner.engine,owner.room);
         klass("loginpatch::HabboTicketLogin").areaHideState30(id,int(data[0]) != 0);
      }
      
      public static function removeObject(object:Object) : void
      {
         var owner:Object = _owners[object];
         if(owner == null)
         {
            return;
         }
         var rooms:Object = _rooms[owner.engine];
         var state:Object = rooms == null ? null : rooms[owner.room];
         delete _owners[object];
         if(state == null)
         {
            return;
         }
         delete state.areas[int(object.getId())];
         applyRoomMasks(owner.engine,owner.room);
      }
      
      public static function rectangles(area:Object, width:int, height:int) : Array
      {
         var result:Array = [];
         if(!area.on)
         {
            return result;
         }
         var x:int = Math.max(0,Math.min(width,int(area.x)));
         var y:int = Math.max(0,Math.min(height,int(area.y)));
         var right:int = Math.max(x,Math.min(width,int(area.x) + Math.max(0,int(area.width))));
         var bottom:int = Math.max(y,Math.min(height,int(area.y) + Math.max(0,int(area.height))));
         if(area.invert)
         {
            addRect(result,0,0,width,y);
            addRect(result,0,bottom,width,height - bottom);
            addRect(result,0,y,x,bottom - y);
            addRect(result,right,y,width - right,bottom - y);
         }
         else
         {
            addRect(result,x,y,right - x,bottom - y);
         }
         return result;
      }
      
      private static function addRect(out:Array, x:int, y:int, width:int, height:int) : void
      {
         if(width > 0 && height > 0)
         {
            out.push({
               "x":x,
               "y":y,
               "width":width,
               "height":height
            });
         }
      }
      
      public static function applyRoomMasks(engine:Object, room:int) : void
      {
         var object:Object;
         var logic:Object;
         var Message:Class;
         var id:int;
         var area:Object;
         var rect:Object;
         var hole:int;
         var state:Object = roomState(engine,room);
         if(state == null)
         {
            return;
         }
         klass("loginpatch::ClientFixes23").refreshRoom(engine,room);
         object = engine["_-nk"](room);
         if(object == null || object.getEventHandler() == null)
         {
            return;
         }
         logic = object.getEventHandler();
         Message = klass("_-0gs::_-1Ry");
         _applying = state;
         try
         {
            if(state.roomObject === object)
            {
               for each(id in state.applied)
               {
                  logic.processUpdateMessage(new Message("RORPFHUM_REMOVE",id));
               }
            }
            state.roomObject = object;
            state.applied = [];
            for each(area in state.areas)
            {
               for each(rect in rectangles(area,state.width,state.height))
               {
                  hole = int(state.next--);
                  if(state.next < -2000000000)
                  {
                     state.next = -1;
                  }
                  state.applied.push(hole);
                  logic.processUpdateMessage(new Message("RORPFHUM_ADD",hole,rect.x,rect.y,rect.width,rect.height));
               }
            }
         }
         finally
         {
            _applying = null;
         }
      }
      
      public static function hiddenFurniture(object:Object, engine:Object, room:int, category:int) : Boolean
      {
         if(object == null)
         {
            return false;
         }
         var type:String = String(object.getType());
         if(type.indexOf("conf_invis_control") == 0 || type.indexOf("conf_area_hide") == 0)
         {
            return false;
         }
         var rooms:Object = _rooms[engine];
         var state:Object = rooms == null ? null : rooms[room];
         if(state == null)
         {
            return false;
         }
         var location:Object = null;
         for each(var area:Object in state.areas)
         {
            if(!(!area.on || int(area.width) <= 0 || int(area.height) <= 0 || category == 20 && area.wallitems !== true))
            {
               if(location == null)
               {
                  location = object.getLocation();
               }
               if(location == null)
               {
                  return false;
               }
               var inside:Boolean = Number(location.x) >= Number(area.x) - 0.5 && Number(location.x) < Number(area.x) + Number(area.width) - 0.5 && Number(location.y) >= Number(area.y) - 0.5 && Number(location.y) < Number(area.y) + Number(area.height) - 0.5;
               if(area.invert ? !inside : inside)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function captureParser32(parser:Object) : void
      {
         if(_applying != null)
         {
            _parsers[parser] = _applying;
         }
      }
      
      private static function vector32(v:Object) : Object
      {
         return {
            "x":Number(v.x),
            "y":Number(v.y),
            "z":Number(v.z)
         };
      }
      
      private static function subPlane32(p:Object, u0:Number, u1:Number, v0:Number, v1:Number) : Object
      {
         return {
            "type":p.type,
            "secondary":p.secondary,
            "a":{
               "x":p.a.x + p.l.x * u0 + p.r.x * v0,
               "y":p.a.y + p.l.y * u0 + p.r.y * v0,
               "z":p.a.z + p.l.z * u0 + p.r.z * v0
            },
            "l":{
               "x":p.l.x * (u1 - u0),
               "y":p.l.y * (u1 - u0),
               "z":p.l.z * (u1 - u0)
            },
            "r":{
               "x":p.r.x * (v1 - v0),
               "y":p.r.y * (v1 - v0),
               "z":p.r.z * (v1 - v0)
            }
         };
      }
      
      private static function subtract32(p:Object, rect:Object) : Array
      {
         var u0:Number = 0;
         var u1:Number = 1;
         var v0:Number = 0;
         var v1:Number = 1;
         for each(var axis:String in ["x","y"])
         {
            var low:Number = Number(rect[axis]) - 0.5;
            var high:Number = low + Number(rect[axis == "x" ? "width" : "height"]);
            if(Number(rect[axis]) == 0)
            {
               low -= 1;
            }
            var a:Number = Number(p.a[axis]);
            var l:Number = Number(p.l[axis]);
            var r:Number = Number(p.r[axis]);
            if(Math.abs(l) > 0.000001 && Math.abs(r) > 0.000001)
            {
               return [p];
            }
            if(Math.abs(l) > 0.000001)
            {
               u0 = Math.max(u0,Math.min((low - a) / l,(high - a) / l));
               u1 = Math.min(u1,Math.max((low - a) / l,(high - a) / l));
            }
            else if(Math.abs(r) > 0.000001)
            {
               v0 = Math.max(v0,Math.min((low - a) / r,(high - a) / r));
               v1 = Math.min(v1,Math.max((low - a) / r,(high - a) / r));
            }
            else if(a < low - 0.000001 || a > high + 0.000001)
            {
               return [p];
            }
         }
         if(u1 - u0 < 0.000001 || v1 - v0 < 0.000001)
         {
            return [p];
         }
         var out:Array = [];
         if(u0 > 0.000001)
         {
            out.push(subPlane32(p,0,u0,0,1));
         }
         if(u1 < 0.999999)
         {
            out.push(subPlane32(p,u1,1,0,1));
         }
         if(v0 > 0.000001)
         {
            out.push(subPlane32(p,u0,u1,0,v0));
         }
         if(v1 < 0.999999)
         {
            out.push(subPlane32(p,u0,u1,v1,1));
         }
         return out;
      }
      
      public static function clipRoomPlanes32(parser:Object) : void
      {
         var state:Object = _parsers[parser];
         if(state == null)
         {
            return;
         }
         var rects:Array = [];
         for each(var area:Object in state.areas)
         {
            rects = rects.concat(rectangles(area,state.width,state.height));
         }
         if(rects.length == 0)
         {
            return;
         }
         var result:Array = [];
         var count:int = int(parser["_-3uW"]);
         var i:int = 0;
         while(i < count)
         {
            var parts:Array = [{
               "type":int(parser["_-i"](i)),
               "a":vector32(parser["_-1Ae"](i)),
               "l":vector32(parser["_-0-F"](i)),
               "r":vector32(parser["_-1wo"](i)),
               "secondary":parser["_-4dT"](i)
            }];
            for each(var rect:Object in rects)
            {
               var next:Array = [];
               for each(var part:Object in parts)
               {
                  next = next.concat(subtract32(part,rect));
               }
               parts = next;
            }
            result = result.concat(parts);
            i++;
         }
         var planes:Object = parser["_-2us"]();
         planes.length = 0;
         var Data:Class = klass("_-0Ee::_-3Yc");
         var V:Class = klass("_-0AB::Vector3d");
         for each(var p:Object in result)
         {
            planes.push(new Data(p.type,new V(p.a.x,p.a.y,p.a.z),new V(p.l.x,p.l.y,p.l.z),new V(p.r.x,p.r.y,p.r.z),p.secondary));
         }
      }
   }
}

