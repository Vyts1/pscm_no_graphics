// �������� ����� ��
procedure TForm1.ClsForm;
begin
  form2.ShowModal;
end;

// ���������� ������ ��
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Form1.FormPaint(Form1);
  ClsForm;
end;
