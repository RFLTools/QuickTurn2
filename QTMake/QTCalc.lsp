;
;
;     Program written by Robert Livingston, 2015-04-23
;
;     QTCALC is a utility for calculating turn radiis and lock angles
;
;
(defun C:QTCALC (/ DCL_ID CMDECHO CANCELQTCALC FIXNUMBER L RC RD RI RO W WB)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)

 (defun FIXNUMBER (TILE / TMP)
  (set_tile TILE (rtos (setq TMP (atof (get_tile TILE)))))
  (cond ((= "W" TILE)
         (setq W TMP
               RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2)))
               RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2)))
         )
        )
        ((= "WB" TILE)
         (setq WB TMP
               RD (sqrt (- (expt RC 2) (expt WB 2)))
               RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2)))
               RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2)))
               L (* (/ 180.0 pi) (atan (/ WB RD)))
         )
        )
        ((= "L" TILE)
         (setq L TMP
               RC (/ WB (sin (* (/ pi 180.0) L)))
               RD (sqrt (- (expt RC 2) (expt WB 2)))
               RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2)))
               RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2)))
         )
        )
        ((= "RI" TILE)
         (setq RI TMP
               RD (+ (sqrt (- (expt RI 2) (expt WB 2))) (/ W 2.0))
               RC (sqrt (+ (expt WB 2) (expt RD 2)))
               RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2)))
               L (* (/ 180.0 pi) (atan (/ WB RD)))
         )
        )
        ((= "RC" TILE)
         (setq RC TMP
               RD (sqrt (- (expt RC 2) (expt WB 2)))
               RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2)))
               RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2)))
               L (* (/ 180.0 pi) (atan (/ WB RD)))
         )
        )
        ((= "RO" TILE)
         (setq RO TMP
               RD (- (sqrt (- (expt RO 2) (expt WB 2))) (/ W 2.0))
               RC (sqrt (+ (expt WB 2) (expt RD 2)))
               RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2)))
               L (* (/ 180.0 pi) (atan (/ WB RD)))
         )
        )
  )
  (set_tile "W" (rtos W))
  (set_tile "WB" (rtos WB))
  (set_tile "L" (rtos L))
  (set_tile "RI" (rtos RI))
  (set_tile "RC" (rtos RC))
  (set_tile "RO" (rtos RO))
  (setq QTCALCLIST (list (cons "W" W) (cons "WB" WB) (cons "RC" RC)))
 )

 (defun CANCELQTMAKE ()
  (done_dialog)
  (unload_dialog DCL_ID)
 )

 (if (= nil QTCALCLIST)
  (progn
   (setq W 2.6 WB 10.0 RC 12.0)
   (setq RD (sqrt (- (expt RC 2) (expt WB 2))))
   (setq RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2))))
   (setq RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2))))
   (setq L (* (/ 180.0 pi) (atan (/ WB RD))))
  )
  (progn
   (setq W (cdr (assoc "W" QTCALCLIST)))
   (setq WB (cdr (assoc "WB" QTCALCLIST)))
   (setq RC (cdr (assoc "RC" QTCALCLIST)))
   (setq RD (sqrt (- (expt RC 2) (expt WB 2))))
   (setq RI (sqrt (+ (expt (- RD (/ W 2.0)) 2) (expt WB 2))))
   (setq RO (sqrt (+ (expt (+ RD (/ W 2.0)) 2) (expt WB 2))))
   (setq L (* (/ 180.0 pi) (atan (/ WB RD))))
  )
 )
 
 (setq QTCALCDCLNAME "Z:\\Lisp\\GitHub\\QuickTurn\\QTMake\\QTCalc.dcl")
 (if (= QTCALCDCLNAME nil)
  (progn
   (setq QTCALCDCLNAME (vl-filename-mktemp "rfl.dcl"))
   (MAKEDCL QTCALCDCLNAME "QTCALC")
  )
  (if (= nil (findfile QTCALCDCLNAME))
   (progn
    (setq QTCALCDCLNAME (vl-filename-mktemp "rfl.dcl"))
    (MAKEDCL QTCALCDCLNAME "QTCALC")
   )
  )
 )
 (setq DCL_ID (load_dialog QTCALCDCLNAME))
 (if (not (new_dialog "QTCALC" DCL_ID)) (exit))

 (set_tile "W" (rtos W))
 (set_tile "WB" (rtos WB))
 (set_tile "L" (rtos L))
 (set_tile "RI" (rtos RI))
 (set_tile "RC" (rtos RC))
 (set_tile "RO" (rtos RO))
 
 (action_tile "W" "(FIXNUMBER \"W\")")
 (action_tile "WB" "(FIXNUMBER \"WB\")")
 (action_tile "L" "(FIXNUMBER \"L\")")
 (action_tile "RI" "(FIXNUMBER \"RI\")")
 (action_tile "RC" "(FIXNUMBER \"RC\")")
 (action_tile "RO" "(FIXNUMBER \"RO\")")
 (action_tile "CANCEL" "(CANCELQTMAKE)")

 (start_dialog)
 
 (setvar "CMDECHO" CMDECHO)
 (eval nil)
)
