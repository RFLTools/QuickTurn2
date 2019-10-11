;
;
;     Program written by Robert Livingston, 2019-10-10
;
;     QT:WBLOCKLISTCUSTOM is a tool for writing custom MAKEENT programs
;
;
(defun QT:WBLOCKLISTCUSTOM (ENTSET FILENAME FOLDERNAME / BLOCKNESTLIST CMDECHO CODE DIMZIN ENT ENTLIST LSTSEARCH NODE OUTFILE VAL)
 (setq CMDECHO (getvar "CMDECHO"))
 (setvar "CMDECHO" 0)
 (setq DIMZIN (getvar "DIMZIN"))
 (setvar "DIMZIN" 8)

 (defun LSTSEARCH (STR LST / NODE RES)
  (setq RES nil)
  (foreach NODE LST
   (if (= (strcase NODE) (strcase STR)) (setq RES T))
  )
  RES
 )
 (setq BLOCKNESTLIST nil)
 (setq OUTFILE (open (strcat FOLDERNAME "\\" FILENAME ".lsp") "w"))
 (setq C 0)
 (while (< C (sslength ENTSET))
  (setq ENT (ssname ENTSET C))
  (if (= "INSERT" (cdr (assoc 0 (setq ENTLIST (entget ENT)))))
   (progn
    (princ "(entmake)\n" OUTFILE)
    (princ "(entmake\n" OUTFILE)
    (princ " (list\n" OUTFILE)
    (setq ENTLIST (tblsearch "BLOCK" (cdr (assoc 2 ENTLIST))))
    (setq ENT (cdr (assoc -2 ENTLIST)))
    (while (/= nil ENTLIST)
     (setq NODE (car ENTLIST))
     (setq ENTLIST (cdr ENTLIST))
     (setq CODE (car NODE))
     (if (and (>= CODE 0) (<= CODE 100) (/= CODE 5))
      (if (= (vl-list-length NODE) nil)
       (progn
        (princ
         (strcat "  (cons "
                 (itoa CODE)
                 " "
                 (if (numberp (cdr NODE))
                  (rtos (cdr NODE) 2 8)
                  (strcat "\"" (cdr NODE) "\"")
                 )
                 ")\n"
         )
         OUTFILE
        )
       )
       (progn
        (princ "  (list" OUTFILE)
        (foreach VAL NODE (princ " " OUTFILE)
                          (if (numberp VAL)
                              (princ (rtos VAL 2 8) OUTFILE)
                              (princ (strcat "\"" VAL "\"") OUTFILE)
                          )
        )
        (princ ")\n" OUTFILE)
       )
      )
     )
    )
    (princ " )\n" OUTFILE)
    (princ ")\n" OUTFILE)
    (while (/= ENT nil)
     (setq ENTLIST (entget ENT))
     (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
      (if (= nil (LSTSEARCH (cdr (assoc 2 ENTLIST)) BLOCKNESTLIST))
       (setq BLOCKNESTLIST (append BLOCKNESTLIST (list (cdr (assoc 2 ENTLIST)))))
      )
     )
     (setq ENT (entnext ENT))
     (princ "(entmake\n" OUTFILE)
     (princ " (list\n" OUTFILE)
     (while (/= ENTLIST nil)
      (setq NODE (car ENTLIST))
      (setq ENTLIST (cdr ENTLIST))
      (setq CODE (car NODE))
      (if (and (>= CODE 0) (<= CODE 100) (/= CODE 5))
       (if (= (vl-list-length NODE) nil)
        (progn
         (princ
          (strcat "  (cons "
                  (itoa CODE)
                  " "
                  (if (numberp (cdr NODE))
                   (rtos (cdr NODE) 2 8)
                   (strcat "\"" (cdr NODE) "\"")
                  )
                  ")\n"
          )
          OUTFILE
         )
        )
        (progn
         (princ "  (list" OUTFILE)
         (foreach VAL NODE (princ " " OUTFILE)
                           (if (numberp VAL)
                               (princ (rtos VAL 2 8) OUTFILE)
                               (princ (strcat "\"" VAL "\"") OUTFILE)
                           )
         )
         (princ ")\n" OUTFILE)
        )
       )
      )
     )
     (princ " )\n" OUTFILE)
     (princ ")\n" OUTFILE)
    )
    (princ "(entmake (list (cons 0 \"ENDBLK\")))\n" OUTFILE)
   )
  )
  (setq C (+ C 1))
 )
 (foreach NODE BLOCKNESTLIST
  (progn
   (princ "(entmake)\n" OUTFILE)
   (princ "(entmake\n" OUTFILE)
   (princ " (list\n" OUTFILE)
   (setq ENTLIST (tblsearch "BLOCK" NODE))
   (setq ENT (cdr (assoc -2 ENTLIST)))
   (while (/= nil ENTLIST)
    (setq NODE (car ENTLIST))
    (setq ENTLIST (cdr ENTLIST))
    (setq CODE (car NODE))
    (if (and (>= CODE 0) (<= CODE 100) (/= CODE 5))
     (if (= (vl-list-length NODE) nil)
      (progn
       (princ
        (strcat "  (cons "
                (itoa CODE)
                " "
                (if (numberp (cdr NODE))
                 (rtos (cdr NODE) 2 8)
                 (strcat "\"" (cdr NODE) "\"")
                )
                ")\n"
        )
        OUTFILE
       )
      )
      (progn
       (princ "  (list" OUTFILE)
       (foreach VAL NODE (princ " " OUTFILE)
                         (if (numberp VAL)
                             (princ (rtos VAL 2 8) OUTFILE)
                             (princ (strcat "\"" VAL "\"") OUTFILE)
                         )
       )
       (princ ")\n" OUTFILE)
      )
     )
    )
   )
   (princ " )\n" OUTFILE)
   (princ ")\n" OUTFILE)
   (while (/= ENT nil)
    (setq ENTLIST (entget ENT))
    (if (= "INSERT" (cdr (assoc 0 ENTLIST)))
     (if (= nil (cdr (assoc 2 ENTLIST)))
      (setq BLOCKNESTLIST (append BLOCKNESTLIST (list (cdr (assoc 2 ENTLIST)))))
     )
    )
    (setq ENT (entnext ENT))
    (princ "(entmake\n" OUTFILE)
    (princ " (list\n" OUTFILE)
    (while (/= ENTLIST nil)
     (setq NODE (car ENTLIST))
     (setq ENTLIST (cdr ENTLIST))
     (setq CODE (car NODE))
     (if (and (>= CODE 0) (<= CODE 100) (/= CODE 5))
      (if (= (vl-list-length NODE) nil)
       (progn
        (princ
         (strcat "  (cons "
                 (itoa CODE)
                 " "
                 (if (numberp (cdr NODE))
                  (rtos (cdr NODE) 2 8)
                  (strcat "\"" (cdr NODE) "\"")
                 )
                 ")\n"
         )
         OUTFILE
        )
       )
       (progn
        (princ "  (list" OUTFILE)
        (foreach VAL NODE (princ " " OUTFILE)
                          (if (numberp VAL)
                              (princ (rtos VAL 2 8) OUTFILE)
                              (princ (strcat "\"" VAL "\"") OUTFILE)
                          )
        )
        (princ ")\n" OUTFILE)
       )
      )
     )
    )
    (princ " )\n" OUTFILE)
    (princ ")\n" OUTFILE)
   )
   (princ "(entmake (list (cons 0 \"ENDBLK\")))\n" OUTFILE)
  )
 )
 (close OUTFILE)
 (setvar "CMDECHO" CMDECHO)
 (setvar "DIMZIN" DIMZIN)
 BLOCKNESTLIST
)