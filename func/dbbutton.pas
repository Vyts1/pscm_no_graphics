// Показать форму БД
procedure TForm1.ClsForm;
begin
  form2.ShowModal;
end;

// Обработчик кнопки БД
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Form1.FormPaint(Form1);
  ClsForm;
end;
