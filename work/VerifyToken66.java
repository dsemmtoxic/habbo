import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
// The prior fixture validated property names but did not enforce class-typed
// native slots. AIR does: TextField cannot be stored in LoginScreen.Label.
class VerifyToken66 extends VerifyToken65 {
 static class V66 extends V65 {
  V66(SWF s)throws Exception{super(s);}
  @Override void set(Object receiver,Object key,Object value){
   if(receiver instanceof Obj o&&o.type.equals(rawType(PatchOldLogin.SCREEN))){
    var c=raw.get(o.type);for(var trait:c.inst().instance_traits.traits)if(trait instanceof TraitSlotConst slot&&AuditStartup.name(c.abc(),slot.name_index).equals(key)){
     String type=AuditStartup.q(c.abc(),slot.type_index);if(value!=null&&raw.containsKey(type)&&!instanceOf(value,type))throw new FixtureError("Error #1034: native LoginScreen."+key+" requires "+type+"; received "+(value instanceof Obj item?item.type:String.valueOf(value)));
    }
   }
   super.set(receiver,key,value);
  }
 }
 static void startup(SWF old,SWF now)throws Exception{
  boolean reproduced=false;try{new V66(old).create(1536,709,"pt");}catch(FixtureError e){check(e.getMessage().contains("#1034")&&e.getMessage().contains("_-0ya")&&e.getMessage().contains("_-2xS::_-Fk"),"Unexpected65 startup error: "+e);reproduced=true;System.out.println("PASS: reproduced65 startup failure with native slot coercion: "+e.getMessage());}check(reproduced,"Did not reproduce65 blocking initialization");
  var v=new V66(now);int count=0;
  for(boolean linked:List.of(false,true))for(int[]size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{640,360},new int[]{375,812})){
   if(linked){var profile=new Obj("profile66");profile.put("name","Avatar");profile.put("figure","hr-1-1.hd-1-1");profile.put("id","one");profile.put("image","");v.savedProfile=profile;}else v.savedProfile=null;
   var screen=v.create(size[0],size[1],"pt");var state=v.state(screen);var ui=(Obj)state.get("login62");
   check(truth(screen.get("_-iK")),"Native initialization did not finish; loading may remain");
   var loading=new Obj("loading66");loading.put("visible",true);v.helper("syncLoginPresentation","loginScreen",screen,loading);check(!truth(loading.get("visible"))&&truth(screen.get("visible")),"Loading overlay did not yield to login");
   for(String[] pair:new String[][]{{"_-0ya","title","titleView"},{"_-3Nt","instructions","instructionsView"}}){
    var nativeLabel=(Obj)screen.get(pair[0]);check(nativeLabel==state.get(pair[1])&&nativeLabel.type.equals("_-2xS::_-Fk"),"Native Label slot was replaced");check(nativeLabel!=ui.get(pair[2])&&((Obj)ui.get(pair[2])).type.equals("starling.text::TextField"),"Modern view not separate from native Label");check(!truth(nativeLabel.get("visible")),"Hidden native label overlaps modern UI");
   }
   click(v,(Obj)ui.get("tokenTab"));for(String key:List.of("titleView","instructionsView")){var view=(Obj)ui.get(key);check(truth(view.get("visible")),"Token title hidden");contained(view,(Obj)state.get("card"),key);check(view.get("nativeFilters") instanceof List,"White text lost black outline");}
   ((Obj)state.get("input")).put("text","hhbr.unit.ticket");int auth=v.authCalls;click(v,(Obj)state.get("login"));check(v.authCalls==auth+1,"Native authentication changed");v.helper("disposeTokenLogin",screen);count++;
  }
  System.out.println("PASS: native initializeHandler/onAddedToStage completes in "+count+" unlinked/linked and landscape/portrait cases; both native Label slots stay type-correct, outlined modern views are separate, token action and disposal preserved. Real Android transition remains a device boundary.");
 }
 public static void main(String[]args)throws Exception{startup(new SWF(new FileInputStream(args[0]),false),new SWF(new FileInputStream(args[1]),false));}
}
