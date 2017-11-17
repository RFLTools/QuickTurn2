;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTDRAWATEND draws the vehicle in it's last position
;
;
(defun QT:DRAWATEND (/ ANG ANGW ENT ENTLIST NODE P)
 (if QT:PATHLIST
  (foreach NODE QT:PATHLIST
   (progn
    (setq ENT (car NODE)
          P (last (cadr NODE))
          ANG (last (caddr NODE))
          ANGW (angle (cadr (reverse (cadr NODE))) (car (reverse (cadr NODE))))
    )
    (QT:NEWWHEELANG NODE (- ANGW ANG))
    (setq ENTLIST (entget ENT))
    (setq ENTLIST (subst (cons 10 P) (assoc 10 ENTLIST) ENTLIST))
    (setq ENTLIST (subst (cons 50 ANG) (assoc 50 ENTLIST) ENTLIST))
    (entmod ENTLIST)
    (entupd ENT)
   )
  )
 )
 nil
)
