package §_-2-R§
{
   import §_-0Lu§.§_-25C§;
   import §_-0Lu§.§_-3fa§;
   import §_-0iC§.§_-1mt§;
   import §_-0iC§.§_-BX§;
   import §_-1Ab§.§_-nO§;
   import §_-1N-§.§_-2mJ§;
   import §_-1WR§.§_-2Xz§;
   import §_-20o§.§_-0Ep§;
   import §_-20o§.§_-2uW§;
   import §_-20o§.§_-4bn§;
   import §_-2xS§.Alert;
   import §_-2xS§.LayoutGroup;
   import §_-2xS§.§_-0xe§;
   import §_-2xS§.§_-1XI§;
   import loginpatch.HabboTicketLogin;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class §_-6S§ extends LayoutGroup
   {
      
      public static const §_-1zm§:String = "conversation_slot_keyboard_active";
      
      public static const §_-0Kc§:String = "conversation_slot_keyboard_inactive";
      
      private var §_-1dL§:§_-4bn§;
      
      private var §_-0t0§:int;
      
      private var §_-3v4§:§_-0xe§;
      
      private var §_-02y§:§_-1XI§;
      
      private var §_-4ba§:§_-0Ep§;
      
      private var §_-2PT§:§_-BX§;
      
      private var §_-0US§:§_-BX§;
      
      public function §_-6S§(param1:§_-4bn§)
      {
         super();
         §_-1dL§ = param1;
         createView();
         §_-1iq§ = null;
      }
      
      override public function dispose() : void
      {
         §_-3v4§ = null;
         §_-02y§ = null;
         §_-2PT§ = null;
         §_-0US§ = null;
         §_-4ba§ = null;
         §_-1dL§ = null;
         super.dispose();
      }
      
      public function set §_-1iq§(param1:§_-0Ep§) : void
      {
         if(param1 == null)
         {
            this.visible = false;
            §_-0t0§ = -1;
         }
         else
         {
            this.visible = true;
            §_-0t0§ = param1.id;
            §_-4ba§ = param1;
            if(§_-3v4§.dataProvider)
            {
               §_-3v4§.dataProvider.removeEventListener("addItem",§_-2Ga§);
               §_-3v4§.dataProvider.removeEventListener("reset",§_-2Ga§);
            }
            §_-3v4§.dataProvider = param1.messages;
            §_-3v4§.dataProvider.addEventListener("addItem",§_-2Ga§);
            §_-3v4§.dataProvider.addEventListener("reset",§_-2Ga§);
            §_-1Ko§(false);
         }
         HabboTicketLogin.consoleOpened(this.§_-1dL§,param1,this.§_-3v4§);
      }
      
      public function get §_-4Pi§() : int
      {
         return §_-0t0§;
      }
      
      private function createView() : void
      {
         this.layout = new §_-1mt§();
         var _loc1_:int = §_-2mJ§.§_-17E§(20);
         §_-02y§ = new §_-1XI§();
         §_-02y§.§_-G7§ = true;
         §_-02y§.isFocusEnabled = true;
         §_-02y§.maxChars = 150;
         §_-02y§.§_-31i§ = "Damn you auto correct!";
         §_-02y§.styleNameList.add("alternate-chat-input");
         §_-02y§.addEventListener("enter",§_-5K§);
         §_-02y§.addEventListener("focusIn",§_-eq§);
         §_-02y§.addEventListener("focusOut",§_-0pp§);
         §_-02y§.addEventListener("softKeyboardDeactivate",§_-0pp§);
         §_-02y§.prompt = "${messenger.message_prompt}";
         §_-02y§.validate();
         addChild(§_-02y§);
         §_-0US§ = new §_-BX§(NaN,0,int(Starling.current.stage.stageHeight / 2),0);
         §_-2PT§ = new §_-BX§(NaN,0,0,0);
         §_-02y§.layoutData = §_-2PT§;
         §_-3v4§ = new §_-0xe§();
         §_-3v4§.horizontalScrollPolicy = "off";
         §_-3v4§.scrollBarDisplayMode = "fixed";
         var _loc2_:§_-BX§ = new §_-BX§(_loc1_,0,_loc1_,0);
         _loc2_.§_-44E§ = §_-02y§;
         §_-3v4§.layoutData = _loc2_;
         §_-3v4§.§_-1ct§ = §_-2Rc§;
         §_-3v4§.styleNameList.add("alternate-messenger-message-list");
         §_-3v4§.typicalItem = new §_-2uW§(1,0,"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",0);
         §_-3v4§.addEventListener("resize",§_-3jj§);
         addChild(§_-3v4§);
      }
      
      private function §_-37h§(param1:Event) : void
      {
         var _loc2_:int = §_-4ba§.§_-3aV§;
         var _loc5_:Boolean = §_-1dL§.habboUI.§_-0dH§.§_-2tw§(_loc2_);
         if(!_loc5_)
         {
            Alert.show("${friendlist.followerror.offline}","${friendlist.alert.title}",new §_-nO§([{"label":"${generic.ok}"}]));
            return;
         }
         var _loc4_:Boolean = §_-1dL§.habboUI.§_-0dH§.§_-2Kf§(_loc2_);
         if(!_loc4_)
         {
            Alert.show("${friendlist.followerror.prevented}","${friendlist.alert.title}",new §_-nO§([{"label":"${generic.ok}"}]));
            return;
         }
         var _loc3_:§_-25C§ = new §_-25C§(_loc2_);
         §_-1dL§.communication.connection.send(_loc3_);
         §_-1dL§.habboUI.§_-38x§(1);
      }
      
      private function §_-1Ko§(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         if(§_-4ba§ && §_-4ba§.messages)
         {
            §_-3v4§.§_-2kw§();
            §_-3v4§.validate();
            _loc2_ = param1 ? 0.5 : 0;
            §_-3v4§.scrollToPosition(0,§_-3v4§.maxVerticalScrollPosition,_loc2_);
            if(this.stage && §_-4ba§.§_-0MK§)
            {
               §_-1dL§.§_-dz§(§_-4ba§);
            }
         }
      }
      
      private function §_-3jj§(param1:Event) : void
      {
         §_-1Ko§(false);
      }
      
      private function §_-eq§(param1:Event) : void
      {
         if(§_-2mJ§.§_-17Z§() != 2)
         {
            §_-02y§.layoutData = §_-0US§;
            dispatchEventWith("conversation_slot_keyboard_active");
         }
      }
      
      private function §_-0pp§(param1:Event) : void
      {
         if(§_-2mJ§.§_-17Z§() != 2 && param1.target == §_-02y§)
         {
            §_-02y§.layoutData = §_-2PT§;
            dispatchEventWith("conversation_slot_keyboard_inactive");
         }
         if(§_-2mJ§.isAndroid())
         {
            §_-5K§(param1);
         }
      }
      
      private function §_-2Ga§(param1:Event) : void
      {
         if(HabboTicketLogin.insertingConsoleHistory())
         {
            return;
         }
         §_-1Ko§(true);
      }
      
      private function §_-5K§(param1:Event) : void
      {
         if(!§_-4ba§ || !§_-02y§ || §_-02y§.text == "")
         {
            return;
         }
         var _loc3_:§_-2Xz§ = §_-1dL§.habboUI.§_-0dH§;
         var _loc2_:Boolean = _loc3_ && _loc3_.§_-2tw§(§_-4ba§.§_-3aV§);
         var _loc4_:§_-2uW§ = new §_-2uW§(1,§_-1dL§.habboUI.sessionDataManager.userId,§_-02y§.text,0);
         §_-1dL§.send(new §_-3fa§(§_-4ba§.§_-3aV§,§_-02y§.text));
         §_-02y§.text = "";
         if(_loc2_)
         {
            §_-4ba§.§_-0An§(_loc4_);
         }
         else
         {
            §_-3v4§.dataProvider.removeEventListener("addItem",§_-2Ga§);
            §_-4ba§.§_-0An§(_loc4_);
            §_-4ba§.§_-0An§(new §_-2uW§(4,0,"${messenger.notification.persisted_message_sent}",0));
            §_-3v4§.dataProvider.addEventListener("addItem",§_-2Ga§);
            §_-1Ko§(true);
         }
         §_-1dL§.§_-2v§(§_-4ba§);
      }
   }
}

