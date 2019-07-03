      ;;;**************************************************************************
      ;;;
      ;;; rep.lsp , routine om het automatisch herhalen van een of meerdere
      ;;;           commando's op individuele elementen in een selectie set
      ;;;
      ;;; (c) ,  Paul Hoogendijk, juni 1993
      ;;;
      ;;;*************************************************************************
      (defun c:rep(/ cn l f scriptname)
        (setvar "cmdecho" 0)
        (setq scriptname "repcom.scr")
        (setq cn 0)
        (setq repset (ssget))
        (princ (strcat "\nGeef commando's, \n\t# om commando te beïndigen"
                        "\n\t~ om een element door te geven"
                        "\n\t$ om één element commando door te geven (pedit)"
                        "\n\t% om de hoofd-xy coordinaat door te geven:\n"))
        (while (/= "#" (setq st (getstring "commando --> ")))
          (setq l (append l (list st)))
        )
        (setq f (open scriptname "w"))
        (repeat (sslength repset)
          (foreach N l
            (cond 
              ((= N "~")
                (princ (strcat "(ssname repset " (itoa cn) ")\n\n") f)
              )
              ((= N "%")
                (princ (strcat "(cdr (assoc 10 (entget (ssname repset " (itoa cn) "))))\n") f)
              )
              ((= N "$")
                (princ (strcat "(ssname repset " (itoa cn) ")\n") f)
              )
              (T
                (princ N f)
                (princ "\n" f)
              )
            )
          )
          (setq cn (1+ cn))
        )
        (setq f (close f))
        (command "._SCRIPT" scriptname)
        (setvar "cmdecho" 0)
        (princ)
      )
      
