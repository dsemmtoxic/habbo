package §_-2-R§
{
   import §_-0iC§.§_-1mt§;
   import §_-1N-§.§_-2mJ§;
   import §_-20o§.§_-2uW§;
   import §_-2xS§.§_-Fk§;
   import §_-3La§.Scale9Image;
   import §_-4J6§.§_-12P§;
   
   public class §_-2Rc§ extends §_-12P§
   {
      
      private static const §_-49U§:int = §_-2mJ§.§_-17E§(20);
      
      private static const §_-3OT§:int = §_-2mJ§.§_-17E§(35);
      
      private static const §_-ez§:int = §_-2mJ§.§_-17E§(200);
      
      private var §_-2pq§:Scale9Image;
      
      private var §_-3i2§:§_-Fk§;
      
      public function §_-2Rc§()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layout = new §_-1mt§();
         §_-2pq§ = new Scale9Image(HitchTheme.§_-18-§("background-transp-dark"));
         §_-2pq§.textureScale = §_-2mJ§.§_-0-S§();
         addChild(§_-2pq§);
         §_-3i2§ = new §_-Fk§();
         §_-3i2§.wordWrap = true;
         §_-3i2§.y = §_-49U§;
         addChild(§_-3i2§);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(§_-2BC§("data"))
         {
            commitData();
         }
      }
      
      override protected function commitData() : void
      {
         var _loc1_:§_-2uW§ = §_-0SL§ as §_-2uW§;
         §_-3i2§.text = _loc1_.message;
         switch(_loc1_.type - 1)
         {
            case 0:
               §_-2pP§();
               break;
            case 1:
               §_-4VG§();
               break;
            case 2:
            case 3:
            case 4:
               §_-0zu§();
         }
      }
      
      private function §_-4VG§() : void
      {
         §_-2pq§.textures = HitchTheme.§_-18-§("messenger_type_peer");
         §_-3i2§.maxWidth = width * 0.8 - §_-49U§ - §_-49U§;
         §_-3i2§.minWidth = §_-ez§;
         §_-3i2§.textRendererProperties.textFormat = HitchTheme.§_-2pn§;
         §_-3i2§.validate();
         var _loc2_:int = §_-49U§ + §_-3i2§.width + §_-49U§;
         var _loc1_:int = §_-49U§ + §_-3i2§.height + §_-3OT§;
         §_-2v9§(_loc2_,_loc1_,0,§_-49U§);
      }
      
      private function §_-2pP§() : void
      {
         §_-2pq§.textures = HitchTheme.§_-18-§("messenger_type_me");
         §_-3i2§.maxWidth = width * 0.8 - §_-49U§ - §_-49U§;
         §_-3i2§.minWidth = §_-ez§;
         §_-3i2§.textRendererProperties.textFormat = HitchTheme.§_-in§;
         §_-3i2§.validate();
         var _loc3_:int = §_-49U§ + §_-3i2§.width + §_-49U§;
         var _loc2_:int = §_-49U§ + §_-3i2§.height + §_-3OT§;
         var _loc1_:int = width - _loc3_;
         §_-2v9§(_loc3_,_loc2_,_loc1_,§_-49U§);
      }
      
      private function §_-0zu§() : void
      {
         §_-2pq§.textures = HitchTheme.§_-18-§("background-transp-dark");
         §_-3i2§.maxWidth = width;
         §_-3i2§.validate();
         var _loc3_:int = width;
         §_-3i2§.textRendererProperties.textFormat = HitchTheme.§_-0cx§;
         var _loc2_:int = §_-49U§ + §_-3i2§.height + §_-49U§;
         var _loc1_:int = width - _loc3_;
         §_-2v9§(_loc3_,_loc2_,_loc1_,§_-49U§);
      }
      
      private function §_-2v9§(param1:int, param2:int, param3:int, param4:int) : void
      {
         §_-2pq§.width = param1;
         §_-2pq§.height = param2;
         §_-2pq§.x = param3;
         §_-3i2§.x = param3 + param4;
         height = param2;
         invalidate("layout");
      }
   }
}

