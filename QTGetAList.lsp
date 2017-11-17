;
;
;     Program written by Robert Livingston, 2017-11-09
;
;     QTGETALIST returns a list of angles swept along PLIST
;
;
(defun QT:GETALIST (PLIST ENTANG L / A ALIST D P PLAST SIGN TAN TOL)
 (defun SIGN (N) (if (= N 0.0) 0.0 (if (< N 0.0) -1.0 1.0)))
 (defun TAN (A) (/ (sin A) (cos A)))
 (setq TOL 0.000001)

 (setq ALIST nil PLAST nil)
 (if (>= (length PLIST) 2)
  (progn
   (foreach P PLIST
    (progn
     (if (= nil PLAST)
      (setq PLAST P)
      (if (> (setq D (distance P PLAST)) TOL)
       (progn
        (setq A (- ENTANG (angle P PLAST)))
        (while (< A 0.0) (setq A (+ A (* 2.0 pi))))
        (while (>= A (* 2.0 pi)) (setq A (- A (* 2.0 pi))))
        (setq SIGN 1.0)
        (if (> A pi) (setq SIGN -1.0 A (- (* 2.0 pi) A)))
        (if (< A TOL)
         (setq A 0.0)
         (setq A (* 2.0
                    (atan (exp (- (log (TAN (/ (abs A) 2.0)))
                                  (/ D L)
                               )
                          )
                    )
                 )
         )
        )
        (setq ENTANG (+ (angle P PLAST) (* SIGN A)))
        (while (< ENTANG 0.0) (setq ENTANG (+ ENTANG (* 2.0 pi))))
        (while (>= ENTANG (* 2.0 pi)) (setq ENTANG (- ENTANG (* 2.0 pi))))
       )
      )
     )
     (setq PLAST P)
     (setq ALIST (append ALIST (list ENTANG)))
    )
   )
  )
 )
 ALIST
)
