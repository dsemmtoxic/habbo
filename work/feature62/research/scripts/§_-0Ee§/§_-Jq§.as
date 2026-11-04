package §_-0Ee§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   
   public class §_-Jq§
   {
      
      public static const §_-3B6§:String = "window";
      
      public static const §_-w5§:String = "hole";
      
      private var §_-0sG§:Vector3d = null;
      
      private var _type:String = null;
      
      private var §_-0q6§:String = null;
      
      public function §_-Jq§(param1:String, param2:§_-3gO§, param3:String)
      {
         super();
         this.type = param1;
         this.§_-UL§ = param2;
         this.category = param3;
      }
      
      public function get §_-UL§() : §_-3gO§
      {
         return §_-0sG§;
      }
      
      public function set §_-UL§(param1:§_-3gO§) : void
      {
         if(§_-0sG§ == null)
         {
            §_-0sG§ = new Vector3d();
         }
         §_-0sG§.§_-4Dq§(param1);
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function get category() : String
      {
         return §_-0q6§;
      }
      
      public function set category(param1:String) : void
      {
         §_-0q6§ = param1;
      }
      
      public function dispose() : void
      {
         §_-0sG§ = null;
      }
   }
}

