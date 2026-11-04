import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;
import com.jpexs.decompiler.flash.abc.avm2.*;
import com.jpexs.decompiler.flash.abc.avm2.instructions.*;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.tags.*;
import com.jpexs.helpers.ByteArrayRange;

class PatchOldLogin {
  static ABC abc;
  static final String DEMO = "com.sulake.habbo.communication.demo:HabboCommunicationDemo";
  static final String SCREEN = "com.sulake.habbo.communication.demo.view.screen:LoginScreen";
  static final String BASE = "com.sulake.habbo.communication.demo.view.screen:LoginFlowScreenBase";
  static final String UNIQUE = "com.sulake.habbo.communication.messages.outgoing.handshake:UniqueIDMessageComposer";
  static final String HELLO = "com.sulake.habbo.communication.messages.outgoing.handshake:ClientHelloMessageComposer";
  static final String INCOMING = "com.sulake.habbo.communication.demo:IncomingMessages";
  static final String SOCKET = "com.sulake.core.communication.connection:SocketConnection";
  static final String WIRE = "com.sulake.core.communication.wireformat:EvaWireFormat";
  static final String IGNORE = "com.sulake.habbo.session:IgnoredUsersManager";
  static final String IGNORE_LIST = "com.sulake.habbo.communication.messages.parser.users:IgnoredUsersMessageParser";
  static final String IGNORE_RESULT = "com.sulake.habbo.communication.messages.parser.users:IgnoreResultMessageParser";
  static final String IGNORE_EVENT = "com.sulake.habbo.communication.messages.incoming.users:IgnoreResultMessageEvent";
  static final String IGNORE_GET = "com.sulake.habbo.communication.messages.outgoing.users:GetIgnoredUsersMessageComposer";
  static final String IGNORE_ADD = "com.sulake.habbo.communication.messages.outgoing.users:IgnoreUserMessageComposer";
  static final String IGNORE_REMOVE = "com.sulake.habbo.communication.messages.outgoing.users:UnignoreUserMessageComposer";
  static final String USERS = "com.sulake.habbo.communication.messages.parser.room.engine:UsersMessageParser";
  static final String FRIEND = "com.sulake.habbo.communication.messages.incoming.friendlist:FriendData";
  static final String PEER = "com.sulake.habbo.widgets.actions:PeerActionsCtrl";
  static final String CATALOG = "com.sulake.habbo.tablet.catalog:HabboTabletCatalog";
  static final String CATALOG_VIEW = "com.sulake.habbo.tablet.catalog:CatalogViewController";
  static final String MESSAGE_CLASSES = "com.sulake.core.communication.messages:MessageClassManager";
  static final String IAP_PAGE = "com.sulake.habbo.tablet.catalog.viewer.controller.page:InAppPurchasePageControllerBase";
  static final String OFFER_DATA = "com.sulake.habbo.communication.messages.incoming.catalog:CatalogPageMessageOfferData";
  static final String ACHIEVEMENT_DATA = "com.sulake.habbo.communication.messages.incoming.inventory.achievements:AchievementData";
  static final String QUEST_DATA = "com.sulake.habbo.communication.messages.incoming.quest:QuestMessageData";
  static final String RECIPE_DATA = "com.sulake.habbo.communication.messages.parser.crafting:FurnitureProductItem";
  static final String CONSOLE_PARSER = "com.sulake.habbo.communication.messages.parser.friendlist:NewConsoleMessageMessageParser";
  static final String MESSENGER = "com.sulake.habbo.messenger:HabboTabletMessenger";
  static final String UI_INCOMING = "com.sulake.habbo.ui:IncomingMessages";
  static final String AVATAR_DETAILS = "com.sulake.habbo.profile.avatar.slot:AvatarDetailsSlot";
  static final String INVENTORY_UPDATE = "com.sulake.habbo.communication.messages.parser.inventory.furni:FurniListAddOrUpdateParser";
  static final String CHAT_COMMANDS = "com.sulake.habbo.chat.input:ChatCommands";
  static final String INVENTORY_INCOMING = "com.sulake.habbo.tablet.inventory:IncomingMessages";
  static final String WIRED_DATA = "com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.data:WiredData";
  static final String WIRED_ACTION = "com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.data:WiredActionData";
  static final String WIRED_TRIGGER = "com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.data:WiredTriggerData";
  static final String WIRED_COMPOSERS = "com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents:";
  static final String WIRED_CONTROL = "com.sulake.habbo.roomevents.userdefinedroomevents:WiredCtrl";
  static final String WIRED_VIEW = "com.sulake.habbo.roomevents.userdefinedroomevents:UserDefinedRoomEventsCtrl";
  static final String PREVIEW_BUTTONS = "com.sulake.habbo.tablet.catalog.preview.elements:CatalogPreviewButtons";

  static InstanceInfo instance(String original) {
    for (int ci=0;ci<abc.instance_info.size();ci++) {
      var inst=abc.instance_info.get(ci);
      if (inst.protectedNS != 0 && abc.constants.getNamespace(inst.protectedNS).getRawName(abc.constants).equals(original)) return inst;
      if (inst.protectedNS == 0) for(var trait : inst.instance_traits.traits) {
        var ns = abc.constants.getMultiname(trait.name_index).getNamespace(abc.constants);
        if(ns != null && ns.getRawName(abc.constants).equals(original)) return inst;
      }
      if (inst.protectedNS == 0) for(var trait : abc.class_info.get(ci).static_traits.traits) {
        var ns=abc.constants.getMultiname(trait.name_index).getNamespace(abc.constants);
        if(ns!=null && ns.getRawName(abc.constants).equals(original))return inst;
      }
    }
    throw new IllegalStateException("No class " + original);
  }

  static int member(String owner, String name) {
    for (var trait : instance(owner).instance_traits.traits) {
      if (abc.constants.getString(abc.constants.getMultiname(trait.name_index).name_index).equals(name)) return trait.name_index;
    }
    throw new IllegalStateException("No member " + owner + "." + name);
  }

  static MethodBody method(String owner, String name) {
    for (var trait : instance(owner).instance_traits.traits) {
      if (abc.constants.getString(abc.constants.getMultiname(trait.name_index).name_index).equals(name) && trait instanceof TraitMethodGetterSetter) return abc.findBody(((TraitMethodGetterSetter)trait).method_info);
    }
    throw new IllegalStateException("No method " + name);
  }

  static int publicName(String name) {
    int ns = abc.constants.getNamespaceId(Namespace.KIND_PACKAGE, "", 0, true);
    return abc.constants.addMultiname(Multiname.createQName(false, abc.constants.getStringId(name, true), ns));
  }

  static int helperName() {
    int ns = abc.constants.getNamespaceId(Namespace.KIND_PACKAGE, "loginpatch", 0, true);
    return abc.constants.addMultiname(Multiname.createQName(false, abc.constants.getStringId("HabboTicketLogin", true), ns));
  }

  static class Code {
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    Code op(int opcode, int... values) {
      out.write(opcode);
      for (int value : values) {
        do {int next = value & 127; value >>>= 7; out.write(value == 0 ? next : next | 128);} while(value != 0);
      }
      return this;
    }
    byte[] bytes() {return out.toByteArray();}
    Code field(String owner, String name) {return op(0xd0).op(0x66, member(owner, name));}
    Code branch(int opcode,int offset) {
      if(offset < -8388608 || offset > 8388607)throw new IllegalArgumentException("S24 overflow");
      out.write(opcode);out.write(offset&255);out.write((offset>>8)&255);out.write((offset>>16)&255);return this;
    }
  }

  static void replace(String owner, String name, Code code, int maxStack) {
    var body = method(owner, name);
    body.setCodeBytes(code.bytes());
    body.max_stack = maxStack;
    body.max_regs = Math.max(4, body.max_regs);
    body.exceptions = new ABCException[0];
    body.getCode();
    body.setModified();
    System.out.println("Replaced auth method " + name + " (" + code.bytes().length + " bytes)");
  }

  static void observe(String owner,String name,Code prefix,int maxStack) throws Exception {
    var body=method(owner,name);
    byte[] bytes=body.getCodeBytes();
    if(bytes.length<2 || bytes[0]!=(byte)0xd0 || bytes[1]!=0x30)throw new IllegalStateException("Unexpected observed method prologue "+name);
    for(var e:body.exceptions) {
      if(e.start<2 || e.end<2 || e.target<2)throw new IllegalStateException("Exception crosses observer prologue "+name);
      e.start+=prefix.bytes().length;e.end+=prefix.bytes().length;e.target+=prefix.bytes().length;
    }
    var out=new ByteArrayOutputStream();
    out.write(bytes,0,2);out.write(prefix.bytes());out.write(bytes,2,bytes.length-2);
    body.setCodeBytes(out.toByteArray());body.max_stack=Math.max(maxStack,body.max_stack);
    body.getCode();body.setModified();
  }

  static Code handled(Code condition) {
    // A true result consumes the legacy callback; false runs the original body.
    return condition.op(0x12,1,0,0).op(0x47);
  }

  static void beforeReturn(MethodBody body,Code addition,int maxStack) {
    var instructions=body.getCode().code;
    int at=instructions.size()-1;
    int ret=instructions.get(at).getBytes()[0]&255;
    if(ret==0x48) {
      at--;
      if((instructions.get(at).getBytes()[0]&255)!=0x26)throw new IllegalStateException("Expected final return true");
    } else if(ret!=0x47)throw new IllegalStateException("Expected final return");
    var temp=new MethodBody(abc,new Traits(),addition.bytes(),new ABCException[0]);
    body.insertAll(at,temp.getCode().code);
    body.max_stack=Math.max(body.max_stack,maxStack);
    body.setModified();
  }

  static void s24(byte[] bytes,int at,long offset) {
    if(offset < -8388608 || offset > 8388607)throw new IllegalStateException("S24 overflow");
    for(int i=0;i<3;i++)bytes[at+i]=(byte)(offset>>(8*i));
  }

