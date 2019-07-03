;; volume

(defun c:Vol ( / ss ss_Length entn cn obj volume)
  (vl-load-com)  
  (princ "\nMacro: Volume")
  
  (setvar "cmdecho" 0)
  (setvar "highlight" 1)
  (setq volume 0.0)
  (setq ss (ssget))
  (command "._Select" ss "")
  (setq ss (ssget "P" '((0 . "3DSOLID"))))
  (if (= ss nil)
    (princ "Nothing to do.")
    (progn
      (setq ss_Length (sslength ss) cn 0)      
      (repeat ss_Length
        (setq entn (ssname ss cn))
        (setq cn (1+ cn))
        (setq obj (vlax-ename->vla-object entn))
        (if obj
          (setq volume (+ (vlax-get-property obj 'Volume) volume))
          );_end of if
        );_ end of repeat
      );_ end of progn
    );_ end of if

  (princ (strcat "\n" "Solids Selected: "(rtos ss_Length 2 0) "  \nTotal Volume: "(rtos volume 2 2)))
  (princ)
  ) ;_ end of defun

(defun C:*Vol* ( / ss ss_Length entn cn obj volume)
  (vl-load-com)
  
  (setvar "cmdecho" 0)
  (setvar "highlight" 1)
  (setq volume 0.0)
  (setq ss (ssget))
  (command "._Select" ss "")
  (setq ss (ssget "P" '((0 . "3DSOLID"))))
  (if (= ss nil)
    (princ "Nothing to do.")
    (progn
      (setq ss_Length (sslength ss) cn 0)      
      (repeat ss_Length
        (setq entn (ssname ss cn))
        (setq cn (1+ cn))
        (setq obj (vlax-ename->vla-object entn))
        (if obj
          (setq volume (+ (vlax-get-property obj 'Volume) volume))
          );_end of if
        );_ end of repeat
      );_ end of progn
    );_ end of if
(princ (strcat "\n" "Solids Selected: "(rtos ss_Length 2 0) "  "  ))
  volume
  ) ;_ end of defun


;; extrusion
(defun c:Ext ( / ss ss_Length entn cn region_Last region_List newArea maxArea maxEntity ss_subtract)
  (vl-load-com)  
  (princ "\nMacro: Extrusion\n")
  (princ)
  (setq region_List '())
  (setvar "cmdecho" 0)
  (setvar "highlight" 1)
  (setq ss (ssget))
  (command "._Select" ss "")
  (setq ss (ssget "P" '(   (-4 . "<OR") 
                           (0 . "*POLYLINE")
                           (0 . "REGION")
                           (0 . "CIRCLE")
                           (0 . "ELLIPSE")
                           (-4 . "OR>")
                       )))
  (if (= ss nil)
    (princ "Nothing to do.")
    (progn
      (setq ss_Length (sslength ss) cn 0)
      ;;(command "_region" ss "")
      (repeat ss_Length
        (setq entn (entget (ssname ss cn)))
        (setq cn (1+ cn))
        ;;(setq obj (vlax-ename->vla-object entn))
        (if entn
          (progn
            (if (equal (cdr (assoc 0 entn)) "REGION")
              (setq region_Last (cdr (assoc -1 entn)))
              (progn
                (command "_region" (cdr (assoc -1 entn)) "")
                (setq region_Last (entlast))
                );- end of progn
              );_ end of if
            (setq region_List (append region_List (list region_Last)))
            ;; find the external boundary
            (setq newArea (vlax-get-property (vlax-ename->vla-object region_Last) 'area))
            (if (< maxArea newArea)
              (progn
                (setq maxArea newArea)
                (setq maxEntity region_Last))
              );_ end of if
            );_ end of progn
          );_end of if
        );_ end of repeat
      (setq region_List (vl-remove maxEntity region_List))       
      (foreach region region_list
      (command "_subtract" maxEntity "" region "")
        )      
      (command "_Extrude" (entlast) "")
      (princ)
      
      );_ end of progn
    );_ end of if
  );_ end of defun


;; make regions with holes
(defun c:CAH ( / ss ss_Length entn cn region_Last region_List newArea maxArea maxEntity ss_subtract)
  (vl-load-com)  
  (princ "\nMacro: Make Region with Holes\n")
  (princ)
  (setq region_List '())
  (setvar "cmdecho" 0)
  (setvar "highlight" 1)
  (setq ss (ssget))
  (command "._Select" ss "")
  (setq ss (ssget "P" '(   (-4 . "<OR") 
                           (0 . "*POLYLINE")
                           (0 . "REGION")
                           (0 . "CIRCLE")
                           (0 . "ELLIPSE")
                           (-4 . "OR>")
                       )))
  (if (= ss nil)
    (princ "Nothing to do.")
    (progn
      (setq ss_Length (sslength ss) cn 0)
      ;;(command "_region" ss "")
      (repeat ss_Length
        (setq entn (entget (ssname ss cn)))
        (setq cn (1+ cn))
        (if entn
          (progn
            (if (equal (cdr (assoc 0 entn)) "REGION")
              (setq region_Last (cdr (assoc -1 entn)))
              (progn
                (command "_region" (cdr (assoc -1 entn)) "")
                (setq region_Last (entlast))
                );- end of progn
              );_ end of if
            (setq region_List (append region_List (list region_Last)))
            ;; find the external boundary
            (setq newArea (vlax-get-property (vlax-ename->vla-object region_Last) 'area))
            (if (< maxArea newArea)
              (progn
                (setq maxArea newArea)
                (setq maxEntity region_Last))
              );_ end of if
            );_ end of progn
          );_end of if
        );_ end of repeat
      (setq region_List (vl-remove maxEntity region_List))       
      (foreach region region_list
      (command "_subtract" maxEntity "" region "")
        )      
      (princ)
      
      );_ end of progn
    );_ end of if
  );_ end of defun


(defun C:Sqm (/ floor)
  
  (initget 7)
  (setq floor (getint "\nEnter the floor height: "))  
  
  (princ (strcat "\nTotal Area: "(rtos (/ (C:*Vol*) floor) 2 2)))
  (princ)
  
  );_ endof defun