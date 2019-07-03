(defun c:l2x()
 
  (setq suggestie (strcat (getvar "dwgprefix") "layer_list.xls"))
  (setq expfile (getstring (strcat "Exportfile: <" suggestie ">:")))
  (if (= "" expfile) (setq expfile suggestie))

  (setq fi (open expfile "w"))

  (princ "name\tlinetype\tcolor\ton/off\tthawed/frozen\n" fi)
  (setq lay (tblnext "LAYER" T))

  (while lay
    (princ (strcat (cdr (assoc 2 lay)) "\t"  						; layername
                   (cdr (assoc 6 lay)) "\t"  						; linetype
                   (itoa (abs (cdr (assoc 62 lay)))) "\t"  				; color
                   (if (< (cdr (assoc 62 lay)) 0) "OFF" "ON") "\t" 			; on / off                   
		   (if (= 0 (AND (cdr (assoc 70 lay)) 1)) "Thawed" "Frozen") "\t"  	; linetype
                   "\n"
     ) fi)
    (setq lay (tblnext "LAYER"))

  )

  (setq fi (close fi))

)

