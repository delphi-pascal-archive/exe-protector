unit formA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, EditRexe{, pngimage}, ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    Btn1: TButton;
    Btn2: TButton;
    Open: TOpenDialog;
    XPManifest1: TXPManifest;
    Save: TSaveDialog;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ReadFile(FileName: String): AnsiString;
var
  F             :File;
  Buffer        :AnsiString;
  Size,ReadBytes:Integer;
  DefaultFileMode:Byte;
begin
  Result := '';
  DefaultFileMode := FileMode;
  FileMode := 0;
  AssignFile(F, FileName);
  Reset(F, 1);

  if (IOResult = 0) then
  begin
    Size := FileSize(F);
    while (Size > 1024) do
    begin
      SetLength(Buffer, 1024);
      BlockRead(F, Buffer[1], 1024, ReadBytes);
      Result := Result + Buffer;
      Dec(Size, ReadBytes);
    end;
    SetLength(Buffer, Size);
    BlockRead(F, Buffer[1], Size);
    Result := Result + Buffer;
    CloseFile(F);
  end;

  FileMode := DefaultFileMode;
end;

function Xorit(Buffer :String; Key :Integer) :String;
var
  i,c,x  :Integer;
begin
  for i := 1 to Length(Buffer) do
  begin
    c := Integer(Buffer[i]);
    x := c xor Key;
    Result := Result + Char(x);
  end;
end;

procedure TForm1.Btn1Click(Sender: TObject);
begin
  if Open.Execute then
    Edit2.Text := Open.FileName;
end;

procedure TForm1.Btn2Click(Sender: TObject);
var
  Buffer,Pword :String;
begin
  if not Save.Execute then
    Exit;
  Pword  := Xorit(Edit1.Text, 125684);
  Buffer := Xorit(ReadFile(Edit2.Text), 1337);

  CopyFile(PChar(ExtractFilePath(ParamStr(0))+'Stub/Stub.exe'), PChar(Save.FileName), False);
  InsOrReplaceInFile('PW',Save.FileName, Pword);
  InsOrReplaceInFile('FE',Save.FileName, Buffer);
  MessageBoxA(0, 'Votre programme est maintenant crypté et protégé', 'Exe Protector', 64);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
i:integer;
const
str='1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
max=15;
begin
Edit1.Text:='';
for i:=0 to max do
begin
   Edit1.Text:=Edit1.Text+str[random(length(str))+1];
end;
end;

end.
