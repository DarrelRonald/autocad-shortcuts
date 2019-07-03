;;;    custom2013.LSP Version 0.5 for AutoCAD 2013
;;;
;;;    Copyright (C) 2012 by maxwan architects and urbanists BV.
;;;
;;;    Permission to use, copy, modify, and distribute this software
;;;    for any purpose and without fee is hereby granted, provided
;;;    that the above copyright notice appears in all copies and
;;;    that both that copyright notice and the limited warranty and
;;;    restricted rights notice below appear in all supporting
;;;    documentation.
;;;
;;;
;;;

;;;==========================Autoloading lisps============================

(autoload "2t" '("2t"))

(autoload "a2x" '("a2x" "ssf"))

(autoload "ca" '("ca"))

(autoload "caa" '("caa"))

(autoload "cc" '("cc"))

(autoload "cl" '("cl"))

(autoload "cla" '("cla"))

(autoload "layers" '("fl" "fe" "ol"))

(autoload "g" '("g"))

(autoload "k" '("k"))

(autoload "olifant" '("oli"))

(autoload "p2z" '("p2z"))

(autoload "t2z" '("t2z"))

(autoload "volume" '("vol" "cah"))

(autoload "rep" '("rep"))

(autoload "wd" '("wd"))

(autoload "xy" '("xy"))

(autoload "l2x" '("l2x"))

(autoload "pb" '("pb"))

(autoload "Tlen" '("Tlen"))

;;(autoload "spl2pl.vlx" '("spl2pl"))



;;;===================custom maxwan shortcuts==========================

(DEFUN C:AO ()
(COMMAND "AREA" "O"))

(DEFUN C:B1 ()
(COMMAND ".BREAK" PAUSE "@"))

(DEFUN C:B12 ()
(COMMAND ".BREAK" PAUSE "F" PAUSE "@"))

(DEFUN C:B2 ()
(COMMAND "BREAK" PAUSE "F"))

(DEFUN C:BA ()
(COMMAND "-VIEW" "_BACK"))

(DEFUN C:BF ()
(SETVAR "HPSEPARATE" 1)
(SETVAR "HPGAPTOL" 0)
(COMMAND "_-BHATCH" "P" "SOLID"))

(DEFUN C:BF1 ()
(SETVAR "HPSEPARATE" 1)
(COMMAND "_-BHATCH" "P" "SOLID" "A" "G" "1" ""))

(DEFUN C:BFG()
(COMMAND "_-BHATCH" "A" "G" PAUSE ""))

(DEFUN C:BM ()
(IF (= (GETVAR "BLIPMODE") 1) (SETVAR "BLIPMODE" 0) (SETVAR "BLIPMODE" 1)))

(DEFUN C:BOS ()
(SETQ OBJ (ssget))
(PROMPT "select boundary objects....")
(COMMAND "-BOUNDARY" "a" "b" "n" OBJ "" ""))

(DEFUN C:CPL ()
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "pedit" "m" OBJ "" "c" ""))

(DEFUN C:CR ()
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "COPY" OBJ "" "0,0" "" "ROTATE" "P" "" PAUSE PAUSE "REDRAW"))

(DEFUN C:DP ()
(COMMAND "DIST" PAUSE "PER"))

(DEFUN C:ER ()
(PROMPT "Erase except last.....")
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "ERASE" OBJ "R" "L" "" "REDRAW"))

(DEFUN C:F0 ()
(COMMAND ".FILLET" "RADIUS" "0" "FILLET"))

(DEFUN C:FR ()
(COMMAND "-view" "_FRONT"))

(DEFUN C:HI ()
(IF (= (GETVAR "highlight") 1) (SETVAR "highlight" 0) (SETVAR "highlight" 1)))

(DEFUN C:HB ()
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "-hatchedit" OBJ "B" "P" ""))

(DEFUN C:HD ()
(COMMAND "_shademode" "H"))

(DEFUN C:II ()  
  (command "_.undo" "mark");_ !!
  (SETQ OS (GETVAR "OSMODE"))
  (SETVAR "OSMODE" 0)
  (COMMAND "UCS" "WORLD")
  (COMMAND "LAYER" "THAW" "0" "SET" "0" "")
  (COMMAND "INSERT" "~" "0,0,0" "1" "" "0")
  (COMMAND "UCS" "prev")
  (SETVAR "OSMODE" OS)
)

(DEFUN C:L0 ()
(COMMAND "LAYER" "t" "0" "s" "0" ""))

(DEFUN C:L00 ()
(COMMAND "LAYER" "t" "00" "m" "00" "p" "N" "" ""))

(DEFUN C:L9 ()
(COMMAND "LAYER" "t" "09" "m" "09" ""))

(DEFUN C:LAY ()
(COMMAND "LAYOUT" "SET"))

(DEFUN C:LC ()
(COMMAND "LAYER" "C"))

(DEFUN C:LE ()
(COMMAND "-view" "_left"))

(DEFUN C:LD ()
(COMMAND "LENGTHEN" "DE"))

(DEFUN C:LED ()
(COMMAND "LENGTHEN" "DY"))

(DEFUN C:LF ()
(COMMAND "LAYER" "F"))

(DEFUN C:LFA ()
(COMMAND "LAYER" "F" "*" ""))

(DEFUN C:LFF ()
(COMMAND "LAYER" "F" "*f" ""))

(DEFUN C:LFH ()
(COMMAND "LAYER" "F" "*h" ""))

(DEFUN C:LFS ()
(COMMAND "LAYER" "F" "*s" ""))

(DEFUN C:LFX ()
(COMMAND "LAYER" "F" "w*,p*,s*,x*,-*" "" ""))

(DEFUN C:LL ()
(COMMAND "LAYER" "LOCK"))

(DEFUN C:LLA ()
(COMMAND "LAYER" "LOCK" "*" ""))

(DEFUN C:LM ()
(COMMAND "LAYER" "MAKE"))

(DEFUN C:LN ()
(COMMAND "LAYER" "ON"))

(DEFUN C:LNA ()
(COMMAND "LAYER" "ON" "*" ""))

(DEFUN C:LNF ()
(COMMAND "LAYER" "ON" "*f" ""))

(DEFUN C:LNH ()
(COMMAND "LAYER" "ON" "*h" ""))

(DEFUN C:LNN ()
(COMMAND "LAYER" "ON" "*n" "" ""))

(DEFUN C:LNS ()
(COMMAND "LAYER" "ON" "*s" ""))

(DEFUN C:LNX ()
(COMMAND "LAYER" "ON" "w*,p*,s*,x*,-*" ""))

(DEFUN C:LO ()
(COMMAND "LAYER" "OFF"))

(DEFUN C:LOA ()
(COMMAND "LAYER" "OFF" "*" "" ""))

(DEFUN C:LOF ()
(COMMAND "LAYER" "OFF" "*f" "" ""))

(DEFUN C:LOH ()
(COMMAND "LAYER" "OFF" "*h" "" ""))

(DEFUN C:LON ()
(COMMAND "LAYER" "OFF" "*n" "" ""))

(DEFUN C:LOS ()
(COMMAND "LAYER" "OFF" "*s" "" ""))

(DEFUN C:LOX ()
(COMMAND "LAYER" "OFF" "d*,w*,p*,s*,x*,-*" "" ""))

(DEFUN C:LS ()
(COMMAND "LAYER" "S"))

(DEFUN C:LT ()
(COMMAND "LAYER" "T"))

(DEFUN C:LTA ()
(COMMAND "LAYER" "T" "*" ""))

(DEFUN C:LTNA ()
(COMMAND "LAYER" "T" "*" "ON" "*" "")
(COMMAND "ZOOM" "E"))

(DEFUN C:LTF ()
(COMMAND "LAYER" "T" "*f" ""))

(DEFUN C:LTH ()
(COMMAND "LAYER" "T" "*h" ""))

(DEFUN C:LTS ()
(COMMAND "LAYER" "T" "*S" ""))

(DEFUN C:LTX ()
(COMMAND "LAYER" "T" "w*,p*,s*,x*" ""))

(DEFUN C:LTG ()
(COMMAND "pedit" pause "L" "ON" ""))

(DEFUN C:LTSC ()
(COMMAND "LTSCALE"))

(DEFUN C:LU ()
(COMMAND "LAYER" "U"))

(DEFUN C:LUA ()
(COMMAND "LAYER" "U" "*" ""))

(DEFUN C:LW ()
(PROMPT "wake up frozen layer to make current")
(SETQ LAYER (GETSTRING "\n which layer?"))
(COMMAND "LAYER" "T" LAYER "ON" LAYER "S" LAYER ""))

(DEFUN C:MB ()
(IF (= (GETVAR "MBUTTONPAN") 1) (SETVAR "MBUTTONPAN" 0) (SETVAR "MBUTTONPAN" 1)))

(DEFUN C:NE ()
(COMMAND "-view" "_neiso"))

(DEFUN C:NW ()
(COMMAND "-view" "_nwiso"))

(DEFUN C:OA ()
(COMMAND "-OSNAP" "END,INT,MID,CEN,"))

(DEFUN C:OC ()
(COMMAND "-OSNAP" "END,INT,INS,NOD,CEN"))

(DEFUN C:OD ()
(COMMAND "-OSNAP" "END"))

(DEFUN C:OI ()
(COMMAND "-OSNAP" "INS"))

(DEFUN C:ON ()
(COMMAND "-OSNAP" "NON"))

(DEFUN C:OT ()
(COMMAND "-OSNAP" "TAN"))

(DEFUN C:PN ()
(COMMAND "ZOOM" "C" PAUSE ""))

(DEFUN C:PP ()
(COMMAND "_plan" "C"))

(DEFUN C:PSL ()
(IF (= (GETVAR "PSLTSCALE") 1) (SETVAR "PSLTSCALE" 0) (SETVAR "PSLTSCALE" 1)))

(DEFUN C:PUA ()
(COMMAND "purge" "all" "*" "n"))

(DEFUN C:RI ()
(COMMAND "-VIEW" "_RIGHT"))

(DEFUN C:S2 ()
(COMMAND "_vscurrent" "2"))

(DEFUN C:S3 ()
(COMMAND "_vscurrent" "3"))

(DEFUN C:SE ()
(COMMAND "-view" "_seiso"))

(DEFUN C:S2a()
(SETVAR "PLINECONVERTMODE" 1)
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "SPLINEDIT" OBJ "P"))

(DEFUN C:S2P()
(SETVAR "PLINECONVERTMODE" 0)
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "SPLINEDIT" OBJ "P"))

(DEFUN C:SEP ()
(COMMAND "_solidedit" "_body" "_separate" PAUSE "" ""))

(DEFUN C:SF ()
(SETVAR "HPSEPARATE" 1)
(SETQ OBJ (ssget))
(PROMPT "select objects....")
(COMMAND "-bhatch" "p" "SOLID" "s" OBJ "" ""))

(DEFUN C:SG ()
(COMMAND "_vscurrent" "C"))

(DEFUN C:SH ()
(COMMAND "_vscurrent" "H"))

(DEFUN C:SPF ()
(IF (= (GETVAR "SPLFRAME") 1) (SETVAR "SPLFRAME" 0) (SETVAR "SPLFRAME" 1))
(COMMAND "REGEN"))

(DEFUN C:SPL2PL ()
(alert "SPL2PL \n\nUse the new adaptive SPLINEDIT command to convert to polyline: \n - S2P (spline to polyline) \n - S2A (spline to polyline using arcs)"))

(DEFUN C:SR ()
(COMMAND "_vscurrent" "R"))

(DEFUN C:SW ()
(COMMAND "-view" "_swiso"))

(DEFUN C:SX ()
(COMMAND "_vscurrent" "X"))

(DEFUN C:TM ()
(IF (= (GETVAR "TILEMODE") 1) (SETVAR "TILEMODE" 0) (SETVAR "TILEMODE" 1)))

(DEFUN C:TT ()
(COMMAND "PLAN" "W"))

(DEFUN C:U2 ()
(COMMAND "UCS" "ZAXIS"))

(DEFUN C:U3 ()
(COMMAND "UCS" "3POINT"))

(defun c:ub ( / )
  (princ "\nMacro: Undo Back")
  (command "_.undo" "_e" "_.undo" "_B")
  (princ)
)

(DEFUN C:UE ()
(COMMAND "UCS" "ENTITY"))

(DEFUN C:UF ()
(IF (= (GETVAR "UCSFOLLOW") 1) (SETVAR "UCSFOLLOW" 0) (SETVAR "UCSFOLLOW" 1)))

(DEFUN C:UO ()
(COMMAND "UCS" "ORIGIN"))

(DEFUN C:UP ()
(COMMAND "UCS" "P"))

(DEFUN C:UR ()
(COMMAND "UCS" "RESTORE"))

(DEFUN C:US ()
(COMMAND "UCS" "SAVE"))

(DEFUN C:UV ()
(COMMAND "UCS" "VIEW"))

(DEFUN C:UW ()
(COMMAND "UCS" "WORLD"))

(DEFUN C:UX ()
(COMMAND "UCS" "X" "90"))

(DEFUN C:UY ()
(COMMAND "UCS" "Y" "90"))

(DEFUN C:UZ ()
(COMMAND "UCS" "Z" "90"))

(DEFUN C:LFV ()
(SETQ LAYER (GETSTRING "\n Which layer to freeze in this viewport?"))
(COMMAND "VPLAYER" "F" LAYER "C" ""))

(DEFUN C:LFAV ()
(SETQ LAYER (GETSTRING "\n Which layer to freeze in all viewports?"))
(COMMAND "VPLAYER" "F" LAYER "A" ""))

(DEFUN C:LTV ()
(SETQ LAYER (GETSTRING "\n Which layer to thaw in this viewport?"))
(COMMAND "VPLAYER" "T" LAYER "C" ""))

(DEFUN C:LTAV ()
(SETQ LAYER (GETSTRING "\n Which layer to thaw in all viewports?"))
(COMMAND "VPLAYER" "T" LAYER "A" ""))

(DEFUN C:VP ()
(COMMAND "-vports" "P"))

(DEFUN C:VR ()
(COMMAND "VIEW" "RESTORE"))

(DEFUN C:VS ()
(COMMAND "VIEW" "SAVE"))

(DEFUN C:VW ()
(COMMAND "VIEW" "WINDOW"))

(DEFUN C:WW ()
  (PROMPT "Wblock special - insertion point= 0,0,0 in UCS-World")
  (SETQ OBJECTS (SSGET))
  (setq os (getvar "osmode"))
  (setvar "osmode" 0)
  (command "_.undo" "mark")
  (COMMAND "LAYER" "T" "0" "S" "0" "")
  (COMMAND "UCS" "WORLD")
  (COMMAND "WBLOCK" "~" "" "0,0,0" objects "")
  (setvar "osmode" os)
  (COMMAND "UCS" "PREV")
  )

(defun C:Xdda (/)
  (if (not MC:Xdda)
    (load "maxilla.fas")
    )
  (MC:Xdda)
  )

(defun C:Xdd (/)
  (if (not MC:Xdd)
    (load "maxilla.fas")
    )
  (MC:Xdd)
  )

(defun C:Xdg (/)
  (if (not MC:Xdg)
    (load "maxilla.fas")
    )
  (MC:Xdg)
  )

(defun C:Xds (/)
  (if (not MC:Xds)
    (load "maxilla.fas")
    )
  (MC:Xds)
  )

(DEFUN C:XX (/ osmode)
  (PROMPT "XREF special - insertion point= 0,0,0 in UCS-World")
  (setq os (getvar "osmode"))
  (setvar "osmode" 0)  
  (COMMAND "UCS" "WORLD")
  (command "LAYER" "THAW" "0" "SET" "0" "")
  (command "XREF" "overlay" "~" "0,0,0" "1" "1" "0")
  (setvar "osmode" os)
  (command "UCS" "PREV")
)

(DEFUN C:ZA ()
(COMMAND "'ZOOM" "A"))

(DEFUN C:ZD ()
(COMMAND "'ZOOM" "D"))

(DEFUN C:ZE ()
(COMMAND "'ZOOM" "E"))

(DEFUN C:ZI ()
(COMMAND "'ZOOM" "2X"))

(DEFUN C:ZO ()
(COMMAND "'ZOOM" ".5X"))

(DEFUN C:ZP ()
(COMMAND "'ZOOM" "P"))

(DEFUN C:ZW ()
(COMMAND "'ZOOM" "W"))

(DEFUN C:ZX ()
(COMMAND "'ZOOM" ".9X"))

(DEFUN C:ZZ ()
(COMMAND "'ZOOM" "O"))

;; ==========ending the custom commands====

;; ========== Custom variable settings=====


(command "LAYISO" "S" "OFF" "" "")

(command "XDWGFADECTL" "0")

(command "ISAVEBAK" "0")



;;(alert "\nmaxwan shortcuts for AutoCAD 2014 (r19.1)\n\nCopyright (C) 1993 - 2013 by maxwan architects and urbanist BV\n\nThis is ApplePie-Ware if you use them professionaly.\nFor personal use this is Postcardware!\nSend us a postcard (or apple pie) with your email address and we will tell you how to remove this message.\nFeel free to pass on these shortcuts, as long as this message is included.\n\nmaxwan architects and urbanists\nBenjamin Franklinstraat 509\n3029 AC Rotterdam, NL\n\nmailto:maxwan@maxwan.com\nhttp://www.maxwan.com")

