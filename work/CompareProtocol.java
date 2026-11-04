import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class CompareProtocol extends PatchOldLogin {
 static Map<String,Map<Integer,String>> read(String path,String registry)throws Exception{
  var result=new TreeMap<String,Map<Integer,String>>();var swf=new SWF(new FileInputStream(path),false);
  for(var tag:swf.getAbcList()){
   var a=tag.getABC();var names=new HashMap<String,String>();for(int ci=0;ci<a.instance_info.size();ci++)names.put(qname(a,a.instance_info.get(ci).name_index),originalName(a,ci));
   for(int ci=0;ci<a.instance_info.size();ci++)if(qname(a,a.instance_info.get(ci).name_index).equals(registry)){
    var code=a.findBody(a.class_info.get(ci).cinit_index).getCode().code;
    for(int i=0;i+3<code.size();i++){var x=code.get(i);var y=code.get(i+1);var z=code.get(i+2);var w=code.get(i+3);int p=y.getBytes()[0]&255;
     if((x.getBytes()[0]&255)!=0x60||(p!=0x24&&p!=0x25&&p!=0x2d)||(z.getBytes()[0]&255)!=0x60||(w.getBytes()[0]&255)!=0x61)continue;
     int id=p==0x2d?a.constants.getInt(y.operands[0]):y.operands[0];String raw=qname(a,z.operands[0]),type=names.getOrDefault(raw,raw);
     if(result.computeIfAbsent(qname(a,x.operands[0]),k->new TreeMap<>()).put(id,type)!=null)throw new IllegalStateException("Duplicate header "+id);
    }
   }
  }
  if(result.isEmpty())throw new IllegalStateException("Registry absent "+registry);return result;
 }
}
