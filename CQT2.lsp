;
;
;     Program written by Robert Livingston, 2017-11-16
;
;     C:QT2 is a routine for dynamically modelling swept paths of vehicles
;
;
(defun C:QT2 (/ COLOR ENT ENTLIST ILIST P SCALE STEP VLIST)
 (command "._UNDO" "M")
 (if (= nil (setq COLOR (getint "\nEnter envelope color <34> : ")))
  (setq COLOR 34)
 )
 (setq ILIST (QT:GETVLIST))
 (setq VLIST (cadr ILIST))
 (setq ENT (caaddr ILIST))
 (setq ENTLIST (entget ENT))
 (setq SCALE (cdr (assoc 41 ENTLIST)))
 (setq STEP (* 0.1 SCALE (- (nth 2 (cadr (car VLIST))) (nth 0 (cadr (car VLIST))))))
 (setq P (list (+ (car (car ILIST)) (* (nth 0 (cadr (car VLIST))) (cos (cdr (assoc 50 ENTLIST)))))
               (+ (cadr (car ILIST)) (* (nth 0 (cadr (car VLIST))) (sin (cdr (assoc 50 ENTLIST)))))
         )
 )
 (QT:DRAWDPATH P 0.0 VLIST COLOR)
 (foreach ENT (caddr ILIST)
  (redraw ENT)
 )
 (foreach ENT QT:PATHLIST
  (entdel (car ENT))
 )
 T
)