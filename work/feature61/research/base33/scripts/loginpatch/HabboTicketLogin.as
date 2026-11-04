package loginpatch
{
   import flash.desktop.Clipboard;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import starling.core.Starling;
   
   public final class HabboTicketLogin
   {
      
      private static var _timer:Timer;
      
      private static var _controller:Object;
      
      private static var _commandContext:Object;
      
      private static var _antiIdleTimer:Timer;
      
      private static var _wiredEditor:Object;
      
      private static var _offline32:Object;
      
      private static var _pendingWired:Object;
      
      private static var _modernInfo:Object;
      
      private static var _modernService:Object;
      
      private static var _modernControl:Object;
      
      private static var _modernContent:Object;
      
      private static var _heightPopup:Object;
      
      private static var _heightField:Object;
      
      private static var _heightId:int;
      
      private static var _activeConnection:Object;
      
      private static var _localeUi:Object;
      
      private static var _localeWired:Object;
      
      private static var _localeEnglish:Object;
      
      private static var _uiLocalization:Object;
      
      private static var _chatAtlas:Object;
      
      private static var _messenger:Object;
      
      private static var _friendLayer:Object;
      
      private static var _optionPopup:Object;
      
      private static var _optionOwner:Object;
      
      private static var _roomCanvas:Object;
      
      private static var _roomEngine:Object;
      
      private static var _wiredPopup:Object;
      
      private static var _modernSave:Object;
      
      private static var _areaStartX:int;
      
      private static var _areaStartY:int;
      
      private static var _areaHit:Object;
      
      private static var _areaShield:Object;
      
      private static var _areaLayer:Object;
      
      private static var _areaCaption:Object;
      
      private static var _heightRuler:Object;
      
      private static var _heightKnob:Object;
      
      private static var _heightRangeLabel:Object;
      
      private static var _heightTimer:Timer;
      
      private static var _actionPicker:Object;
      
      private static var _actionExtra:Object;
      
      private static var _actionExtraRow:Object;
      
      private static var _actionOriginal:int;
      
      private static var _actionOriginalText:String;
      
      private static var _accountUi:Object;
      
      private static var _accountConnection:Object;
      
      private static var _accountPopup:Object;
      
      private static var _incomeRows:Object;
      
      private static var _incomeStatus:Object;
      
      private static var _uiAtlas:Object;
      
      private static var _hideObject:Object;
      
      private static var _hideContent:Object;
      
      private static var _hideSave:Object;
      
      private static var _hideToggle:Object;
      
      private static var _hideStatus:Object;
      
      private static var _stage:String = "início";
      
      private static var _sent:Array = [];
      
      private static var _received:Array = [];
      
      private static var _ssoSession:Boolean = false;
      
      private static var _authenticated:Boolean = false;
      
      private static var _failureQueued:Boolean = false;
      
      private static var _attempt:int = 0;
      
      private static var _legacyCallbacks:int = 0;
      
      private static var _disconnectReason:int = -999;
      
      private static var _userIds:Dictionary = new Dictionary();
      
      private static var _userNames:Dictionary = new Dictionary();
      
      private static var _forcedIgnoreIds:Dictionary = new Dictionary(true);
      
      private static var _ignoredCount:int = -1;
      
      private static var _coreCategory:int = -999;
      
      private static var _coreErrorId:int = 0;
      
      private static var _coreHeader:int = -1;
      
      private static var _coreSource:String = "";
      
      private static var _coreFrames:Array = [];
      
      private static var _silverOffers:Dictionary = new Dictionary();
      
      private static var _consoleMetadata:Dictionary = new Dictionary(true);
      
      private static var _consoleConfirmations:Dictionary = new Dictionary(true);
      
      private static var _nextConsoleConfirmation:int = 1;
      
      private static var _antiIdle:Boolean = false;
      
      private static var _tradeBlocked:Boolean = false;
      
      private static var _tradeOpen:Boolean = false;
      
      private static var _typingVisible:Boolean = true;
      
      private static var _wiredById:Dictionary = new Dictionary();
      
      private static var _builderRefresh:Dictionary = new Dictionary(true);
      
      private static var _wiredSchema:Object = {
         "effect:6":{
            "name":"GiveScore",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:27":{
            "name":"BotTalkDirectToAvatar",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.whisper}"
               },{
                  "value":0,
                  "label":"${wiredfurni.params.talk}"
               }]
            }],
            "text":true
         },
         "effect:15":{
            "name":"ToggleToRandomState",
            "params":[],
            "text":false
         },
         "effect:30":{
            "name":"SendSignal",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.signal.send_options}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.signal.send_options}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:0":{
            "name":"ToggleFurniState",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"wiredfurni.params.toggletype.0"
               },{
                  "value":1,
                  "label":"wiredfurni.params.toggletype.1"
               }]
            }],
            "text":false
         },
         "effect:19":{
            "name":"KickFromRoom",
            "params":[],
            "text":true
         },
         "effect:1":{
            "name":"Reset",
            "params":[],
            "text":false
         },
         "effect:35":{
            "name":"MoveFurniToUser",
            "params":[],
            "text":false
         },
         "effect:26":{
            "name":"BotChangeFigure",
            "params":[],
            "text":true
         },
         "effect:31":{
            "name":"FreezeUser",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.freeze.effect_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.freeze.effect.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.freeze.effect.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.freeze.effect.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.freeze.effect.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.freeze.effect.4}"
               }]
            },{
               "kind":"check",
               "label":"${wiredfurni.params.freeze.cancel_on_teleport}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:13":{
            "name":"MoveToDirection",
            "params":[{
               "kind":"number",
               "label":"${wiredfurni.params.startdir}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"${wiredfurni.params.turn}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.user_collide}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:43":{
            "name":"MoveUserToFurni",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.user_move.walkmode}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.user_move.walkmode.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.user_move.walkmode.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.user_move.walkmode.2}"
               }]
            }],
            "text":false
         },
         "effect:33":{
            "name":"RelativeFurniMove",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:32":{
            "name":"UnfreezeUser",
            "params":[],
            "text":false
         },
         "effect:21":{
            "name":"BotTeleport",
            "params":[],
            "text":true
         },
         "effect:38":{
            "name":"AdjustClock",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"wiredfurni.params.clock_minutes",
               "min":0,
               "max":99
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.choose_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.operator.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.operator.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.operator.2}"
               }]
            }],
            "text":false
         },
         "effect:24":{
            "name":"BotGiveHandItem",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.handitem}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${handitem0}"
               },{
                  "value":2,
                  "label":"${handitem2}"
               },{
                  "value":5,
                  "label":"${handitem5}"
               },{
                  "value":7,
                  "label":"${handitem7}"
               },{
                  "value":8,
                  "label":"${handitem8}"
               },{
                  "value":9,
                  "label":"${handitem9}"
               },{
                  "value":10,
                  "label":"${handitem10}"
               },{
                  "value":27,
                  "label":"${handitem27}"
               }]
            }],
            "text":true
         },
         "effect:41":{
            "name":"ChangeVariable",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:8":{
            "name":"Teleport",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:14":{
            "name":"GiveScoreToPredefinedTeam",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            }],
            "text":false
         },
         "effect:17":{
            "name":"GiveReward",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"Once"
               },{
                  "value":1,
                  "label":"1 / n Days"
               },{
                  "value":2,
                  "label":"1 / n Hours"
               },{
                  "value":3,
                  "label":"1 / n Mins"
               }]
            },{
               "kind":"check",
               "label":"Unique Rewards",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "effect:40":{
            "name":"RemoveVariable",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:3":{
            "name":"SetFurniStateTo",
            "params":[{
               "kind":"check",
               "label":"wiredfurni.params.conditions",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:9":{
            "name":"JoinTeam",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.choose_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team_type.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team_type.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team_type.2}"
               }]
            }],
            "text":false
         },
         "effect:34":{
            "name":"MoveFurniToFurni",
            "params":[],
            "text":false
         },
         "effect:18":{
            "name":"CallAnotherStack",
            "params":[],
            "text":false
         },
         "effect:7":{
            "name":"Chat",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.show_message.visibility_selection.title}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.show_message.visibility_selection.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.show_message.visibility_selection.1}"
               }]
            },{
               "kind":"options",
               "label":"Estilo da mensagem",
               "min":0,
               "max":2147483647,
               "options":[{
                  "value":34,
                  "label":"Notificação padrão"
               },{
                  "value":200,
                  "label":"Notificação vermelha"
               },{
                  "value":201,
                  "label":"Notificação verde"
               },{
                  "value":202,
                  "label":"Notificação azul"
               },{
                  "value":210,
                  "label":"Alerta"
               },{
                  "value":211,
                  "label":"Informação"
               },{
                  "value":212,
                  "label":"Atenção"
               },{
                  "value":220,
                  "label":"Errado"
               },{
                  "value":221,
                  "label":"Errado (círculo)"
               },{
                  "value":222,
                  "label":"Correto"
               },{
                  "value":223,
                  "label":"Correto (círculo)"
               },{
                  "value":224,
                  "label":"Ponto de interrogação"
               },{
                  "value":225,
                  "label":"Ponto de interrogação (círculo)"
               },{
                  "value":226,
                  "label":"Seta para cima"
               },{
                  "value":227,
                  "label":"Seta para cima (círculo)"
               },{
                  "value":228,
                  "label":"Seta para baixo"
               },{
                  "value":229,
                  "label":"Seta para baixo (círculo)"
               },{
                  "value":250,
                  "label":"Caveira"
               },{
                  "value":251,
                  "label":"Caveira 2"
               },{
                  "value":252,
                  "label":"Lupa"
               }]
            }],
            "text":true
         },
         "effect:28":{
            "name":"ControlClock",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.clock_control}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.clock_control.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.clock_control.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.clock_control.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.clock_control.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.clock_control.4}"
               }]
            }],
            "text":false
         },
         "effect:49":{
            "name":"WriteToLogs",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.write_to_logs.log_level.title}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.write_to_logs.log_level.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.write_to_logs.log_level.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.write_to_logs.log_level.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.write_to_logs.log_level.3}"
               }]
            }],
            "text":true
         },
         "effect:42":{
            "name":"MoveUser",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.moveuser}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":-1,
                  "label":"${wiredfurni.params.movefurni.0}"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.rotateuser}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":-1,
                  "label":"${wiredfurni.params.rotatefurni.0}"
               }]
            }],
            "text":false
         },
         "effect:20":{
            "name":"MuteUser",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.length.minutes",
               "min":0,
               "max":10
            }],
            "text":true
         },
         "effect:10":{
            "name":"LeaveTeam",
            "params":[],
            "text":false
         },
         "effect:29":{
            "name":"SetFurniAltitude",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setaltitude",
               "min":0,
               "max":8000
            },{
               "kind":"options",
               "label":"${wiredfurni.params.choose_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.operator.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.operator.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.operator.2}"
               }]
            }],
            "text":false
         },
         "effect:22":{
            "name":"BotMove",
            "params":[],
            "text":true
         },
         "effect:16":{
            "name":"MoveFurniTo",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.movefurni}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.movefurni.0}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.movefurni.2}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.movefurni.4}"
               },{
                  "value":6,
                  "label":"${wiredfurni.params.movefurni.6}"
               }]
            },{
               "kind":"number",
               "label":"wiredfurni.params.emptytiles",
               "min":1,
               "max":5
            }],
            "text":false
         },
         "effect:44":{
            "name":"TeleportToRoom",
            "params":[],
            "text":false
         },
         "effect:39":{
            "name":"GiveVariable",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "effect:23":{
            "name":"BotTalk",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.talk}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.shout}"
               }]
            }],
            "text":true
         },
         "effect:25":{
            "name":"BotFollowAvatar",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.start.following}"
               },{
                  "value":0,
                  "label":"${wiredfurni.params.stop.following}"
               }]
            }],
            "text":true
         },
         "effect:4":{
            "name":"MoveFurni",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.movefurni}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.movefurni.0}"
               },{
                  "value":4,
                  "label":"Mover ↗"
               },{
                  "value":8,
                  "label":"Mover ↑"
               },{
                  "value":5,
                  "label":"Mover ↖"
               },{
                  "value":9,
                  "label":"Mover ←"
               },{
                  "value":6,
                  "label":"Mover ↙"
               },{
                  "value":10,
                  "label":"Mover ↓"
               },{
                  "value":7,
                  "label":"Mover ↘"
               },{
                  "value":11,
                  "label":"Mover →"
               },{
                  "value":2,
                  "label":"Uma direção diagonal aleatória"
               },{
                  "value":3,
                  "label":"Uma direção reta aleatória"
               },{
                  "value":1,
                  "label":"Mover aleatoriamente"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.rotatefurni}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.rotatefurni.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.rotatefurni.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.rotatefurni.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.rotatefurni.3}"
               }]
            }],
            "text":false
         },
         "effect:11":{
            "name":"Chase",
            "params":[],
            "text":false
         },
         "effect:12":{
            "name":"Flee",
            "params":[],
            "text":false
         },
         "trigger:21":{
            "name":"UnknownHabboRoomeventsWired_SetupTriggerconfs1",
            "params":[],
            "text":false
         },
         "trigger:11":{
            "name":"UnknownHabboRoomeventsWired_SetupTriggerconfs2",
            "params":[],
            "text":false
         },
         "trigger:16":{
            "name":"PerformAction",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.action_selection}",
               "min":0,
               "max":11,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.action.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.action.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.action.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.action.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.action.4}"
               },{
                  "value":5,
                  "label":"${wiredfurni.params.action.5}"
               },{
                  "value":6,
                  "label":"${wiredfurni.params.action.6}"
               },{
                  "value":7,
                  "label":"${wiredfurni.params.action.7}"
               },{
                  "value":8,
                  "label":"${wiredfurni.params.action.8}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.action.10}"
               },{
                  "value":11,
                  "label":"${wiredfurni.params.action.11}"
               }]
            }],
            "text":false,
            "action":true
         },
         "trigger:14":{
            "name":"BotAvatarReached",
            "params":[],
            "text":true
         },
         "trigger:8":{
            "name":"GameStarts",
            "params":[],
            "text":false
         },
         "trigger:6":{
            "name":"TriggerPeriodically",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.settime3",
               "min":1,
               "max":120
            }],
            "text":false
         },
         "trigger:12":{
            "name":"TriggerPeriodicLong",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.settime3",
               "min":1,
               "max":120
            }],
            "text":false
         },
         "trigger:18":{
            "name":"AvatarClicksFurni",
            "params":[],
            "text":false
         },
         "trigger:17":{
            "name":"ReceiveSignal",
            "params":[],
            "text":false
         },
         "trigger:20":{
            "name":"StateChange",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.select_options}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.state_trigger.1}"
               },{
                  "value":0,
                  "label":"${wiredfurni.params.state_trigger.0}"
               }]
            }],
            "text":false
         },
         "trigger:22":{
            "name":"VariableUpdate",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.variables.trigger_options}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.variables.trigger_options}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.variables.trigger_options}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.variables.trigger_options.1.0}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "trigger:10":{
            "name":"ScoreAchieved",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setscore2",
               "min":1,
               "max":1000
            },{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team.any}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            }],
            "text":false
         },
         "trigger:26":{
            "name":"TransactionFailed",
            "params":[],
            "text":false
         },
         "trigger:3":{
            "name":"TriggerOnce",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.settime2",
               "min":1,
               "max":1200
            }],
            "text":false
         },
         "trigger:23":{
            "name":"AvatarLeavesRoom",
            "params":[],
            "text":false
         },
         "trigger:4":{
            "name":"UseStuff",
            "params":[],
            "text":false
         },
         "trigger:2":{
            "name":"UnknownHabboRoomeventsWired_SetupTriggerconfs5",
            "params":[],
            "text":false
         },
         "trigger:7":{
            "name":"AvatarEntersRoom",
            "params":[],
            "text":false
         },
         "trigger:9":{
            "name":"GameEnds",
            "params":[],
            "text":false
         },
         "trigger:1":{
            "name":"UnknownHabboRoomeventsWired_SetupTriggerconfs4",
            "params":[],
            "text":false
         },
         "trigger:0":{
            "name":"AvatarSaysSomething",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.chat.hide}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.chattriggertype}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.chatcontains}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.exactmatch}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.allmatch}"
               }]
            },{
               "kind":"check",
               "label":"${wiredfurni.params.chat.onlyowner}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "trigger:25":{
            "name":"TransactionCompleted",
            "params":[],
            "text":false
         },
         "trigger:19":{
            "name":"TriggerPeriodicShort",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setshorttime",
               "min":1,
               "max":10
            }],
            "text":false
         },
         "trigger:24":{
            "name":"UserClicksUser",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "trigger:15":{
            "name":"ClockReachTime",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"wiredfurni.params.clock_minutes_elapsed",
               "min":0,
               "max":99
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "trigger:13":{
            "name":"BotDestinationReached",
            "params":[],
            "text":true
         },
         "condition:26":{
            "name":"TriggererMatches",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.usertype}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.usertype.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.usertype.2}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.usertype.4}"
               }]
            }],
            "text":true
         },
         "condition:29":{
            "name":"DateMatches",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 5",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 6",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 7",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 8",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:3":{
            "name":"TimeElapsedMore",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.allowafter2",
               "min":1,
               "max":1200
            }],
            "text":false
         },
         "condition:11":{
            "name":"ActorIsWearingBadge",
            "params":[],
            "text":true
         },
         "condition:38":{
            "name":"InputSourceQuantity",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"wiredfurni.params.setamount2",
               "min":0,
               "max":100
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "condition:35":{
            "name":"ClockTimeMatches",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"wiredfurni.params.clock_minutes_elapsed",
               "min":0,
               "max":99
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "condition:4":{
            "name":"TimeElapsedLess",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.allowbefore2",
               "min":1,
               "max":1200
            }],
            "text":false
         },
         "condition:18":{
            "name":"DontHaveStackedFurnis",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.requireall}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.not_requireall.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.not_requireall.1}"
               }]
            }],
            "text":false
         },
         "condition:37":{
            "name":"ActorFacingDirection",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:40":{
            "name":"HasVariable",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:32":{
            "name":"ActorIsPerformingAction",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.action_selection}",
               "min":0,
               "max":11,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.action.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.action.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.action.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.action.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.action.4}"
               },{
                  "value":5,
                  "label":"${wiredfurni.params.action.5}"
               },{
                  "value":6,
                  "label":"${wiredfurni.params.action.6}"
               },{
                  "value":7,
                  "label":"${wiredfurni.params.action.7}"
               },{
                  "value":8,
                  "label":"${wiredfurni.params.action.8}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.action.10}"
               },{
                  "value":11,
                  "label":"${wiredfurni.params.action.11}"
               }]
            }],
            "text":false,
            "action":true
         },
         "condition:39":{
            "name":"CanPerformMove",
            "params":[],
            "text":false
         },
         "condition:2":{
            "name":"TriggererIsOnFurni",
            "params":[],
            "text":false
         },
         "condition:31":{
            "name":"TeamIsWinning",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team.triggerer}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.placement_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.placement.1}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.placement.2}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.placement.3}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.placement.4}"
               }]
            }],
            "text":false
         },
         "condition:10":{
            "name":"ActorIsGroupMember",
            "params":[],
            "text":false
         },
         "condition:25":{
            "name":"ActorHasHandItem",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.handitem}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${handitem0}"
               },{
                  "value":2,
                  "label":"${handitem2}"
               },{
                  "value":5,
                  "label":"${handitem5}"
               },{
                  "value":7,
                  "label":"${handitem7}"
               },{
                  "value":8,
                  "label":"${handitem8}"
               },{
                  "value":9,
                  "label":"${handitem9}"
               },{
                  "value":10,
                  "label":"${handitem10}"
               },{
                  "value":27,
                  "label":"${handitem27}"
               }]
            }],
            "text":false
         },
         "condition:42":{
            "name":"VariableValue",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":2,
                  "label":">"
               },{
                  "value":5,
                  "label":"≥"
               },{
                  "value":1,
                  "label":"="
               },{
                  "value":3,
                  "label":"≤"
               },{
                  "value":0,
                  "label":"<"
               },{
                  "value":4,
                  "label":"≠"
               }]
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:8":{
            "name":"StuffTypeMatches",
            "params":[],
            "text":false
         },
         "condition:28":{
            "name":"TimeMatches",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 5",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 6",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 7",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 8",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 9",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:7":{
            "name":"HasStackedFurnis",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.requireall}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.requireall.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.requireall.1}"
               }]
            }],
            "text":false
         },
         "condition:44":{
            "name":"LevelMatches",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.level_selection",
               "min":1,
               "max":30
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "condition:1":{
            "name":"FurnisHaveAvatars",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.requireall}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.requireall.2}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.requireall.3}"
               }]
            }],
            "text":false
         },
         "condition:34":{
            "name":"TeamHasScore",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team.triggerer}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            },{
               "kind":"number",
               "label":"wiredfurni.params.setscore2",
               "min":0,
               "max":1000
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "condition:5":{
            "name":"UserCountIn",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.usercountmin",
               "min":0,
               "max":125
            },{
               "kind":"number",
               "label":"wiredfurni.params.usercountmax",
               "min":0,
               "max":125
            }],
            "text":false
         },
         "condition:0":{
            "name":"StatesMatch",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.condition.state}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:6":{
            "name":"ActorIsInTeam",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team.any}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            }],
            "text":false
         },
         "condition:43":{
            "name":"VariableAge",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.variables.compare_value}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.variables.compare_value.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.variables.compare_value.1}"
               }]
            },{
               "kind":"options",
               "label":"${wiredfurni.params.variables.duration}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.variables.duration.0}"
               }]
            }],
            "text":false
         },
         "condition:12":{
            "name":"ActorIsWearingEffect",
            "params":[{
               "kind":"number",
               "label":"${wiredfurni.params.effectid}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "condition:14":{
            "name":"FurnisHaveNoAvatars",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.requireall}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.not_requireall.2}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.not_requireall.3}"
               }]
            }],
            "text":false
         },
         "condition:36":{
            "name":"FurniHasAltitude",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setaltitude",
               "min":0,
               "max":8000
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "condition:24":{
            "name":"DateRangeActive",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:4":{
            "name":"FurniOnFurni",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.selection_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.onfurni.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.onfurni.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.onfurni.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.onfurni.3}"
               }]
            }],
            "text":false
         },
         "selector:16":{
            "name":"FurniWithAltitude",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setaltitude",
               "min":0,
               "max":8000
            },{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.comparison.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.comparison.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.comparison.2}"
               }]
            }],
            "text":false
         },
         "selector:1":{
            "name":"UnknownHabboRoomeventsWired_SetupSelectors2",
            "params":[],
            "text":false
         },
         "selector:10":{
            "name":"UsersFromSignal",
            "params":[],
            "text":false
         },
         "selector:11":{
            "name":"UsersByName",
            "params":[],
            "text":true
         },
         "selector:17":{
            "name":"UnknownHabboRoomeventsWired_SetupSelectors3",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":2,
                  "label":">"
               },{
                  "value":5,
                  "label":"≥"
               },{
                  "value":1,
                  "label":"="
               },{
                  "value":3,
                  "label":"≤"
               },{
                  "value":0,
                  "label":"<"
               },{
                  "value":4,
                  "label":"≠"
               }]
            },{
               "kind":"check",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:0":{
            "name":"FurniByType",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.state_match}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:18":{
            "name":"UsersWithVariable",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.comparison_selection}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":2,
                  "label":">"
               },{
                  "value":5,
                  "label":"≥"
               },{
                  "value":1,
                  "label":"="
               },{
                  "value":3,
                  "label":"≤"
               },{
                  "value":0,
                  "label":"<"
               },{
                  "value":4,
                  "label":"≠"
               }]
            },{
               "kind":"check",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:7":{
            "name":"FurniInArea",
            "params":[{
               "kind":"number",
               "label":"Posição X",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Posição Y",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Largura",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Altura",
               "min":0,
               "max":64
            }],
            "text":false,
            "area":true
         },
         "selector:5":{
            "name":"FurniFromSignal",
            "params":[],
            "text":false
         },
         "selector:13":{
            "name":"UsersInArea",
            "params":[{
               "kind":"number",
               "label":"Posição X",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Posição Y",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Largura",
               "min":0,
               "max":64
            },{
               "kind":"number",
               "label":"Altura",
               "min":0,
               "max":64
            }],
            "text":false,
            "area":true
         },
         "selector:3":{
            "name":"UsersInTeam",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.team}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.team.any}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.team.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.team.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.team.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.team.4}"
               }]
            }],
            "text":false
         },
         "selector:6":{
            "name":"UnknownHabboRoomeventsWired_SetupSelectors1",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:15":{
            "name":"UsersInGroup",
            "params":[],
            "text":false
         },
         "selector:8":{
            "name":"UsersOnFurni",
            "params":[],
            "text":false
         },
         "selector:12":{
            "name":"UsersInNeighborhood",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:19":{
            "name":"RemoteSelector",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.remote_selection.type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.remote_selection.type.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.remote_selection.type.1}"
               }]
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "selector:2":{
            "name":"UsersByType",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.usertype}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.usertype.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.usertype.2}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.usertype.4}"
               }]
            }],
            "text":false
         },
         "selector:9":{
            "name":"UsersPerformingAction",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.action_selection}",
               "min":0,
               "max":11,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.action.0}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.action.1}"
               },{
                  "value":2,
                  "label":"${wiredfurni.params.action.2}"
               },{
                  "value":3,
                  "label":"${wiredfurni.params.action.3}"
               },{
                  "value":4,
                  "label":"${wiredfurni.params.action.4}"
               },{
                  "value":5,
                  "label":"${wiredfurni.params.action.5}"
               },{
                  "value":6,
                  "label":"${wiredfurni.params.action.6}"
               },{
                  "value":7,
                  "label":"${wiredfurni.params.action.7}"
               },{
                  "value":8,
                  "label":"${wiredfurni.params.action.8}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.action.10}"
               },{
                  "value":11,
                  "label":"${wiredfurni.params.action.11}"
               }]
            }],
            "text":false,
            "action":true
         },
         "selector:14":{
            "name":"UsersWithHanditem",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.handitem}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${handitem0}"
               },{
                  "value":2,
                  "label":"${handitem2}"
               },{
                  "value":5,
                  "label":"${handitem5}"
               },{
                  "value":7,
                  "label":"${handitem7}"
               },{
                  "value":8,
                  "label":"${handitem8}"
               },{
                  "value":9,
                  "label":"${handitem9}"
               },{
                  "value":10,
                  "label":"${handitem10}"
               },{
                  "value":27,
                  "label":"${handitem27}"
               }]
            }],
            "text":false
         },
         "addon:12":{
            "name":"FurniVariableFilter",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:13":{
            "name":"UserVariableFilter",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:6":{
            "name":"NoMoveAnimation",
            "params":[],
            "text":false
         },
         "addon:1":{
            "name":"PickOneRandomlyPropagation",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.skipactions",
               "min":0,
               "max":100
            },{
               "kind":"number",
               "label":"wiredfurni.params.pickamount",
               "min":1,
               "max":100
            }],
            "text":false
         },
         "addon:17":{
            "name":"ExecuteInOrder",
            "params":[],
            "text":false
         },
         "addon:1000":{
            "name":"VariableTextConnectorAddon",
            "params":[],
            "text":true
         },
         "addon:19":{
            "name":"FurniNamePlaceholderAddon",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "addon:11":{
            "name":"UserSelectorFilter",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:7":{
            "name":"MovePhysics",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.movephysics.keep_altitude}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.movephysics.move_through_furni}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.movephysics.move_through_users}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"${wiredfurni.params.movephysics.block_by_furni}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:0":{
            "name":"ConditionEvaluation",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:15":{
            "name":"VariablePlaceholderAddon",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"check",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "addon:10":{
            "name":"FurniSelectorFilter",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:9":{
            "name":"AnimationTime",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setanimationtime2",
               "min":50,
               "max":2000
            }],
            "text":false
         },
         "addon:8":{
            "name":"CarryUsers",
            "params":[{
               "kind":"options",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"wiredfurni.params.carry_mode.0"
               },{
                  "value":1,
                  "label":"wiredfurni.params.carry_mode.1"
               }]
            }],
            "text":false
         },
         "addon:2000":{
            "name":"GlobalPlaceholderAddon",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.choose_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.from_value}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.from_another_room}"
               }]
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.choose_type}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.from_value}"
               },{
                  "value":1,
                  "label":"${wiredfurni.params.from_another_room}"
               }]
            }],
            "text":true
         },
         "addon:14":{
            "name":"UsernamePlaceholderAddon",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "addon:1002":{
            "name":"VariableTimeUtilAddon",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:5":{
            "name":"ExceedExecutions",
            "params":[{
               "kind":"number",
               "label":"wiredfurni.params.setexecutions",
               "min":1,
               "max":100
            },{
               "kind":"number",
               "label":"wiredfurni.params.settimewindow",
               "min":1,
               "max":20
            }],
            "text":false
         },
         "addon:16":{
            "name":"VariableCapturerAddon",
            "params":[{
               "kind":"check",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "addon:1001":{
            "name":"VariableLvlUpAddon",
            "params":[{
               "kind":"number",
               "label":"Opção 1",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 2",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 3",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 4",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 5",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 6",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"number",
               "label":"Opção 7",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":false
         },
         "addon:2":{
            "name":"UnknownHabboRoomeventsWired_SetupAddons1",
            "params":[],
            "text":false
         },
         "variable:1":{
            "name":"UserVariable",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.variables.availability}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":0,
                  "label":"${wiredfurni.params.variables.availability.0}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.variables.availability.10}"
               },{
                  "value":11,
                  "label":"${wiredfurni.params.variables.availability.11}"
               }]
            },{
               "kind":"check",
               "label":"${wiredfurni.params.variables.settings.has_value}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "variable:3":{
            "name":"ContextVariable",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.variables.settings.has_value}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "variable:5":{
            "name":"QuestVariable",
            "params":[],
            "text":true
         },
         "variable:0":{
            "name":"FurniVariable",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.variables.settings.has_value}",
               "min":-2147483648,
               "max":2147483647
            },{
               "kind":"options",
               "label":"${wiredfurni.params.variables.availability}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.variables.availability.1}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.variables.availability.10}"
               }]
            }],
            "text":true
         },
         "variable:2":{
            "name":"GlobalVariable",
            "params":[{
               "kind":"options",
               "label":"${wiredfurni.params.variables.availability}",
               "min":-2147483648,
               "max":2147483647,
               "options":[{
                  "value":1,
                  "label":"${wiredfurni.params.variables.availability.1}"
               },{
                  "value":10,
                  "label":"${wiredfurni.params.variables.availability.10}"
               },{
                  "value":11,
                  "label":"${wiredfurni.params.variables.availability.11}"
               }]
            }],
            "text":true
         },
         "variable:4":{
            "name":"ReferenceVariable",
            "params":[{
               "kind":"check",
               "label":"${wiredfurni.params.variables.settings.read_only}",
               "min":-2147483648,
               "max":2147483647
            }],
            "text":true
         },
         "variable:8":{
            "name":"DailyTaskVariable",
            "params":[],
            "text":true
         },
         "variable:6":{
            "name":"QuestChainVariable",
            "params":[],
            "text":true
         },
         "variable:7":{
            "name":"EchoVariable",
            "params":[],
            "text":true
         }
      };
      
      private static var _wiredLabels:Object = {
         "handitem0":"Nenhum",
         "handitem10":"Café com leite",
         "handitem2":"Suco",
         "handitem27":"Chá Árabe",
         "handitem5":"Leite",
         "handitem7":"Água",
         "handitem8":"Café",
         "handitem9":"Café Descafeinado",
         "wiredfurni.params.action.0":"Acenar",
         "wiredfurni.params.action.1":"Mandar um beijo",
         "wiredfurni.params.action.10":"Sinais",
         "wiredfurni.params.action.11":"Dançar",
         "wiredfurni.params.action.2":"Rir",
         "wiredfurni.params.action.3":"Curti!",
         "wiredfurni.params.action.4":"Acordar",
         "wiredfurni.params.action.5":"Inativo",
         "wiredfurni.params.action.6":"Sentar",
         "wiredfurni.params.action.7":"Levantar",
         "wiredfurni.params.action.8":"Deitar",
         "wiredfurni.params.action.9":"Nadar",
         "wiredfurni.params.action.dance.1":"Hap-Hop",
         "wiredfurni.params.action.dance.2":"Pogo Mogo",
         "wiredfurni.params.action.dance.3":"Duck Funk",
         "wiredfurni.params.action.dance.4":"Rollie",
         "wiredfurni.params.action.sign.0":"0",
         "wiredfurni.params.action.sign.1":"1",
         "wiredfurni.params.action.sign.10":"10",
         "wiredfurni.params.action.sign.11":"|",
         "wiredfurni.params.action.sign.12":"ª",
         "wiredfurni.params.action.sign.13":"!",
         "wiredfurni.params.action.sign.14":"Futebol",
         "wiredfurni.params.action.sign.15":":)",
         "wiredfurni.params.action.sign.16":"Cartão vermelho",
         "wiredfurni.params.action.sign.17":"Cartão Amarelo",
         "wiredfurni.params.action.sign.2":"2",
         "wiredfurni.params.action.sign.3":"3",
         "wiredfurni.params.action.sign.4":"4",
         "wiredfurni.params.action.sign.5":"5",
         "wiredfurni.params.action.sign.6":"6",
         "wiredfurni.params.action.sign.7":"7",
         "wiredfurni.params.action.sign.8":"8",
         "wiredfurni.params.action.sign.9":"9",
         "wiredfurni.params.action_selection":"Ação:",
         "wiredfurni.params.allmatch":"Concordar com todo o texto",
         "wiredfurni.params.allowafter2":"Ativar depois de:",
         "wiredfurni.params.allowbefore2":"Ativar antes de:",
         "wiredfurni.params.carry_mode.0":"estão de pé diretamente sobre o mobi em movimento",
         "wiredfurni.params.carry_mode.1":"estão de pé no mesmo piso que o mobi em movimento",
         "wiredfurni.params.chat.hide":"Ocultar a mensagem do gatilho",
         "wiredfurni.params.chat.onlyowner":"Somente o proprietário da sala pode acionar",
         "wiredfurni.params.chatcontains":"Contém palavra-chave",
         "wiredfurni.params.chattriggertype":"Escolha o tipo:",
         "wiredfurni.params.choose_type":"Escolha o tipo:",
         "wiredfurni.params.clock_control":"Selecione a Opção",
         "wiredfurni.params.clock_control.0":"Começar",
         "wiredfurni.params.clock_control.1":"Parar",
         "wiredfurni.params.clock_control.2":"Reset",
         "wiredfurni.params.clock_control.3":"Pausa",
         "wiredfurni.params.clock_control.4":"Reiniciar",
         "wiredfurni.params.clock_minutes":"%minutes% minutos",
         "wiredfurni.params.clock_minutes_elapsed":"Passaram %minutes% minutos",
         "wiredfurni.params.comparison.0":"Menor que",
         "wiredfurni.params.comparison.1":"Igual",
         "wiredfurni.params.comparison.2":"Maior que",
         "wiredfurni.params.comparison_selection":"Escolha o tipo:",
         "wiredfurni.params.condition.state":"Atual estado do Mobi",
         "wiredfurni.params.conditions":"Selecione um critério de Mobi que precisa ser marcado:",
         "wiredfurni.params.emptytiles":"Space placed Furnis %tiles% tiles apart",
         "wiredfurni.params.exactmatch":"Combinação exata",
         "wiredfurni.params.freeze.cancel_on_teleport":"Descongelar ao teletransportar",
         "wiredfurni.params.freeze.effect.0":"Wired Freeze",
         "wiredfurni.params.freeze.effect.1":"Congelado",
         "wiredfurni.params.freeze.effect.2":"Raio-X",
         "wiredfurni.params.freeze.effect.3":"Passarinhos",
         "wiredfurni.params.freeze.effect.4":"Armadilha",
         "wiredfurni.params.freeze.effect_selection":"Escolha um efeito:",
         "wiredfurni.params.from_another_room":"De outro quarto",
         "wiredfurni.params.from_value":"Do valor",
         "wiredfurni.params.handitem":"Item de mão",
         "wiredfurni.params.length.minutes":"Duração: %minutes% minutos",
         "wiredfurni.params.level_selection":"Set level: %level%",
         "wiredfurni.params.movefurni":"Mover Mobi:",
         "wiredfurni.params.movefurni.0":"Nenhum movimento",
         "wiredfurni.params.movephysics.block_by_furni":"Está bloqueado por mobis",
         "wiredfurni.params.movephysics.keep_altitude":"Manter a altura do mobi",
         "wiredfurni.params.movephysics.move_through_furni":"Mover através dos mobis",
         "wiredfurni.params.movephysics.move_through_users":"Mover através dos Habbos",
         "wiredfurni.params.moveuser":"Mover usuário:",
         "wiredfurni.params.not_requireall.0":"Se um ou mais mobis selecionados NÃO têm mobis em cima.",
         "wiredfurni.params.not_requireall.1":"Todos os mobis selecionados NÃO têm outros mobis em cima",
         "wiredfurni.params.not_requireall.2":"Se um dos mobis selecionados não possui nenhum avatar nele",
         "wiredfurni.params.not_requireall.3":"Se todos os mobis selecionados não possuem avatares neles",
         "wiredfurni.params.onfurni.0":"Mobis acima de Mobis",
         "wiredfurni.params.onfurni.1":"Mobis sob Mobis",
         "wiredfurni.params.onfurni.2":"Mobis na mesma altura",
         "wiredfurni.params.onfurni.3":"Todos os mobis no piso",
         "wiredfurni.params.operator.0":"Aumentar",
         "wiredfurni.params.operator.1":"Diminuir",
         "wiredfurni.params.operator.2":"Configurar valor",
         "wiredfurni.params.pickamount":"Selecione %picks% efeitos",
         "wiredfurni.params.placement.1":"1º",
         "wiredfurni.params.placement.2":"2º",
         "wiredfurni.params.placement.3":"3º",
         "wiredfurni.params.placement.4":"4º",
         "wiredfurni.params.placement_selection":"Posicionamento:",
         "wiredfurni.params.quantifier.furni.0":"Todos os mobis coincidem",
         "wiredfurni.params.quantifier.furni.1":"Qualquer um dos mobis coincide",
         "wiredfurni.params.quantifier.furni.neg.0":"Algum dos mobis não coincide",
         "wiredfurni.params.quantifier.furni.neg.1":"Nenhum dos mobis coincide",
         "wiredfurni.params.quantifier.users.0":"Todos os usuários coincidem",
         "wiredfurni.params.quantifier.users.1":"Qualquer um dos usuários coincide",
         "wiredfurni.params.quantifier.users.neg.0":"Qualquer um dos usuários não coincide",
         "wiredfurni.params.quantifier.users.neg.1":"Nenhum dos usuários coincide",
         "wiredfurni.params.quantifier.variables.0":"Todas as variáveis correspondem",
         "wiredfurni.params.quantifier.variables.1":"Qualquer uma das variáveis corresponde",
         "wiredfurni.params.quantifier.variables.neg.0":"Qualquer uma das variáveis NÃO corresponde",
         "wiredfurni.params.quantifier.variables.neg.1":"Nenhuma das variáveis corresponde",
         "wiredfurni.params.remote_selection.type":"Tipo de seleção:",
         "wiredfurni.params.remote_selection.type.0":"União",
         "wiredfurni.params.remote_selection.type.1":"Intersecção",
         "wiredfurni.params.requireall":"Permite ativação se:",
         "wiredfurni.params.requireall.0":"Se um dos Mobis selecionados tem Mobi em cima",
         "wiredfurni.params.requireall.1":"Todos os Mobis selecionados têm Mobi em cima",
         "wiredfurni.params.requireall.2":"Se um dos mobis selecionados possui um avatar nele",
         "wiredfurni.params.requireall.3":"Se todos os mobis selecionados possuem avatares neles",
         "wiredfurni.params.rotatefurni":"Girar Mobi:",
         "wiredfurni.params.rotatefurni.0":"Nenhuma rotação",
         "wiredfurni.params.rotatefurni.1":"Rotacionar no sentido horário",
         "wiredfurni.params.rotatefurni.2":"Rotacionar no sentido anti horário",
         "wiredfurni.params.rotatefurni.3":"Para direções aleatórias",
         "wiredfurni.params.rotateuser":"Girar usuário:",
         "wiredfurni.params.select_options":"Selecione as opções:",
         "wiredfurni.params.selection_type":"Opções de seleção de Mobis:",
         "wiredfurni.params.setaltitude":"Selecionar altura:",
         "wiredfurni.params.setamount2":"Comparar com:",
         "wiredfurni.params.setanimationtime2":"Tempo de animação (ms):",
         "wiredfurni.params.setexecutions":"Quantidade de execuções: %amount%",
         "wiredfurni.params.setscore2":"Equipe tem que marcar:",
         "wiredfurni.params.setshorttime":"Configurar intervalo: %ms% millisegundos",
         "wiredfurni.params.settime2":"Configurar tempo:",
         "wiredfurni.params.settime3":"Definir tempo (segundos):",
         "wiredfurni.params.settimewindow":"Janela de tempo: %timewindow% segundos",
         "wiredfurni.params.shout":"Gritar",
         "wiredfurni.params.show_message.visibility_selection.0":"Somente o usuário",
         "wiredfurni.params.show_message.visibility_selection.1":"Todos",
         "wiredfurni.params.show_message.visibility_selection.title":"Visibilidade da mensagem:",
         "wiredfurni.params.signal.send_options":"Opções de sinal:",
         "wiredfurni.params.skipactions":"Evitar os efeitos das últimas %skips% execuções.",
         "wiredfurni.params.sources.collapse":"Ocultar configurações avançadas",
         "wiredfurni.params.sources.context":"Variáveis de contexto",
         "wiredfurni.params.sources.expand":"Mostrar configurações avançadas",
         "wiredfurni.params.sources.furni.0":"Use o item de ativação",
         "wiredfurni.params.sources.furni.100":"Use mobis escolhidos",
         "wiredfurni.params.sources.furni.101":"Escolha de mobis secundários",
         "wiredfurni.params.sources.furni.110":"Use the snapshot",
         "wiredfurni.params.sources.furni.200":"Usar mobis do seletor",
         "wiredfurni.params.sources.furni.201":"Usar mobis do sinal",
         "wiredfurni.params.sources.furni.900":"Todos os mobis do quarto",
         "wiredfurni.params.sources.furni.901":"Todo o mobi movido pela pilha de WIRED",
         "wiredfurni.params.sources.furni.title":"Selecione a fonte do Mobi:",
         "wiredfurni.params.sources.furni.title.chests":"Baús:",
         "wiredfurni.params.sources.furni.title.contracts":"Contratos:",
         "wiredfurni.params.sources.furni.title.item_types":"Tipos de Mobis para checar:",
         "wiredfurni.params.sources.furni.title.match.0":"Os mobis para combinar:",
         "wiredfurni.params.sources.furni.title.match.1":"Mobis para comparar com:",
         "wiredfurni.params.sources.furni.title.mv.0":"Os móveis em movimento:",
         "wiredfurni.params.sources.furni.title.mv.1":"Os mobis alvo:",
         "wiredfurni.params.sources.furni.title.mv_user":"O usuário alvo:",
         "wiredfurni.params.sources.furni.title.mv_user2":"O usuário em movimento:",
         "wiredfurni.params.sources.furni.title.payment":"Fonte dos mobis (pagamento)",
         "wiredfurni.params.sources.furni.title.physics.0":"Mover através dos mobis:",
         "wiredfurni.params.sources.furni.title.physics.1":"Bloqueado por mobis:",
         "wiredfurni.params.sources.furni.title.place_furni":"Mobi a ser colocado:",
         "wiredfurni.params.sources.furni.title.projectile":"O projétil:",
         "wiredfurni.params.sources.furni.title.reward":"Fonte dos mobis (recompensas)",
         "wiredfurni.params.sources.furni.title.signal_antenna":"Antenas:",
         "wiredfurni.params.sources.furni.title.signal_forward":"Mobis para enviar:",
         "wiredfurni.params.sources.furni.title.snapshot.0":"Estado a verificar:",
         "wiredfurni.params.sources.furni.title.snapshot.1":"Estado/posição a verificar:",
         "wiredfurni.params.sources.furni.title.snapshot.2":"Estado/posição a definir:",
         "wiredfurni.params.sources.global":"Variáveis globais",
         "wiredfurni.params.sources.merged.title":"Selecione a fonte:",
         "wiredfurni.params.sources.merged.title.custom_target":"Destino personalizado:",
         "wiredfurni.params.sources.merged.title.neighborhood":"Perto de:",
         "wiredfurni.params.sources.merged.title.target":"Selecionar alvo:",
         "wiredfurni.params.sources.merged.title.target_location":"Local de destino:",
         "wiredfurni.params.sources.merged.title.variable_animation_distance":"Fonte variável (distância de animação):",
         "wiredfurni.params.sources.merged.title.variable_time_per_tile":"Fonte variável (tempo por bloco):",
         "wiredfurni.params.sources.merged.title.variables":"Origem da variável:",
         "wiredfurni.params.sources.merged.title.variables_destination":"Variável de destino:",
         "wiredfurni.params.sources.merged.title.variables_reference":"Variável referência:",
         "wiredfurni.params.sources.merged.title.variables_reference_payment":"Referência variável (pagamento)",
         "wiredfurni.params.sources.merged.title.variables_reference_reward":"Referência variável (recompensas)",
         "wiredfurni.params.sources.users.0":"Use o usuário acionador",
         "wiredfurni.params.sources.users.10":"O usuário alcançado",
         "wiredfurni.params.sources.users.100":"Use o bot especificado pelo nome",
         "wiredfurni.params.sources.users.101":"Use o Habbo especificado pelo nome",
         "wiredfurni.params.sources.users.11":"O usuário clicado",
         "wiredfurni.params.sources.users.200":"Usar usuários do seletor",
         "wiredfurni.params.sources.users.201":"Usar usuários do Sinal",
         "wiredfurni.params.sources.users.900":"Todos os usuários no quarto",
         "wiredfurni.params.sources.users.title":"Selecionar usuários fonte:",
         "wiredfurni.params.sources.users.title.bots":"Selecione Bot fonte:",
         "wiredfurni.params.sources.users.title.carry":"Permitir transporte para:",
         "wiredfurni.params.sources.users.title.match.0":"Os usuários a coincidir:",
         "wiredfurni.params.sources.users.title.match.1":"Usuários para comparar com:",
         "wiredfurni.params.sources.users.title.physics.0":"Mover através dos usuários:",
         "wiredfurni.params.sources.users.title.reward_user":"Usuários para premiar:",
         "wiredfurni.params.sources.users.title.shooter":"O atirador:",
         "wiredfurni.params.sources.users.title.signal_forward":"Habbos para enviar:",
         "wiredfurni.params.start.following":"Começar a seguir",
         "wiredfurni.params.startdir":"Direção de Início",
         "wiredfurni.params.state_match":"Selecione mobis apenas se o estado corresponder",
         "wiredfurni.params.state_trigger.0":"Trigger for all states",
         "wiredfurni.params.state_trigger.1":"Trigger for the current state",
         "wiredfurni.params.stop.following":"Parar de seguir",
         "wiredfurni.params.talk":"Conversar",
         "wiredfurni.params.team":"Escolha um time",
         "wiredfurni.params.team.1":"Vermelho",
         "wiredfurni.params.team.2":"Verde",
         "wiredfurni.params.team.3":"Azul",
         "wiredfurni.params.team.4":"Amarelo",
         "wiredfurni.params.team.any":"Qualquer Equipe",
         "wiredfurni.params.team.triggerer":"Ativador da equipe",
         "wiredfurni.params.team_type.0":"Wired",
         "wiredfurni.params.team_type.1":"Battle Banzai",
         "wiredfurni.params.team_type.2":"Freeze",
         "wiredfurni.params.toggletype.0":"Alternar para o próximo estado",
         "wiredfurni.params.toggletype.1":"Alternar para o estado anterior",
         "wiredfurni.params.turn":"Quando o movimento é bloqueado",
         "wiredfurni.params.user_collide":"Ao colidir com o usuário",
         "wiredfurni.params.user_move.walkmode":"Se o usuário estivesse andando:",
         "wiredfurni.params.user_move.walkmode.0":"Continuar andando se for movido para junto do alvo",
         "wiredfurni.params.user_move.walkmode.1":"Continuar andando",
         "wiredfurni.params.user_move.walkmode.2":"Parar de andar",
         "wiredfurni.params.usercountmax":"Não mais de %value% pessoas",
         "wiredfurni.params.usercountmin":"Ao menos %value% pessoas",
         "wiredfurni.params.usertype":"Tipo de Usuário:",
         "wiredfurni.params.usertype.1":"Habbo",
         "wiredfurni.params.usertype.2":"Mascote",
         "wiredfurni.params.usertype.4":"Bot",
         "wiredfurni.params.variables.availability":"Opções de disponibilidade:",
         "wiredfurni.params.variables.availability.0":"Enquanto o usuário está no quarto",
         "wiredfurni.params.variables.availability.1":"Enquanto o quarto está ativo",
         "wiredfurni.params.variables.availability.10":"Permanente",
         "wiredfurni.params.variables.availability.11":"Permanente, compartilhado entre quartos",
         "wiredfurni.params.variables.compare_value":"Comparar valor:",
         "wiredfurni.params.variables.compare_value.0":"Data de criação",
         "wiredfurni.params.variables.compare_value.1":"Data da última modificação",
         "wiredfurni.params.variables.duration":"Duração:",
         "wiredfurni.params.variables.duration.0":"Milissegundos",
         "wiredfurni.params.variables.settings.has_value":"Tem valor",
         "wiredfurni.params.variables.settings.read_only":"Somente leitura",
         "wiredfurni.params.variables.trigger_options":"Ativar quando a variável for:",
         "wiredfurni.params.variables.trigger_options.1.0":"Aumentou ",
         "wiredfurni.params.whisper":"Sussurrar",
         "wiredfurni.params.write_to_logs.log_level.title":"Nível de registro:",
         "wiredfurni.params.effectid":"Efeito de avatar",
         "wiredfurni.params.movefurni.2":"Leste",
         "wiredfurni.params.movefurni.4":"Sul",
         "wiredfurni.params.movefurni.6":"Oeste"
      };
      
      private static var _pickGroup:int = 0;
      
      private static var _pickLabels:Array = [];
      
      private static var _formBindings:Array = [];
      
      private static var _roomVariables:Array = [];
      
      private static var _lastVariablesRequest:int = -5000;
      
      private static var _variableRoom:int = -1;
      
      private static var _hotelLanguage:String = "pt";
      
      private static var _chatCatalogue:Object = {
         "styles":[{
            "id":0,
            "name":"normal",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_normal_chat_bubble_base",
            "tail":"style_normal_chat_bubble_pointer",
            "preview":"style_normal_selector_preview",
            "icon":null,
            "tint":"style_normal_chat_bubble_color"
         },{
            "id":1,
            "name":"generic",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[28,18,1,1],
            "margins":[28,5,12,7],
            "face":null,
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":12,
            "overlap":[0,-1,0,0],
            "colorXY":null,
            "base":"style_generic_chat_bubble_base",
            "tail":"style_generic_chat_bubble_pointer",
            "preview":"style_generic_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":2,
            "name":"bot",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":true,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":null,
            "pointer":22,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_bot_chat_bubble_base",
            "tail":"style_bot_chat_bubble_pointer",
            "preview":"style_bot_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":3,
            "name":"normal_red",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_red_chat_bubble_base",
            "tail":"style_normal_red_chat_bubble_pointer",
            "preview":"style_normal_red_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":4,
            "name":"normal_blue",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_blue_chat_bubble_base",
            "tail":"style_normal_blue_chat_bubble_pointer",
            "preview":"style_normal_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":5,
            "name":"normal_yellow",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_yellow_chat_bubble_base",
            "tail":"style_normal_yellow_chat_bubble_pointer",
            "preview":"style_normal_yellow_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":6,
            "name":"normal_green",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_green_chat_bubble_base",
            "tail":"style_normal_green_chat_bubble_pointer",
            "preview":"style_normal_green_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":7,
            "name":"normal_grey",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_grey_chat_bubble_base",
            "tail":"style_normal_grey_chat_bubble_pointer",
            "preview":"style_normal_grey_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":8,
            "name":"fortune_teller",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[27,20,1,1],
            "margins":[26,7,12,7],
            "face":null,
            "pointer":26,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,2,0,0],
            "colorXY":null,
            "base":"style_fortune_teller_chat_bubble_base",
            "tail":"style_fortune_teller_chat_bubble_pointer",
            "preview":"style_fortune_teller_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":9,
            "name":"zombie_hand",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[30,17,1,1],
            "margins":[31,10,17,7],
            "face":[19,18],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[6,4,5,0],
            "colorXY":null,
            "base":"style_zombie_hand_chat_bubble_base",
            "tail":"style_zombie_hand_chat_bubble_pointer",
            "preview":"style_zombie_hand_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":10,
            "name":"skeleton",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[34,29,1,1],
            "margins":[32,16,15,9],
            "face":[19,24],
            "pointer":32,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[2,8,3,2],
            "colorXY":null,
            "base":"style_skeleton_chat_bubble_base",
            "tail":"style_skeleton_chat_bubble_pointer",
            "preview":"style_skeleton_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":11,
            "name":"normal_sky_blue",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_sky_blue_chat_bubble_base",
            "tail":"style_normal_sky_blue_chat_bubble_pointer",
            "preview":"style_normal_sky_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":12,
            "name":"normal_pink",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_pink_chat_bubble_base",
            "tail":"style_normal_pink_chat_bubble_pointer",
            "preview":"style_normal_pink_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":13,
            "name":"normal_purple",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_purple_chat_bubble_base",
            "tail":"style_normal_purple_chat_bubble_pointer",
            "preview":"style_normal_purple_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":14,
            "name":"normal_dark_yellow",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_dark_yellow_chat_bubble_base",
            "tail":"style_normal_dark_yellow_chat_bubble_pointer",
            "preview":"style_normal_dark_yellow_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":15,
            "name":"normal_dark_turquoise",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_normal_dark_turquoise_chat_bubble_base",
            "tail":"style_normal_dark_turquoise_chat_bubble_pointer",
            "preview":"style_normal_dark_turquoise_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":16,
            "name":"hearts",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[31,15,1,1],
            "margins":[29,7,12,7],
            "face":[14,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[1,1,0,0],
            "colorXY":null,
            "base":"style_hearts_chat_bubble_base",
            "tail":"style_hearts_chat_bubble_pointer",
            "preview":"style_hearts_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":17,
            "name":"gothicrose",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[36,24,1,1],
            "margins":[35,11,10,9],
            "face":[19,19],
            "pointer":30,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[5,5,0,2],
            "colorXY":null,
            "base":"style_gothicrose_chat_bubble_base",
            "tail":"style_gothicrose_chat_bubble_pointer",
            "preview":"style_gothicrose_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":19,
            "name":"piglet",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[30,17,1,1],
            "margins":[29,7,12,7],
            "face":[20,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[3,1,0,0],
            "colorXY":null,
            "base":"style_piglet_chat_bubble_base",
            "tail":"style_piglet_chat_bubble_pointer",
            "preview":"style_piglet_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":20,
            "name":"sausagedog",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[30,18,1,1],
            "margins":[29,7,12,7],
            "face":[20,15],
            "pointer":24,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[3,1,0,0],
            "colorXY":null,
            "base":"style_sausagedog_chat_bubble_base",
            "tail":"style_sausagedog_chat_bubble_pointer",
            "preview":"style_sausagedog_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":21,
            "name":"firingmylazer",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[32,22,1,1],
            "margins":[25,15,12,9],
            "face":[15,23],
            "pointer":34,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,9,0,0],
            "colorXY":null,
            "base":"style_firingmylazer_chat_bubble_base",
            "tail":"style_firingmylazer_chat_bubble_pointer",
            "preview":"style_firingmylazer_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":22,
            "name":"dragon",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[35,18,1,1],
            "margins":[28,9,12,9],
            "face":[19,18],
            "pointer":29,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[5,4,0,0],
            "colorXY":null,
            "base":"style_dragon_chat_bubble_base",
            "tail":"style_dragon_chat_bubble_pointer",
            "preview":"style_dragon_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":23,
            "name":"staff",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[32,21,1,1],
            "margins":[31,8,12,7],
            "face":[17,16],
            "pointer":27,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[3,2,0,0],
            "colorXY":null,
            "base":"style_staff_chat_bubble_base",
            "tail":"style_staff_chat_bubble_pointer",
            "preview":"style_staff_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":24,
            "name":"bats",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[40,22,1,1],
            "margins":[38,9,12,8],
            "face":[22,17],
            "pointer":28,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[8,3,0,0],
            "colorXY":null,
            "base":"style_bats_chat_bubble_base",
            "tail":"style_bats_chat_bubble_pointer",
            "preview":"style_bats_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":25,
            "name":"console",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[28,18,1,1],
            "margins":[28,7,12,10],
            "face":[15,15],
            "pointer":26,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_console_chat_bubble_base",
            "tail":"style_console_chat_bubble_pointer",
            "preview":"style_console_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":26,
            "name":"steampunk_pipe",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[30,16,1,1],
            "margins":[28,4,12,9],
            "face":[13,13],
            "pointer":20,
            "anonymous":false,
            "color":13408563,
            "size":12,
            "overlap":[2,-1,0,0],
            "colorXY":null,
            "base":"style_steampunk_pipe_chat_bubble_base",
            "tail":"style_steampunk_pipe_chat_bubble_pointer",
            "preview":"style_steampunk_pipe_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":27,
            "name":"storm",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[36,24,1,1],
            "margins":[35,11,12,7],
            "face":[20,19],
            "pointer":30,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[7,5,0,0],
            "colorXY":null,
            "base":"style_storm_chat_bubble_base",
            "tail":"style_storm_chat_bubble_pointer",
            "preview":"style_storm_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":28,
            "name":"parrot",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[25,4,15,7],
            "face":null,
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_parrot_chat_bubble_base",
            "tail":"style_parrot_chat_bubble_pointer",
            "preview":"style_parrot_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":29,
            "name":"pirate",
            "system":false,
            "hc":true,
            "staff":true,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[32,10,1,1],
            "margins":[32,5,10,8],
            "face":[15,13],
            "pointer":24,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,-1,0,0],
            "colorXY":null,
            "base":"style_pirate_chat_bubble_base",
            "tail":"style_pirate_chat_bubble_pointer",
            "preview":"style_pirate_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":30,
            "name":"bot_guide",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":true,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":null,
            "pointer":22,
            "anonymous":false,
            "color":203302,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_bot_guide_chat_bubble_base",
            "tail":"style_bot_guide_chat_bubble_pointer",
            "preview":"style_bot_guide_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":31,
            "name":"bot_rentable",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[16,10],
            "pointer":22,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_bot_rentable_chat_bubble_base",
            "tail":"style_bot_rentable_chat_bubble_pointer",
            "preview":"style_bot_rentable_selector_preview",
            "icon":"style_bot_rentable_icon",
            "tint":null
         },{
            "id":32,
            "name":"skelestock",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,16,1,1],
            "margins":[28,4,12,7],
            "face":null,
            "pointer":22,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_skelestock_chat_bubble_base",
            "tail":"style_skelestock_chat_bubble_pointer",
            "preview":"style_skelestock_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":33,
            "name":"bot_frank_large",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":true,
            "notification":false,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":21,
            "anonymous":false,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_bot_frank_large_chat_bubble_base",
            "tail":"style_bot_frank_large_chat_bubble_pointer",
            "preview":"style_bot_frank_large_selector_preview",
            "icon":"style_bot_frank_large_icon",
            "tint":null
         },{
            "id":34,
            "name":"notification",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_chat_bubble_base",
            "tail":"style_notification_chat_bubble_pointer",
            "preview":"style_notification_selector_preview",
            "icon":"style_notification_icon",
            "tint":null
         },{
            "id":35,
            "name":"goat",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,19,1,1],
            "margins":[28,6,12,7],
            "face":null,
            "pointer":25,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,0,0,0],
            "colorXY":null,
            "base":"style_goat_chat_bubble_base",
            "tail":"style_goat_chat_bubble_pointer",
            "preview":"style_goat_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":36,
            "name":"santa",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[11,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_santa_chat_bubble_base",
            "tail":"style_santa_chat_bubble_pointer",
            "preview":"style_santa_selector_preview",
            "icon":"style_santa_icon",
            "tint":null
         },{
            "id":37,
            "name":"ambassador",
            "system":false,
            "hc":false,
            "staff":true,
            "ambassador":true,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[32,21,1,1],
            "margins":[31,8,12,7],
            "face":[17,16],
            "pointer":27,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[3,2,0,0],
            "colorXY":null,
            "base":"style_ambassador_chat_bubble_base",
            "tail":"style_ambassador_chat_bubble_pointer",
            "preview":"style_ambassador_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":38,
            "name":"radio",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[29,17,1,1],
            "margins":[28,4,12,7],
            "face":[11,12],
            "pointer":23,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_radio_chat_bubble_base",
            "tail":"style_radio_chat_bubble_pointer",
            "preview":"style_radio_selector_preview",
            "icon":"style_radio_icon",
            "tint":null
         },{
            "id":120,
            "name":"snowstorm_red",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[34,29,1,1],
            "margins":[32,16,15,9],
            "face":[17,24],
            "pointer":34,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,8,3,2],
            "colorXY":null,
            "base":"style_snowstorm_red_chat_bubble_base",
            "tail":"style_snowstorm_red_chat_bubble_pointer",
            "preview":"style_snowstorm_red_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":121,
            "name":"snowstorm_blue",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[34,29,1,1],
            "margins":[32,16,15,9],
            "face":[17,24],
            "pointer":34,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,8,3,2],
            "colorXY":null,
            "base":"style_snowstorm_blue_chat_bubble_base",
            "tail":"style_snowstorm_blue_chat_bubble_pointer",
            "preview":"style_snowstorm_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":130,
            "name":"wired_team_red",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[42,20,1,1],
            "margins":[36,7,12,7],
            "face":[21,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,1,0,0],
            "colorXY":null,
            "base":"style_wired_team_red_chat_bubble_base",
            "tail":"style_wired_team_red_chat_bubble_pointer",
            "preview":"style_wired_team_red_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":131,
            "name":"wired_team_blue",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[42,20,1,1],
            "margins":[36,7,12,7],
            "face":[21,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,1,0,0],
            "colorXY":null,
            "base":"style_wired_team_blue_chat_bubble_base",
            "tail":"style_wired_team_blue_chat_bubble_pointer",
            "preview":"style_wired_team_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":132,
            "name":"wired_team_yellow",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[42,20,1,1],
            "margins":[36,7,12,7],
            "face":[21,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,1,0,0],
            "colorXY":null,
            "base":"style_wired_team_yellow_chat_bubble_base",
            "tail":"style_wired_team_yellow_chat_bubble_pointer",
            "preview":"style_wired_team_yellow_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":133,
            "name":"wired_team_green",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":false,
            "rect":[42,20,1,1],
            "margins":[36,7,12,7],
            "face":[21,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,1,0,0],
            "colorXY":null,
            "base":"style_wired_team_green_chat_bubble_base",
            "tail":"style_wired_team_green_chat_bubble_pointer",
            "preview":"style_wired_team_green_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":200,
            "name":"notification_red",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_red_chat_bubble_base",
            "tail":"style_notification_red_chat_bubble_pointer",
            "preview":"style_notification_red_selector_preview",
            "icon":"style_notification_red_icon",
            "tint":null
         },{
            "id":201,
            "name":"notification_green",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_green_chat_bubble_base",
            "tail":"style_notification_green_chat_bubble_pointer",
            "preview":"style_notification_green_selector_preview",
            "icon":"style_notification_green_icon",
            "tint":null
         },{
            "id":202,
            "name":"notification_blue",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_blue_chat_bubble_base",
            "tail":"style_notification_blue_chat_bubble_pointer",
            "preview":"style_notification_blue_selector_preview",
            "icon":"style_notification_blue_icon",
            "tint":null
         },{
            "id":210,
            "name":"notification_alert",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_alert_chat_bubble_base",
            "tail":"style_notification_alert_chat_bubble_pointer",
            "preview":"style_notification_alert_selector_preview",
            "icon":"style_notification_alert_icon",
            "tint":null
         },{
            "id":211,
            "name":"notification_info",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_info_chat_bubble_base",
            "tail":"style_notification_info_chat_bubble_pointer",
            "preview":"style_notification_info_selector_preview",
            "icon":"style_notification_info_icon",
            "tint":null
         },{
            "id":212,
            "name":"notification_warning",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_warning_chat_bubble_base",
            "tail":"style_notification_warning_chat_bubble_pointer",
            "preview":"style_notification_warning_selector_preview",
            "icon":"style_notification_warning_icon",
            "tint":null
         },{
            "id":220,
            "name":"notification_wrong",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_wrong_chat_bubble_base",
            "tail":"style_notification_wrong_chat_bubble_pointer",
            "preview":"style_notification_wrong_selector_preview",
            "icon":"style_notification_wrong_icon",
            "tint":null
         },{
            "id":221,
            "name":"notification_wrong_circle",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_wrong_circle_chat_bubble_base",
            "tail":"style_notification_wrong_circle_chat_bubble_pointer",
            "preview":"style_notification_wrong_circle_selector_preview",
            "icon":"style_notification_wrong_circle_icon",
            "tint":null
         },{
            "id":222,
            "name":"notification_correct",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_correct_chat_bubble_base",
            "tail":"style_notification_correct_chat_bubble_pointer",
            "preview":"style_notification_correct_selector_preview",
            "icon":"style_notification_correct_icon",
            "tint":null
         },{
            "id":223,
            "name":"notification_correct_circle",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_correct_circle_chat_bubble_base",
            "tail":"style_notification_correct_circle_chat_bubble_pointer",
            "preview":"style_notification_correct_circle_selector_preview",
            "icon":"style_notification_correct_circle_icon",
            "tint":null
         },{
            "id":224,
            "name":"notification_question_mark",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_question_mark_chat_bubble_base",
            "tail":"style_notification_question_mark_chat_bubble_pointer",
            "preview":"style_notification_question_mark_selector_preview",
            "icon":"style_notification_question_mark_icon",
            "tint":null
         },{
            "id":225,
            "name":"notification_question_mark_circle",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_question_mark_circle_chat_bubble_base",
            "tail":"style_notification_question_mark_circle_chat_bubble_pointer",
            "preview":"style_notification_question_mark_circle_selector_preview",
            "icon":"style_notification_question_mark_circle_icon",
            "tint":null
         },{
            "id":226,
            "name":"notification_arrow_up",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_arrow_up_chat_bubble_base",
            "tail":"style_notification_arrow_up_chat_bubble_pointer",
            "preview":"style_notification_arrow_up_selector_preview",
            "icon":"style_notification_arrow_up_icon",
            "tint":null
         },{
            "id":227,
            "name":"notification_arrow_up_circle",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_arrow_up_circle_chat_bubble_base",
            "tail":"style_notification_arrow_up_circle_chat_bubble_pointer",
            "preview":"style_notification_arrow_up_circle_selector_preview",
            "icon":"style_notification_arrow_up_circle_icon",
            "tint":null
         },{
            "id":228,
            "name":"notification_arrow_down",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_arrow_down_chat_bubble_base",
            "tail":"style_notification_arrow_down_chat_bubble_pointer",
            "preview":"style_notification_arrow_down_selector_preview",
            "icon":"style_notification_arrow_down_icon",
            "tint":null
         },{
            "id":229,
            "name":"notification_arrow_down_circle",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_arrow_down_circle_chat_bubble_base",
            "tail":"style_notification_arrow_down_circle_chat_bubble_pointer",
            "preview":"style_notification_arrow_down_circle_selector_preview",
            "icon":"style_notification_arrow_down_circle_icon",
            "tint":null
         },{
            "id":250,
            "name":"notification_skull",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_skull_chat_bubble_base",
            "tail":"style_notification_skull_chat_bubble_pointer",
            "preview":"style_notification_skull_selector_preview",
            "icon":"style_notification_skull_icon",
            "tint":null
         },{
            "id":251,
            "name":"notification_skull_2",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_skull_2_chat_bubble_base",
            "tail":"style_notification_skull_2_chat_bubble_pointer",
            "preview":"style_notification_skull_2_selector_preview",
            "icon":"style_notification_skull_2_icon",
            "tint":null
         },{
            "id":252,
            "name":"notification_magnifier",
            "system":true,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":true,
            "incomingOnly":false,
            "rect":[38,7,1,1],
            "margins":[38,2,12,6],
            "face":[19,13],
            "pointer":0,
            "anonymous":true,
            "color":0,
            "size":17,
            "overlap":[0,-2,0,-4],
            "colorXY":null,
            "base":"style_notification_magnifier_chat_bubble_base",
            "tail":"style_notification_magnifier_chat_bubble_pointer",
            "preview":"style_notification_magnifier_selector_preview",
            "icon":"style_notification_magnifier_icon",
            "tint":null
         },{
            "id":1000,
            "name":"nft_habbo_avatar_bronze",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[35,13,1,1],
            "margins":[29,9,12,7],
            "face":[16,16],
            "pointer":28,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_bronze_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_bronze_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_bronze_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1001,
            "name":"nft_habbo_avatar_gold",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[35,15,1,1],
            "margins":[29,9,12,7],
            "face":[16,16],
            "pointer":28,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_gold_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_gold_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_gold_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1002,
            "name":"nft_habbo_avatar_diamond",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[35,15,1,1],
            "margins":[29,9,12,7],
            "face":[16,16],
            "pointer":28,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_diamond_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_diamond_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_diamond_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1003,
            "name":"nft_habbo_avatar_rainbow",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[35,15,1,1],
            "margins":[29,9,12,7],
            "face":[16,16],
            "pointer":28,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_rainbow_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_rainbow_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_rainbow_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1004,
            "name":"nft_habbo_avatar_trippy",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[37,15,1,1],
            "margins":[33,12,12,7],
            "face":[20,16],
            "pointer":31,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_trippy_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_trippy_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_trippy_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1005,
            "name":"nft_habbo_avatar_ultra_trippy",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[37,15,1,1],
            "margins":[33,12,12,7],
            "face":[20,16],
            "pointer":31,
            "anonymous":false,
            "color":3342336,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_habbo_avatar_ultra_trippy_chat_bubble_base",
            "tail":"style_nft_habbo_avatar_ultra_trippy_chat_bubble_pointer",
            "preview":"style_nft_habbo_avatar_ultra_trippy_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1006,
            "name":"nft_mvhq",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[37,15,1,1],
            "margins":[33,12,12,7],
            "face":[20,16],
            "pointer":31,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_mvhq_chat_bubble_base",
            "tail":"style_nft_mvhq_chat_bubble_pointer",
            "preview":"style_nft_mvhq_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1007,
            "name":"nft_metakey",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[37,15,1,1],
            "margins":[33,11,12,9],
            "face":[20,16],
            "pointer":30,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_metakey_chat_bubble_base",
            "tail":"style_nft_metakey_chat_bubble_pointer",
            "preview":"style_nft_metakey_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1010,
            "name":"nft_crafted_habbo_avatar",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[47,17,1,1],
            "margins":[40,13,12,9],
            "face":[20,18],
            "pointer":32,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_crafted_habbo_avatar_chat_bubble_base",
            "tail":"style_nft_crafted_habbo_avatar_chat_bubble_pointer",
            "preview":"style_nft_crafted_habbo_avatar_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1011,
            "name":"nft_balloon_orange",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[42,19,1,1],
            "margins":[39,10,12,7],
            "face":[16,18],
            "pointer":29,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,5,3,0],
            "colorXY":[0,0],
            "base":"style_nft_balloon_orange_chat_bubble_base",
            "tail":"style_nft_balloon_orange_chat_bubble_pointer",
            "preview":"style_nft_balloon_orange_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1012,
            "name":"nft_balloon_blue",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[42,19,1,1],
            "margins":[39,10,12,7],
            "face":[16,18],
            "pointer":29,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,5,3,0],
            "colorXY":[0,0],
            "base":"style_nft_balloon_blue_chat_bubble_base",
            "tail":"style_nft_balloon_blue_chat_bubble_pointer",
            "preview":"style_nft_balloon_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1013,
            "name":"nft_origami_orange",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[33,14,1,1],
            "margins":[34,7,19,11],
            "face":[11,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[-1,2,1,0],
            "colorXY":[0,0],
            "base":"style_nft_origami_orange_chat_bubble_base",
            "tail":"style_nft_origami_orange_chat_bubble_pointer",
            "preview":"style_nft_origami_orange_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1014,
            "name":"nft_origami_blue",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[33,14,1,1],
            "margins":[34,7,19,11],
            "face":[11,15],
            "pointer":26,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[-1,2,1,0],
            "colorXY":[0,0],
            "base":"style_nft_origami_blue_chat_bubble_base",
            "tail":"style_nft_origami_blue_chat_bubble_pointer",
            "preview":"style_nft_origami_blue_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1015,
            "name":"nft_chocolate_dark",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[30,13,1,1],
            "margins":[31,5,9,6],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":16439195,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_chocolate_dark_chat_bubble_base",
            "tail":"style_nft_chocolate_dark_chat_bubble_pointer",
            "preview":"style_nft_chocolate_dark_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1016,
            "name":"nft_chocolate_white",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[30,13,1,1],
            "margins":[31,5,9,6],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":5912096,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_chocolate_white_chat_bubble_base",
            "tail":"style_nft_chocolate_white_chat_bubble_pointer",
            "preview":"style_nft_chocolate_white_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1017,
            "name":"nft_clay",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[35,11,1,1],
            "margins":[35,4,15,6],
            "face":[17,12],
            "pointer":23,
            "anonymous":false,
            "color":4925196,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_clay_chat_bubble_base",
            "tail":"style_nft_clay_chat_bubble_pointer",
            "preview":"style_nft_clay_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1018,
            "name":"nft_scroll",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[32,11,1,1],
            "margins":[31,4,12,11],
            "face":[15,12],
            "pointer":23,
            "anonymous":false,
            "color":8660759,
            "size":12,
            "overlap":[0,-2,0,3],
            "colorXY":[0,0],
            "base":"style_nft_scroll_chat_bubble_base",
            "tail":"style_nft_scroll_chat_bubble_pointer",
            "preview":"style_nft_scroll_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1019,
            "name":"nft_pillow",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[34,9,1,1],
            "margins":[33,2,16,10],
            "face":[17,10],
            "pointer":23,
            "anonymous":false,
            "color":16767388,
            "size":12,
            "overlap":[0,-2,0,2],
            "colorXY":[0,0],
            "base":"style_nft_pillow_chat_bubble_base",
            "tail":"style_nft_pillow_chat_bubble_pointer",
            "preview":"style_nft_pillow_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1020,
            "name":"nft_bobba",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[27,13,1,1],
            "margins":[28,9,23,9],
            "face":[17,16],
            "pointer":27,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[3,2,5,0],
            "colorXY":[0,0],
            "base":"style_nft_bobba_chat_bubble_base",
            "tail":"style_nft_bobba_chat_bubble_pointer",
            "preview":"style_nft_bobba_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1021,
            "name":"nft_pinktube",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[29,14,1,1],
            "margins":[32,5,13,8],
            "face":[16,13],
            "pointer":24,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-3,0,0],
            "colorXY":[0,0],
            "base":"style_nft_pinktube_chat_bubble_base",
            "tail":"style_nft_pinktube_chat_bubble_pointer",
            "preview":"style_nft_pinktube_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1022,
            "name":"nft_keycaps",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[29,10,1,1],
            "margins":[28,2,12,9],
            "face":[13,12],
            "pointer":23,
            "anonymous":false,
            "color":3814446,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_keycaps_chat_bubble_base",
            "tail":"style_nft_keycaps_chat_bubble_pointer",
            "preview":"style_nft_keycaps_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1023,
            "name":"nft_xmas22",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[36,12,1,1],
            "margins":[28,3,14,12],
            "face":[13,12],
            "pointer":19,
            "anonymous":false,
            "color":16777215,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":[0,0],
            "base":"style_nft_xmas22_chat_bubble_base",
            "tail":"style_nft_xmas22_chat_bubble_pointer",
            "preview":"style_nft_xmas22_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1024,
            "name":"nft_rocky",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[32,18,1,1],
            "margins":[27,11,15,9],
            "face":[16,18],
            "pointer":27,
            "anonymous":false,
            "color":15593455,
            "size":12,
            "overlap":[2,2,3,0],
            "colorXY":[0,0],
            "base":"style_nft_rocky_chat_bubble_base",
            "tail":"style_nft_rocky_chat_bubble_pointer",
            "preview":"style_nft_rocky_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1025,
            "name":"nft_ice",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[32,18,1,1],
            "margins":[27,11,15,9],
            "face":[16,18],
            "pointer":27,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[2,2,3,0],
            "colorXY":[0,0],
            "base":"style_nft_ice_chat_bubble_base",
            "tail":"style_nft_ice_chat_bubble_pointer",
            "preview":"style_nft_ice_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":1026,
            "name":"nft_aurora",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[30,14,1,1],
            "margins":[28,6,12,12],
            "face":[16,16],
            "pointer":31,
            "anonymous":false,
            "color":16759552,
            "size":12,
            "overlap":[0,-4,0,0],
            "colorXY":[0,0],
            "base":"style_nft_aurora_chat_bubble_base",
            "tail":"style_nft_aurora_chat_bubble_pointer",
            "preview":"style_nft_aurora_selector_preview",
            "icon":null,
            "tint":null
         },{
            "id":10000,
            "name":"recycled",
            "system":false,
            "hc":false,
            "staff":false,
            "ambassador":false,
            "html":false,
            "notification":false,
            "incomingOnly":true,
            "rect":[30,19,1,1],
            "margins":[30,7,14,9],
            "face":[16,15],
            "pointer":29,
            "anonymous":false,
            "color":0,
            "size":12,
            "overlap":[0,-2,0,0],
            "colorXY":null,
            "base":"style_recycled_chat_bubble_base",
            "tail":"style_recycled_chat_bubble_pointer",
            "preview":"style_recycled_selector_preview",
            "icon":null,
            "tint":null
         }],
         "images":{
            "style_ambassador_chat_bubble_base":[0,0,54,28],
            "style_ambassador_chat_bubble_pointer":[55,0,9,6],
            "style_ambassador_selector_preview":[0,0,54,28],
            "style_bats_chat_bubble_base":[65,0,61,30],
            "style_bats_chat_bubble_pointer":[127,0,9,6],
            "style_bats_selector_preview":[137,0,53,30],
            "style_bot_chat_bubble_base":[191,0,51,24],
            "style_bot_chat_bubble_pointer":[243,0,9,7],
            "style_bot_frank_large_chat_bubble_base":[253,0,63,22],
            "style_bot_frank_large_chat_bubble_pointer":[317,0,9,6],
            "style_bot_frank_large_icon":[327,0,19,19],
            "style_bot_frank_large_selector_preview":[347,0,51,30],
            "style_bot_guide_chat_bubble_base":[399,0,51,24],
            "style_bot_guide_chat_bubble_pointer":[451,0,9,7],
            "style_bot_guide_selector_preview":[399,0,51,24],
            "style_bot_rentable_chat_bubble_base":[461,0,51,24],
            "style_bot_rentable_chat_bubble_pointer":[243,0,9,7],
            "style_bot_rentable_icon":[513,0,20,11],
            "style_bot_rentable_selector_preview":[191,0,51,24],
            "style_bot_selector_preview":[191,0,51,24],
            "style_console_chat_bubble_base":[347,0,51,30],
            "style_console_chat_bubble_pointer":[534,0,9,9],
            "style_console_selector_preview":[347,0,51,30],
            "style_dragon_chat_bubble_base":[544,0,57,31],
            "style_dragon_chat_bubble_pointer":[602,0,9,6],
            "style_dragon_selector_preview":[612,0,51,28],
            "style_firingmylazer_chat_bubble_base":[664,0,53,37],
            "style_firingmylazer_chat_bubble_pointer":[718,0,9,6],
            "style_firingmylazer_selector_preview":[728,0,53,33],
            "style_fortune_teller_chat_bubble_base":[782,0,51,27],
            "style_fortune_teller_chat_bubble_pointer":[834,0,9,6],
            "style_fortune_teller_selector_preview":[782,0,51,27],
            "style_generic_chat_bubble_base":[844,0,51,25],
            "style_generic_chat_bubble_pointer":[317,0,9,6],
            "style_generic_selector_preview":[844,0,51,25],
            "style_goat_chat_bubble_base":[896,0,51,26],
            "style_goat_chat_bubble_pointer":[948,0,9,6],
            "style_goat_selector_preview":[896,0,51,26],
            "style_gothicrose_chat_bubble_base":[958,0,56,33],
            "style_gothicrose_chat_bubble_pointer":[0,38,9,6],
            "style_gothicrose_selector_preview":[10,38,52,33],
            "style_hearts_chat_bubble_base":[63,38,52,27],
            "style_hearts_chat_bubble_pointer":[116,38,9,6],
            "style_hearts_selector_preview":[63,38,52,27],
            "style_nft_aurora_chat_bubble_base":[126,38,50,32],
            "style_nft_aurora_chat_bubble_pointer":[177,38,9,5],
            "style_nft_aurora_selector_preview":[126,38,50,32],
            "style_nft_balloon_blue_chat_bubble_base":[187,38,60,30],
            "style_nft_balloon_blue_chat_bubble_pointer":[248,38,9,6],
            "style_nft_balloon_blue_selector_preview":[258,38,55,34],
            "style_nft_balloon_orange_chat_bubble_base":[314,38,60,30],
            "style_nft_balloon_orange_chat_bubble_pointer":[375,38,9,6],
            "style_nft_balloon_orange_selector_preview":[385,38,55,34],
            "style_nft_bobba_chat_bubble_base":[441,38,59,31],
            "style_nft_bobba_chat_bubble_pointer":[501,38,11,6],
            "style_nft_bobba_selector_preview":[513,38,55,34],
            "style_nft_chocolate_dark_chat_bubble_base":[569,38,51,24],
            "style_nft_chocolate_dark_chat_bubble_pointer":[621,38,10,5],
            "style_nft_chocolate_dark_selector_preview":[632,38,55,34],
            "style_nft_chocolate_white_chat_bubble_base":[688,38,51,24],
            "style_nft_chocolate_white_chat_bubble_pointer":[740,38,10,5],
            "style_nft_chocolate_white_selector_preview":[751,38,51,24],
            "style_nft_clay_chat_bubble_base":[803,38,59,24],
            "style_nft_clay_chat_bubble_pointer":[863,38,10,5],
            "style_nft_clay_selector_preview":[874,38,50,24],
            "style_nft_crafted_habbo_avatar_chat_bubble_base":[925,38,58,39],
            "style_nft_crafted_habbo_avatar_chat_bubble_pointer":[984,38,13,9],
            "style_nft_crafted_habbo_avatar_selector_preview":[925,38,58,39],
            "style_nft_habbo_avatar_bronze_chat_bubble_base":[0,78,49,31],
            "style_nft_habbo_avatar_bronze_chat_bubble_pointer":[50,78,9,5],
            "style_nft_habbo_avatar_bronze_selector_preview":[60,78,54,31],
            "style_nft_habbo_avatar_diamond_chat_bubble_base":[115,78,49,31],
            "style_nft_habbo_avatar_diamond_chat_bubble_pointer":[165,78,9,5],
            "style_nft_habbo_avatar_diamond_selector_preview":[175,78,54,31],
            "style_nft_habbo_avatar_gold_chat_bubble_base":[230,78,49,31],
            "style_nft_habbo_avatar_gold_chat_bubble_pointer":[280,78,9,5],
            "style_nft_habbo_avatar_gold_selector_preview":[290,78,54,31],
            "style_nft_habbo_avatar_rainbow_chat_bubble_base":[345,78,49,31],
            "style_nft_habbo_avatar_rainbow_chat_bubble_pointer":[395,78,9,5],
            "style_nft_habbo_avatar_rainbow_selector_preview":[405,78,54,31],
            "style_nft_habbo_avatar_trippy_chat_bubble_base":[460,78,56,37],
            "style_nft_habbo_avatar_trippy_chat_bubble_pointer":[517,78,11,8],
            "style_nft_habbo_avatar_trippy_selector_preview":[529,78,61,37],
            "style_nft_habbo_avatar_ultra_trippy_chat_bubble_base":[591,78,56,37],
            "style_nft_habbo_avatar_ultra_trippy_chat_bubble_pointer":[648,78,11,8],
            "style_nft_habbo_avatar_ultra_trippy_selector_preview":[660,78,61,37],
            "style_nft_ice_chat_bubble_base":[722,78,56,29],
            "style_nft_ice_chat_bubble_pointer":[779,78,13,7],
            "style_nft_ice_selector_preview":[793,78,50,29],
            "style_nft_keycaps_chat_bubble_base":[844,78,57,24],
            "style_nft_keycaps_chat_bubble_pointer":[902,78,9,6],
            "style_nft_keycaps_selector_preview":[912,78,46,24],
            "style_nft_metakey_chat_bubble_base":[0,116,66,36],
            "style_nft_metakey_chat_bubble_pointer":[67,116,9,5],
            "style_nft_metakey_selector_preview":[77,116,56,29],
            "style_nft_mvhq_chat_bubble_base":[134,116,52,33],
            "style_nft_mvhq_chat_bubble_pointer":[187,116,9,5],
            "style_nft_mvhq_selector_preview":[134,116,52,33],
            "style_nft_origami_blue_chat_bubble_base":[197,116,52,31],
            "style_nft_origami_blue_chat_bubble_pointer":[250,116,9,6],
            "style_nft_origami_blue_selector_preview":[260,116,55,34],
            "style_nft_origami_orange_chat_bubble_base":[316,116,52,31],
            "style_nft_origami_orange_chat_bubble_pointer":[369,116,9,6],
            "style_nft_origami_orange_selector_preview":[379,116,55,34],
            "style_nft_pillow_chat_bubble_base":[435,116,58,26],
            "style_nft_pillow_chat_bubble_pointer":[494,116,10,5],
            "style_nft_pillow_selector_preview":[505,116,55,34],
            "style_nft_pinktube_chat_bubble_base":[561,116,59,26],
            "style_nft_pinktube_chat_bubble_pointer":[621,116,9,6],
            "style_nft_pinktube_selector_preview":[631,116,46,26],
            "style_nft_rocky_chat_bubble_base":[678,116,56,29],
            "style_nft_rocky_chat_bubble_pointer":[735,116,13,7],
            "style_nft_rocky_selector_preview":[749,116,50,29],
            "style_nft_scroll_chat_bubble_base":[800,116,52,29],
            "style_nft_scroll_chat_bubble_pointer":[853,116,10,5],
            "style_nft_scroll_selector_preview":[864,116,55,34],
            "style_nft_xmas22_chat_bubble_base":[920,116,57,24],
            "style_nft_xmas22_chat_bubble_pointer":[978,116,16,9],
            "style_nft_xmas22_selector_preview":[0,153,55,34],
            "style_normal_blue_chat_bubble_base":[56,153,51,24],
            "style_normal_blue_chat_bubble_pointer":[108,153,9,6],
            "style_normal_blue_selector_preview":[56,153,51,24],
            "style_normal_chat_bubble_base":[118,153,51,24],
            "style_normal_chat_bubble_color":[170,153,30,24],
            "style_normal_chat_bubble_pointer":[317,0,9,6],
            "style_normal_dark_turquoise_chat_bubble_base":[201,153,51,24],
            "style_normal_dark_turquoise_chat_bubble_pointer":[253,153,9,6],
            "style_normal_dark_turquoise_selector_preview":[201,153,51,24],
            "style_normal_dark_yellow_chat_bubble_base":[263,153,51,24],
            "style_normal_dark_yellow_chat_bubble_pointer":[315,153,9,6],
            "style_normal_dark_yellow_selector_preview":[263,153,51,24],
            "style_normal_green_chat_bubble_base":[325,153,51,24],
            "style_normal_green_chat_bubble_pointer":[377,153,9,6],
            "style_normal_green_selector_preview":[325,153,51,24],
            "style_normal_grey_chat_bubble_base":[387,153,51,24],
            "style_normal_grey_chat_bubble_pointer":[439,153,9,6],
            "style_normal_grey_selector_preview":[387,153,51,24],
            "style_normal_pink_chat_bubble_base":[449,153,51,24],
            "style_normal_pink_chat_bubble_pointer":[501,153,9,6],
            "style_normal_pink_selector_preview":[449,153,51,24],
            "style_normal_purple_chat_bubble_base":[511,153,51,24],
            "style_normal_purple_chat_bubble_pointer":[563,153,9,6],
            "style_normal_purple_selector_preview":[511,153,51,24],
            "style_normal_red_chat_bubble_base":[573,153,51,24],
            "style_normal_red_chat_bubble_pointer":[625,153,9,6],
            "style_normal_red_selector_preview":[573,153,51,24],
            "style_normal_selector_preview":[635,153,51,24],
            "style_normal_sky_blue_chat_bubble_base":[687,153,51,24],
            "style_normal_sky_blue_chat_bubble_pointer":[739,153,9,6],
            "style_normal_sky_blue_selector_preview":[687,153,51,24],
            "style_normal_yellow_chat_bubble_base":[749,153,51,24],
            "style_normal_yellow_chat_bubble_pointer":[801,153,9,6],
            "style_normal_yellow_selector_preview":[749,153,51,24],
            "style_notification_alert_chat_bubble_base":[811,153,63,22],
            "style_notification_alert_chat_bubble_pointer":[317,0,9,6],
            "style_notification_alert_icon":[875,153,19,19],
            "style_notification_alert_selector_preview":[347,0,51,30],
            "style_notification_arrow_down_chat_bubble_base":[895,153,63,22],
            "style_notification_arrow_down_chat_bubble_pointer":[317,0,9,6],
            "style_notification_arrow_down_circle_chat_bubble_base":[895,153,63,22],
            "style_notification_arrow_down_circle_chat_bubble_pointer":[317,0,9,6],
            "style_notification_arrow_down_circle_icon":[959,153,19,19],
            "style_notification_arrow_down_circle_selector_preview":[347,0,51,30],
            "style_notification_arrow_down_icon":[979,153,19,19],
            "style_notification_arrow_down_selector_preview":[347,0,51,30],
            "style_notification_arrow_up_chat_bubble_base":[0,188,63,22],
            "style_notification_arrow_up_chat_bubble_pointer":[317,0,9,6],
            "style_notification_arrow_up_circle_chat_bubble_base":[0,188,63,22],
            "style_notification_arrow_up_circle_chat_bubble_pointer":[317,0,9,6],
            "style_notification_arrow_up_circle_icon":[64,188,19,19],
            "style_notification_arrow_up_circle_selector_preview":[347,0,51,30],
            "style_notification_arrow_up_icon":[84,188,19,19],
            "style_notification_arrow_up_selector_preview":[347,0,51,30],
            "style_notification_blue_chat_bubble_base":[104,188,63,22],
            "style_notification_blue_chat_bubble_pointer":[317,0,9,6],
            "style_notification_blue_icon":[168,188,19,19],
            "style_notification_blue_selector_preview":[347,0,51,30],
            "style_notification_chat_bubble_base":[188,188,63,22],
            "style_notification_chat_bubble_pointer":[317,0,9,6],
            "style_notification_correct_chat_bubble_base":[252,188,63,22],
            "style_notification_correct_chat_bubble_pointer":[317,0,9,6],
            "style_notification_correct_circle_chat_bubble_base":[252,188,63,22],
            "style_notification_correct_circle_chat_bubble_pointer":[317,0,9,6],
            "style_notification_correct_circle_icon":[316,188,19,19],
            "style_notification_correct_circle_selector_preview":[347,0,51,30],
            "style_notification_correct_icon":[336,188,19,19],
            "style_notification_correct_selector_preview":[347,0,51,30],
            "style_notification_green_chat_bubble_base":[356,188,63,22],
            "style_notification_green_chat_bubble_pointer":[317,0,9,6],
            "style_notification_green_icon":[420,188,19,19],
            "style_notification_green_selector_preview":[440,188,63,27],
            "style_notification_icon":[420,188,19,19],
            "style_notification_info_chat_bubble_base":[104,188,63,22],
            "style_notification_info_chat_bubble_pointer":[317,0,9,6],
            "style_notification_info_icon":[504,188,19,19],
            "style_notification_info_selector_preview":[347,0,51,30],
            "style_notification_magnifier_chat_bubble_base":[524,188,63,22],
            "style_notification_magnifier_chat_bubble_pointer":[317,0,9,6],
            "style_notification_magnifier_icon":[588,188,19,19],
            "style_notification_magnifier_selector_preview":[347,0,51,30],
            "style_notification_question_mark_chat_bubble_base":[608,188,63,22],
            "style_notification_question_mark_chat_bubble_pointer":[317,0,9,6],
            "style_notification_question_mark_circle_chat_bubble_base":[608,188,63,22],
            "style_notification_question_mark_circle_chat_bubble_pointer":[317,0,9,6],
            "style_notification_question_mark_circle_icon":[672,188,19,19],
            "style_notification_question_mark_circle_selector_preview":[347,0,51,30],
            "style_notification_question_mark_icon":[692,188,19,19],
            "style_notification_question_mark_selector_preview":[347,0,51,30],
            "style_notification_red_chat_bubble_base":[811,153,63,22],
            "style_notification_red_chat_bubble_pointer":[317,0,9,6],
            "style_notification_red_icon":[168,188,19,19],
            "style_notification_red_selector_preview":[347,0,51,30],
            "style_notification_selector_preview":[440,188,63,27],
            "style_notification_skull_2_chat_bubble_base":[712,188,63,22],
            "style_notification_skull_2_chat_bubble_pointer":[317,0,9,6],
            "style_notification_skull_2_icon":[776,188,19,19],
            "style_notification_skull_2_selector_preview":[347,0,51,30],
            "style_notification_skull_chat_bubble_base":[796,188,63,22],
            "style_notification_skull_chat_bubble_pointer":[317,0,9,6],
            "style_notification_skull_icon":[776,188,19,19],
            "style_notification_skull_selector_preview":[347,0,51,30],
            "style_notification_warning_chat_bubble_base":[860,188,63,22],
            "style_notification_warning_chat_bubble_pointer":[317,0,9,6],
            "style_notification_warning_icon":[924,188,19,19],
            "style_notification_warning_selector_preview":[347,0,51,30],
            "style_notification_wrong_chat_bubble_base":[811,153,63,22],
            "style_notification_wrong_chat_bubble_pointer":[317,0,9,6],
            "style_notification_wrong_circle_chat_bubble_base":[811,153,63,22],
            "style_notification_wrong_circle_chat_bubble_pointer":[317,0,9,6],
            "style_notification_wrong_circle_icon":[944,188,19,19],
            "style_notification_wrong_circle_selector_preview":[347,0,51,30],
            "style_notification_wrong_icon":[964,188,19,19],
            "style_notification_wrong_selector_preview":[347,0,51,30],
            "style_parrot_chat_bubble_base":[0,216,51,24],
            "style_parrot_chat_bubble_pointer":[52,216,9,6],
            "style_parrot_selector_preview":[0,216,51,24],
            "style_piglet_chat_bubble_base":[62,216,52,27],
            "style_piglet_chat_bubble_pointer":[115,216,9,6],
            "style_piglet_selector_preview":[62,216,52,27],
            "style_pirate_chat_bubble_base":[125,216,53,26],
            "style_pirate_chat_bubble_pointer":[179,216,9,6],
            "style_pirate_selector_preview":[189,216,52,26],
            "style_radio_chat_bubble_base":[242,216,51,24],
            "style_radio_chat_bubble_pointer":[294,216,9,6],
            "style_radio_icon":[304,216,19,19],
            "style_radio_selector_preview":[324,216,55,34],
            "style_recycled_chat_bubble_base":[380,216,55,29],
            "style_recycled_chat_bubble_pointer":[436,216,9,6],
            "style_recycled_selector_preview":[380,216,55,29],
            "style_santa_chat_bubble_base":[446,216,51,24],
            "style_santa_chat_bubble_pointer":[498,216,9,6],
            "style_santa_icon":[508,216,13,18],
            "style_santa_selector_preview":[522,216,55,34],
            "style_sausagedog_chat_bubble_base":[578,216,52,27],
            "style_sausagedog_chat_bubble_pointer":[631,216,8,8],
            "style_sausagedog_selector_preview":[640,216,50,27],
            "style_skelestock_chat_bubble_base":[691,216,51,24],
            "style_skelestock_chat_bubble_pointer":[743,216,9,6],
            "style_skelestock_selector_preview":[691,216,51,24],
            "style_skeleton_chat_bubble_base":[753,216,58,38],
            "style_skeleton_chat_bubble_pointer":[812,216,7,8],
            "style_skeleton_selector_preview":[820,216,54,34],
            "style_snowstorm_blue_chat_bubble_base":[875,216,53,35],
            "style_snowstorm_blue_chat_bubble_pointer":[929,216,9,6],
            "style_snowstorm_blue_selector_preview":[875,216,53,35],
            "style_snowstorm_red_chat_bubble_base":[939,216,53,35],
            "style_snowstorm_red_chat_bubble_pointer":[993,216,9,6],
            "style_snowstorm_red_selector_preview":[939,216,53,35],
            "style_staff_chat_bubble_base":[0,255,54,28],
            "style_staff_chat_bubble_pointer":[55,0,9,6],
            "style_staff_selector_preview":[0,255,54,28],
            "style_steampunk_pipe_chat_bubble_base":[55,255,51,26],
            "style_steampunk_pipe_chat_bubble_pointer":[107,255,9,10],
            "style_steampunk_pipe_selector_preview":[117,255,51,26],
            "style_storm_chat_bubble_base":[169,255,58,31],
            "style_storm_chat_bubble_pointer":[228,255,9,6],
            "style_storm_selector_preview":[238,255,54,31],
            "style_wired_team_blue_chat_bubble_base":[293,255,59,27],
            "style_wired_team_blue_chat_bubble_pointer":[353,255,9,6],
            "style_wired_team_blue_selector_preview":[363,255,55,34],
            "style_wired_team_green_chat_bubble_base":[419,255,59,27],
            "style_wired_team_green_chat_bubble_pointer":[479,255,9,6],
            "style_wired_team_green_selector_preview":[489,255,55,34],
            "style_wired_team_red_chat_bubble_base":[545,255,59,27],
            "style_wired_team_red_chat_bubble_pointer":[605,255,9,6],
            "style_wired_team_red_selector_preview":[615,255,55,34],
            "style_wired_team_yellow_chat_bubble_base":[671,255,59,27],
            "style_wired_team_yellow_chat_bubble_pointer":[731,255,9,6],
            "style_wired_team_yellow_selector_preview":[741,255,55,34],
            "style_zombie_hand_chat_bubble_base":[797,255,62,30],
            "style_zombie_hand_chat_bubble_pointer":[860,255,7,10],
            "style_zombie_hand_selector_preview":[868,255,54,30]
         }
      };
      
      private static var _chatBitmaps:Object = {};
      
      private static var _friendHighlightEnabled:Boolean = true;
      
      private static var _consoleHistoryHeader:int = -1;
      
      private static var _consoleOwnId:int = 0;
      
      private static var _consoleHistories:Dictionary = new Dictionary();
      
      private static var _consoleViews:Dictionary = new Dictionary(true);
      
      private static var _consoleLiveIds:Dictionary = new Dictionary();
      
      private static var _consoleLivePeers:Dictionary = new Dictionary();
      
      private static var _consoleHistoryIds:Dictionary = new Dictionary();
      
      private static var _insertingConsoleHistory:Boolean = false;
      
      private static var _socialPreferencesLoaded:Boolean = false;
      
      private static var _friendIds:Dictionary = new Dictionary();
      
      private static var _seenRoomFriends:Dictionary = new Dictionary();
      
      private static var _friendTags:Dictionary = new Dictionary();
      
      private static var _friendRoom:int = -1;
      
      private static var _lastFriendScan:int = -1000;
      
      private static var _optionStates:Dictionary = new Dictionary(true);
      
      private static var _optionChoices:Dictionary = new Dictionary(true);
      
      private static var _wiredOpeningStage:String = "ler configuração";
      
      private static var _editorRoom:int = -1;
      
      private static var _areaActive:Boolean = false;
      
      private static var _areaSelecting:Boolean = false;
      
      private static var _areaDragging:Boolean = false;
      
      private static var _areaTouchId:int = -1;
      
      private static var _areaGhosts:Dictionary = new Dictionary(true);
      
      private static var _lastGhostRefresh:int = 0;
      
      private static var _areaGeometryVersion:int = -1;
      
      private static var _heightRange:Number = 10;
      
      private static var _heightRoom:int = -1;
      
      private static var _heightDesired:int = 0;
      
      private static var _heightSent:int = 0;
      
      private static var _heightDirty:Boolean = false;
      
      private static var _heightAwait:Boolean = false;
      
      private static var _heightRequests:Array = [];
      
      private static var _heightSendAt:int = 0;
      
      private static var _heightSync:Boolean = false;
      
      private static var _heightEditing:Boolean = false;
      
      private static var _actionUpdating:Boolean = false;
      
      private static var _furniturePicking:Boolean = false;
      
      private static var _pickButtons:Array = [];
      
      private static var _furnitureMarks:Dictionary = new Dictionary(true);
      
      private static var _loginViews:Dictionary = new Dictionary(true);
      
      private static var _tokenScreens:Dictionary = new Dictionary(true);
      
      private static var _tokenActions:Dictionary = new Dictionary(true);
      
      private static var _eventPickers:Dictionary = new Dictionary(true);
      
      private static var _eventButtons:Dictionary = new Dictionary(true);
      
      private static var _eventListRequests:Dictionary = new Dictionary(true);
      
      private static var _catalogHistory:Dictionary = new Dictionary(true);
      
      private static var _catalogRestore:Dictionary = new Dictionary(true);
      
      private static var _incomeStatusHeader:int = -1;
      
      private static var _incomeClaimHeader:int = -1;
      
      private static var _incomeNoticeHeader:int = -1;
      
      private static var _incomeClaimRequest:int = -1;
      
      private static var _incomeRewards:Array = [];
      
      private static var _incomePending:Object = {};
      
      private static var _incomeButtons:Dictionary = new Dictionary(true);
      
      private static var _incomeLoaded:Boolean = false;
      
      private static var _incomeNames:Array = ["Primeiros passos","Presente diário","Conquistas","Feira Livre","Dia do Pagamento HC","Progressão de nível","Packs","Sacola de Provisões","Doações","Caixas Surpresa","SnowStorm","Jogos","Baús Wired","Agências"];
      
      private static var _uiFrames:Object = {
         "currency_credits":[0,0,15,15],
         "currency_duckets":[16,0,15,15],
         "currency_emerald":[32,0,24,24],
         "currency_silver":[57,0,24,24],
         "earnings_icon_achievements":[82,0,24,26],
         "earnings_icon_bonusbag":[107,0,22,26],
         "earnings_icon_chests":[130,0,24,26],
         "earnings_icon_dailygift":[155,0,24,26],
         "earnings_icon_donations":[180,0,23,26],
         "earnings_icon_games":[204,0,24,26],
         "earnings_icon_hcpayday":[229,0,24,26],
         "earnings_icon_levelprogression":[254,0,24,26],
         "earnings_icon_marketplace":[279,0,24,26],
         "earnings_icon_roombundle":[304,0,32,32],
         "earnings_icon_rpgs":[337,0,24,27],
         "earnings_icon_snowstorm":[362,0,19,26],
         "earnings_icon_surprise":[382,0,24,26],
         "earnings_icon_tutorial":[407,0,32,32]
      };
      
      private static var _uiTextures:Object = {};
      
      private static var _purseBars:Dictionary = new Dictionary(true);
      
      private static var _purseClicks:Dictionary = new Dictionary(true);
      
      private static var _creditReady:Dictionary = new Dictionary(true);
      
      private static var _creditsRequests:Dictionary = new Dictionary(true);
      
      private static var _extraBalances:Object = {};
      
      private static var _silverHeader:int = -1;
      
      private static var _emeraldHeader:int = -1;
      
      private static var _recolorDefaults:Object = {
         "artdeco1":"672913,A73E18,EB840C,E9C258,669933",
         "classic":"FFFFFF,F7EBBC,ABD0D2,5EAAF8,835AB1,AC5AB1,FF99BC,525252,672913,E14218,FF9900,FFD837,92D13D,007223",
         "default":"FFFFFF,AEF0D8,99FFCC,00E9E5,00F8FD,A1E8FD,ABD0D2,BCC0C4,F5D1B3,FDE1B1,F7EBBC,FDD97E,FFD837,DBF96F,BAFA00,9ABD00,8AAE00,92D13D,B6FA70,4EFA99,52DA50,00BA00,00AA00,00A943,007900,007223,005900,2E632E,0D380C,336666,004059,525252,778084,008895,2CBFFF,5EAAF8,BCB7FF,DDB6FE,FEB6FE,F5BFE1,FF99BC,FF7852,E14218,FF3600,E76000,FF9900,FEA13D,AD8100,666600,513100,6F3D0C,672913,8D1600,AE0024,E7005F,FF549C,AC5AB1,835AB1,6685FF,0085FF,0074FF,9C73FF,FE72FF,DE00D7,96008E,3F1BC7,0000C8,683EFF,0000FF",
         "grass":"B0B1AE,6AB18E,57832E,30B106,929E12,B19626,B15501",
         "industrial":"545B5B,3C412F,3D3432,262C31,383F55",
         "metal":"8F9B9B,676F51,695955,414B53,606B92",
         "metalcrate":"BBBBBB,B5AC8A,7D989A,457DB6,604282,7E4282,BB708A,3C3C3C,4B1E0E,A53012,BB7000,BB9E28,6B992D,00541A",
         "redbrick":"CECECE,C7BE98,8AA8A9,4C89C8,6A498F,8B498F,CE7B98,424242,53210F,B63513,CE7B00,CEAE2C,76A931,005C1C",
         "sand":"F7EBBC,C29655,7E5C1D,95701D,CB8233,E1A53A,F0C833",
         "stone":"D0D0D0,C9C099,8BAAAB,4D8BCA,6B4990,8C4990,D07D99,434343,54210F,B73614,D07D00,D0B02D,77AA32,005D1D",
         "water":"336666,0069A6,5EAAF8,7AD8FF,99FFCC,E14218",
         "wood":"636568,667660,5A5045,7F603B,714A23,7D3822"
      };
      
      private static var _recolorMapping:String = "default=bc_block_0_recolorable,bc_block_1_recolorable,bc_cone_recolorable,bc_cylinder_recolorable,bc_halfcylinder_recolorable,bc_hemisphere_recolorable,bc_panel_recolorable,bc_pyramidtip_recolorable,bc_quarterring_recolorable,bc_round_recolorable,bc_stairs_recolorable,bc_standinghalfcylinder_recolorable,bc_standingtriangularprism_recolorable,bc_stick_recolorable,bc_triangularprism_recolorable,bc_wedge_recolorable,bc_block_small_recolorable,bc_curvedramp_recolorable,bc_glasspanel_recolorable,bc_quartercircle_recolorable,bc_ramp_recolorable,bc_sphere_recolorable,bc_sphere_small_recolorable,bc_wedgecrnr_recolorable,bc_alpha1_alpha_recolorable,bc_alpha1_a_recolorable,bc_alpha1_b_recolorable,bc_alpha1_c_recolorable,bc_alpha1_d_recolorable,bc_alpha1_e_recolorable,bc_alpha1_f_recolorable,bc_alpha1_g_recolorable,bc_alpha1_h_recolorable,bc_alpha1_i_recolorable,bc_alpha1_j_recolorable,bc_alpha1_k_recolorable,bc_alpha1_l_recolorable,bc_alpha1_m_recolorable,bc_alpha1_n_recolorable,bc_alpha1_num_recolorable,bc_alpha1_o_recolorable,bc_alpha1_p_recolorable,bc_alpha1_q_recolorable,bc_alpha1_r_recolorable,bc_alpha1_s_recolorable,bc_alpha1_t_recolorable,bc_alpha1_u_recolorable,bc_alpha1_v_recolorable,bc_alpha1_w_recolorable,bc_alpha1_x_recolorable,bc_alpha1_y_recolorable,bc_alpha1_z_recolorable;artdeco1=bc_block_artdeco1_recolorable;classic=bc_block_glass_recolorable,bc_block_marble_recolorable,bc_block_wool_recolorable,bc_flowerhedge_recolorable,bc_lavarock_recolorable,bc_terra_recolorable,bc_tile_recolorable;grass=bc_block_grass_recolorable;industrial=bc_block_industrial_recolorable;metal=bc_block_metalgrip_recolorable;redbrick=bc_block_redbrick_recolorable;sand=bc_block_sand_recolorable;water=bc_block_water_recolorable;metalcrate=bc_metalcrate_recolorable;stone=bc_stone_recolorable;wood=bc_wood_recolorable";
      
      private static var _recolorViews:Dictionary = new Dictionary(true);
      
      private static var _recolorSwatches:Dictionary = new Dictionary(true);
      
      private static var _recolorRecent:Object = {};
      
      private static var _hideRoom:int = -1;
      
      private static var _hideOn:Boolean = false;
      
      private static var _hideBusy:Boolean = false;
      
      private static var _hideToggleAt:int = 0;
      
      private static var _hideChecks:Array = [];
      
      public function HabboTicketLogin()
      {
         super();
      }
      
      public static function dismissMottoKeyboard(event:Object) : void
      {
         if(event != null)
         {
            event.stopImmediatePropagation();
            var input:Object = event.currentTarget;
            if(input != null)
            {
               input["_-0HB"]();
            }
         }
         if(Starling.current != null && Starling.current.nativeStage != null)
         {
            Starling.current.nativeStage.focus = null;
         }
      }
      
      private static function wiredInts(data:Object) : Array
      {
         var size:int = int(data["_-0u0"]());
         if(size < 0 || size > data.bytesAvailable / 4)
         {
            throw new ArgumentError("Invalid Wired integer array length");
         }
         var result:Array = [];
         var i:int = 0;
         while(i < size)
         {
            result.push(data["_-0u0"]());
            i++;
         }
         return result;
      }
      
      private static function wiredStrings(data:Object) : Array
      {
         var size:int = int(data["_-0u0"]());
         if(size < 0 || size > data.bytesAvailable / 2)
         {
            throw new ArgumentError("Invalid Wired string array length");
         }
         var result:Array = [];
         var i:int = 0;
         while(i < size)
         {
            result.push(data["_-nr"]());
            i++;
         }
         return result;
      }
      
      private static function wiredSources(data:Object) : Array
      {
         var size:int = int(data["_-0u0"]());
         if(size < 0 || size > data.bytesAvailable / 4)
         {
            throw new ArgumentError("Invalid Wired source configuration length");
         }
         var result:Array = [];
         var i:int = 0;
         while(i < size)
         {
            result.push(wiredInts(data));
            i++;
         }
         return result;
      }
      
      public static function readWired(data:Object, category:String) : Object
      {
         if(data == null)
         {
            return _pendingWired;
         }
         var info:Object = {};
         info.category = category;
         info.limit = data["_-0u0"]();
         info.ids = wiredInts(data);
         info.ids2 = wiredInts(data);
         info.type = data["_-0u0"]();
         info.id = data["_-0u0"]();
         info.text = data["_-nr"]();
         info.ints = wiredInts(data);
         info.variables = wiredStrings(data);
         info.furniSources = wiredInts(data);
         info.userSources = wiredInts(data);
         info.code = data["_-0u0"]();
         info.delay = 0;
         info.quantifier = 0;
         if(category == "effect")
         {
            info.delay = data["_-0u0"]();
         }
         else if(category == "condition")
         {
            info.quantifier = data["_-0u0"]();
         }
         info.filter = false;
         info.invert = false;
         if(category == "selector")
         {
            info.filter = data.readBoolean();
            info.invert = data.readBoolean();
         }
         info.advanced = data.readBoolean();
         info.allowedFurni = wiredSources(data);
         info.allowedUsers = wiredSources(data);
         info.defaultFurniSources = wiredInts(data);
         info.defaultUserSources = wiredInts(data);
         info.wall = data.readBoolean();
         if(category == "condition")
         {
            info.quantifierType = data.readByte();
            info.inverted = data.readBoolean();
         }
         info.allowSelect = false;
         var group:int = 0;
         while(group < info.allowedFurni.length)
         {
            var sources:Array = info.allowedFurni[group];
            if(sources.indexOf(100) != -1 || sources.indexOf(101) != -1 || sources.indexOf(110) != -1)
            {
               info.allowSelect = true;
            }
            group++;
         }
         info.contextVariables = data.bytesAvailable > 0 ? readWiredContext(data,info) : [];
         info.defaults = data.bytesAvailable > 0 ? wiredInts(data) : [];
         if(data.bytesAvailable != 0)
         {
            throw new ArgumentError("Unexpected Wired definition suffix");
         }
         _wiredById[int(info.id)] = info;
         return info;
      }
      
      public static function wiredDelay(id:int) : int
      {
         var info:Object = _wiredById[id];
         return info == null ? 0 : int(info.delay);
      }
      
      public static function wiredDelayMaximum(id:int) : Number
      {
         return Math.max(10,wiredDelay(id) / 2);
      }
      
      private static function appendWiredList(output:Array, values:Array) : void
      {
         output.push(values.length);
         var i:int = 0;
         while(i < values.length)
         {
            output.push(values[i]);
            i++;
         }
      }
      
      public static function wiredPayload(category:String, original:Array) : Array
      {
         if(original == null || original.length < 4)
         {
            return null;
         }
         var info:Object = _wiredById[int(original[0])];
         if(info == null || info.category != category)
         {
            if(_controller != null)
            {
               _controller.alert(localText("Configuração do Wired"),localText("Reabra este Wired antes de salvar para carregar todas as configurações atuais."));
            }
            return null;
         }
         var cursor:int = 1;
         var count:int = int(original[cursor++]);
         if(count < 0 || cursor + count + 2 > original.length)
         {
            return null;
         }
         var ints:Array = info.ints.slice();
         var i:int = 0;
         while(i < count)
         {
            ints[i] = original[cursor++];
            i++;
         }
         var text:String = String(original[cursor++]);
         count = int(original[cursor++]);
         if(count < 0 || cursor + count > original.length)
         {
            return null;
         }
         var ids:Array = original.slice(cursor,cursor + count);
         cursor += count;
         var output:Array = [int(original[0])];
         appendWiredList(output,ints);
         output.push(text);
         appendWiredList(output,ids);
         if(category == "effect")
         {
            output.push(cursor < original.length ? int(original[cursor]) : int(info.delay));
         }
         else if(category == "condition")
         {
            output.push(int(info.quantifier));
         }
         appendWiredList(output,info.furniSources);
         appendWiredList(output,info.userSources);
         appendWiredList(output,info.variables);
         appendWiredList(output,info.ids2);
         return output;
      }
      
      public static function blockWiredSave(composer:Object) : Boolean
      {
         var type:String = getQualifiedClassName(composer);
         if(type != "_-46v::_-Xg" && type != "_-46v::_-1sF" && type != "_-46v::_-4WL")
         {
            return false;
         }
         return composer["_-0tq"]() == null;
      }
      
      public static function rememberWiredEditor(editor:Object) : void
      {
         _actionPicker = null;
         _actionExtra = null;
         _actionExtraRow = null;
         _formBindings = [];
         endArea();
         removeWiredPanel();
         _modernInfo = null;
         _wiredEditor = editor;
      }
      
      public static function builderLimitPending(catalog:Object) : Boolean
      {
         if(catalog == null || int(catalog["_-317"]) >= 0)
         {
            return false;
         }
         var previous:Object = _builderRefresh[catalog];
         var now:int = getTimer();
         if(previous == null || now - int(previous) >= 1000)
         {
            _builderRefresh[catalog] = now;
            catalog["_-2xK"]();
         }
         if(_controller != null)
         {
            _controller.alert(localText("Clube do Arquiteto"),localText("Atualizando a quantidade de mobis e o seu limite. Aguarde um instante e tente colocar o mobi novamente."));
         }
         return true;
      }
      
      public static function resetCommands() : void
      {
         klass("loginpatch::FloorEditor22").resetAccount();
         klass("loginpatch::AreaHide30").reset();
         klass("loginpatch::RoomIdentity30").reset();
         klass("loginpatch::ClientFixes23").reset();
         if(_antiIdleTimer != null)
         {
            _antiIdleTimer.stop();
         }
         _antiIdle = false;
         _tradeBlocked = false;
         _tradeOpen = false;
         _typingVisible = true;
         _commandContext = null;
         _friendIds = new Dictionary();
         clearFriendHighlights();
         _messenger = null;
         _consoleOwnId = 0;
         _consoleHistories = new Dictionary();
         _consoleViews = new Dictionary(true);
         _consoleLiveIds = new Dictionary();
         _consoleLivePeers = new Dictionary();
         _consoleHistoryIds = new Dictionary();
      }
      
      private static function commandNotice(message:String) : void
      {
         if(_controller != null)
         {
            _controller.alert(localText("Comandos"),message);
         }
      }
      
      private static function commandSession() : Object
      {
         if(_commandContext == null || _commandContext.disposed || _commandContext.roomEngine == null)
         {
            return null;
         }
         return _commandContext["_-4Ej"].getSession(int(_commandContext.roomEngine["_-0Y"]));
      }
      
      private static function commandPacket(type:String, first:Object = null, second:Object = null, count:int = 0) : Object
      {
         var packetClass:Class = getDefinitionByName(type) as Class;
         if(count == 2)
         {
            return new packetClass(first,second);
         }
         if(count == 1)
         {
            return new packetClass(first);
         }
         return new packetClass();
      }
      
      public static function runCommand(text:String, context:Object) : Boolean
      {
         if(text == null)
         {
            return false;
         }
         var value:String = text.replace(/^\s+|\s+$/g,"");
         var split:int = value.indexOf(" ");
         var command:String = (split < 0 ? value : value.substr(0,split)).toLowerCase();
         if(command != ":afk" && command != ":tradeblock" && command != ":typing" && command != ":comandos" && command != ":friendhl" && command != ":floor")
         {
            return false;
         }
         _commandContext = context;
         var session:Object = commandSession();
         if(session == null || session.disposed)
         {
            commandNotice(localText("Entre em um quarto para usar este comando."));
            return true;
         }
         var connection:Object = context.communication.connection;
         switch(command)
         {
            case ":floor":
               openFloorEditor(context);
               break;
            case ":friendhl":
               loadSocialPreferences();
               _friendHighlightEnabled = !_friendHighlightEnabled;
               clearFriendHighlights();
               _lastFriendScan = -1000;
               saveSocialPreferences();
               commandNotice(_friendHighlightEnabled ? localText("Destaque de amigos ativado.") : localText("Destaque de amigos desativado."));
               break;
            case ":afk":
               _antiIdle = !_antiIdle;
               if(_antiIdleTimer == null)
               {
                  _antiIdleTimer = new Timer(60000);
                  _antiIdleTimer.addEventListener(TimerEvent.TIMER,commandAntiIdle);
               }
               if(_antiIdle)
               {
                  _antiIdleTimer.start();
               }
               else
               {
                  _antiIdleTimer.stop();
               }
               commandNotice(_antiIdle ? localText("Anti-inatividade ativada.") : localText("Anti-inatividade desativada."));
               break;
            case ":typing":
               _typingVisible = !_typingVisible;
               if(!_typingVisible)
               {
                  session["_-30L"](false);
               }
               commandNotice(_typingVisible ? localText("Indicador de digitação ativado.") : localText("Indicador de digitação desativado."));
               break;
            case ":tradeblock":
               _tradeBlocked = !_tradeBlocked;
               if(_tradeBlocked && _tradeOpen)
               {
                  connection.send(commandPacket("_-LI::_-28E"));
               }
               commandNotice(_tradeBlocked ? localText("Trocas bloqueadas.") : localText("Trocas liberadas."));
               break;
            case ":comandos":
               commandNotice(":afk — alterna anti-inatividade\n:tradeblock — alterna bloqueio de trocas\n:typing — alterna o indicador de digitação\n:friendhl — alterna o destaque de amigos no quarto" + "\n" + String(klass("loginpatch::FloorStrings22").getText(_hotelLanguage,"floor22.help")));
         }
         return true;
      }
      
      public static function commandAntiIdle(event:TimerEvent) : void
      {
         if(!_antiIdle)
         {
            return;
         }
         var session:Object = commandSession();
         if(session != null && !session.disposed && session.state == "RSE_STARTED")
         {
            session["_-2uA"](0);
         }
      }
      
      public static function blockTyping(composer:Object) : Boolean
      {
         return !_typingVisible && getQualifiedClassName(composer) == "_-1pz::_-dy";
      }
      
      public static function blockTrade(communication:Object) : Boolean
      {
         _tradeOpen = true;
         if(!_tradeBlocked)
         {
            return false;
         }
         communication.connection.send(commandPacket("_-LI::_-28E"));
         return true;
      }
      
      public static function commandTradeState(event:Object) : void
      {
         var type:String = getQualifiedClassName(event);
         if(type == "_-2bf::_-3dE" || type == "_-2bf::_-4Zw" || type == "_-2bf::_-3Cv")
         {
            _tradeOpen = false;
         }
      }
      
      public static function readConsoleTail(parser:Object, data:Object, messageId:String = "") : void
      {
         _consoleMetadata[parser] = null;
         if(data.bytesAvailable == 0)
         {
            return;
         }
         var confirmation:int = int(data["_-0u0"]());
         var sender:int = int(data["_-0u0"]());
         data["_-nr"]();
         data["_-nr"]();
         _consoleMetadata[parser] = {
            "confirmation":confirmation,
            "sender":sender,
            "messageId":messageId
         };
         if(messageId != null && messageId != "")
         {
            _consoleLiveIds[messageId] = true;
            _consoleLivePeers[messageId] = int(parser["_-0UP"]);
         }
      }
      
      public static function isOwnConsoleMessage(parser:Object, session:Object) : Boolean
      {
         var info:Object = _consoleMetadata[parser];
         if(info == null)
         {
            return false;
         }
         if(info.messageId != null && _consoleHistoryIds[info.messageId] === true)
         {
            return true;
         }
         if(int(info.confirmation) > 0)
         {
            return true;
         }
         var ownId:int = session == null ? 0 : int(session.userId);
         return ownId > 0 && int(info.sender) == ownId;
      }
      
      public static function rememberSilverOffer(id:int, silver:int) : void
      {
         if(id > 0)
         {
            _silverOffers[id] = silver;
         }
      }
      
      public static function currentPayload(kind:String, original:Array) : Array
      {
         switch(kind)
         {
            case "catalog-index":
               return original.slice(0,1);
            case "builder-placement":
               return original.concat([false]);
            case "private-chat":
               var confirmation:int = int(_consoleConfirmations[original]);
               if(confirmation <= 0)
               {
                  if(_nextConsoleConfirmation >= 2147483647)
                  {
                     _nextConsoleConfirmation = 1;
                  }
                  confirmation = _nextConsoleConfirmation++;
                  _consoleConfirmations[original] = confirmation;
               }
               return original.concat([confirmation]);
            default:
               throw new ArgumentError("Unknown compatibility payload");
         }
      }
      
      public static function blockUnsupportedPurchase(composer:Object) : Boolean
      {
         var type:String = getQualifiedClassName(composer);
         if(type != "_-1Dj::_-ZX" && type != "_-1Dj::_-1hg")
         {
            return false;
         }
         var payload:Array = composer["_-0tq"]();
         if(payload == null || payload.length < 2 || int(_silverOffers[int(payload[1])]) <= 0)
         {
            return false;
         }
         if(_controller != null)
         {
            _controller.alert("Oferta com prata","Esta oferta usa prata, uma moeda que esta versão antiga não exibe. Use o cliente atual para conferir o preço e comprar.");
         }
         return true;
      }
      
      public static function rememberUser(id:int, name:String) : void
      {
         if(id <= 0 || name == null || name.length == 0)
         {
            return;
         }
         var key:String = name.toLowerCase();
         var previous:String = _userNames[id] as String;
         if(previous != null && previous.toLowerCase() != key && int(_userIds[previous.toLowerCase()]) == id)
         {
            delete _userIds[previous.toLowerCase()];
         }
         _userNames[id] = name;
         _userIds[key] = id;
      }
      
      public static function rememberRoomUsers(users:Array) : void
      {
         for each(var user:Object in users)
         {
            if(int(user["_-3uE"]) == 1)
            {
               rememberUser(int(user["_-1GP"]),String(user.name));
            }
         }
      }
      
      public static function userIdForName(name:String) : int
      {
         return name == null ? 0 : int(_userIds[name.toLowerCase()]);
      }
      
      public static function userNameForId(id:int) : String
      {
         var name:String = _userNames[id] as String;
         return name == null ? "" : name;
      }
      
      public static function blockUnknownIdentity(name:String) : Boolean
      {
         if(userIdForName(name) > 0)
         {
            return false;
         }
         if(_controller != null)
         {
            _controller.alert("Usuário indisponível","Aguarde os dados desse usuário e tente novamente.");
         }
         return true;
      }
      
      public static function ignorePayload(composer:Object, original:Array) : Array
      {
         var id:int = int(_forcedIgnoreIds[composer]);
         if(id <= 0 && original != null && original.length > 0)
         {
            id = userIdForName(String(original[0]));
         }
         return id > 0 ? [id] : [];
      }
      
      public static function ignoreById(session:Object, id:int, composerClass:Class) : void
      {
         if(id <= 0 || session == null)
         {
            return;
         }
         var composer:Object = new composerClass("");
         _forcedIgnoreIds[composer] = id;
         session.send(composer);
      }
      
      public static function isIgnoredName(name:String, ignored:Array) : Boolean
      {
         var id:int = userIdForName(name);
         return id > 0 && ignored.indexOf(id) >= 0;
      }
      
      public static function noteIgnoredList(ignored:Array) : void
      {
         _ignoredCount = ignored.length;
      }
      
      public static function receiveIgnoreResult(ignored:Array, result:int, id:int) : void
      {
         if(id <= 0)
         {
            return;
         }
         var index:int = ignored.indexOf(id);
         if(result == 1 || result == 2)
         {
            if(index < 0)
            {
               ignored.push(id);
            }
            if(result == 2)
            {
               ignored.shift();
            }
         }
         else if(result == 3 && index >= 0)
         {
            ignored.splice(index,1);
         }
         _ignoredCount = ignored.length;
      }
      
      public static function coreError(event:Object) : void
      {
         var source:Array;
         var failure:Object;
         var stack:String;
         var lines:Array;
         var i:int;
         var frame:Array;
         if(!_ssoSession || !Boolean(event["_-aV"]) || _coreCategory != -999)
         {
            return;
         }
         _coreCategory = int(event.category);
         _coreHeader = _received.length == 0 ? -1 : int(_received[_received.length - 1]);
         try
         {
            source = String(event.message).match(/[A-Za-z_$][A-Za-z0-9_.$-]*::[A-Za-z_$][A-Za-z0-9_$-]*/g);
            if(source != null && source.length > 0)
            {
               _coreSource = String(source[source.length - 1]);
            }
            failure = event.error;
            if(failure != null)
            {
               _coreErrorId = int(failure.errorID);
               if(_coreSource.length == 0)
               {
                  _coreSource = getQualifiedClassName(failure);
               }
               stack = failure.getStackTrace();
               if(stack != null)
               {
                  lines = stack.split("\n");
                  i = 1;
                  while(i < lines.length && _coreFrames.length < 2)
                  {
                     frame = String(lines[i]).match(/at\s+([A-Za-z0-9_.$:\/-]+)/);
                     if(frame != null)
                     {
                        _coreFrames.push(String(frame[1]).substr(0,90));
                     }
                     i++;
                  }
               }
            }
         }
         catch(recordingError:Error)
         {
         }
      }
      
      private static function coreDiagnostic() : String
      {
         if(_coreCategory == -999)
         {
            return "";
         }
         return "\nFalha interna: categoria " + _coreCategory + ", erro " + _coreErrorId + ", mensagem " + _coreHeader + ".\nOrigem: " + _coreSource + (_coreFrames.length == 0 ? "" : "\n" + _coreFrames.join("; "));
      }
      
      public static function phase(value:String) : void
      {
         var names:Object = {
            "HABBO_CONNECTION_EVENT_ESTABLISHED":"servidor conectado",
            "HABBO_CONNECTION_EVENT_HANDSHAKING":"negociação de conexão",
            "HABBO_CONNECTION_EVENT_HANDSHAKED":"conexão criptografada",
            "HABBO_CONNECTION_EVENT_AUTHENTICATED":"login aceito",
            "HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL":"conexão encerrada durante a negociação"
         };
         if(names[value] != null)
         {
            _stage = names[value];
         }
         if(value == "HABBO_CONNECTION_EVENT_AUTHENTICATED")
         {
            _authenticated = true;
            stopTimer();
         }
      }
      
      public static function sent(id:int) : void
      {
         _sent.push(id);
         if(_sent.length > 8)
         {
            _sent.shift();
         }
      }
      
      public static function received(id:int) : void
      {
         _received.push(id);
         if(_received.length > 8)
         {
            _received.shift();
         }
      }
      
      private static function stopTimer() : void
      {
         if(_timer != null)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",onTimeout);
            _timer = null;
         }
      }
      
      private static function diagnostic() : String
      {
         return "Autenticação: " + (_authenticated ? "aceita" : "não confirmada") + ".\nEtapa: " + _stage + ".\n" + (_disconnectReason == -999 ? "" : "Motivo de desconexão: " + _disconnectReason + ".\n") + "Enviadas: " + _sent.join(", ") + ".\nRecebidas: " + _received.join(", ") + ".\nIgnorados carregados: " + _ignoredCount + "." + coreDiagnostic();
      }
      
      public static function ignoreLegacyResponse(path:String) : Boolean
      {
         if(!_ssoSession)
         {
            return false;
         }
         switch(path)
         {
            case "/api/public/info/hello":
            case "/api/public/authentication/login":
            case "/api/public/authentication/facebook":
            case "/api/public/authentication/apple":
            case "/api/ssotoken":
            case "/api/user/avatars":
            case "/api/user/avatars/select":
               ++_legacyCallbacks;
               return true;
            default:
               return false;
         }
      }
      
      private static function showQueuedFailure(attempt:int, message:String) : void
      {
         if(attempt == _attempt && _controller != null)
         {
            if(_disconnectReason == -3 && _coreErrorId == 0)
            {
               showOffline32(_controller);
               return;
            }
            _controller.alert("Falha ao concluir a conexão",message + "\n" + diagnostic());
         }
      }
      
      private static function queueFailure(controller:Object, message:String) : void
      {
         stopTimer();
         if(_failureQueued)
         {
            return;
         }
         _failureQueued = true;
         _controller = controller;
         setTimeout(showQueuedFailure,800,_attempt,message);
      }
      
      public static function connectionClosed(controller:Object, reason:int) : void
      {
         resetCommands();
         _disconnectReason = reason;
         if(_ssoSession && reason != 0)
         {
            queueFailure(controller,"A conexão foi encerrada. Motivo: " + reason + ".");
         }
      }
      
      public static function clearOffline32() : void
      {
         if(_offline32 == null)
         {
            return;
         }
         var root:Object = _offline32.root;
         _offline32 = null;
         Starling.current.stage.removeEventListener("resize",layoutOffline32);
         root.removeFromParent(true);
      }
      
      private static function offlineIcon32() : Object
      {
         var S:Class = klass("starling.display::Sprite");
         var Q:Class = klass("starling.display::Quad");
         var icon:Object = new S();
         var ring:int = 0;
         while(ring < 3)
         {
            var radius:Number = 15 + 14 * ring;
            var i:int = 0;
            while(i < 14)
            {
               var a:Number = (-145 + i * 110 / 14) * Math.PI / 180;
               var b:Number = (-145 + (i + 1) * 110 / 14) * Math.PI / 180;
               var x:Number = 50 + Math.cos(a) * radius;
               var y:Number = 70 + Math.sin(a) * radius;
               var dx:Number = (Math.cos(b) - Math.cos(a)) * radius;
               var dy:Number = (Math.sin(b) - Math.sin(a)) * radius;
               var line:Object = new Q(Math.sqrt(dx * dx + dy * dy) + 1,4,7720959);
               line.x = x;
               line.y = y;
               line.rotation = Math.atan2(dy,dx);
               line.touchable = false;
               icon.addChild(line);
               i++;
            }
            ring++;
         }
         var slash:Object = new Q(72,5,15895426);
         slash.x = 23;
         slash.y = 17;
         slash.rotation = Math.PI / 4;
         slash.touchable = false;
         icon.addChild(slash);
         icon.touchable = false;
         return icon;
      }
      
      public static function showOffline32(controller:Object) : void
      {
         clearOffline32();
         var root:Object = uiGroup(1,1,857887);
         root.name = "offlineScreen32";
         var card:Object = uiGroup(1,1,1517619);
         root.addChild(card);
         var title:Object = uiText("Sem acesso à internet",34,16777215,true);
         var text:Object = uiText("A conexão foi interrompida. Verifique o Wi-Fi ou os dados móveis e entre novamente quando a internet voltar.",20,12570070);
         text.wordWrap = true;
         card.addChild(title);
         card.addChild(text);
         var badge:Object = offlineIcon32();
         card.addChild(badge);
         var action:Object = button(localText("Voltar para o login"),offlineBack32);
         card.addChild(action);
         _offline32 = {
            "root":root,
            "card":card,
            "title":title,
            "text":text,
            "badge":badge,
            "action":action,
            "controller":controller
         };
         Starling.current.stage.addChild(root);
         Starling.current.stage.addEventListener("resize",layoutOffline32);
         layoutOffline32(null);
      }
      
      public static function layoutOffline32(event:Object) : void
      {
         if(_offline32 == null)
         {
            return;
         }
         var s:Object = _offline32;
         var w:Number = Starling.current.stage.stageWidth;
         var h:Number = Starling.current.stage.stageHeight;
         var u:Number = uiUnit();
         s.root.width = w;
         s.root.height = h;
         s.root.backgroundSkin.width = w;
         s.root.backgroundSkin.height = h;
         var c:Object = s.card;
         c.width = Math.min(w - 40 * u,760 * u);
         c.height = Math.min(h - 40 * u,390 * u);
         c.x = (w - c.width) / 2;
         c.y = (h - c.height) / 2;
         c.backgroundSkin.width = c.width;
         c.backgroundSkin.height = c.height;
         var inner:Number = c.width - 64 * u;
         s.badge.x = c.width / 2 - 50 * u;
         s.badge.y = 14 * u;
         s.badge.scaleX = u;
         s.badge.scaleY = u;
         s.title.x = 32 * u;
         s.title.y = 106 * u;
         s.title.width = inner;
         s.title.wordWrap = true;
         s.title.height = 80 * u;
         s.title.textRendererProperties.textFormat.align = "center";
         s.text.x = 32 * u;
         s.text.y = 188 * u;
         s.text.width = inner;
         s.text.height = 90 * u;
         s.text.textRendererProperties.textFormat.align = "center";
         s.action.validate();
         s.action.x = 32 * u;
         s.action.y = c.height - 82 * u;
         s.action.width = inner;
         s.action.height = 56 * u;
      }
      
      public static function offlineBack32(event:Object) : void
      {
         if(_offline32 == null)
         {
            return;
         }
         var controller:Object = _offline32.controller;
         clearOffline32();
         _failureQueued = false;
         if(controller != null)
         {
            controller.handleLoginFailedShowDefaultView();
         }
      }
      
      public static function handleLegacyLoginError(controller:Object) : Boolean
      {
         if(!_ssoSession)
         {
            return false;
         }
         if(_authenticated)
         {
            ++_legacyCallbacks;
            return true;
         }
         queueFailure(controller,"O aplicativo voltou ao fluxo antigo de login.");
         return true;
      }
      
      public static function handleGenericError(controller:Object, code:int) : Boolean
      {
         if(!_ssoSession || code != -3 && code != -400)
         {
            return false;
         }
         queueFailure(controller,"O servidor retornou o erro " + code + ".");
         return true;
      }
      
      private static function onTimeout(event:TimerEvent) : void
      {
         var controller:Object = _controller;
         stopTimer();
         if(controller != null)
         {
            controller.alert("Conexão não concluída","O login ainda não foi concluído.\n" + diagnostic());
         }
      }
      
      public static function runtimeVersion() : String
      {
         return Capabilities.version.split(" ").join("/");
      }
      
      public static function serverError(controller:Object, errorCode:int, messageId:int) : void
      {
         queueFailure(controller,"Erro " + errorCode + ". Mensagem do servidor: " + messageId + ".");
      }
      
      public static function configure(input:Object, password:Object, remember:Object, loginButton:Object, websiteButton:Object, title:Object, instructions:Object, controller:Object) : void
      {
         title.text = localText("Entrar com código");
         instructions.text = "Copie o código do Launcher no site oficial do Habbo. Depois, volte e toque em Colar código e entrar.";
         instructions.wordWrap = true;
         input.text = "";
         input.prompt = "Cole aqui o código de login do site Habbo";
         input.displayAsPassword = true;
         input.maxChars = 8192;
         input.visible = false;
         input.includeInLayout = false;
         password.text = "";
         password.visible = false;
         password.includeInLayout = false;
         remember.isSelected = false;
         remember.parent.visible = false;
         remember.parent.includeInLayout = false;
         loginButton.label = localText("Colar código e entrar");
         websiteButton.label = localText("Abrir site oficial do Habbo");
         websiteButton.defaultIcon = null;
         websiteButton.isEnabled = true;
         var cancel:Object = loginButton.parent.getChildAt(0);
         if(cancel != loginButton)
         {
            cancel.visible = false;
            cancel.includeInLayout = false;
         }
         var container:Object = input.parent;
         var i:int = container.getChildIndex(websiteButton) + 1;
         while(i < container.numChildren)
         {
            var child:Object = container.getChildAt(i);
            child.visible = false;
            child.includeInLayout = false;
            i++;
         }
         controller.forgetUserLoginCredentials();
         controller.loginName = "";
         controller.password = "";
         controller["_-1FS"] = false;
      }
      
      public static function openWebsite(controller:Object) : void
      {
         var hosts:Object = {
            "pt":"www.habbo.com.br",
            "en":"www.habbo.com",
            "fi":"www.habbo.fi",
            "fr":"www.habbo.fr",
            "de":"www.habbo.de",
            "nl":"www.habbo.nl",
            "es":"www.habbo.es",
            "it":"www.habbo.it",
            "tr":"www.habbo.com.tr"
         };
         var host:String = hosts[controller.getProperty("environment.id")];
         if(host == null)
         {
            host = "www.habbo.com.br";
         }
         navigateToURL(new URLRequest("https://" + host + "/settings/avatars"));
      }
      
      public static function login(controller:Object, input:Object) : void
      {
         var raw:String;
         var copied:Object;
         var parts:Array;
         var hotels:Object;
         var hotel:String;
         var authenticationPart:String;
         var ticket:String;
         clearOffline32();
         raw = String(input.text);
         if(raw.replace(/^\s+|\s+$/g,"").length == 0)
         {
            copied = null;
            try
            {
               copied = Clipboard.generalClipboard.getData("air:text");
            }
            catch(error:Error)
            {
               controller.alert(localText("Login por código"),localText("Não foi possível ler a área de transferência. Copie novamente o código do Launcher e toque em Colar código e entrar."));
               return;
            }
            if(copied == null)
            {
               controller.alert(localText("Login por código"),localText("Copie o código do Launcher no site oficial do Habbo e volte para continuar."));
               return;
            }
            raw = String(copied);
         }
         raw = raw.replace(/^\s+|\s+$/g,"");
         parts = raw.split(".");
         hotels = {
            "hhbr":"pt",
            "hhus":"en",
            "hhfi":"fi",
            "hhfr":"fr",
            "hhde":"de",
            "hhnl":"nl",
            "hhes":"es",
            "hhit":"it",
            "hhtr":"tr"
         };
         hotel = hotels[String(parts[0]).toLowerCase()];
         authenticationPart = String(parts[0]) + "." + String(parts[1]) + "." + String(parts[2]);
         if(parts.length < 3 || hotel == null || String(parts[1]).length == 0 || String(parts[2]).length == 0 || raw.length > 8192 || /\s/.test(authenticationPart))
         {
            controller.alert(localText("Código inválido"),localText("Use o código do Launcher copiado no site Habbo. No hotel brasileiro ele começa com hhbr. Não use sua senha nem o código recebido por e-mail."));
            return;
         }
         if(hotel != controller.getProperty("environment.id"))
         {
            controller.alert(localText("Hotel diferente"),localText("Esse código pertence a outro hotel. Volte, selecione o mesmo hotel do site e cole o código novamente."));
            return;
         }
         ticket = String(parts[1]) + "." + String(parts[2]);
         input.text = "";
         stopTimer();
         ++_attempt;
         _ssoSession = true;
         _authenticated = false;
         _failureQueued = false;
         _legacyCallbacks = 0;
         _disconnectReason = -999;
         _userIds = new Dictionary();
         _userNames = new Dictionary();
         _forcedIgnoreIds = new Dictionary(true);
         _ignoredCount = -1;
         _silverOffers = new Dictionary();
         _consoleMetadata = new Dictionary(true);
         _consoleConfirmations = new Dictionary(true);
         _nextConsoleConfirmation = 1;
         endRoomEditors();
         resetAccountState();
         _wiredById = new Dictionary();
         _wiredEditor = null;
         _modernInfo = null;
         _modernService = null;
         _modernControl = null;
         _roomVariables = [];
         _formBindings = [];
         _activeConnection = null;
         _variableRoom = -1;
         _builderRefresh = new Dictionary(true);
         resetCommands();
         _coreCategory = -999;
         _coreErrorId = 0;
         _coreHeader = -1;
         _coreSource = "";
         _coreFrames = [];
         _stage = "conectando ao servidor";
         _sent = [];
         _received = [];
         _controller = controller;
         controller.forgetUserLoginCredentials();
         controller.loginName = "";
         controller.password = "";
         controller["_-1FS"] = false;
         controller["_-1nL"] = "habbo";
         controller.communication["_-1vv"]();
         _timer = new Timer(30000,1);
         _timer.addEventListener("timerComplete",onTimeout);
         _timer.start();
         controller["_-zP"](ticket,"");
      }
      
      private static function klass(name:String) : Class
      {
         return getDefinitionByName(name) as Class;
      }
      
      private static function label(text:String) : Object
      {
         var L:Class = klass("_-2xS::_-Fk");
         var l:Object = new L();
         l.styleNameList.add("LABEL_M_CONDENSED_LIGHT_GRAY");
         l.text = localText(text);
         l.wordWrap = true;
         l.maxWidth = Math.min(500,Starling.current.stage.stageWidth * 0.31);
         return l;
      }
      
      private static function button(text:String, callback:Function) : Object
      {
         var B:Class = klass("_-2xS::Button");
         var b:Object = new B();
         b.label = localText(text);
         b.styleNameList.add("alternate-blue-button");
         b.addEventListener("triggered",callback);
         return b;
      }
      
      public static function selectHotelLanguage(controller:Object, language:String) : void
      {
         var supported:Array = ["pt","en","de","fr","es","it","nl","fi","tr"];
         _hotelLanguage = supported.indexOf(language) >= 0 ? language : "en";
         _uiLocalization = controller == null ? null : controller.localization;
         var L:Class = klass("loginpatch::LocaleData21");
         _localeUi = L.ui(_hotelLanguage);
         _localeEnglish = L.ui("en");
         _localeWired = L.wired(_hotelLanguage);
         for(var screen:Object in _tokenScreens)
         {
            layoutTokenLogin(screen);
         }
      }
      
      public static function localText(text:String) : String
      {
         if(text == null || _hotelLanguage == "pt")
         {
            return text;
         }
         if(_localeUi == null)
         {
            var L:Class = klass("loginpatch::LocaleData21");
            _localeUi = L.ui(_hotelLanguage);
            _localeEnglish = L.ui("en");
         }
         if(_localeUi[text] != null)
         {
            return String(_localeUi[text]);
         }
         if(_localeEnglish[text] != null)
         {
            return String(_localeEnglish[text]);
         }
         var number:Object = /^(Opção |Variável |Placa |Dança )(\d+)$/.exec(text);
         if(number != null)
         {
            return localText(String(number[1])) + String(number[2]);
         }
         return text;
      }
      
      private static function tr(key:String, fallback:String = "") : String
      {
         if(key == null)
         {
            return localText(fallback == null ? "" : fallback);
         }
         if(key.indexOf("${") == 0)
         {
            key = key.substring(2,key.length - 1);
         }
         if(_hotelLanguage != "pt" && _localeWired != null && _localeWired[key] != null)
         {
            return String(_localeWired[key]);
         }
         if(_hotelLanguage == "pt" && _wiredLabels[key] != null)
         {
            return String(_wiredLabels[key]);
         }
         var result:String = "";
         var localization:Object = _uiLocalization;
         if(localization == null && _modernService != null)
         {
            localization = _modernService.localization;
         }
         if(localization != null)
         {
            result = localization.getLocalization(key,"");
         }
         var i:int = 0;
         while(i < 8 && result != null && result.indexOf("${") == 0 && result.charAt(result.length - 1) == "}")
         {
            var alias:String = result.substring(2,result.length - 1);
            result = localization == null ? "" : localization.getLocalization(alias,"");
            i++;
         }
         if(result != null && result != "" && result != key && result.indexOf("${") != 0)
         {
            return result;
         }
         return localText(fallback == null || fallback == "" ? key : fallback);
      }
      
      private static function column(gap:Number = 12) : Object
      {
         var U:Class = klass("_-2YJ::_-0iF");
         return U["_-3zA"](gap);
      }
      
      private static function addLabel(parent:Object, text:String) : Object
      {
         var l:Object = label(text);
         parent.addChild(l);
         return l;
      }
      
      private static function makeNumber(parent:Object, caption:String, initial:Number, min:Number, max:Number, step:Number = 1) : Object
      {
         var row:Object = column(4);
         parent.addChild(row);
         addLabel(row,caption);
         var N:Class = klass("_-2xS::_-1Gh");
         var n:Object = new N();
         n.minimum = Math.min(min,initial);
         n.maximum = Math.max(max,initial);
         n.step = step;
         n.value = initial;
         row.addChild(n);
         return n;
      }
      
      private static function makeText(parent:Object, caption:String, initial:String) : Object
      {
         var row:Object = column(4);
         parent.addChild(row);
         addLabel(row,caption);
         var T:Class = klass("_-2xS::_-1XI");
         var t:Object = new T();
         t.text = initial;
         t.width = Math.max(220,Starling.current.stage.stageWidth * 0.3);
         t.addEventListener("enter",dismissMottoKeyboard);
         row.addChild(t);
         return t;
      }
      
      private static function chatBitmap(name:String) : Object
      {
         if(name == null)
         {
            return null;
         }
         if(_chatBitmaps[name] != null)
         {
            return _chatBitmaps[name];
         }
         if(_chatAtlas == null)
         {
            var Atlas:Class = klass("loginpatch::ChatAtlas");
            _chatAtlas = new Atlas();
         }
         var frame:Array = _chatCatalogue.images[name];
         if(frame == null)
         {
            return null;
         }
         var B:Class = klass("flash.display::BitmapData");
         var R:Class = klass("flash.geom::Rectangle");
         var P:Class = klass("flash.geom::Point");
         var image:Object = new B(int(frame[2]),int(frame[3]),true,0);
         image.copyPixels(_chatAtlas.bitmapData,new R(frame[0],frame[1],frame[2],frame[3]),new P(0,0));
         _chatBitmaps[name] = image;
         return image;
      }
      
      private static function chatRect(values:Array, scale:Number = 1) : Object
      {
         if(values == null)
         {
            return null;
         }
         var R:Class = klass("flash.geom::Rectangle");
         return new R(values[0] * scale,values[1] * scale,values[2] * scale,values[3] * scale);
      }
      
      private static function chatPoint(values:Array, scale:Number = 1) : Object
      {
         if(values == null)
         {
            return null;
         }
         var P:Class = klass("flash.geom::Point");
         return new P(values[0] * scale,values[1] * scale);
      }
      
      public static function extendChatStyles(styles:Object) : void
      {
         var C:Class = klass("_-0gh::_-1P8");
         var D:Class = klass("_-1N-::_-2mJ");
         var F:Class = klass("flash.text::TextFormat");
         var scale:Number = Number(D["_-0-S"]());
         var profile:int = int(D["_-17Z"]());
         for each(var data:Object in _chatCatalogue.styles)
         {
            if(styles.getValue(int(data.id)) == null)
            {
               var size:Number = Number(data.size) * scale * (profile == 0 ? 2 : (profile == 1 ? 1.2 : 1));
               var format:Object = new F("Ubuntu",size,uint(data.color));
               var style:Object = new C(int(data.id),String(data.name),chatBitmap(data.base),chatRect(data.rect),chatBitmap(data.tail),int(data.pointer) * scale,chatRect(data.margins,scale),format,Boolean(data.anonymous),chatBitmap(data.icon),chatPoint(data.face,scale),chatBitmap(data.preview),Boolean(data.system) || Boolean(data.incomingOnly),Boolean(data.hc),Boolean(data.ambassador),Boolean(data.staff),chatBitmap(data.tint),chatPoint(data.colorXY,scale),chatRect(data.overlap,scale),Boolean(data.html));
               styles.add(int(data.id),style);
            }
         }
      }
      
      public static function notificationChat(style:int) : Boolean
      {
         for each(var data:Object in _chatCatalogue.styles)
         {
            if(int(data.id) == style)
            {
               return Boolean(data.notification);
            }
         }
         return false;
      }
      
      private static function chatRun(text:String, bold:int, italic:int, underline:int, color:String) : String
      {
         if(text == "")
         {
            return "";
         }
         var face:String = bold > 0 ? (italic > 0 ? "UbuntuBoldItalic" : "UbuntuBold") : (italic > 0 ? "UbuntuItalic" : "Ubuntu");
         text = "<font face=\"" + face + "\"" + (color == null ? "" : " color=\"#" + color + "\"") + ">" + text + "</font>";
         if(underline > 0)
         {
            text = "<u>" + text + "</u>";
         }
         if(italic > 0)
         {
            text = "<i>" + text + "</i>";
         }
         if(bold > 0)
         {
            text = "<b>" + text + "</b>";
         }
         return text;
      }
      
      private static function chatMarkup(text:String) : String
      {
         text = text.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
         text = text.replace(/\r\n/g,"\n").replace(/\r/g,"\n").replace(/\n/g,"<br/>");
         var rgb:Object = {
            "red":"FF0000",
            "green":"008000",
            "blue":"0000FF",
            "purple":"800080",
            "cyan":"00BFFF",
            "yellow":"FFFF00",
            "orange":"FF9900",
            "white":"FFFFFF",
            "black":"000000",
            "gray":"777777",
            "grey":"777777"
         };
         var bold:int = 0;
         var italic:int = 0;
         var underline:int = 0;
         var colors:Array = [];
         var out:String = "";
         var cursor:int = 0;
         var color:String = null;
         while(cursor < text.length)
         {
            var open:int = text.indexOf("[",cursor);
            var end:int = open < 0 ? -1 : text.indexOf("]",open + 1);
            if(open < 0 || end < 0)
            {
               out += chatRun(text.substring(cursor),bold,italic,underline,color);
               break;
            }
            out += chatRun(text.substring(cursor,open),bold,italic,underline,color);
            var token:String = text.substring(open + 1,end).toLowerCase();
            var close:Boolean = token.charAt(0) == "/";
            if(close)
            {
               token = token.substring(1);
            }
            var known:Boolean = true;
            if(token == "b")
            {
               bold = Math.max(0,bold + (close ? -1 : 1));
            }
            else if(token == "i")
            {
               italic = Math.max(0,italic + (close ? -1 : 1));
            }
            else if(token == "u")
            {
               underline = Math.max(0,underline + (close ? -1 : 1));
            }
            else if(rgb[token] != null)
            {
               if(!close)
               {
                  colors.push({
                     "tag":token,
                     "color":rgb[token]
                  });
               }
               else if(colors.length > 0 && colors[colors.length - 1].tag == token)
               {
                  colors.pop();
               }
               else
               {
                  known = false;
               }
               color = colors.length > 0 ? String(colors[colors.length - 1].color) : null;
            }
            else
            {
               known = false;
            }
            if(!known)
            {
               out += chatRun(text.substring(open,end + 1),bold,italic,underline,color);
            }
            cursor = end + 1;
         }
         return out;
      }
      
      public static function formatRoomBubble(renderer:Object, style:Object, item:Object) : void
      {
         var type:int = int(item["_-11J"]);
         var whisper:Boolean = type == 1;
         var shout:Boolean = type == 2;
         var original:Object = style.textFormat;
         var F:Class = klass("flash.text::TextFormat");
         var format:Object = new F(whisper ? "UbuntuItalic" : (shout ? "UbuntuBold" : "Ubuntu"),original.size,whisper ? 7829367 : original.color,shout,whisper);
         format.kerning = original.kerning;
         format.leading = original.leading;
         renderer.textFormat = format;
         if(notificationChat(int(item.style)))
         {
            renderer.text = chatMarkup(String(renderer.text));
            renderer.isHTML = true;
         }
      }
      
      public static function renderNotification(renderer:Object, style:Object, item:Object) : void
      {
         renderer.text = String(item.text);
         renderer.touchable = false;
         formatRoomBubble(renderer,style,item);
      }
      
      public static function initConsoleHistoryProtocol(header:int) : void
      {
         _consoleHistoryHeader = header;
      }
      
      public static function rememberMessenger(messenger:Object, userId:int) : void
      {
         _messenger = messenger;
         _consoleOwnId = userId;
         _consoleHistories = new Dictionary();
         _consoleViews = new Dictionary(true);
      }
      
      public static function consoleOpened(messenger:Object, conversation:Object, list:Object) : void
      {
         if(conversation == null || list == null)
         {
            return;
         }
         _messenger = messenger;
         var peer:int = int(conversation["_-3aV"]);
         if(peer <= 0)
         {
            return;
         }
         var state:Object = _consoleHistories[peer];
         if(state != null && state.conversation !== conversation)
         {
            consoleConversationRemoved(peer);
            state = null;
         }
         if(state == null)
         {
            state = {
               "conversation":conversation,
               "list":list,
               "ids":[],
               "cursor":"",
               "requested":"",
               "pending":false,
               "loaded":false,
               "more":true,
               "last":-5000
            };
            _consoleHistories[peer] = state;
         }
         state.conversation = conversation;
         state.list = list;
         _consoleViews[list] = state;
         list.removeEventListener("scroll",consoleHistoryScrolled);
         list.addEventListener("scroll",consoleHistoryScrolled);
         if(!state.loaded)
         {
            requestConsoleHistory(peer,state);
         }
      }
      
      public static function consoleConversationRemoved(peer:int) : void
      {
         var state:Object = _consoleHistories[peer];
         if(state != null)
         {
            for each(var oldId:String in state.ids)
            {
               delete _consoleHistoryIds[oldId];
            }
            if(_consoleViews[state.list] === state)
            {
               delete _consoleViews[state.list];
            }
         }
         var stale:Array = [];
         for(var liveId:Object in _consoleLivePeers)
         {
            if(int(_consoleLivePeers[liveId]) == peer)
            {
               stale.push(liveId);
            }
         }
         for each(liveId in stale)
         {
            delete _consoleLiveIds[liveId];
            delete _consoleLivePeers[liveId];
         }
         delete _consoleHistories[peer];
      }
      
      public static function consoleHistoryScrolled(event:Object) : void
      {
         if(_insertingConsoleHistory)
         {
            return;
         }
         var list:Object = event.currentTarget;
         var state:Object = _consoleViews[list];
         if(state == null || !state.loaded || !state.more || state.pending || list.verticalScrollPosition > 12)
         {
            return;
         }
         requestConsoleHistory(int(state.conversation["_-3aV"]),state);
      }
      
      private static function requestConsoleHistory(peer:int, state:Object) : void
      {
         if(_messenger == null || _messenger.disposed || state.pending || !state.more)
         {
            return;
         }
         var now:int = getTimer();
         if(now - int(state.last) < 4000)
         {
            return;
         }
         var C:Class = klass("loginpatch::ConsoleHistoryPayload");
         state.requested = String(state.cursor);
         state.last = now;
         state.pending = true;
         _messenger.send(new C(peer,String(state.cursor)));
         setTimeout(consoleHistoryTimeout,10000,peer,state);
      }
      
      public static function consoleHistoryTimeout(peer:int, state:Object) : void
      {
         if(_consoleHistories[peer] === state && getTimer() - int(state.last) >= 9900)
         {
            state.pending = false;
         }
      }
      
      public static function insertingConsoleHistory() : Boolean
      {
         return _insertingConsoleHistory;
      }
      
      private static function receiveConsoleHistory(data:Object) : void
      {
         var entries:Array;
         var i:int;
         var sender:int;
         var state:Object;
         var first:Boolean;
         var oldest:String;
         var messages:Array;
         var C:Class;
         var entry:Object;
         var id:String;
         var collection:Object;
         var list:Object;
         var active:Boolean;
         var oldMax:Number;
         var oldPosition:Number;
         var peer:int = int(data["_-0u0"]());
         var count:int = int(data["_-0u0"]());
         if(count < 0 || count > 5000)
         {
            throw new ArgumentError("Histórico de console inválido");
         }
         entries = [];
         i = 0;
         while(i < count)
         {
            sender = int(data["_-0u0"]());
            data["_-nr"]();
            data["_-nr"]();
            entries.push({
               "sender":sender,
               "text":data["_-nr"](),
               "seconds":data["_-0u0"](),
               "id":data["_-nr"]()
            });
            i++;
         }
         state = _consoleHistories[peer];
         if(state == null)
         {
            return;
         }
         state.pending = false;
         first = !state.loaded;
         state.loaded = true;
         if(count == 0)
         {
            state.more = false;
            return;
         }
         oldest = String(entries[0].id);
         state.more = oldest != "" && oldest != String(state.requested);
         state.cursor = oldest;
         messages = [];
         C = klass("_-20o::_-2uW");
         for each(entry in entries)
         {
            id = String(entry.id);
            if(!(id != "" && (_consoleHistoryIds[id] === true || _consoleLiveIds[id] === true)))
            {
               if(id != "")
               {
                  _consoleHistoryIds[id] = true;
                  state.ids.push(id);
               }
               messages.push(new C(int(entry.sender) == _consoleOwnId ? 1 : 2,int(entry.sender),String(entry.text),int(entry.seconds)));
            }
         }
         if(messages.length == 0)
         {
            return;
         }
         collection = state.conversation.messages;
         list = state.list;
         active = _consoleViews[list] === state && list.dataProvider === collection;
         oldMax = active ? Number(list.maxVerticalScrollPosition) : 0;
         oldPosition = active ? Number(list.verticalScrollPosition) : 0;
         _insertingConsoleHistory = true;
         try
         {
            collection.data = messages.concat(collection.data);
            if(active)
            {
               list.validate();
               list.verticalScrollPosition = first ? list.maxVerticalScrollPosition : Math.max(0,oldPosition + list.maxVerticalScrollPosition - oldMax);
            }
         }
         finally
         {
            _insertingConsoleHistory = false;
         }
      }
      
      private static function loadSocialPreferences() : void
      {
         var C:Class;
         var settings:Object;
         if(_socialPreferencesLoaded)
         {
            return;
         }
         _socialPreferencesLoaded = true;
         try
         {
            C = klass("flash.net::SharedObject");
            settings = C.getLocal("habbo_classic_commands");
            if(settings.data.friendhl === true || settings.data.friendhl === false)
            {
               _friendHighlightEnabled = Boolean(settings.data.friendhl);
            }
         }
         catch(error:Error)
         {
         }
      }
      
      private static function saveSocialPreferences() : void
      {
         var C:Class;
         var settings:Object;
         try
         {
            C = klass("flash.net::SharedObject");
            settings = C.getLocal("habbo_classic_commands");
            settings.data.friendhl = _friendHighlightEnabled;
            settings.flush();
         }
         catch(error:Error)
         {
         }
      }
      
      public static function friendsFragment(parser:Object) : void
      {
         if(int(parser["_-10A"]) == 0)
         {
            _friendIds = new Dictionary();
         }
         addFriendRecords(parser["_-0VJ"]);
      }
      
      public static function friendsUpdated(parser:Object) : void
      {
         for each(var id:int in parser["_-3Rx"])
         {
            delete _friendIds[id];
         }
         addFriendRecords(parser["_-1CR"]);
         addFriendRecords(parser["_-9a"]);
      }
      
      private static function addFriendRecords(friends:Array) : void
      {
         if(friends == null)
         {
            return;
         }
         for each(var friend:Object in friends)
         {
            var id:int = int(friend.id);
            if(id > 0)
            {
               _friendIds[id] = true;
            }
         }
      }
      
      private static function clearFriendHighlights(resetSeen:Boolean = true) : void
      {
         if(_friendLayer != null)
         {
            _friendLayer.removeFromParent(true);
            _friendLayer = null;
         }
         _friendTags = new Dictionary();
         if(resetSeen)
         {
            _seenRoomFriends = new Dictionary();
         }
      }
      
      public static function roomSocialFrame(event:Object) : void
      {
         if(_roomCanvas == null || _roomCanvas.disposed || _roomEngine == null)
         {
            return;
         }
         var room:int = int(_roomEngine["_-0Y"]);
         var now:int = getTimer();
         if(room != _friendRoom)
         {
            clearFriendHighlights();
            _friendRoom = room;
            _lastFriendScan = -1000;
         }
         if(!_friendHighlightEnabled)
         {
            return;
         }
         if(now - _lastFriendScan >= 200)
         {
            scanRoomFriends(now);
            _lastFriendScan = now;
         }
         for(var key:Object in _friendTags)
         {
            var record:Object = _friendTags[key];
            var obj:Object = _roomEngine["_-46h"](room,int(key),100);
            if(now >= int(record.expires) || obj == null || int(_seenRoomFriends[key]) != int(record.account))
            {
               record.view.removeFromParent(true);
               delete _friendTags[key];
            }
            else
            {
               var location:Object = obj.getLocation();
               var point:Object = projected(location.x,location.y,location.z + 1.85);
               record.view.visible = point != null;
               if(point != null)
               {
                  record.view.x = point.x + Number(_roomCanvas["_-1Gf"]) - record.view.width / 2;
                  record.view.y = point.y + Number(_roomCanvas["_-1cn"]) - record.view.height - 5;
                  record.view.alpha = Math.min(1,Math.max(0,(int(record.expires) - now) / 700));
               }
            }
         }
      }
      
      private static function scanRoomFriends(now:int) : void
      {
         var desktop:Object = _roomCanvas.desktop;
         if(desktop == null)
         {
            return;
         }
         var session:Object = desktop["_-22-"];
         if(session == null || session.disposed)
         {
            return;
         }
         var manager:Object = session["_-2gp"];
         if(manager == null)
         {
            return;
         }
         var users:Object = manager["_-1Z1"]();
         var current:Dictionary = new Dictionary();
         for each(var user:Object in users)
         {
            if(!(user == null || int(user.type) != 1 || user.name == null || user.name == ""))
            {
               var account:int = int(user["_-1GP"]);
               if(_friendIds[account] === true)
               {
                  var index:int = int(user["_-Oi"]);
                  if(index != int(session["_-4kZ"]))
                  {
                     var obj:Object = _roomEngine["_-46h"](_friendRoom,index,100);
                     if(obj != null)
                     {
                        current[index] = account;
                        if(int(_seenRoomFriends[index]) != account)
                        {
                           showFriendHighlight(index,account,String(user.name),now);
                        }
                     }
                  }
               }
            }
         }
         _seenRoomFriends = current;
      }
      
      private static function showFriendHighlight(index:int, account:int, name:String, now:int) : void
      {
         if(name == null || name == "")
         {
            return;
         }
         if(_friendLayer == null)
         {
            var S:Class = klass("starling.display::Sprite");
            _friendLayer = new S();
            _friendLayer.touchable = false;
            _roomCanvas["_-2ne"].addChild(_friendLayer);
         }
         var old:Object = _friendTags[index];
         if(old != null)
         {
            old.view.removeFromParent(true);
         }
         var Text:Class = klass("starling.text::TextField");
         var tag:Object = new Text(280,30,name,"Ubuntu",20,6808399,true);
         tag.touchable = false;
         tag.autoScale = true;
         var Glow:Class = klass("flash.filters::GlowFilter");
         tag.nativeFilters = [new Glow(0,1,4,4,12,2,false,false)];
         _friendLayer.addChild(tag);
         _friendTags[index] = {
            "view":tag,
            "account":account,
            "expires":now + 6000
         };
      }
      
      private static function makeOptions(parent:Object, caption:String, options:Array, value:Object) : Object
      {
         var row:Object = column(4);
         parent.addChild(row);
         addLabel(row,caption);
         var control:Object = button("",openOptions);
         control.width = panelWidth() - 38;
         updateOptions(control,options,value);
         row.addChild(control);
         return control;
      }
      
      private static function updateOptions(control:Object, options:Array, value:Object) : void
      {
         if(_optionOwner === control)
         {
            closeOptions(null);
         }
         var items:Array = [];
         var selected:int = -1;
         var i:int = 0;
         while(i < options.length)
         {
            var option:Object = options[i];
            if(option != null)
            {
               if(option.value == value)
               {
                  selected = int(items.length);
               }
               items.push({
                  "label":tr(String(option.label),String(option.label)),
                  "value":option.value
               });
            }
            i++;
         }
         if(selected < 0)
         {
            items.push({
               "label":"Valor atual (" + String(value) + ")",
               "value":value
            });
            selected = items.length - 1;
         }
         _optionStates[control] = {
            "items":items,
            "index":selected
         };
         control.label = String(items[selected].label) + " ▾";
      }
      
      private static function optionValue(control:Object) : Object
      {
         var state:Object = control == null ? null : _optionStates[control];
         if(state == null || state.index < 0 || state.index >= state.items.length)
         {
            return null;
         }
         var item:Object = state.items[state.index];
         return item == null ? null : item.value;
      }
      
      public static function openOptions(event:Object) : void
      {
         var owner:Object = event.currentTarget;
         var state:Object = _optionStates[owner];
         if(state == null || state.items.length == 0)
         {
            return;
         }
         closeOptions(null);
         _optionOwner = owner;
         _optionChoices = new Dictionary(true);
         var root:Object = panel();
         addLabel(root,localText("Escolha uma opção"));
         var S:Class = klass("_-2xS::_-4Mu");
         var V:Class = klass("_-0iC::_-pG");
         var list:Object = new S();
         list.layout = new V();
         list.layout.gap = 5;
         list.width = root.width - 28;
         list.height = Math.min(Starling.current.stage.stageHeight * 0.58,state.items.length * 64);
         list.horizontalScrollPolicy = "off";
         list.verticalScrollPolicy = "auto";
         var i:int = 0;
         while(i < state.items.length)
         {
            var choice:Object = button(String(state.items[i].label),chooseOption);
            choice.width = list.width - 8;
            _optionChoices[choice] = {
               "owner":owner,
               "index":i
            };
            list.addChild(choice);
            i++;
         }
         root.addChild(list);
         root.addChild(button(localText("Cancelar"),closeOptions));
         _optionPopup = root;
         presentPanel(root);
      }
      
      public static function chooseOption(event:Object) : void
      {
         var choice:Object = _optionChoices[event.currentTarget];
         if(choice == null)
         {
            return;
         }
         var owner:Object = choice.owner;
         var index:int = int(choice.index);
         var state:Object = _optionStates[owner];
         closeOptions(null);
         if(state == null || index < 0 || index >= state.items.length)
         {
            return;
         }
         state.index = index;
         owner.label = String(state.items[index].label) + " ▾";
         owner.dispatchEventWith("change");
      }
      
      public static function closeOptions(event:Object) : void
      {
         if(_optionPopup != null)
         {
            var P:Class = klass("_-u8::_-1OE");
            P["_-4gZ"](_optionPopup,true);
            _optionPopup = null;
         }
         _optionOwner = null;
         _optionChoices = new Dictionary(true);
      }
      
      public static function modernWiredContent(control:Object) : Object
      {
         if(control != _modernControl || _modernInfo == null)
         {
            return null;
         }
         var content:Object = column(10);
         var name:String = _wiredEditor["_-1yl"](int(_modernInfo.type));
         var description:String = _wiredEditor["_-0lb"](int(_modernInfo.type));
         addLabel(content,name);
         if(description != null && description != "")
         {
            addLabel(content,description);
         }
         return content;
      }
      
      private static function makeCheck(parent:Object, caption:String, initial:Boolean) : Object
      {
         var C:Class = klass("_-2xS::_-1kl");
         var c:Object = new C();
         c.label = localText(caption);
         c.isSelected = initial;
         parent.addChild(c);
         return c;
      }
      
      private static function formValue(control:Object, kind:String) : Object
      {
         if(kind == "options")
         {
            return optionValue(control);
         }
         if(kind == "check")
         {
            return control.isSelected ? 1 : 0;
         }
         if(kind == "bool")
         {
            return Boolean(control.isSelected);
         }
         if(kind == "text")
         {
            return String(control.text);
         }
         return int(control.value);
      }
      
      private static function bind(control:Object, kind:String, target:Object, key:Object) : void
      {
         _formBindings.push({
            "control":control,
            "kind":kind,
            "target":target,
            "key":key,
            "original":target[key],
            "baseline":formValue(control,kind)
         });
      }
      
      private static function captureForm() : void
      {
         for each(var b:Object in _formBindings)
         {
            var value:Object = formValue(b.control,b.kind);
            b.target[b.key] = value === b.baseline ? b.original : value;
         }
      }
      
      private static function sourceLabel(id:int, users:Boolean) : String
      {
         var key:String = "wiredfurni.params.sources." + (users ? "users." : "furni.") + id;
         var fallback:String = id == 100 ? localText("Mobis selecionados 1") : (id == 101 ? localText("Mobis selecionados 2") : (id == 110 ? localText("Mobis adicionais") : String(id)));
         return tr(key,fallback);
      }
      
      private static function addSources(parent:Object, allowed:Array, values:Array, defaults:Array, users:Boolean) : void
      {
         var i:int = 0;
         while(i < allowed.length)
         {
            var options:Array = [];
            for each(var source:int in allowed[i])
            {
               options.push({
                  "value":source,
                  "label":sourceLabel(source,users)
               });
            }
            if(options.length != 0)
            {
               if(i >= values.length)
               {
                  values[i] = i < defaults.length ? defaults[i] : options[0].value;
               }
               bind(makeOptions(parent,(users ? localText("Avatares") : localText("Mobis")) + localText(" — origem ") + (i + 1),options,values[i]),"options",values,i);
            }
            i++;
         }
      }
      
      public static function selectWiredOne(event:Object) : void
      {
         chooseWiredFurniture(0);
      }
      
      public static function selectWiredTwo(event:Object) : void
      {
         chooseWiredFurniture(1);
      }
      
      private static function chooseWiredFurniture(group:int) : void
      {
         if(_modernInfo == null || _modernControl == null || _wiredEditor == null)
         {
            return;
         }
         captureForm();
         captureAction();
         _pickGroup = group;
         _modernControl["_-3xY"] = group == 0 ? _modernInfo.ids.slice() : _modernInfo.ids2.slice();
         _wiredEditor["_-oI"]();
      }
      
      public static function pickedWiredFurniture(control:Object, ids:Array) : void
      {
         if(control != _modernControl || _modernInfo == null)
         {
            return;
         }
         if(_pickGroup == 0)
         {
            _modernInfo.ids = ids.slice();
         }
         else
         {
            _modernInfo.ids2 = ids.slice();
         }
         refreshPickLabels();
      }
      
      private static function refreshPickLabels() : void
      {
         if(_modernInfo == null || _modernInfo.ids == null || _modernInfo.ids2 == null || _pickLabels == null)
         {
            return;
         }
         if(_pickLabels.length > 0 && _pickLabels[0] != null)
         {
            _pickLabels[0].text = localText("Seleção 1: ") + _modernInfo.ids.length + " / " + _modernInfo.limit;
         }
         if(_pickLabels.length > 1 && _pickLabels[1] != null)
         {
            _pickLabels[1].text = localText("Seleção 2: ") + _modernInfo.ids2.length + " / " + _modernInfo.limit;
         }
      }
      
      public static function modernWired(data:Object, service:Object, right:Object, save:Object, previous:Object, editor:Object) : Object
      {
         _actionPicker = null;
         _actionExtra = null;
         _actionExtraRow = null;
         _formBindings = [];
         endFurniturePicking();
         endArea();
         removeWiredPanel();
         if(previous != null)
         {
            previous.dispose();
         }
         _modernService = service;
         _modernInfo = _wiredById[int(data.id)];
         _wiredEditor = editor;
         _optionStates = new Dictionary(true);
         _formBindings = [];
         _pickLabels = [];
         _pickGroup = 0;
         _actionPicker = null;
         _actionExtra = null;
         _actionExtraRow = null;
         _wiredOpeningStage = "criar painel";
         var W:Class = klass("_-1NI::_-2R7");
         var control:Object = new W(data);
         _modernControl = control;
         var content:Object = control.view;
         _modernContent = content;
         if(content.layout != null)
         {
            content.layout.gap = 10;
         }
         if(content.numChildren > 2)
         {
            var illustration:Object = content.getChildAt(2);
            illustration.visible = false;
            illustration.includeInLayout = false;
            var title:Object = content.getChildAt(0);
            title.wordWrap = true;
            title.maxWidth = panelWidth() - 28;
         }
         var info:Object = _modernInfo;
         if(info == null)
         {
            throw new ArgumentError("Configuração recebida sem identificador de Wired");
         }
         var schema:Object = _wiredSchema[info.category + ":" + info.code];
         _wiredOpeningStage = "criar opções";
         var area:Boolean = schema != null && schema.area === true;
         if(schema != null && !area)
         {
            var descriptors:Array = schema.params;
            var count:int = Math.max(info.ints.length,info.defaults.length,descriptors.length);
            var i:int = 0;
            while(i < count)
            {
               var d:Object = i < descriptors.length ? descriptors[i] : {
                  "kind":"number",
                  "label":localText("Opção ") + (i + 1),
                  "min":-2147483648,
                  "max":2147483647
               };
               if(info.category == "effect" && int(info.code) == 7 && i == 2)
               {
                  d = {
                     "kind":"options",
                     "label":localText("Largura do balão"),
                     "options":[{
                        "value":-1,
                        "label":localText("Preferência do usuário")
                     },{
                        "value":0,
                        "label":localText("Largo")
                     },{
                        "value":1,
                        "label":localText("Normal")
                     },{
                        "value":2,
                        "label":localText("Fino")
                     }]
                  };
               }
               if(i >= info.ints.length)
               {
                  if(i < info.defaults.length)
                  {
                     info.ints[i] = info.defaults[i];
                  }
                  else if(d.kind == "options" && d.options.length > 0)
                  {
                     info.ints[i] = d.options[0].value;
                  }
                  else
                  {
                     info.ints[i] = Math.max(Number(d.min),Math.min(Number(d.max),0));
                  }
               }
               if(d.kind == "options")
               {
                  var c:Object = makeOptions(content,tr(d.label),d.options,info.ints[i]);
               }
               else if(d.kind == "check")
               {
                  c = makeCheck(content,tr(d.label),int(info.ints[i]) != 0);
               }
               else
               {
                  c = makeNumber(content,tr(d.label),int(info.ints[i]),Number(d.min),Number(d.max));
               }
               bind(c,d.kind,info.ints,i);
               if(schema.action === true && i == 0)
               {
                  _actionPicker = c;
                  _actionOriginal = int(info.ints[0]);
                  _actionOriginalText = String(info.text);
               }
               i++;
            }
         }
         else if(!area)
         {
            i = 0;
            while(i < info.ints.length)
            {
               bind(makeNumber(content,localText("Opção ") + (i + 1),info.ints[i],-2147483648,2147483647),"number",info.ints,i);
               i++;
            }
         }
         _wiredOpeningStage = "criar campos";
         if(area)
         {
            beginArea(content);
         }
         if(schema != null && schema.action === true)
         {
            createActionExtras(content);
         }
         if((schema == null || schema.action !== true) && (info.text != "" || info.category == "variable" || schema == null || schema.text))
         {
            bind(makeText(content,info.category == "variable" ? localText("Nome da variável") : localText("Texto"),info.text),"text",info,"text");
         }
         if(info.category == "effect")
         {
            bind(makeNumber(content,localText("Atraso (pulsos de 0,5 segundo)"),info.delay,0,120),"number",info,"delay");
         }
         if(info.category == "condition" && info.quantifierType != 0)
         {
            var target:String = info.quantifierType == 1 ? "furni" : (info.quantifierType == 2 ? "users" : "variables");
            var quantifierKey:String = "wiredfurni.params.quantifier." + target + (info.inverted ? ".neg." : ".");
            bind(makeOptions(content,"Condição",[{
               "value":0,
               "label":tr(quantifierKey + "0",localText("Todos"))
            },{
               "value":1,
               "label":tr(quantifierKey + "1","Pelo menos um")
            }],info.quantifier),"options",info,"quantifier");
         }
         if(info.category == "selector")
         {
            bind(makeCheck(content,localText("Filtrar a seleção anterior"),info.filter),"bool",info,"filter");
            bind(makeCheck(content,localText("Inverter seleção"),info.invert),"bool",info,"invert");
         }
         addSources(content,info.allowedFurni,info.furniSources,info.defaultFurniSources,false);
         addSources(content,info.allowedUsers,info.userSources,info.defaultUserSources,true);
         var pickOne:Boolean = info.ids.length > 0;
         var pickTwo:Boolean = info.ids2.length > 0;
         for each(var allowedGroup:Array in info.allowedFurni)
         {
            if(allowedGroup.indexOf(100) != -1 || allowedGroup.indexOf(110) != -1)
            {
               pickOne = true;
            }
            if(allowedGroup.indexOf(101) != -1)
            {
               pickTwo = true;
            }
         }
         _pickLabels = [null,null];
         _pickButtons = [null,null];
         if(pickOne)
         {
            _pickLabels[0] = addLabel(content,"");
            _pickButtons[0] = button(localText("Selecionar mobis 1"),selectWiredOne);
            content.addChild(_pickButtons[0]);
         }
         if(pickTwo)
         {
            _pickLabels[1] = addLabel(content,"");
            _pickButtons[1] = button(localText("Selecionar mobis 2"),selectWiredTwo);
            content.addChild(_pickButtons[1]);
         }
         refreshPickLabels();
         if(info.category == "effect" && int(info.code) == 3)
         {
            control["_-1A7"] = true;
            content.addChild(button(localText("Guardar estado e posição dos mobis"),selectWiredOne));
         }
         var vars:Array = info.contextVariables.concat(_roomVariables);
         i = 0;
         while(i < info.variables.length)
         {
            var opts:Array = [{
               "value":"n",
               "label":localText("Nenhuma")
            }];
            for each(var v:Object in vars)
            {
               opts.push({
                  "value":v.id,
                  "label":v.name
               });
            }
            bind(makeOptions(content,localText("Variável ") + (i + 1),opts,info.variables[i]),"options",info.variables,i);
            i++;
         }
         _wiredOpeningStage = "exibir painel";
         if(save == null)
         {
            save = button(localText("Salvar"),saveDirectWired);
         }
         var F:Class = klass("_-0iC::_-4TN");
         content.layoutData = new F(100);
         if(_roomEngine != null && _roomCanvas != null)
         {
            presentWiredPanel(content,save);
         }
         else
         {
            right.addChildAt(content,0);
         }
         save.includeInLayout = save.visible = true;
         return control;
      }
      
      public static function saveDirectWired(event:Object) : void
      {
         saveModernWired();
      }
      
      private static function actionExtraOptions(action:int) : Array
      {
         var options:Array = [{
            "value":"",
            "label":(action == 10 ? localText("Qualquer placa") : localText("Qualquer dança"))
         }];
         if(action == 10)
         {
            var i:int = 0;
            while(i <= 17)
            {
               options.push({
                  "value":String(i),
                  "label":tr("wiredfurni.params.action.sign." + i,localText("Placa ") + i)
               });
               i++;
            }
         }
         else if(action == 11)
         {
            i = 1;
            while(i <= 4)
            {
               options.push({
                  "value":"dance " + i,
                  "label":tr("wiredfurni.params.action.dance." + i,localText("Dança ") + i)
               });
               i++;
            }
         }
         return options;
      }
      
      private static function createActionExtras(parent:Object) : void
      {
         if(_actionPicker == null)
         {
            return;
         }
         _actionExtraRow = column(4);
         parent.addChild(_actionExtraRow);
         _actionExtra = makeOptions(_actionExtraRow,localText("Placa ou dança específica"),actionExtraOptions(_actionOriginal),_actionOriginalText);
         _actionExtraRow.visible = _actionOriginal == 10 || _actionOriginal == 11;
         _actionExtraRow.includeInLayout = _actionExtraRow.visible;
         _actionPicker.addEventListener("change",actionChanged);
      }
      
      public static function actionChanged(event:Object) : void
      {
         if(_actionUpdating || _actionPicker == null || _actionExtra == null)
         {
            return;
         }
         _actionUpdating = true;
         var action:int = int(optionValue(_actionPicker));
         var value:String = action == _actionOriginal ? _actionOriginalText : "";
         var options:Array = actionExtraOptions(action);
         var selected:int = 0;
         var i:int = 0;
         while(i < options.length)
         {
            if(options[i].value == value)
            {
               selected = i;
            }
            i++;
         }
         if(selected == 0 && value != "")
         {
            options.push({
               "value":value,
               "label":"Valor atual (" + value + ")"
            });
            selected = options.length - 1;
         }
         updateOptions(_actionExtra,options,value);
         _actionExtraRow.visible = action == 10 || action == 11;
         _actionExtraRow.includeInLayout = _actionExtraRow.visible;
         _actionUpdating = false;
      }
      
      private static function captureAction() : void
      {
         if(_actionPicker == null || _modernInfo == null)
         {
            return;
         }
         var action:int = int(optionValue(_actionPicker));
         if(action == 10 || action == 11)
         {
            _modernInfo.text = String(optionValue(_actionExtra));
         }
         else if(action != _actionOriginal)
         {
            _modernInfo.text = "";
         }
      }
      
      public static function saveModernWired() : Boolean
      {
         if(_modernInfo == null || _modernControl == null || _modernControl.disposed)
         {
            return false;
         }
         captureForm();
         captureAction();
         var info:Object = _modernInfo;
         var names:Object = {
            "effect":"Effect",
            "trigger":"Trigger",
            "condition":"Condition",
            "addon":"Addon",
            "selector":"Selector",
            "variable":"Variable"
         };
         var C:Class = klass("loginpatch::WiredPayload" + names[info.category]);
         _modernService.send(new C(modernPayload(info)));
         return true;
      }
      
      public static function modernPayload(info:Object) : Array
      {
         var out:Array = [int(info.id)];
         appendWiredList(out,info.ints);
         out.push(String(info.text));
         appendWiredList(out,info.ids);
         if(info.category == "effect")
         {
            out.push(int(info.delay));
         }
         if(info.category == "condition")
         {
            out.push(int(info.quantifier));
         }
         if(info.category == "selector")
         {
            out.push(Boolean(info.filter));
            out.push(Boolean(info.invert));
         }
         appendWiredList(out,info.furniSources);
         appendWiredList(out,info.userSources);
         appendWiredList(out,info.variables);
         appendWiredList(out,info.ids2);
         return out;
      }
      
      public static function interceptWired(wrapper:Object, connection:Object) : Boolean
      {
         var id:int;
         var category:String;
         var D:Class;
         var room:int;
         var Request:Class;
         _activeConnection = connection;
         if(klass("loginpatch::AreaHide30").incoming(wrapper))
         {
            return true;
         }
         if(klass("loginpatch::ClientFixes23").interceptRoomFlags(wrapper))
         {
            return true;
         }
         if(interceptAccountPacket(wrapper,connection))
         {
            return true;
         }
         id = int(wrapper["_-2Dk"]());
         if(id == _consoleHistoryHeader)
         {
            receiveConsoleHistory(wrapper);
            return true;
         }
         if(id == 3097)
         {
            receiveStackHeight(wrapper);
            return true;
         }
         if(id == 860)
         {
            receiveWiredVariables(wrapper);
            return true;
         }
         if(id == 1686)
         {
            category = "effect";
         }
         else if(id == 2539)
         {
            category = "trigger";
         }
         else if(id == 1572)
         {
            category = "condition";
         }
         else if(id == 16)
         {
            category = "addon";
         }
         else if(id == 2772)
         {
            category = "selector";
         }
         else
         {
            if(id != 444)
            {
               return false;
            }
            category = "variable";
         }
         try
         {
            _wiredOpeningStage = "ler configuração";
            received(id);
            _pendingWired = readWired(wrapper,category);
            if(_wiredEditor != null)
            {
               D = klass("_-VG::_-3qW");
               _wiredEditor["_-26m"](new D(null,category));
            }
            if(_pendingWired.variables.length > 0 && _modernService != null)
            {
               room = int(_modernService.roomId);
               if(room != _variableRoom || getTimer() - _lastVariablesRequest >= 800)
               {
                  _variableRoom = room;
                  _lastVariablesRequest = getTimer();
                  _roomVariables = [];
                  Request = klass("loginpatch::WiredPayloadVariables");
                  connection.send(new Request([0]));
               }
            }
            _pendingWired = null;
            return true;
         }
         catch(error:Error)
         {
            _pendingWired = null;
            _modernInfo = null;
            if(_wiredEditor != null)
            {
               _wiredEditor.close();
            }
            if(_controller != null)
            {
               _controller.alert(localText("Configuração do Wired"),"Não foi possível abrir esta configuração. Nenhuma alteração foi enviada. Código: " + error.errorID + ". Etapa: " + _wiredOpeningStage + ". " + error.message);
            }
            return true;
         }
      }
      
      private static function receiveWiredVariables(data:Object) : void
      {
         data["_-0u0"]();
         var last:Boolean = Boolean(data.readBoolean());
         var removed:Array = wiredStrings(data);
         var count:int = int(data["_-0u0"]());
         if(count < 0 || count > 50000)
         {
            throw new ArgumentError("Invalid Wired variable count");
         }
         var i:int = 0;
         while(i < count)
         {
            data["_-0u0"]();
            var variable:Object = readVariable(data);
            _roomVariables.push(variable);
            i++;
         }
         if(!last || _modernInfo == null)
         {
            return;
         }
         captureForm();
         var C:Class = klass("_-1Ab::_-nO");
         for each(var binding:Object in _formBindings)
         {
            if(binding.target === _modernInfo.variables)
            {
               var options:Array = [{
                  "value":"n",
                  "label":localText("Nenhuma")
               }];
               var selected:int = 0;
               var value:String = String(_modernInfo.variables[binding.key]);
               for each(variable in _modernInfo.contextVariables.concat(_roomVariables))
               {
                  options.push({
                     "value":variable.id,
                     "label":variable.name
                  });
                  if(variable.id == value)
                  {
                     selected = options.length - 1;
                  }
               }
               if(selected == 0 && value != "n" && value != "")
               {
                  options.push({
                     "value":value,
                     "label":value
                  });
                  selected = options.length - 1;
               }
               updateOptions(binding.control,options,value);
            }
         }
      }
      
      private static function readVariable(data:Object) : Object
      {
         var result:Object = {
            "id":data["_-nr"](),
            "type":data["_-0u0"](),
            "name":data["_-nr"]()
         };
         data["_-0u0"]();
         data["_-0u0"]();
         var i:int = 0;
         while(i < 8)
         {
            data.readBoolean();
            i++;
         }
         if(data.readBoolean())
         {
            var count:int = int(data["_-0u0"]());
            i = 0;
            while(i < count)
            {
               data["_-0u0"]();
               data["_-nr"]();
               i++;
            }
         }
         return result;
      }
      
      private static function readWiredContext(data:Object, info:Object = null) : Array
      {
         var vars:Array = [];
         var count:int = int(data["_-0u0"]());
         if(count < 0 || count > 64)
         {
            throw new ArgumentError("Invalid Wired context");
         }
         var i:int = 0;
         while(i < count)
         {
            var kind:int = int(data["_-0u0"]());
            if(kind == 0)
            {
               data["_-0u0"]();
            }
            else if(kind == 1 || kind == 2)
            {
               vars.push(readVariable(data));
               var n:int = int(data["_-0u0"]());
               var j:int = 0;
               while(j < n)
               {
                  data["_-0u0"]();
                  data["_-0u0"]();
                  j++;
               }
            }
            else if(kind == 3)
            {
               vars.push(readVariable(data));
               data["_-0u0"]();
            }
            else if(kind == 4)
            {
               n = int(data["_-0u0"]());
               j = 0;
               while(j < n)
               {
                  data["_-0u0"]();
                  data["_-nr"]();
                  vars.push(readVariable(data));
                  j++;
               }
            }
            else if(kind == 5)
            {
               n = int(data["_-0u0"]());
               j = 0;
               while(j < n)
               {
                  vars.push(readVariable(data));
                  j++;
               }
            }
            else
            {
               if(kind != 6)
               {
                  if(info == null)
                  {
                     throw new ArgumentError("Unknown Wired context type: " + kind);
                  }
                  info.contextComplete = false;
                  info.unknownContext = kind;
                  while(data.bytesAvailable > 0)
                  {
                     data.readByte();
                  }
                  return vars;
               }
               n = int(data["_-0u0"]());
               j = 0;
               while(j < n)
               {
                  data["_-0u0"]();
                  data["_-nr"]();
                  data["_-nr"]();
                  j++;
               }
            }
            i++;
         }
         return vars;
      }
      
      public static function rememberRoomCanvas(canvas:Object, engine:Object) : void
      {
         if(klass("loginpatch::FloorEditor22").previewRoomFor(canvas) != 0)
         {
            return;
         }
         if(engine == null)
         {
            return;
         }
         if(_roomCanvas != canvas)
         {
            if(_roomCanvas != null)
            {
               _roomCanvas.canvas.removeEventListener("enterFrame",roomSocialFrame);
            }
            clearFriendHighlights();
            endRoomEditors();
            _friendRoom = -1;
         }
         _roomCanvas = canvas;
         _roomEngine = engine;
         loadSocialPreferences();
         canvas.canvas.removeEventListener("enterFrame",roomSocialFrame);
         canvas.canvas.addEventListener("enterFrame",roomSocialFrame);
      }
      
      public static function disposeRoomCanvas(canvas:Object) : void
      {
         if(canvas != _roomCanvas)
         {
            return;
         }
         canvas.canvas.removeEventListener("enterFrame",roomSocialFrame);
         clearFriendHighlights();
         endRoomEditors();
         klass("loginpatch::FloorEditor22").roomClosed();
         _roomCanvas = null;
         _roomEngine = null;
      }
      
      private static function endRoomEditors() : void
      {
         _pickLabels = [];
         _pickButtons = [];
         endFurniturePicking();
         endArea();
         closeHeight(null);
         removeWiredPanel();
         _modernInfo = null;
         _modernControl = null;
         _modernContent = null;
         _hideObject = null;
         _hideContent = null;
         _hideSave = null;
         _hideToggle = null;
         _hideStatus = null;
         _hideChecks = [];
         _hideRoom = -1;
         _hideBusy = false;
      }
      
      private static function panelWidth() : Number
      {
         var width:Number = Starling.current.stage.stageWidth;
         return Math.min(width - 16,Math.min(520,Math.max(300,width * 0.32)));
      }
      
      private static function panel() : Object
      {
         var root:Object = column(10);
         root.width = panelWidth();
         root.layout.padding = 14;
         root.styleNameList.add("alternate-blue-with-border-bg");
         return root;
      }
      
      private static function placePanel(root:Object) : void
      {
         root.x = Starling.current.stage.stageWidth - root.width - 8;
         root.y = 8;
      }
      
      private static function presentPanel(root:Object) : void
      {
         var P:Class = klass("_-u8::_-1OE");
         P["_-3Dk"](root,false,false);
         placePanel(root);
      }
      
      private static function removeWiredPanel() : void
      {
         _hideObject = null;
         _hideContent = null;
         _hideSave = null;
         _hideToggle = null;
         _hideStatus = null;
         _hideChecks = [];
         _hideRoom = -1;
         _hideBusy = false;
         closeOptions(null);
         if(_wiredPopup == null)
         {
            return;
         }
         if(_modernContent != null)
         {
            _modernContent.removeFromParent();
         }
         var P:Class = klass("_-u8::_-1OE");
         P["_-4gZ"](_wiredPopup,true);
         _wiredPopup = null;
         _modernSave = null;
      }
      
      private static function presentWiredPanel(content:Object, save:Object) : void
      {
         var root:Object = panel();
         addLabel(root,localText("Mobis Wired"));
         var S:Class = klass("_-2xS::_-4Mu");
         var V:Class = klass("_-0iC::_-pG");
         var scroll:Object = new S();
         scroll.layout = new V();
         scroll.layout.gap = 10;
         scroll.width = root.width - 28;
         scroll.height = Math.max(160,Starling.current.stage.stageHeight * 0.78 - 130);
         scroll.horizontalScrollPolicy = "off";
         scroll.verticalScrollPolicy = "auto";
         scroll.addChild(content);
         root.addChild(scroll);
         var U:Class = klass("_-2YJ::_-0iF");
         var row:Object = U["_-4fM"](10);
         row.addChild(button(localText("Salvar"),saveWiredPanel));
         row.addChild(button(localText("Fechar"),closeWiredPanel));
         root.addChild(row);
         _wiredPopup = root;
         _modernSave = save;
         _editorRoom = int(_roomEngine["_-0Y"]);
         root.addEventListener("enterFrame",editorFrame);
         presentPanel(root);
      }
      
      public static function saveWiredPanel(event:Object) : void
      {
         endFurniturePicking();
         if(_modernSave != null)
         {
            _modernSave.dispatchEventWith("triggered");
         }
      }
      
      public static function closeWiredPanel(event:Object) : void
      {
         if(_wiredEditor != null)
         {
            _wiredEditor.close();
         }
         else
         {
            wiredClosed();
         }
      }
      
      public static function wiredClosed() : void
      {
         _actionPicker = null;
         _actionExtra = null;
         _actionExtraRow = null;
         _formBindings = [];
         _pickLabels = [];
         _pickButtons = [];
         endFurniturePicking();
         endArea();
         removeWiredPanel();
         _modernInfo = null;
         _modernControl = null;
         _modernContent = null;
      }
      
      public static function wiredUiEvent(event:Object) : Boolean
      {
         if(_roomCanvas == null || _roomEngine == null)
         {
            return false;
         }
         var type:String = String(event.type);
         if(type == "WIRED_OPEN_REQUEST")
         {
            if(_wiredPopup != null)
            {
               _wiredPopup.visible = true;
            }
            return true;
         }
         if(type == "WIRED_OPEN_STUFF_SELECTOR_REQUEST")
         {
            if(_wiredPopup != null)
            {
               _wiredPopup.visible = false;
            }
         }
         return false;
      }
      
      public static function editorFrame(event:Object) : void
      {
         if(_roomEngine == null || _roomCanvas == null || _roomCanvas.disposed || _wiredPopup != null && int(_roomEngine["_-0Y"]) != _editorRoom || _heightPopup != null && int(_roomEngine["_-0Y"]) != _heightRoom)
         {
            endRoomEditors();
            return;
         }
         if(_hideObject != null && !canManageAreaHide30())
         {
            endRoomEditors();
            return;
         }
         if(_hideBusy && getTimer() - _hideToggleAt > 5000)
         {
            _hideBusy = false;
            refreshAreaHide30();
            if(_hideStatus != null)
            {
               _hideStatus.text = localText("O quarto não confirmou a alteração. Tente novamente.");
            }
         }
         if(_wiredPopup != null)
         {
            placePanel(_wiredPopup);
         }
         if(_optionPopup != null)
         {
            placePanel(_optionPopup);
         }
         if(_heightPopup != null)
         {
            placePanel(_heightPopup);
         }
         if(_areaActive)
         {
            if(getTimer() - _lastGhostRefresh >= 250)
            {
               ghostFurniture();
               _lastGhostRefresh = getTimer();
            }
            var version:int = int(_roomCanvas.geometry["_-9l"]);
            if(version != _areaGeometryVersion)
            {
               drawArea();
               _areaGeometryVersion = version;
            }
            if(_areaShield != null)
            {
               _areaShield.width = _roomCanvas.width;
               _areaShield.height = _roomCanvas.height;
            }
         }
      }
      
      private static function beginArea(parent:Object) : void
      {
         if(_roomCanvas == null || _roomEngine == null)
         {
            addLabel(parent,localText("Entre em um quarto para selecionar uma área."));
            return;
         }
         _areaActive = true;
         _areaSelecting = false;
         _areaDragging = false;
         _areaGhosts = new Dictionary(true);
         ghostFurniture();
         var Spr:Class = klass("starling.display::Sprite");
         var Q:Class = klass("starling.display::Quad");
         _areaLayer = new Spr();
         _areaLayer.touchable = false;
         _roomCanvas["_-2ne"].addChild(_areaLayer);
         _areaShield = new Q(_roomCanvas.width,_roomCanvas.height,0);
         _areaShield.alpha = 0;
         _areaShield.touchable = false;
         _areaShield.addEventListener("touch",areaTouch);
         _roomCanvas.canvas.addChild(_areaShield);
         addLabel(parent,localText("Seleção de área"));
         addLabel(parent,localText("Toque em Selecionar área e arraste o dedo sobre o piso do quarto."));
         parent.addChild(button(localText("Selecionar área"),startArea));
         parent.addChild(button(localText("Limpar área"),clearArea));
         _areaCaption = addLabel(parent,"");
         drawArea();
      }
      
      private static function ghostFurniture() : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var room:int = int(_roomEngine["_-0Y"]);
         for each(var category:int in [10,20])
         {
            var count:int = int(_roomEngine["_-2vx"](room,category));
            var i:int = 0;
            while(i < count)
            {
               var obj:Object = _roomEngine["_-2Fe"](room,i,category);
               if(obj != null)
               {
                  var model:Object = obj.getModelController();
                  if(model != null)
                  {
                     var record:Object = _areaGhosts[obj];
                     if(record == null)
                     {
                        record = {
                           "object":obj,
                           "alpha":model.getNumber("furniture_alpha_multiplier")
                        };
                        _areaGhosts[obj] = record;
                     }
                     var alpha:Number = Number(record.alpha);
                     if(isNaN(alpha))
                     {
                        alpha = 1;
                     }
                     model.setNumber("furniture_alpha_multiplier",alpha * 0.12);
                  }
               }
               i++;
            }
         }
      }
      
      private static function endArea() : void
      {
         _areaActive = false;
         _areaSelecting = false;
         _areaDragging = false;
         _areaTouchId = -1;
         if(_areaShield != null)
         {
            _areaShield.removeFromParent(true);
            _areaShield = null;
         }
         if(_areaLayer != null)
         {
            _areaLayer.removeFromParent(true);
            _areaLayer = null;
         }
         for each(var record:Object in _areaGhosts)
         {
            var obj:Object = record.object;
            var model:Object = obj.getModelController();
            if(model != null)
            {
               model.setNumber("furniture_alpha_multiplier",Number(record.alpha));
            }
         }
         _areaGhosts = new Dictionary(true);
         _areaCaption = null;
         _areaHit = null;
      }
      
      public static function startArea(event:Object) : void
      {
         if(!_areaActive || _hideObject != null && _hideOn)
         {
            return;
         }
         endFurniturePicking();
         _roomEngine["_-2Zf"]();
         _areaSelecting = true;
         _areaDragging = false;
         _areaTouchId = -1;
         _areaShield.touchable = true;
         _areaCaption.text = localText("Arraste sobre o piso para marcar a área.");
      }
      
      public static function clearArea(event:Object) : void
      {
         if(!_areaActive || _modernInfo == null)
         {
            return;
         }
         _areaSelecting = false;
         _areaDragging = false;
         _areaTouchId = -1;
         _areaShield.touchable = false;
         setArea(0,0,0,0);
         drawArea();
         if(_hideObject != null)
         {
            saveAreaHide30(null);
         }
      }
      
      private static function setArea(x:int, y:int, width:int, height:int) : void
      {
         _modernInfo.ints[0] = x;
         _modernInfo.ints[1] = y;
         _modernInfo.ints[2] = width;
         _modernInfo.ints[3] = height;
      }
      
      public static function areaTileHit(x:int, y:int, z:int, type:String) : Boolean
      {
         if(type != "loginpatch_area")
         {
            return false;
         }
         _areaHit = {
            "x":x,
            "y":y,
            "z":z
         };
         return true;
      }
      
      private static function probeFloor(globalX:Number, globalY:Number) : Object
      {
         var PointClass:Class = klass("flash.geom::Point");
         var point:Object = _roomCanvas["_-2ne"].globalToLocal(new PointClass(globalX,globalY));
         point.x -= Number(_roomCanvas["_-1Gf"]);
         point.y -= Number(_roomCanvas["_-1cn"]);
         _areaHit = null;
         var logic:Object = _roomCanvas.roomObject.getEventHandler();
         logic["_-329"](point,_roomCanvas.geometry,"loginpatch_area");
         if(_areaHit == null)
         {
            return null;
         }
         var floor:Object = _roomEngine["_-2J-"](int(_roomEngine["_-0Y"]));
         if(floor == null)
         {
            return null;
         }
         var height:Number = Number(floor["_-4-t"](_areaHit.x,_areaHit.y));
         if(isNaN(height) || height < 0 || height >= 100 || Math.abs(height - Number(_areaHit.z)) > 0.01)
         {
            return null;
         }
         return _areaHit;
      }
      
      public static function areaTouch(event:Object) : void
      {
         if(!_areaActive || !_areaSelecting)
         {
            return;
         }
         event.stopImmediatePropagation();
         var touch:Object = event.getTouch(_areaShield,null,_areaTouchId);
         if(touch == null)
         {
            return;
         }
         if(touch.phase == "began")
         {
            var hit:Object = probeFloor(touch.globalX,touch.globalY);
            if(hit == null)
            {
               return;
            }
            _areaTouchId = touch.id;
            _areaStartX = hit.x;
            _areaStartY = hit.y;
            _areaDragging = true;
            setArea(hit.x,hit.y,1,1);
            drawArea();
         }
         else if(_areaDragging && (touch.phase == "moved" || touch.phase == "ended"))
         {
            hit = probeFloor(touch.globalX,touch.globalY);
            if(hit != null)
            {
               setArea(Math.min(_areaStartX,hit.x),Math.min(_areaStartY,hit.y),Math.abs(hit.x - _areaStartX) + 1,Math.abs(hit.y - _areaStartY) + 1);
               drawArea();
            }
            if(touch.phase == "ended")
            {
               _areaSelecting = false;
               _areaDragging = false;
               _areaTouchId = -1;
               _areaShield.touchable = false;
               if(_hideObject != null)
               {
                  saveAreaHide30(null);
               }
            }
         }
      }
      
      private static function projected(x:Number, y:Number, z:Number) : Object
      {
         var V:Class = klass("_-0AB::Vector3d");
         return _roomCanvas.geometry["_-49b"](new V(x,y,z));
      }
      
      private static function drawArea() : void
      {
         if(!_areaActive || _areaLayer == null || _modernInfo == null)
         {
            return;
         }
         _areaLayer.removeChildren(0,-1,true);
         var values:Array = _modernInfo.ints;
         var width:int = int(values[2]);
         var height:int = int(values[3]);
         if(_areaCaption != null)
         {
            _areaCaption.text = width > 0 && height > 0 ? localText("Área marcada: ") + width + " × " + height + " quadrados" : localText("Nenhuma área selecionada");
         }
         if(width <= 0 || height <= 0 || width > 128 || height > 128)
         {
            return;
         }
         var floor:Object = _roomEngine["_-2J-"](int(_roomEngine["_-0Y"]));
         var Q:Class = klass("starling.display::Quad");
         var M:Class = klass("flash.geom::Matrix");
         var x:int = int(values[0]);
         while(x < int(values[0]) + width)
         {
            var y:int = int(values[1]);
            while(y < int(values[1]) + height)
            {
               var z:Number = floor != null ? Number(floor["_-4-t"](x,y)) : 0;
               if(!(z < 0 || z >= 100 || isNaN(z)))
               {
                  var a:Object = projected(x - 0.5,y - 0.5,z + 0.01);
                  var b:Object = projected(x + 0.5,y - 0.5,z + 0.01);
                  var c:Object = projected(x - 0.5,y + 0.5,z + 0.01);
                  if(!(a == null || b == null || c == null))
                  {
                     var quad:Object = new Q(1,1,7446783);
                     quad.alpha = 0.4;
                     quad.touchable = false;
                     quad.transformationMatrix = new M(b.x - a.x,b.y - a.y,c.x - a.x,c.y - a.y,a.x + _roomCanvas["_-1Gf"],a.y + _roomCanvas["_-1cn"]);
                     _areaLayer.addChild(quad);
                  }
               }
               y++;
            }
            x++;
         }
      }
      
      private static function isHeightAdjustable(type:String) : Boolean
      {
         return type.indexOf("tile_stackmagic") == 0 || type.indexOf("tile_walkmagic") == 0;
      }
      
      public static function openStackHeight(logic:Object) : Boolean
      {
         var obj:Object = logic.object;
         if(obj == null || !isHeightAdjustable(String(obj.getType())))
         {
            return false;
         }
         if(_activeConnection == null || _roomEngine == null)
         {
            return false;
         }
         _roomEngine["_-2Zf"]();
         showHeight(obj.getId(),obj.getLocation().z,_activeConnection);
         return true;
      }
      
      private static function showHeight(id:int, height:Number, context:Object) : void
      {
         closeHeight(null);
         _activeConnection = context;
         _heightId = id;
         _heightRoom = int(_roomEngine["_-0Y"]);
         _heightDesired = _heightSent = Math.round(height * 100);
         _heightDirty = false;
         _heightAwait = false;
         _heightRequests = [];
         _heightRange = height > 10 ? 80 : 10;
         _heightSync = true;
         _heightEditing = false;
         var root:Object = panel();
         addLabel(root,localText("Regulador de altura"));
         var U:Class = klass("_-2YJ::_-0iF");
         var row:Object = U["_-4fM"](14,"left","top");
         root.addChild(row);
         var Spr:Class = klass("starling.display::Sprite");
         _heightRuler = new Spr();
         makeHeightRuler();
         row.addChild(_heightRuler);
         var controls:Object = column(10);
         row.addChild(controls);
         var help:Object = addLabel(controls,localText("Arraste o medidor ou digite a altura. O mobi acompanha a alteração no quarto."));
         help.maxWidth = root.width - 120;
         _heightRangeLabel = addLabel(controls,localText("Régua: 0 a ") + _heightRange);
         _heightField = makeText(controls,localText("Altura (0 a 80)"),height.toFixed(2));
         _heightField.width = root.width - 125;
         _heightField.restrict = "0-9.,";
         _heightField.maxChars = 8;
         _heightField.addEventListener("change",heightTextChanged);
         _heightField.addEventListener("focusIn",heightFocusIn);
         _heightField.addEventListener("focusOut",heightFocusOut);
         controls.addChild(button(localText("Para o topo"),aboveHeight));
         controls.addChild(button(localText("Nível do chão"),floorHeight));
         root.addChild(button(localText("Fechar"),closeHeight));
         _heightPopup = root;
         root.addEventListener("enterFrame",editorFrame);
         _heightSync = false;
         syncHeightControls(height,true);
         presentPanel(root);
      }
      
      private static function makeHeightRuler() : void
      {
         var Q:Class = klass("starling.display::Quad");
         var h:Number = Math.max(170,Math.min(330,Starling.current.stage.stageHeight * 0.47));
         var track:Object = new Q(54,h,3750217);
         _heightRuler.addChild(track);
         var i:int = 0;
         while(i <= 20)
         {
            var mark:Object = new Q(i % 2 == 0 ? 30 : 16,2,13816530);
            mark.x = 54 - mark.width;
            mark.y = (h - 18) * i / 20 + 8;
            mark.touchable = false;
            _heightRuler.addChild(mark);
            i++;
         }
         _heightKnob = new Q(48,14,11465123);
         _heightKnob.x = 3;
         _heightKnob.touchable = false;
         _heightRuler.addChild(_heightKnob);
         _heightRuler.addEventListener("touch",heightRulerTouch);
      }
      
      private static function syncHeightControls(height:Number, replaceText:Boolean) : void
      {
         if(_heightPopup == null || _heightField == null)
         {
            return;
         }
         _heightSync = true;
         if(replaceText)
         {
            _heightField.text = height.toFixed(2);
         }
         if(height > _heightRange)
         {
            _heightRange = 80;
         }
         if(_heightRangeLabel != null)
         {
            _heightRangeLabel.text = localText("Régua: 0 a ") + _heightRange;
         }
         if(_heightKnob != null)
         {
            _heightKnob.y = (1 - Math.min(1,Math.max(0,height / _heightRange))) * (_heightRuler.height - 18) + 2;
         }
         _heightSync = false;
      }
      
      private static function previewHeight(id:int, height:Number) : void
      {
         if(_roomEngine == null || int(_roomEngine["_-0Y"]) != _heightRoom)
         {
            return;
         }
         var obj:Object = _roomEngine["_-46h"](_heightRoom,id,10);
         if(obj == null || !isHeightAdjustable(String(obj.getType())))
         {
            return;
         }
         var selection:Object = _roomEngine.getSelectedObjectData(_heightRoom);
         if(selection != null && int(selection.id) == id && int(selection.category) == 10)
         {
            var saved:Object = selection["_-UL"];
            if(saved != null)
            {
               saved.z = height;
            }
         }
         var pos:Object = obj.getLocation();
         var V:Class = klass("_-0AB::Vector3d");
         _roomEngine["_-0ex"](_heightRoom,id,new V(pos.x,pos.y,height),null);
      }
      
      private static function queueHeight(height:Number, replaceText:Boolean) : void
      {
         if(isNaN(height) || height < 0 || height > 80)
         {
            return;
         }
         var units:int = int(Math.round(height * 100));
         if(units == _heightDesired)
         {
            syncHeightControls(units / 100,replaceText);
            return;
         }
         _heightDesired = units;
         syncHeightControls(units / 100,replaceText);
         previewHeight(_heightId,units / 100);
         _heightDirty = true;
         if(_heightTimer == null)
         {
            _heightTimer = new Timer(120);
            _heightTimer.addEventListener("timer",flushHeight);
         }
         if(!_heightTimer.running)
         {
            _heightTimer.start();
         }
      }
      
      public static function heightFocusIn(event:Object) : void
      {
         _heightEditing = true;
      }
      
      public static function heightFocusOut(event:Object) : void
      {
         _heightEditing = false;
         if(_heightDesired >= 0)
         {
            syncHeightControls(_heightDesired / 100,true);
         }
      }
      
      public static function heightTextChanged(event:Object) : void
      {
         if(_heightSync || _heightField == null)
         {
            return;
         }
         var text:String = String(_heightField.text).replace(",",".");
         if(text == "" || text == ".")
         {
            return;
         }
         queueHeight(Number(text),false);
      }
      
      public static function heightRulerTouch(event:Object) : void
      {
         if(_heightRuler == null)
         {
            return;
         }
         var touch:Object = event.getTouch(_heightRuler);
         if(touch == null)
         {
            return;
         }
         event.stopImmediatePropagation();
         if(touch.phase != "began" && touch.phase != "moved" && touch.phase != "ended")
         {
            return;
         }
         var point:Object = touch.getLocation(_heightRuler);
         queueHeight(Math.max(0,Math.min(1,1 - (point.y - 9) / (_heightRuler.height - 18))) * _heightRange,true);
         if(touch.phase == "ended")
         {
            flushHeight(null);
         }
      }
      
      public static function flushHeight(event:Object) : void
      {
         if(_roomEngine == null || int(_roomEngine["_-0Y"]) != _heightRoom)
         {
            _heightDirty = false;
            _heightAwait = false;
            if(_heightTimer != null)
            {
               _heightTimer.stop();
            }
            return;
         }
         if(_heightAwait && getTimer() - _heightSendAt < 600)
         {
            return;
         }
         if(!_heightDirty)
         {
            if(_heightTimer != null)
            {
               _heightTimer.stop();
            }
            return;
         }
         _heightSent = _heightDesired;
         _heightDirty = false;
         _heightAwait = true;
         _heightSendAt = getTimer();
         _heightRequests.push(_heightSent);
         sendStackHeight(_heightId,_heightSent,_activeConnection);
      }
      
      public static function receiveStackHeight(data:Object) : void
      {
         var id:int = int(data["_-0u0"]());
         var height:Number = data["_-0u0"]() / 100;
         if(_roomEngine == null || int(_roomEngine["_-0Y"]) != _heightRoom)
         {
            return;
         }
         if(id != _heightId)
         {
            previewHeight(id,height);
            return;
         }
         var expected:int = _heightRequests.length > 0 ? int(_heightRequests.shift()) : _heightDesired;
         _heightAwait = _heightRequests.length > 0;
         if(_heightDirty || _heightAwait || expected != _heightDesired)
         {
            if(_heightDirty)
            {
               flushHeight(null);
            }
            return;
         }
         _heightDesired = _heightSent = Math.round(height * 100);
         previewHeight(id,height);
         syncHeightControls(height,!_heightEditing);
      }
      
      public static function applyHeight(event:Object) : void
      {
         heightTextChanged(null);
         flushHeight(null);
      }
      
      public static function floorHeight(event:Object) : void
      {
         queueHeight(0,true);
         flushHeight(null);
      }
      
      public static function aboveHeight(event:Object) : void
      {
         _heightDesired = -100;
         _heightDirty = true;
         flushHeight(null);
      }
      
      public static function closeHeight(event:Object) : void
      {
         if(_heightPopup == null)
         {
            return;
         }
         flushHeight(null);
         var P:Class = klass("_-u8::_-1OE");
         P["_-4gZ"](_heightPopup,true);
         _heightPopup = null;
         _heightField = null;
         _heightRuler = null;
         _heightKnob = null;
         _heightRangeLabel = null;
      }
      
      private static function sendStackHeight(id:int, height:int, context:Object) : void
      {
         if(context == null)
         {
            return;
         }
         var C:Class = klass("_-26z::_-kr");
         context.send(new C(id,height));
      }
      
      public static function wiredFurniturePicking() : Boolean
      {
         return _furniturePicking && _modernInfo != null && _roomCanvas != null;
      }
      
      public static function wiredFurnitureTap(canvas:Object, objects:Object) : void
      {
         if(!wiredFurniturePicking() || canvas != _roomCanvas || objects == null)
         {
            return;
         }
         var selected:Object = null;
         for each(var obj:Object in objects)
         {
            var category:int = int(obj["_-3YM"]());
            if(category == 10 || category == 20 && _modernInfo.wall)
            {
               selected = obj;
               break;
            }
         }
         if(selected == null)
         {
            return;
         }
         var id:int = int(selected.getId());
         var ids:Array = _pickGroup == 0 ? _modernInfo.ids : _modernInfo.ids2;
         var index:int = ids.indexOf(id);
         if(index >= 0)
         {
            ids.splice(index,1);
         }
         else
         {
            if(ids.length >= int(_modernInfo.limit))
            {
               if(_pickLabels[_pickGroup] != null)
               {
                  _pickLabels[_pickGroup].text = "Limite de " + _modernInfo.limit + " mobis. Desmarque um para trocar.";
               }
               return;
            }
            ids.push(id);
         }
         _modernControl["_-3xY"] = ids.slice();
         refreshFurnitureMarks();
         refreshPickLabels();
      }
      
      private static function refreshFurnitureMarks() : void
      {
         clearFurnitureMarks();
         if(!wiredFurniturePicking() || _roomEngine == null)
         {
            return;
         }
         var ids:Array = _pickGroup == 0 ? _modernInfo.ids : _modernInfo.ids2;
         for each(var id:int in ids)
         {
            var obj:Object = _roomEngine["_-46h"](int(_roomEngine["_-0Y"]),id,10);
            if(obj == null && _modernInfo.wall)
            {
               obj = _roomEngine["_-46h"](int(_roomEngine["_-0Y"]),id,20);
            }
            if(obj != null)
            {
               _roomCanvas["_-2qv"](obj,true);
               _furnitureMarks[obj] = true;
            }
         }
      }
      
      private static function clearFurnitureMarks() : void
      {
         if(_roomCanvas != null)
         {
            for(var obj:Object in _furnitureMarks)
            {
               _roomCanvas["_-2qv"](obj,false);
            }
         }
         _furnitureMarks = new Dictionary(true);
      }
      
      private static function endFurniturePicking() : void
      {
         _furniturePicking = false;
         clearFurnitureMarks();
         if(_modernInfo != null)
         {
            refreshPickLabels();
         }
      }
      
      public static function positionChatIcon(icon:Object, style:Object, background:Object) : Boolean
      {
         if(icon == null)
         {
            return false;
         }
         icon.scaleX = icon.scaleY = 1;
         if(style == null || style["_-ES"] == null)
         {
            icon.visible = false;
            return true;
         }
         var D:Class = klass("_-1N-::_-2mJ");
         var scale:Number = Number(D["_-0-S"]());
         if(style["_-0iM"] == null)
         {
            var slot:Number = Math.max(1,Math.min(Number(style.textFieldMargins.x) - 4 * scale,Number(style.background.texture.height) * scale - 4 * scale));
            scale = Math.min(slot / icon.texture.width,slot / icon.texture.height);
         }
         icon.scaleX = icon.scaleY = scale;
         icon.x = Math.round(Number(style["_-ES"].x) - icon.width / 2);
         icon.y = Math.round((background.height - icon.height) / 2);
         icon.visible = true;
         return true;
      }
      
      public static function buildTokenLogin(screen:Object, container:Object, controller:Object, view:Object) : Object
      {
         selectHotelLanguage(controller,controller.getProperty("environment.id"));
         var T:Class = klass("_-2xS::_-1XI");
         var C:Class = klass("_-2xS::_-00s");
         var input:Object = new T();
         input.text = "";
         input.visible = false;
         input.includeInLayout = false;
         var password:Object = new T();
         password.text = "";
         var remember:Object = new C();
         remember.isSelected = false;
         container.padding = 0;
         container.layout = null;
         container.horizontalScrollPolicy = "off";
         container.verticalScrollPolicy = "off";
         screen.horizontalScrollPolicy = "off";
         screen.verticalScrollPolicy = "off";
         var root:Object = uiGroup(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight,0,false);
         root.name = "token-login-root";
         container.addChild(root);
         var card:Object = uiGroup(1,1,1121093);
         card.backgroundSkin.alpha = 0.92;
         root.addChild(card);
         var title:Object = uiText(localText("Entrar com código"),34,16777215,true);
         card.addChild(title);
         var instructions:Object = uiText(localText("Copie o código do Launcher no site oficial do Habbo e toque no botão abaixo para entrar."),19,14213627);
         instructions.wordWrap = true;
         card.addChild(instructions);
         var loginButton:Object = button(localText("Colar código e entrar"),tokenLoginAction);
         loginButton.styleNameList.remove("alternate-blue-button");
         card.addChild(loginButton);
         var website:Object = button(localText("Abrir site oficial do Habbo"),tokenWebsiteAction);
         card.addChild(website);
         var country:Object = button("",tokenHotelAction);
         country.name = "login-hotel-flag";
         var I:Class = klass("_-2xS::_-1aX");
         var icon:Object = new I();
         country.defaultIcon = icon;
         root.addChild(country);
         var state:Object = {
            "root":root,
            "container":container,
            "controller":controller,
            "view":view,
            "card":card,
            "title":title,
            "instructions":instructions,
            "input":input,
            "password":password,
            "remember":remember,
            "login":loginButton,
            "website":website,
            "country":country,
            "icon":icon
         };
         _tokenScreens[screen] = state;
         _tokenActions[loginButton] = state;
         _tokenActions[website] = state;
         _tokenActions[country] = state;
         screen.addEventListener("resize",tokenLoginResize);
         controller.forgetUserLoginCredentials();
         controller.loginName = "";
         controller.password = "";
         controller["_-1FS"] = false;
         layoutTokenLogin(screen);
         return state;
      }
      
      public static function tokenLoginResize(event:Object) : void
      {
         layoutTokenLogin(event.currentTarget);
      }
      
      public static function layoutTokenLogin(screen:Object) : void
      {
         var state:Object = _tokenScreens[screen];
         if(state == null)
         {
            return;
         }
         var w:Number = Starling.current.stage.stageWidth;
         var h:Number = Starling.current.stage.stageHeight;
         var u:Number = uiUnit();
         var container:Object = state.container;
         container.width = w;
         container.height = h;
         container.maxHeight = h;
         container.x = container.y = 0;
         var A:Class = klass("_-0iC::_-BX");
         container.layoutData = new A(0,0,0,0);
         state.root.width = w;
         state.root.height = h;
         state.root.x = state.root.y = 0;
         var card:Object = state.card;
         card.width = Math.min(w - 48 * u,Math.min(w * 0.72,1060 * u));
         card.height = 326 * u;
         card.x = Math.round((w - card.width) / 2);
         card.y = Math.round((h - card.height) / 2 + 18 * u);
         card.backgroundSkin.width = card.width;
         card.backgroundSkin.height = card.height;
         state.title.text = localText("Entrar com código");
         state.instructions.text = localText("Copie o código do Launcher no site oficial do Habbo e toque no botão abaixo para entrar.");
         state.login.label = localText("Colar código e entrar");
         state.website.label = localText("Abrir site oficial do Habbo");
         var inner:Number = card.width - 48 * u;
         state.title.x = 24 * u;
         state.title.y = 22 * u;
         state.title.width = inner;
         state.title.maxWidth = inner;
         state.instructions.x = 24 * u;
         state.instructions.y = 82 * u;
         state.instructions.width = inner;
         state.instructions.maxWidth = inner;
         state.instructions.height = 62 * u;
         var F:Class = klass("flash.text::TextFormat");
         for each(var control:Object in [state.login,state.website,state.country])
         {
            control.validate();
            control.minWidth = control.minHeight = 0;
            control.padding = 10 * u;
            control.defaultLabelProperties.textFormat = new F("UbuntuBold",22 * u,16777215);
         }
         state.login.x = 24 * u;
         state.login.y = 164 * u;
         state.login.width = inner;
         state.login.height = 60 * u;
         state.website.x = 24 * u;
         state.website.y = 242 * u;
         state.website.width = inner;
         state.website.height = 56 * u;
         state.country.width = 136 * u;
         state.country.height = 54 * u;
         state.country.x = w - state.country.width - 18 * u;
         state.country.y = 16 * u;
         var environment:String = state.controller.getProperty("environment.id");
         var Theme:Class = klass("HitchTheme");
         state.icon.source = Theme.getTexture(Theme["_-oc"](environment) ? environment : "H_logo_small");
         state.icon.width = state.icon.height = 32 * u;
         var labels:Object = {
            "pt":"BR",
            "en":"EN",
            "fi":"FI",
            "fr":"FR",
            "de":"DE",
            "nl":"NL",
            "es":"ES",
            "it":"IT",
            "tr":"TR"
         };
         state.country.label = (String(labels[environment] == null ? localText("Hotel") : labels[environment])) + " ▾";
         state.country.visible = true;
         state.country.includeInLayout = true;
         container.readjustLayout();
      }
      
      public static function tokenLoginAction(event:Object) : void
      {
         var state:Object = _tokenActions[event.currentTarget];
         if(state != null)
         {
            state.input.text = "";
            login(state.controller,state.input);
         }
      }
      
      public static function tokenWebsiteAction(event:Object) : void
      {
         var state:Object = _tokenActions[event.currentTarget];
         if(state != null)
         {
            openWebsite(state.controller);
         }
      }
      
      public static function tokenHotelAction(event:Object) : void
      {
         var state:Object = _tokenActions[event.currentTarget];
         if(state != null)
         {
            state.view.showEnvironmentSelect();
         }
      }
      
      public static function disposeTokenLogin(screen:Object) : void
      {
         var state:Object = _tokenScreens[screen];
         if(state == null)
         {
            return;
         }
         delete _tokenActions[state.login];
         delete _tokenActions[state.website];
         delete _tokenActions[state.country];
         delete _tokenScreens[screen];
         screen.removeEventListener("resize",tokenLoginResize);
      }
      
      public static function syncLoginPresentation(name:String, loginScreen:Object, loadingScreen:Object) : void
      {
         if(loginScreen != null)
         {
            loginScreen.visible = name == "loginScreen";
            loginScreen.touchable = name == "loginScreen";
         }
         if(loadingScreen != null)
         {
            loadingScreen.visible = name == "loadingScreen";
            loadingScreen.touchable = name == "loadingScreen";
         }
      }
      
      public static function decorateLogin(screen:Object, view:Object, icon:Object) : void
      {
         if(screen.getChildByName("login-hotel-flag") != null)
         {
            return;
         }
         var scale:Number = uiUnit();
         var flag:Object = button("",changeLoginHotel);
         flag.name = "login-hotel-flag";
         flag.padding = 8 * scale;
         icon.removeFromParent();
         flag.defaultIcon = icon;
         flag.validate();
         flag.minWidth = flag.minHeight = 0;
         flag.width = flag.height = 54 * scale;
         var A:Class = klass("_-0iC::_-BX");
         var anchor:Object = new A();
         anchor.top = 12 * scale;
         anchor.left = 12 * scale;
         flag.layoutData = anchor;
         _loginViews[flag] = view;
         screen.addChild(flag);
      }
      
      public static function changeLoginHotel(event:Object) : void
      {
         var view:Object = _loginViews[event.currentTarget];
         if(view != null)
         {
            view.showEnvironmentSelect();
         }
      }
      
      public static function cacheChatFace(context:Object, key:String, figure:String, gesture:String, listener:Object) : void
      {
         var T:Class = klass("_-0zo::_-1Tv");
         var textures:Object = T["_-0R5"];
         if(textures["_-4nG"](key) != null)
         {
            return;
         }
         var renderer:Object = context["_-3lM"];
         if(!renderer["_-0VM"](renderer["_-2YV"](figure)))
         {
            return;
         }
         var avatar:Object = renderer["_-4QF"](figure,"h",null,listener);
         if(avatar == null)
         {
            return;
         }
         if(gesture != null && gesture != "")
         {
            avatar.appendAction("gest",gesture);
         }
         var full:Object = avatar.getImage("head",false);
         if(full == null)
         {
            avatar.dispose();
            return;
         }
         var skin:String = "";
         for each(var part:String in figure.split("."))
         {
            if(part.indexOf("hd-") == 0)
            {
               skin = part;
               break;
            }
         }
         var reference:Object = skin == "" ? null : renderer["_-4QF"](skin,"h",null,listener);
         var bounds:Object = null;
         if(reference != null)
         {
            var face:Object = reference.getImage("head",false);
            if(face != null)
            {
               bounds = face.getColorBoundsRect(4278190080,0,false);
            }
         }
         var B:Class = klass("flash.display::BitmapData");
         var R:Class = klass("flash.geom::Rectangle");
         var P:Class = klass("flash.geom::Point");
         var size:int = 36;
         var cx:Number = full.width / 2;
         var cy:Number = full.height * 0.3;
         if(bounds != null && bounds.width > 0 && bounds.height > 0)
         {
            cx = bounds.x + bounds.width / 2;
            cy = bounds.y + bounds.height / 2;
         }
         var crop:Object = new R(Math.round(cx - size / 2),Math.round(cy - size / 2),size,size);
         var portrait:Object = new B(size,size,true,0);
         portrait.copyPixels(full,crop,new P(0,0),null,null,true);
         textures["_-0OO"](key,portrait);
         portrait.dispose();
         if(reference != null)
         {
            reference.dispose();
         }
         avatar.dispose();
      }
      
      public static function requestEventLists(catalog:Object) : void
      {
         if(catalog == null || catalog.communication == null || catalog.communication.connection == null)
         {
            return;
         }
         var connection:Object = catalog.communication.connection;
         var now:int = getTimer();
         var previous:Object = _eventListRequests[catalog];
         if(previous != null && previous.connection == connection && now - int(previous.time) < 1000)
         {
            return;
         }
         _eventListRequests[catalog] = {
            "connection":connection,
            "time":now
         };
         var Rooms:Class = klass("loginpatch::RoomAdInfoPayload");
         var Categories:Class = klass("loginpatch::EventCategoriesPayload");
         connection.send(new Rooms());
         connection.send(new Categories());
      }
      
      public static function eventCategoriesArrived(catalog:Object, controller:Object) : void
      {
         if(catalog == null || controller == null)
         {
            return;
         }
         var page:Object = controller["_-1wL"];
         if(page != null && getQualifiedClassName(page) == "_-ue::_-0LS" && page["_-49d"]())
         {
            page["_-1ff"](catalog["_-4mq"]);
         }
      }
      
      public static function refreshEventSelectors(page:Object, root:Object, categories:Object, rooms:Object, catalog:Object) : void
      {
         if(root == null || catalog == null)
         {
            return;
         }
         var localization:Object = catalog.localization;
         refreshEventSelector(categories,localText("Selecione a categoria do evento"),localization,catalog["_-4mq"]);
         refreshEventSelector(rooms,localText("Selecione um quarto"),localization);
      }
      
      private static function refreshEventSelector(picker:Object, caption:String, localization:Object, records:Array = null) : void
      {
         if(picker == null || picker.parent == null)
         {
            return;
         }
         var control:Object = _eventPickers[picker];
         if(control == null || control.parent == null)
         {
            var parent:Object = picker.parent;
            var index:int = int(parent.getChildIndex(picker));
            control = button(caption,eventSelectorChanged);
            control.removeEventListener("triggered",eventSelectorChanged);
            control.addEventListener("triggered",openOptions);
            control.addEventListener("change",eventSelectorChanged);
            control.width = Math.max(280,Number(picker.width));
            parent.addChildAt(control,index);
            picker.visible = false;
            picker.includeInLayout = false;
            _eventPickers[picker] = control;
            _eventButtons[control] = picker;
         }
         var data:Object = picker.dataProvider;
         var items:Array = [];
         if(data != null)
         {
            var i:int = 0;
            while(i < int(data.length))
            {
               var value:Object = data.getItemAt(i);
               var text:String = String(value);
               if(records != null && i < records.length)
               {
                  var supplied:String = records[i]["_-VN"];
                  if(supplied != null && supplied != "")
                  {
                     text = supplied;
                  }
               }
               var pass:int = 0;
               while(true)
               {
                  if(!(pass < 8 && text.indexOf("${") == 0 && localization != null))
                  {
                     break;
                  }
                  var key:String = text.substring(2,text.length - 1);
                  var translated:String = localization.getLocalization(key,text);
                  if(translated == text)
                  {
                     break;
                  }
                  text = translated;
                  pass++;
               }
               items.push({
                  "label":text,
                  "value":i
               });
               i++;
            }
         }
         control.isEnabled = items.length > 0;
         if(items.length == 0)
         {
            _optionStates[control] = {
               "items":[],
               "index":-1
            };
            control.label = caption + (data == null ? localText(" (carregando…)") : localText(" (nenhuma opção disponível)"));
         }
         else
         {
            updateOptions(control,items,Math.max(0,int(picker.selectedIndex)));
         }
      }
      
      public static function eventSelectorChanged(event:Object) : void
      {
         var control:Object = event.currentTarget;
         var picker:Object = _eventButtons[control];
         if(picker != null)
         {
            picker.selectedIndex = int(optionValue(control));
         }
      }
      
      private static function catalogRecord(control:Object, type:String) : Object
      {
         var byType:Object = _catalogHistory[control];
         if(byType == null)
         {
            byType = {};
            _catalogHistory[control] = byType;
         }
         if(byType[type] == null)
         {
            byType[type] = {
               "page":-1,
               "scroll":[],
               "query":""
            };
         }
         return byType[type];
      }
      
      public static function rememberCatalogPage(control:Object, type:String, page:int) : void
      {
         if(type == null || page < 0)
         {
            return;
         }
         var record:Object = catalogRecord(control,type);
         record.page = page;
         var pending:Object = _catalogRestore[control];
         if(pending != null && int(pending.page) == page)
         {
            delete _catalogRestore[control];
            setTimeout(restoreCatalogScroll,60,control,type);
         }
      }
      
      private static function collectCatalogScroll(view:Object, path:Array, out:Array) : void
      {
         if(view == null)
         {
            return;
         }
         if("verticalScrollPosition" in view && "horizontalScrollPosition" in view)
         {
            out.push({
               "path":path.slice(),
               "y":Number(view.verticalScrollPosition),
               "x":Number(view.horizontalScrollPosition)
            });
         }
         if("numChildren" in view)
         {
            var i:int = 0;
            while(i < int(view.numChildren))
            {
               var next:Array = path.slice();
               next.push(i);
               collectCatalogScroll(view.getChildAt(i),next,out);
               i++;
            }
         }
      }
      
      public static function rememberCatalogPosition(control:Object, type:String, content:Object) : void
      {
         if(control == null || control.stage == null || type == null || content == null || !content["_-49d"]())
         {
            return;
         }
         var record:Object = catalogRecord(control,type);
         var positions:Array = [];
         collectCatalogScroll(content.view,[],positions);
         record.scroll = positions;
      }
      
      public static function restoreCatalogScroll(control:Object, type:String) : void
      {
         if(control == null || control.catalogType != type)
         {
            return;
         }
         var record:Object = catalogRecord(control,type);
         var page:Object = control["_-1wL"];
         if(page == null || !page["_-49d"]())
         {
            return;
         }
         var root:Object = page.view;
         root.validate();
         for each(var position:Object in record.scroll)
         {
            var view:Object = root;
            for each(var index:int in position.path)
            {
               if(view == null || !("numChildren" in view) || index >= int(view.numChildren))
               {
                  view = null;
                  break;
               }
               view = view.getChildAt(index);
            }
            if(view != null && "verticalScrollPosition" in view)
            {
               view.verticalScrollPosition = position.y;
               view.horizontalScrollPosition = position.x;
            }
         }
      }
      
      public static function catalogTypeChanged(control:Object, type:String) : void
      {
         if(control == null || type == null)
         {
            return;
         }
         var record:Object = catalogRecord(control,type);
         if(int(record.page) < 0)
         {
            return;
         }
         var pending:Object = _catalogRestore[control];
         if(pending != null && pending.type == type && int(pending.page) == int(record.page))
         {
            return;
         }
         _catalogRestore[control] = {
            "page":int(record.page),
            "type":type,
            "tries":0,
            "sent":false,
            "applying":false
         };
         setTimeout(restoreCatalogPage,60,control);
      }
      
      public static function catalogPageChosen(control:Object) : void
      {
         var pending:Object = _catalogRestore[control];
         if(pending != null && !pending.applying)
         {
            delete _catalogRestore[control];
         }
      }
      
      public static function restoreCatalogPage(control:Object) : void
      {
         var pending:Object = _catalogRestore[control];
         if(pending == null || control == null)
         {
            return;
         }
         if(control.catalogType != pending.type)
         {
            delete _catalogRestore[control];
            return;
         }
         if(pending.sent)
         {
            return;
         }
         if(control.stage == null || control.menu == null)
         {
            var _loc5_:Object = pending;
            var _loc6_:Number = Number(_loc5_.tries) + 1;
            _loc5_.tries = _loc6_;
            if(int(pending.tries) < 40)
            {
               setTimeout(restoreCatalogPage,100,control);
            }
            else
            {
               delete _catalogRestore[control];
            }
            return;
         }
         var state:Object = control.catalog["_-2le"](String(pending.type));
         var node:Object = state == null ? null : state["_-1uN"](int(pending.page));
         if(node != null)
         {
            pending.sent = true;
            pending.applying = true;
            control.menu["_-pY"](int(pending.page));
            control.catalog["_-1ri"](node,String(pending.type));
            pending.applying = false;
         }
         else if(++pending.tries < 40)
         {
            setTimeout(restoreCatalogPage,100,control);
         }
         else
         {
            delete _catalogRestore[control];
         }
      }
      
      public static function catalogLink(catalog:Object, control:Object, link:String) : Boolean
      {
         if(control == null || link == null)
         {
            return false;
         }
         var parts:Array = link.split("/");
         if(parts.length != 2)
         {
            return false;
         }
         var type:String = parts[1] == "warehouse" ? "BUILDERS_CLUB" : (parts[1] == "open" ? "NORMAL" : null);
         if(type == null)
         {
            return false;
         }
         catalog["_-2RD"]();
         control["_-bK"](type);
         var E:Class = klass("_-3oe::_-Rx");
         catalog.events.dispatchEvent(new E(type == "NORMAL" ? "CATALOG_OPEN_REQUEST" : "CATALOG_OPEN_BC_WAREHOUSE"));
         return true;
      }
      
      public static function clearCatalogHistory(control:Object) : void
      {
         delete _catalogHistory[control];
         delete _catalogRestore[control];
      }
      
      public static function initAccountProtocol(status:int, claim:int, notice:int, request:int) : void
      {
         _incomeStatusHeader = status;
         _incomeClaimHeader = claim;
         _incomeNoticeHeader = notice;
         _incomeClaimRequest = request;
      }
      
      public static function featureMenuSelected(menu:Object, ui:Object, item:Object) : Boolean
      {
         if(item == null || int(item.id) != 18002)
         {
            return false;
         }
         _accountUi = ui;
         _accountConnection = ui.communication.connection;
         menu["_-0Zf"]();
         showEarnings();
         return true;
      }
      
      private static function accountPanel(title:String) : Object
      {
         closeAccountPanel(null);
         var root:Object = column(10);
         root.width = Math.min(Starling.current.stage.stageWidth - 32,900);
         root.layout.padding = 18;
         root.styleNameList.add("alternate-blue-with-border-bg");
         var heading:Object = addLabel(root,title);
         heading.maxWidth = root.width - 36;
         _accountPopup = root;
         return root;
      }
      
      private static function presentAccountPanel(root:Object) : void
      {
         root.addChild(button(localText("Fechar"),closeAccountPanel));
         var P:Class = klass("_-u8::_-1OE");
         P["_-3Dk"](root,true,true);
      }
      
      public static function closeAccountPanel(event:Object) : void
      {
         if(_accountPopup != null)
         {
            var P:Class = klass("_-u8::_-1OE");
            P["_-4gZ"](_accountPopup,true);
         }
         _accountPopup = null;
         _incomeRows = null;
         _incomeStatus = null;
         _incomeButtons = new Dictionary(true);
      }
      
      private static function showEarnings() : void
      {
         closeAccountPanel(null);
         var u:Number = uiUnit();
         var root:Object = uiGroup(Starling.current.stage.stageWidth * 0.86,Starling.current.stage.stageHeight * 0.91,14015467);
         _accountPopup = root;
         var header:Object = uiGroup(root.width,56 * u,2050915);
         root.addChild(header);
         var title:Object = uiText(localText("Lucros"),28,16777215,true);
         title.validate();
         title.x = (root.width - title.width) / 2;
         title.y = 10 * u;
         header.addChild(title);
         var close:Object = button("X",closeAccountPanel);
         close.styleNameList.remove("alternate-blue-button");
         close.styleNameList.add("feathers-danger-button");
         close.validate();
         close.minWidth = close.minHeight = 0;
         close.width = close.height = 42 * u;
         close.x = root.width - close.width - 8 * u;
         close.y = 7 * u;
         header.addChild(close);
         _incomeStatus = uiText(localText("Carregando recompensas…"),16,3690072);
         _incomeStatus.x = 18 * u;
         _incomeStatus.y = header.height + 8 * u;
         _incomeStatus.maxWidth = root.width - 36 * u;
         root.addChild(_incomeStatus);
         var S:Class = klass("_-2xS::_-4Mu");
         var V:Class = klass("_-0iC::_-pG");
         _incomeRows = new S();
         _incomeRows.layout = new V();
         _incomeRows.layout.gap = 6 * u;
         _incomeRows.x = 18 * u;
         _incomeRows.y = header.height + 38 * u;
         _incomeRows.width = root.width - 36 * u;
         _incomeRows.height = root.height - _incomeRows.y - 14 * u;
         _incomeRows.horizontalScrollPolicy = "off";
         _incomeRows.verticalScrollPolicy = "auto";
         root.addChild(_incomeRows);
         var P:Class = klass("_-u8::_-1OE");
         P["_-3Dk"](root,true,true);
         requestIncomeStatus();
      }
      
      private static function requestIncomeStatus() : void
      {
         if(_accountConnection == null)
         {
            return;
         }
         var C:Class = klass("loginpatch::IncomeStatusPayload");
         _accountConnection.send(new C());
      }
      
      public static function interceptAccountPacket(data:Object, connection:Object) : Boolean
      {
         var id:int = int(data["_-2Dk"]());
         if(receiveExtraBalance(id,data))
         {
            return true;
         }
         if(id != _incomeStatusHeader && id != _incomeClaimHeader && id != _incomeNoticeHeader)
         {
            return false;
         }
         _accountConnection = connection;
         if(id == _incomeNoticeHeader)
         {
            data.readByte();
            if(_incomeRows != null)
            {
               requestIncomeStatus();
            }
            return true;
         }
         if(id == _incomeClaimHeader)
         {
            var category:int = int(data.readByte());
            var success:Boolean = Boolean(data.readBoolean());
            delete _incomePending[category];
            if(success)
            {
               requestIncomeStatus();
               if(_accountUi != null)
               {
                  requestCredits(_accountUi.catalog,true);
               }
            }
            else
            {
               renderIncomeRows();
            }
            if(_incomeStatus != null)
            {
               _incomeStatus.text = success ? localText("Resgate confirmado. Atualizando…") : localText("O servidor não confirmou o resgate. Tente novamente.");
            }
            return true;
         }
         var count:int = int(data["_-0u0"]());
         if(count < 0 || count > 2000 || count > data.bytesAvailable / 8)
         {
            throw new ArgumentError("Invalid income reward count");
         }
         var rewards:Array = [];
         var i:int = 0;
         while(i < count)
         {
            rewards.push({
               "category":data.readByte(),
               "type":data.readByte(),
               "amount":data["_-0u0"](),
               "product":data["_-nr"]()
            });
            i++;
         }
         _incomeRewards = rewards;
         _incomeLoaded = true;
         renderIncomeRows();
         return true;
      }
      
      private static function incomeSummary(category:int) : Object
      {
         var duckets:int = 0;
         var credits:int = 0;
         var products:Array = [];
         for each(var reward:Object in _incomeRewards)
         {
            if(int(reward.category) == category)
            {
               if(String(reward.product) != "")
               {
                  products.push(localText("Presente disponível"));
               }
               else if(int(reward.type) == 0)
               {
                  duckets += int(reward.amount);
               }
               else if(int(reward.type) == 1)
               {
                  credits += int(reward.amount);
               }
            }
         }
         var parts:Array = [];
         if(duckets > 0)
         {
            parts.push(duckets + " duckets");
         }
         if(credits > 0)
         {
            parts.push(credits + " moedas");
         }
         if(products.length > 0)
         {
            parts.push(products.join(", "));
         }
         return {
            "text":(parts.length == 0 ? "" : parts.join(" · ")),
            "available":parts.length > 0,
            "duckets":duckets,
            "credits":credits,
            "products":products.length
         };
      }
      
      private static function renderIncomeRows() : void
      {
         if(_incomeRows == null)
         {
            return;
         }
         var scroll:Number = Number(_incomeRows.verticalScrollPosition);
         _incomeRows.removeChildren(0,-1,true);
         _incomeButtons = new Dictionary(true);
         if(_incomeStatus != null && _incomeLoaded)
         {
            _incomeStatus.text = "";
         }
         var u:Number = uiUnit();
         var width:Number = _incomeRows.width - 14 * u;
         var iconNames:Array = ["tutorial","dailygift","achievements","marketplace","hcpayday","levelprogression","roombundle","bonusbag","donations","surprise","snowstorm","games","chests","rpgs"];
         var i:int = 0;
         while(i < _incomeNames.length)
         {
            var summary:Object = incomeSummary(i);
            var row:Object = uiGroup(width,54 * u,12964314);
            var nameWidth:Number = width * 0.43;
            var claimWidth:Number = width * 0.18;
            var nameCell:Object = uiGroup(nameWidth,54 * u,15462129);
            row.addChild(nameCell);
            var icon:Object = uiIcon("earnings_icon_" + iconNames[i],34 * u);
            icon.x = 10 * u;
            icon.y = (row.height - icon.height) / 2;
            nameCell.addChild(icon);
            var title:Object = uiText(String(_incomeNames[i]),22,1713966);
            title.x = 52 * u;
            title.y = 13 * u;
            title.maxWidth = nameWidth - 60 * u;
            nameCell.addChild(title);
            var rewardX:Number = nameWidth + 14 * u;
            if(int(summary.duckets) > 0)
            {
               rewardX = incomeAmount(row,"currency_duckets",int(summary.duckets),rewardX,18 * u);
            }
            if(int(summary.credits) > 0)
            {
               rewardX = incomeAmount(row,"currency_credits",int(summary.credits),rewardX,18 * u);
            }
            if(int(summary.products) > 0)
            {
               var gift:Object = uiText(localText("Presente disponível"),18,1713966);
               gift.x = rewardX;
               gift.y = 17 * u;
               gift.maxWidth = width - claimWidth - rewardX - 12 * u;
               row.addChild(gift);
            }
            var claim:Object = button(_incomePending[i] === true ? localText("Resgatando…") : localText("Resgatar"),claimIncome);
            claim.styleNameList.remove("alternate-blue-button");
            claim.validate();
            claim.minWidth = claim.minHeight = 0;
            claim.isEnabled = _incomeLoaded && Boolean(summary.available) && _incomePending[i] !== true;
            claim.width = claimWidth;
            claim.height = 50 * u;
            claim.x = width - claimWidth;
            claim.y = 2 * u;
            var F:Class = klass("flash.text::TextFormat");
            claim.defaultLabelProperties.textFormat = new F("Ubuntu",22 * u,16777215);
            row.addChild(claim);
            _incomeButtons[claim] = i;
            _incomeRows.addChild(row);
            i++;
         }
         _incomeRows.validate();
         _incomeRows.verticalScrollPosition = scroll;
      }
      
      public static function claimIncome(event:Object) : void
      {
         var value:Object = _incomeButtons[event.currentTarget];
         if(value == null || _accountConnection == null)
         {
            return;
         }
         var category:int = int(value);
         if(_incomePending[category] === true || !incomeSummary(category).available)
         {
            return;
         }
         _incomePending[category] = true;
         event.currentTarget.isEnabled = false;
         event.currentTarget.label = localText("Resgatando…");
         var C:Class = klass("loginpatch::IncomeClaimPayload");
         _accountConnection.send(new C(category));
      }
      
      public static function encodeIncomeClaim(header:int, payload:Array) : Object
      {
         if(header != _incomeClaimRequest)
         {
            return null;
         }
         if(payload == null || payload.length != 1 || int(payload[0]) < 0 || int(payload[0]) > 13)
         {
            throw new ArgumentError("Invalid income claim category");
         }
         var B:Class = klass("flash.utils::ByteArray");
         var bytes:Object = new B();
         sent(header);
         bytes.writeInt(3);
         bytes.writeShort(header);
         bytes.writeByte(int(payload[0]));
         return bytes;
      }
      
      private static function resetAccountState() : void
      {
         closeAccountPanel(null);
         _accountUi = null;
         _accountConnection = null;
         _incomeRewards = [];
         _incomePending = {};
         _incomeLoaded = false;
         _eventListRequests = new Dictionary(true);
         _creditReady = new Dictionary(true);
         _creditsRequests = new Dictionary(true);
         _extraBalances = {};
      }
      
      private static function uiUnit() : Number
      {
         return Math.max(0.65,Starling.current.stage.stageHeight / 720);
      }
      
      private static function uiGroup(width:Number, height:Number, color:uint = 0, background:Boolean = true) : Object
      {
         var G:Class = klass("_-2xS::LayoutGroup");
         var group:Object = new G();
         group.width = width;
         group.height = height;
         if(background)
         {
            var Q:Class = klass("starling.display::Quad");
            var skin:Object = new Q(width,height,color);
            skin.touchable = false;
            group.backgroundSkin = skin;
         }
         return group;
      }
      
      private static function uiText(text:String, size:Number, color:uint, bold:Boolean = false) : Object
      {
         var L:Class = klass("_-2xS::_-Fk");
         var F:Class = klass("flash.text::TextFormat");
         var item:Object = new L();
         item.validate();
         item.text = localText(text);
         item.wordWrap = false;
         item.touchable = false;
         item.textRendererProperties.textFormat = new F(bold ? "UbuntuBold" : "Ubuntu",size * uiUnit(),color);
         item.textRendererProperties.embedFonts = true;
         return item;
      }
      
      private static function uiIcon(name:String, size:Number) : Object
      {
         var texture:Object = _uiTextures[name];
         var I:Class = klass("starling.display::Image");
         if(texture == null)
         {
            var frame:Array = _uiFrames[name];
            if(frame == null)
            {
               throw new ArgumentError("Missing UI icon: " + name);
            }
            if(_uiAtlas == null)
            {
               var A:Class = klass("loginpatch::UiAtlas19");
               _uiAtlas = new A();
            }
            var B:Class = klass("flash.display::BitmapData");
            var R:Class = klass("flash.geom::Rectangle");
            var P:Class = klass("flash.geom::Point");
            var bitmap:Object = new B(frame[2],frame[3],true,0);
            bitmap.copyPixels(_uiAtlas.bitmapData,new R(frame[0],frame[1],frame[2],frame[3]),new P());
            var T:Class = klass("starling.textures::Texture");
            texture = T.fromBitmapData(bitmap,false,false,1);
            bitmap.dispose();
            _uiTextures[name] = texture;
         }
         var icon:Object = new I(texture);
         var scale:Number = size / Math.max(texture.width,texture.height);
         icon.scaleX = icon.scaleY = scale;
         icon.smoothing = "none";
         icon.touchable = false;
         return icon;
      }
      
      private static function incomeAmount(row:Object, iconName:String, amount:int, x:Number, y:Number) : Number
      {
         var u:Number = uiUnit();
         var icon:Object = uiIcon(iconName,24 * u);
         icon.x = x;
         icon.y = y;
         row.addChild(icon);
         var value:Object = uiText(String(amount),22,1713966);
         value.x = x + 30 * u;
         value.y = y - 2 * u;
         row.addChild(value);
         value.validate();
         return value.x + value.width + 16 * u;
      }
      
      public static function initCurrencyProtocol(silver:int, emerald:int) : void
      {
         _silverHeader = silver;
         _emeraldHeader = emerald;
      }
      
      public static function requestCredits(catalog:Object, force:Boolean = false) : void
      {
         if(catalog == null || catalog.communication == null || catalog.communication.connection == null)
         {
            return;
         }
         var connection:Object = catalog.communication.connection;
         var previous:Object = _creditsRequests[connection];
         var now:int = getTimer();
         if(previous != null && now - int(previous) < (force ? 1000 : 30000))
         {
            return;
         }
         _creditsRequests[connection] = now;
         var C:Class = klass("loginpatch::CreditsInfoPayload");
         connection.send(new C());
         var S:Class = klass("loginpatch::SilverInfoPayload");
         connection.send(new S());
      }
      
      public static function creditsArrived(purse:Object) : void
      {
         _creditReady[purse] = true;
      }
      
      private static function receiveExtraBalance(id:int, data:Object) : Boolean
      {
         if(id != _silverHeader && id != _emeraldHeader)
         {
            return false;
         }
         var value:int = int(data["_-0u0"]());
         _extraBalances[id == _silverHeader ? "silver" : "emerald"] = value;
         for(var widget:Object in _purseBars)
         {
            updateClassicPurse(widget);
         }
         return true;
      }
      
      public static function trackClassicPurse(widget:Object, ui:Object, credit:Object, seasonal:Object, seasonalIcon:Object, ducketIcon:Object) : void
      {
         var row:Object = credit.parent == null ? null : credit.parent.parent;
         if(row == null)
         {
            return;
         }
         _purseBars[widget] = {
            "ui":ui,
            "row":row,
            "credit":credit,
            "seasonal":seasonal,
            "seasonalIcon":seasonalIcon,
            "reference":ducketIcon,
            "extras":{}
         };
         updateClassicPurse(widget);
      }
      
      public static function classicCurrencyIcon(type:int) : String
      {
         var names:Object = {
            "0":"purse_ducket",
            "3":"purse_subscription",
            "5":"purse_dmd",
            "101":"purse_seasonal1",
            "102":"purse_seasonal2",
            "103":"purse_seasonal3",
            "104":"purse_seasonal4",
            "105":"purse_seasonal5"
         };
         return names[type] == null ? "purse_subscription" : String(names[type]);
      }
      
      private static function classicCurrencyCell(state:Object, key:String, asset:String, atlas:Boolean = false) : Object
      {
         var G:Class = klass("_-2xS::LayoutGroup");
         var H:Class = klass("_-0iC::_-0q9");
         var L:Class = klass("_-2xS::_-Fk");
         var I:Class = klass("_-2xS::_-1aX");
         var D:Class = klass("_-1N-::_-2mJ");
         var Theme:Class = klass("HitchTheme");
         var row:Object = new G();
         row.name = "-1";
         row.touchable = false;
         row.layout = new H();
         row.layout.paddingLeft = row.layout.paddingRight = D["_-17E"](40);
         row.layout.paddingTop = row.layout.paddingBottom = D["_-17E"](20);
         row.layout.gap = D["_-17E"](10);
         row.layout.verticalAlign = "middle";
         row.minWidth = row.minHeight = D["_-17E"](150);
         var icon:Object = new I();
         if(atlas)
         {
            state.reference.validate();
            var source:Object = uiIcon(asset,Math.max(16,Number(state.reference.height)));
            icon.source = source.texture;
            icon.height = source.height;
            icon.width = source.width;
            source.dispose();
         }
         else
         {
            icon.source = Theme.getTexture(asset);
         }
         row.addChild(icon);
         var value:Object = new L();
         value.styleNameList.add("LABEL_M_CONDENSED_LIGHT_BLUE");
         row.addChild(value);
         state.row.addChild(row);
         var result:Object = {
            "cell":row,
            "label":value,
            "icon":icon
         };
         state.extras[key] = result;
         return result;
      }
      
      public static function activeSeasonalTypes(provider:Object) : Array
      {
         var result:Array = [];
         if(provider == null || !provider.getBoolean("seasonalcurrencyindicator.enabled"))
         {
            return result;
         }
         var raw:String = provider.getProperty("seasonalcurrencyindicator.active");
         if(raw == null || raw == "")
         {
            raw = provider.getProperty("seasonalcurrencyindicator.currency");
         }
         if(raw == null || raw == "")
         {
            return result;
         }
         for each(var part:String in raw.split(","))
         {
            part = part.replace(/^\s+|\s+$/g,"");
            if(/^\d+$/.test(part))
            {
               var id:int = int(part);
               if(id >= 101 && id <= 105 && result.indexOf(id) < 0)
               {
                  result.push(id);
               }
            }
         }
         return result;
      }
      
      private static function setSeasonalIcon(icon:Object, provider:Object, type:int) : void
      {
         var name:String = provider.getProperty("seasonalcurrency.id." + type);
         var key:String = "seasonal_" + name;
         var builtins:Object = {
            "stars":"purse_seasonal3",
            "golden_fishes":"purse_seasonal1",
            "easter_eggs":"purse_seasonal2",
            "clouds":"purse_seasonal4"
         };
         if(builtins[name] != null)
         {
            var NativeTheme:Class = klass("HitchTheme");
            icon.source = NativeTheme.getTexture(String(builtins[name]));
            return;
         }
         if(_uiFrames[key] != null)
         {
            var picture:Object = uiIcon(key,24 * uiUnit());
            icon.source = picture.texture;
            icon.width = picture.width;
            icon.height = picture.height;
            picture.dispose();
         }
         else
         {
            var Theme:Class = klass("HitchTheme");
            icon.source = Theme.getTexture(classicCurrencyIcon(type));
         }
      }
      
      public static function updateClassicPurse(widget:Object) : void
      {
         var state:Object = _purseBars[widget];
         if(state == null || state.row == null)
         {
            return;
         }
         var purse:Object = state.ui.catalog["_-119"]();
         var points:Object = purse["_-vM"];
         var ids:Array = activeSeasonalTypes(state.ui);
         if(ids.length > 1)
         {
            ids = ids.slice(0,1);
         }
         state.credit.text = _creditReady[purse] ? String(purse.credits) : "…";
         for(var key:Object in state.extras)
         {
            state.extras[key].cell.visible = false;
            state.extras[key].cell.includeInLayout = false;
         }
         var seasonalCell:Object = state.seasonal == null ? null : state.seasonal.parent;
         if(seasonalCell != null)
         {
            seasonalCell.visible = seasonalCell.includeInLayout = ids.length > 0;
            if(ids.length > 0)
            {
               var first:int = int(ids.shift());
               state.seasonal.text = points[first] == null ? "…" : String(points[first]);
               setSeasonalIcon(state.seasonalIcon,state.ui,first);
            }
         }
         for each(var type:int in ids)
         {
            var pointKey:String = "points:" + type;
            var point:Object = state.extras[pointKey];
            if(point == null)
            {
               point = classicCurrencyCell(state,pointKey,classicCurrencyIcon(type));
            }
            setSeasonalIcon(point.icon,state.ui,type);
            point.label.text = points[type] == null ? "…" : String(points[type]);
            point.cell.visible = point.cell.includeInLayout = true;
         }
         var silver:Object = state.extras["silver"];
         if(silver == null)
         {
            silver = classicCurrencyCell(state,"silver","currency_silver",true);
         }
         silver.label.text = _extraBalances["silver"] == null ? "…" : String(_extraBalances["silver"]);
         silver.cell.visible = silver.cell.includeInLayout = true;
      }
      
      public static function createPurseBar(widget:Object, ui:Object) : void
      {
         var u:Number = uiUnit();
         var A:Class = klass("_-0iC::_-BX");
         var anchor:Object = new A();
         anchor.top = 14 * u;
         anchor.horizontalCenter = 0;
         widget.layoutData = anchor;
         widget.width = Starling.current.stage.stageWidth * 0.7;
         widget.height = 62 * u;
         var Q:Class = klass("starling.display::Quad");
         widget.backgroundSkin = new Q(widget.width,widget.height,660768);
         var content:Object = uiGroup(widget.width,widget.height,0,false);
         widget.addChild(content);
         _purseBars[widget] = {
            "ui":ui,
            "content":content
         };
         updatePurseBar(widget);
      }
      
      public static function purseBarAdded(widget:Object, ui:Object) : void
      {
         ui.catalog["_-0ik"](widget);
         updatePurseBar(widget);
         requestCredits(ui.catalog);
      }
      
      public static function clearPurseBar(widget:Object) : void
      {
         delete _purseBars[widget];
      }
      
      private static function purseBalances(ui:Object) : Array
      {
         var purse:Object = ui.catalog["_-119"]();
         var points:Object = purse["_-vM"];
         var result:Array = [{
            "key":"credits",
            "name":localText("Moedas"),
            "icon":"purse_credit",
            "value":(_creditReady[purse] ? String(purse.credits) : "…"),
            "action":1
         },{
            "key":"points:5",
            "name":localText("Diamantes"),
            "icon":"purse_dmd",
            "value":String(purse["_-4CK"](5)),
            "action":2
         },{
            "key":"points:0",
            "name":localText("Duckets"),
            "icon":"purse_ducket",
            "value":String(purse["_-4CK"](0)),
            "action":3
         }];
         var ids:Array = [];
         for(var key:Object in points)
         {
            if(int(key) != 0 && int(key) != 5 && int(points[key]) > 0)
            {
               ids.push(int(key));
            }
         }
         ids.sort(Array.NUMERIC);
         var icons:Object = {
            "3":"purse_subscription",
            "101":"purse_seasonal1",
            "102":"purse_seasonal2",
            "103":"purse_seasonal3",
            "104":"purse_seasonal4",
            "105":"purse_seasonal5"
         };
         for each(var id:int in ids)
         {
            result.push({
               "key":"points:" + id,
               "name":"Moeda " + id,
               "icon":(icons[id] == null ? "purse_subscription" : icons[id]),
               "value":String(points[id]),
               "action":0
            });
         }
         for each(var extra:String in ["silver","emerald"])
         {
            if(_extraBalances[extra] != null && int(_extraBalances[extra]) > 0)
            {
               result.push({
                  "key":extra,
                  "name":(extra == "silver" ? localText("Prata") : "Esmeraldas"),
                  "asset":"currency_" + extra,
                  "value":String(_extraBalances[extra]),
                  "action":0
               });
            }
         }
         var minutes:int = int(purse["_-0em"]);
         var hc:String = minutes <= 0 ? "0" : (minutes >= 1440 ? String(Math.ceil(minutes / 1440)) + " d" : String(Math.ceil(minutes / 60)) + " h");
         result.push({
            "key":"hc",
            "name":localText("HC"),
            "icon":"purse_hc",
            "value":hc,
            "action":4
         });
         result.push({
            "key":"bc",
            "name":localText("Arquiteto"),
            "icon":"purse_bc",
            "value":String(Math.max(0,Math.ceil(Number(ui.catalog["_-3R6"]) / 86400))) + " d",
            "action":5
         });
         return result;
      }
      
      public static function updatePurseBar(widget:Object) : void
      {
         var state:Object = _purseBars[widget];
         if(state == null)
         {
            return;
         }
         var content:Object = state.content;
         content.removeChildren(0,-1,true);
         var ui:Object = state.ui;
         var balances:Array = purseBalances(ui);
         var u:Number = uiUnit();
         widget.width = Starling.current.stage.stageWidth * 0.7;
         var count:int = int(balances.length);
         var columns:int = Math.min(7,count);
         var rows:int = Math.ceil(count / columns);
         var height:Number = rows == 1 ? 58 * u : 94 * u;
         widget.height = height;
         content.width = widget.width;
         content.height = height;
         if(widget.backgroundSkin != null)
         {
            widget.backgroundSkin.height = height;
         }
         var width:Number = (widget.width - 20 * u) / columns;
         var lineHeight:Number = (height - 12 * u) / rows;
         var i:int = 0;
         while(i < count)
         {
            var balance:Object = balances[i];
            var cell:Object = uiGroup(width,lineHeight,0,false);
            cell.name = String(balance.key);
            cell.x = 10 * u + i % columns * width;
            cell.y = 6 * u + int(i / columns) * lineHeight;
            if(balance.asset != null)
            {
               var icon:Object = uiIcon(String(balance.asset),24 * u);
            }
            else
            {
               var Theme:Class = klass("HitchTheme");
               var Image:Class = klass("starling.display::Image");
               icon = new Image(Theme.getTexture(String(balance.icon)));
               var scale:Number = 24 * u / Math.max(icon.width,icon.height);
               icon.scaleX = icon.scaleY = scale;
               icon.smoothing = "none";
               icon.touchable = false;
            }
            icon.x = 4 * u;
            icon.y = (lineHeight - icon.height) / 2;
            cell.addChild(icon);
            var value:Object = uiText(String(balance.value),18,16777215);
            value.x = 34 * u;
            value.y = (lineHeight - 24 * u) / 2;
            value.maxWidth = width - 38 * u;
            cell.addChild(value);
            if(int(balance.action) > 0)
            {
               cell.isQuickHitAreaEnabled = true;
               cell.addEventListener("touch",purseBarTouch);
               _purseClicks[cell] = {
                  "ui":ui,
                  "action":balance.action
               };
            }
            content.addChild(cell);
            i++;
         }
      }
      
      public static function purseBarTouch(event:Object) : void
      {
         var state:Object = _purseClicks[event.currentTarget];
         if(state == null)
         {
            return;
         }
         var touch:Object = event.getTouch(event.currentTarget,"ended");
         if(touch == null)
         {
            return;
         }
         var ui:Object = state.ui;
         switch(int(state.action))
         {
            case 1:
            case 2:
               ui.context.createLinkEvent("catalog/open/mobile_credits");
               break;
            case 3:
               ui.catalog["_-3BY"]("ducket_info","NORMAL");
               break;
            case 4:
               ui.context.createLinkEvent("openView/hccenter");
               break;
            case 5:
               ui.context.createLinkEvent("catalog/open/mobile_subscriptions");
         }
      }
      
      public static function isRecolorableOffer(offer:Object) : Boolean
      {
         return offer != null && offer.product != null && offer.product.furnitureData != null && String(offer.product.furnitureData["_-uZ"]).indexOf("_recolorable") >= 0;
      }
      
      public static function recolorPalette(catalog:Object, className:String) : Object
      {
         var mapping:String = catalog.getProperty("recolorable_bc.palette_to_furni");
         if(mapping == null || mapping == "")
         {
            mapping = _recolorMapping;
         }
         var palette:String = "default";
         for each(var entry:String in mapping.split(";"))
         {
            var parts:Array = entry.split("=");
            if(parts.length == 2 && String(parts[1]).split(",").indexOf(className) >= 0)
            {
               palette = String(parts[0]);
            }
         }
         var raw:String = catalog.getProperty("recolorable_bc.palette." + palette);
         if(raw == null || raw == "")
         {
            raw = String(_recolorDefaults[palette] == null ? _recolorDefaults["default"] : _recolorDefaults[palette]);
         }
         var colors:Array = [];
         for each(var hex:String in raw.split(","))
         {
            hex = hex.replace(/^\s+|\s+$/g,"");
            if(/^[0-9a-fA-F]{6}$/.test(hex))
            {
               colors.push(uint(parseInt(hex,16)));
            }
         }
         return {
            "name":palette,
            "colors":colors
         };
      }
      
      public static function recolorRGB(color:uint) : String
      {
         return [color >> 16 & 0xFF,color >> 8 & 0xFF,color & 0xFF].join(",");
      }
      
      public static function recolorStuffData(product:Object) : Object
      {
         if(product == null || product.furnitureData == null || String(product.furnitureData["_-uZ"]).indexOf("_recolorable") < 0)
         {
            return null;
         }
         var rgb:Array = String(product["_-2XU"]).split(",");
         if(rgb.length != 3)
         {
            return null;
         }
         for each(var component:String in rgb)
         {
            if(!/^\d{1,3}$/.test(component) || int(component) > 255)
            {
               return null;
            }
         }
         var M:Class = klass("_-44B::Map");
         var S:Class = klass("_-0VW::_-2yp");
         var data:Object = new M();
         data.add("state","0");
         data.add("r",rgb[0]);
         data.add("g",rgb[1]);
         data.add("b",rgb[2]);
         return new S(data);
      }
      
      public static function recolorPreviewResult(preview:Object, offer:Object, listener:Object) : Object
      {
         var V:Class = klass("_-0AB::Vector3d");
         return preview.roomEngine["_-1LW"](offer.product["_-1am"],new V(180),64,listener,0,"0",-1,-1,recolorStuffData(offer.product));
      }
      
      public static function showFurniturePalette(content:Object, host:Object, image:Object, preview:Object, offer:Object) : void
      {
         clearFurniturePalette(content);
         if(!isRecolorableOffer(offer) || String(offer.product["_-4Xb"]) != "s")
         {
            return;
         }
         var palette:Object = recolorPalette(preview.catalog,String(offer.product.furnitureData["_-uZ"]));
         if(palette.colors.length == 0)
         {
            return;
         }
         image.validate();
         var originalGlow:Object = image.getChildAt(0);
         var u:Number = uiUnit();
         var panel:Object = uiGroup(1,1,1121093);
         host.addChild(panel);
         var title:Object = uiText(localText("Cor do mobi"),18,16777215,true);
         panel.addChild(title);
         var S:Class = klass("_-2xS::_-4Mu");
         var scroll:Object = new S();
         scroll.layout = null;
         scroll.horizontalScrollPolicy = "off";
         scroll.verticalScrollPolicy = "on";
         scroll.scrollBarDisplayMode = "fixed";
         scroll.clipContent = true;
         panel.addChild(scroll);
         var state:Object = {
            "content":content,
            "host":host,
            "image":image,
            "preview":preview,
            "offer":offer,
            "panel":panel,
            "title":title,
            "scroll":scroll,
            "palette":palette,
            "buttons":[],
            "color":0,
            "width":0,
            "height":0,
            "oldLayout":image.layoutData,
            "oldWidth":image.width,
            "oldHeight":image.height,
            "oldGlowWidth":originalGlow.width,
            "oldGlowHeight":originalGlow.height
         };
         _recolorViews[content] = state;
         for each(var color:uint in palette.colors)
         {
            var pick:Object = button("",chooseFurnitureColor);
            pick.styleNameList.remove("alternate-blue-button");
            var skin:Object = uiGroup(44 * u,44 * u,2633790);
            var Q:Class = klass("starling.display::Quad");
            var face:Object = new Q(36 * u,36 * u,color);
            face.x = face.y = 4 * u;
            face.touchable = false;
            skin.addChild(face);
            var cell:Object = {
               "button":pick,
               "skin":skin,
               "color":color,
               "state":state
            };
            state.buttons.push(cell);
            _recolorSwatches[pick] = cell;
            pick.addEventListener("addedToStage",furnitureSwatchAdded);
            scroll.addChild(pick);
            installFurnitureSwatch(cell);
         }
         layoutFurniturePalette(content);
         var selected:Number = _recolorRecent[palette.name] == null ? Number(palette.colors[0]) : Number(_recolorRecent[palette.name]);
         var rgb:Array = String(offer.product["_-2XU"]).split(",");
         if(rgb.length == 3)
         {
            selected = int(rgb[0]) << 16 | int(rgb[1]) << 8 | int(rgb[2]);
         }
         if(palette.colors.indexOf(uint(selected)) < 0)
         {
            selected = Number(palette.colors[0]);
         }
         applyFurnitureColor(state,uint(selected));
      }
      
      public static function layoutFurniturePalette(content:Object) : void
      {
         var state:Object = _recolorViews[content];
         if(state == null)
         {
            return;
         }
         var u:Number = uiUnit();
         var w:Number = Math.min(Starling.current.stage.stageWidth * 0.47,650 * u);
         var h:Number = Number(state.host.height);
         if(isNaN(h) || h < 300 * u)
         {
            h = Starling.current.stage.stageHeight - 60 * u;
         }
         if(state.width == w && state.height == h)
         {
            return;
         }
         state.width = w;
         state.height = h;
         var A:Class = klass("_-0iC::_-BX");
         var imageHeight:Number = Math.max(180 * u,h - 242 * u);
         state.image.layoutData = new A(36 * u,NaN,NaN,18 * u);
         state.image.width = w;
         state.image.height = imageHeight;
         var glow:Object = state.image.getChildAt(0);
         glow.width = w;
         glow.height = imageHeight;
         var panel:Object = state.panel;
         panel.x = 18 * u;
         panel.y = 36 * u + imageHeight + 8 * u;
         panel.width = w;
         panel.height = 170 * u;
         panel.backgroundSkin.width = w;
         panel.backgroundSkin.height = panel.height;
         state.title.x = 12 * u;
         state.title.y = 6 * u;
         var scroll:Object = state.scroll;
         scroll.x = 8 * u;
         scroll.y = 34 * u;
         scroll.width = w - 16 * u;
         scroll.height = panel.height - 42 * u;
         var columns:int = Math.max(1,int((scroll.width - 24 * u) / (48 * u)));
         var i:int = 0;
         while(i < state.buttons.length)
         {
            var pick:Object = state.buttons[i].button;
            pick.width = pick.height = 44 * u;
            pick.x = i % columns * 48 * u;
            pick.y = int(i / columns) * 48 * u;
            i++;
         }
         scroll.readjustLayout();
      }
      
      private static function installFurnitureSwatch(cell:Object) : void
      {
         var pick:Object = cell.button;
         pick.validate();
         pick.stateToSkinFunction = null;
         pick.defaultSkin = cell.skin;
         pick.downSkin = cell.skin;
         pick.minWidth = pick.minHeight = 0;
         pick.padding = 0;
         pick.validate();
      }
      
      public static function furnitureSwatchAdded(event:Object) : void
      {
         var cell:Object = _recolorSwatches[event.currentTarget];
         if(cell != null)
         {
            installFurnitureSwatch(cell);
         }
      }
      
      public static function chooseFurnitureColor(event:Object) : void
      {
         var cell:Object = _recolorSwatches[event.currentTarget];
         if(cell != null)
         {
            applyFurnitureColor(cell.state,uint(cell.color));
         }
      }
      
      private static function applyFurnitureColor(state:Object, color:uint) : void
      {
         if(state.palette.colors.indexOf(color) < 0)
         {
            return;
         }
         state.color = color;
         _recolorRecent[state.palette.name] = color;
         state.offer.product["_-2XU"] = recolorRGB(color);
         for each(var cell:Object in state.buttons)
         {
            cell.skin.backgroundSkin.color = uint(cell.color) == color ? 16777215 : 2633790;
         }
         state.image.showOffer(state.offer);
      }
      
      public static function furniturePurchaseParameters(content:Object) : String
      {
         var state:Object = _recolorViews[content];
         return state == null ? "" : String(state.offer.product["_-2XU"]);
      }
      
      public static function clearFurniturePalette(content:Object) : void
      {
         var state:Object = _recolorViews[content];
         if(state == null)
         {
            return;
         }
         for each(var cell:Object in state.buttons)
         {
            delete _recolorSwatches[cell.button];
            cell.button.removeEventListener("triggered",chooseFurnitureColor);
            cell.button.removeEventListener("addedToStage",furnitureSwatchAdded);
         }
         state.panel.removeFromParent(true);
         state.image.layoutData = state.oldLayout;
         state.image.width = state.oldWidth;
         state.image.height = state.oldHeight;
         if(state.image.numChildren > 0)
         {
            var glow:Object = state.image.getChildAt(0);
            glow.width = state.oldGlowWidth;
            glow.height = state.oldGlowHeight;
         }
         delete _recolorViews[content];
      }
      
      public static function legacyLogicType(type:String) : String
      {
         return type == "furniture_recolorable" ? "furniture_multistate" : type;
      }
      
      public static function legacyVisualizationType(type:String) : String
      {
         return type == "furniture_recolorable" ? "furniture_animated" : type;
      }
      
      public static function recolorLayer(object:Object, tag:String) : int
      {
         if(object == null || String(object.getType()).indexOf("_recolorable") == -1 || tag != "recolorable")
         {
            return -1;
         }
         var model:Object = object.getModel();
         var data:Object = model.getStringToStringMap("furniture_data");
         if(data == null)
         {
            return 16777215;
         }
         var red:Object = data.getValue("r");
         var green:Object = data.getValue("g");
         var blue:Object = data.getValue("b");
         if(red != null && green != null && blue != null)
         {
            return (int(red) & 0xFF) << 16 | (int(green) & 0xFF) << 8 | int(blue) & 0xFF;
         }
         var color:Object = data.getValue("color");
         if(color == null)
         {
            color = data.getValue("color1");
         }
         if(color == null)
         {
            color = data.getValue("rgb");
         }
         if(color == null)
         {
            return 16777215;
         }
         var text:String = String(color);
         var radix:int = 10;
         if(text.indexOf("#") == 0)
         {
            text = text.substr(1);
            radix = 16;
         }
         else if(text.indexOf("0x") == 0)
         {
            text = text.substr(2);
            radix = 16;
         }
         else if(/[a-fA-F]/.test(text))
         {
            radix = 16;
         }
         var value:Number = Number(parseInt(text,radix));
         return isNaN(value) ? 16777215 : int(value) & 0xFFFFFF;
      }
      
      public static function floorRoomId(actual:int, canvas:Object) : int
      {
         var id:int = int(klass("loginpatch::FloorEditor22").previewRoomFor(canvas));
         return id == 0 ? actual : id;
      }
      
      public static function floorPreviewRoom(room:int) : Boolean
      {
         return Boolean(klass("loginpatch::FloorEditor22").isPreviewRoom(room));
      }
      
      public static function floorLanguage() : String
      {
         return _hotelLanguage;
      }
      
      public static function floorAlert(title:String, message:String) : void
      {
         if(_controller != null)
         {
            _controller.alert(title,message);
         }
      }
      
      public static function floorPacket(kind:String, parser:Object) : void
      {
         var E:Class = klass("loginpatch::FloorEditor22");
         try
         {
            E.observe(kind,parser);
         }
         catch(error:Error)
         {
            E.report(error);
         }
      }
      
      public static function openFloorEditor(context:Object) : void
      {
         var L:Class;
         var E:Class = klass("loginpatch::FloorEditor22");
         try
         {
            E.open(context);
         }
         catch(error:Error)
         {
            E.close();
            L = klass("loginpatch::FloorStrings22");
            floorAlert(String(L.getText(_hotelLanguage,"floorplaneditor.title")),String(L.getText(_hotelLanguage,"floor22.openError")) + " (" + error.errorID + ")");
         }
      }
      
      public static function marketReturnRow25(data:Object, button:Object) : void
      {
         if(data == null || button == null)
         {
            return;
         }
         var allowed:Boolean = int(data.status) != 2;
         button.visible = allowed;
         button.includeInLayout = allowed;
         button.isEnabled = allowed;
      }
      
      public static function afterMarketReturn25(logic:Object, event:Object) : void
      {
         if(logic == null || logic.disposed || event == null)
         {
            return;
         }
         var parser:Object = event.getParser();
         if(parser != null && Boolean(parser.success))
         {
            logic["_-2Zv"]();
         }
      }
      
      public static function initClient23(header:int) : void
      {
         klass("loginpatch::ClientFixes23").initialize(header);
      }
      
      public static function bindRoom23(engine:Object, room:int) : void
      {
         klass("loginpatch::ClientFixes23").bindRoom(engine,room);
         klass("loginpatch::AreaHide30").bindRoom(engine,room);
      }
      
      public static function dropRoom23(engine:Object, room:int) : void
      {
         klass("loginpatch::ClientFixes23").dropRoom(engine,room);
         klass("loginpatch::AreaHide30").dropRoom(engine,room);
         klass("loginpatch::RoomIdentity30").dropRoom(engine,room);
      }
      
      public static function applyVisibility23(object:Object, engine:Object, room:int) : void
      {
         klass("loginpatch::ClientFixes23").applyObject(object,engine,room);
         klass("loginpatch::AreaHide30").rememberObject(object,engine,room);
      }
      
      public static function applyWallVisibility32(object:Object, engine:Object, room:int) : void
      {
         klass("loginpatch::ClientFixes23").applyObject(object,engine,room,20);
      }
      
      public static function areaParser32(parser:Object) : void
      {
         klass("loginpatch::AreaHide30").captureParser32(parser);
      }
      
      public static function clipRoomPlanes32(parser:Object) : void
      {
         klass("loginpatch::AreaHide30").clipRoomPlanes32(parser);
      }
      
      public static function visibilityChanged23(visualization:Object, object:Object) : Boolean
      {
         return klass("loginpatch::ClientFixes23").visibilityChanged(visualization,object);
      }
      
      public static function spriteAlpha23(alpha:int, object:Object, sprite:Object) : int
      {
         return klass("loginpatch::ClientFixes23").spriteAlpha(alpha,object,sprite);
      }
      
      public static function spriteCapture23(capture:int, object:Object, sprite:Object) : int
      {
         return klass("loginpatch::ClientFixes23").spriteCapture(capture,object,sprite);
      }
      
      public static function decodeNews23(value:String, html:Boolean = false) : String
      {
         return klass("loginpatch::ClientFixes23").decodeNews(value,html);
      }
      
      public static function planFurnitureCache23(collections:Object, libraries:Object, placeholders:Array) : void
      {
         klass("loginpatch::ClientCache23").planFurniture(collections,libraries,placeholders);
      }
      
      public static function releaseFurnitureCache23(collection:Object) : Boolean
      {
         return klass("loginpatch::ClientCache23").releaseFurniture(collection);
      }
      
      public static function planAvatarCache23(libraries:Object) : void
      {
         klass("loginpatch::ClientCache23").planAvatars(libraries);
      }
      
      public static function releaseAvatarCache23(library:Object) : Boolean
      {
         return klass("loginpatch::ClientCache23").releaseAvatar(library);
      }
      
      public static function touchAvatarCache23(library:Object, inUse:Boolean) : void
      {
         if(inUse)
         {
            klass("loginpatch::ClientCache23").touchAvatar(library);
         }
      }
      
      public static function forceCache23(force:Boolean) : void
      {
         klass("loginpatch::ClientCache23").force(force);
      }
      
      public static function logicClass30(type:String, fallback:Class) : Class
      {
         return type == "furniture_area_hide" ? klass("loginpatch::AreaHideLogic30") : fallback;
      }
      
      public static function initAreaHide30(header:int) : void
      {
         klass("loginpatch::AreaHide30").initialize(header);
      }
      
      public static function areaFloorMap30(parser:Object, wrapper:Object) : void
      {
         klass("loginpatch::AreaHide30").floorMap(parser,wrapper);
      }
      
      public static function areaRoomReady30(engine:Object, room:int) : void
      {
         klass("loginpatch::AreaHide30").applyRoomMasks(engine,room);
      }
      
      public static function roomUser30(engine:Object, room:int, webId:int, index:int, userType:int) : void
      {
         klass("loginpatch::RoomIdentity30").seen(engine,room,webId,index,userType);
      }
      
      private static function canManageAreaHide30() : Boolean
      {
         if(_hideObject == null || _roomEngine == null || int(_roomEngine["_-0Y"]) != _hideRoom)
         {
            return false;
         }
         if(_roomEngine["_-46h"](_hideRoom,int(_hideObject.getId()),10) !== _hideObject)
         {
            return false;
         }
         var session:Object = _roomEngine["_-4Ej"].getSession(_hideRoom);
         return session != null && !session.disposed && (Boolean(session["_-0lf"]) || Boolean(session["_-1Ti"]));
      }
      
      public static function openAreaHide30(object:Object) : void
      {
         if(object == null || _roomCanvas == null || _roomEngine == null || String(object.getType()).indexOf("conf_area_hide") != 0)
         {
            return;
         }
         endRoomEditors();
         _hideObject = object;
         _hideRoom = int(_roomEngine["_-0Y"]);
         if(!canManageAreaHide30())
         {
            _hideObject = null;
            _hideRoom = -1;
            return;
         }
         var model:Object = object.getModel();
         _hideOn = int(object.getState(0)) != 0;
         _hideBusy = false;
         _modernInfo = {"ints":[int(model.getNumber("furniture_area_hide_root_x")),int(model.getNumber("furniture_area_hide_root_y")),int(model.getNumber("furniture_area_hide_width")),int(model.getNumber("furniture_area_hide_length"))]};
         var root:Object = panel();
         root.name = "areaHidePanel30";
         addLabel(root,tr("furni.name.conf_area_hide","Ocultador de área"));
         _hideToggle = button("",toggleAreaHide30);
         root.addChild(_hideToggle);
         _hideStatus = addLabel(root,"");
         var Scroll:Class = klass("_-2xS::_-4Mu");
         var Vertical:Class = klass("_-0iC::_-pG");
         var body:Object = new Scroll();
         body.layout = new Vertical();
         body.layout.gap = 10;
         body.width = root.width - 28;
         body.height = Math.max(160,Starling.current.stage.stageHeight * 0.78 - 150);
         body.horizontalScrollPolicy = "off";
         body.verticalScrollPolicy = "auto";
         root.addChild(body);
         var labels:Array = [localText("Ocultar este mobi com o Controlador de mobis invisíveis"),tr("widget.areahide.wallitems_txt","Ocultar itens de parede"),tr("widget.areahide.invert_txt","Inverter área")];
         var fields:Array = ["furniture_area_hide_invisibility","furniture_area_hide_wallitems","furniture_area_hide_invert"];
         _hideChecks = [];
         var i:int = 0;
         while(i < 3)
         {
            var check:Object = makeCheck(body,labels[i],int(model.getNumber(fields[i])) == 1);
            check.width = body.width - 16;
            check.defaultLabelProperties.wordWrap = true;
            check.addEventListener("change",saveAreaHide30);
            _hideChecks.push(check);
            i++;
         }
         _hideContent = column(8);
         body.addChild(_hideContent);
         var U:Class = klass("_-2YJ::_-0iF");
         var row:Object = U["_-4fM"](10);
         _hideSave = button(localText("Salvar"),saveAreaHide30);
         row.addChild(_hideSave);
         row.addChild(button(localText("Fechar"),closeAreaHide30));
         root.addChild(row);
         _wiredPopup = root;
         _editorRoom = _hideRoom;
         root.addEventListener("enterFrame",editorFrame);
         refreshAreaHide30();
         presentPanel(root);
      }
      
      private static function refreshAreaHide30() : void
      {
         if(_hideObject == null || _hideToggle == null)
         {
            return;
         }
         _hideToggle.label = _hideOn ? tr("widget.areahide.button.off","Desligar") : tr("widget.areahide.button.on","Ligar");
         _hideToggle.isEnabled = !_hideBusy;
         for each(var check:Object in _hideChecks)
         {
            check.isEnabled = !_hideOn && !_hideBusy;
         }
         if(_hideSave != null)
         {
            _hideSave.isEnabled = !_hideOn && !_hideBusy;
         }
         if(_hideOn)
         {
            if(_areaActive)
            {
               endArea();
            }
            _hideContent.removeChildren(0,-1,true);
            addLabel(_hideContent,localText("Desligue o ocultador para editar a área."));
         }
         else if(!_areaActive)
         {
            _hideContent.removeChildren(0,-1,true);
            beginArea(_hideContent);
         }
         _hideStatus.text = _hideBusy ? localText("Aguardando resposta do quarto...") : (_hideOn ? localText("Ocultador ligado") : localText("Ocultador desligado"));
      }
      
      public static function areaHideState30(id:int, on:Boolean) : void
      {
         if(_hideObject == null || int(_hideObject.getId()) != id)
         {
            return;
         }
         _hideOn = on;
         _hideBusy = false;
         refreshAreaHide30();
      }
      
      public static function saveAreaHide30(event:Object) : void
      {
         if(!canManageAreaHide30() || _hideOn || _hideBusy || _modernInfo == null || _activeConnection == null)
         {
            return;
         }
         var values:Array = _modernInfo.ints;
         var C:Class = klass("loginpatch::AreaHidePayload30");
         var sent:Boolean = Boolean(_activeConnection.send(new C(int(_hideObject.getId()),int(values[0]),int(values[1]),int(values[2]),int(values[3]),Boolean(_hideChecks[0].isSelected),Boolean(_hideChecks[1].isSelected),Boolean(_hideChecks[2].isSelected))));
         if(_hideStatus != null)
         {
            _hideStatus.text = sent ? localText("Configuração enviada.") : localText("Não foi possível enviar a configuração.");
         }
      }
      
      public static function toggleAreaHide30(event:Object) : void
      {
         if(!canManageAreaHide30() || _hideBusy || _activeConnection == null)
         {
            return;
         }
         if(!_hideOn)
         {
            saveAreaHide30(null);
         }
         var C:Class = klass("_-3eU::_-3D8");
         _hideBusy = Boolean(_activeConnection.send(new C(int(_hideObject.getId()))));
         _hideToggleAt = getTimer();
         refreshAreaHide30();
      }
      
      public static function closeAreaHide30(event:Object) : void
      {
         endRoomEditors();
      }
   }
}

