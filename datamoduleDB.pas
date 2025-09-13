unit datamoduleDB;

interface

uses
  SysUtils, Classes, DB, ADODB;

type                                //DataModule1.DataSource1
                                    //DataModule1.ADOTable1
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOTable1nId: TAutoIncField;
    ADOTable1Material: TWideStringField;
    ADOTable1ROms: TFloatField;
    ADOTable1ROml: TFloatField;
    ADOTable1CPms: TFloatField;
    ADOTable1CPml: TFloatField;
    ADOTable1Lms: TFloatField;
    ADOTable1Lml: TFloatField;
    ADOTable1Tm: TFloatField;
    ADOTable1TBoil: TFloatField;
    ADOTable1Lm: TFloatField;
    ADOTable1MUml: TFloatField;
    ADOTable1SIGml: TFloatField;
    ADOTable1LBoil: TFloatField;
    ADOTable1AW: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
