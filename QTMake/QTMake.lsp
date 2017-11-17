;
;
;     Program written by Robert Livingston, 2015-04-13
;     Adapted from MAKEENT
;
;     C:QTMAKE is a utility to create QuickTurn Vehicle Blocks
;
;
(defun C:QTMAKE (/ DCL_ID ACCEPTQTMAKE ACTIVEDOC ACTIVESPACE ANGBASE ANGDIR ATTREQ BLOCKINDEX BLOCKLIST CANCELQTMAKE CONTINUEFLAG D D0 DG DH ENT ENTLIST ENTSET L LA LB P PBASE PLA PLB WF WR UPDATEBLOCK TMP)
 (command "._UNDO" "M")
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq ANGBASE (getvar "ANGBASE"))
 (setvar "ANGBASE" 0)
 (setq ANGDIR (getvar "ANGDIR"))
 (setvar "ANGDIR" 0)
 (setq OSMODE (getvar "OSMODE"))
 (setq ATTREQ (getvar "ATTREQ"))
 (setvar "ATTREQ" 0)
 (vl-load-com)
  
 (defun ACCEPTQTMAKE (/ C ENT ENTLIST NODE P ORTHOMODE OSMODE)
  (done_dialog)
  (unload_dialog DCL_ID)
  (setq CONTINUEFLAG nil)
 )
 
 (defun CANCELQTMAKE ()
  (done_dialog)
  (unload_dialog DCL_ID)
  (setq CONTINUEFLAG nil)
  (setq BLOCKINDEX nil)
 )

 (defun UPDATEBLOCK ()
  (setq BLOCKINDEX (atoi (get_tile "BLOCKNAME")))
  (done_dialog)
  (unload_dialog DCL_ID)
 )

 (setq BLOCKLIST (list (list "TAC-2017-A-BUS" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-A-BUS-FRONT" "TAC-2017-A-BUS-REAR")
                       (list "TAC-2017-ATD" "*WheelLeftM1" "*WheelRightM1" "TAC-2017-ATD-TRUCK" "TAC-2017-ATD-TRAILER1" "TAC-2017-ATD-PUP" "TAC-2017-ATD-TRAILER2")
                       (list "TAC-2017-B-12" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-B-12")
                       (list "TAC-2017-BTD" "*WheelLeftM1" "*WheelRightM1" "TAC-2017-BTD-TRUCK" "TAC-2017-BTD-TRAILER1" "TAC-2017-BTD-TRAILER2")
                       (list "TAC-2017-HSU" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-HSU")
                       (list "TAC-2017-I-BUS" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-I-BUS")
                       (list "TAC-2017-LSU" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-LSU")
                       (list "TAC-2017-MSU" "*WheelLeftM2" "*WheelRightM2" "TAC-2017-MSU")
                       (list "TAC-2017-P" "*WheelLeftM3" "*WheelRightM3" "TAC-2017-P")
                       (list "TAC-2017-WB-19" "*WheelLeftM1" "*WheelRightM1" "TAC-2017-WB-19-TRUCK" "TAC-2017-WB-19-TRAILER")
                       (list "TAC-2017-WB-20" "*WheelLeftM1" "*WheelRightM1" "TAC-2017-WB-20-TRUCK" "TAC-2017-WB-20-TRAILER")
                       (list "Special-19HeavyHaul" "*WheelLeftM2" "*WheelRightM2" "*WheelLeftM6" "*WheelRightM6" "Special-19HeavyHaul-Truck" "Special-19HeavyHaul-Pup1" "Special-19HeavyHaul-Pup2" "Special-19HeavyHaul-Trailer" "Special-19HeavyHaul-Pup3" "Special-19HeavyHaul-Pup4")
                       (list "BC_MOTI-WB-15" "*WheelLeftM1" "*WheelRightM1" "BC_MOTI-WB-15-TRUCK" "BC_MOTI-WB-15-TRAILER")
                       (list "BC_MOTI-LG3" "*WheelLeftM1" "*WheelRightM1" "BC_MOTI-LG3-TRUCK" "BC_MOTI-LG3-TRAILER1" "BC_MOTI-LG3-TRAILER2" "BC_MOTI-LG3-LOAD")
                       (list "BC_MOTI-LG5" "*WheelLeftM1" "*WheelRightM1" "BC_MOTI-LG5-TRUCK" "BC_MOTI-LG5-TRAILER1" "BC_MOTI-LG5-TRAILER2" "BC_MOTI-LG5-LOAD")
                       (list "BC_MOTI-TS7" "*WheelLeftM1" "*WheelRightM1" "BC_MOTI-TS7-TRUCK" "BC_MOTI-TS7-TRAILER")
                       (list "AB_INF-5Axle" "*WheelLeftM1" "*WheelRightM1" "AB_INF-5Axle-Truck" "AB_INF-5Axle-Trailer")
                       (list "AB_INF-ABus" "*WheelLeftM2" "*WheelRightM2" "AB_INF-ABus-Front" "AB_INF-ABus-Rear")
                       (list "AB_INF-BUS" "*WheelLeftM2" "*WheelRightM2" "AB_INF-BUS")
                       (list "AB_INF-HeavyHaul" "*WheelLeftM2" "*WheelRightM2" "*Wheel5" "AB_INF-HeavyHaul-Truck" "AB_INF-HeavyHaul-Pup1" "AB_INF-HeavyHaul-Pup2" "AB_INF-HeavyHaul-Trailer" "AB_INF-HeavyHaul-Pup3")
                       (list "AB_INF-I-BUS" "*WheelLeftM2" "*WheelRightM2" "AB_INF-I-BUS")
                       (list "AB_INF-LogHaul" "*WheelLeftM1" "*WheelRightM1" "AB_INF-LogHaul-Truck" "AB_INF-LogHaul-Trailer1" "AB_INF-LogHaul-Trailer2" "AB_INF-LogHaul-Load")
                       (list "AB_INF-P" "*WheelLeftM3" "*WheelRightM3" "AB_INF-P")
                       (list "AB_INF-Pt" "*WheelLeftM3" "*WheelRightM3" "AB_INF-P" "AB_INF-CAMPER")
                       (list "AB_INF-SU9" "*WheelLeftM2" "*WheelRightM2" "AB_INF-SU9")
                       (list "AB_INF-WB-12" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-12-TRUCK" "AB_INF-WB-12-TRAILER")
                       (list "AB_INF-WB-15" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-15-TRUCK" "AB_INF-WB-15-TRAILER")
                       (list "AB_INF-WB-17" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-17-TRUCK" "AB_INF-WB-17-TRAILER")
                       (list "AB_INF-WB-21" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-21-TRUCK" "AB_INF-WB-21-TRAILER")
                       (list "AB_INF-WB-23" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-23-TRUCK" "AB_INF-WB-23-TRAILER1" "AB_INF-WB-23-TRAILER2")
                       (list "AB_INF-WB-28" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-28-TRUCK" "AB_INF-WB-28-TRAILER1" "AB_INF-WB-28-PUP" "AB_INF-WB-28-TRAILER2")
                       (list "AB_INF-WB-33" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-33-TRUCK" "AB_INF-WB-33-TRAILER1" "AB_INF-WB-33-PUP" "AB_INF-WB-33-TRAILER1" "AB_INF-WB-33-PUP" "AB_INF-WB-33-TRAILER2")
                       (list "AB_INF-WB-36" "*WheelLeftM1" "*WheelRightM1" "AB_INF-WB-36-TRUCK" "AB_INF-WB-36-TRAILER1" "AB_INF-WB-36-PUP" "AB_INF-WB-36-TRAILER2")
                       (list "AASHTO-2011-A-BUS" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-A-BUS-FRONT" "AASHTO-2011-A-BUS-REAR")
                       (list "AASHTO-2011-BUS-40" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-BUS-40")
                       (list "AASHTO-2011-BUS-45" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-BUS-45")
                       (list "AASHTO-2011-CITY-BUS" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-CITY-BUS")
                       (list "AASHTO-2011-P" "*WheelLeft4" "*WheelRight4" "AASHTO-2011-P")
                       (list "AASHTO-2011-PB" "*WheelLeft4" "*WheelRight4" "AASHTO-2011-P" "AASHTO-2011-B")
                       (list "AASHTO-2011-PT" "*WheelLeft4" "*WheelRight4" "AASHTO-2011-P" "AASHTO-2011-T")
                       (list "AASHTO-2011-MH" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-MH")
                       (list "AASHTO-2011-MHB" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-MH" "AASHTO-2011-B")
                       (list "AASHTO-2011-MHT" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-MH" "AASHTO-2011-T")
                       (list "AASHTO-2011-S-BUS-36" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-S-BUS-36")
                       (list "AASHTO-2011-S-BUS-40" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-S-BUS-40")
                       (list "AASHTO-2011-SU-30" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-SU-30")
                       (list "AASHTO-2011-SU-40" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-SU-40")
                       (list "AASHTO-2011-WB-40" "*WheelLeft1" "*WheelRight1" "AASHTO-2011-WB-40-TRUCK" "AASHTO-2011-WB-40-TRAILER")
                       (list "AASHTO-2011-WB-62" "*WheelLeft1" "*WheelRight1" "AASHTO-2011-WB-62-TRUCK" "AASHTO-2011-WB-62-TRAILER")
                       (list "AASHTO-2011-WB-67" "*WheelLeft1" "*WheelRight1" "AASHTO-2011-WB-67-TRUCK" "AASHTO-2011-WB-67-TRAILER")
                       (list "AASHTO-2011-WB-67D" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-WB-67D-TRUCK" "AASHTO-2011-WB-67D-TRAILER1" "AASHTO-2011-WB-67D-PUP" "AASHTO-2011-WB-67D-TRAILER2")
                       (list "AASHTO-2011-WB-92D" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-WB-92D-TRUCK" "AASHTO-2011-WB-92D-TRAILER1" "AASHTO-2011-WB-92D-PUP" "AASHTO-2011-WB-92D-TRAILER2")
                       (list "AASHTO-2011-WB-100T" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-WB-100T-TRUCK" "AASHTO-2011-WB-100T-TRAILER" "AASHTO-2011-WB-100T-PUP" "AASHTO-2011-WB-100T-TRAILER" "AASHTO-2011-WB-100T-PUP" "AASHTO-2011-WB-100T-TRAILER")
                       (list "AASHTO-2011-WB-109D" "*WheelLeft2" "*WheelRight2" "AASHTO-2011-WB-109D-TRUCK" "AASHTO-2011-WB-109D-TRAILER" "AASHTO-2011-WB-109D-PUP" "AASHTO-2011-WB-109D-TRAILER")
                       (list "TAC-1999-A-BUS" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-A-BUS-FRONT" "TAC-1999-A-BUS-REAR")
                       (list "TAC-1999-ATD" "*WheelLeftM1" "*WheelRightM1" "TAC-1999-ATD-TRUCK" "TAC-1999-ATD-TRAILER1" "TAC-1999-ATD-PUP" "TAC-1999-ATD-TRAILER2")
                       (list "TAC-1999-B-12" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-B-12")
                       (list "TAC-1999-BTD" "*WheelLeftM1" "*WheelRightM1" "TAC-1999-BTD-TRUCK" "TAC-1999-BTD-TRAILER1" "TAC-1999-BTD-TRAILER2")
                       (list "TAC-1999-HSU" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-HSU")
                       (list "TAC-1999-I-BUS" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-I-BUS")
                       (list "TAC-1999-LSU" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-LSU")
                       (list "TAC-1999-MSU" "*WheelLeftM2" "*WheelRightM2" "TAC-1999-MSU")
                       (list "TAC-1999-P" "*WheelLeftM3" "*WheelRightM3" "TAC-1999-P")
                       (list "TAC-1999-WB-19" "*WheelLeftM1" "*WheelRightM1" "TAC-1999-WB-19-TRUCK" "TAC-1999-WB-19-TRAILER")
                       (list "TAC-1999-WB-20" "*WheelLeftM1" "*WheelRightM1" "TAC-1999-WB-20-TRUCK" "TAC-1999-WB-20-TRAILER")
)
 )

 (setq BLOCKINDEX 0)
 (setq CONTINUEFLAG T)

 (while CONTINUEFLAG
  (if (= QTMAKEDCLNAME nil)
   (progn
    (setq QTMAKEDCLNAME (vl-filename-mktemp "rfl.dcl"))
    (QT:MAKEDCL QTMAKEDCLNAME "QTMAKE")
   )
   (if (= nil (findfile QTMAKEDCLNAME))
    (progn
     (setq QTMAKEDCLNAME (vl-filename-mktemp "rfl.dcl"))
     (QT:MAKEDCL QTMAKEDCLNAME "QTMAKE")
    )
   )
  )
  (setq DCL_ID (load_dialog QTMAKEDCLNAME))
  (if (not (new_dialog "QTMAKE" DCL_ID)) (exit))

  (start_list "BLOCKNAME")
  (foreach NODE BLOCKLIST
   (add_list (car NODE))
  )
  (end_list)

  (set_tile "BLOCKNAME" (itoa BLOCKINDEX))

  (setq QTMAKESLBNAME "quickturn.slb")
  (if (= nil (findfile QTMAKESLBNAME))
   (progn
    (setq QTMAKESLBNAME (vl-filename-mktemp "rfl.slb"))
    (QT:MAKESLB QTMAKESLBNAME)
   )
  )
  (start_image "IMAGE")
  (slide_image 0 0 (- (dimx_tile "IMAGE") 1)
                   (- (dimy_tile "IMAGE") 1)
                   (strcat QTMAKESLBNAME "(" (car (nth BLOCKINDEX BLOCKLIST)) ")")
  )
  (end_image)

  (action_tile "BLOCKNAME" "(UPDATEBLOCK)")
  (action_tile "OK" "(ACCEPTQTMAKE)")
  (action_tile "CANCEL" "(CANCELQTMAKE)")

  (start_dialog)
 )
 
 (if (/= nil BLOCKINDEX)
  (progn
   (if (= nil (cdr (nth BLOCKINDEX BLOCKLIST)))
    (QT:MAKE (car (nth BLOCKINDEX BLOCKLIST)))
    (foreach NODE (cdr (nth BLOCKINDEX BLOCKLIST))
     (if (= "*" (substr NODE 1 1))
      (if (= nil (tblsearch "BLOCK" (substr NODE 2))) (QT:MAKE (substr NODE 2)))
      (if (= nil (tblsearch "BLOCK" NODE)) (QT:MAKE NODE))
     )
    )
   )
   
   (setq ACTIVEDOC (vla-get-activedocument (vlax-get-acad-object)))
   (setq ACTIVESPC
         (vlax-get-property ACTIVEDOC
          (if (or (eq acmodelspace (vla-get-activespace ACTIVEDOC)) (eq :vlax-true (vla-get-mspace ACTIVEDOC)))
           'modelspace
           'paperspace
          )
         )
   )
   
   (setq PLA nil)
   (setq PLB nil)
   (setq PBASE (getpoint "\nSelect point to insert vehicle : "))
   (setvar "OSMODE" 0)
   (setq P PBASE)
   (setq ENTSET (ssadd))
   (setq LA nil LB nil)
   (foreach NODE (cdr (nth BLOCKINDEX BLOCKLIST))
    (if (/= "*" (substr NODE 1 1))
     (progn
;      (setq D nil D0 nil DG nil DH nil L nil LA nil LB nil WF nil WR nil)
      (setq D nil D0 nil DG nil DH nil L nil WF nil WR nil)
      (vla-insertblock ACTIVESPC
                       (vlax-3D-point P)
                       NODE
                       1.0
                       1.0
                       1.0
                       0.0
      )
      (setq ENT (entlast))
      (setq ENTLIST (entget ENT))
      (ssadd ENT ENTSET)
      (setq TMP (QT:GETD ENT))
      (setq D0 (nth 0 TMP)
            DG (nth 1 TMP)
            D (nth 2 TMP)
            DH (nth 3 TMP)
            LOCKANG (nth 4 TMP)
            LB (nth 5 TMP)
            LA (nth 6 TMP)
            WF (nth 7 TMP)
            WR (nth 8 TMP)
      )
      (if (and (= nil PLB) (/= nil LB))
       (progn
        (setq PLB (list (- (+ (car P) LB) D0) (cadr P) (caddr P)))
        (setq LB nil)
       )
      )
      (if (and (/= nil PLB) (/= nil LB))
       (progn
        (setq ENTLIST (subst (list 10 (- (car PLB) LB) (cadr PLB) (caddr PLB)) (assoc 10 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (setq PLB nil)
       )
      )
      (if (or (= nil LA) (= nil LB))
       (progn
        (setq P (cdr (assoc 10 ENTLIST)))
        (setq P (list (- (car P) D0) (cadr P) (caddr P)))
        (setq ENTLIST (subst (cons 10 P) (assoc 10 ENTLIST) ENTLIST))
        (entmod ENTLIST)
        (if (/= nil DH) (setq P (list (+ (car P) DH) (cadr P) (caddr P))))
       )
;       (progn
;       )
      )
     )
    )
   )
  )
 )
 
 (setvar "CMDECHO" CMDECHO)
 (setvar "ANGBASE" ANGBASE)
 (setvar "ANGDIR" ANGDIR)
 (setvar "OSMODE" OSMODE)
 (setvar "ATTREQ" ATTREQ)
 (eval nil)
)
