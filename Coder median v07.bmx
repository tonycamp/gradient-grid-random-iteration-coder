Import BRL.Pixmap
Import BRL.PNGLoader


Global largura,altura,chunk

Global imagemap : TPixmap

Global Stringdata :String
Global Stringiter : String
Global Stringadverage : String
Global Stringyd : String
Global Stringud : String
Global Stringvd : String
Print "BMP OR TGA OR PNG OR JPG 2 Experimental Version To DAT by Tony Camp , Antonio Campanico , toi"
Stringdata=Input("Name of File To Compress :")
Stringiter=Input("Number of iterations (100-90000) : ")
Stringadverage=Input("Number of square grid ( 2 - 16 ) : ")
stringyd=Input("Number of Y Divisor ( 1 - 8 ) : ")
stringud=Input("Number of U Divisor ( 1 - 8 ) : ")
stringvd=Input("Number of V Divisor ( 1 - 8 ) : ")

Global filestringoutdat : String = Stringdata+".dat"
Global filestringinbmp : String =Stringdata
Global filestringoutdatpng : String =Stringdata+".original.dat.png"

Global file001:TStream = WriteFile(filestringoutdat)

Global num3 : Int
Global stringElapsedTime : String
Global timespend : Int
Global elapsedtime : Double
Global begintime : Double
Global ytimestep : Double
Global totaltime : Double
Global donetime : Double
Global todotime : Double

' WE CAN USE TIFF PNG BMP TGA JPG BUT NOT AVIF _ AVIF ITS STILL BETTER _ PROB NOT EVEN WEBP
' JUST A CURIOSITY
' DECODIFIER AND ALPHA NOT DONE
' 24 BITS RGB YUV MODE

Begintime=MilliSecs()

Graphics 1800,900

imagemap=LoadPixmap(filestringinbmp)

largura=PixmapWidth(imagemap)
altura=PixmapHeight(imagemap)

Global iterations,adverage,gridx,gridy,divisory,divisoru,divisorv,range,accuracy,tolerance,noise

iterations = Int (Stringiter)
adverage = Int (Stringadverage)
range=80
gridx = adverage
gridy = adverage
divisory=Int(Stringyd)
divisoru=Int(Stringud)
divisorv=Int(Stringvd)

Global valuered : Byte [largura,altura]
Global valuegreen : Byte [largura,altura]
Global valueblue : Byte [largura,altura]
Global valuered2 : Byte [largura,altura]
Global valuegreen2 : Byte [largura,altura]
Global valueblue2 : Byte [largura,altura]
Global valuey : Byte [largura,altura]
Global valueu : Byte [largura,altura]
Global valuev : Byte [largura,altura]
Global valuey2 : Byte [largura,altura]
Global valueu2 : Byte [largura,altura]
Global valuev2 : Byte [largura,altura]
Global valuey2ant : Int
Global valueu2ant : Int
Global valuev2ant : Int
Global valuebity : Int
Global valuebitu : Int
Global valuebitv : Int
Global valuefinal : Int
Global mediany : Double
Global medianu : Double
Global medianv : Double
Global valuey3 : Int [largura,altura]
Global valueu3 : Int [largura,altura]
Global valuev3 : Int [largura,altura]
Global valuesya : Int [largura,altura]
Global valuesua : Int [largura,altura]
Global valuesva : Int [largura,altura]
Global valuesyaf : Int [largura,altura]
Global valuesuaf : Int [largura,altura]
Global valuesvaf : Int [largura,altura]
Global tabelarandomy : Int [ iterations + 1 , 81 , gridx + 1 , gridy + 1 ]
Global tabelarandomu : Int [ iterations + 1 , 81 , gridx + 1 , gridy + 1 ]
Global tabelarandomv : Int [ iterations + 1 , 81 , gridx + 1 , gridy + 1 ]
Global valuesy : Int [largura,altura]
Global valuesu : Int [largura,altura]
Global valuesv : Int [largura,altura]
Global valueyf: Int [largura,altura]
Global valueuf: Int [largura,altura]
Global valuevf: Int [largura,altura]
Global valueyf2 : Int [largura,altura]
Global valueuf2 : Int [largura,altura]
Global valuevf2 : Int [largura,altura]
Global valueyf3 : Int [largura,altura]
Global valueuf3 : Int [largura,altura]
Global valuevf3 : Int [largura,altura]
Global valueyf4 : Int [largura,altura]
Global valueuf4 : Int [largura,altura]
Global valuevf4 : Int [largura,altura]
Global tabelafinaly : Int [largura,altura]
Global tabelafinalu : Int [largura,altura]
Global tabelafinalv : Int [largura,altura]
Global valor1 : Int
Global valor2 : Int
Global valor3 : Int
Global valor4 : Int
Global valor : Int 
Global g : Int
Global x : Int
Global x1 : Int
Global y : Int
Global y1 : Int
Global f : Int
Global r : Int
Global rangetry : Int
Global finalrange : Int
Global randomiter : Int
Global maxnum : Int
Global maxnumfinal : Double
Global num : Int
Global finaliter : Int
Global actualtime : Double
Global buffertime : Double
Global timeleft : Double
Global diff : Int
Global trys : Int
Global bita1 : Int
Global insert : Int
Global insertfinal : Double
Global insertiter : Int
Global maxinsertfinal : Double
Global maxinsertiter : Double
Global mediafinal : Double
Global multiply : Double
Global size : Double

