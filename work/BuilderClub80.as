package loginpatch
{
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    public class BuilderClub80
    {
        private static const lastQuery:Dictionary = new Dictionary(true);

        public static function warm(catalog:Object):void
        {
            if (catalog == null)
            {
                return;
            }

            var now:int = getTimer();
            var previous:* = lastQuery[catalog];
            if (previous !== undefined && now - int(previous) < 1000)
            {
                return;
            }

            lastQuery[catalog] = now;
            catalog["_-2xK"]();
        }

        public static function ownerAtLimit(catalog:Object):Boolean
        {
            var used:int = int(catalog["_-317"]);
            var limit:int = int(catalog["_-1qy"]);
            return used >= 0 && limit > 0 && used >= limit;
        }

        public static function groupEnabled(catalog:Object):Boolean
        {
            var setting:String = catalog.getProperty("builders.club.furniture.placement.group.room.enabled");
            // Older hotel configurations may omit the flag. Keep the room
            // rights gate and let the server decide whether to accept placement.
            return setting != "false" && setting != "0";
        }
    }
}
