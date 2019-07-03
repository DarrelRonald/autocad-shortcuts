(defun c:a2x( / fname f ss cn nrofdecimals )
  
  ;;;
  ;;; Area's 2 Excel -- exports area of selected polylines plus layer 
  ;;; names to a tab seperated exportfile.
  ;;;
  ;;; copyright by CAD & Networking may 1998
  ;;;
 
  ;;; set to higher value for increased accuracy
  (setq nrofdecimals 2)

  ;;; retrieve exportfilename
  (setq fname (getstring "\nGive filename for export:"))

  ;; let user select everything which is a polyline  
  (setq ss (ssget  (list (cons -4 "<or")(cons 0 "*polyline*")(cons 0 "*region*")(cons -4 "or>"))))
 
  ;;; initialize counter
  (setq cn 0)

  ;;; if user selected any valid objects...
  (if (> (sslength ss) 0)
    (progn
     
      ;;; open export file for writing  
      (setq f (open fname "w"))    

      ;;; princ table headers
      (princ (strcat "Area" "\t" "Perimeter" "\t" "Layer" "\n") f)

      (repeat (sslength ss)

        ;;; get information from first of every polyline
        (setq ent (entget (setq entn (ssname ss cn))))

        ;;; calculate area
        (command "._Area" "_Object" entn)

        ;;; export area plus layername tab seperated to file
        (princ (strcat (rtos (getvar "area") 2 nrofdecimals) "\t" (rtos (getvar "perimeter") 2 nrofdecimals) "\t" (cdr(assoc 8 ent)) "\n") f)

        ;;; increase counter
	(setq cn (1+ cn))
      ) 

      ;;; close exportfile
      (setq f (close f))
    )

    ;;; else give warning no objects selected
    (princ "\nNo (valid) objects selected.")
  )
)


(defun c:ssf( / ptlist pt)
  
  ;;;
  ;;; Seperate Solid Fill (oops that's simple)
  ;;;
  ;;; copyright by CAD & Networking may 1998
  ;;;

  (setq ptlist nil)
  (while (setq pt (getpoint "\nGive point (return to stop):"))
    (setq ptlist (cons pt ptlist))
  )

  (foreach N ptlist
    (command "-bhatch" "_P" "s" N "")
  )
)


(defun *error*saf*(s)
  (setvar "osmode" os)
  (princ s)
  (setq *error* olderr)
  (princ)
)

(defun c:saf( / ptlist pt)
  
  ;;;
  ;;; Seperate Area Fill (oops that's simple)
  ;;;
  ;;; copyright by CAD & Networking may 1998
  ;;;
  (setq os (getvar "osmode"))
  (setvar "osmode" 0)

  (setq olerr *error*)
  (setq *error* *error*saf*)

  (setq ss (ssget (list (cons 0 "*POLYLINE*"))))
  (setq cn 0)  

  (repeat (sslength ss)
    (setq entn (ssname ss cn))
    (command "-bhatch" "_P" "solid" "_s" entn "" "")
    (setq cn (1+ cn))
  )
  (setvar "osmode" os)

  (setq *error* olderr)

)
  

(defun c:ca(/ pt ent txthgt)

  ;;; bepalen van de teksthoogte indien current style height = 0
  (setq txthgt (cdr (assoc 40 (tblsearch "STYLE" (getvar "TEXTSTYLE")))))
  (if (and (null v:th) (= txthgt 0))
    (progn
      (initget 1)
      (setq v:th (getdist "Text height: "))
    )
  )
 
  ;;; preset voor loop
  (setq ent T)
  (while (not (null ent))

    ;;; different prompts and initgets depending on style
    (if (= txthgt 0)
      (progn
        (setq ans "Text height/<Select boundary>: ")
        (initget "Text")
      )
      (progn
        (setq ans "<Select boundary>: ")
      )
    )
    (setq ent (entsel ans))
    (cond 
      ((= ent "Text")
        (progn
          (setq v:th (getdist (strcat "Text height <" (rtos v:th 2 2) ">: ")))
        )
      )
      ((= (type (car ent)) 'ENAME)
        (redraw (car ent) 3)
        (initget 1)
        (setq pt (getpoint "Positie tekst: "))
        (command "._AREA" "_Entity" ent)
        (if (= txthgt 0)
          (command "_.TEXT" "M" pt v:th "" (strcat (rtos (getvar "area") 2 0) " m2"))
          (command "_.TEXT" "M" pt "" (strcat (rtos (getvar "area") 2 0) " m2"))
        )

        (redraw (car ent) 1)
      )
 
    )
  )
  (setvar "cmdecho" 1)
  (princ)
)
  
(princ "a2x  -  area to excel \n")
(princ "ssf  -  select solid fill\n")
(princ "ca   -  calculate area\n")
(princ "loaded\n")
(princ)

