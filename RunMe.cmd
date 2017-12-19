@echo off
rem
rem Simple copy batch to create combined lsp file
rem
if exist LoadQuickTurn2.lsp del LoadQuickTurn2.lsp
rem
COPY /B ".\CQT2.lsp" + ^
        ".\QTCopy.lsp" + ^
        ".\QTDrawAtEnd.lsp" + ^
        ".\QTDrawAtPos.lsp" + ^
        ".\QTDrawAtStart.lsp" + ^
        ".\QTDrawDPath.lsp" + ^
        ".\QTDrawPath.lsp" + ^
        ".\QTDrawEnvelope.lsp" + ^
        ".\QTGetAList.lsp" + ^
        ".\QTGetD.lsp" + ^
        ".\QTGetEnvelope.lsp" + ^
        ".\QTGetHList.lsp" + ^
        ".\QTGetPList.lsp" + ^
        ".\QTGetVList.lsp" + ^
        ".\QTMakePath.lsp" + ^
        ".\QTMakeTempBlock.lsp" + ^
        ".\QTNewWheelAng.lsp" + ^
        ".\QTMAke\QTMake.lsp" + ^
        ".\QTMAke\QTMakeDCL.lsp" + ^
        ".\QTMAke\QTMakeOUT.lsp" + ^
        ".\QTMAke\QTMakeSLB.lsp" ^
        ".\LoadQuickTurn2.lsp"
pause
