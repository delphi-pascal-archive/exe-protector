program Crypter;

uses
  Forms,
  formA in 'formA.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Exe Protector';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
