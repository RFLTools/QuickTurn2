;
;
;     Program written by Robert Livingston, 03-03-11
;
;     QT:MAKEDCL is a utility for writing temporary DCL files
;                2015-11-17 : Revised to be standalone for QTMAKE
;
;     DCL's included:
;                              QTMAKE.dcl
;
(defun QT:MAKEDCL (OUTFILENAME DCLNAME / OUTFILE)
 (cond ((= (strcase DCLNAME) "QTMAKE")
        (progn
         (setq OUTFILE (open OUTFILENAME "w"))
         (princ "QTMAKE : dialog {\n" OUTFILE)
         (princ "                  label = \"QuickTurn Vehicle Block Creator\";\n" OUTFILE)
         (princ "                  : row {\n" OUTFILE)
         (princ "                          : column {\n" OUTFILE)
         (princ "                                     width = 40;\n" OUTFILE)
         (princ "                                     : list_box {\n" OUTFILE)
         (princ "                                                  key = \"BLOCKNAME\";\n" OUTFILE)
         (princ "                                                }\n" OUTFILE)
         (princ "                                   }\n" OUTFILE)
         (princ "                          : column {\n" OUTFILE)
         (princ "                                     : image {\n" OUTFILE)
         (princ "                                               key = \"IMAGE\";\n" OUTFILE)
         (princ "                                               width = 40;\n" OUTFILE)
         (princ "                                               height = 18;\n" OUTFILE)
         (princ "                                               color = 0;\n" OUTFILE)
         (princ "                                             }\n" OUTFILE)
         (princ "                                   }\n" OUTFILE)
         (princ "                        }\n" OUTFILE)
         (princ "                  : row {\n" OUTFILE)
         (princ "                          : ok_button {\n" OUTFILE)
         (princ "                                        label = \"OK\";\n" OUTFILE)
         (princ "                                        key = \"OK\";\n" OUTFILE)
         (princ "                                        is_default = true;\n" OUTFILE)
         (princ "                                      }\n" OUTFILE)
         (princ "                          : cancel_button {\n" OUTFILE)
         (princ "                                            label = \"Cancel\";\n" OUTFILE)
         (princ "                                            key = \"CANCEL\";\n" OUTFILE)
         (princ "                                          }\n" OUTFILE)
         (princ "                        }\n" OUTFILE)
         (princ "                }\n" OUTFILE)
         (close OUTFILE)
        )
       )
       ((= (strcase DCLNAME) "PROTOTYPE")
        (progn
         (setq OUTFILE (open OUTFILENAME "w"))



         (close OUTFILE)
        )
       )
       (T
        (progn
         (alert "!!! DCL DOES NOT EXIST !!!")
        )
       )
 )
)