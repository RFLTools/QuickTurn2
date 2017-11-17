;
;
;     Program written by Robert Livingston, 2017-11-10
;
;     QTMAKEPATH computes the vehicle path along ENT
;
;
(defun QT:MAKEPATH (ENT VLIST STEP / *error* ALIST A2 ANG C D D0 DG DH ENTLIST DLIST ILIST L NODE P P1 P2 PLIST)
 (setq QT:PATHLIST nil PLIST nil)
 (foreach NODE VLIST
  (progn
   (setq ENTLIST (entget (car NODE)))
   (setq P (cdr (assoc 10 ENTLIST)))
   (setq ANG (cdr (assoc 50 ENTLIST)))
   (setq D0 (nth 0 (cadr NODE))
         DG (nth 1 (cadr NODE))
         D  (nth 2 (cadr NODE))
         DH (nth 3 (cadr NODE))
         L  (nth 4 (cadr NODE))
   )
   (setq P1 (list (+ (car P) (* D0 (cos ANG)))
                  (+ (cadr P) (* D0 (sin ANG)))
            )
   )
   (if (= PLIST nil)
    (setq PLIST (QT:GETPLIST P1 STEP ENT))
   )
   (setq ALIST (QT:GETALIST PLIST ANG (- D DG)))
   (setq C 0)
   (setq ILIST nil)
   (while (< C (length PLIST))
    (setq P2 (nth C PLIST)
          A2 (nth C ALIST)
    )
    (setq ILIST (append ILIST (list (list (+ (car P2) (* D0 (cos (+ A2 pi))))
                                          (+ (cadr P2) (* D0 (sin (+ A2 pi))))
                                    )
                              )
                )
    )
    (setq C (1+ C))
   )
   (setq QT:PATHLIST (append QT:PATHLIST (list (list (car NODE) ILIST ALIST (cadr NODE)))))
   (if (/= DH 0.0) (setq PLIST (QT:GETHLIST PLIST ALIST (- DH DG))))
  )
 )
)
