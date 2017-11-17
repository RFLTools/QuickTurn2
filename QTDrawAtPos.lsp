;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTDRAWATPOS draws the vehicle in it's nth position
;
;
(defun QT:DRAWATPOS (C / ANG ANGW CMAX ENT ENTLIST NODE P)
 (if QT:PATHLIST
  (progn
   (if (< C 0)
    (setq C 0)
    (if (> C (setq CMAX (- (length (cadr (car QT:PATHLIST))) 1)))
     (setq C CMAX)
    )
   )
   (foreach NODE QT:PATHLIST
    (progn
     (setq ENT (car NODE)
           P (nth C (cadr NODE))
           ANG (nth C (caddr NODE))
     )
     (if (= C CMAX)
      (setq ANGW (angle (nth (1- C) (cadr NODE)) (nth C (cadr NODE))))
      (setq ANGW (angle (nth C (cadr NODE)) (nth (1+ C) (cadr NODE))))
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
 )
 nil
)
