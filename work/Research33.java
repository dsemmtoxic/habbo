import java.io.*;import java.nio.file.*;import java.util.*;import java.util.regex.*;import com.jpexs.decompiler.flash.SWF;
class Research33 {
 public static void main(String[] a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var selected=new ArrayList<String>();var out=new StringBuilder();var p=Pattern.compile(a[2]);
  for(var c:AuditStartup.classes(s).values())if(p.matcher(c.logical()).find()){out.append(c.logical()).append('\t').append(c.raw()).append('\n');selected.add(AuditStartup.selector(c));}
  Files.createDirectories(Path.of(a[1]).getParent());Files.writeString(Path.of(a[1]),out);Files.writeString(Path.of(a[1]+".select"),String.join(",",selected));System.out.print(out);
 }
}