  // Insert a complete block, preserving branches to its first instruction.
  // This also adjusts crossing jumps/switches and exception ranges, which a
  // raw splice into the middle of an AVM2 method would otherwise invalidate.
  static void insertInclusive(MethodBody body,int index,Code addition,int maxStack) throws Exception {
    var instructions=body.getCode().code;int at=(int)instructions.get(index).getAddress(),delta=addition.bytes().length;
    byte[] original=body.getCodeBytes(),amended=new byte[original.length+delta];
    System.arraycopy(original,0,amended,0,at);System.arraycopy(addition.bytes(),0,amended,at,delta);System.arraycopy(original,at,amended,at+delta,original.length-at);
    for(var ins:instructions) {
      int op=ins.getBytes()[0]&255;long from=ins.getAddress(),now=from>=at?from+delta:from;
      if(op>=0x0c&&op<=0x1a) {
        long target=from+ins.getBytes().length+ins.operands[0],newTarget=target>at?target+delta:target;
        s24(amended,(int)now+1,newTarget-now-ins.getBytes().length);
      } else if(op==0x1b) {
        long target=from+ins.operands[0],newTarget=target>at?target+delta:target;s24(amended,(int)now+1,newTarget-now);
        byte[] raw=ins.getBytes();int cursor=4;while((raw[cursor++]&128)!=0){}
        for(int j=2;j<ins.operands.length;j++,cursor+=3){target=from+ins.operands[j];newTarget=target>at?target+delta:target;s24(amended,(int)now+cursor,newTarget-now);}
      }
    }
    for(var ex:body.exceptions){if(ex.start>at)ex.start+=delta;if(ex.end>at)ex.end+=delta;if(ex.target>at)ex.target+=delta;}
    body.setCodeBytes(amended);body.max_stack=Math.max(body.max_stack,maxStack);body.getCode();body.setModified();body.getCode().checkValidOffsets(body);
  }

