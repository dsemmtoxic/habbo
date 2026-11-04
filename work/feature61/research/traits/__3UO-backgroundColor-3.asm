

code
   getlocal0
   pushscope
   getlocal1
   findproperty QName(PrivateNamespace("away3d.containers:View3D"),"_-34")
   swap
   setproperty QName(PrivateNamespace("away3d.containers:View3D"),"_-34")
   getlex QName(ProtectedNamespace("away3d.containers:View3D"),"_-37g")
   getlocal1
   pushbyte 16
   rshift
   pushshort 255
   bitand
   pushshort 255
   divide
   setproperty QName(PackageInternalNs("away3d:arcane"),"backgroundR")
   getlex QName(ProtectedNamespace("away3d.containers:View3D"),"_-37g")
   getlocal1
   pushbyte 8
   rshift
   pushshort 255
   bitand
   pushshort 255
   divide
   setproperty QName(PackageInternalNs("away3d:arcane"),"backgroundG")
   getlex QName(ProtectedNamespace("away3d.containers:View3D"),"_-37g")
   getlocal1
   pushshort 255
   bitand
   pushshort 255
   divide
   setproperty QName(PackageInternalNs("away3d:arcane"),"backgroundB")
   returnvoid
end ; code
