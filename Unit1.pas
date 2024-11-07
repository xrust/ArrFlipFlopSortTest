unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, uCommon, uNixTime, uLogger;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Log: TMemo;
    Edit1: TEdit;
    btngen: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    procedure btngenClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var Form1: TForm1;
    garr : array of Integer;
    //procedure MoveMemory(Destination,Source:Pointer;Count:Integer);stdcall;external 'kernel32.dll';
//-----------------------------------------------------------------------------+
implementation {$R *.dfm}
//-----------------------------------------------------------------------------+
procedure TForm1.btngenClick(Sender: TObject);var i,sz:Integer;
begin
    sz:=StrToIntDef(Edit1.Text,10000);
    SetLength(garr,sz);
    Randomize;
    for i:=0 to Length(garr)-1 do begin garr[i]:=RandomRange(1,10000000);{PrintLn([garr[i]]);}end;
end;
//-----------------------------------------------------------------------------+
procedure Sort(arr:array of Integer);var i,j,v:Integer; c:Int64; time:Double;
begin
    GetLog('BubleSort Start');
    time:=UnixTimeCurrentMsDbl;
    c:=0;
    for i:=0 to Length(arr)-2 do begin
        Application.ProcessMessages;
        for j:=i+1 to Length(arr)-2 do begin
            if( arr[i] > arr[j] )then begin
                v:=arr[j];
                arr[j]:=arr[i];
                arr[i]:=v;
                //---
                inc(c);
            end;
        end;
    end;
    PrintLn(['Time : ',UnixTimeCurrentMsDbl-time]);
end;
//-----------------------------------------------------------------------------+
procedure SortFast(var data:array of Integer);
var
i,j,v:Integer;
imax,imin,imid:Integer;
time:Double;
ready:Boolean;
arr,buff:array of Integer;
text:string;
begin
    GetLog('Fast Sort Start');
    time:=UnixTimeCurrentMsDbl;
    SetLength(arr,Length(data)*2);
    for i:=0 to Length(arr)-1 do arr[i]:=0;
    //---
    imin :=Length(data);
    imax :=Length(data);
    arr[imin]:=data[0];
    //---
    for i:=1 to Length(data)-1 do begin                                                             
        Application.ProcessMessages;
        if( data[i] < arr[imin] )then begin
            Dec(imin);
            arr[imin]:=data[i];
        end else begin
            if( data[i] >= arr[imax] )then begin
                inc(imax);
                arr[imax]:=data[i];
            end else begin
                imid:=Trunc((imin+imax)/2)+1;
                if( data[i] < arr[imid] )then begin
                    for j:=imin to imid do begin
                        if( data[i] >= arr[j] )then begin
                            arr[j-1]:=arr[j];
                        end else begin
                            Dec(imin);
                            //---
                            arr[j-1]:=data[i];
                            Break;
                        end;
                    end;
                end else begin
                    for j:=imax downto imid do begin
                        if( data[i] < arr[j] )then begin
                            arr[j+1]:=arr[j];
                        end else begin
                            inc(imax);
                            //---
                            arr[j+1]:=data[i];
                            Break;
                        end;
                    end;
                end;
            end;
        end;
    end;
    PrintLn(['Time : ',UnixTimeCurrentMsDbl-time]);
end;
//-----------------------------------------------------------------------------+
procedure TForm1.btn1Click(Sender: TObject);
begin
    Sort(garr);
end;
//-----------------------------------------------------------------------------+
procedure TForm1.btn2Click(Sender: TObject);
begin
    SortFast(garr);
end;
//-----------------------------------------------------------------------------+
procedure FlipFlopSort(data:array of Integer);
var
i,j:Integer;
imax,imin,imid:Integer;
fmin,fmax:Integer;
arr:array of Integer;
time:Double;
begin
    GetLog('FlipFlopSort Start');
    time:=UnixTimeCurrentMsDbl;
    SetLength(arr,Length(data)*2);
    for i:=0 to Length(arr)-1 do arr[i]:=0;
    //---
    imin :=Length(data);
    imax :=Length(data);
    arr[imin]:=data[0];
    //---
    for i:=1 to Length(data)-1 do begin
        Application.ProcessMessages;
        if( data[i] < arr[imin] )then begin
            Dec(imin);
            arr[imin]:=data[i];
        end else begin
            if( data[i] >= arr[imax] )then begin
                inc(imax);
                arr[imax]:=data[i];
            end else begin
                fmin:=imin;
                fmax:=imax;
                while( fmax-fmin > 32 )do begin
                    imid:=Trunc(fmin+(fmax-fmin)/2);
                    if( data[i] < arr[imid] )then fmax:=imid else fmin:=imid;
                end;
                for j:=fmax downto fmin do begin
                    if( data[i] < arr[j] )then Continue;
                    imid:=j;
                    Break;
                end;
                if( imid < Trunc((imin+imax)/2) )then begin
                    Move(arr[imin],arr[imin-1],(1+imid-imin)*sizeof(Integer));
                    arr[imid]:=data[i];
                    Dec(imin);
                end else begin
                    Move(arr[imid+1],arr[imid+2],(1+imax-imid)*sizeof(Integer));
                    arr[imid+1]:=data[i];
                    inc(imax);
                end;
            end;
        end;
    end;
    //---
    PrintLn(['Time : ',UnixTimeCurrentMsDbl-time]);
end;
//-----------------------------------------------------------------------------+
procedure TForm1.btn3Click(Sender: TObject);
begin
    FlipFlopSort(garr);
end;
//-----------------------------------------------------------------------------+
end.
 