;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTGETVLIST Returns a list of temporary vehicles and their values
;
;
(defun QT:GETVLIST ( / *error* DLIST ENT ENTORIG ENVLIST P STOPFLAG VLIST VLISTORIG)
 (defun *error* (msg)
  (print msg)
 )
 (setq P nil STOPFLAG nil VLIST nil)
 (while (= STOPFLAG nil)
  (if (/= (car (setq DLIST (QT:GETD (setq ENTORIG (car (entsel)))))) nil)
   (progn
    (if (= nil P) (setq P (cdr (assoc 10 (entget ENTORIG)))))
    (setq ENT (QT:MAKETEMPBLOCK ENTORIG))
    (redraw ENTORIG 2)
    (redraw ENT 2)
    (setq VLISTORIG (append VLISTORIG (list ENTORIG)))
    (setq VLIST (append VLIST (list (list ENT DLIST (QT:GETENVELOPE ENTORIG)))))
    (if (= (cadddr DLIST) 0.0) (setq STOPFLAG T))
   )
   (setq STOPFLAG T)
  )
 )
 (if VLIST
  (progn
   (foreach ENT VLIST (redraw (car ENT)))
   (list P VLIST VLISTORIG)
  )
  nil
 )
)
