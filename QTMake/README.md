# QuickTurn - QTMake
AutoLisp QuickTurn vehicle block creator

Purpose:  To create and insert a QuickTurn vehicle block.

Within AutoCAD QTMake.lsp, QTMakeOut.lsp, QTMakeDCL.lsp and QTMakeSLB.lsp must be loaded.  Entering QTMAKE at the command prompt will execute the command.

QTWBLOCKLIST.lsp is used to create QTMakeOut.lsp.  It is not required for C:QTMake.  When QTWBLOCKLIST is run it will prompt for the vehicle blocks within the current drawing session and will create QTMakeOut.lsp with these vehicles.

QTMakeDCL.lsp is used to create a temporary DCL file used by QTMake.lsp

QTMakeSLB.lsp is used to create a temporary slide library file used by QTMake.lsp
