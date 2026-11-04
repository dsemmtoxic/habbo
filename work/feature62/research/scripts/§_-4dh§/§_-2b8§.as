package §_-4dh§
{
   import §_-0AB§.§_-0By§;
   import §_-0KT§.§_-2tN§;
   import §_-0ir§.AGALMiniAssembler;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.Program3D;
   import flash.display3D.VertexBuffer3D;
   import flash.utils.ByteArray;
   
   public class §_-2b8§ implements §_-2tN§
   {
      
      public static const §_-1Yk§:String = "image";
      
      public static const §_-0be§:String = "colors";
      
      private var §_-3-b§:uint;
      
      private var §_-0t§:uint;
      
      private var §_-1cS§:Program3D;
      
      private var §_-cK§:IndexBuffer3D;
      
      private var §_-0OB§:VertexBuffer3D;
      
      private var _context:Context3D;
      
      private var §_-4LB§:§_-3mZ§;
      
      private var §_-1ux§:String = "image";
      
      private var §_-3RQ§:BitmapData;
      
      public function §_-2b8§(param1:Context3D)
      {
         super();
         this.context = param1;
      }
      
      private static function §_-3Cj§() : ByteArray
      {
         var _loc1_:String = "mov op, va0\nmov v0, va1";
         return new AGALMiniAssembler(false).assemble("vertex",_loc1_);
      }
      
      private static function §_-2P§() : ByteArray
      {
         var _loc1_:String = "mov oc, v0";
         return new AGALMiniAssembler(false).assemble("fragment",_loc1_);
      }
      
      public function dispose() : void
      {
         §_-4Zt§();
         if(§_-3RQ§)
         {
            §_-3RQ§.dispose();
            §_-3RQ§ = null;
         }
         if(§_-4LB§ != null)
         {
            §_-4LB§.dispose();
            §_-4LB§ = null;
         }
         _context = null;
      }
      
      public function colors(param1:uint, param2:uint) : void
      {
         §_-3-b§ = param1;
         §_-0t§ = param2;
         §_-4Zt§();
         §_-1ux§ = "colors";
      }
      
      public function §_-37r§(param1:BitmapData) : void
      {
         if(§_-3RQ§)
         {
            §_-3RQ§.dispose();
            §_-3RQ§ = null;
         }
         §_-3RQ§ = param1.clone();
         if(!_context || _context.driverInfo == null || _context.driverInfo == "Disposed")
         {
            return;
         }
         if(§_-4LB§ == null)
         {
            §_-4LB§ = new §_-3mZ§(_context);
         }
         §_-4LB§.bitmapData = param1;
         §_-1ux§ = "image";
      }
      
      public function set mode(param1:String) : void
      {
         §_-1ux§ = param1;
      }
      
      public function set context(param1:Context3D) : void
      {
         if(param1 == _context)
         {
            return;
         }
         _context = param1;
         §_-4Zt§();
         if(§_-4LB§)
         {
            §_-4LB§.dispose();
            §_-4LB§ = null;
         }
         if(§_-3RQ§)
         {
            §_-4LB§ = new §_-3mZ§(_context);
            §_-4LB§.bitmapData = §_-3RQ§;
         }
      }
      
      private function §_-4Zt§() : void
      {
         if(§_-0OB§)
         {
            §_-0OB§.dispose();
            §_-0OB§ = null;
            §_-1cS§.dispose();
            §_-1cS§ = null;
            §_-cK§.dispose();
            §_-cK§ = null;
         }
      }
      
      public function render() : void
      {
         if(!_context || _context.profile == null || _context.profile == "Disposed")
         {
            return;
         }
         if(§_-1ux§ == "colors")
         {
            if(!§_-0OB§)
            {
               §_-0HO§(_context);
            }
            _context.setBlendFactors("one","zero");
            _context.setProgram(§_-1cS§);
            _context.setVertexBufferAt(0,§_-0OB§,0,"float2");
            _context.setVertexBufferAt(1,§_-0OB§,2,"float3");
            _context.drawTriangles(§_-cK§,0,2);
            _context.setVertexBufferAt(0,null);
            _context.setVertexBufferAt(1,null);
         }
         if(§_-1ux§ == "image")
         {
            if(§_-4LB§)
            {
               §_-4LB§.render();
            }
         }
      }
      
      private function §_-0HO§(param1:Context3D) : void
      {
         §_-0OB§ = param1.createVertexBuffer(4,5);
         §_-1cS§ = param1.createProgram();
         §_-cK§ = param1.createIndexBuffer(6);
         §_-cK§.uploadFromVector(Vector.<uint>([0,1,2,2,0,3]),0,6);
         §_-1cS§.upload(§_-3Cj§(),§_-2P§());
         §_-1w8§();
      }
      
      private function §_-1w8§() : void
      {
         var _loc6_:Number = (§_-3-b§ >> 16 & 0xFF) / 255;
         var _loc3_:Number = (§_-3-b§ >> 8 & 0xFF) / 255;
         var _loc7_:Number = (§_-3-b§ & 0xFF) / 255;
         var _loc1_:Number = (§_-0t§ >> 16 & 0xFF) / 255;
         var _loc4_:Number = (§_-0t§ >> 8 & 0xFF) / 255;
         var _loc2_:Number = (§_-0t§ & 0xFF) / 255;
         var _loc5_:Vector.<Number> = Vector.<Number>([-1,-1,_loc1_,_loc4_,_loc2_,1,-1,_loc1_,_loc4_,_loc2_,1,1,_loc6_,_loc3_,_loc7_,-1,1,_loc6_,_loc3_,_loc7_]);
         §_-0OB§.uploadFromVector(_loc5_,0,4);
      }
      
      public function §_-3g9§(param1:int, param2:int, param3:int) : void
      {
         §_-3-b§ = §_-0By§.§_-1Bw§(((param1 & 0xFF) << 16) + ((param2 & 0xFF) << 8) + (param3 & 0xFF));
         var _loc4_:int = int(Math.max(param3 - 40,0));
         §_-0t§ = §_-0By§.§_-1Bw§(((param1 & 0xFF) << 16) + ((param2 & 0xFF) << 8) + (_loc4_ & 0xFF));
         §_-1w8§();
      }
   }
}

