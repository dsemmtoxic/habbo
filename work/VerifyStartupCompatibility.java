import java.io.*;
import java.nio.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.ABC;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;

// Local execution of the saved AVM2 methods. This is deliberately a narrow
// interpreter: unsupported opcodes/calls fail instead of silently approximating
// behavior. Service, event and UI fixtures never access the network or billing.
class VerifyStartupCompatibility {
  record Method(AuditStartup.Cls cls,MethodBody body) {}
  record Ref(String name) {}
  record Bound(Object receiver,String name) {}
  static class Obj extends LinkedHashMap<Object,Object> {
    final String type;Obj(String type){this.type=type;}
    @Override public String toString(){return "Obj("+type+")";}
  }
  static class FixtureError extends RuntimeException {FixtureError(String s){super(s);}}
  static class Reader {
    final ByteBuffer b;Reader(byte[] bytes){b=ByteBuffer.wrap(bytes).order(ByteOrder.BIG_ENDIAN);}
    int integer(){return b.getInt();}int shortInteger(){return b.getShort();}boolean bool(){return b.get()!=0;}
    String string(){int n=Short.toUnsignedInt(b.getShort());byte[] out=new byte[n];b.get(out);return new String(out,StandardCharsets.UTF_8);}
  }
  static class Packet {
    final ByteArrayOutputStream bytes=new ByteArrayOutputStream();final DataOutputStream out=new DataOutputStream(bytes);
    Packet i(int n)throws Exception{out.writeInt(n);return this;}Packet h(int n)throws Exception{out.writeShort(n);return this;}
    Packet b(boolean b)throws Exception{out.writeBoolean(b);return this;}
    Packet s(String s)throws Exception{byte[] a=s.getBytes(StandardCharsets.UTF_8);out.writeShort(a.length);out.write(a);return this;}
    byte[] bytes(){return bytes.toByteArray();}
  }
  static void check(boolean x,String why){if(!x)throw new AssertionError(why);}
  static Object pop(List<Object> s){check(!s.isEmpty(),"Operand stack underflow");return s.remove(s.size()-1);}
  static int int32(double value){if(!Double.isFinite(value)||value==0)return 0;double integer=value<0?Math.ceil(value):Math.floor(value);double modulo=integer%4294967296.0;if(modulo<0)modulo+=4294967296.0;if(modulo>=2147483648.0)modulo-=4294967296.0;return (int)modulo;}
  static int num(Object x){if(x==null)return 0;if(x instanceof Double||x instanceof Float)return int32(((Number)x).doubleValue());if(x instanceof Number)return ((Number)x).intValue();if(x instanceof Boolean)return (Boolean)x?1:0;try{return int32(Double.parseDouble(String.valueOf(x)));}catch(NumberFormatException e){return 0;}}
  static double number(Object x){if(x==null)return 0;if(x instanceof Number)return ((Number)x).doubleValue();if(x instanceof Boolean)return (Boolean)x?1:0;String s=String.valueOf(x).trim();if(s.isEmpty())return 0;try{return Double.parseDouble(s);}catch(NumberFormatException e){return Double.NaN;}}
  static boolean truth(Object x){return x!=null&&!Boolean.FALSE.equals(x)&&(!(x instanceof Number)||((Number)x).doubleValue()!=0&&!Double.isNaN(((Number)x).doubleValue()))&&(!(x instanceof String)||!((String)x).isEmpty());}
  // AVM2 equals coerces Boolean/number/string primitives; strictequals does
  // not. TradingModel compares the Boolean userAccepts getter with integer 0.
  static boolean strictEqual(Object a,Object b){if(a instanceof Number&&b instanceof Number)return ((Number)a).doubleValue()==((Number)b).doubleValue();if(a instanceof Map||b instanceof Map||a instanceof List||b instanceof List)return a==b;return Objects.equals(a,b);}
  static boolean equal(Object a,Object b){if(a==null||b==null)return a==b;if(a instanceof Boolean||b instanceof Boolean||a instanceof Number&&b instanceof String||a instanceof String&&b instanceof Number)return number(a)==number(b);return strictEqual(a,b);}
  static boolean relation(Object a,Object b,int op){double l,r;if(a instanceof String x&&b instanceof String y){l=x.compareTo(y);r=0;}else{l=number(a);r=number(b);}return switch(op){case 0->l<r;case 1->l<=r;case 2->l>r;case 3->l>=r;default->throw new AssertionError("Invalid relational operator");};}
  static class VM {
    Integer activationSlot(Method m,Object receiver,int multiname){
      if(!(receiver instanceof Obj o)||!o.type.equals("activation"))return null;
      var abc=m.cls().abc();String q=AuditStartup.q(abc,multiname);int assigned=0;
      for(var tr:m.body().traits.traits)if(tr instanceof TraitSlotConst slot){int id=slot.slot_id==0?assigned+1:slot.slot_id;assigned=Math.max(assigned,id);if(AuditStartup.q(abc,tr.name_index).equals(q))return id;}
      return null;
    }
    final Map<String,AuditStartup.Cls> classes;final Map<String,AuditStartup.Cls> raw=new HashMap<>();
    final Obj statics=new Obj("loginpatch::HabboTicketLogin"),globals=new Obj("globals");
    final List<String> calls=new ArrayList<>();
    VM(SWF swf){classes=AuditStartup.classes(swf);for(var c:classes.values())raw.put(c.raw(),c);statics.put("_silverOffers",new HashMap<Object,Object>());statics.put("_controller",null);statics.put("_consoleMetadata",new IdentityHashMap<Object,Object>());statics.put("_consoleConfirmations",new IdentityHashMap<Object,Object>());statics.put("_nextConsoleConfirmation",1);statics.put("_consoleLiveIds",new HashMap<Object,Object>());statics.put("_consoleLivePeers",new HashMap<Object,Object>());statics.put("_consoleHistoryIds",new HashMap<Object,Object>());statics.put("_typingVisible",true);}
    Method method(String owner,String name) {
      var c=classes.get(owner);if(c==null)throw new AssertionError("Missing class "+owner);
      if(name.equals("<init>"))return new Method(c,c.abc().findBody(c.inst().iinit_index));
      var traits=new ArrayList<Trait>();traits.addAll(c.inst().instance_traits.traits);traits.addAll(c.abc().class_info.get(c.index()).static_traits.traits);
      for(var t:traits)if(t instanceof TraitMethodGetterSetter&&name.equals(AuditStartup.name(c.abc(),t.name_index)))return new Method(c,c.abc().findBody(((TraitMethodGetterSetter)t).method_info));
      throw new AssertionError("Missing method "+owner+"."+name);
    }
    Object lexical(Method m,Obj self,String n,int multiname) {
      String q=AuditStartup.q(m.cls.abc(),multiname);
      if(self.containsKey(n))return self.get(n);
      if(statics.containsKey(n))return statics.get(n);
      if(self.type.equals("loginpatch::HabboTicketLogin"))for(var t:m.cls.abc().class_info.get(m.cls.index()).static_traits.traits)if(t instanceof TraitSlotConst slot&&n.equals(AuditStartup.name(m.cls.abc(),t.name_index))){String type=AuditStartup.name(m.cls.abc(),slot.type_index);return "Boolean".equals(type)?false:("int".equals(type)||"uint".equals(type)?0:null);}
      if(raw.containsKey(q))return new Ref(q);
      if(Set.of("Math","Date","Vector","Dictionary","getQualifiedClassName","Error","ArgumentError").contains(n))return new Ref(n);
      if(n.equals("_-3gH"))return new Ref(q);
      throw new AssertionError("Unknown lexical property "+n+" in "+m.cls.logical());
    }
    @SuppressWarnings("unchecked") Object get(Object receiver,Object key) {
      if(receiver==null)throw new NullPointerException("Fixture dereference of absent service: "+key);
      if(receiver instanceof Reader r){if(key.equals("bytesAvailable"))return r.b.remaining();if(Set.of("_-0u0","_-nr").contains(key))return new Bound(r,String.valueOf(key));}
      if(receiver instanceof Obj o&&String.valueOf(key).equals("_-0tq")&&o.containsKey("__payload"))return new Bound(o,"fixture-payload");
      if(receiver instanceof Map)return ((Map<Object,Object>)receiver).get(key);
      if(receiver instanceof List<?> list){if(key.equals("length"))return list.size();int n=num(key);return n>=0&&n<list.size()?list.get(n):null;}
      throw new AssertionError("Unsupported get "+key+" on "+receiver);
    }
    @SuppressWarnings("unchecked") void set(Object receiver,Object key,Object value) {
      check(receiver instanceof Map,"Unsupported property setter "+key);((Map<Object,Object>)receiver).put(key,value);
    }
    boolean has(Object receiver,Object key){
      if(receiver instanceof Map map&&map.containsKey(key))return true;
      if(receiver instanceof Obj o){var c=raw.get(o.type);while(c!=null){for(var t:c.inst().instance_traits.traits)if(AuditStartup.name(c.abc(),t.name_index).equals(key))return true;c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}}
      if(receiver instanceof List list)return key.equals("length")||num(key)>=0&&num(key)<list.size();
      return false;
    }
    boolean instanceOf(Object value,String type){
      if(value instanceof Number&&(type.equals("Number")||type.equals("::Number")))return true;
      if(value instanceof List&&(type.equals("Array")||type.equals("::Array")))return true;
      if(!(value instanceof Obj o))return false;var pending=new ArrayDeque<String>();var seen=new HashSet<String>();pending.add(o.type);
      while(!pending.isEmpty()){String name=pending.removeFirst();if(!seen.add(name))continue;if(name.equals(type))return true;var c=raw.get(name);if(c==null)continue;pending.add(AuditStartup.q(c.abc(),c.inst().super_index));for(int i:c.inst().interfaces)pending.add(AuditStartup.q(c.abc(),i));}return false;
    }
    Object construct(String type,List<Object> args) {
      if(type.equals("Date"))return new Ref("fixed-fixture-date");
      if(type.equals("Dictionary"))return new HashMap<Object,Object>();
      if(type.equals("Error")||type.equals("ArgumentError"))return new FixtureError(String.valueOf(args.get(0)));
      if(type.equals("fixture-parser"))return new Obj("fixture-parser-instance");
      if(type.equals("vector"))return new ArrayList<Object>();
      var cls=raw.get(type);if(cls==null)throw new AssertionError("Unknown constructor "+type);
      var result=new Obj(type);execute(method(cls.logical(),"<init>"),result,args.toArray());return result;
    }
    void constructSuper(Method method,Obj self,List<Object> args) {}
    @SuppressWarnings("unchecked") Object call(Object receiver,String name,List<Object> args) {
      if(receiver==null)throw new NullPointerException("Fixture call on absent service: "+name);
      if(receiver==globals&&raw.containsKey(name)&&args.size()==1&&instanceOf(args.get(0),name))return args.get(0);
      if(receiver instanceof Reader r)return switch(name){case "_-0u0","readInteger"->r.integer();case "_-nr","readString"->r.string();case "readBoolean"->r.bool();case "readShort"->r.shortInteger();default->throw new AssertionError("Unknown wire reader "+name);};
      if(receiver instanceof List<?> original) {
        var list=(List<Object>)original;
        if(name.equals("push")){list.addAll(args);return list.size();}
        if(name.equals("slice")){return new ArrayList<>(list.subList(args.isEmpty()?0:num(args.get(0)),args.size()<2?list.size():Math.min(list.size(),num(args.get(1)))));}
        if(name.equals("concat")){var result=new ArrayList<Object>(list);for(Object arg:args)if(arg instanceof List)result.addAll((List<?>)arg);else result.add(arg);return result;}
        if(name.equals("join"))return list.stream().map(v->v==null?"":String.valueOf(v)).collect(java.util.stream.Collectors.joining(args.isEmpty()?",":String.valueOf(args.get(0))));
      }
      if(receiver instanceof Ref ref) {
        if(ref.name.equals("Math")&&name.equals("max"))return Math.max(num(args.get(0)),num(args.get(1)));
        if(ref.name.equals("loginpatch::HabboTicketLogin"))return execute(method("loginpatch:HabboTicketLogin",name),statics,args.toArray());
      }
      if(name.equals("getQualifiedClassName")){Object arg=args.get(0);check(arg instanceof Obj,"Class name expected a fixture object");return ((Obj)arg).type;}
      if(receiver instanceof Obj o) {
        if(name.equals("getInAppPurchaser"))return o.get("inAppPurchaser");
        if(name.equals("fixture-payload"))return o.get("__payload");
        if(Set.of("addEventListener","removeEventListener","restorePurchases","_-4-T","reset","hide","hotlooks","alert").contains(name)){calls.add(name+":"+args);return null;}
      }
      throw new AssertionError("Unsupported call "+name+" on "+receiver);
    }
    Object invokeSuper(Method m,Obj self,String name,List<Object> args){calls.add("super:"+name+":"+args);return null;}
    void validatePropertyCall(Method method,Object receiver,int multiname) {}
    int instructionBudget(){return 100000;}
    Object execute(Method m,Obj self,Object... args) {
      var a=m.cls.abc();var body=m.body;check(body!=null,"Missing executable body");var code=body.getCode().code;
      var info=a.method_info.get(body.method_info);Object[] locals=new Object[Math.max(body.max_regs,Math.max(args.length,info.param_types.length)+1)];locals[0]=self;System.arraycopy(args,0,locals,1,args.length);
      int firstOptional=info.param_types.length-info.optional.length;
      for(int i=args.length;i<info.param_types.length;i++)if(i>=firstOptional){var value=info.optional[i-firstOptional];locals[i+1]=switch(value.value_kind){case 10->false;case 11->true;case 12,0->null;case 3->a.constants.getInt(value.value_index);case 4->a.constants.getUInt(value.value_index);case 6->a.constants.getDouble(value.value_index);case 1->a.constants.getString(value.value_index);default->throw new AssertionError("Unsupported optional default kind "+value.value_kind);};}
      // AVM2 coerces primitive arguments against the method signature.
      for(int i=0;i<info.param_types.length;i++){
        String type=info.param_types[i]==0?"*":Objects.toString(AuditStartup.name(a,info.param_types[i]),"*");Object value=locals[i+1];
        if(type.equals("int")||type.equals("uint"))locals[i+1]=num(value);
        else if(type.equals("Number")){try{locals[i+1]=value instanceof Number?((Number)value).doubleValue():Double.parseDouble(String.valueOf(value));}catch(NumberFormatException ex){locals[i+1]=Double.NaN;}}
      }
      var stack=new ArrayList<Object>();var scopes=new ArrayList<Object>();var offsets=new HashMap<Long,Integer>();for(int i=0;i<code.size();i++)offsets.put(code.get(i).getAddress(),i);
      int pc=0,steps=0;
      while(pc<code.size()&&++steps<instructionBudget()) {
        var ins=code.get(pc++);int op=ins.getBytes()[0]&255;var v=ins.operands;
        try {
        if(op>=0xd0&&op<=0xd3){stack.add(locals[op-0xd0]);continue;}if(op>=0xd4&&op<=0xd7){locals[op-0xd4]=pop(stack);continue;}
        switch(op) {
          case 0x02:case 0x09:case 0xef:case 0xf0:case 0xf1:break;
          case 0x08:locals[v[0]]=null;break;
          case 0x20:case 0x21:stack.add(null);break;
          case 0x24:stack.add((int)(byte)v[0]);break;
          case 0x25:stack.add(v[0]);break;
          case 0x26:stack.add(true);break;
          case 0x27:stack.add(false);break;
          case 0x28:stack.add(Double.NaN);break;
          case 0x29:pop(stack);break;
          case 0x2a:stack.add(stack.get(stack.size()-1));break;
          case 0x2b:{Object x=pop(stack),y=pop(stack);stack.add(x);stack.add(y);break;}
          case 0x2c:stack.add(a.constants.getString(v[0]));break;
          case 0x2d:stack.add(a.constants.getInt(v[0]));break;
          case 0x2f:stack.add(a.constants.getDouble(v[0]));break;
          case 0x32:{Object object=locals[v[0]];int index=num(locals[v[1]]);int length=object instanceof List<?> l?l.size():object instanceof Map<?,?> map?map.size():0;boolean more=index<length;if(more)locals[v[1]]=index+1;else{locals[v[0]]=null;locals[v[1]]=0;}stack.add(more);break;}
          case 0x1e:{int index=num(pop(stack))-1;Object object=pop(stack);if(object instanceof Map<?,?> map)stack.add(new ArrayList<>(map.keySet()).get(index));else stack.add(index);break;}
          case 0x23:{int index=num(pop(stack))-1;Object object=pop(stack);if(object instanceof List<?> list)stack.add(list.get(index));else if(object instanceof Map<?,?> map)stack.add(new ArrayList<>(map.values()).get(index));else throw new AssertionError("Unsupported iteration receiver");break;}
          case 0x30:scopes.add(pop(stack));break;
          case 0x5a:stack.add(new Obj("avm2-catch-scope"));break;
          case 0x1d:scopes.remove(scopes.size()-1);break;
          case 0x65:stack.add(scopes.get(v[0]));break;
          case 0x6c:stack.add(get(pop(stack),v[0]));break;
          case 0x6d:{Object value=pop(stack);set(pop(stack),v[0],value);break;}
          case 0x62:stack.add(locals[v[0]]);break;
          case 0x63:locals[v[0]]=pop(stack);break;
          case 0x64:stack.add(globals);break;
          case 0x70:case 0x85:{Object x=pop(stack);stack.add(x==null?null:String.valueOf(x));break;}
          case 0x73:stack.add(num(pop(stack)));break;
          case 0x75:stack.add(number(pop(stack)));break;
          case 0xa2:{Object r=pop(stack),l=pop(stack);stack.add(((Number)l).doubleValue()*((Number)r).doubleValue());break;}
          case 0xa4:{double r=((Number)pop(stack)).doubleValue(),l=((Number)pop(stack)).doubleValue();stack.add(l%r);break;}
          case 0xa5:case 0xa6:case 0xa7:{int r=num(pop(stack)),l=num(pop(stack));stack.add(op==0xa5?l<<r:op==0xa6?l>>r:l>>>r);break;}
          case 0xa8:{int r=num(pop(stack)),l=num(pop(stack));stack.add(l&r);break;}
          case 0xa9:{int r=num(pop(stack)),l=num(pop(stack));stack.add(l|r);break;}
          case 0xac:{Object r=pop(stack),l=pop(stack);stack.add(strictEqual(l,r));break;}
          case 0x76:stack.add(truth(pop(stack)));break;
          case 0x74:stack.add(Integer.toUnsignedLong(num(pop(stack))));break;
          case 0x80:case 0x82:break;
          case 0x87:{pop(stack);Object value=pop(stack);stack.add(value);break;}
          case 0x96:stack.add(!truth(pop(stack)));break;
          case 0xc2:case 0x92:locals[v[0]]=num(locals[v[0]])+1;break;
          case 0xc3:locals[v[0]]=num(locals[v[0]])-1;break;
          case 0x91:case 0xc0:stack.add(num(pop(stack))+1);break;
          case 0x2e:stack.add(a.constants.getUInt(v[0]));break;
          case 0x90:stack.add(-number(pop(stack)));break;
          case 0x93:case 0xc1:stack.add(num(pop(stack))-1);break;
          case 0xa0:{Object right=pop(stack),left=pop(stack);if(left instanceof String||right instanceof String)stack.add(String.valueOf(left)+right);else if(left instanceof Double||right instanceof Double)stack.add(((Number)left).doubleValue()+((Number)right).doubleValue());else stack.add(num(left)+num(right));break;}
          case 0xa1:{Object right=pop(stack),left=pop(stack);if(left instanceof Double||right instanceof Double)stack.add(((Number)left).doubleValue()-((Number)right).doubleValue());else stack.add(num(left)-num(right));break;}
          case 0xc6:{int right=num(pop(stack)),left=num(pop(stack));stack.add(left-right);break;}
          case 0xa3:{double right=((Number)pop(stack)).doubleValue(),left=((Number)pop(stack)).doubleValue();stack.add(left/right);break;}
          case 0xab:case 0xad:case 0xae:case 0xaf:case 0xb0:{Object r=pop(stack),l=pop(stack);stack.add(op==0xab?equal(l,r):relation(l,r,op-0xad));break;}
          case 0x57:stack.add(new Obj("activation"));break;
          case 0x95:{Object value=pop(stack);stack.add(value instanceof String?"string":value instanceof Number?"number":value instanceof Boolean?"boolean":value instanceof Bound?"function":"object");break;}
          case 0x56:{var list=new ArrayList<Object>();for(int i=0;i<v[0];i++)list.add(0,pop(stack));stack.add(list);break;}
          case 0x55:{var object=new Obj("Object");for(int i=0;i<v[0];i++){Object value=pop(stack),key=pop(stack);object.put(key,value);}stack.add(object);break;}
          case 0x53:{for(int i=0;i<v[0];i++)pop(stack);pop(stack);stack.add(new Ref("vector"));break;}
          case 0x5d:case 0x5e:{String n=AuditStartup.name(a,v[0]);String q=AuditStartup.q(a,v[0]);Object receiver=null;for(int si=scopes.size()-1;si>=0;si--)if(activationSlot(m,scopes.get(si),v[0])!=null){receiver=scopes.get(si);break;}stack.add(receiver!=null?receiver:raw.containsKey(q)||Set.of("Date","Math","Dictionary","Error","ArgumentError","getQualifiedClassName").contains(n)?globals:self);break;}
          case 0x60:{
            // Captured locals are traits of the activation scope. Resolve the
            // actual QName/slot before falling back to instance/static traits.
            boolean found=false;
            for(int si=scopes.size()-1;si>=0&&!found;si--){Object scope=scopes.get(si);Integer id=activationSlot(m,scope,v[0]);if(id!=null){stack.add(get(scope,id));found=true;}}
            if(!found)stack.add(lexical(m,self,AuditStartup.name(a,v[0]),v[0]));break;
          }
          case 0x66:{var mn=a.constants.getMultiname(v[0]);Object key=mn.name_index==0?pop(stack):AuditStartup.name(a,v[0]);Object receiver=pop(stack);Integer slot=activationSlot(m,receiver,v[0]);stack.add(get(receiver,slot==null?key:slot));break;}
          case 0x61:case 0x68:{Object value=pop(stack);var mn=a.constants.getMultiname(v[0]);Object key=mn.name_index==0?pop(stack):AuditStartup.name(a,v[0]);Object receiver=pop(stack);Integer slot=activationSlot(m,receiver,v[0]);set(receiver,slot==null?key:slot,value);break;}
          case 0x6a:{var mn=a.constants.getMultiname(v[0]);Object key=mn.name_index==0?pop(stack):AuditStartup.name(a,v[0]);Object receiver=pop(stack);check(receiver instanceof Map,"Unsupported delete receiver");((Map<?,?>)receiver).remove(key);stack.add(true);break;}
          case 0xb2:{Object value=pop(stack);String type=AuditStartup.q(a,v[0]);stack.add((value instanceof Number&&type.equals("::Number"))||(value instanceof List&&type.equals("::Array"))||(value instanceof Obj&&((Obj)value).type.equals(type)));break;}
          case 0xb4:{Object receiver=pop(stack),key=pop(stack);stack.add(has(receiver,key));break;}
          case 0xb3:{Object type=pop(stack),value=pop(stack);stack.add(type instanceof Ref t&&instanceOf(value,t.name()));break;}
          case 0x49:{var p=new ArrayList<Object>();for(int i=0;i<v[0];i++)p.add(0,pop(stack));check(pop(stack)==self,"Unexpected super constructor receiver");constructSuper(m,self,p);break;}
          case 0x42:{var p=new ArrayList<Object>();for(int i=0;i<v[0];i++)p.add(0,pop(stack));Object c=pop(stack);String type=c instanceof Ref r?r.name:null;if(type==null&&c==self){for(var tr:m.cls.abc().class_info.get(m.cls.index()).static_traits.traits)if(tr instanceof TraitMethodGetterSetter mt&&mt.method_info==body.method_info){type=self.type;break;}}check(type!=null,"Expected constructible type in "+m.cls.logical()+" at "+ins.getAddress()+"; received "+(c==null?"null":c instanceof Obj o?o.type:c.getClass().getSimpleName()));stack.add(construct(type,p));break;}
          case 0x4a:{
            var p=new ArrayList<Object>();for(int i=0;i<v[1];i++)p.add(0,pop(stack));Object receiver=pop(stack);String n=AuditStartup.name(a,v[0]),q=AuditStartup.q(a,v[0]);
            String type=n.equals("_-ao")?((Ref)get(receiver,n)).name:raw.containsKey(q)?q:n;stack.add(construct(type,p));break;
          }
          case 0x41:{
            var p=new ArrayList<Object>();for(int i=0;i<v[0];i++)p.add(0,pop(stack));Object receiver=pop(stack),function=pop(stack);
            if(function instanceof Bound bound)stack.add(call(bound.receiver,bound.name,p));
            else if(function instanceof Ref ref)stack.add(call(receiver,ref.name,p));else throw new AssertionError("Not callable "+function+" receiver="+receiver+" in "+m.cls.logical()+" at "+ins.getAddress());break;
          }
          case 0x45:case 0x46:case 0x4f:case 0x4e:{
            var p=new ArrayList<Object>();for(int i=0;i<v[1];i++)p.add(0,pop(stack));Object receiver=pop(stack);String n=AuditStartup.name(a,v[0]);Object result;
            if(op==0x4e||op==0x45){result=invokeSuper(m,self,n,p);}
            else if(receiver==globals&&raw.containsKey(AuditStartup.q(a,v[0])))throw new AssertionError("Unexpected class call");
            else {validatePropertyCall(m,receiver,v[0]);result=call(receiver,n,p);}
            if(op==0x46||op==0x45)stack.add(result);break;
          }
          case 0x03:{Object error=pop(stack);if(error instanceof RuntimeException)throw (RuntimeException)error;throw new AssertionError("AVM2 throw "+error);}
          // AVM2 returnvoid discards the current operand stack. In particular,
          // this client's native trace-and-return upload guard leaves undefined.
          case 0x47:return null;
          case 0x48:{Object result=pop(stack);check(stack.isEmpty(),"Stack not empty at value return");return result;}
          case 0x1b:{int selector=num(pop(stack));int relative=selector<0||selector>v[1]?v[0]:v[selector+2];Integer dest=offsets.get(ins.getAddress()+relative);check(dest!=null,"Invalid switch target");pc=dest;break;}
          case 0x10:case 0x11:case 0x12:case 0x13:case 0x14:case 0x15:case 0x16:case 0x17:case 0x18:case 0x19:case 0x1a:case 0x0c:case 0x0d:case 0x0e:case 0x0f:{
            boolean jump=true;
            if(op==0x11||op==0x12){boolean value=truth(pop(stack));jump=op==0x11?value:!value;}
            else if(op!=0x10){Object r=pop(stack),l=pop(stack);jump=switch(op){case 0x13->equal(l,r);case 0x14->!equal(l,r);case 0x19->strictEqual(l,r);case 0x1a->!strictEqual(l,r);case 0x15,0x16,0x17,0x18->relation(l,r,op-0x15);case 0x0c,0x0d,0x0e,0x0f->!relation(l,r,op-0x0c);default->throw new AssertionError();};}
            if(jump){Integer dest=offsets.get(ins.getAddress()+ins.getBytes().length+v[0]);check(dest!=null,"Invalid branch target");pc=dest;}break;
          }
          default:throw new AssertionError("Unsupported opcode 0x"+Integer.toHexString(op)+" in "+m.cls.logical());
        }
        check(stack.size()<=body.max_stack,"Saved max_stack too small");
        } catch(FixtureError error) {
          Integer target=null;
          for(var handler:body.exceptions)if(ins.getAddress()>=handler.start&&ins.getAddress()<handler.end) {
            String type=handler.type_index==0?"*":AuditStartup.name(a,handler.type_index);
            if(Set.of("*","Error","ArgumentError").contains(type)){target=offsets.get((long)handler.target);break;}
          }
          if(target==null)throw error;
          stack.clear();stack.add(error);scopes.clear();pc=target;
        }
      }
      throw new AssertionError("Method did not terminate in "+m.cls.logical());
    }
  }
  static String msg(String suffix){return "com.sulake.habbo.communication.messages."+suffix;}
  static Packet recipe(Packet p,int id)throws Exception{return p.s("recipe-"+id).s("product-"+id).s(id%2==0?"":"furniture-class-"+id);}
  static Packet achievement(Packet p,int id)throws Exception{return p.i(id).i(2).s("badge-"+id).i(5).i(10).i(20).i(0).i(8).b(false).s("explore").s("rooms").i(10).i(0).h(id%3);}
  static Packet quest(Packet p,int id,boolean seasonal)throws Exception{p.s("campaign-"+id).i(1).i(3).i(0).i(id).b(true).s("FIND_STUFF").s("1").i(30).s("quest-"+id).i(2).i(4).i(0).s("catalog").s("chain").b(false).b(seasonal);if(seasonal)p.i(12345);return p;}
  static Packet offer(Packet p,int id,int silver,boolean limited)throws Exception {
    p.i(id).s("offer-"+id).b(false).i(5).i(10).i(0).i(silver).b(true).i(1);
    p.s("s").i(777).s("extra").i(2).b(limited);if(limited)p.i(100).i(55);
    return p.i(1).b(true).b(false).s("preview-"+id);
  }
  static int rows(VM vm,String type,byte[] bytes,int count,String idField)throws Exception {
    var r=new Reader(bytes);var method=vm.method(type,"<init>");
    for(int i=0;i<count;i++){var result=new Obj(method.cls.raw());vm.execute(method,result,r);if(idField!=null)check(Objects.equals(result.get(idField),101+i),"Wrong record identity after a new wire field in "+type);}
    check(r.integer()==0x12345678&&r.b.remaining()==0,"Reader lost the record boundary in "+type);return r.b.position();
  }
  static void testRecords(VM old,VM now,VM oracle)throws Exception {
    int cases=0,reproduced=0;
    for(int count:new int[]{0,1,3})for(int mode=0;mode<3;mode++)for(String kind:List.of("recipe","achievement","quest","offer")) {
      Packet p=new Packet();for(int i=0;i<count;i++){int id=101+i;switch(kind){case "recipe"->recipe(p,id);case "achievement"->achievement(p,id);case "quest"->quest(p,id,(i+mode)%2==0);case "offer"->offer(p,id,mode==0?0:mode==1?20:123456,(i%2)==0);}}
      p.i(0x12345678);String type=switch(kind){case "recipe"->msg("parser.crafting:FurnitureProductItem");case "achievement"->msg("incoming.inventory.achievements:AchievementData");case "quest"->msg("incoming.quest:QuestMessageData");default->msg("incoming.catalog:CatalogPageMessageOfferData");};
      String field=switch(kind){case "recipe"->null;case "achievement"->"_-eR";case "quest"->"_-1tQ";default->"_-2h0";};
      String currentField=switch(kind){case "recipe"->null;case "achievement"->"_achievementId";case "quest"->"_id";default->"_offerId";};
      rows(oracle,type,p.bytes(),count,currentField);rows(now,type,p.bytes(),count,field);cases++;
      if(count>0){boolean failed=false;try{rows(old,type,p.bytes(),count,field);}catch(BufferUnderflowException|IllegalArgumentException|AssertionError expected){failed=true;}check(failed,"Original schema mismatch was not reproduced");reproduced++;}
    }
    System.out.println("PASS: "+cases+" empty/single/multiple record fixtures consume exactly the same bytes as the actual AirPlus constructors, including seasonal branches, limited products and silver prices; reproduced "+reproduced+" original failures.");
  }
  static void testRegistry(VM old,VM now)throws Exception {
    var table=CompareProtocol.read("work/HabboTablet_LoginSSO.swf","_-0cq::_-0z0").entrySet().stream().filter(e->e.getKey().endsWith("::_-0up")).findFirst().orElseThrow().getValue();
    var index=new HashMap<Object,Object>();for(var e:table.entrySet())index.put(now.classes.get(e.getValue()).raw(),e.getKey());
    var self=new Obj("fixture-manager");self.put("_-1Mf",index);self.put("_-17M",new HashMap<Object,Object>());
    var method=now.method("com.sulake.core.communication.messages:MessageClassManager","_-0bA");int accepted=0,skipped=0;
    for(Object type:index.keySet()) {
      var one=new Obj(String.valueOf(type));one.put("_-ao",new Ref("fixture-parser"));now.execute(method,self,one);check(one.get("parser")!=null,"Mapped parser not created");
      var two=new Obj(String.valueOf(type));two.put("_-ao",new Ref("fixture-parser"));now.execute(method,self,two);check(one.get("parser")==two.get("parser"),"Existing parser sharing changed");accepted++;
    }
    for(String line:Files.readAllLines(Path.of("work/startup-audit/retired-events.tsv")).subList(1,14)) {
      String type=line.split("\t")[1];var event=new Obj(type);event.put("_-ao",new Ref("fixture-parser"));
      boolean oldFailed=false;try{old.execute(old.method("com.sulake.core.communication.messages:MessageClassManager","_-0bA"),self,event);}catch(FixtureError expected){oldFailed=true;}
      check(oldFailed,"Retired event failure not reproduced");now.execute(method,self,event);check(!event.containsKey("parser"),"Retired parser was registered");skipped++;
    }
    boolean strict=false;try{now.execute(method,self,new Obj("fixture::unregistered-bug"));}catch(FixtureError expected){strict=true;}check(strict,"Unknown registration bugs were hidden");
    System.out.println("PASS: All "+accepted+" current incoming types register and share parsers; all "+skipped+" specifically retired types skip cleanly; unexpected unknown types still fail.");
  }
  static void testPayloads(VM now) {
    for(var spec:List.of(Map.entry(msg("outgoing.catalog:GetCatalogIndexComposer"),List.of("NORMAL","old-filter")),Map.entry(msg("outgoing.catalog:BuildersClubPlaceRoomItemMessageComposer"),List.of(1,2,"extra",3,4,5)),Map.entry(msg("outgoing.catalog:BuildersClubPlaceWallItemMessageComposer"),List.of(1,2,"extra","wall")),Map.entry(msg("outgoing.friendlist:SendMsgMessageComposer"),List.of(123,"test-message")))) {
      var instance=new Obj(now.classes.get(spec.getKey()).raw());var original=new ArrayList<Object>(spec.getValue());instance.put(spec.getKey().contains("SendMsg")?"_-38i":"_-0SL",original);
      var method=now.method(spec.getKey(),"_-0tq");var expected=new ArrayList<Object>(original);
      if(spec.getKey().contains("GetCatalogIndex"))expected=new ArrayList<>(expected.subList(0,1));
      else if(spec.getKey().contains("SendMsg")){var payload=(List<?>)now.execute(method,instance);check(payload.size()==3&&num(payload.get(2))>0,"Private chat lacks a positive confirmation ID");expected.add(payload.get(2));}
      else expected.add(false);
      check(expected.equals(now.execute(method,instance)),"Incorrect adapted outgoing payload");check(expected.equals(now.execute(method,instance)),"Payload grew on repeated serialization");check(original.equals(spec.getValue()),"Source payload mutated");
    }
    var remember=now.method("loginpatch:HabboTicketLogin","rememberSilverOffer");var blocked=now.method("loginpatch:HabboTicketLogin","blockUnsupportedPurchase");now.execute(remember,now.statics,601,25);now.execute(remember,now.statics,602,0);
    for(String type:List.of("_-1Dj::_-ZX","_-1Dj::_-1hg","fixture::ordinary-message"))for(int offer:new int[]{601,602,603}) {
      var composer=new Obj(type);composer.put("__payload",new ArrayList<Object>(List.of(9,offer,"extra")));
      check(Objects.equals(now.execute(blocked,now.statics,composer),!type.contains("ordinary")&&offer==601),"Incorrect silver purchase gate");
    }
    now.execute(remember,now.statics,601,0);var changed=new Obj("_-1Dj::_-ZX");changed.put("__payload",new ArrayList<Object>(List.of(9,601)));check(Boolean.FALSE.equals(now.execute(blocked,now.statics,changed)),"Price refresh left a stale silver restriction");
    System.out.println("PASS: Four saved composer methods produce current payloads without mutating cached arrays; silver purchase gates affect only the two catalog purchase types with a known silver price.");
  }
  static void testBillingPage(VM old,VM now) {
    String owner="com.sulake.habbo.tablet.catalog.viewer.controller.page:InAppPurchasePageControllerBase";
    for(boolean catalogPresent:new boolean[]{false,true})for(boolean service:new boolean[]{false,true}) {
      var catalog=new Obj("catalog");var purchaser=new Obj("purchaser");purchaser.put("productsReady",false);catalog.put("inAppPurchaser",service?purchaser:null);
      var page=new Obj("page");page.put("_-3HX",catalogPresent?catalog:null);page.put("_-23d",new ArrayList<>());page.put("_-2oZ",new Obj("popup"));page.put("_-4-T",new Ref("handler"));
      now.calls.clear();now.execute(now.method(owner,"disposeView"),page);check(page.get("_-23d")==null&&page.get("_-2oZ")==null&&now.calls.stream().anyMatch(x->x.startsWith("super:disposeView:")),"Billing cleanup was skipped");
      check(now.calls.stream().filter(x->x.startsWith("removeEventListener:")).count()==(catalogPresent&&service?1:0),"Incorrect optional listener removal");
      page.put("_-3lo",new Obj("view"));now.calls.clear();now.execute(now.method(owner,"update"),page,1,"page",null,new ArrayList<>(),"NORMAL",0,false);
      check(now.calls.stream().anyMatch(x->x.startsWith("super:update:")),"Billing page setup was skipped");check(now.calls.stream().filter(x->x.startsWith("addEventListener:")).count()==(catalogPresent&&service?1:0),"Missing-service page registered billing listener");
    }
    System.out.println("PASS: Remaining billing-page cleanup and update handle absent catalog/service while retaining superclass cleanup and existing-service listeners.");
  }
  static void testOtherGuards(VM now) {
    for(String[] spec:new String[][]{
      {"com.sulake.habbo.tablet.catalog.viewer.controller.page:InAppPurchasePageControllerBase","_-4AR"},
      {"com.sulake.habbo.tablet.catalog:CatalogViewController","_-2w9"},{"com.sulake.habbo.tablet.catalog:CatalogViewController","_-nW"},{"com.sulake.habbo.tablet.catalog:CatalogViewController","_-4OL"},
      {"com.sulake.habbo.targetedoffers:TargetedOfferController","_-28f"}
    })for(boolean catalogPresent:new boolean[]{false,true}) {
      var self=new Obj("fixture-view");var catalog=new Obj("catalog");catalog.put("inAppPurchaser",null);self.put("_-3HX",catalogPresent?catalog:null);
      now.calls.clear();now.execute(now.method(spec[0],spec[1]),self,(Object)null);check(now.calls.isEmpty(),"Absent-service callback still invoked billing");
    }
    var editor=new Obj("fixture-editor");editor.put("_-0On",new HashMap<>());editor.put("_-2k1",0);editor.put("_-2X-",null);now.calls.clear();
    now.execute(now.method("com.sulake.habbo.avatareditor:HabboTabletAvatarEditor","_-2aZ"),editor);check(now.calls.isEmpty(),"Hot looks still queried a null legacy session");
    var remember=now.method("loginpatch:HabboTicketLogin","rememberSilverOffer");now.execute(remember,now.statics,701,30);
    for(String name:List.of("send","_-El")) {
      var composer=new Obj("_-1Dj::_-ZX");composer.put("__payload",new ArrayList<Object>(List.of(1,701,"extra")));
      check(Boolean.FALSE.equals(now.execute(now.method("com.sulake.core.communication.connection:SocketConnection",name),new Obj("fixture-socket"),composer)),"Silver purchase reached the socket sender");
    }
    System.out.println("PASS: Deferred purchase/offer callbacks, restore and hot-look fetching handle absent legacy services; unsupported silver purchases stop before both socket send paths.");
  }
  public static void main(String[] args)throws Exception {
    var old=new VM(new SWF(new FileInputStream(args[0]),false));var now=new VM(new SWF(new FileInputStream(args[1]),false));var oracle=new VM(new SWF(new FileInputStream("work/plus.swf"),false));
    testRegistry(old,now);testRecords(old,now,oracle);testPayloads(now);testBillingPage(old,now);testOtherGuards(now);
  }
}
