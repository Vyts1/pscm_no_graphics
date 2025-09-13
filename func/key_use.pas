procedure TForm1.KeyUse( Key: Word);
begin
 CASE Key OF
  81: //q
   if not fix then
   begin
    alfaX:=alfaX+ugol_obzora;
    if alfaX > 360 then alfaX := alfaX - 360;
   end;

  65: //a
   if not fix then
   begin
    alfaX:=alfaX-ugol_obzora;
    if alfaX < 0 then alfaX := alfaX + 360;
   end;

  87: //w
   if not fix then
   begin
    alfaY:=alfaY+ugol_obzora;
    if alfaY > 360 then alfaY := alfaY - 360;
   end;
  83: //s
   if not fix then
   begin
    alfaY:=alfaY-ugol_obzora;
    if alfaY < 0 then alfaY := alfaY + 360;
   end;

  69: //e
   if not fix then
   begin
    alfaZ:=alfaZ+ugol_obzora;
    if alfaZ > 360 then alfaZ := alfaZ - 360;
   end;
  68: //d
   if not fix then
   begin
    alfaZ:=alfaZ-ugol_obzora;
    if alfaZ < 0 then alfaZ := alfaZ + 360;
   end;

  82: //r
   if not fix then
    centX:=centX+shag_sm;

  70: //f
   if not fix then
    centX:=centX-shag_sm;

  84: //t
   if not fix then
    centY:=centY+shag_sm;

  71: //g
   if not fix then
    centY:=centY-shag_sm;

  89: //y
   if not fix then
    centZ:=centZ+shag_sm;

  72: //h
   if not fix then
    centZ:=centZ-shag_sm;

  85: //u
   if not fix then
    scale := scale + scale_sh;

  74: //j
   if not fix then
    scale := scale - scale_sh;

  90: //z
   begin
     alfaX:=0;  alfaY:=0;  alfaZ:=0;
     centX:=0;  centY:=0;  centZ:=0;
     scale:=1;
   end;

  49:
   begin
    setmode3d(1);
   end;

  50:
   begin
    setmode3d(2);
   end;

  51:
   begin
    setmode3d(3);
   end;

  52:
   begin
    setmode3d(4);
   end;

  53:
   begin
    setmode3d(5);
   end;

  VK_ESCAPE:
   Close;

 END;

 If Key = VK_ESCAPE then Close;
 log ('  aX=' + floattostr(alfaX) + '  aY=' + floattostr(alfaY) + '  aZ=' + floattostr(alfaZ) );
// ShowMessage(inttostr(Key));


 InvalidateRect(Handle, nil, False);

end;


//это обработка клавиатуры
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
 CASE Key OF
  81: //q
   if not fix then
   begin
    alfaX:=alfaX+ugol_obzora;
    if alfaX > 360 then alfaX := alfaX - 360;
   end;

  65: //a
   if not fix then
   begin
    alfaX:=alfaX-ugol_obzora;
    if alfaX < 0 then alfaX := alfaX + 360;
   end;

  87: //w
   if not fix then
   begin
    alfaY:=alfaY+ugol_obzora;
    if alfaY > 360 then alfaY := alfaY - 360;
   end;
  83: //s
   if not fix then
   begin
    alfaY:=alfaY-ugol_obzora;
    if alfaY < 0 then alfaY := alfaY + 360;
   end;

  69: //e
   if not fix then
   begin
    alfaZ:=alfaZ+ugol_obzora;
    if alfaZ > 360 then alfaZ := alfaZ - 360;
   end;
  68: //d
   if not fix then
   begin
    alfaZ:=alfaZ-ugol_obzora;
    if alfaZ < 0 then alfaZ := alfaZ + 360;
   end;

  82: //r
   if not fix then
    centX:=centX+shag_sm;

  70: //f
   if not fix then
    centX:=centX-shag_sm;

  84: //t
   if not fix then
    centY:=centY+shag_sm;

  71: //g
   if not fix then
    centY:=centY-shag_sm;

  89: //y
   if not fix then
    centZ:=centZ+shag_sm;

  72: //h
   if not fix then
    centZ:=centZ-shag_sm;

  85: //u
   if not fix then
    scale := scale + scale_sh;

  74: //j
   if not fix then
    scale := scale - scale_sh;

  90: //z
   begin
     alfaX:=0;  alfaY:=0;  alfaZ:=0;
     centX:=0;  centY:=0;  centZ:=0;
     scale:=1;
   end;

  49:
   begin
    setmode3d(1);
   end;

  50:
   begin
    setmode3d(2);
   end;

  51:
   begin
    setmode3d(3);
   end;

  52:
   begin
    setmode3d(4);
   end;

  53:
   begin
    setmode3d(5);
   end;

  VK_ESCAPE:
   Close;

 END;

 If Key = VK_ESCAPE then Close;

 ShowMessage(inttostr(Key));


 InvalidateRect(Handle, nil, False);
 }
end;


