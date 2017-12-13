;
;
;     Program written by Robert Livingston, 2017-11-16
;
;     C:QT2 is a routine for dynamically modelling swept paths of vehicles
;
;
(defun C:QT2 (/ COLOR ENT ENTLIST ILIST P STEP VLIST)
 (command "._UNDO" "M")
 (princ "\nSelect a vehicle block, polyline or <return> to insert vehicle.")
 (if (= nil (setq ILIST (QT:GETVLIST)))
  (C:QTMAKE)
  (if (listp (car ILIST))
   (progn
    (if (= nil (setq COLOR (getint "\nEnter envelope color <34> : ")))
     (setq COLOR 34)
    )
    (setq VLIST (cadr ILIST))
    (setq ENT (caaddr ILIST))
    (setq ENTLIST (entget ENT))
    (setq STEP (* 0.1 (- (nth 2 (cadr (car VLIST))) (nth 0 (cadr (car VLIST))))))
    (setq P (list (+ (car (car ILIST)) (* (nth 0 (cadr (car VLIST))) (cos (cdr (assoc 50 ENTLIST)))))
                  (+ (cadr (car ILIST)) (* (nth 0 (cadr (car VLIST))) (sin (cdr (assoc 50 ENTLIST)))))
            )
    )
    (QT:DRAWDPATH P STEP 0.0 VLIST COLOR)
    (foreach ENT (caddr ILIST)
     (redraw ENT)
    )
    (foreach ENT QT:PATHLIST
     (entdel (car ENT))
    )
   )
   (if ILIST
    (progn
     (setq P (cadr ILIST))
     (setq ENT (car ILIST))
     (setq ENTLIST (entget ENT))
     (if (listp (car (setq ILIST (QT:GETVLIST))))
      (progn
       (if (= nil (setq COLOR (getint "\nEnter envelope color <34> : ")))
        (setq COLOR 34)
       )
       (setq STEP (* 0.1 (- (nth 2 (cadr (car VLIST))) (nth 0 (cadr (car VLIST))))))
       (setq P (list (+ (car (car ILIST)) (* (nth 0 (cadr (car VLIST))) (cos (cdr (assoc 50 ENTLIST)))))
                     (+ (cadr (car ILIST)) (* (nth 0 (cadr (car VLIST))) (sin (cdr (assoc 50 ENTLIST)))))
               )
       )
       (QT:DRAWPATH P ENT STEP 0.0 VLIST COLOR)
       (foreach ENT (caddr ILIST)
        (redraw ENT)
       )
       (foreach ENT QT:PATHLIST
        (entdel (car ENT))
       )
      )
     )
    )
   )
  )
 )
 T
)