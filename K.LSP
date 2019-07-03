;;; K.LSP IS AN IMPROVED VERSION OF CHTOT.LSP BY G.J.LEBBINK,
;;; IMPROVED IN THE SENSE THAT IT DOESN'T CHANGE UCS AND REDRAW
;;; WITH EVERY CHANGED ENTITY
;;; IF YOU' RE DEALING HOWEVER WITH ENTITIES IN DIFFERENT UCS'S K DOESN'T WORK
;;; FRANS BLOK

(defun c:k (/ d lay col ltp lts)
        (setvar "cmdecho" 0)
        (grtext -1 "chprop all")
        (grtext -2 " ")
        (setq d (ssget)
              x 0
              )
        (setq col (cdr (assoc '62 (setq f1 (entget (car (entsel " Select entity "))))))
              ltp (cdr (assoc '6 f1))
              lay (cdr (assoc '8 f1))
	  lts (cdr (assoc '48 f1))
              thi (cdr (assoc '10 f1))          )

        (if (= col nil) (setq col "bylayer"))
        (if (= ltp nil) (setq ltp "bylayer"))
        (if (= lts nil) (setq lts 1))
        (if (= thi nil) (setq thi 0))
        (repeat (sslength d)
               (progn
               (setq ent (ssname d x)
                     x (1+ x)
                     )
               (command 
                        "chprop" ent "" "c" col "la" lay "lt" ltp "s" lts ""
                        
                        )
               )
        )
        (setvar "cmdecho" 1)
        (grtext)
        (prin1)
)
