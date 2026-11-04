package §_-vL§
{
   import §_-0Ce§.§_-31d§;
   import §_-0Ce§.§_-3ty§;
   import §_-0Lu§.§_-jx§;
   import §_-0Wy§.§_-0Q7§;
   import §_-0Wy§.§_-1C7§;
   import §_-0Wy§.§_-3AP§;
   import §_-0Wy§.§_-3wg§;
   import §_-0Wy§.§_-458§;
   import §_-0tl§.§_-15i§;
   import §_-15s§.IHabboTracking;
   import §_-1pz§.§_-05h§;
   import §_-1pz§.§_-09f§;
   import §_-1pz§.§_-3hM§;
   import §_-1pz§.§_-3vY§;
   import §_-1pz§.§_-dy§;
   import §_-249§.§_-pC§;
   import §_-25S§.§_-Zc§;
   import §_-26z§.§_-05v§;
   import §_-26z§.§_-1cO§;
   import §_-26z§.§_-3fS§;
   import §_-26z§.§_-445§;
   import §_-26z§.§_-4LH§;
   import §_-26z§.§_-57§;
   import §_-2Jw§.§_-40M§;
   import §_-2Jw§.§_-4Fg§;
   import §_-2Jw§.§_-FD§;
   import §_-33O§.§_-1I0§;
   import §_-3Hl§.§_-0B7§;
   import §_-3Hl§.§_-0bQ§;
   import §_-3Hl§.§_-2ei§;
   import §_-3Hl§.§_-3Q§;
   import §_-3Hl§.§_-3g-§;
   import §_-3Hl§.§_-4iX§;
   import §_-3Hl§.§_-KF§;
   import §_-3eU§.§_-1bK§;
   import §_-3eU§.§_-2xY§;
   import §_-3eU§.§_-3D8§;
   import §_-3eU§.§_-3Ee§;
   import §_-3eU§.§_-4Ym§;
   import §_-3eU§.§_-Z§;
   import §_-3eU§.§_-ZG§;
   import §_-3eU§.§_-dJ§;
   import §_-3eU§.§_-sp§;
   import §_-3eU§.§_-yE§;
   import §_-3nV§.§_-10K§;
   import §_-3nV§.§_-4RV§;
   import §_-3nV§.§_-4b5§;
   import §_-3zB§.§_-4Fl§;
   import §_-44B§.Map;
   import §_-4eH§.§_-2Ff§;
   import §_-ET§.§_-4ZR§;
   import flash.utils.getTimer;
   
   public class §_-2rR§ implements §_-3Q9§
   {
      
      private const §_-1jn§:int = 2500;
      
      private var §_-4XR§:§_-pC§;
      
      private var _disposed:Boolean;
      
      private var §_-1OH§:int = 0;
      
      private var §_-0a4§:String = "";
      
      private var §_-4ZY§:String = "";
      
      private var §_-34I§:§_-15i§ = null;
      
      private var _state:String = "RSE_CREATED";
      
      private var §_-0L-§:§_-58§;
      
      private var §_-4QE§:int = -1;
      
      private var §_-3dc§:Boolean = false;
      
      private var §_-nA§:int = 0;
      
      private var §_-2Xl§:int = 0;
      
      private var §_-2Me§:Boolean = false;
      
      private var §_-0y2§:Boolean = false;
      
      private var §_-2Gf§:Boolean = false;
      
      private var §_-JU§:int;
      
      private var §_-4XE§:Map = new Map();
      
      private var §_-Rh§:int = 0;
      
      private var _habboTracking:IHabboTracking = null;
      
      private var §_-Ka§:Boolean = false;
      
      private var §_-3cr§:Boolean = true;
      
      private var §_-0kM§:Boolean = false;
      
      private var §_-1Pc§:Boolean = false;
      
      private var §_-2gi§:§_-2Ff§ = null;
      
      public function §_-2rR§()
      {
         super();
         §_-0L-§ = new §_-58§();
      }
      
      public function set connection(param1:§_-pC§) : void
      {
         if(param1 == null)
         {
            return;
         }
         §_-4XR§ = param1;
         if(§_-0L-§ != null)
         {
            §_-0L-§.connection = param1;
         }
      }
      
      public function dispose() : void
      {
         §_-4XR§ = null;
         if(§_-0L-§ != null)
         {
            §_-0L-§.dispose();
            §_-0L-§ = null;
         }
         if(§_-4XE§ != null)
         {
            §_-4XE§.dispose();
            §_-4XE§ = null;
         }
         if(§_-34I§)
         {
            §_-34I§.dispose();
            §_-34I§ = null;
         }
         if(§_-2gi§ != null)
         {
            §_-2gi§ = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get roomId() : int
      {
         return §_-1OH§;
      }
      
      public function set roomId(param1:int) : void
      {
         §_-1OH§ = param1;
      }
      
      public function get §_-02Y§() : String
      {
         return §_-0a4§;
      }
      
      public function set §_-02Y§(param1:String) : void
      {
         §_-0a4§ = param1;
      }
      
      public function get §_-2ES§() : String
      {
         return §_-4ZY§;
      }
      
      public function set §_-2ES§(param1:String) : void
      {
         §_-4ZY§ = param1;
      }
      
      public function get §_-1aB§() : §_-15i§
      {
         return §_-34I§;
      }
      
      public function set §_-1aB§(param1:§_-15i§) : void
      {
         §_-34I§ = param1;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function get §_-Qh§() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function set §_-Qh§(param1:IHabboTracking) : void
      {
         _habboTracking = param1;
      }
      
      public function get §_-0Zc§() : Boolean
      {
         return §_-0kM§;
      }
      
      public function set §_-0Zc§(param1:Boolean) : void
      {
         §_-0kM§ = param1;
      }
      
      public function get §_-3Dx§() : §_-2Ff§
      {
         return §_-2gi§;
      }
      
      public function set §_-3Dx§(param1:§_-2Ff§) : void
      {
         §_-2gi§ = param1;
      }
      
      public function start() : Boolean
      {
         if(_state == "RSE_CREATED" && §_-4XR§ != null)
         {
            _state = "RSE_STARTED";
            if(§_-34I§)
            {
               return §_-Gv§();
            }
            return §_-1zs§();
         }
         return false;
      }
      
      public function reset(param1:int) : void
      {
         if(param1 != §_-1OH§)
         {
            §_-1OH§ = param1;
            §_-3dc§ = false;
            §_-nA§ = 0;
            §_-2Xl§ = 0;
            §_-0y2§ = false;
         }
      }
      
      private function §_-1zs§() : Boolean
      {
         if(§_-4XR§ == null)
         {
            return false;
         }
         §_-4XR§.send(new §_-FD§(§_-1OH§,§_-0a4§));
         return true;
      }
      
      private function §_-Gv§() : Boolean
      {
         if(§_-4XR§ == null)
         {
            return false;
         }
         §_-4XR§.send(§_-34I§);
         §_-34I§ = null;
         return true;
      }
      
      public function §_-1gs§(param1:String, param2:int = 0) : void
      {
         if(§_-0kM§)
         {
            §_-4XR§.send(new §_-1I0§(param1));
         }
         else
         {
            param1 = param1.replace(/&#[0-9]+;/g,"");
            §_-4XR§.send(new §_-05h§(param1,param2,§_-Rh§));
            §_-4XE§.add(§_-Rh§,getTimer());
            §_-Rh§ = §_-Rh§ + 1;
         }
      }
      
      public function §_-3cd§(param1:String) : void
      {
         §_-4XR§.send(new §_-0Q7§(param1));
      }
      
      public function §_-0F8§(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = §_-4XE§.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getTimer();
            if(_loc3_ - int(_loc2_) > 2500)
            {
               if(_habboTracking != null)
               {
                  _habboTracking.chatLagDetected(_loc3_);
               }
            }
         }
      }
      
      public function §_-33H§(param1:String, param2:int = 0) : void
      {
         §_-4XR§.send(new §_-09f§(param1,param2));
      }
      
      public function §_-2TL§(param1:String, param2:String, param3:int = 0) : void
      {
         §_-4XR§.send(new §_-3vY§(param1,param2,param3));
      }
      
      public function §_-30L§(param1:Boolean) : void
      {
         if(param1)
         {
            §_-4XR§.send(new §_-dy§());
         }
         else
         {
            §_-4XR§.send(new §_-3hM§());
         }
      }
      
      public function §_-2uA§(param1:int) : void
      {
         §_-4XR§.send(new §_-1C7§(param1));
      }
      
      public function §_-4E0§(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 17)
         {
            §_-4XR§.send(new §_-458§(param1));
         }
      }
      
      public function §_-4kG§(param1:int) : void
      {
         §_-4XR§.send(new §_-3AP§(param1));
      }
      
      public function §_-2L-§(param1:int) : void
      {
         §_-4XR§.send(new §_-3wg§(param1));
      }
      
      public function §_-2Y§(param1:int) : void
      {
         §_-4XR§.send(new §_-445§(param1));
      }
      
      public function §_-2YA§(param1:int) : void
      {
         §_-4XR§.send(new §_-4LH§(param1));
      }
      
      public function §_-1RU§(param1:int, param2:String) : void
      {
         §_-4XR§.send(new §_-3fS§(param1,param2));
      }
      
      public function §_-Kr§() : void
      {
         §_-4XR§.send(new §_-57§());
      }
      
      public function §_-1iQ§(param1:int, param2:int, param3:uint, param4:int, param5:Boolean) : void
      {
         var _loc6_:String = "000000" + param3.toString(16).toUpperCase();
         var _loc7_:String = "#" + _loc6_.substr(_loc6_.length - 6);
         §_-4XR§.send(new §_-05v§(param1,param2,_loc7_,param4,param5));
      }
      
      public function §_-20H§() : void
      {
         §_-4XR§.send(new §_-1cO§());
      }
      
      public function §_-3GN§(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void
      {
         §_-4XR§.send(new §_-4ZR§(param1,param2,param3,param4,param5));
      }
      
      public function §_-35Z§(param1:int) : void
      {
         §_-4XR§.send(new §_-10K§(param1));
      }
      
      public function §_-3QM§(param1:int) : void
      {
         §_-4XR§.send(new §_-4b5§(param1));
      }
      
      public function §_-1JT§(param1:int, param2:int, param3:Array) : void
      {
         §_-4XR§.send(new §_-4RV§(param1,param2,param3));
      }
      
      public function §_-0wh§(param1:String) : void
      {
         §_-4XR§.send(new §_-31d§(param1));
      }
      
      public function §_-0Ka§(param1:String) : void
      {
         §_-4XR§.send(new §_-3ty§(param1));
      }
      
      public function §_-Tl§(param1:int) : void
      {
         §_-4XR§.send(new §_-FD§(param1));
      }
      
      public function §_-v6§(param1:String) : void
      {
         §_-4XR§.send(new §_-jx§(param1));
      }
      
      public function §_-0A9§(param1:int) : void
      {
         §_-4XR§.send(new §_-3g-§(param1));
      }
      
      public function §_-2DS§(param1:int) : void
      {
         §_-4XR§.send(new §_-4iX§(param1));
      }
      
      public function §_-4Vj§(param1:int, param2:String) : void
      {
         §_-4XR§.send(new §_-2ei§(param1,param2,roomId));
      }
      
      public function §_-2qG§(param1:int, param2:int) : void
      {
         §_-4XR§.send(new §_-3Q§(param1,param2,roomId));
      }
      
      public function §_-1q1§(param1:int) : void
      {
         §_-4XR§.send(new §_-KF§(param1));
      }
      
      public function §_-3d2§(param1:int) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         var _loc2_:§_-0bQ§ = new §_-0bQ§(_loc3_);
         §_-4XR§.send(_loc2_);
      }
      
      public function §_-dj§(param1:String, param2:Boolean) : void
      {
         §_-4XR§.send(new §_-0B7§(param1,param2));
      }
      
      public function §_-4R§(param1:int) : void
      {
         §_-4XR§.send(new §_-2xY§(param1));
      }
      
      public function §_-4I7§(param1:int) : void
      {
         §_-4XR§.send(new §_-4Ym§(param1,true));
      }
      
      public function §_-252§(param1:int) : void
      {
         §_-4XR§.send(new §_-yE§(param1));
      }
      
      public function §_-2So§(param1:int) : void
      {
         §_-4XR§.send(new §_-1bK§(param1));
      }
      
      public function §_-12i§(param1:int) : void
      {
         §_-4XR§.send(new §_-4Ym§(param1,false));
      }
      
      public function §_-0o8§(param1:int) : void
      {
         §_-4XR§.send(new §_-dJ§(param1));
      }
      
      public function §_-35d§(param1:int) : void
      {
         §_-4XR§.send(new §_-ZG§(param1));
      }
      
      public function §_-2RQ§(param1:int) : void
      {
         §_-4XR§.send(new §_-Z§(param1));
      }
      
      public function §_-01j§(param1:int) : void
      {
         §_-4XR§.send(new §_-sp§(param1));
      }
      
      public function §_-1k§(param1:int, param2:int) : void
      {
         §_-4XR§.send(new §_-4Fl§(param1,param2));
      }
      
      public function §_-01J§(param1:int) : void
      {
         §_-4XR§.send(new §_-3D8§(param1));
      }
      
      public function §_-3vd§() : void
      {
         §_-4XR§.send(new §_-Zc§());
      }
      
      public function §_-0Ty§() : void
      {
         if(§_-4XR§ != null)
         {
            §_-4XR§.send(new §_-4Fg§());
         }
      }
      
      public function §_-4Pf§(param1:int) : void
      {
         if(§_-4XR§ == null)
         {
            return;
         }
         §_-4XR§.send(new §_-40M§(param1));
      }
      
      public function §_-44u§(param1:int, param2:String, param3:String) : void
      {
         if(§_-4XR§ == null)
         {
            return;
         }
         var _loc4_:§_-3Ee§ = new §_-3Ee§(param1,param2,param3);
         §_-4XR§.send(_loc4_);
         _loc4_.dispose();
         _loc4_ = null;
      }
      
      public function get §_-2gp§() : §_-W7§
      {
         return §_-0L-§ as §_-W7§;
      }
      
      public function get §_-4kZ§() : int
      {
         return §_-4QE§;
      }
      
      public function set §_-4kZ§(param1:int) : void
      {
         §_-4QE§ = param1;
      }
      
      public function set §_-0lf§(param1:Boolean) : void
      {
         §_-3dc§ = param1;
      }
      
      public function get §_-1Ti§() : Boolean
      {
         return §_-nA§ >= 1;
      }
      
      public function get §_-0lf§() : Boolean
      {
         return §_-3dc§;
      }
      
      public function set §_-423§(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 5)
         {
            §_-nA§ = param1;
         }
         else
         {
            Logger.log("Invalid roomControllerLevel " + param1 + ", setting to ROOM_CONTROL_LEVEL_NONE instead");
            §_-nA§ = 0;
         }
      }
      
      public function get §_-423§() : int
      {
         return §_-nA§;
      }
      
      public function get §_-BY§() : int
      {
         return §_-2Xl§;
      }
      
      public function get §_-12l§() : Boolean
      {
         return true;
      }
      
      public function set §_-BY§(param1:int) : void
      {
         §_-2Xl§ = param1;
      }
      
      public function get §_-1pT§() : Boolean
      {
         return §_-2Me§;
      }
      
      public function set §_-1pT§(param1:Boolean) : void
      {
         §_-2Me§ = param1;
      }
      
      public function get §_-1SN§() : Boolean
      {
         return §_-JU§ == 4;
      }
      
      public function set doorMode(param1:int) : void
      {
         §_-JU§ = param1;
      }
      
      public function get §_-0rn§() : Boolean
      {
         return §_-0y2§;
      }
      
      public function set §_-0rn§(param1:Boolean) : void
      {
         §_-0y2§ = param1;
      }
      
      public function get §_-2-c§() : Boolean
      {
         return §_-2Gf§;
      }
      
      public function set §_-2-c§(param1:Boolean) : void
      {
         §_-2Gf§ = param1;
      }
      
      public function get §_-1av§() : Boolean
      {
         return §_-3dc§;
      }
      
      public function get §_-Yc§() : Boolean
      {
         return §_-Ka§;
      }
      
      public function set §_-Yc§(param1:Boolean) : void
      {
         §_-Ka§ = param1;
      }
      
      public function get §_-2nm§() : Boolean
      {
         return §_-1Pc§;
      }
      
      public function set §_-2nm§(param1:Boolean) : void
      {
         §_-1Pc§ = param1;
      }
      
      public function get §_-3f-§() : Boolean
      {
         return §_-3cr§;
      }
      
      public function set §_-3f-§(param1:Boolean) : void
      {
         §_-3cr§ = param1;
      }
      
      public function §_-4Zp§() : Boolean
      {
         var _loc1_:Boolean = false;
         if(§_-3Dx§)
         {
            _loc1_ = §_-2Ud§(§_-3Dx§.§_-3UM§);
         }
         return _loc1_;
      }
      
      public function §_-00b§() : Boolean
      {
         var _loc1_:Boolean = false;
         if(§_-3Dx§)
         {
            _loc1_ = §_-2Ud§(§_-3Dx§.§_-kl§);
         }
         return _loc1_;
      }
      
      public function §_-2sC§() : Boolean
      {
         var _loc1_:Boolean = false;
         if(§_-3Dx§)
         {
            _loc1_ = §_-2Ud§(§_-3Dx§.§_-5f§);
         }
         return _loc1_;
      }
      
      private function §_-2Ud§(param1:int) : Boolean
      {
         switch(param1)
         {
            case 0:
               return §_-0lf§;
            case 1:
               return §_-1Ti§;
            case 2:
               return true;
            case 4:
               return §_-1pT§ && §_-423§ >= 3;
            case 5:
               return §_-1pT§ && §_-423§ >= 2;
            default:
               return false;
         }
      }
   }
}