Function Clamp255:Int(value:Float)
    If value < 0 Then Return 0
    If value > 255 Then Return 255
    Return Int(value)
End Function



For y = 0 To altura - 1
    For x = 0 To largura - 1
        Local pixel:Int = ReadPixel(imagemap, x, y)

        valuered[x, y]   = (pixel Shr 16) & $FF
        valuegreen[x, y] = (pixel Shr 8)  & $FF
        valueblue[x, y]  = pixel & $FF

        ' --- RGB → YUV ---
        valuey[x, y] = 0.257 * valuered[x, y] + 0.504 * valuegreen[x, y] + 0.098 * valueblue[x, y] + 16
        valueu[x, y] = -0.148 * valuered[x, y] - 0.291 * valuegreen[x, y] + 0.439 * valueblue[x, y] + 128
        valuev[x, y] = 0.439 * valuered[x, y] - 0.368 * valuegreen[x, y] - 0.071 * valueblue[x, y] + 128
    Next
Next

WriteString(file001,String(largura)+Chr(13)+Chr(10))
WriteString(file001,String(altura)+Chr(13)+Chr(10))

Function createrandoms()
SeedRnd(0)
For f=0 To iterations
For r=0 To range
If f=0 Then
For y=0 To gridy
For x=0 To gridx
tabelarandomy[f,r,x,y]=0
tabelarandomu[f,r,x,y]=0
tabelarandomv[f,r,x,y]=0
Next
Next
Else
For y=0 To gridy
For x=0 To gridx
tabelarandomy[f,r,x,y]=Rand(range)
tabelarandomy[f,r,x,y]=tabelarandomy[f,r,x,y]-(range/2)
tabelarandomu[f,r,x,y]=Rand(range)
tabelarandomu[f,r,x,y]=tabelarandomu[f,r,x,y]-(range/2)
tabelarandomv[f,r,x,y]=Rand(range)
tabelarandomv[f,r,x,y]=tabelarandomv[f,r,x,y]-(range/2)
Next
Next
End If
Next
Next
End Function

createrandoms()

maxnumfinal=0
trys=0
For y=0 To ((altura-1)-gridy)
For x=0 To ((largura-1)-gridx)

mediany=0
medianu=0
medianv=0

