package §_-20o§
{
   import §_-0cq§.§_-qE§;
   import §_-0tl§.§_-15i§;
   import §_-0tl§.§_-3gH§;
   import §_-1Ab§.§_-nO§;
   import §_-1WR§.§_-1lI§;
   import §_-1WR§.§_-Nk§;
   import §_-2lx§.§_-2Jj§;
   import §_-2xS§.Alert;
   import §_-3fm§.§_-2al§;
   import §_-3fm§.§_-2m7§;
   import §_-4Em§.§_-2It§;
   import §_-4Em§.§_-2Mk§;
   import §_-4Em§.§_-4MM§;
   import §_-eT§.§_-1oI§;
   import §_-eT§.§_-3GR§;
   import §_-eT§.§_-45Z§;
   import §_-pp§.§_-0S9§;
   import §_-pp§.§_-4Wj§;
   import §_-vL§.§_-no§;
   import flash.display.BitmapData;
   import flash.events.Event;
   import loginpatch.HabboTicketLogin;
   import starling.textures.Texture;
   
   public class §_-4bn§ implements §_-2m7§
   {
      
      private static const §_-3bF§:int = 1;
      
      private static var §_-1B3§:§_-2Jj§;
      
      private var §_-33k§:§_-0S9§;
      
      private var _communication:§_-qE§;
      
      private var §_-32n§:§_-no§;
      
      private var _messageEvents:Vector.<§_-3gH§>;
      
      private var §_-4Ne§:§_-nO§;
      
      private var §_-101§:Boolean;
      
      public function §_-4bn§(param1:§_-0S9§, param2:§_-qE§, param3:§_-2Jj§, param4:§_-no§)
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:§_-2uW§ = null;
         var _loc9_:§_-0Ep§ = null;
         super();
         §_-33k§ = param1;
         _communication = param2;
         §_-1B3§ = param3;
         §_-32n§ = param4;
         §_-4Ne§ = new §_-nO§();
         addMessageEvent(new §_-3GR§(§_-1B4§));
         addMessageEvent(new §_-1oI§(§_-2gk§));
         addMessageEvent(new §_-45Z§(§_-fV§));
         var _loc7_:Vector.<§_-2uW§> = §_-4Wj§.§_-1Mt§();
         if(_loc7_)
         {
            _loc6_ = int(_loc7_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc5_ = _loc7_[_loc8_];
               _loc9_ = §_-35o§(_loc5_.§_-0UP§);
               _loc9_.§_-0An§(_loc5_);
               _loc9_.§_-Ag§(_loc5_.§_-3y9§);
               _loc8_++;
            }
         }
         HabboTicketLogin.rememberMessenger(this,this.§_-32n§.userId);
      }
      
      public static function get localization() : §_-2Jj§
      {
         return §_-1B3§;
      }
      
      public function dispose() : void
      {
         if(§_-101§)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_:§_-3gH§ in _messageEvents)
            {
               _communication.§_-21R§(_loc1_);
            }
         }
         §_-33k§ = null;
         _communication = null;
         §_-1B3§ = null;
         §_-32n§ = null;
         _messageEvents = null;
         §_-4Ne§ = null;
         §_-101§ = true;
      }
      
      public function get disposed() : Boolean
      {
         return §_-101§;
      }
      
      public function get communication() : §_-qE§
      {
         return _communication;
      }
      
      public function §_-0aN§() : void
      {
         §_-33k§.§_-Jp§();
      }
      
      public function §_-ZA§(param1:§_-1lI§) : void
      {
         var _loc6_:String = null;
         var _loc2_:§_-2uW§ = null;
         var _loc3_:int = param1.§_-0ef§;
         var _loc4_:Boolean = param1.§_-2n7§;
         var _loc5_:§_-0Ep§ = §_-3dP§(_loc3_);
         if(_loc5_)
         {
            _loc6_ = _loc4_ ? "${messenger.notification.online}" : "${messenger.notification.offline}";
            _loc2_ = new §_-2uW§(4,_loc3_,_loc6_,0);
            _loc5_.§_-0An§(_loc2_);
         }
      }
      
      public function send(param1:§_-15i§) : void
      {
         _communication.connection.send(param1);
      }
      
      public function §_-35o§(param1:int) : §_-0Ep§
      {
         var _loc3_:§_-Nk§ = null;
         var _loc4_:§_-2al§ = null;
         var _loc2_:BitmapData = null;
         var _loc5_:§_-0Ep§ = §_-3dP§(param1);
         if(!_loc5_)
         {
            _loc5_ = new §_-0Ep§(param1);
            §_-4Ne§.push(_loc5_);
         }
         if(§_-33k§.§_-0dH§)
         {
            _loc3_ = §_-33k§.§_-0dH§.§_-3kz§(param1);
            if(_loc3_)
            {
               _loc5_.§_-2zr§ = _loc3_.name;
               _loc5_.§_-1DA§ = _loc3_.figure;
               _loc4_ = §_-33k§.§_-3lM§.§_-4QF§(_loc3_.figure,"h",null,this);
               _loc4_.setDirection("full",2);
               _loc2_ = _loc4_.§_-4Th§("head");
               if(_loc2_)
               {
                  _loc5_.§_-0pO§ = Texture.fromBitmapData(_loc2_);
               }
            }
         }
         return _loc5_;
      }
      
      public function §_-rR§(param1:int) : void
      {
         HabboTicketLogin.consoleConversationRemoved(param1);
         var _loc2_:§_-0Ep§ = §_-3dP§(param1);
         if(_loc2_)
         {
            §_-4Ne§.removeItem(_loc2_);
         }
      }
      
      public function §_-4Hj§(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:§_-0Ep§ = null;
         var _loc3_:int = §_-4Ne§.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = §_-4Ne§.getItemAt(_loc4_) as §_-0Ep§;
            if(_loc2_.id == param1)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function §_-1B4§(param1:§_-3GR§) : void
      {
         if(HabboTicketLogin.isOwnConsoleMessage(param1.parser,this.§_-32n§))
         {
            return;
         }
         var _loc2_:§_-2It§ = param1.getParser();
         var _loc5_:§_-0Ep§ = §_-3dP§(_loc2_.§_-0UP§);
         if(_loc5_ == null)
         {
            _loc5_ = §_-35o§(_loc2_.§_-0UP§);
         }
         var _loc4_:int = _loc2_.§_-0UP§ == §_-32n§.userId ? 1 : 2;
         var _loc3_:§_-2uW§ = new §_-2uW§(_loc4_,_loc2_.§_-0UP§,_loc2_.§_-0F1§,_loc2_.§_-3y9§);
         _loc5_.§_-0An§(_loc3_);
         if(_loc2_.§_-3y9§ > 1)
         {
            _loc5_.§_-Ag§(_loc2_.§_-3y9§);
         }
         §_-2v§(_loc5_);
      }
      
      private function §_-3dP§(param1:int) : §_-0Ep§
      {
         var _loc3_:int = 0;
         var _loc4_:§_-0Ep§ = null;
         var _loc2_:int = §_-4Ne§.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = §_-4Ne§.getItemAt(_loc3_) as §_-0Ep§;
            if(_loc4_.§_-3aV§ == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function §_-dz§(param1:§_-0Ep§) : void
      {
         param1.§_-0MK§ = false;
         §_-2v§(param1);
      }
      
      public function §_-2v§(param1:§_-0Ep§) : void
      {
         var _loc2_:int = §_-4Ne§.getItemIndex(param1);
         if(_loc2_ != -1)
         {
            §_-4Ne§.updateItemAt(_loc2_);
         }
         §_-4CN§();
      }
      
      public function §_-4CN§() : void
      {
         var _loc1_:Boolean = §_-0MK§();
         if(_loc1_)
         {
            §_-33k§.events.dispatchEvent(new Event("messenger-has-unseen-messages"));
            §_-33k§.§_-2fc§.playSound("HBST_message_received");
         }
         else
         {
            §_-33k§.events.dispatchEvent(new Event("messenger-has-not-unseen-messages"));
         }
      }
      
      public function §_-0MK§() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:§_-0Ep§ = null;
         if(§_-4Ne§)
         {
            _loc2_ = §_-4Ne§.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = §_-4Ne§.getItemAt(_loc3_) as §_-0Ep§;
               if(_loc1_.§_-0MK§)
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function §_-fV§(param1:§_-45Z§) : void
      {
         var _loc2_:§_-2Mk§ = param1.getParser();
         var _loc6_:§_-0Ep§ = §_-3dP§(_loc2_.§_-0UP§);
         if(_loc6_ == null)
         {
            _loc6_ = §_-35o§(_loc2_.§_-0UP§);
         }
         var _loc4_:int = 5;
         var _loc5_:String = §_-33k§.localization.getLocalization("messenger.invitation");
         var _loc3_:§_-2uW§ = new §_-2uW§(_loc4_,_loc2_.§_-0UP§,_loc5_ + "\n" + _loc2_.§_-0F1§,0);
         _loc6_.§_-0An§(_loc3_);
         §_-2v§(_loc6_);
      }
      
      private function §_-2gk§(param1:§_-3gH§) : void
      {
         var _loc2_:§_-4MM§ = (param1 as §_-1oI§).getParser();
         Alert.show(_loc2_.message,"${generic.error}",new §_-nO§([{"label":"${generic.ok}"}]));
      }
      
      public function get habboUI() : §_-0S9§
      {
         return §_-33k§;
      }
      
      public function get sessionDataManager() : §_-no§
      {
         return §_-32n§;
      }
      
      private function addMessageEvent(param1:§_-3gH§) : void
      {
         if(!_messageEvents)
         {
            _messageEvents = new Vector.<§_-3gH§>();
         }
         _messageEvents.push(_communication.§_-2jM§(param1));
      }
      
      public function get §_-sZ§() : §_-nO§
      {
         return §_-4Ne§;
      }
      
      public function §_-1pp§(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc2_:§_-0Ep§ = null;
         var _loc4_:§_-2al§ = null;
         var _loc3_:int = §_-4Ne§.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = §_-4Ne§.getItemAt(_loc5_) as §_-0Ep§;
            if(_loc2_.§_-1DA§ == param1)
            {
               _loc4_ = §_-33k§.§_-3lM§.§_-4QF§(param1,"h",null,this);
               _loc4_.setDirection("full",2);
               _loc2_.§_-0pO§ = Texture.fromBitmapData(_loc4_.§_-4Th§("head"));
               break;
            }
            _loc5_++;
         }
      }
   }
}

