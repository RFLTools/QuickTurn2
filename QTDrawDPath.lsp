;
;
;     Program written by Robert Livingston, 2017-11-09
;
;     QTDRAWDPATH Draws the path from a point to a second point dynamically
;
;
(defun QT:DRAWDPATH (P STEP A VLIST COLOR / *error* A2 ANGLIST BLOCKLIST DRAWP DRAWSTART ENT ENVLIST JOINALL L MAKEPLINE N1 N2 NODE P2 PLIST PLLIST REP RMIN SIGN STARTLIST STARTLISTLIST STOPFLAG TAN TEMPLIST TMP TOL)
 (defun *error* (msg)
  (if ENT (entdel ENT))
  ;(JOINALL)
  (DRAWSTART)
  (foreach ENT (caddr ILIST)
   (redraw ENT)
  )
  (foreach ENT QT:PATHLIST
   (entdel (car ENT))
  )
  (print msg)
 )
 (defun TAN (A)
  (/ (sin A) (cos A))
 )
 (defun SIGN (X)
  (if (< X 0.0)
   -1.0
   (if (> X 0.0)
    1.0
    0.0
   )
  )
 )
 (setq TOL 0.0000001)
 (defun JOINALL (/ ENT ENTLIST ENTLISTNEW FOUND PLENT NODE TMP)
  (setq PLENT nil)
  (foreach ENT PLLIST
   (if (/= ENT nil)
    (if (= nil PLENT)
     (progn
      (setq PLENT ENT)
      (command "._PEDIT" PLENT "JOIN")
     )
     (progn
      (command ENT)
     )
    )
   )
  )
  (if (/= PLENT nil) (command "" ""))
  
  (setq ENTLISTNEW (list (list (cons 0 "BLOCK")
                               (cons 2 "*U")
                               (cons 8 "0")
                               (cons 70 1)
                               (list 10 0.0 0.0 0.0)
                         )
                   )
  )
  (setq FOUND nil)
  (foreach NODE BLOCKLIST
   (if NODE
    (foreach ENT NODE
     (progn
      (setq FOUND T)
      (setq ENTLIST (entget ENT))
      (setq ENTLISTNEW (append ENTLISTNEW
                              (list (list (cons 0 "INSERT")
                                          (cons 100 "AcDbEntity")
                                          (cons 67 0)
                                          (cons 8 "0")
                                          (cons 100 "AcDbBlockReference")
                                          (assoc 2 ENTLIST)
                                          (assoc 10 ENTLIST)
                                          (assoc 41 ENTLIST)
                                          (assoc 42 ENTLIST)
                                          (assoc 43 ENTLIST)
                                          (assoc 50 ENTLIST)
                                          (assoc 70 ENTLIST)
                                          (assoc 71 ENTLIST)
                                          (assoc 44 ENTLIST)
                                          (assoc 45 ENTLIST)
                                    )
                              )
                       )
      )
      (entdel ENT)
     )
    )
   )
  )
  (setq ENTLISTNEW (append ENTLISTNEW (list (list (cons 0 "ENDBLK")
                                                  (cons 100 "AcDbBlockEnd")
                                                  (cons 8 "0")
                                            )
                                      )
                   )
  )
  (if FOUND
   (progn
    (entmake)
    (foreach NODE ENTLISTNEW
     (setq TMP (entmake NODE))
    )
    (entmake (list (cons 0 "INSERT")
                   (cons 2 TMP)
                   (list 10 0.0 0.0 0.0)
                   (cons 41 1.0)
                   (cons 42 1.0)
                   (cons 43 1.0)
                   (cons 50 0.0)
             )
    )
    (command "._DRAWORDER" (entlast) "" "BACK")
    (entlast)
   )
  )
  
  (setq ENTLISTNEW (list (list (cons 0 "BLOCK")
                               (cons 2 "*U")
                               (cons 8 "0")
                               (cons 70 1)
                               (list 10 0.0 0.0 0.0)
                         )
                   )
  )
  (setq FOUND nil)
  (foreach ENT ENVLIST
   (if ENT
    (progn
     (setq FOUND T)
     (setq ENTLIST (entget ENT))
     (setq ENTLISTNEW (append ENTLISTNEW
                             (list (list (cons 0 "INSERT")
                                         (cons 100 "AcDbEntity")
                                         (cons 67 0)
                                         (cons 8 "0")
                                         (cons 100 "AcDbBlockReference")
                                         (assoc 2 ENTLIST)
                                         (assoc 10 ENTLIST)
                                         (assoc 41 ENTLIST)
                                         (assoc 42 ENTLIST)
                                         (assoc 43 ENTLIST)
                                         (assoc 50 ENTLIST)
                                         (assoc 70 ENTLIST)
                                         (assoc 71 ENTLIST)
                                         (assoc 44 ENTLIST)
                                         (assoc 45 ENTLIST)
                                   )
                             )
                      )
     )
     (entdel ENT)
    )
   )
  )
  (setq ENTLISTNEW (append ENTLISTNEW (list (list (cons 0 "ENDBLK")
                                                  (cons 100 "AcDbBlockEnd")
                                                  (cons 8 "0")
                                            )
                                      )
                   )
  )
  (if FOUND
   (progn
    (entmake)
    (foreach NODE ENTLISTNEW
     (setq TMP (entmake NODE))
    )
    (entmake (list (cons 0 "INSERT")
                   (cons 2 TMP)
                   (list 10 0.0 0.0 0.0)
                   (cons 41 1.0)
                   (cons 42 1.0)
                   (cons 43 1.0)
                   (cons 50 0.0)
             )
    )
    (command "._DRAWORDER" (entlast) "" "BACK")
    (entlast)
   )
  )
  
  (setq ENT nil)
 )
 (defun MAKEPLINE (PL A / ANG DIR ENT ENTLIST L R)
  (setq ENT nil)
  (cond ((= (length PL) 2)
         (progn
          (if (< (setq ANG (- (angle (cadr PL) (car PL)) A)) 0.0)
           (setq ANG (+ ANG (* 2.0 pi)))
          )
          (if (> ANG pi)
           (setq DIR -1.0
                 ANG (- (* 2.0 pi) ANG)
           )
           (setq DIR 1.0)
          )
          (if (< (sin ANG) TOL)
           (setq R nil
                 L (distance (car PL) (cadr PL))
           )
           (setq R (/ (distance (car PL) (cadr PL)) 2.0 (sin ANG))
                 L (/ (* (distance (car PL) (cadr PL)) ANG) (sin ANG))
           )
          )
          (if (and R (< R RMIN))
           (setq PL (list (car PL)
                          (list (+ (car (car PL)) (* 2.0 RMIN (sin ANG) (cos (+ pi A (* DIR ANG)))))
                                (+ (cadr (car PL)) (* 2.0 RMIN (sin ANG) (sin (+ pi A (* DIR ANG)))))
                          )
                    )
                 L (/ (* (distance (car PL) (cadr PL)) ANG) (sin ANG))
           )
          )
          (if (< L (* 500.0 STEP))
           (progn
            (setq ENTLIST (list (cons 0 "LWPOLYLINE")
                                (cons 100 "AcDbEntity")
                                (cons 100 "AcDbPolyline")
                                (cons 90 2)
                                (cons 70 128)
                                (cons 43 0.0)
                                (cons 38 0.0)
                                (cons 39 0.0)
                                (list 10 (car (car PL)) (cadr (car PL)))
                                (cons 42 (* DIR (TAN (/ (* 2.0 ANG) 4.0))))
                                (list 10 (car (cadr PL)) (cadr (cadr PL)))
                                (list 210 0.0 0.0 1.0)
                          )
            )
            (if (entmake ENTLIST) (setq ENT (entlast)))
           )
          )
         )
        )
        ((= (length PL) 3)
         (progn
          (princ "!")
         )
        )
  )
  (setq ANG (+ A (* 2.0 DIR ANG)))
  (if (> ANG (* 2.0 pi)) (setq ANG (- ANG (* 2.0 pi))))
  (if ENT (list ENT ANG PL) nil)
 )
 (defun DRAWSTART (/ NODE)
  (foreach NODE STARTLIST
   (progn
    (setq ENTLIST (entget (car NODE)))
    (setq ENTLIST (subst (cons 10 (cadr NODE)) (assoc 10 ENTLIST) ENTLIST))
    (setq ENTLIST (subst (cons 50 (caddr NODE)) (assoc 50 ENTLIST) ENTLIST))
    (entmod ENTLIST)
    (entupd (car NODE))
   )
  )
 )
 (defun DRAWP (P2 /)
  (if (/= ENT nil)
   (progn
    (entdel ENT)
    (setq ENT nil)
   )
  )
  (DRAWSTART)
  (if (and (> (distance P P2) (* 2.0 STEP)) (setq ENT (MAKEPLINE (list P P2) (- (caddar STARTLIST) A))))
   (progn
    (setq P2 (cadr (caddr ENT)))
    (setq A2 (cadr ENT))
    (setq ENT (car ENT))
    (QT:MAKEPATH ENT VLIST STEP)
    (QT:DRAWATEND)
   )
  )
  P2
 )
 (defun SETSTARTLIST (/ A2 NODE P2)
  (setq STARTLIST nil)
  (foreach NODE VLIST
   (setq ENTLIST (entget (car NODE))
         P2 (cdr (assoc 10 ENTLIST))
         A2 (cdr (assoc 50 ENTLIST))
         STARTLIST (append STARTLIST (list (list (car NODE) P2 A2)))
   )
  )
 )
 (setq STOPFLAG nil ENT nil)
 (SETSTARTLIST)
 (setq STARTLISTLIST (list STARTLIST))
 (setq ANGLIST (list A))
 (setq PLIST (list P))
 (setq PLLIST (list nil))
 (setq ENVLIST (list nil))
 (setq BLOCKLIST (list nil))
 (if (or (= (nth 4 (cadar VLIST)) nil) (= (nth 4 (cadar VLIST)) 0.0))
  (setq RMIN nil)
  (setq RMIN (/ (- (nth 2 (cadar VLIST)) (nth 1 (cadar VLIST))) (sin (* (nth 4 (cadar VLIST)) (/ pi 180.0)))))
 )
 (princ "\nSelect point or Angle / Corner / Quit / eXit : ")
 (while (= STOPFLAG nil)
  (setq REP (grread T))
  (cond ((= (car REP) 2)
         (cond ((or (= (chr (cadr REP)) "q") (= (chr (cadr REP)) "x"))
                (progn
                 (DRAWSTART)
                 (if ENT (entdel ENT))
                 (setq STOPFLAG T)
                 (JOINALL)
                )
               )
               ((= (chr (cadr REP)) "a")
                (progn
                 (setq TMP nil)
                 (if (or (= (nth 4 (cadar VLIST)) nil) (= (nth 4 (cadar VLIST)) 0.0))
                  (if (setq TMP (getangle (strcat "\nNew start wheel angle <" (rtos (* A (/ 180.0 pi))) "> : ")))
                   (if (> (setq A TMP) pi) (setq A (- A (* 2.0 pi))))
                  )
                  (progn
                   (if (setq TMP (getangle (strcat "\nNew start wheel angle (" (rtos (* -1.0 (nth 4 (cadar VLIST)))) " to " (rtos (nth 4 (cadar VLIST))) ") <" (rtos (* A (/ 180.0 pi))) "> : ")))
                    (if (> (setq A TMP) pi) (setq A (- A (* 2.0 pi))))
                   )
                  )
                 )
                 (if (> (abs A) (* (nth 4 (cadar VLIST)) (/ pi 180.0))) (setq A (* (SIGN A) (nth 4 (cadar VLIST)) (/ pi 180.0))))
                )
               )
               ((= (chr (cadr REP)) "c")
                (progn
                 (princ "To come...")
                )
               )
               ((= (chr (cadr REP)) "u")
                (progn
                 (if (last PLLIST) (entdel (last PLLIST)))
                 (setq PLLIST (reverse (cdr (reverse PLLIST))))
                 (if (last ENVLIST) (entdel (last ENVLIST)))
                 (setq ENVLIST (reverse (cdr (reverse ENVLIST))))
                 (if (last BLOCKLIST) (foreach NODE (last BLOCKLIST) (entdel NODE)))
                 (setq BLOCKLIST (reverse (cdr (reverse BLOCKLIST))))
                 (if (last ANGLIST) (setq A (last ANGLIST)))
                 (setq ANGLIST (reverse (cdr (reverse ANGLIST))))
                 (if (last STARTLISTLIST) (setq STARTLIST (last STARTLISTLIST)))
                 (setq STARTLISTLIST (reverse (cdr (reverse STARTLISTLIST))))
                 (DRAWSTART)
                 (if (last PLIST) (setq P (last PLIST)))
                 (setq PLIST (reverse (cdr (reverse PLIST))))
                )
               )
         )
        )
        ((= (car REP) 3)
         (progn
          (setq PLIST (append PLIST (list P)))
          (setq P (DRAWP (cadr REP)))
          (setq PLLIST (append PLLIST (list ENT)))
          (setq BLOCKLIST (append BLOCKLIST (list (QT:COPY))))
          (setq ENVLIST (append ENVLIST (list (QT:DRAWENVELOPE COLOR VLIST))))
          (setq STARTLISTLIST (append STARTLISTLIST (list STARTLIST)))
          (SETSTARTLIST)
          (setq ANGLIST (append ANGLIST (list A)))
          (if (< (setq A (- (caddar STARTLIST) A2)) 0.0) (setq A (+ A (* 2.0 pi))))
          (if (> A pi) (setq A (- A (* 2.0 pi))))
          (setq ENT nil)
         )
        )
        ((= (car REP) 5)
         (progn
          (DRAWP (cadr REP))
         )
        )
  )
 )
)
