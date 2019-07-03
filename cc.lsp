(defun c:cc(/ ss lname)
  (setq ss (ssget))

  (setq os (getvar "osmode"))
  (setvar "osmode" 0)

  (setq olerr *error*)
  (setq *error* *error*saf*)

  (setq lname (getstring "\nGive layername to which the selected entities should be copied:"))
  (command "._COPY" ss "" "0,0" "")
  (if (tblsearch "LAYER" lname T)
    (command "._CHPROP" ss "" "_La" lname  "")
    (progn
      (command "._LAYER" "_New" lname "")
      (command "._CHPROP" ss "" "_La" lname  "")
    )
  )
  (setvar "osmode" os)

  (setq *error* olderr)

)



(defun *error*saf*(s)
  (setvar "osmode" os)
  (princ s)
  (setq *error* olderr)
  (princ)
)
