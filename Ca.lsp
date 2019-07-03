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

        (redraw (car ent) 4)
      )
 
    )
  )
  (setvar "cmdecho" 1)
  (princ)
)


  
;(princ "a2x  -  area to excel \n")
;(princ "ssf  -  select solid fill\n")
(princ "ca   -  calculate area\n")
(princ "cl   -  calculate length\n")
(princ "loaded\n")
(princ)