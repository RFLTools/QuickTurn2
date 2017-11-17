;
;
;     Program written by Robert Livingston, 2017-11-09
;
;     QTGETHLIST returns a list of Hook Points baset on a plist and anglist
;
;
(defun QT:GETHLIST (PLIST ALIST L / A C HLIST P)
 (setq C 0 HLIST nil)
 (while (< C (length PLIST))
  (setq P (nth C PLIST) A (nth C ALIST))
  (setq HLIST (append HLIST (list (list (+ (car P) (* L (cos A)))
                                        (+ (cadr P) (* L (sin A)))
                                  )
                            )
              )
  )
  (setq C (1+ C))
 )
 HLIST
)