  static MethodBody constructor(String owner){return abc.findBody(instance(owner).iinit_index);}
  static int callIndex(MethodBody body,String name,int occurrence) {
    int seen=0;var code=body.getCode().code;
    for(int i=0;i<code.size();i++){var ins=code.get(i);int op=ins.getBytes()[0]&255;if((op==0x46||op==0x4f||op==0x66)&&name.equals(abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index))&&++seen==occurrence)return i;}
    throw new IllegalStateException("Missing call "+name+" #"+occurrence);
  }
  static Code readAndDrop(String name){return new Code().op(0xd1).op(0x46,publicName(name),0).op(0x29);}

  static void updateInventorySchemas() throws Exception {
    // The current update packet has a leading item count. The legacy parser
    // hardcodes one item, so it treats the count as an item ID and then tries
    // to read the remaining binary fields as UTF (EOF #2030 on pickup).
    var body=method(INVENTORY_UPDATE,"parse");var code=body.getCode().code;int at=-1;
    for(int i=0;i+1<code.size();i++)if((code.get(i).getBytes()[0]&255)==0x24&&code.get(i).operands[0]==1&&(code.get(i+1).getBytes()[0]&255)==0xd6){if(at!=-1)throw new IllegalStateException("Ambiguous inventory item count");at=i;}
    if(at<0)throw new IllegalStateException("Missing legacy inventory count");
    insertInclusive(body,at,new Code().op(0xd1).op(0x46,publicName("_-0u0"),0).op(0x73),2);
    // Do the instruction edit after the raw insertion; getCodeBytes retains
    // the original serialized body until save, so reversing these operations
    // would splice at an address from an already shortened instruction list.
    body.replaceInstruction(at+3,new AVM2Instruction(0,0x02,new int[0]));
    body.setModified();
    System.out.println("Inventory updates now consume their current item count, preserving the shared floor/wall item record and handling empty and batched updates");
  }

  static void updateRecordSchemas() throws Exception {
    // Only nested records need to consume their newly added suffixes: leaving
    // these bytes unread corrupts the next record in the same server message.
    // Top-level append-only messages remain compatible with the old getters.
    var achievement=constructor(ACHIEVEMENT_DATA);
    insertInclusive(achievement,achievement.getCode().code.size()-1,readAndDrop("readShort"),2);
    var recipe=constructor(RECIPE_DATA);
    insertInclusive(recipe,recipe.getCode().code.size()-1,readAndDrop("_-nr"),2);
    var quest=constructor(QUEST_DATA);Code seasonal=readAndDrop("_-0u0");
    Code extra=new Code().op(0xd1).op(0x46,publicName("readBoolean"),0).branch(0x12,seasonal.bytes().length);
    extra.out.write(seasonal.bytes());insertInclusive(quest,quest.getCode().code.size()-1,extra,2);
    var offer=constructor(OFFER_DATA);int giftRead=callIndex(offer,"readBoolean",2);
    if((offer.getCode().code.get(giftRead-1).getBytes()[0]&255)!=0xd1)throw new IllegalStateException("Unexpected offer reader");
    Code silver=new Code().op(0x60,helperName()).field(OFFER_DATA,"_-2h0").op(0xd1).op(0x46,publicName("_-0u0"),0).op(0x4f,publicName("rememberSilverOffer"),2);
    insertInclusive(offer,giftRead-1,silver,3);
    System.out.println("Adapted catalog silver field, achievement short state, conditional seasonal quest data and crafting recipe suffixes");
  }

  static Code copyGetter(MethodBody body,String property) {
    int i=callIndex(body,property,1);var code=body.getCode().code;
    if(i<1||(code.get(i-1).getBytes()[0]&255)!=0x60)throw new IllegalStateException("Unexpected optional-service receiver "+property);
    var out=new Code();out.out.writeBytes(code.get(i-1).getBytes());out.op(0x2a).branch(0x12,code.get(i).getBytes().length);out.out.writeBytes(code.get(i).getBytes());return out;
  }
  static void guardServiceAtEntry(String owner,String name,String property) throws Exception {
    var body=method(owner,name);Code guard=copyGetter(body,property).branch(0x11,1).op(0x47);
    insertInclusive(body,2,guard,2);
  }
  static void updateOptionalServices() throws Exception {
    // A missing legacy Web API session must not break display cleanup. Keep
    // all original superclass calls and view resets; skip absent-service work.
    var cleanup=method(IAP_PAGE,"disposeView");int end=callIndex(cleanup,"removeEventListener",1);
    int at=(int)cleanup.getCode().code.get(2).getAddress(),after=(int)(cleanup.getCode().code.get(end).getAddress()+cleanup.getCode().code.get(end).getBytes().length);
    Code cleanGuard=copyGetter(cleanup,"inAppPurchaser").branch(0x12,after-at);
    insertInclusive(cleanup,2,cleanGuard,2);
    var update=method(IAP_PAGE,"update");int getter=callIndex(update,"getInAppPurchaser",1);
    insertInclusive(update,getter-1,copyGetter(update,"getInAppPurchaser").branch(0x11,1).op(0x47),2);
    guardServiceAtEntry(IAP_PAGE,"_-4AR","getInAppPurchaser");
    for(String callback:new String[]{"_-2w9","_-nW","_-4OL"})guardServiceAtEntry(CATALOG_VIEW,callback,"getInAppPurchaser");
    guardServiceAtEntry("com.sulake.habbo.targetedoffers:TargetedOfferController","_-28f","inAppPurchaser");
    var hotlooks=method("com.sulake.habbo.avatareditor:HabboTabletAvatarEditor","_-2aZ");int hot=callIndex(hotlooks,"hotlooks",1);
    var receiver=hotlooks.getCode().code.get(hot-1);if((receiver.getBytes()[0]&255)!=0x60)throw new IllegalStateException("Unexpected hot-look session");
    insertInclusive(hotlooks,hot-1,new Code().op(0x60,receiver.operands[0]).branch(0x11,1).op(0x47),2);
    System.out.println("Protected remaining billing page cleanup/update/restore, delayed offer callbacks and legacy hot-look fetching");
  }

  static void updateComposerSchemas() throws Exception {
    for(String[] spec:new String[][]{
      {"com.sulake.habbo.communication.messages.outgoing.catalog:GetCatalogIndexComposer","catalog-index"},
      {"com.sulake.habbo.communication.messages.outgoing.catalog:BuildersClubPlaceRoomItemMessageComposer","builder-placement"},
      {"com.sulake.habbo.communication.messages.outgoing.catalog:BuildersClubPlaceWallItemMessageComposer","builder-placement"},
      {"com.sulake.habbo.communication.messages.outgoing.friendlist:SendMsgMessageComposer","private-chat"}
    }) {
      Code payload=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0x2c,abc.constants.getStringId(spec[1],true)).field(spec[0],spec[1].equals("private-chat")?"_-38i":"_-0SL").op(0x46,publicName("currentPayload"),2).op(0x48);
      replace(spec[0],"_-0tq",payload,3);
    }
    // The old catalog cannot display silver prices. Prevent an offer using
    // that new currency from being purchased under an incomplete old price.
    for(String name:new String[]{"send","_-El"}) {
      var body=method(SOCKET,name);
      Code guard=new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("blockUnsupportedPurchase"),1).branch(0x12,2).op(0x27).op(0x48);
      // These two methods have an obfuscation prelude before pushscope. Insert
      // only after its real getlocal0/pushscope pair, with an empty operand
      // stack, rather than assuming the first two instructions are a prologue.
      var instructions=body.getCode().code;int scope=-1;
      for(int i=0;i+1<instructions.size();i++)if((instructions.get(i).getBytes()[0]&255)==0xd0&&(instructions.get(i+1).getBytes()[0]&255)==0x30){scope=i+2;break;}
      if(scope<0)throw new IllegalStateException("Missing socket scope prologue");
      insertInclusive(body,scope,guard,2);
    }
    System.out.println("Updated catalog request, builder placement and private-chat payloads; guarded unrepresentable silver purchases");
  }

  static void updateSocialInteractions() throws Exception {
    // Enter is deliberately a keyboard-only action. Keep the original button
    // closure intact, and replace the separate Enter closure instead of sharing it.
    var motto=method(AVATAR_DETAILS,"_-23n");var code=motto.getCode().code;int enter=-1;
    for(int i=1;i<code.size();i++)if((code.get(i).getBytes()[0]&255)==0x40 && (code.get(i-1).getBytes()[0]&255)==0x2c && "enter".equals(abc.constants.getString(code.get(i-1).operands[0])))enter=code.get(i).operands[0];
    if(enter<0)throw new IllegalStateException("Missing motto Enter closure");
    var enterBody=abc.findBody(enter);
    enterBody.setCodeBytes(new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("dismissMottoKeyboard"),1).op(0x47).bytes());
    enterBody.exceptions=new ABCException[0];enterBody.max_stack=2;enterBody.getCode();enterBody.setModified();

    var parser=method(CONSOLE_PARSER,"parse");var instructions=parser.getCode().code;int last=instructions.size()-1;
    if((instructions.get(last).getBytes()[0]&255)!=0x48||(instructions.get(last-1).getBytes()[0]&255)!=0x26)throw new IllegalStateException("Unexpected console parser return");
    Code tail=new Code().op(0x60,helperName()).op(0xd0).op(0xd1).field(CONSOLE_PARSER,"_-9s").op(0x4f,publicName("readConsoleTail"),3);
    insertInclusive(parser,last-1,tail,4);

    // The UI adds sent messages locally. A positive confirmation is an ACK,
    // not an incoming bubble; sender ID also handles zero-confirmation echoes.
    // Check both live chats and the pre-messenger notification queue so an echo
    // cannot reappear later when the console is opened.
    for(String owner:new String[]{MESSENGER,UI_INCOMING}) {
      Code own=new Code().op(0x60,helperName()).op(0xd1).op(0x66,publicName("parser"));
      if(owner.equals(MESSENGER))own.field(owner,"_-32n");
      else own.field(owner,"_-2o8").op(0x66,publicName("sessionDataManager"));
      own.op(0x46,publicName("isOwnConsoleMessage"),2);
      observe(owner,"_-1B4",handled(own),3);
    }
    System.out.println("Motto Enter now only dismisses the keyboard without sending or closing the profile; console consumes current sender/confirmation fields and excludes outgoing ACKs from chats and notifications");
  }

  static void updateImmersiveWindow() throws Exception {
    MethodBody body=null;
    for(var inst:abc.instance_info)if(qname(abc,inst.name_index).equals("::HabboTabletMain"))for(var t:inst.instance_traits.traits)if(t instanceof TraitMethodGetterSetter&&"goFullScreen".equals(abc.constants.getString(abc.constants.getMultiname(t.name_index).name_index)))body=abc.findBody(((TraitMethodGetterSetter)t).method_info);
    if(body==null)throw new IllegalStateException("Missing native fullscreen handler");
    var instructions=body.getCode().code;int at=-1;
    for(int i=3;i+1<instructions.size();i++)if((instructions.get(i).getBytes()[0]&255)==0x2c&&"normal".equals(abc.constants.getString(instructions.get(i).operands[0])))at=i;
    if(at<0)throw new IllegalStateException("Missing windowed-mode reset");
    var nativeClass=instructions.get(at-3);var immerse=instructions.get(at-2);var stage=instructions.get(at-1);var display=instructions.get(at+1);
    if((nativeClass.getBytes()[0]&255)!=0x60||(immerse.getBytes()[0]&255)!=0x4f||(stage.getBytes()[0]&255)!=0x60||(display.getBytes()[0]&255)!=0x61||!"immersiveMode".equals(abc.constants.getString(abc.constants.getMultiname(immerse.operands[0]).name_index)))throw new IllegalStateException("Unexpected fullscreen sequence");
    // Set AIR's fullscreen window first, then request immersive system UI. The
    // previous order immediately reset AIR to NORMAL and could restore borders.
    Code replacement=new Code();replacement.out.writeBytes(stage.getBytes());replacement.op(0x2c,abc.constants.getStringId("fullScreenInteractive",true));replacement.out.writeBytes(display.getBytes());replacement.out.writeBytes(nativeClass.getBytes());replacement.out.writeBytes(immerse.getBytes());
    var fresh=new MethodBody(abc,new Traits(),replacement.bytes(),new ABCException[0]).getCode().code;
    if(fresh.size()!=5)throw new IllegalStateException("Unexpected fullscreen replacement size");
    for(int j=4;j>=0;j--){var ins=fresh.get(j);body.replaceInstruction(at-3+j,new AVM2Instruction(0,ins.getBytes()[0]&255,ins.operands.clone()));}
    body.setModified();body.getCode().checkValidOffsets(body);
    System.out.println("Fullscreen now establishes AIR's full window before immersive system UI, preserving activation and resize handling");
  }

  static void updateCommands() throws Exception {
    Code command=new Code().op(0x60,helperName()).op(0xd1).field(CHAT_COMMANDS,"_-4Fr").op(0x46,publicName("runCommand"),2).branch(0x12,2).op(0x26).op(0x48);
    observe(CHAT_COMMANDS,"_-3Ac",command,3);
    Code trade=new Code().op(0x60,helperName()).field(INVENTORY_INCOMING,"_-2kU").op(0x46,publicName("blockTrade"),1);
    observe(INVENTORY_INCOMING,"_-0tL",handled(trade),2);
    observe(INVENTORY_INCOMING,"_-2yq",new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("commandTradeState"),1),2);
    for(String name:new String[]{"send","_-El"}) {
      var body=method(SOCKET,name);var instructions=body.getCode().code;int scope=-1;
      for(int i=0;i+1<instructions.size();i++)if((instructions.get(i).getBytes()[0]&255)==0xd0&&(instructions.get(i+1).getBytes()[0]&255)==0x30){scope=i+2;break;}
      if(scope<0)throw new IllegalStateException("Missing socket scope for typing guard");
      Code typing=new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("blockTyping"),1).branch(0x12,2).op(0x26).op(0x48);
      insertInclusive(body,scope,typing,2);
    }
    System.out.println("Retained AFK/tradeblock/typing/friendhl commands; clone, dc and ping command hooks removed");
  }

  static void replaceConstructor(String owner,Code code,int stack) {
    var body=constructor(owner);body.setCodeBytes(code.bytes());body.max_stack=stack;
    body.max_regs=Math.max(body.max_regs,4);body.exceptions=new ABCException[0];body.getCode();body.setModified();
  }

  static void updateWired() throws Exception {
    Code data=new Code().op(0xd0).op(0x30).op(0xd0).op(0x49,0).op(0x60,helperName()).op(0xd1).op(0xd2).op(0x46,publicName("readWired"),2).op(0xd7);
    data.op(0xd0).op(0xd2).op(0x61,member(WIRED_DATA,"_-0q6"));
    for(String[] field:new String[][]{{"_-1zo","allowSelect"},{"_-1n4","limit"},{"_-4ii","ids"},{"_-U-","type"},{"_-1tQ","id"},{"_-4Jw","text"},{"_-0W3","ints"},{"_-2at","code"}})data.op(0xd0).op(0xd3).op(0x66,publicName(field[1])).op(0x61,member(WIRED_DATA,field[0]));
    data.op(0xd0).op(0x24,0).op(0x61,member(WIRED_DATA,"_-08o")).op(0x47);replaceConstructor(WIRED_DATA,data,3);
    Code action=new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0x2c,abc.constants.getStringId("effect",true)).op(0x49,2);
    action.op(0xd0).op(0x60,helperName()).op(0xd0).op(0x66,publicName("id")).op(0x46,publicName("wiredDelay"),1).op(0x61,member(WIRED_ACTION,"_-2XJ"));
    action.op(0xd0).op(0x56,0).op(0x61,member(WIRED_ACTION,"_-3xw")).op(0x47);replaceConstructor(WIRED_ACTION,action,3);
    Code trigger=new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0x2c,abc.constants.getStringId("trigger",true)).op(0x49,2).op(0xd0).op(0x56,0).op(0x61,member(WIRED_TRIGGER,"_-1Dt")).op(0x47);replaceConstructor(WIRED_TRIGGER,trigger,3);
    for(String[] spec:new String[][]{{"UpdateActionMessageComposer","effect"},{"UpdateConditionMessageComposer","condition"},{"UpdateTriggerMessageComposer","trigger"}})replace(WIRED_COMPOSERS+spec[0],"_-0tq",new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0x2c,abc.constants.getStringId(spec[1],true)).field(WIRED_COMPOSERS+spec[0],"_-38i").op(0x46,publicName("wiredPayload"),2).op(0x48),3);
    // Base controls don't edit these fields. Preserve the received values;
    // specialized text/parameter controls retain their existing overrides.
    replace(WIRED_CONTROL,"getIntParams",new Code().op(0xd0).op(0x30).field(WIRED_CONTROL,"_-0SL").op(0x66,publicName("intParams")).op(0x46,publicName("slice"),0).op(0x48),1);
    replace(WIRED_CONTROL,"getStringParam",new Code().op(0xd0).op(0x30).field(WIRED_CONTROL,"_-0SL").op(0x66,publicName("stringParam")).op(0x48),1);
    observe(WIRED_VIEW,"_-2rm",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("rememberWiredEditor"),1),2);
    // The modern editor does not use the old full-screen list, previews or
    // selection callbacks. Constructing that hidden tree still invokes old
    // controls with current definitions. Create it only on an explicit request
    // for the native furniture selector, never when opening a configuration.
    Code display=new Code().op(0xd0).op(0x30);
    display.op(0xd0).op(0x60,helperName()).op(0xd1).field(WIRED_VIEW,"_-2U8").op(0x20).op(0x20).field(WIRED_VIEW,"_-0K0").op(0xd0).op(0x46,publicName("modernWired"),6).op(0x80,instance(WIRED_CONTROL).name_index).op(0x61,member(WIRED_VIEW,"_-0K0")).op(0x47);
    replace(WIRED_VIEW,"_-26m",display,10);
    observe(WIRED_VIEW,"_-oI",new Code().op(0xd0).op(0x4f,member(WIRED_VIEW,"createView"),0),1);
    observe(WIRED_VIEW,"save",handled(new Code().op(0x60,helperName()).op(0x46,publicName("saveModernWired"),0)),2);
    var selected=method(WIRED_CONTROL,"_-3xY");
    // member lookup returns getter first; explicitly find the setter.
    for(var t:instance(WIRED_CONTROL).instance_traits.traits)if(t instanceof TraitMethodGetterSetter m && (t.kindType==3) && "_-3xY".equals(abc.constants.getString(abc.constants.getMultiname(t.name_index).name_index)))selected=abc.findBody(m.method_info);
    beforeReturn(selected,new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0x4f,publicName("pickedWiredFurniture"),2),3);
    Code intercept=new Code().op(0x60,helperName()).op(0xd1).op(0xd0).op(0x46,publicName("interceptWired"),2).branch(0x12,3).op(0x56,0).op(0x48);
    observe(SOCKET,"_-0lj",intercept,3);
    var view=method(WIRED_CONTROL,"createView");int slider=callIndex(view,"_-4gK",1),at=-1;
    for(int i=Math.max(0,slider-12);i<slider;i++){var ins=view.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x24&&ins.operands[0]==10){if(at!=-1)throw new IllegalStateException("Ambiguous Wired delay maximum");at=i;}}
    if(at<0)throw new IllegalStateException("Missing Wired delay maximum");
    Code max=new Code().op(0x60,helperName()).field(WIRED_CONTROL,"_-0SL").op(0x66,publicName("id")).op(0x46,publicName("wiredDelayMaximum"),1);
    insertInclusive(view,at,max,10);view.replaceInstruction(at+5,new AVM2Instruction(0,0x02,new int[0]));view.setModified();
    for(String name:new String[]{"send","_-El"}) {
      var body=method(SOCKET,name);var instructions=body.getCode().code;int scope=-1;
      for(int i=0;i+1<instructions.size();i++)if((instructions.get(i).getBytes()[0]&255)==0xd0&&(instructions.get(i+1).getBytes()[0]&255)==0x30){scope=i+2;break;}
      if(scope<0)throw new IllegalStateException("Missing socket scope for Wired guard");
      insertInclusive(body,scope,new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("blockWiredSave"),1).branch(0x12,2).op(0x27).op(0x48),2);
    }
    Code pending=new Code().op(0x60,helperName()).field(PREVIEW_BUTTONS,"_-ZD").op(0x66,publicName("catalog")).op(0x46,publicName("builderLimitPending"),1).branch(0x12,2).op(0x27).op(0x48);
    observe(PREVIEW_BUTTONS,"_-1bj",pending,2);
    System.out.println("Adapted Wired definition/save schemas, preserved advanced metadata and base controls, protected unsupported editor types; BC pending count now refreshes instead of reporting a false limit");
  }

  static void updateNavigatorAndHeight() throws Exception {
    String nav="com.sulake.habbo.tablet.navigator:NavigatorViewController";
    var body=method(nav,"_-1Lq");int at=-1;
    for(int i=0;i<body.getCode().code.size();i++){var ins=body.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x61 && "dataProvider".equals(abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index))){at=i-2;break;}}
    if(at<0)throw new IllegalStateException("Missing navigator menu provider");
    // ListCollection.addItemAt is obfuscated in this APK. Bind the actual
    // declared method instead of inventing a public property on a sealed class.
    Code item=new Code().op(0xd3).op(0x60,rawClass("_-4k::_-0GT")).op(0x2c,abc.constants.getStringId("Quartos com meus amigos",true)).op(0x60,rawClass("_-0It::_-0Ro")).op(0x42,0).op(0x42,2).op(0x24,2).op(0x4f,rawMember("_-1Ab::_-nO","_-0Fc"),2);
    insertInclusive(body,at,item,5);
    for(int i=0;i<body.getCode().code.size();i++){
      var ins=body.getCode().code.get(i);
      if((ins.getBytes()[0]&255)==0x2c && "${navigator.navibutton.1}".equals(abc.constants.getString(ins.operands[0])))body.replaceInstruction(i,new AVM2Instruction(0,0x2c,new int[]{abc.constants.getStringId("Todos os quartos",true)}));
    }
    String actions="com.sulake.habbo.tablet.room.widgets.furniture:ObjectActionsCtrl";
    // Resolved through raw QName below: the native Use menu and double-tap
    // both pass through the furniture logic's useObject implementation.
    String logic="com.sulake.habbo.room.object.logic.furniture:FurnitureLogic";
    var use=method(logic,"useObject");
    observe(logic,"useObject",handled(new Code().op(0x60,helperName()).op(0xd0).op(0x46,publicName("openStackHeight"),1)),2);
  }
  static void updateRoomEditors() throws Exception {
    String canvas="com.sulake.room.renderer:RoomSpriteCanvas3d";
    MethodBody setter=null;
    for(var t:instance(canvas).instance_traits.traits)if(t instanceof TraitMethodGetterSetter m && t.kindType==3 && "roomEngine".equals(abc.constants.getString(abc.constants.getMultiname(t.name_index).name_index)))setter=abc.findBody(m.method_info);
    if(setter==null)throw new IllegalStateException("Missing native canvas room-engine setter");
    beforeReturn(setter,new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0x4f,publicName("rememberRoomCanvas"),2),3);
    observe(canvas,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("disposeRoomCanvas"),1),2);
    observe("com.sulake.habbo.room.object.logic.room:RoomLogic","handleFloorTouchAtTileLocation",handled(new Code().op(0x60,helperName()).op(0xd1).op(0xd2).op(0xd3).op(0x62,4).op(0x46,publicName("areaTileHit"),4)),5);
    observe("com.sulake.habbo.ui:HabboUI","_-0-t",handled(new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("wiredUiEvent"),1)),2);
    observe(WIRED_VIEW,"close",new Code().op(0x60,helperName()).op(0x4f,publicName("wiredClosed"),0),1);
    var view=method(WIRED_CONTROL,"createView");
    // Synchronize the prior delay patch before inserting the new native view path.
    view.setCodeBytes(view.getCode().getBytes());view.getCode();
    Code assign=new Code().op(0xd0).op(0x2b).op(0x80,rawClass("_-2xS::LayoutGroup")).op(0x61,member(WIRED_CONTROL,"_-3lo")).op(0x47);
    Code content=new Code().op(0x60,helperName()).op(0xd0).op(0x46,publicName("modernWiredContent"),1).op(0x2a).branch(0x12,assign.bytes().length);
    content.out.writeBytes(assign.bytes());content.op(0x29);
    observe(WIRED_CONTROL,"createView",content,3);
    System.out.println("Added nonmodal room editors, real floor-plane touch probes, Wired lifecycle cleanup and native room-canvas capture");
  }
  static void updateFriendHighlightsAndTap() throws Exception {
    String fragments="com.sulake.habbo.communication.messages.parser.friendlist:FriendsListFragmentMessageParser";
    String updates="com.sulake.habbo.communication.messages.parser.friendlist:FriendListUpdateMessageParser";
    beforeReturn(method(fragments,"parse"),new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("friendsFragment"),1),3);
    beforeReturn(method(updates,"parse"),new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("friendsUpdated"),1),3);
    System.out.println("Added real-friend membership tracking; native single-tap behavior retained");
  }
  static void updateConsoleHistory() throws Exception {
    beforeReturn(constructor(MESSENGER),new Code().op(0x60,helperName()).op(0xd0).field(MESSENGER,"_-32n").op(0x66,publicName("userId")).op(0x4f,publicName("rememberMessenger"),2),3);
    observe(MESSENGER,"_-rR",new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("consoleConversationRemoved"),1),2);
    String slot="com.sulake.habbo.messenger.view:ConversationSlot";
    var setter=method(slot,"_-1iq");
    beforeReturn(setter,new Code().op(0x60,helperName()).field(slot,"_-1dL").op(0xd1).field(slot,"_-3v4").op(0x4f,publicName("consoleOpened"),3),4);
    observe(slot,"_-2Ga",handled(new Code().op(0x60,helperName()).op(0x46,publicName("insertingConsoleHistory"),0)),1);
    System.out.println("Added server-backed console history with cursor pagination, sender alignment, message-ID deduplication and scroll preservation");
  }
  static int rawMember(String raw,String name) {
    for(var inst:abc.instance_info)if(qname(abc,inst.name_index).equals(raw))for(var trait:inst.instance_traits.traits)
      if(abc.constants.getString(abc.constants.getMultiname(trait.name_index).name_index).equals(name))return trait.name_index;
    throw new IllegalStateException("Missing actual native member "+raw+"."+name);
  }
  static int rawClass(String raw) {
    for(var i:abc.instance_info)if(qname(abc,i.name_index).equals(raw))return i.name_index;
    throw new IllegalStateException("Missing class "+raw);
  }

  static void updateChatBubbles() throws Exception {
    String library="com.sulake.habbo.chat.discussion.viewer.visualization.style:ChatStyleLibrary";
    String bubble="com.sulake.habbo.chat.discussion.viewer.visualization:Bubble";
    beforeReturn(abc.findBody(instance(library).iinit_index),new Code().op(0x60,helperName()).field(library,"_-2Lt").op(0x4f,publicName("extendChatStyles"),1),2);

    // Keep the native link/text preparation, then assign a fresh TextFormat.
    // Mutating the shared style format did not invalidate the native renderer
    // and also leaked whisper/shout state between pooled bubbles.
    var text=method(bubble,"_-0Fe");int afterText=-1;
    for(int i=0;i<text.getCode().code.size();i++) {
      var ins=text.getCode().code.get(i);
      if((ins.getBytes()[0]&255)==0x61 && "text".equals(abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index))) {
        if(afterText!=-1)throw new IllegalStateException("Ambiguous native chat text assignment");
        afterText=(int)(ins.getAddress()+ins.getBytes().length);
      }
    }
    if(afterText<0 || text.exceptions.length!=0)throw new IllegalStateException("Missing native chat text boundary");
    Code format=new Code().op(0x60,helperName()).field(bubble,"_-1iK").field(bubble,"_-2Ov").field(bubble,"_-0rS").op(0x4f,publicName("formatRoomBubble"),3).op(0x47);
    var bytes=new ByteArrayOutputStream();bytes.write(text.getCode().getBytes(),0,afterText);bytes.write(format.bytes());
    text.setCodeBytes(bytes.toByteArray());text.max_stack=Math.max(text.max_stack,4);text.getCode();text.setModified();

    // Wired notifications are not necessarily attached to a live avatar.
    // Render them through the existing native bubble/background/icon/layout
    // path before its legacy user lookup can discard a system sender.
    Code display=new Code().op(0xd0).op(0x4f,member(bubble,"_-2TQ"),0)
      .op(0x60,helperName()).field(bubble,"_-1iK").field(bubble,"_-2Ov").field(bubble,"_-0rS").op(0x4f,publicName("renderNotification"),3)
      .op(0xd0).op(0x20).op(0x20).op(0x4f,member(bubble,"_-4Yw"),2)
      .op(0xd0).op(0x4f,member(bubble,"_-33X"),0)
      .op(0xd0).op(0x4f,member(bubble,"_-1mN"),0).op(0x26).op(0x48);
    Code intercept=new Code().op(0x60,helperName()).field(bubble,"_-0rS").op(0x66,publicName("style")).op(0x46,publicName("notificationChat"),1).branch(0x12,display.bytes().length);
    var prefix=new ByteArrayOutputStream();prefix.write(intercept.bytes());prefix.write(display.bytes());
    var body=method(bubble,"_-243");insertInclusive(body,2,new Code(){ {out.writeBytes(prefix.toByteArray());} },4);
    System.out.println("Extended native chat catalogue with exact reference assets; added gray italic whispers, isolated pooled text formats and avatar-independent rich Wired notifications");
  }

  static void updateRecolorableFurniture() throws Exception {
    String factory="com.sulake.habbo.room:RoomObjectFactory",visual="com.sulake.habbo.room.object:RoomObjectVisualizationFactory";
    observe(factory,"_-i-",new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("legacyLogicType"),1).op(0xd5),2);
    observe(visual,"_-1O7",new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("legacyVisualizationType"),1).op(0xd5),2);
    observe(visual,"_-1Vk",new Code().op(0x60,helperName()).op(0xd2).op(0x46,publicName("legacyVisualizationType"),1).op(0xd6),2);
    String rendering="com.sulake.habbo.room.object.visualization.furniture:FurnitureVisualization";
    int object=0;
    for(var ins:method(rendering,"updateModel").getCode().code)if(((ins.getBytes()[0]&255)==0x66 || (ins.getBytes()[0]&255)==0x60) && "_-3Cd".equals(abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index))){object=ins.operands[0];break;}
    if(object==0)throw new IllegalStateException("Missing visualization room object");
    Code color=new Code().op(0x60,helperName()).op(0xd0).op(0x66,object).op(0xd0).op(0xd1).op(0xd0).op(0x66,member(rendering,"direction")).op(0xd2).op(0x46,member(rendering,"getSpriteTag"),3).op(0x46,publicName("recolorLayer"),2).op(0x2a).op(0x24,0).branch(0x15,1).op(0x48).op(0x29);
    observe(rendering,"getSpriteColor",color,7);
    System.out.println("Added recolorable block/letter assets to native logic/visual factories with per-layer RGB rendering");
  }

  static void updateIgnoredUsers() throws Exception {
    // Current ignore lists and acknowledgements contain account IDs, not UTF
    // names. Consuming IDs as readUTF corrupts the record cursor and can cause
    // a fatal RangeError during the first post-authentication data burst.
    for(String owner:new String[]{IGNORE_LIST,IGNORE_RESULT}) {
      var body=method(owner,"parse");int replaced=0;
      for(int i=body.getCode().code.size()-1;i>=0;i--) {
        var ins=body.getCode().code.get(i);
        if((ins.getBytes()[0]&255)==0x46 && abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index).equals("_-nr")) {
          body.replaceInstruction(i,new AVM2Instruction(ins.getAddress(),0x46,new int[]{publicName("_-0u0"),0}));
          // Preserve the old acknowledgement's String getter ABI. The manager
          // converts this decimal ID back to int instead of treating it as a name.
          if(owner.equals(IGNORE_RESULT))body.insertInstruction(i+1,new AVM2Instruction(0,0x70,new int[0]));
          replaced++;
        }
      }
      if(replaced!=1)throw new IllegalStateException("Unexpected ignore parser schema "+owner+": "+replaced);
      body.setModified();
    }
    replace(IGNORE_GET,"_-0tq",new Code().op(0xd0).op(0x30).op(0x56,0).op(0x48),1);
    for(String owner:new String[]{IGNORE_ADD,IGNORE_REMOVE}) {
      var payload=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd0).field(owner,"_-38i").op(0x46,publicName("ignorePayload"),2).op(0x48);
      replace(owner,"_-0tq",payload,3);
    }
    Code result=new Code().op(0xd0).op(0x30).op(0x60,helperName()).field(IGNORE,"_-2Ex").op(0xd1).op(0x66,publicName("result")).op(0xd1).op(0x66,publicName("parser")).op(0x66,publicName("name")).op(0x73).op(0x4f,publicName("receiveIgnoreResult"),3).op(0x47);
    replace(IGNORE,"_-1Ww",result,4);
    Code eventName=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd0).op(0x66,publicName("parser")).op(0x66,publicName("name")).op(0x73).op(0x46,publicName("userNameForId"),1).op(0x48);
    replace(IGNORE_EVENT,"name",eventName,2);
    Code isIgnored=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd1).field(IGNORE,"_-2Ex").op(0x46,publicName("isIgnoredName"),2).op(0x48);
    replace(IGNORE,"_-0Uo",isIgnored,3);
    for(String method:new String[]{"_-1xR","_-2e4"})observe(IGNORE,method,handled(new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("blockUnknownIdentity"),1)),2);
    for(String method:new String[]{"_-2yB","_-Vf"}) {
      Code peer=new Code().op(0x60,helperName()).field(PEER,"_-RY").field(PEER,"_-2YW").op(0x4f,publicName("rememberUser"),2);
      peer.op(0x60,helperName()).field(PEER,"_-2YW").op(0x46,publicName("blockUnknownIdentity"),1);
      observe(PEER,method,handled(peer),3);
    }
    Code byId=new Code().op(0xd0).op(0x30).op(0x60,helperName()).field(IGNORE,"_-32n").op(0xd1).op(0x60,instance(IGNORE_ADD).name_index).op(0x4f,publicName("ignoreById"),3).op(0x47);
    replace(IGNORE,"_-KT",byId,4);
    beforeReturn(method(IGNORE,"_-tU"),new Code().op(0x60,helperName()).field(IGNORE,"_-2Ex").op(0x4f,publicName("noteIgnoredList"),1),2);

    // Keep the legacy name-based UI while using numeric IDs on the wire. Human
    // avatar records and friend records supply the identity cache; pets/bots
    // never populate it, and unresolved names are never sent as IDs.
    beforeReturn(method(USERS,"parse"),new Code().op(0x60,helperName()).field(USERS,"_-sH").op(0x4f,publicName("rememberRoomUsers"),1),2);
    beforeReturn(abc.findBody(instance(FRIEND).iinit_index),new Code().op(0x60,helperName()).field(FRIEND,"id").field(FRIEND,"name").op(0x4f,publicName("rememberUser"),2),3);
    observe(DEMO,"onCoreError",new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("coreError"),1),2);
    System.out.println("Adapted ignore list/result readers and legacy ignore UI to numeric IDs; added fatal-error source diagnostics");
  }

  static void guardCatalogListenerBlock(String methodName,String listenerOperation,int expected) throws Exception {
    var body=method(CATALOG_VIEW,methodName);var code=body.getCode().code;
    int first=-1,last=-1,count=0;
    for(int i=0;i+4<code.size();i++) {
      if((code.get(i).getBytes()[0]&255)!=0x60 || code.get(i).operands[0]!=member(CATALOG_VIEW,"_-3HX"))continue;
      var get=code.get(i+1);var event=code.get(i+2);var handler=code.get(i+3);var call=code.get(i+4);
      if((get.getBytes()[0]&255)!=0x46 || !abc.constants.getString(abc.constants.getMultiname(get.operands[0]).name_index).equals("getInAppPurchaser") || get.operands[1]!=0)continue;
      if((event.getBytes()[0]&255)!=0x2c || !abc.constants.getString(event.operands[0]).startsWith("IN_APP_") || (handler.getBytes()[0]&255)!=0x60 || (call.getBytes()[0]&255)!=0x4f || call.operands[1]!=2 || !abc.constants.getString(abc.constants.getMultiname(call.operands[0]).name_index).equals(listenerOperation))throw new IllegalStateException("Unexpected catalog listener block");
      if(first<0)first=i;
      if(last>=0 && i!=last+1)throw new IllegalStateException("Non-contiguous catalog listeners");
      last=i+4;count++;i+=4;
    }
    if(count!=expected || body.exceptions.length!=0)throw new IllegalStateException("Unexpected catalog listeners: "+methodName+" "+count);
    int at=(int)code.get(first).getAddress();int end=(int)(code.get(last).getAddress()+code.get(last).getBytes().length);
    // Existing conditional targets at this address deliberately enter the new
    // guard. No other original branch crosses the insertion point.
    for(var ins:code) {
      int op=ins.getBytes()[0]&255;if(op==0x1b)throw new IllegalStateException("Unexpected switch");
      if(op>=0x0c && op<=0x1a) {
        long from=ins.getAddress(),target=from+ins.getBytes().length+ins.operands[0];
        if((from<at && target>at) || (from>=at && target<at))throw new IllegalStateException("Unexpected branch across catalog guard");
      }
    }
    Code guard=new Code().op(0x60,member(CATALOG_VIEW,"_-3HX")).op(0x46,member(CATALOG,"getInAppPurchaser"),0);
    if(listenerOperation.equals("removeEventListener"))guard.branch(0x11,1).op(0x47);
    else guard.branch(0x12,end-at);
    byte[] original=body.getCodeBytes();var amended=new ByteArrayOutputStream();
    amended.write(original,0,at);amended.write(guard.bytes());amended.write(original,at,original.length-at);
    body.setCodeBytes(amended.toByteArray());body.max_stack=Math.max(2,body.max_stack);body.getCode();body.setModified();
    System.out.println("Guarded "+count+" optional billing listeners in "+methodName+"; original catalog display logic retained");
  }

  static void updateCatalogLifecycle() throws Exception {
    // Clipboard SSO has no legacy Web API session. The original purchaser
    // getter therefore returns null; this is an optional service, not a login
    // error. Preserve hiding/showing the UI and skip only its absent listeners.
    guardCatalogListenerBlock("removeFromParent","removeEventListener",5);
    guardCatalogListenerBlock("onAddedToStage","addEventListener",6);
    Code init=new Code().op(0xd0).op(0x30).op(0xd0).op(0x46,member(CATALOG,"getInAppPurchaser"),0).op(0x2a).branch(0x11,2).op(0x29).op(0x47);
    init.field(CATALOG,"_-244").op(0x4f,publicName("_-1x8"),1).op(0x47);
    replace(CATALOG,"initInAppPurchaser",init,2);
  }

  static String qname(ABC a,int i) {
    var mn=a.constants.getMultiname(i);var ns=mn.getNamespace(a.constants);
    return (ns==null?"":ns.getRawName(a.constants))+"::"+a.constants.getString(mn.name_index);
  }

  static String originalName(ABC a,int ci) {
    var inst=a.instance_info.get(ci);
    if(inst.protectedNS!=0) {
      var ns=a.constants.getNamespace(inst.protectedNS).getRawName(a.constants);
      if(ns.startsWith("com.sulake.") && ns.contains(":"))return ns;
    }
    var traits=new ArrayList<Trait>();
    traits.addAll(inst.instance_traits.traits);traits.addAll(a.class_info.get(ci).static_traits.traits);
    for(var t:traits) {
      var ns=a.constants.getMultiname(t.name_index).getNamespace(a.constants);
      if(ns!=null) {
        var s=ns.getRawName(a.constants);
        if(s.startsWith("com.sulake.") && s.contains(":"))return s;
      }
    }
    var n=qname(a,inst.name_index);return n.startsWith("com.sulake.")?n.replace("::",":"):n;
  }

  static Map<String,Map<String,Integer>> currentTables(SWF current) throws Exception {
    Map<String,Map<String,Integer>> result=new HashMap<>();
    for(var tag:current.getAbcList()) {
      var a=tag.getABC();var names=new HashMap<String,String>();
      for(int ci=0;ci<a.instance_info.size();ci++)names.put(qname(a,a.instance_info.get(ci).name_index),originalName(a,ci));
      for(int ci=0;ci<a.instance_info.size();ci++) {
        if(!qname(a,a.instance_info.get(ci).name_index).equals("com.sulake.habbo.communication::HabboMessages"))continue;
        var code=a.findBody(a.class_info.get(ci).cinit_index).getCode().code;
        for(int i=0;i+3<code.size();i++) {
          var x=code.get(i);var y=code.get(i+1);var z=code.get(i+2);var w=code.get(i+3);
          int p=y.getBytes()[0]&255;
          if((x.getBytes()[0]&255)!=0x60 || (p!=0x24 && p!=0x25 && p!=0x2d) || (z.getBytes()[0]&255)!=0x60 || (w.getBytes()[0]&255)!=0x61)continue;
          int id=p==0x2d?a.constants.getInt(y.operands[0]):y.operands[0];
          String side=qname(a,x.operands[0]);side=side.substring(side.lastIndexOf("::")+2);
          String type=names.get(qname(a,z.operands[0]));
          if(type==null)throw new IllegalStateException("Unresolved current message class");
          var table=result.computeIfAbsent(side,k->new HashMap<>());
          if(table.put(type,id)!=null)throw new IllegalStateException("Duplicate current message type "+type);
        }
      }
    }
    if(result.get("_composers").size()<500 || result.get("_events").size()<500)throw new IllegalStateException("Incomplete AirPlus tables");
    return result;
  }

  static void updateProtocol(SWF current,String modulus) throws Exception {
    var tables=currentTables(current);
    var manual=Map.ofEntries(
      Map.entry("_-1I-::_-3I2","com.sulake.habbo.communication.messages.outgoing.handshake:InitDiffieHandshakeMessageComposer"),
      Map.entry("_-1I-::_-5p","com.sulake.habbo.communication.messages.outgoing.handshake:InfoRetrieveMessageComposer"),
      Map.entry("_-1I-::_-214","com.sulake.habbo.communication.messages.outgoing.handshake:PongMessageComposer"),
      Map.entry("_-3eU::_-0p4","com.sulake.habbo.communication.messages.outgoing.room.engine:GetFurnitureAliasesMessageComposer"),
      Map.entry("_-0It::_-075","com.sulake.habbo.communication.messages.outgoing.newnavigator:NewNavigatorInitComposer"),
      Map.entry("_-2Jw::_-4Fg","com.sulake.habbo.communication.messages.outgoing.room.session:QuitMessageComposer"),
      Map.entry("_-0Wy::_-11L","com.sulake.habbo.communication.messages.outgoing.room.avatar:DropCarryItemMessageComposer"),
      Map.entry("_-4h3::_-4Q1","com.sulake.habbo.communication.messages.outgoing.users:GetHabboGroupBadgesMessageComposer"),
      Map.entry("_-0Lu::_-4Ib","com.sulake.habbo.communication.messages.outgoing.friendlist:MessengerInitMessageComposer"),
      Map.entry("_-0Lu::_-16B","com.sulake.habbo.communication.messages.outgoing.friendlist:GetFriendRequestsMessageComposer"),
      Map.entry("_-3D2::_-2MU","com.sulake.habbo.communication.messages.outgoing.competition:RoomCompetitionInitMessageComposer"),
      Map.entry("_-1gU::_-1a2","com.sulake.habbo.communication.messages.outgoing.inventory.bots:GetBotInventoryComposer"),
      Map.entry("_-1pz::_-3hM","com.sulake.habbo.communication.messages.outgoing.room.chat:CancelTypingMessageComposer"),
      Map.entry("_-2bB::_-3Oq","com.sulake.habbo.communication.messages.outgoing.inventory.furni:RequestFurniInventoryComposer"),
      Map.entry("_-2bB::_-0-R","com.sulake.habbo.communication.messages.outgoing.inventory.furni:RequestFurniInventoryWhenNotInRoomComposer"),
      Map.entry("_-2lK::_-4dZ","com.sulake.habbo.communication.messages.outgoing.inventory.pets:GetPetInventoryComposer"),
      Map.entry("_-1pz::_-dy","com.sulake.habbo.communication.messages.outgoing.room.chat:StartTypingMessageComposer"),
      Map.entry("_-LI::_-28E","com.sulake.habbo.communication.messages.outgoing.inventory.trading:CloseTradingComposer"),
      Map.entry("_-1Dj::_-3oJ","com.sulake.habbo.communication.messages.outgoing.catalog:BuildersClubQueryFurniCountMessageComposer"),
      Map.entry("_-1Dj::_-48X","com.sulake.habbo.communication.messages.outgoing.catalog:GetBundleDiscountRulesetComposer"),
      Map.entry("_-1I-::_-0Wb","com.sulake.habbo.communication.messages.outgoing.handshake:DisconnectMessageComposer"),
      Map.entry("_-0Rs::_-1zD","com.sulake.habbo.communication.messages.outgoing.marketplace:GetMarketplaceConfigurationMessageComposer"),
      Map.entry("_-0Rs::_-1lT","com.sulake.habbo.communication.messages.outgoing.marketplace:GetMarketplaceCanMakeOfferMessageComposer"),
      Map.entry("_-1Dj::_-2JA","com.sulake.habbo.communication.messages.outgoing.catalog:GetBonusRareInfoMessageComposer"),
      Map.entry("_-199::_-2Qe","com.sulake.habbo.communication.messages.outgoing.camera:RequestCameraConfigurationMessageComposer"),
      Map.entry("_-49h::_-41z","com.sulake.habbo.communication.messages.outgoing.quest:GetCommunityGoalProgressMessageComposer"),
      Map.entry("_-49h::_-1JD","com.sulake.habbo.communication.messages.outgoing.quest:GetQuestsMessageComposer"),
      Map.entry("_-49h::_-6v","com.sulake.habbo.communication.messages.outgoing.quest:GetSeasonalQuestsOnlyMessageComposer"),
      Map.entry("_-49h::_-ho","com.sulake.habbo.communication.messages.outgoing.quest:RejectQuestMessageComposer")
    );
    // Empty composers have no surviving source namespaces. These aliases come
    // from reviewed call sites (login, room leave, typing, inventory, etc.).
    for(String alias:manual.values())if(!tables.get("_composers").containsKey(alias))throw new IllegalStateException("Unresolved explicit alias "+alias);
    for(var entry:Map.of("WiredFurniAddonEvent",16,"WiredFurniSelectorEvent",2772,"WiredFurniVariableEvent",444).entrySet())if(!Objects.equals(tables.get("_events").get("com.sulake.habbo.communication.messages.incoming.userdefinedroomevents:"+entry.getKey()),entry.getValue()))throw new IllegalStateException("Unsupported Wired notice header does not match current registry");
    var names=new HashMap<String,String>();
    for(int ci=0;ci<abc.instance_info.size();ci++)names.put(qname(abc,abc.instance_info.get(ci).name_index),originalName(abc,ci));
    MethodBody body=null;
    for(int ci=0;ci<abc.instance_info.size();ci++)if(qname(abc,abc.instance_info.get(ci).name_index).equals("_-0cq::_-0z0"))body=abc.findBody(abc.class_info.get(ci).cinit_index);
    if(body==null)throw new IllegalStateException("Missing original message registry");
    int composers=0,events=0,omitted=0;var targetsOut=new HashSet<Integer>();var targetsIn=new HashSet<Integer>();
    Code retiredEvents=new Code();int retiredCount=0;
    var retiredReport=new StringBuilder("logical\traw\n");
    var report=new StringBuilder("direction\told_id\tairplus_id\tmessage_type\n");
    var code=body.getCode().code;
    for(int i=code.size()-4;i>=0;i--) {
      var x=code.get(i);var y=code.get(i+1);var z=code.get(i+2);var w=code.get(i+3);
      int p=y.getBytes()[0]&255;
      if((x.getBytes()[0]&255)!=0x60 || (p!=0x24 && p!=0x25 && p!=0x2d) || (z.getBytes()[0]&255)!=0x60 || (w.getBytes()[0]&255)!=0x61)continue;
      String table=qname(abc,x.operands[0]);
      boolean outgoing=table.endsWith("::_-26i");
      if(!outgoing && !table.endsWith("::_-0up"))throw new IllegalStateException("Unexpected registry table");
      int oldId=p==0x2d?abc.constants.getInt(y.operands[0]):y.operands[0];
      String raw=qname(abc,z.operands[0]);String logical=manual.getOrDefault(raw,names.get(raw));
      Integer id=tables.get(outgoing?"_composers":"_events").get(logical);
      report.append(outgoing?"send":"receive").append('\t').append(oldId).append('\t').append(id==null?"OMITTED":id).append('\t').append(logical).append('\n');
      if(id==null) {
        // Never allow a stale header to address an unrelated current operation.
        if(!outgoing) {
          retiredEvents.op(0xd1).op(0xb2,z.operands[0]).branch(0x12,1).op(0x47);
          retiredReport.append(logical).append('\t').append(raw).append('\n');retiredCount++;
        }
        for(int j=i+3;j>=i;j--)body.replaceInstruction(j,new AVM2Instruction(code.get(j).getAddress(),0x02,new int[0]));
        omitted++;
      } else {
        if(!(outgoing?targetsOut:targetsIn).add(id))throw new IllegalStateException("Colliding remapped header "+id);
        body.replaceInstruction(i+1,new AVM2Instruction(y.getAddress(),0x25,new int[]{id}));
        if(outgoing)composers++;else events++;
      }
    }
    // A second class may use the same wire header. Register these aliases in
    // the class-to-header manager, preserving every original composer mapping.
    Code aliasesCode=new Code();
    for(String[] pair:new String[][]{{"Effect","UpdateActionMessageComposer"},{"Trigger","UpdateTriggerMessageComposer"},{"Condition","UpdateConditionMessageComposer"},{"Addon","UpdateAddonMessageComposer"},{"Selector","UpdateSelectorMessageComposer"},{"Variable","UpdateVariableMessageComposer"}}){
      int id=tables.get("_composers").get(WIRED_COMPOSERS+pair[1]);
      aliasesCode.op(0xd0).op(0x25,id).op(0x60,rawClass("loginpatch::WiredPayload"+pair[0])).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
    }
    int variablesHeader=tables.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu:WiredGetAllVariablesDiffsMessageComposer");
    if(variablesHeader!=2665 || tables.get("_events").get("com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu:WiredAllVariablesDiffsEvent")!=860)throw new IllegalStateException("Wired variable synchronization protocol changed");
    aliasesCode.op(0xd0).op(0x25,variablesHeader).op(0x60,rawClass("loginpatch::WiredPayloadVariables")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
    int historyRequest=tables.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.friendlist:GetMessengerHistoryComposer");
    int historyResponse=tables.get("_events").get("com.sulake.habbo.communication.messages.incoming.friendlist:ConsoleMessageHistoryEvent");
    aliasesCode.op(0xd0).op(0x25,historyRequest).op(0x60,rawClass("loginpatch::ConsoleHistoryPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
    aliasesCode.op(0x60,helperName()).op(0x25,historyResponse).op(0x4f,publicName("initConsoleHistoryProtocol"),1);
    System.out.println("Console history protocol: request "+historyRequest+", response "+historyResponse);
    Code ownedAliases=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,aliasesCode.bytes().length);
    ownedAliases.out.writeBytes(aliasesCode.bytes());
    var registration=method(MESSAGE_CLASSES,"_-2aE");
    insertInclusive(registration,registration.getCode().code.size()-1,ownedAliases,3);
    body.setModified();
    if(composers<379 || events<452 || composers+events+omitted!=929)throw new IllegalStateException("Unexpected protocol coverage: "+composers+"/"+events+"/"+omitted);
    Files.writeString(Path.of("work/applied-protocol.tsv"),report.toString());
    System.out.println("Updated complete registry: "+composers+" outgoing and "+events+" incoming mappings; "+omitted+" unsupported entries omitted");
    if(retiredCount!=13)throw new IllegalStateException("Unexpected retired incoming message count "+retiredCount);
    observe(MESSAGE_CLASSES,"_-0bA",retiredEvents,2);
    Files.writeString(Path.of("work/startup-audit/retired-events.tsv"),retiredReport.toString());
    System.out.println("Skipped registration of all "+retiredCount+" specifically retired incoming types; all other registration validation remains active");

    String revision=null;
    for(var tag:current.getAbcList()) {
      var a=tag.getABC();
      for(int ci=0;ci<a.instance_info.size();ci++)if(qname(a,a.instance_info.get(ci).name_index).equals("com.sulake.habbo.communication.messages.outgoing.handshake::ClientHelloMessageComposer")) {
        for(var t:a.instance_info.get(ci).instance_traits.traits)if(t instanceof TraitMethodGetterSetter) {
          var b=a.findBody(((TraitMethodGetterSetter)t).method_info);
          if(b==null)continue;
          for(var ins:b.getCode().code)if((ins.getBytes()[0]&255)==0x2c) {
            String s=a.constants.getString(ins.operands[0]);
            if(s.matches("WIN63-[0-9]+-[0-9]+"))revision=s;
          }
        }
      }
    }
    if(revision==null)throw new IllegalStateException("Missing AirPlus revision");
    Code hello=new Code().op(0xd0).op(0x30).op(0x2c,abc.constants.getStringId(revision,true)).op(0x2c,abc.constants.getStringId("FLASH25",true)).op(0x24,7).op(0x24,4).op(0x56,4).op(0x48);
    replace(HELLO,"_-0tq",hello,4);

    if(!modulus.matches("[0-9A-Fa-f]{512}"))throw new IllegalStateException("Unexpected current RSA modulus");
    String rsaBlob=Base64.getEncoder().encodeToString(((char)modulus.length()+modulus+(char)5+"10001").getBytes(StandardCharsets.UTF_8));
    var key=method(INCOMING,"_-45S");int replacements=0;
    for(int i=0;i<key.getCode().code.size();i++) {
      var ins=key.getCode().code.get(i);
      if((ins.getBytes()[0]&255)==0x2c && abc.constants.getString(ins.operands[0]).startsWith("xIBlMDUyODA4")) {
        key.replaceInstruction(i,new AVM2Instruction(ins.getAddress(),0x2c,new int[]{abc.constants.getStringId(rsaBlob,true)}));replacements++;
      }
    }
    if(replacements!=1)throw new IllegalStateException("Expected one old RSA key");
    key.setModified();
    System.out.println("Using AirPlus revision "+revision+" and its 2048-bit RSA public key");

    observe(DEMO,"_-1xA",new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("phase"),1),2);
    observe(WIRE,"encode",new Code().op(0x60,helperName()).op(0xd1).op(0x4f,publicName("sent"),1),2);
    observe(SOCKET,"_-0lj",new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("_-2Dk"),0).op(0x4f,publicName("received"),1),2);
    // The current client fetches furniture aliases immediately after auth.
    // Use the original empty composer and original event/parser/UI classes.
    int aliasClass=0;
    for(var inst:abc.instance_info)if(qname(abc,inst.name_index).equals("_-3eU::_-0p4"))aliasClass=inst.name_index;
    if(aliasClass==0)throw new IllegalStateException("Missing furniture alias composer");
    observe(INCOMING,"_-1Ph",new Code().op(0xd1).op(0x66,publicName("connection")).op(0x5d,aliasClass).op(0x4a,aliasClass,0).op(0x4f,publicName("send"),1),2);

    // Manual Launcher SSO replaces the mobile web authentication flow. Pending
    // old callbacks must not reset the token, restore password login or select
    // another avatar after this socket session has begun.
    for(String name:new String[]{"_-qz","_-3E4"}) {
      Code guard=new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("ignoreLegacyResponse"),1);
      observe(DEMO,name,handled(guard),2);
    }
    Code oldLoginError=new Code().op(0x60,helperName()).field(BASE,"_controller").op(0x46,publicName("handleLegacyLoginError"),1);
    observe(SCREEN,"_-0B5",handled(oldLoginError),2);
    observe(DEMO,"disconnected",new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0x4f,publicName("connectionClosed"),2),3);
    Code generic=new Code().op(0x60,helperName()).field(INCOMING,"_-1no").op(0xd1).op(0x66,publicName("parser")).op(0x66,publicName("errorCode")).op(0x46,publicName("handleGenericError"),2);
    observe(INCOMING,"_-4V3",handled(generic),3);
  }

  public static void main(String[] args) throws Exception {
    SWF swf = new SWF(new FileInputStream(args[0]), false);
    var main = swf.getAbcList().get(1);
    abc = main.getABC();
    SWF.initPlayer();
    AbcIndexing index = new AbcIndexing(swf, SWF.getAirGlobalAbcIndex());
    index.selectAbc(abc);
    ActionScript3Parser.compile(Files.readString(Path.of("work/ChatAtlas.as")),abc,index,"ChatAtlas.as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
    // Keep the PNG bytes intact, including low-alpha pixels. A lossless-ARGB
    // import would premultiply/unpremultiply the reference artwork twice.
    var atlas=new DefineBitsJPEG2Tag(swf);atlas.characterID=swf.getNextCharacterId();atlas.setImage(Files.readAllBytes(Path.of("work/ChatAtlas.png")));atlas.setModified(true);
    swf.addTag(swf.indexOfTag((Tag)main),atlas);
    var binding=new SymbolClassTag(swf);binding.tags.add(atlas.characterID);binding.names.add("loginpatch.ChatAtlas");binding.setModified(true);swf.addTag(swf.indexOfTag((Tag)main)+1,binding);
    for(String category:List.of("Effect","Trigger","Condition","Addon","Selector","Variable","Variables")) {
      String name="WiredPayload"+category;
      ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
      // FFdec resolves an escaped obfuscated interface import to an
      // unqualified QName. Bind the actual existing AIR interface explicitly.
      var payload=abc.instance_info.stream().filter(c->qname(abc,c.name_index).equals("loginpatch::"+name)).findFirst().orElseThrow();
      payload.interfaces=new int[]{rawClass("_-0tl::_-15i")};
      boolean encoder=false;
      for(var trait:payload.instance_traits.traits)if(trait instanceof TraitMethodGetterSetter && "_-0tq".equals(abc.constants.getString(abc.constants.getMultiname(trait.name_index).name_index)))encoder=true;
      if(!encoder)throw new IllegalStateException("Missing native composer encoder: "+name);
    }
    ActionScript3Parser.compile(Files.readString(Path.of("work/ConsoleHistoryPayload.as")),abc,index,"ConsoleHistoryPayload.as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
    abc.instance_info.stream().filter(c->qname(abc,c.name_index).equals("loginpatch::ConsoleHistoryPayload")).findFirst().orElseThrow().interfaces=new int[]{rawClass("_-0tl::_-15i")};
    ActionScript3Parser.compile(Files.readString(Path.of(args[1])), abc, index, "HabboTicketLogin.as", abc.instance_info.size(), abc.script_info.size(), true, swf.getDocumentClass());
    System.out.println("Compiled independent SSO helper");

    Code login = new Code().op(0xd0).op(0x30).op(0x60, helperName());
    login.field(BASE,"_controller").field(SCREEN,"_-2W-").op(0x4f, publicName("login"),2).op(0x47);
    replace(SCREEN,"_-0zI",login,3);

    Code website = new Code().op(0xd0).op(0x30).op(0x60,helperName());
    website.field(BASE,"_controller").op(0x4f,publicName("openWebsite"),1).op(0x47);
    replace(SCREEN,"_-0cR",website,2);

    var initialize = method(SCREEN,"initializeHandler");
    var instructions = initialize.getCode().code;
    int last = instructions.size() - 1;
    if ((instructions.get(last).getBytes()[0] & 255) != 0x47) throw new IllegalStateException("Unexpected initialize ending");
    Code configure = new Code().op(0x60,helperName());
    for (String field : new String[]{"_-2W-","_-3Gd","_-1NE","_-P6","_-0sU","_-0ya","_-3Nt"}) configure.field(SCREEN,field);
    configure.field(BASE,"_controller").op(0x4f,publicName("configure"),8).op(0x47);
    var original = initialize.getCodeBytes();
    if ((original[original.length-1] & 255) != 0x47) throw new IllegalStateException("Unexpected final byte");
    var amended = new ByteArrayOutputStream();
    amended.write(original,0,original.length-1);
    amended.write(configure.bytes());
    initialize.setCodeBytes(amended.toByteArray());
    initialize.max_stack = Math.max(initialize.max_stack,10);
    initialize.getCode();
    initialize.setModified();

    Code sso = new Code().op(0xd0).op(0x30);
    sso.op(0xd0).op(0x4f,member(DEMO,"forgetUserLoginCredentials"),0);
    sso.op(0xd0).op(0x24,2).op(0x61,member(DEMO,"_-xm"));
    sso.op(0xd0).op(0x27).op(0x61,member(DEMO,"_-3sL"));
    sso.op(0xd0).op(0x27).op(0x61,member(DEMO,"_-3jC"));
    sso.op(0xd0).op(0x27).op(0x61,member(DEMO,"_-2QX"));
    sso.op(0xd0).op(0xd1).op(0x4f,member(DEMO,"_-4O"),1).op(0x47);
    replace(DEMO,"_-zP",sso,2);

    // The current client sends machine id, fingerprint, and AIR version.
    // Keep the old class and constructor, adding only the missing wire field.
    Code identity = new Code().op(0xd0).op(0x30);
    identity.field(UNIQUE,"_-2mp").field(UNIQUE,"_-Iw");
    identity.op(0x60,helperName()).op(0x46,publicName("runtimeVersion"),0);
    identity.op(0x56,3).op(0x48);
    replace(UNIQUE,"_-0tq",identity,3);

    // Preserve the original handling of all other server error codes.
    // For error 1, show the request id which the old dialog discarded.
    var serverError = method(DEMO,"_-2Dn");
    byte[] oldError = serverError.getCodeBytes();
    if(oldError[0] != (byte)0xd0 || oldError[1] != 0x30 || serverError.exceptions.length != 0) throw new IllegalStateException("Unexpected error handler prologue");
    Code details = new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0xd2).op(0x4f,publicName("serverError"),3).op(0x47);
    byte[] report = details.bytes();
    var errorBytes = new ByteArrayOutputStream();
    errorBytes.write(oldError,0,2);
    errorBytes.write(new byte[]{(byte)0xd1,0x24,0x01,0x14,(byte)report.length,0x00,0x00});
    errorBytes.write(report);
    errorBytes.write(oldError,2,oldError.length-2);
    serverError.setCodeBytes(errorBytes.toByteArray());
    serverError.max_stack = Math.max(4,serverError.max_stack);
    serverError.getCode();
    serverError.setModified();

    var configurationReady = method(DEMO,"_-1mf");
    var code = configurationReady.getCode().code;
    int removed = 0;
    for (int i = code.size()-2; i >= 1; i--) {
      var ins = code.get(i);
      if ((ins.getBytes()[0] & 255) == 0x2c) {
        String value = abc.constants.getString(ins.operands[0]);
        if(value.equals("http://d63.varoke.net/crossdomain.xml") || value.equals("https://d63.varoke.net/crossdomain.xml")) {
          if ((code.get(i-1).getBytes()[0] & 255) != 0x60 || (code.get(i+1).getBytes()[0] & 255) != 0x4f) throw new IllegalStateException("Unexpected policy instructions");
          for(int j=i+1;j>=i-1;j--) configurationReady.replaceInstruction(j,new AVM2Instruction(code.get(j).getAddress(),0x02,new int[0]));
          removed++;
        }
      }
    }
    if(removed != 2) throw new IllegalStateException("Expected 2 obsolete policy requests, found " + removed);
    configurationReady.setModified();
    ((Tag)main).setModified(true);

    int configs = 0;
    for (var tag : swf.getTags()) if(tag instanceof DefineBinaryDataTag) {
      var binary = (DefineBinaryDataTag)tag;
      String value = new String(binary.binaryData.getRangeData(),StandardCharsets.UTF_8);
      if(value.contains("connection.info.host.pt=game-br.habbo.com")) {
        value = value.replace("=http://www.habbo", "=https://www.habbo").replace("=http://sandbox.habbo.com", "=https://sandbox.habbo.com");
        value = value.replaceAll("(?m)^(connection\\.info\\.port\\.(?:en|pt|fi|fr|de|nl|es|it|tr|s2))=[^\\r\\n]*", "$1=30000,993,843");
        binary.setDataBytes(new ByteArrayRange(value.getBytes(StandardCharsets.UTF_8)));
        binary.setModified(true);
        configs++;
      }
    }
    if(configs != 1) throw new IllegalStateException("Expected common config");
    if(args.length!=5)throw new IllegalArgumentException("original.swf helper.as output.swf airplus.swf current-rsa-modulus.txt");
    updateProtocol(new SWF(new FileInputStream(args[3]),false),Files.readString(Path.of(args[4])).trim());
    updateIgnoredUsers();
    updateCatalogLifecycle();
    updateRecordSchemas();
    updateInventorySchemas();
    updateOptionalServices();
    updateComposerSchemas();
    updateSocialInteractions();
    updateImmersiveWindow();
    updateCommands();
    updateWired();
    updateNavigatorAndHeight();
    updateRoomEditors();
    updateFriendHighlightsAndTap();
    updateConsoleHistory();
    updateChatBubbles();
    updateRecolorableFurniture();
    try (var out = new FileOutputStream(args[2])) {swf.saveTo(out);}
    System.out.println("Saved original UI/game with AirPlus-compatible network registry, hello/RSA/SSO, and numeric-only connection diagnostics: " + args[2]);
  }
}
