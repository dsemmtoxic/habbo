package §_-0gs§
{
   import §_-0AB§.Vector3d;
   import §_-0AB§.§_-3gO§;
   import §_-2C1§.§_-0Rb§;
   
   public class §_-1cl§ extends §_-0Rb§
   {
      
      public static const §_-0bg§:String = "RORMUM_ADD_MASK";
      
      public static const §_-4mf§:String = "RORMUM_ADD_MASK";
      
      public static const §_-39v§:String = "door";
      
      public static const §_-3B6§:String = "window";
      
      public static const §_-w5§:String = "hole";
      
      private var _type:String = "";
      
      private var §_-2Bn§:String = "";
      
      private var §_-1gm§:String = "";
      
      private var §_-1QV§:Vector3d = null;
      
      private var §_-aq§:String = "window";
      
      public function §_-1cl§(param1:String, param2:String, param3:String = null, param4:§_-3gO§ = null, param5:String = "window")
      {
         super(null,null);
         _type = param1;
         §_-2Bn§ = param2;
         §_-1gm§ = param3;
         if(param4 != null)
         {
            §_-1QV§ = new Vector3d(param4.x,param4.y,param4.z);
         }
         §_-aq§ = param5;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get §_-4VP§() : String
      {
         return §_-2Bn§;
      }
      
      public function get §_-0K3§() : String
      {
         return §_-1gm§;
      }
      
      public function get §_-1z2§() : §_-3gO§
      {
         return §_-1QV§;
      }
      
      public function get §_-4A9§() : String
      {
         return §_-aq§;
      }
   }
}

