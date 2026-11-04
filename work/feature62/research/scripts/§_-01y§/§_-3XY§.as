package §_-01y§
{
   import §_-0AB§.§_-3gO§;
   import §_-0AB§.§_-4hO§;
   import §_-0KT§.§_-CG§;
   import §_-0tl§.§_-15i§;
   import §_-112§.§_-1Ia§;
   import §_-1iL§.§_-Ro§;
   import §_-44B§.Map;
   import §_-vL§.§_-no§;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface §_-3XY§ extends §_-CG§
   {
      
      function get events() : IEventDispatcher;
      
      function get §_-t3§() : Boolean;
      
      function get §_-0Y§() : int;
      
      function §_-7N§(param1:int, param2:int, param3:int, param4:int, param5:int) : DisplayObject;
      
      function createRoomCanvas3d(param1:int, param2:int, param3:int, param4:int, param5:int) : §_-1Ia§;
      
      function §_-16h§(param1:int, param2:int, param3:Number, param4:Point = null, param5:Point = null, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void;
      
      function §_-0B6§(param1:int, param2:int, param3:int, param4:int) : Boolean;
      
      function §_-Ev§(param1:int) : Array;
      
      function §_-0np§(param1:int, param2:int, param3:Boolean) : void;
      
      function §_-2H8§(param1:int, param2:int = -1) : §_-4hO§;
      
      function §_-39N§(param1:int, param2:int = -1) : Point;
      
      function §_-2YM§(param1:int, param2:int, param3:Point) : Boolean;
      
      function §_-2fL§(param1:int = -1000, param2:int = -1) : Number;
      
      function get §_-1Mv§() : §_-0du§;
      
      function §_-3-d§(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void;
      
      function §_-1sP§(param1:int) : void;
      
      function §_-1Jo§(param1:int, param2:String) : Number;
      
      function §_-2gL§(param1:int, param2:String) : String;
      
      function §_-1OU§(param1:int) : §_-27Z§;
      
      function §_-27a§(param1:int, param2:§_-3eA§, param3:String = null, param4:§_-0z5§ = null) : ImageResult;
      
      function §_-2HO§(param1:int, param2:String = null) : §_-27Z§;
      
      function §_-05r§(param1:int, param2:§_-3eA§, param3:String = null) : ImageResult;
      
      function §_-1LW§(param1:int, param2:§_-3gO§, param3:int, param4:§_-3eA§, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1, param9:§_-0z5§ = null) : ImageResult;
      
      function §_-4e§(param1:String, param2:String, param3:§_-3gO§, param4:int, param5:§_-3eA§, param6:uint = 0, param7:String = null, param8:§_-0z5§ = null, param9:int = -1, param10:int = -1, param11:String = null, param12:int = -1) : ImageResult;
      
      function §_-3Ie§(param1:int, param2:§_-3gO§, param3:int, param4:§_-3eA§, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1) : ImageResult;
      
      function §_-1op§(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:int, param6:§_-3eA§, param7:Boolean = true, param8:uint = 0, param9:Array = null, param10:String = null) : ImageResult;
      
      function §_-3xS§(param1:String, param2:String, param3:String, param4:int, param5:§_-3eA§, param6:String = null) : ImageResult;
      
      function getRoomObjectImage(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:int, param6:§_-3eA§, param7:uint = 0) : ImageResult;
      
      function §_-4b3§(param1:int, param2:int, param3:int, param4:int) : Rectangle;
      
      function §_-8k§(param1:int, param2:int, param3:int, param4:int = -1) : Point;
      
      function §_-tq§(param1:int) : Rectangle;
      
      function §_-2vx§(param1:int, param2:int) : int;
      
      function §_-46h§(param1:int, param2:int, param3:int) : §_-Ro§;
      
      function §_-2Fe§(param1:int, param2:int, param3:int) : §_-Ro§;
      
      function §_-4KB§(param1:int, param2:int, param3:int, param4:int) : Vector.<§_-Ro§>;
      
      function §_-0nC§(param1:int, param2:int, param3:int, param4:String) : Boolean;
      
      function §_-1xe§(param1:int) : void;
      
      function §_-06E§(param1:int, param2:int, param3:String, param4:Map) : Boolean;
      
      function §_-16P§(param1:int, param2:int, param3:String, param4:String) : Boolean;
      
      function §_-4XA§(param1:int, param2:int) : Boolean;
      
      function §_-1Tl§(param1:String, param2:Boolean, param3:int, param4:int, param5:int, param6:String = null, param7:§_-0z5§ = null, param8:int = -1, param9:int = -1, param10:String = null) : Boolean;
      
      function §_-1v9§() : Boolean;
      
      function §_-2Zf§() : void;
      
      function §_-1ll§() : Boolean;
      
      function §_-3Hk§(param1:int, param2:int) : void;
      
      function §_-0fr§(param1:int, param2:int, param3:int) : void;
      
      function §_-2Fx§(param1:int) : String;
      
      function getSelectedObjectData(param1:int) : §_-4ik§;
      
      function §_-0un§() : int;
      
      function §_-3rr§(param1:int, param2:uint, param3:int, param4:Boolean) : Boolean;
      
      function §_-22r§(param1:int, param2:Boolean, param3:int, param4:int, param5:int) : Boolean;
      
      function §_-2-D§(param1:int, param2:int) : §_-1A-§;
      
      function §_-3PD§(param1:int, param2:String) : Array;
      
      function §_-02a§(param1:int, param2:String) : int;
      
      function §_-4TG§(param1:int, param2:String) : §_-1A-§;
      
      function §_-1E3§(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:§_-3gO§, param6:int, param7:§_-0z5§, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1) : Boolean;
      
      function §_-2Os§(param1:int, param2:int, param3:int) : void;
      
      function §_-i1§(param1:int, param2:int, param3:int, param4:String, param5:int) : Boolean;
      
      function §_-3M0§(param1:int, param2:int, param3:int = -1, param4:Boolean = false) : void;
      
      function §_-2M3§(param1:int, param2:int, param3:int, param4:§_-3gO§, param5:§_-3gO§, param6:int, param7:String, param8:int = 0, param9:int = 0, param10:String = "", param11:int = -1, param12:Boolean = true) : Boolean;
      
      function §_-1tu§(param1:int, param2:int, param3:§_-3gO§) : Boolean;
      
      function §_-0He§(param1:int, param2:int, param3:int = -1) : void;
      
      function §_-2Kl§(param1:int, param2:int, param3:§_-3gO§, param4:§_-3gO§, param5:Number, param6:int, param7:String = null) : Boolean;
      
      function §_-3R5§(param1:int, param2:int, param3:§_-3gO§, param4:§_-3gO§, param5:Boolean = false, param6:Number = 0, param7:§_-3gO§ = null, param8:Number = NaN) : Boolean;
      
      function §_-3Oa§(param1:int, param2:int, param3:String, param4:String = null, param5:String = null, param6:Boolean = false) : Boolean;
      
      function §_-12h§(param1:int, param2:int, param3:String, param4:String = "") : Boolean;
      
      function §_-0UN§(param1:int, param2:int, param3:int) : Boolean;
      
      function §_-0gW§(param1:int, param2:int, param3:int, param4:int = 0) : Boolean;
      
      function §_-0jQ§(param1:int, param2:int, param3:String, param4:int, param5:String = null) : Boolean;
      
      function §_-1t9§(param1:int, param2:int) : void;
      
      function §_-1SO§(param1:int, param2:int) : int;
      
      function §_-1nu§(param1:int, param2:int) : int;
      
      function §_-Xa§(param1:int, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false) : Boolean;
      
      function §_-dZ§(param1:int) : String;
      
      function §_-1qF§(param1:String) : int;
      
      function §_-fc§(param1:int, param2:String = null) : String;
      
      function §_-1vN§() : String;
      
      function §_-3hC§() : String;
      
      function §_-2WM§(param1:int, param2:int) : Boolean;
      
      function §_-K4§() : §_-Ro§;
      
      function §_-4El§(param1:int, param2:XML) : void;
      
      function §_-0C7§(param1:int) : void;
      
      function get §_-08m§() : Boolean;
      
      function set §_-06t§(param1:Boolean) : void;
      
      function get §_-06t§() : Boolean;
      
      function §_-7W§(param1:int, param2:int, param3:int = -1) : void;
      
      function §_-262§(param1:int) : void;
      
      function §_-3-C§(param1:int) : §_-2v0§;
      
      function §_-0Cn§(param1:int) : §_-4NV§;
      
      function get sessionDataManager() : §_-no§;
      
      function §_-4XB§(param1:int, param2:int) : void;
      
      function §_-3kg§(param1:int, param2:Boolean) : void;
      
      function §_-4az§(param1:int) : void;
      
      function §_-01n§(param1:int) : void;
      
      function §_-1Xp§(param1:int, param2:int, param3:BitmapData, param4:Matrix, param5:Boolean) : Boolean;
      
      function set §_-3K4§(param1:Boolean) : void;
      
      function §_-1Y8§() : void;
      
      function §_-PU§(param1:int, param2:Boolean, param3:Boolean = true) : Boolean;
      
      function get §_-0qa§() : int;
      
      function set §_-0qa§(param1:int) : void;
      
      function get §_-H9§() : int;
      
      function set §_-H9§(param1:int) : void;
      
      function §_-3Zl§(param1:Rectangle, param2:uint, param3:Boolean = false) : §_-15i§;
      
      function §_-12R§() : void;
      
      function §_-0Ox§(param1:int, param2:int, param3:String) : void;
      
      function §_-3Vw§(param1:int, param2:Boolean) : void;
   }
}

