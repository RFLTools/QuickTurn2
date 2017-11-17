;
;
;     Program written by Robert Livingston, 2015-11-13
;
;     QT:GetD returns the Vehicle parameters for an entered vehicle
;
;     Returns (DEye DGear DRear DHook LockAng LoadBase LoadAngle WheelFront WheelRear)
;
;     DEye (D0) = Distance from block insertion point to the eye point (the path point of the vehicle)
;     DGear (DG) = Distance from block insertion point to front wheels
;     DRear (D) = Distance from block insertion point to rear wheels
;     DHook (DH) = Distance from block insertion point to hitch (king pin)
;     LockAng (LOCKANG) = Wheel lock angle
;     LoadBase (LB) = Distance from block insertion point to load pivot/base point
;     LoadAngle (LA) = Distance from block insertion point to load angle definition point
;     WheelFront (WF) = Width between front wheels (not used at this time)
;     WheelRear (WR) = Width between rear wheels (not used at this time)
;
;
(defun QT:GETD (ENT / D D0 DG DH ENTLIST LA LB LOCKANG WF WR)
 (setq D nil
       D0 nil
       DG nil
       DH nil
       LOCKANG nil
       LA nil
       LB nil
       WF nil
       WR nil
 )
 (if (/= nil ENT)
  (progn
   (setq ENTLIST (entget ENT))
   (setq BLOCKSCALE (cdr (assoc 41 ENTLIST)))
   (if (and (= "INSERT" (cdr (assoc 0 ENTLIST))) (= 1 (cdr (assoc 66 ENTLIST))))
    (progn
     (setq ENT (entnext ENT))
     (setq ENTLIST (entget ENT))
     (while (= "ATTRIB" (cdr (assoc 0 ENTLIST)))
      (cond ((= "D0" (strcase (cdr (assoc 2 ENTLIST))))
             (setq D0 (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "DG" (strcase (cdr (assoc 2 ENTLIST))))
             (setq DG (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "D" (strcase (cdr (assoc 2 ENTLIST))))
             (setq D (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "DH" (strcase (cdr (assoc 2 ENTLIST))))
             (setq DH (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "L" (strcase (cdr (assoc 2 ENTLIST))))
             (if (/= "" (cdr (assoc 1 ENTLIST)))
              (setq LOCKANG (atof (cdr (assoc 1 ENTLIST))))
             )
            )
            ((= "LB" (strcase (cdr (assoc 2 ENTLIST))))
             (setq LB (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "LA" (strcase (cdr (assoc 2 ENTLIST))))
             (setq LA (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
            )
            ((= "WF" (strcase (cdr (assoc 2 ENTLIST))))
             (if (/= "" (cdr (assoc 1 ENTLIST)))
              (setq WF (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
             )
            )
            ((= "WR" (strcase (cdr (assoc 2 ENTLIST))))
             (if (/= "" (cdr (assoc 1 ENTLIST)))
              (setq WR (* BLOCKSCALE (atof (cdr (assoc 1 ENTLIST)))))
             )
            )
      )
      (setq ENT (entnext ENT))
      (setq ENTLIST (entget ENT))
     )
    )
   )
  )
 )
 (list D0 DG D DH LOCKANG LB LA WF WR)
)
