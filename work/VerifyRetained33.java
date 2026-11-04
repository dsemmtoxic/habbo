import java.io.*;import com.jpexs.decompiler.flash.SWF;
class VerifyRetained33 extends VerifyFeatures33 {
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO32.swf"),false);
  hiders(old,s);crowdedCache(old,s);cacheLimits(s);geometry32(s);visibility25(s);market25(s);
  System.out.println("PASS: retained33 hider/controller behavior, cache, clipped floors, immediate invisible-mobi updates and marketplace callbacks verified.");
 }
}
