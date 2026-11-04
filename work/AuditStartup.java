import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;

class AuditStartup {
  record Cls(ABC abc,int index,String logical,String raw) {
    InstanceInfo inst(){return abc.instance_info.get(index);}
  }
  static String q(ABC a,int i) {
    if(i==0)return "*";
    var m=a.constants.getMultiname(i);var n=m.getNamespace(a.constants);
    return (n==null?"":n.getRawName(a.constants))+"::"+a.constants.getString(m.name_index);
  }
  static String original(ABC a,int ci) {
    var inst=a.instance_info.get(ci);
    if(inst.protectedNS!=0){String s=a.constants.getNamespace(inst.protectedNS).getRawName(a.constants);if(s.startsWith("com.sulake.")&&s.contains(":"))return s;}
    var traits=new ArrayList<Trait>();traits.addAll(inst.instance_traits.traits);traits.addAll(a.class_info.get(ci).static_traits.traits);
    for(var t:traits){var n=a.constants.getMultiname(t.name_index).getNamespace(a.constants);if(n!=null){String s=n.getRawName(a.constants);if(s.startsWith("com.sulake.")&&s.contains(":"))return s;}}
    return q(a,inst.name_index).replace("::",":");
  }
  static Map<String,Cls> classes(SWF swf) {
    var result=new TreeMap<String,Cls>();
    for(var tag:swf.getAbcList()){var a=tag.getABC();for(int i=0;i<a.instance_info.size();i++){String logical=original(a,i);result.put(logical,new Cls(a,i,logical,q(a,a.instance_info.get(i).name_index)));}}
    return result;
  }
  static String name(ABC a,int i){return a.constants.getString(a.constants.getMultiname(i).name_index);}
  static String resolved(ABC a,int i,Map<String,String> aliases){String raw=q(a,i);return aliases.getOrDefault(raw,raw);}
  static Map<String,String> aliases(Map<String,Cls> classes){var out=new HashMap<String,String>();for(var c:classes.values())out.put(c.raw,c.logical);return out;}
  static String selector(Cls c) {return String.join(".",Arrays.stream(c.raw.replace("::",".").split("\\.")).map(s->s.contains("-")?"§"+s+"§":s).toList());}
  static String wire(MethodBody body,ABC a,Map<String,String> aliases,Map<String,String> readers) {
    var out=new ArrayList<String>();if(body==null)return "";
    for(var ins:body.getCode().code) {
      int op=ins.getBytes()[0]&255;var v=ins.operands;
      if((op==0x46||op==0x4f)&&readers.containsKey(name(a,v[0])))out.add(readers.get(name(a,v[0])));
      else if(op==0x4a) {String type=resolved(a,v[0],aliases);if(type.startsWith("com.sulake.habbo.communication.messages."))out.add("NEW("+type+")");}
    }
    return String.join(" ",out);
  }
  static Map<String,MethodBody> methods(Cls c,Map<String,String> aliases) {
    var result=new TreeMap<String,MethodBody>();var a=c.abc;var ctor=a.method_info.get(c.inst().iinit_index);
    for(int p:ctor.param_types)if(resolved(a,p,aliases).endsWith(":IMessageDataWrapper"))result.put("<init>",a.findBody(c.inst().iinit_index));
    for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter){String n=name(a,t.name_index);int mi=((TraitMethodGetterSetter)t).method_info;var info=a.method_info.get(mi);
      boolean wrapper=false;for(int p:info.param_types)if(resolved(a,p,aliases).endsWith(":IMessageDataWrapper"))wrapper=true;
      if(n.equals("parse")||wrapper)result.put(n,a.findBody(mi));
    }
    return result;
  }
  static String signature(Cls c,Map<String,String> aliases) {
    var info=c.abc.method_info.get(c.inst().iinit_index);var types=new ArrayList<String>();for(int p:info.param_types)types.add(resolved(c.abc,p,aliases));
    return String.join(",",types);
  }
  static String arrayShape(Cls c,String method) {
    for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter && name(c.abc,t.name_index).equals(method)) {
      var b=c.abc.findBody(((TraitMethodGetterSetter)t).method_info);if(b==null)return "";var out=new TreeSet<String>();
      for(var ins:b.getCode().code){int op=ins.getBytes()[0]&255;if(op==0x56)out.add("array:"+ins.operands[0]);else if((op==0x46||op==0x4f)&&"push".equals(name(c.abc,ins.operands[0])))out.add("push:"+ins.operands[1]);}
      return String.join(",",out);
    }
    return "";
  }
  public static void main(String[] args)throws Exception {
    var old=classes(new SWF(new FileInputStream(args[0]),false));var plus=classes(new SWF(new FileInputStream(args[1]),false));
    var ao=aliases(old);var ap=aliases(plus);Path dir=Path.of("work/startup-audit");Files.createDirectories(dir);
    var inventory=new StringBuilder("logical\told_raw\tnew_raw\n");for(var e:old.entrySet())inventory.append(e.getKey()).append('\t').append(e.getValue().raw).append('\t').append(plus.containsKey(e.getKey())?plus.get(e.getKey()).raw:"").append('\n');Files.writeString(dir.resolve("classes.tsv"),inventory);
    var readersOld=new HashMap<String,String>();var readersNew=new HashMap<String,String>();
    for(var pair:List.of(Map.entry(old,readersOld),Map.entry(plus,readersNew))) {
      var cls=pair.getKey();var readers=pair.getValue();var aliases=aliases(cls);
      var wrapper=cls.get("com.sulake.core.communication.messages:IMessageDataWrapper");if(wrapper==null)throw new AssertionError("Missing wrapper interface");
      for(var t:wrapper.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter) {
        var a=wrapper.abc;var info=a.method_info.get(((TraitMethodGetterSetter)t).method_info);String n=name(a,t.name_index);String ret=resolved(a,info.ret_type,aliases);
        System.out.println((cls==old?"old ":"new ")+n+" params="+info.param_types.length+" return="+ret);
        if(info.param_types.length==0)readers.put(n,(cls==old?switch(n){case "_-nr"->"STRING";case "_-0u0"->"INT";case "_-2Dk"->"ID";default->n;}:switch(n){case "readString"->"STRING";case "readInteger"->"INT";case "getID"->"ID";default->n;}));
      }
    }
    var diffs=new StringBuilder("logical\tmethod\told_wire\tnew_wire\n");var oldSelect=new TreeSet<String>();var newSelect=new TreeSet<String>();int compared=0,changed=0;
    for(var e:old.entrySet()) {
      if(!e.getKey().startsWith("com.sulake.habbo.communication.messages.")||!plus.containsKey(e.getKey()))continue;
      var a=e.getValue();var b=plus.get(e.getKey());var ma=methods(a,ao);var mb=methods(b,ap);
      for(var m:ma.entrySet()) {
        MethodBody match=mb.get(m.getKey());if(match==null && ma.size()==1 && mb.size()==1)match=mb.values().iterator().next();
        if(match==null)continue;
        String sa=wire(m.getValue(),a.abc,ao,readersOld),sb=wire(match,b.abc,ap,readersNew);if(sa.isEmpty()&&sb.isEmpty())continue;
        compared++;
        if(!sa.equals(sb)){changed++;diffs.append(e.getKey()).append('\t').append(m.getKey()).append('\t').append(sa).append('\t').append(sb).append('\n');oldSelect.add(selector(a));newSelect.add(selector(b));
          Path pcode=dir.resolve("pcode");Files.createDirectories(pcode);String stem=e.getKey().substring(e.getKey().lastIndexOf(':')+1)+"-"+m.getKey().replace("<","").replace(">","");
          if(m.getValue()!=null)Files.writeString(pcode.resolve(stem+"-old.txt"),m.getValue().getCode().toASMSource(a.abc));Files.writeString(pcode.resolve(stem+"-new.txt"),match.getCode().toASMSource(b.abc));
        }
      }
    }
    Files.writeString(dir.resolve("wire-differences.tsv"),diffs);Files.writeString(dir.resolve("old-select.txt"),String.join(",",oldSelect));Files.writeString(dir.resolve("new-select.txt"),String.join(",",newSelect));
    System.out.println("Compared "+compared+" wire readers; "+changed+" changed primitive/nested-record sequences exported for review.");
    var sessionReport=new StringBuilder("logical\tmethod\tcall\n");var sessionClasses=new TreeSet<String>();
    for(var c:old.values()) {
      var bodies=new LinkedHashMap<String,MethodBody>();bodies.put("<init>",c.abc.findBody(c.inst().iinit_index));
      for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter)bodies.put(name(c.abc,t.name_index),c.abc.findBody(((TraitMethodGetterSetter)t).method_info));
      for(var entry:bodies.entrySet())if(entry.getValue()!=null)for(var ins:entry.getValue().getCode().code) {
        int op=ins.getBytes()[0]&255;if(op!=0x46&&op!=0x4f&&op!=0x66)continue;
        String n=name(c.abc,ins.operands[0]);if(n==null||!Set.of("getHabboWebApiSession","getInAppPurchaser","inAppPurchaser").contains(n))continue;
        sessionReport.append(c.logical).append('\t').append(entry.getKey()).append('\t').append(n).append('\n');sessionClasses.add(selector(c));
      }
    }
    Files.writeString(dir.resolve("legacy-session-calls.tsv"),sessionReport);Files.writeString(dir.resolve("legacy-session-select.txt"),String.join(",",sessionClasses));
    var outDiff=new StringBuilder("logical\told_ctor\tnew_ctor\told_array\tnew_array\n");var oldOut=new TreeSet<String>();var newOut=new TreeSet<String>();
    int outCompared=0,outChanged=0;
    for(var e:old.entrySet())if(e.getKey().startsWith("com.sulake.habbo.communication.messages.outgoing.")&&plus.containsKey(e.getKey())) {
      var a=e.getValue();var b=plus.get(e.getKey());String sa=signature(a,ao),sb=signature(b,ap),xa=arrayShape(a,"_-0tq"),xb=arrayShape(b,"getMessageArray");outCompared++;
      if(!sa.equals(sb)||!xa.equals(xb)){outChanged++;outDiff.append(e.getKey()).append('\t').append(sa).append('\t').append(sb).append('\t').append(xa).append('\t').append(xb).append('\n');oldOut.add(selector(a));newOut.add(selector(b));}
    }
    Files.writeString(dir.resolve("outgoing-differences.tsv"),outDiff);Files.writeString(dir.resolve("old-out-select.txt"),String.join(",",oldOut));Files.writeString(dir.resolve("new-out-select.txt"),String.join(",",newOut));
    System.out.println("Compared "+outCompared+" named outgoing constructors/payload shapes; "+outChanged+" differences need review.");
  }
}
