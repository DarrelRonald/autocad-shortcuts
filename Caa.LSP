;Calculating multiple AReas;;;

(defun C:CAA ( / ss1 count emax txthgt txthgt_Init)
  
  (setq txthgt (cdr (assoc 40 (tblsearch "STYLE" (getvar "TEXTSTYLE")))))
  (if (> txthgt 0)
    (setq txthgt_Init txthgt)
    (setq txthgt_Init 10)
    )
  
  
  (prompt "\nSelect Objects...")                 		;Tell them what to select
  (setq ss1 (ssget))                             	;Get the selection set
  (command "_.area" "_a" "_e")                   		;Start the command
  (setq count 0                                  	;Set initial count value
	emax (sslength ss1)                 		;Find the max count value
	);setq
  (while (< count emax)                      		;Start the program loop
    (command (ssname ss1 count))                  	;Pass ename to command
    (setq count (1+ count))                   		;Increment the counter
    );while
  (command "" "")                                	;End the command
  (prompt (strcat "\nFinal area is "               	;Combine final area
		  (rtos (getvar "AREA") 2)          	;in return prompt
		  ))
  (princ)
  
  (setq pt (getpoint "\nPosition of the text: "))
  (initget 6)
  (setq txthgt (getdist (strcat "\nEnter the text height<" (rtos (cond (v:th v:th) (t txthgt_Init))) ">" ": ")))
  (cond
    ((and (not txthgt) (not v:th))
     (setq v:th txthgt_Init)
     )

    (txthgt
     (setq v:th txthgt)
     )
    (t
     (princ)
     )
    )
  
  (command "_.TEXT" "M" pt v:th "0" (strcat (rtos (getvar "area") 2 0) " m2"))

;;;        (if (= txthgt 0)
;;;          (command "_.TEXT" "M" pt v:th "0" (strcat (rtos (getvar "area") 2 0) " m2"))
;;;          (command "_.TEXT" "M" pt "0" (strcat (rtos (getvar "area") 2 0) " m2"))
;;;        )
                                      			;Clean ending
)                                            	;Clean loading
