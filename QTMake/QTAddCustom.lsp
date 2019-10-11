;
;
;     Program written by Robert Livingston, 2019-10-10
;
;     QTADDCUSTOM adds a custom vehicle to the QuickTurn library
;
;
(defun C:QTADDCUSTOM (/ BLOCKNESTLIST C CHECKEXIST CHECKNAME CFILE COLUMN CUSTOMFILE CUSTOMFOLDER ENT ENTLIST ENTSET NODE VFILE VNAME)
 (defun CHECKNAME (NAME / BADLIST CH FLAG)
  (setq FLAG T)
  (setq BADLIST (list "\\" "/" ":" "*" "?" "\"" "<" ">" "|" ","))
  (foreach CH BADLIST
   (if (vl-string-search CH NAME)
    (setq FLAG nil)
   )
  )
  FLAG
 )
 (defun CHECKEXIST (NAME / FILE FLAG INLINE)
  (setq FLAG T)
  (setq FILE (open CUSTOMFILE "r"))
  (while (setq INLINE (read-line FILE))
   (if (= NAME (COLUMN INLINE 1 ","))
    (setq FLAG nil)
   )
  )
  (close FILE)
  FLAG
 )
 (defun COLUMN (LINE COL DELIM)
  (if (= (vl-string-search DELIM LINE) nil)
   nil
   (progn
    (while (and (> (setq COL (1- COL)) 0)
                (/= (vl-string-search DELIM LINE) nil)
           )
     (setq LINE (substr LINE (+ (vl-string-search DELIM LINE) 2)))
    )
    (if (= COL 0)
     (if (/= (vl-string-search DELIM LINE) nil)
      (substr LINE 1 (vl-string-search DELIM LINE))
      LINE
     )
     nil
    )
   )
  )
 )
 (if (setq CUSTOMFILE (findfile (strcat (getenv "programdata") "\\RFLTools\\QuickTurn\\CustomVehicles.txt")))
  (progn
   (setq CUSTOMFOLDER (findfile (strcat (getenv "programdata") "\\RFLTools\\QuickTurn")))
  )
  (progn
   (vl-mkdir (strcat (getenv "programdata") "\\RFLTools"))
   (vl-mkdir (strcat (getenv "programdata") "\\RFLTools\\QuickTurn"))
   (setq VFILE (open (strcat (getenv "programdata") "\\RFLTools\\QuickTurn\\CustomVehicles.txt") "w"))
   (close VFILE)
  )
 )
 
 (setq CUSTOMFILE (findfile (strcat (getenv "programdata") "\\RFLTools\\QuickTurn\\CustomVehicles.txt")))
 (setq CUSTOMFOLDER (findfile (strcat (getenv "programdata") "\\RFLTools\\QuickTurn")))
 
 (if CUSTOMFILE
  (progn
   (setq VNAME nil)
   (while (not VNAME)
    (if (setq VNAME (getstring "\nEnter vehicle name (no spaces) : "))
     (setq VNAME (strcat "CUSTOM-" (strcase VNAME)))
    )
    (if VNAME
     (if (and (CHECKNAME VNAME) (CHECKEXIST VNAME))
      (progn
       (setq ENTSET (ssadd))
       (while (setq ENT (car (entsel "\nSelect vehicle block (<return> when done) : ")))
        (setq ENTLIST (entget ENT))
        (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
         (progn
          (ssadd ENT ENTSET)
          (redraw ENT 2)
         )
        )
       )
       (setq C 0)
       (while (< C (sslength ENTSET))
        (setq ENT (ssname ENTSET C))
        (setq C (1+ C))
        (redraw ENT 1)
       )
       (setq BLOCKNESTLIST (QT:WBLOCKLISTCUSTOM ENTSET VNAME CUSTOMFOLDER))
       (setq CFILE (open CUSTOMFILE "a"))
       (princ VNAME CFILE)
       (foreach NODE BLOCKNESTLIST
        (princ (strcat ",*" NODE) CFILE)
       )
       (setq C 0)
       (while (< C (sslength ENTSET))
        (princ (strcat "," (cdr (assoc 2 (entget (ssname ENTSET C))))) CFILE)
        (setq C (1+ C))
       )
       (princ "\n" CFILE)
       (close CFILE)
      )
      (progn
       (princ "\nProblem with vehicle name or already vehicle exists!")
       (setq VNAME nil)
      )
     )
    )
   )
  )
  (princ "\n!!! Problem opening custom folder !!!")
 )
 nil
)