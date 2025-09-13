unit db_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    procedure ClsForm;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses main, datamoduleDB,  cxTextEdit, cxImageComboBox, cxImage, cxVGrid;
{$R *.dfm}

procedure TForm2.ClsForm;
begin
// action := caHide;

 form2.Visible:=false;
 form2.Close;
// Form1.FormPaint(Form1);
// Form1.Invalidate;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action := caHide;
 ClsForm;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
    i,i2:integer;
    t:TcxCustomRow;
begin
 ClsForm;
 for i:=1 to count_md_items do
   begin
     if MD11Array[i].tip=0 then
                            begin
                              t:=MD11Array[i].row;

                             {$I 'func\updmat.pas'}

                            end;




   end;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  Form1.FormPaint(Form1);
  DataModule1.ADOTable1.Open;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
 Form1.FormPaint(Form1);

end;

end.
