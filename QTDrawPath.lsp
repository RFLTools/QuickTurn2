;
;
;     Program written by Robert Livingston, 2017-11-09
;
;     QTDRAWPATH Draws the path from along a polyline
;
;
(defun QT:DRAWPATH (P ENTPL STEP A VLIST COLOR / *error* )
 (defun *error* (msg)
  (print msg)
 )
 (setq STOPFLAG nil ENT nil)
 (QT:MAKEPATH ENTPL VLIST STEP)
 (QT:DRAWENVELOPE COLOR VLIST)
 (QT:DRAWATEND)
 (getstring "\nFinish...")
)