For y1=0 To gridy-1
For x1=0 To gridx-1
valuey2[x+x1,y+y1]=valuey[x+x1,y+y1]
mediany=mediany+valuey2[x+x1,y+y1]
valueu2[x+x1,y+y1]=valueu[x+x1,y+y1]
medianu=medianu+valueu2[x+x1,y+y1]
valuev2[x+x1,y+y1]=valuev[x+x1,y+y1]
medianv=medianv+valuev2[x+x1,y+y1]
Next
Next

mediany=mediany/(gridx*gridy)
medianu=medianu/(gridx*gridy)
medianv=medianv/(gridx*gridy)
WriteByte(file001,Abs(Int(mediany)-valuey2ant))
WriteByte(file001,Abs(Int(medianu)-valueu2ant))
WriteByte(file001,Abs(Int(medianv)-valuev2ant))
If Int(mediany) < valuey2ant Then
valuebity=1
Else
valuebity=0
End If
If Int(medianu) < valueu2ant Then
valuebitu=1
Else
valuebitu=0
End If
If Int(medianv) < valuev2ant Then
valuebitv=1
Else
valuebitv=0
End If
valuefinal=valuebity*4+valuebitu*2+valuebitv
WriteByte(file001,valuefinal)
valuey2ant=Int(mediany)
valueu2ant=Int(medianu)
valuev2ant=Int(medianv)

For y1=0 To gridy-1
For x1=0 To gridx-1
valuesy[x1,y1]=Int(mediany)
valuesu[x1,y1]=Int(medianu)
valuesv[x1,y1]=Int(medianv)
Next
Next

finalrange=0
randomiter=-1
maxnum=768*gridx*gridy
Repeat
randomiter=randomiter+1
rangetry=0
Repeat
insertiter=0
For y1=0 To gridy-1
For x1=0 To gridx-1
valueyf[x+x1,y+y1]=valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1])
valueuf[x+x1,y+y1]=valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1])
valuevf[x+x1,y+y1]=valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1])
valueyf2[x+x1,y+y1]=(valueyf[x+x1,y+y1]-valuey2[x+x1,y+y1])
valueuf2[x+x1,y+y1]=(valueuf[x+x1,y+y1]-valueu2[x+x1,y+y1])
valuevf2[x+x1,y+y1]=(valuevf[x+x1,y+y1]-valuev2[x+x1,y+y1])
insertiter=insertiter+Abs(valueyf2[x+x1,y+y1])+Abs(valueuf2[x+x1,y+y1])+Abs(valuevf2[x+x1,y+y1])
Next
Next

If insertiter<maxnum Then
maxnum=insertiter
insertfinal=0
finaliter=randomiter
finalrange=rangetry
For y1=0 To gridy-1
For x1=0 To gridx-1

valueyf4[x+x1,y+y1]=(((valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1])))-valuey2[x+x1,y+y1])/divisory
valueuf4[x+x1,y+y1]=(((valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1])))-valueu2[x+x1,y+y1])/divisoru
valuevf4[x+x1,y+y1]=(((valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1])))-valuev2[x+x1,y+y1])/divisorv

