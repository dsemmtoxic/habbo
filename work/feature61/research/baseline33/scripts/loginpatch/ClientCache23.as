package loginpatch
{
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public final class ClientCache23
   {
      
      private static var _furniture:Dictionary = new Dictionary(true);
      
      private static var _avatars:Dictionary = new Dictionary(true);
      
      private static var _avatarUse:Dictionary = new Dictionary(true);
      
      private static var _force:Boolean = false;
      
      public function ClientCache23()
      {
         super();
      }
      
      public static function force(value:Boolean) : void
      {
         _force = value;
      }
      
      public static function touchAvatar(library:Object) : void
      {
         _avatarUse[library] = getTimer();
      }
      
      private static function pressure() : Boolean
      {
         return _force || System.totalMemory > 402653184;
      }
      
      private static function select(candidates:Array, keep:Dictionary, maxCount:int, budget:Number) : void
      {
         candidates.sortOn("last",Array.NUMERIC | Array.DESCENDING);
         var count:int = 0;
         var used:Number = 0;
         for each(var c:Object in candidates)
         {
            if(!(count >= maxCount || used + Number(c.cost) > budget))
            {
               keep[c.item] = true;
               count++;
               used += Number(c.cost);
            }
         }
      }
      
      public static function planFurniture(collections:Object, libraries:Object, placeholders:Array) : void
      {
         _furniture = new Dictionary(true);
         if(pressure() || collections == null)
         {
            return;
         }
         var candidates:Array = [];
         var now:int = getTimer();
         var i:int = 0;
         while(i < int(collections.length))
         {
            var name:String = String(collections["_-2Bo"](i));
            if(placeholders.indexOf(name) < 0)
            {
               var c:Object = collections.getValue(name);
               if(!(c == null || int(c["_-40W"]()) > 0))
               {
                  var last:int = int(c["_-2D1"]());
                  if(now - last < 600000)
                  {
                     var lib:Object = libraries.getValue("RoomContentLoader " + name);
                     var assets:int = lib == null ? 16 : int(lib["_-41q"]);
                     var cost:Number = Math.max(65536,assets * 32768);
                     candidates.push({
                        "item":c,
                        "last":last,
                        "cost":cost
                     });
                  }
               }
            }
            i++;
         }
         select(candidates,_furniture,96,67108864);
      }
      
      public static function releaseFurniture(collection:Object) : Boolean
      {
         return _furniture[collection] !== true;
      }
      
      public static function planAvatars(libraries:Object) : void
      {
         _avatars = new Dictionary(true);
         if(_force || libraries == null)
         {
            return;
         }
         var memory:Number = System.totalMemory;
         if(memory >= 1073741824)
         {
            return;
         }
         var capacity:int = memory >= 805306368 ? 64 : (memory >= 536870912 ? 128 : 256);
         var candidates:Array = [];
         var now:int = getTimer();
         for each(var lib:Object in libraries)
         {
            if(!(lib == null || !lib["_-2nx"] || lib["_-4Z"]))
            {
               var last:int = _avatarUse[lib] == null ? now : int(_avatarUse[lib]);
               _avatarUse[lib] = last;
               if(now - last < 600000)
               {
                  candidates.push({
                     "item":lib,
                     "last":last,
                     "cost":524288
                  });
               }
            }
         }
         select(candidates,_avatars,capacity,capacity * 524288);
      }
      
      public static function releaseAvatar(library:Object) : Boolean
      {
         return _avatars[library] !== true;
      }
   }
}

