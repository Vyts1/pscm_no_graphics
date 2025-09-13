program pscm;

uses
  Forms,
  main in 'main.pas' {Form1},
  db_form in 'db_form.pas' {Form2},
  datamoduleDB in 'datamoduleDB.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
