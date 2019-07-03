
(defun C:2t ();v1.00
;(c) scott hull, 05-27-86
;SAH mechanical design (415) 343-4015
;draws a line tangent to two arcs or circles.

 (terpri)

 (setq os (getvar "osmode"))
  (setvar "osmode" 0)
 
 (defun *error* (st)
      (princ "error: ")
      (princ st)
 (terpri))

 (setq pk1 (getpoint "select first tangent point: "))
 (terpri)
 (setq pk2 (getpoint "select second tangent point: "))
 (setq cp1 (osnap pk1 "cen"))
 (setq cp2 (osnap pk2 "cen"))
 (if (<= (angle cp2 cp1) 0.0)
      (progn (setq c1 cp2) (setq p1 pk2) (setq c2 cp1) (setq p2 pk1))
      (progn (setq c1 cp1) (setq p1 pk1) (setq c2 cp2) (setq p2 pk2)))
 
 (setq dtc (distance c1 c2))
 (setq ag12 (angle c1 c2))
 (setq ag21 (angle c2 c1))
 (setq ag1 (angle c1 p1))
 (setq ag2 (angle c2 p2))
 (if (and (< ag1 ag21) (> ag1 ag12))
      (setq case1 1) (setq case1 2))
 (if (and (< ag2 ag21) (> ag2 ag12))
      (setq case2 3) (setq case2 4)) 
 (setq case (* case1 case2))

 (setq r1 (distance c1 (osnap p1 "near")))
 (setq r2 (distance c2 (osnap p2 "near")))
 (if (or (= case 4) (= case 6))
      (setq dtr (+ r1 r2))
      (setq dtr (- r1 r2)))
      (setq length (sqrt (- (* dtc dtc) (* dtr dtr))))
 (if (or (= case 4) (= case 6))
      (setq agx (atan (/ length dtr)))
      (setq agx (atan (/ dtr length))))
 (if (= case 8)
      (setq ag12 (- (angle c1 c2) (/ pi 2))))
 (if (= case 3)
      (setq ag12 (+ (angle c1 c2) (/ pi 2))))
 (if (or (= case 3) (= case 6))
      (setq agt (- ag12 agx))
      (setq agt (+ ag12 agx)))

 (setq st (polar c1 agt r1))
 (setvar "cmdecho" 0)
 (command "line" st "tan" p2 "")
 (setvar "osmode" os)
 (terpri))
