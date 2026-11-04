import java.io.*;import java.util.*;import java.nio.file.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.tags.*;
import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;

class PatchFeatures25 extends PatchFeatures24 {
 static final String MARKET25="com.sulake.habbo.tablet.catalog.marketplace:MarketPlaceLogic",MARKET_VIEW25="com.sulake.habbo.tablet.catalog.marketplace:MarketPlaceOffersView",MARKET_ROW25="com.sulake.habbo.tablet.catalog.marketplace:MarketPlaceOwnItemsRenderer";
 static void visibility25()throws Exception {
  var b=method(FV23,"updateModel");int at=-1;
  for(int i=0;i<b.getCode().code.size();i++) {
   var ins=b.getCode().code.get(i);
   if((ins.getBytes()[0]&255)==0x61&&AuditStartup.name(abc,ins.operands[0]).equals("_-0VG")){at=i;break;}
  }
  if(at<0||at>16)throw new IllegalStateException("Missing original visibility invalidation guard");
  // The existing visibility-change branch now also forces native model refresh.
  // A cached model id must not consume the GPU-dirty flag without updating sprites.
  int cached=namedReference(b,"_-12p");
  insertInclusive(b,at,new Code().op(0xd0).op(0x2d,abc.constants.getIntId(-1,true)).op(0x61,cached),b.max_stack+2);
 }
 static void market25()throws Exception {
  var b=method(MARKET_VIEW25,"_-3cm");int count=0;
  for(int i=b.getCode().code.size()-1;i>=0;i--) {
   var ins=b.getCode().code.get(i);
   if((ins.getBytes()[0]&255)==0x61&&AuditStartup.name(abc,ins.operands[0]).equals("isEnabled")) {
    // This is the own-sales list, whose action returns one's own item. Buying
    // and listing items retain their existing account checks and server checks.
    insertInclusive(b,i,new Code().op(0x29).op(0x26),b.max_stack);count++;
   }
  }
  if(count!=1)throw new IllegalStateException("Unexpected own-list enabled field");
  b=method(MARKET25,"_-3vm");
  int view=callIndex(b,"_-4If",1);
  insertInclusive(b,view,new Code().op(0xd0).field(MARKET25,"_-3lm").op(0x66,publicName("length")).op(0x61,member(MARKET25,"_-158")),b.max_stack+3);
  atReturns(b,new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0x4f,publicName("afterMarketReturn25"),2),4);
  // Repair the existing malformed failure-localization marker.
  for(var ins:b.getCode().code)if((ins.getBytes()[0]&255)==0x2c&&abc.constants.getString(ins.operands[0]).equals("{{catalog.marketplace.cancel_failed}"))ins.operands[0]=abc.constants.getStringId("${catalog.marketplace.cancel_failed}",true);
  b.setCodeBytes(b.getCode().getBytes());b.getCode();b.setModified();
  b=method(MARKET_ROW25,"commitData");
  atReturns(b,new Code().op(0x60,helperName()).op(0xd0).op(0x66,namedReference(b,"_-0SL")).field(MARKET_ROW25,"_-3xH").op(0x4f,publicName("marketReturnRow25"),2),4);
 }
 public static void main(String[]a)throws Exception {
  var s=new SWF(new FileInputStream(a[0]),false);abc=s.getAbcList().get(1).getABC();SWF.initPlayer();
  var index=new AbcIndexing(s,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/FloorPreview25.as")),abc,index,"FloorPreview25.as",abc.instance_info.size(),abc.script_info.size(),true,s.getDocumentClass());
  visibility25();market25();
  for(var body:abc.bodies)body.getCode().checkValidOffsets(body);
  ((Tag)s.getAbcList().get(1)).setModified(true);
  try(var out=new FileOutputStream(a[1])){s.saveTo(out);}
  System.out.println("Saved Teste25: native-geometry floor preview, floor message subscriptions, GPU visibility refresh and own-market returns.");
 }
}
