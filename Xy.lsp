(defun c:xy ()

  ;;;
  ;;; lisp routine om x en y coordinaten in een tekening op te nemen.
  ;;; (c) by CAD & Networking 1997, 2000    --   pauL@cadan.nl
  ;;; 


  (if (= v:xy_scale nil)
    (setq v:xy_scale 1)
  )

  (if (= v:xy_textheight nil)
    (setq v:xy_textheight 1)
  )

  (if (= v:xy_offsetdist nil)
    (setq v:xy_offsetdist 2)
  )

  ;;; this is the default blockname if you want default no block name set this to: nil (see commented out line)
  (if (= v:xy_blockname nil)
    ;;; (setq v:xy_blockname "")
    (setq v:xy_blockname "xy")
  )

  (initget "Scale Text Offset Block")	
  (setq pt (getpoint "Scale/Text height/Offset/Block/<Select point>:"))
  (cond
    ((= pt "Scale")
      (setq newscale (getdist (strcat "Enter scale factor <" (rtos v:xy_scale) ">:")))
      (if (/= newscale nil)
        (setq v:xy_scale newscale)
      )        
    )

    ((= pt "Text")
      (setq newheight (getdist (strcat "Enter text height <" (rtos v:xy_textheight) ">:")))
      (if (/= newheight nil)
        (setq v:xy_textheight newheight)
      )        
    )

    ((= pt "Offset")
      (setq newoffset (getdist (strcat "Enter offset <" (rtos v:xy_offsetdist) ">:")))
      (if (/= newoffset nil)
        (setq v:xy_offsetdist newoffset)
      )        
    )

    ((= pt "Block")
      (setq newblock (getstring "Enter new blockname or return for none :"))
      (if (= newblock "")
        (setq v:xy_blockname "")
        (setq v:xy_blockname newblock)
      )        
    )

    ((= (type pt) 'LIST)
      (initget 1)
      (setq qua (getpoint pt "Choose quadrant: "))
            
      (setq v:xy_ptstring (strcat (rtos (* (car pt) v:xy_scale) 2 (getvar "luprec"))
                                  ","
                                  (rtos (* (cadr pt) v:xy_scale) 2 (getvar "luprec"))
                          )
      )
      
      ;;; als er eveneens de behoefte bestaat om een blok te inserten....
      ;;; (command "._INSERT" <blockname> pt "1" "1" "0)
      ;;; 
      
     (if (/= v:xy_blockname "")
       (command "INSERT" "xy" pt "1" "1" "0")
     )

 (setq os (getvar "osmode"))
   (setvar "osmode" 0)
     
     (if (< (car qua) (car pt))
        (if (< (cadr qua) (cadr pt))
          (command "._Text" 
                   "_TR" 
                  (list (- (car pt) v:xy_offsetdist) (- (cadr pt) v:xy_offsetdist)) 
                  (if (= (cdr (assoc 40 (tblsearch "STYLE" (getvar "textstyle")))) 0) 
                    (progn v:xy_textheight "")
                    ""
                  )
		  ""
                  v:xy_ptstring
          )
          (command "._Text" 
                   "_BR" 
                  (list (- (car pt) v:xy_offsetdist) (+ (cadr pt) v:xy_offsetdist)) 
                  (if (= (cdr (assoc 40 (tblsearch "STYLE" (getvar "textstyle")))) 0) 
                    (progn v:xy_textheight "")
                    ""
                  )
                  ""
		  v:xy_ptstring
          )
        )
        (if (< (cadr qua) (cadr pt))
          (command "._Text" 
                   "_TL" 
                  (list (+ (car pt) v:xy_offsetdist) (- (cadr pt) v:xy_offsetdist)) 
                  (if (= (cdr (assoc 40 (tblsearch "STYLE" (getvar "textstyle")))) 0) 
                    (progn v:xy_textheight "")
                    ""
                  )
		  ""
                  v:xy_ptstring
          )
          (command "._Text" 
                  (list (+ (car pt) v:xy_offsetdist) (+ (cadr pt) v:xy_offsetdist)) 
                  (if (= (cdr (assoc 40 (tblsearch "STYLE" (getvar "textstyle")))) 0) 
                    (progn v:xy_textheight "")
                    ""
                  )
		  ""
                  v:xy_ptstring
          )
        )
      )
    )
  )
 (setvar "osmode" os)
   (setq *error* olderr)
)
