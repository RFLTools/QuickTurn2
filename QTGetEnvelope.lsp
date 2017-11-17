;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:GETENVELOPE returns the point list of the polyline/lwpolyline on layer defpoints in the entity
;
;
(defun QT:GETENVELOPE (ENT / BLOCKSCALE ENT2 ENTLIST ENTNAME NODE P VLIST)
 (setq VLIST nil)
 (setq ENTLIST (entget ENT))
 (setq BLOCKSCALE (cdr (assoc 41 ENTLIST)))
 (setq ENTNAME (cdr (assoc 2 ENTLIST)))
 (setq ENTLIST (tblsearch "BLOCK" ENTNAME))
 (setq ENT2 (cdr (assoc -2 ENTLIST)))
 (while (/= ENT2 nil)
  (setq ENTLIST (entget ENT2))
  (if (and (= (strcase (cdr (assoc 8 ENTLIST))) "DEFPOINTS")
           (or (= (cdr (assoc 0 ENTLIST)) "POLYLINE")
               (= (cdr (assoc 0 ENTLIST)) "LWPOLYLINE")))
   (progn
    (if (= (cdr (assoc 0 ENTLIST)) "LWPOLYLINE")
     (progn
      (while (/= (setq NODE (car ENTLIST)) nil)
       (setq ENTLIST (cdr ENTLIST))
       (if (= 10 (car NODE))
        (setq VLIST (append VLIST (list (mapcar '(lambda (N) (* N BLOCKSCALE)) (cdr NODE)))))
       )
      )
     )
     (progn
      (setq ENT2 (entnext ENT2))
      (setq ENTLIST (entget ENT2))
      (while (= (cdr (assoc 0 ENTLIST)) "VERTEX")
       (setq P (cdr (assoc 10 ENTLIST)))
       (setq P (list (* BLOCKSCALE (car P)) (* BLOCKSCALE (cadr P))))
       (setq VLIST (append VLIST (list P)))
       (setq ENT2 (entnext ENT2))
       (setq ENTLIST (entget ENT2))
      )
     )
    )
    (setq ENT2 nil)
   )
   (if (/= nil ENT2) (setq ENT2 (entnext ENT2)))
  )
 )
 VLIST
)
