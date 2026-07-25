#NoEnv
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%

global LoopActive := false
global SpeedMode := 1  ; 1 - супербыстрый, 2 - средний, 3 - медленный

F1::
    LoopActive := !LoopActive
    if (LoopActive) {
        SoundBeep, 1000, 200
        TrayTip, Статус, ВКЛЮЧЕНО (Режим: %SpeedMode%), 1
        Gosub, StartLoop
    } else {
        SoundBeep, 500, 200
        TrayTip, Статус, ВЫКЛЮЧЕНО, 1
    }
return

StartLoop:
    while (LoopActive) {
        Loop, 26
        {
            if !LoopActive
                break
            char := Chr(64 + A_Index)
            
            ; Выбор метода отправки в зависимости от режима
            if (SpeedMode = 1) {
                ; Самый быстрый способ - SendInput без задержек
                SendInput, %char%
            } else if (SpeedMode = 2) {
                SendInput, %char%
                Sleep, 1
            } else {
                SendInput, %char%
                Sleep, 5
            }
        }
    }
return

; Смена режимов скорости
F2::
    SpeedMode++
    if (SpeedMode > 3)
        SpeedMode := 1
    TrayTip, Скорость, Режим %SpeedMode%: 
    (Режим 1 - Макс, Режим 2 - Средний, Режим 3 - Медленный), 2
return

Esc::
    if (LoopActive) {
        LoopActive := false
        SoundBeep, 500, 200
        TrayTip, Статус, Остановлено, 1
    }
return

TrayTip, Циклическое нажатие букв, 
(
F1 - Вкл/Выкл
F2 - Смена режима скорости
Esc - Стоп
), 3
return
