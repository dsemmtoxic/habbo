import java.io.*;import java.nio.file.*;import java.util.*;import java.awt.image.BufferedImage;import java.awt.Color;import java.awt.geom.RoundRectangle2D;import javax.imageio.ImageIO;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
// Executes saved AVM2. Native Flash vector graphics/bitmap upload, WebView and
// GPU buffers are explicit boundaries; no result is an Android FPS observation.
class VerifyToken65 extends VerifyToken64 {
 static final Set<String> HELP65=Set.of("loginpatch::ModernUI65","loginpatch::RoomEntry65");
 static class V65 extends V64 {
  int switches;
  V65(SWF s)throws Exception{super(s);}
  @Override boolean own(String n){return super.own(n)||HELP65.contains(n);}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(HELP65.contains(m.cls().raw()))for(var t:m.cls().abc().class_info.get(m.cls().index()).static_traits.traits)if(t instanceof TraitMethodGetterSetter&&n.equals(AuditStartup.name(m.cls().abc(),t.name_index)))return new Bound(new Ref(m.cls().raw()),n);
   if(n.equals("Vector")||n.equals("Number")||n.equals("uint"))return new Ref(n);
   if(n.equals("Rectangle"))return new Ref("flash.geom::Rectangle");
   return super.lexical(m,self,n,i);
  }
  @Override Object construct(String t,List<Object>a){
   if(t.equals("GlowFilter"))t="flash.filters::GlowFilter";
   if(t.equals("vector"))return new ArrayList<>(Collections.nCopies(a.isEmpty()?0:num(a.get(0)),0.0));
   if(t.equals("flash.geom::Rectangle")||t.equals("Rectangle")){var o=new Obj("flash.geom::Rectangle");for(int i=0;i<4;i++)o.put(List.of("x","y","width","height").get(i),i<a.size()?a.get(i):0);return o;}
   return super.construct(t,a);
  }
  @SuppressWarnings("unchecked") @Override void set(Object r,Object k,Object value){if(r instanceof List l){while(l.size()<=num(k))l.add(null);l.set(num(k),value);return;}super.set(r,k,value);}
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&Set.of("mask-manager65","mask-type65","room-geometry65","vertex-target65").contains(o.type)&&!o.containsKey(k))return new Bound(r,String.valueOf(k));
   if(r instanceof Obj o&&o.type.equals("flash.geom::Rectangle")){if(k.equals("left"))return o.get("x");if(k.equals("top"))return o.get("y");if(k.equals("right"))return number(o.get("x"))+number(o.get("width"));}
   return super.get(r,k);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(n.equals("encodeURIComponent"))return java.net.URLEncoder.encode(String.valueOf(a.get(0)),java.nio.charset.StandardCharsets.UTF_8).replace("+","%20");
   if(r instanceof Ref ref&&ref.name().equals("starling.textures::Texture")&&n.equals("fromBitmapData")){var b=(Obj)a.get(0);var texture=new Obj("texture-boundary");texture.put("width",b.get("width"));texture.put("height",b.get("height"));texture.put("image",b.get("image"));return texture;}
   if(r instanceof Ref ref&&HELP65.contains(ref.name()))return execute(method(raw.get(ref.name()).logical(),n),staticObject(ref.name()),a.toArray());
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::WebSession64")&&n.equals("switchAvatar")){switches++;return null;}
   if(r instanceof List l){if(n.equals("indexOf"))return l.indexOf(a.get(0));if(n.equals("sort")){l.sort(Comparator.comparingDouble(VerifyStartupCompatibility::number));return l;}}
   if(r instanceof Obj o&&o.type.equals("flash.geom::Matrix")&&n.equals("createGradientBox")){o.put("gradient",a);return null;}
   if(r instanceof Obj o&&o.type.equals("flash.display::BitmapData")){
    var bitmap=(BufferedImage)o.get("image");
    if(n.equals("getPixel32"))return Integer.toUnsignedLong(bitmap.getRGB(num(a.get(0)),num(a.get(1))));
    if(n.equals("draw")&&a.get(0) instanceof Obj shape&&shape.type.equals("flash.display::Shape")){
     var commands=graphics.get((Obj)shape.get("graphics"));var g=bitmap.createGraphics();int color=0;float alpha=1;
     for(var command:commands){String op=String.valueOf(command.get(0));if(op.equals("beginGradientFill")){color=num(((List<?>)command.get(2)).get(0));alpha=(float)number(((List<?>)command.get(3)).get(0));}if(op.equals("drawRoundRect")){g.setColor(new Color((color>>16)&255,(color>>8)&255,color&255,(int)(alpha*255)));g.fill(new RoundRectangle2D.Double(number(command.get(1)),number(command.get(2)),number(command.get(3)),number(command.get(4)),number(command.get(5)),number(command.get(6))));}}g.dispose();return null;
    }
   }
   if(r instanceof Obj o&&o.type.equals("mask-manager65")&&n.equals("_-2Ey"))return o.get("mask");
   if(r instanceof Obj o&&o.type.equals("mask-type65")&&n.equals("_-1Xd"))return o.get("asset");
   if(r instanceof Obj o&&o.type.equals("room-geometry65")&&n.equals("_-1ke"))return new Obj("normal65");
   if(r instanceof Obj o&&o.type.equals(rawType(PatchToken65.GEOMETRY))){if(n.equals("entryInvalidateUVs65"))return execute(method(PatchToken65.GEOMETRY,n),o);if(n.equals("_-1y0")){o.put("uvInvalidated65",true);return null;}}
   if(r instanceof Obj o&&o.type.equals("vertex-target65")){if(n.equals("_-0AZ")){o.put("vertices",a.get(0));o.put("UVData",a.get(0));return null;}if(n.equals("_-2I1")){o.put("indices",a.get(0));return null;}}
   return super.call(r,n,a);
  }
  Object modern(String n,Object...a){return execute(method("loginpatch:ModernUI65",n),staticObject("loginpatch::ModernUI65"),a);}
  Object entry(String n,Object...a){return execute(method("loginpatch:RoomEntry65",n),staticObject("loginpatch::RoomEntry65"),a);}
 }
 @SuppressWarnings("unchecked") static void lighting65(SWF now)throws Exception{
  // Keep the existing real Apply callback/save/ack scenarios, using the new skin.
  var v=new V65(now);v.setupToner();v.execute(v.method(PatchToken63.EVENTS,"_-0dX"),v.handler,12345,777,10,0,false);var state=v.staticObject("loginpatch::RoomLighting63");var sliders=(List<Obj>)state.get("_sliders");sliders.get(0).put("value",170);v.lighting("changed",(Object)null);click(v,button((Obj)state.get("_popup"),"Aplicar"));check(payload(v,v.sent.get(v.sent.size()-1)).equals(List.of(777,170,255,127)),"Toner save fields changed");check(state.get("_popup")!=null,"Toner closed before acknowledgement");((Obj)v.toner.get("model")).put("furniture_room_background_color_hue",170);v.colorEvent(true,170,255,127);v.lighting("refresh",(Object)null);check(state.get("_popup")==null,"Toner native confirmation failed");
  v.toner.put("logic63",new Obj("_-2mk::_-CC"));v.lighting("legacy",v.toner,"2,1,1,#74F5F5,127");v.execute(v.method(PatchToken63.EVENTS,"_-0dX"),v.handler,12345,777,10,0,false);
  var colors=(List<Obj>)state.get("_colorButtons");check(colors.size()==7,"Native seven colors lost");for(var b:colors){check(b.get("defaultIcon")==null,"Square icon remains");var tx=(Obj)((Obj)b.get("defaultSkin")).get("texture");var image=(BufferedImage)tx.get("image");int w=image.getWidth(),h=image.getHeight();check((image.getRGB(0,0)>>>24)==0,"Swatch is not rounded");check((image.getRGB(w/2,h/2)>>>24)==255&&(image.getRGB(4,h/2)>>>24)==255,"Color does not fill rounded button");}
  click(v,colors.get(6));var brightness=((List<Obj>)state.get("_sliders")).get(0);check(num(brightness.get("minimum"))==76&&num(brightness.get("maximum"))==255,"Dark limit changed");brightness.put("value",0);v.lighting("changed",(Object)null);check(num(v.lightUpdates.get(v.lightUpdates.size()-1).get(2))==76,"Preview permits total darkness");click(v,button((Obj)state.get("_popup"),"Aplicar"));var message=v.sent.stream().map(x->payload(v,x)).filter(x->x.size()==7).reduce((a,b)->b).orElseThrow();check(message.equals(List.of(1,1,"#000000",76,true,false,777)),"Dimmer seven-field wire changed: "+message);v.lighting("legacy",v.toner,"2,1,1,#000000,76");var packet=new Packet().i(3).i(1);for(int i=1;i<=3;i++)packet.i(i).i(1).s(i==1?"#000000":"#74F5F5").i(i==1?76:127);packet.b(true).i(777);var reader=new Reader(packet.bytes());v.call(v.construct(v.rawType(PatchToken63.PRESETS),List.of()),"parse",List.of(reader));v.lighting("refresh",(Object)null);check(reader.b.remaining()==0&&state.get("_popup")==null,"Preset response/confirmation changed");
  System.out.println("PASS: rounded full-fill palette, no square icons; actual Toner/Dimmer Apply callbacks, min76/255, native seven-field save and acknowledgement preserved from working64.");
 }
 @SuppressWarnings("unchecked") static void login65(SWF now)throws Exception{
  var v=new V65(now);for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080},new int[]{1280,800},new int[]{709,1536},new int[]{800,360},new int[]{640,360},new int[]{375,812})){
   var screen=v.create(size[0],size[1],"pt");var state=v.state(screen);var card=(Obj)state.get("card");var ui=(Obj)state.get("login62");contained(card,(Obj)state.get("root"),"transparent card");check(card.get("backgroundSkin")==null,"Old frame remains");
   for(String key:List.of("login","website","country"))contained((Obj)state.get(key),card,key);for(String key:List.of("gear","accountTab","tokenTab","accountName","accountHint","head"))contained((Obj)ui.get(key),card,key);
   check(((Obj)ui.get("accountName")).get("nativeFilters") instanceof List,"Important text has no black outline");check(num(((Obj)ui.get("accountName")).get("color"))==0xffffff,"Important text is not white");
   int opened=v.browserOpens;click(v,(Obj)state.get("login"));check(v.browserOpens==opened+1&&v.browserLaunch,"Link/Enter callback missing");
   var p=new Obj("profile65");p.put("name","Avatar vinculado");p.put("figure","hr-1-1.hd-1-1");p.put("id","one");p.put("image","");v.savedProfile=p;v.login("sessionUpdated",state);v.helper("layoutTokenLogin",screen);contained((Obj)ui.get("switchButton"),card,"switch avatar");click(v,(Obj)ui.get("switchButton"));check(v.switches>0,"Switch button disconnected");
   click(v,(Obj)ui.get("tokenTab"));check(truth(((Obj)state.get("input")).get("visible")),"Manual token lost");contained((Obj)state.get("input"),card,"token");((Obj)state.get("input")).put("text","hhbr.unit.ticket");int auth=v.authCalls;click(v,(Obj)state.get("login"));check(v.authCalls==auth+1&&v.submittedTicket.equals("unit.ticket"),"Original33 token authentication changed");
   v.helper("disposeTokenLogin",screen);v.savedProfile=null;
  }
  for(double[] dims:List.of(new double[]{34,34,166,144},new double[]{40,66,166,144},new double[]{100,20,80,80})){var fit=(List<?>)v.login("fitHead",dims[0],dims[1],dims[2],dims[3]);check(Math.abs(number(fit.get(0))/number(fit.get(1))-dims[0]/dims[1])<1e-9,"Head stretched");check(number(fit.get(0))<=dims[2]&&number(fit.get(1))<=dims[3],"Head exceeds box");}
  var controller=new Obj("fixture-login-controller19");controller.put("environment.id","pt");check(truth(v.login("imageAllowed","https://www.habbo.com.br/habbo-imaging/avatar/example.png",controller))&&!truth(v.login("imageAllowed","https://www.habbo.com.br.evil.example/habbo-imaging/avatar/a.png",controller)),"Image origin not exact");
  System.out.println("PASS: transparent login without frame; new skins and white outlined text; eight landscape/portrait sizes; account/token/settings preserved; real switch callback; proportional head sizing and official image host checks. Native font/GPU/OS layout remain device boundaries.");
 }
 static Obj vector(double x,double y,double z){var o=new Obj("vector65");o.put("x",x);o.put("y",y);o.put("z",z);o.put("length",Math.sqrt(x*x+y*y+z*z));return o;}
 @SuppressWarnings("unchecked") static void mesh65(SWF now)throws Exception{
  var v=new V65(now);var bitmap=(Obj)v.construct("flash.display::BitmapData",List.of(32,96,true,0));var im=(BufferedImage)bitmap.get("image");for(int y=0;y<96;y++)for(int x=0;x<32;x++)im.setRGB(x,y,0xff000000);
  var asset=new Obj("graphic-asset65");var holder=new Obj("asset65");holder.put("content",bitmap);asset.put("asset",holder);asset.put("offsetX",-16);asset.put("offsetY",-96);asset.put("flipH",false);asset.put("flipV",false);var type=new Obj("mask-type65");type.put("asset",asset);var manager=new Obj("mask-manager65");manager.put("mask",type);
  for(boolean alongY:List.of(false,true)){
   var view=new Obj("view65");var roomGeometry=new Obj("room-geometry65");roomGeometry.put("scale",64);v.entry("bind",view,roomGeometry);var plane=new Obj("plane65");plane.put("type",1);plane.put("location",vector(2,3,0));plane.put("_-1Jd",alongY?vector(0,-8,0):vector(8,0,0));plane.put("_-4Gh",vector(0,0,4));plane.put("normal",vector(1,0,0));plane.put("entryMaskManager65",manager);plane.put("entryMaskBitmap65",alongY?v.construct("flash.display::BitmapData",List.of(256,128,true,0)):null);var mask=new Obj("door-mask65");mask.put("type","door");mask.put("_-1W4",4);mask.put("_-4lf",0);plane.put("entryMasks65",List.of(mask));
   var geometry=new Obj(v.rawType(PatchToken65.GEOMETRY));v.entry("configure",view,plane,geometry);var target=new Obj("vertex-target65");target.put("vertexStride",13);target.put("UVStride",13);target.put("UVOffset",9);
   v.execute(v.method(PatchToken65.GEOMETRY,"buildGeometry"),geometry,target);v.execute(v.method(PatchToken65.GEOMETRY,"buildUVs"),geometry,target);
   check(truth(geometry.get("uvInvalidated65")),"Native UV invalidation bridge missing");var data=(List<?>)target.get("vertices");var indices=(List<?>)target.get("indices");check(data.size()>4*13&&indices.size()>6,"Wall is still one full rectangle");double area=0;
   for(int i=0;i<indices.size();i+=3){double[][] p=new double[3][2];for(int j=0;j<3;j++){int at=num(indices.get(i+j))*13;double u=alongY?(3-number(data.get(at+2))*-1)/8:(number(data.get(at))-2)/8;double z=number(data.get(at+1))/Math.sqrt(2./3);p[j]=new double[]{u,z/4};check(Math.abs(number(data.get(at+9))-(1-u))<1e-8&&Math.abs(number(data.get(at+10))-(1-z/4))<1e-8,"Native texture UV continuity broken");}double centerU=(p[0][0]+p[1][0]+p[2][0])/3,centerV=(p[0][1]+p[1][1]+p[2][1])/3;check(!(centerU>.4375&&centerU<.5625&&centerV>0&&centerV<.75),"Triangle covers door opening");area+=Math.abs((p[1][0]-p[0][0])*(p[2][1]-p[0][1])-(p[2][0]-p[0][0])*(p[1][1]-p[0][1]))/2;}
   check(Math.abs(area-(1-.125*.75))<1e-8,"Wrong mask-based door dimensions: "+area);
   plane.put("type",2);var floor=new Obj(v.rawType(PatchToken65.GEOMETRY));v.entry("configure",view,plane,floor);check(!truth(v.entry("build",floor,target)),"Floor cut as wall");plane.put("type",1);mask.put("type","window");var window=new Obj(v.rawType(PatchToken65.GEOMETRY));v.entry("configure",view,plane,window);check(!truth(v.entry("build",window,target)),"Window changed by entrance patch");
  }
  check(!truth(v.entry("build",new Obj(v.rawType(PatchToken65.GEOMETRY)),new Obj("vertex-target65"))),"Unmasked native geometry replaced");
  System.out.println("PASS: actual saved RoomPlaneGeometry hooks cut native-mask-sized door holes in both wall orientations; triangle area and UV continuity verified; floor/window/unmasked geometry retained. Shadow PNG remains disabled by existing33 regression.");
 }
 public static void main(String[]args)throws Exception{var now=new SWF(new FileInputStream(args[0]),false);String mode=args.length>1?args[1]:"all";if(mode.equals("lighting")||mode.equals("all"))lighting65(now);if(mode.equals("login")||mode.equals("all"))login65(now);if(mode.equals("mesh")||mode.equals("all"))mesh65(now);}
}
