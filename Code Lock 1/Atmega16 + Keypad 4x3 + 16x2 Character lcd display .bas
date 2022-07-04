'======================================================================='

' Title: Code Lock
' Last Updated :  02.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega16 + Keypad 4x3 + 16x2 Character lcd display

'======================================================================='

$regfile = "m16def.dat"
$crystal = 1000000

Config Lcdpin = Pin , Db4 = Porta.4 , Db5 = Porta.5 , Db6 = Porta.6 , _
Db7 = Porta.7 , E = Porta.3 , Rs = Porta.2
Config Lcd = 16 * 2

Config Kbd = Portb , Debounce = 50 , Delay = 200
Config Portd = Output

Declare Sub Pass_06
Dim K1 As Byte
Dim K2 As Long
Dim M As Eram Long
Dim N As Byte
Dim W As String * 8

'-----------------------------------------------------------

Do

If M = &HFFFFFFFF Then
M = 0000
Else
Goto Pass_01
End If

''''''''''''''''''''''''''''''

Pass_01:

Cls
Home
Lcd "Enter Password"
N = 0
W = ""
Reset Portd.0
Reset Portd.1
Locate 2 , 1

Call Pass_06

If M = K2 Then
Set Portd.0
Set Portd.1

Goto Pass_02

Else

Reset Portd.0
Reset Portd.1
Cls
Home
Lcd "Error"
Wait 2
Cls
Home
Goto Pass_01
End If

''''''''''''''''''''''''''''''

Pass_02:

Cls
Cursor Off
Home
Lcd "1= Exit "
Locate 2 , 1
Lcd "2= Change Pass"

''''''''''''''''''''''''''''''

Pass_03:

K1 = Getkbd()

If K1 > 15 Then Goto Pass_03

K1 = Lookup(k1 , Code)

If K1 = 50 Then Goto Pass_04
If K1 = 49 Then Goto Pass_01
Goto Pass_03

''''''''''''''''''''''''''''''

Pass_04:

Cls
Cursor Off
Home
Lcd "Enter Pass Again"
Locate 2 , 1

Call Pass_06

If M = K2 Then
Goto Pass_05

Else

Cls
Home
Lcd "Error"
Wait 2
Goto Pass_02
End If

''''''''''''''''''''''''''''''

Pass_05:

Cls
Cursor Off
Home
Lcd "Enter New Pass"
Locate 2 , 1
Call Pass_06
M = K2

Loop


End

''''''''''''''''''''''''''''''

Pass_06:

N = 0
W = ""

''''''''''''''''''''''''''''''

Pass_07:

K1 = Getkbd()
If K1 > 15 Then Goto Pass_07

K1 = Lookup(k1 , Code)

Select Case K1

Case 48 To 57:

If N < 8 Then
Incr N
Lcd String(1 , K1)
W = W + String(1 , K1)

End If

Goto Pass_07

Case 11 :

K2 = Val(w)
End Select

Return

''''''''''''''''''''''''''''''

Code:

Data 0 , 49 , 50 , 51 , 0 , 52 , 53 , 54 , 0 , 55 , 56 , 57 , 0 , 0 , 48 , 11

'-----------------------------------------------------------







