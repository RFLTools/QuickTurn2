;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTDRAWATSTART draws the vehicle in it's first position
;
;
(defun QT:DRAWATSTART (/ ANG ANGW ENT ENTLIST NODE P)
 (if QT:PATHLIST
  (foreach NODE QT:PATHLIST
   (progn
    (setq ENT (car NODE)
          P (car (cadr NODE))
          ANG (car (caddr NODE))
          ANGW (angle (car (cadr NODE)) (cadr (cadr NODE)))
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
