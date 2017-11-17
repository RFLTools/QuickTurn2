;
;
;   Program written by Robert Livingston, 2016-05-16
;
;   QT:COPY copies a vehicle at posicion 'C' to a temporary block
;
;
(defun QT:COPY (/ NODE BLOCKLIST)
 (setq BLOCKLIST nil)
 (foreach NODE QT:PATHLIST
  (progn
   (setq BLOCKLIST (append BLOCKLIST (list (QT:MAKETEMPBLOCK (car NODE)))))
  )
 )
 BLOCKLIST
)