If ((valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1]))-valuey2[x+x1,y+y1]) > 0 Then 
valueyf3[x+x1,y+y1]=(((valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1])))-valuey2[x+x1,y+y1])/divisory
insertfinal=insertfinal+(Abs(valueyf3[x+x1,y+y1]))
Else
valueyf3[x+x1,y+y1]=(((valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1]))-valuey2[x+x1,y+y1])/divisory)+128
insertfinal=insertfinal+(Abs((((valuesy[x1,y1]+(tabelarandomy[randomiter,rangetry,x1,y1]))-valuey2[x+x1,y+y1])/divisory)))
End If
If ((valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1]))-valueu2[x+x1,y+y1]) > 0 Then 
valueuf3[x+x1,y+y1]=((valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1]))-valueu2[x+x1,y+y1])/divisoru
insertfinal=insertfinal+(Abs(valueuf3[x+x1,y+y1]))
Else
valueuf3[x+x1,y+y1]=(((valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1]))-valueu2[x+x1,y+y1])/divisoru)+128
insertfinal=insertfinal+(Abs((((valuesu[x1,y1]+(tabelarandomu[randomiter,rangetry,x1,y1]))-valueu2[x+x1,y+y1])/divisoru)))
End If
If ((valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1]))-valuev2[x+x1,y+y1]) > 0 Then 
valuevf3[x+x1,y+y1]=((valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1]))-valuev2[x+x1,y+y1])/divisorv
insertfinal=insertfinal+(Abs(valuevf3[x+x1,y+y1]))
Else
valuevf3[x+x1,y+y1]=(((valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1]))-valuev2[x+x1,y+y1])/divisorv)+128
insertfinal=insertfinal+(Abs((((valuesv[x1,y1]+(tabelarandomv[randomiter,rangetry,x1,y1]))-valuev2[x+x1,y+y1])/divisorv)))
End If
valuey3[x+x1,y+y1]=valuesy[x1,y1]-(valueyf4[x+x1,y+y1]*divisory)
valueu3[x+x1,y+y1]=valuesu[x1,y1]-(valueuf4[x+x1,y+y1]*divisoru)
valuev3[x+x1,y+y1]=valuesv[x1,y1]-(valuevf4[x+x1,y+y1]*divisorv)
Next
Next
End If
rangetry=rangetry+1
Until (rangetry=range)
Until (iterations=randomiter) 
maxinsertfinal=maxinsertfinal+insertfinal
maxnumfinal=maxnumfinal+maxnum
trys=trys+1
	valor1=finaliter/16777216
	valor2=(finaliter-(valor1*16777216))/65536
	valor3=(finaliter-(valor1*16777216+valor2*65536))/256
	valor4=(finaliter-(valor1*16777216+valor2*65536+valor3*256))
	WriteByte(file001,finalrange)
	WriteByte(file001,valor2)
	WriteByte(file001,valor3)
	WriteByte(file001,valor4)
	For y1=0 To gridy-1
	For x1=0 To gridx-1
	valor1=valueyf3[x+x1,y+y1]
	valor1=valueuf3[x+x1,y+y1]
	valor1=valuevf3[x+x1,y+y1]
	If y1 > 0  Or x1 > 0 Then 
	WriteByte(file001,valor1)
	WriteByte(file001,valor2)
	WriteByte(file001,valor3)
	End If
	Next
	Next
	x=x+(gridx-1)
Next
actualtime=MilliSecs()
donetime=actualtime-begintime
ytimestep=donetime/y
totaltime=ytimestep*altura
todotime=totaltime-donetime
secondsToStringDaysAndHours(Int(todotime)/1000)

size=Float(altura*largura*3)*(Float(Float((maxinsertfinal/((gridx*gridy*3)*trys))))/100)+(((altura*largura)/(gridx*gridy))*3)

WriteStdout ("x="+x+" y="+y+" Grid xy="+gridx+" value Adv.="+Float(Float((maxinsertfinal/((gridx*gridy*3)*trys))))+" time Left:"+stringElapsedTime+" SIZE= "+Int(size)+"             "+Chr(13))

For f=0 To ((largura-1)-gridx)
	For y1=0 To gridy-1
	For x1=0 To gridx-1
	Local ry:Float = valuey3[f+x1,y+y1] - 16
    Local ru:Float = valueu3[f+x1,y+y1] - 128
    Local rv:Float = valuev3[f+x1,y+y1] - 128
    valuered2[f+x1,y+y1]   = Clamp255(1.164 * ry + 1.596 * rv)
    valuegreen2[f+x1,y+y1] = Clamp255(1.164 * ry - 0.392 * ru - 0.813 * rv)
    valueblue2[f+x1,y+y1]  = Clamp255(1.164 * ry + 2.017 * ru)
	SetColor (valuered2[f+x1,y+y1],valuegreen2[f+x1,y+y1],valueblue2[f+x1,y+y1])
	Plot f+x1,y+y1
	Next
	Next
