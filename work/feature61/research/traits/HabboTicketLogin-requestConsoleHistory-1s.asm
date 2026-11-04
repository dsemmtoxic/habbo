

code
   getlocal0
   pushscope
   debug 1, "peer", 0, 0
   debug 1, "state", 1, 0
   debug 1, "now", 2, 1235
   debug 1, "C", 3, 1236
   getlex QName(PrivateNamespace("loginpatch:HabboTicketLogin"),"_messenger")
   pushnull
   equals
   dup
   iftrue ofs0033
   pop
   getlex QName(PrivateNamespace("loginpatch:HabboTicketLogin"),"_messenger")
   getproperty Multiname("disposed",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
ofs0033:
   dup
   iftrue ofs003e
   pop
   getlocal2
   getproperty Multiname("pending",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
ofs003e:
   dup
   iftrue ofs004a
   pop
   getlocal2
   getproperty Multiname("more",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   not
ofs004a:
   iffalse ofs004f
   returnvoid
ofs004f:
   findpropstrict QName(PackageNamespace("flash.utils"),"getTimer")
   callproperty QName(PackageNamespace("flash.utils"),"getTimer"), 0
   convert_i
   setlocal3
   getlocal3
   getlocal2
   getproperty Multiname("last",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   convert_i
   subtract
   pushshort 4000
   ifnlt ofs0068
   returnvoid
ofs0068:
   findpropstrict QName(PrivateNamespace("loginpatch:HabboTicketLogin"),"klass")
   pushstring "loginpatch::ConsoleHistoryPayload"
   callproperty QName(PrivateNamespace("loginpatch:HabboTicketLogin"),"klass"), 1
   coerce QName(PackageNamespace(""),"Class")
   setlocal 4
   getlocal2
   getlocal2
   getproperty Multiname("cursor",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   convert_s
   setproperty Multiname("requested",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   getlocal2
   getlocal3
   setproperty Multiname("last",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   getlocal2
   pushtrue
   setproperty Multiname("pending",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   getlex QName(PrivateNamespace("loginpatch:HabboTicketLogin"),"_messenger")
   getlocal 4
   getlocal1
   getlocal2
   getproperty Multiname("cursor",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")])
   convert_s
   construct 2
   callpropvoid Multiname("send",[PackageNamespace(""),Namespace("http://adobe.com/AS3/2006/builtin"),PackageNamespace("loginpatch"),PackageInternalNs("loginpatch"),PrivateNamespace("loginpatch:HabboTicketLogin"),ProtectedNamespace("loginpatch:HabboTicketLogin"),StaticProtectedNs("loginpatch:HabboTicketLogin"),PrivateNamespace("HabboTicketLogin.as$4144")]), 1
   findpropstrict QName(PackageNamespace("flash.utils"),"setTimeout")
   getlex QName(PackageNamespace(""),"consoleHistoryTimeout")
   pushshort 10000
   getlocal1
   getlocal2
   callpropvoid QName(PackageNamespace("flash.utils"),"setTimeout"), 4
   returnvoid
end ; code
