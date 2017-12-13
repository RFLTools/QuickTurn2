;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTGETVLIST Returns a list of temporary vehicles and their values
;
;
(defun QT:GETVLIST ( / *error* DLIST ENT ENTORIG ENVLIST LA LB P PORIG STOPFLAG VLIST VLISTORIG)
 (defun *error* (msg)
  (print msg)
 )
 (setq P nil STOPFLAG nil VLIST nil LA nil LB nil)
 (while (= STOPFLAG nil)
  (if (/= (car (setq DLIST (QT:GETD (setq ENTORIG (car (setq PORIG (entsel))))))) nil)
   (progn
    (if (= nil P) (setq P (cdr (assoc 10 (entget ENTORIG)))))
    (if (nth 5 DLIST) (setq LB (nth 5 DLIST)))
    (if (nth 6 DLIST) (setq LA (nth 6 DLIST)))
    (setq ENT (QT:MAKETEMPBLOCK ENTORIG))
    (redraw ENTORIG 2)
    (redraw ENT 2)
    (setq VLISTORIG (append VLISTORIG (list ENTORIG)))
    (setq VLIST (append VLIST (list (list ENT DLIST (QT:GETENVELOPE ENTORIG)))))
    (if (= (cadddr DLIST) 0.0) (setq STOPFLAG T))
    (if (and LA LB)
     (if (and (/= (nth 5 (setq DLIST (QT:GETD (setq ENTORIG (car (entsel "\nSelect load block (<return> for none) : ")))))) nil)
              (/= (nth 6 DLIST))
         )
      (progn
       (setq LA nil LB nil)
       (setq ENT (QT:MAKETEMPBLOCK ENTORIG))
       (redraw ENTORIG 2)
       (redraw ENT 2)
       (setq VLISTORIG (append VLISTORIG (list ENTORIG)))
       (setq VLIST (append VLIST (list (list ENT "LOAD" DLIST (QT:GETENVELOPE ENTORIG)))))
      )
     )
    )
   )
   (setq STOPFLAG T)
  )
 )
 (if VLIST
  (progn
   (foreach ENT VLIST (redraw (car ENT)))
   (list P VLIST VLISTORIG)
  )
  PORIG
 )
)
