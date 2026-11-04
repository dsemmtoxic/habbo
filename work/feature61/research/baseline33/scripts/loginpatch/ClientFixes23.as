package loginpatch
{
   import flash.utils.Dictionary;
   
   public final class ClientFixes23
   {
      
      private static var _engine:Object;
      
      private static var _flagsHeader:int = 0;
      
      private static var _room:int = -1;
      
      private static var _rooms:Dictionary = new Dictionary(true);
      
      private static var _visibility:Dictionary = new Dictionary(true);
      
      private static var _owners:Dictionary = new Dictionary(true);
      
      private static var _pendingVisibility:Boolean = false;
      
      private static var _hasPendingVisibility:Boolean = false;
      
      private static var _entityHtml:Boolean = false;
      
      private static var _entities:Object = {
         "amp":38,
         "lt":60,
         "gt":62,
         "quot":34,
         "apos":39,
         "nbsp":160,
         "copy":169,
         "reg":174,
         "ndash":8211,
         "mdash":8212,
         "hellip":8230,
         "lsquo":8216,
         "rsquo":8217,
         "ldquo":8220,
         "rdquo":8221,
         "euro":8364,
         "bull":8226,
         "Agrave":192,
         "Aacute":193,
         "Acirc":194,
         "Atilde":195,
         "Auml":196,
         "Aring":197,
         "AElig":198,
         "Ccedil":199,
         "Egrave":200,
         "Eacute":201,
         "Ecirc":202,
         "Euml":203,
         "Igrave":204,
         "Iacute":205,
         "Icirc":206,
         "Iuml":207,
         "ETH":208,
         "Ntilde":209,
         "Ograve":210,
         "Oacute":211,
         "Ocirc":212,
         "Otilde":213,
         "Ouml":214,
         "Oslash":216,
         "Ugrave":217,
         "Uacute":218,
         "Ucirc":219,
         "Uuml":220,
         "Yacute":221,
         "THORN":222,
         "szlig":223,
         "agrave":224,
         "aacute":225,
         "acirc":226,
         "atilde":227,
         "auml":228,
         "aring":229,
         "aelig":230,
         "ccedil":231,
         "egrave":232,
         "eacute":233,
         "ecirc":234,
         "euml":235,
         "igrave":236,
         "iacute":237,
         "icirc":238,
         "iuml":239,
         "eth":240,
         "ntilde":241,
         "ograve":242,
         "oacute":243,
         "ocirc":244,
         "otilde":245,
         "ouml":246,
         "oslash":248,
         "ugrave":249,
         "uacute":250,
         "ucirc":251,
         "uuml":252,
         "yacute":253,
         "thorn":254,
         "yuml":255
      };
      
      public function ClientFixes23()
      {
         super();
      }
      
      public static function initialize(header:int) : void
      {
         _flagsHeader = header;
      }
      
      public static function reset() : void
      {
         _engine = null;
         _room = -1;
         _rooms = new Dictionary(true);
         _visibility = new Dictionary(true);
         _owners = new Dictionary(true);
         _hasPendingVisibility = false;
      }
      
      public static function bindRoom(engine:Object, room:int) : void
      {
         _engine = engine;
         _room = room;
         if(_hasPendingVisibility && engine != null && room >= 0)
         {
            var rooms:Object = _rooms[engine];
            if(rooms == null)
            {
               rooms = {};
               _rooms[engine] = rooms;
            }
            rooms[room] = _pendingVisibility;
            _hasPendingVisibility = false;
         }
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
      
      public static function interceptRoomFlags(wrapper:Object) : Boolean
      {
         if(_flagsHeader == 0 || int(wrapper["_-2Dk"]()) != _flagsHeader)
         {
            return false;
         }
         wrapper.readBoolean();
         if(wrapper.bytesAvailable > 0)
         {
            wrapper.readBoolean();
         }
         if(wrapper.bytesAvailable > 0)
         {
            wrapper.readBoolean();
         }
         var invisible:Boolean = Boolean(wrapper.bytesAvailable > 0 ? wrapper.readBoolean() : false);
         if(_engine == null || _room < 0)
         {
            _pendingVisibility = invisible;
            _hasPendingVisibility = true;
            return true;
         }
         var rooms:Object = _rooms[_engine];
         if(rooms == null)
         {
            rooms = {};
            _rooms[_engine] = rooms;
         }
         rooms[_room] = invisible;
         refreshRoom(_engine,_room);
         return true;
      }
      
      public static function applyObject(object:Object, engine:Object, room:int, category:int = 10) : void
      {
         if(object == null)
         {
            return;
         }
         _owners[object] = {
            "engine":engine,
            "room":room,
            "category":category
         };
         refreshObject(object);
      }
      
      public static function refreshRoom(engine:Object, room:int) : void
      {
         if(engine == null || room < 0)
         {
            return;
         }
         for each(var category:int in [10,20])
         {
            var n:int = int(engine["_-2vx"](room,category));
            var i:int = 0;
            while(i < n)
            {
               applyObject(engine["_-2Fe"](room,i,category),engine,room,category);
               i++;
            }
         }
      }
      
      private static function refreshObject(object:Object) : void
      {
         var owner:Object = _owners[object];
         if(owner == null)
         {
            return;
         }
         var model:Object = object.getModelController();
         if(model == null)
         {
            return;
         }
         var rooms:Object = _rooms[owner.engine];
         var value:int = rooms != null && rooms[owner.room] === true ? 1 : 0;
         if(Number(model.getNumber("furniture_invisible_layer")) != value)
         {
            model.setNumber("furniture_invisible_layer",value);
         }
         var area:int = AreaHide30.hiddenFurniture(object,owner.engine,owner.room,int(owner.category)) ? 1 : 0;
         if(Number(model.getNumber("loginpatch_area_hidden32")) != area)
         {
            model.setNumber("loginpatch_area_hidden32",area);
         }
      }
      
      public static function visibilityChanged(visualization:Object, object:Object) : Boolean
      {
         if(object == null || object.getModel() == null)
         {
            return false;
         }
         refreshObject(object);
         var model:Object = object.getModel();
         var flag:int = (Number(model.getNumber("furniture_invisible_layer")) > 0 ? 1 : 0) + (Number(model.getNumber("loginpatch_area_hidden32")) > 0 ? 2 : 0) + (Number(model.getNumber("furniture_area_hide_invisibility")) == 1 ? 4 : 0);
         var previous:Object = _visibility[visualization];
         _visibility[visualization] = flag;
         return previous !== flag;
      }
      
      private static function invisibleLayer(object:Object, sprite:Object) : Boolean
      {
         if(object == null || sprite == null)
         {
            return false;
         }
         var product:String = String(object.getType());
         if(product.indexOf("conf_invis_control") == 0)
         {
            return false;
         }
         if(product.indexOf("conf_area_hide") == 0)
         {
            return Number(object.getModel().getNumber("furniture_area_hide_invisibility")) == 1;
         }
         if(sprite.tag == "invisible")
         {
            return true;
         }
         var type:String = String(object.getType());
         return type.indexOf("tile_stackmagic") == 0 || type.indexOf("tile_walkmagic") == 0 || type.indexOf("room_invisible_") == 0;
      }
      
      private static function hidden(object:Object, sprite:Object) : Boolean
      {
         if(object == null || sprite == null || String(object.getType()).indexOf("conf_invis_control") == 0)
         {
            return false;
         }
         refreshObject(object);
         var model:Object = object.getModel();
         return Number(model.getNumber("loginpatch_area_hidden32")) > 0 || invisibleLayer(object,sprite) && Number(model.getNumber("furniture_invisible_layer")) > 0;
      }
      
      public static function spriteAlpha(alpha:int, object:Object, sprite:Object) : int
      {
         var value:int = hidden(object,sprite) ? 0 : alpha;
         if(sprite != null && sprite.image != null)
         {
            sprite.image["_-3uV"](value);
         }
         return value;
      }
      
      public static function spriteCapture(capture:int, object:Object, sprite:Object) : int
      {
         var value:int = hidden(object,sprite) ? 256 : capture;
         if(sprite != null && sprite.image != null)
         {
            sprite.image["_-F5"] = value;
         }
         return value;
      }
      
      public static function decodeNews(value:String, html:Boolean = false) : String
      {
         if(value == null || value.indexOf("&") < 0)
         {
            return value;
         }
         _entityHtml = html;
         var passes:int = html ? 1 : 2;
         var i:int = 0;
         while(i < passes)
         {
            value = value.replace(/&(#x[0-9a-fA-F]+|#X[0-9a-fA-F]+|#[0-9]+|[A-Za-z][A-Za-z0-9]+);/g,newsEntity);
            i++;
         }
         return value;
      }
      
      private static function newsEntity(... args) : String
      {
         var original:String = String(args[0]);
         var key:String = String(args[1]);
         if(key.charAt(0) == "#")
         {
            var cp:Number = Number(key.charAt(1).toLowerCase() == "x" ? parseInt(key.substr(2),16) : parseInt(key.substr(1),10));
         }
         else
         {
            if(_entities[key] == null)
            {
               return original;
            }
            cp = Number(_entities[key]);
         }
         if(isNaN(cp) || cp < 1 || cp > 1114111 || cp >= 55296 && cp <= 57343)
         {
            return original;
         }
         if(_entityHtml && (cp == 38 || cp == 60 || cp == 62 || cp == 34 || cp == 39))
         {
            return original;
         }
         if(cp > 65535)
         {
            cp -= 65536;
            return String.fromCharCode(55296 + (int(cp) >> 10),56320 + (int(cp) & 0x03FF));
         }
         return String.fromCharCode(int(cp));
      }
   }
}

