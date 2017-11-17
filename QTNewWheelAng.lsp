;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:NEWWHEELANG Updates the wheel angle for NODE
;
;
(defun QT:NEWWHEELANG (NODE ANG / A ANG2 D D0 ENT ENT2 ENT3 ENTLIST P SCALE TAN TOL X Y)
 (setq TOL 0.000001)
 (defun TAN (ANG)
  (/ (sin ANG) (cos ANG))
 )
 (setq ENT (car NODE))
 (setq ENTLIST (entget ENT))
 (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
  (progn
   (setq SCALE (cdr (assoc 41 ENTLIST)))
   (setq ENTLIST (tblsearch "BLOCK" (cdr (assoc 2 ENTLIST))))
   (setq ENT2 (cdr (assoc -2 ENTLIST)))
   (while (/= nil ENT2)
    (setq ENTLIST (entget ENT2))
    (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
     (progn
      (if (< (abs ANG) TOL)
       (setq ANG2 ANG)
       (progn
        (setq P (cdr (assoc 10 ENTLIST)))
        (setq X (* (car P) SCALE))
        (setq Y (* (cadr P) SCALE))
        (setq D0 (nth 0 (cadddr NODE))
              D (nth 2 (cadddr NODE))
        )
        (setq A (/ (- D D0) (TAN ANG)))
        (setq ANG2 (atan (/ (- D X) (+ A Y))))
       )
      )
      (setq ENTLIST (subst (cons 50 ANG2) (assoc 50 ENTLIST) ENTLIST))
      (entmod ENTLIST)
      (entupd ENT2)
      (entupd ENT)
     )
    )
    (setq ENT2 (entnext ENT2))
   )
  )
 )
)
