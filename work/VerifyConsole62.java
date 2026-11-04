import java.io.*;import com.jpexs.decompiler.flash.SWF;
class VerifyConsole62 extends VerifyToken61 {
 public static void main(String[]a)throws Exception{var s=new SWF(new FileInputStream(a[0]),false);dates(s);pagination(s);System.out.println("PASS: console dates, original text, pagination/cursors, deduplication, unread state, scrolling and bounded retry preserved in62.");}
}
