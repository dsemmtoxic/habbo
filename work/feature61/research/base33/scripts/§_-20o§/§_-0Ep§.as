package §_-20o§
{
   import §_-1Ab§.§_-nO§;
   import starling.textures.Texture;
   
   public class §_-0Ep§
   {
      
      private static var §_-3m-§:int;
      
      private var §_-1tQ§:int;
      
      private var §_-2M4§:int;
      
      private var §_-L2§:String;
      
      private var §_-4O5§:String;
      
      private var §_-1An§:Texture;
      
      private var §_-2CV§:§_-nO§;
      
      private var §_-2cr§:Boolean;
      
      public function §_-0Ep§(param1:int)
      {
         super();
         §_-1tQ§ = ++§_-3m-§;
         §_-2M4§ = param1;
         §_-2CV§ = new §_-nO§();
      }
      
      public function dispose() : void
      {
         if(§_-1An§)
         {
            §_-1An§.dispose();
            §_-1An§ = null;
         }
         §_-2CV§ = null;
      }
      
      public function get §_-0MK§() : Boolean
      {
         return §_-2cr§;
      }
      
      public function set §_-0MK§(param1:Boolean) : void
      {
         §_-2cr§ = param1;
      }
      
      public function §_-0An§(param1:§_-2uW§) : void
      {
         §_-0MK§ = true;
         §_-2CV§.push(param1);
      }
      
      public function §_-Ag§(param1:int) : void
      {
         var _loc2_:§_-2uW§ = new §_-2uW§(4,0,"",param1);
         _loc2_.§_-2Vw§ = true;
         §_-2CV§.push(_loc2_);
      }
      
      public function get messages() : §_-nO§
      {
         return §_-2CV§;
      }
      
      public function get §_-3aV§() : int
      {
         return §_-2M4§;
      }
      
      public function set §_-0pO§(param1:Texture) : void
      {
         §_-1An§ = param1;
      }
      
      public function get §_-0pO§() : Texture
      {
         return §_-1An§;
      }
      
      public function get §_-2zr§() : String
      {
         return §_-L2§;
      }
      
      public function set §_-2zr§(param1:String) : void
      {
         §_-L2§ = param1;
      }
      
      public function get §_-1DA§() : String
      {
         return §_-4O5§;
      }
      
      public function set §_-1DA§(param1:String) : void
      {
         §_-4O5§ = param1;
      }
      
      public function get id() : int
      {
         return §_-1tQ§;
      }
      
      public function get §_-2U1§() : Boolean
      {
         for each(var _loc1_:§_-2uW§ in §_-2CV§.data)
         {
            if(_loc1_.type == 2)
            {
               return true;
            }
         }
         return false;
      }
   }
}