f=f+(gridx-1)
Next
	Flip
	For f=0 To ((largura-1)-gridx)
	For y1=0 To gridy-1
	For x1=0 To gridx-1
	Local ry:Float = valuey3[f+x1,y+y1] - 16
    Local ru:Float = valueu3[f+x1,y+y1] - 128
    Local rv:Float = valuev3[f+x1,y+y1] - 128
    valuered2[f+x1,y+y1]   = Clamp255(1.164 * ry + 1.596 * rv)
    valuegreen2[f+x1,y+y1] = Clamp255(1.164 * ry - 0.392 * ru - 0.813 * rv)
    valueblue2[f+x1,y+y1]  = Clamp255(1.164 * ry + 2.017 * ru)
	SetColor (valuered2[f+x1,y+y1],valuegreen2[f+x1,y+y1],valueblue2[f+x1,y+y1])
	Plot f+x1,y+y1
	Next
	Next
f=f+(gridx-1)
Next
	Flip

	y=y+(gridy-1)
Next

CloseFile(file001)

Function secondsToStringDaysAndHours(seconds:Int)
	Local days:Int = seconds / 86400
	Local hours:Int = (seconds Mod 86400) / 3600
	Local minutes:Int = (seconds Mod 3600) / 60
	Local secs:Int = seconds Mod 60

	If hours < 10 And minutes < 10 And secs < 10 Then stringElapsedTime = days + " days : " + "0"+hours + ":" + "0"+minutes + ":" + "0"+secs
	If hours < 10 And minutes < 10 And  9 < secs Then stringElapsedTime = days + " days : " + "0"+hours + ":" + "0"+minutes + ":" + secs
	If hours < 10 And 9 < minutes And secs < 10 Then stringElapsedTime = days + " days : " + "0"+hours + ":" + minutes + ":" + "0"+secs
	If hours < 10 And 9 < minutes And  9 < secs Then stringElapsedTime = days + " days : " + "0"+hours + ":" + minutes + ":" + secs
	If 9 < hours And 9 < minutes And secs < 10 Then stringElapsedTime = days + " days : " + hours + ":" + minutes + ":" + "0"+secs
	If 9 < hours And 9 < minutes And  9 < secs Then stringElapsedTime = days + " days : " + hours + ":" + minutes + ":" + secs
	If 9 < hours And minutes < 10 And secs < 10 Then stringElapsedTime = days + " days : " +hours + ":" + "0"+minutes + ":" + "0"+secs
	If 9 < hours And minutes < 10 And  9 < secs Then stringElapsedTime = days + " days : " +hours + ":" + "0"+minutes + ":" + secs
End Function

Rem

Local status:Int

Local batFile:TStream = WriteFile("compressor.bat")

If Int stringmethod=1 Then
    WriteLine(batFile, "@echo off")
    WriteLine(batFile, "set "+"Input="+Chr$(34)+filestringoutdat+".zpaq"+Chr$(34))
	WriteLine(batFile, "set "+"output="+Chr$(34)+filestringoutdat+Chr$(34))
    WriteLine(batFile, "zpaq64 a "+"%Input%"+" "+"%OutPut%"+" -m5 -t4")
	WriteLine(batfile, "del "+Chr$(34)+filestringinbmp+".fusionpoint"+Chr$(34))
    WriteLine(batfile, "rename "+Chr$(34)+filestringoutdat+".zpaq"+Chr$(34)+" "+Chr$(34)+filestringinbmp+".80.m1.fusionpoint"+Chr$(34))
	WriteLine(batfile, "del "+Chr$(34)+filestringoutdat+Chr$(34))
    CloseFile(batFile)
    Print "compressor.bat Sucessfully created."
