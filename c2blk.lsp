(defun C:C2BLK ( / ss blk ent pt n)
(prompt "\nSelect Circles to replace: ")
(setq ss (ssget '((0 . "CIRCLE")))
blk (getstring "\nName of Block: ")
);;setq
(if (and ss (tblsearch "block" blk))
(progn
(setq n (1- (sslength ss)))
(while (>= n 0)
(setq ent (ssname ss n)
pt (cdr (assoc 10 (entget ent)))
n (1- n)
);; setq
(command "_.-insert" blk pt "" "" "")
);;while
(command "_.erase" ss "")
);;progn
);; if
(princ)
)