End If

If Int stringmethod=2 Then
    WriteLine(batFile, "@echo off")
    WriteLine(batFile, "set "+"Input="+Chr$(34)+filestringoutdat+Chr$(34))
	WriteLine(batFile, "set "+"output="+Chr$(34)+filestringoutdat+".paq8o"+Chr$(34))
    WriteLine(batFile, "paq8o -7 "+"%Input%")
	WriteLine(batfile, "del "+Chr$(34)+filestringinbmp+".fusionpoint"+Chr$(34))
    WriteLine(batfile, "rename "+Chr$(34)+filestringoutdat+".paq8o"+Chr$(34)+" "+Chr$(34)+filestringinbmp+".80.m2.fusionpoint"+Chr$(34))
	WriteLine(batfile, "del "+Chr$(34)+filestringoutdat+Chr$(34))
    CloseFile(batFile)
    Print "compressor.bat Sucessfully created."
End If

If Int stringmethod=3 Then
    WriteLine(batFile, "@echo off")
    WriteLine(batFile, "set "+"Input="+Chr$(34)+filestringoutdat+Chr$(34))
	WriteLine(batFile, "set "+"output="+Chr$(34)+filestringoutdat+".ppaq"+Chr$(34))
    WriteLine(batFile, "ppaq c 12ba 2 "+"%Input%"+" %output%")
	WriteLine(batfile, "del "+Chr$(34)+filestringinbmp+".80.fusionpoint"+Chr$(34))
    WriteLine(batfile, "rename "+Chr$(34)+filestringoutdat+".ppaq"+Chr$(34)+" "+Chr$(34)+filestringinbmp+".80.m3.fusionpoint"+Chr$(34))
	WriteLine(batfile, "del "+Chr$(34)+filestringoutdat+Chr$(34))
    CloseFile(batFile)
    Print "compressor.bat Sucessfully created."
End If

If Not batfile Then
    Print "compressor.bat gave error while creating it."
End If
Local Process1:TProcess = CreateProcess("compressor.bat")

secondsToStringDaysAndHours((altura*largura)/240)
Print "Compression started! WAIT = "+stringelapsedtime
Delay(1000)


Repeat
status = ProcessStatus(Process1)
Delay(100)
If status<>1 Then TerminateProcess(Process1)
Delay(100)
Until status<>1

End Rem

Elapsedtime=MilliSecs()
timespend=Elapsedtime-begintime
secondsToStringDaysAndHours((timespend)/1000)
Print "COMPRESSION ENDED : Elapsed Time  = "+stringelapsedtime

For y = 0 To altura - 1
    For x = 0 To largura - 1

' --- reconstrução YUV → RGB ---
        Local ry:Float = valuey3[x, y] - 16
        Local ru:Float = valueu3[x, y] - 128
        Local rv:Float = valuev3[x, y] - 128

        valuered2[x, y]   = Clamp255(1.164 * ry + 1.596 * rv)
        valuegreen2[x, y] = Clamp255(1.164 * ry - 0.392 * ru - 0.813 * rv)
        valueblue2[x, y]  = Clamp255(1.164 * ry + 2.017 * ru)
	Next
Next

' 1. Create a blank pixmap (e.g., 256x256, 32-bit RGBA)
Local pix:TPixmap = CreatePixmap(largura, altura, PF_RGB888)

' 2. Loop to set pixel values manually (example: red gradient)
Local color:Int
For y = 0 To altura-1
    For x = 0 To largura-1
        
         color = (valuered2[x,y] Shl 16) + (valuegreen2[x,y] Shl 8) + (valueblue2[x,y])

        ' Set pixel value at (x, y)
        WritePixel(pix, x, y, color)
    Next
Next

' 3. Save to PNG
SavePixmapPNG(pix, filestringoutdatpng)

Print "Image saved as original.png"


