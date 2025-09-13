procedure TForm1.CenterPanelResize(Sender: TObject);
begin

// glViewport(0, 0, ClientWidth, ClientHeight);
 glViewport(0, 0, CenterPanel.ClientWidth, CenterPanel.ClientHeight);



 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;

 // scale    centX, centY, centZ

 If ClientWidth <= ClientHeight     // (всегда больше 1)
   then
     begin
       ScecSizeX1:=-1.0;
       ScecSizeX2:=+1.0;
       ScecSizeY1:=-1.0 * ClientHeight / ClientWidth;
       ScecSizeY2:=1.0 * ClientHeight / ClientWidth;
       ScecSizeZ1:=-1000;
       ScecSizeZ2:=1000;
     end
   else
     begin
       ScecSizeX1:=-1.0 * ClientWidth / ClientHeight;
       ScecSizeX2:=+1.0 * ClientWidth / ClientHeight;
       ScecSizeY1:=-1.0;
       ScecSizeY2:=1;
       ScecSizeZ1:=-1000;
       ScecSizeZ2:=1000;
     end;


 glOrtho(ScecSizeX1, ScecSizeX2, ScecSizeY1, ScecSizeY2, ScecSizeZ1, ScecSizeZ2);

 predelS:=1/sqrt(3);

 glMatrixMode(GL_MODELVIEW);
 glLoadIdentity;

 InvalidateRect(Handle, nil, False);


end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
 if (NewWidth < 750) or
    (NewHeight < 550) then Resize:=false
                      else Resize:=true;
end;

procedure TForm1.FormResize(Sender: TObject);
//var ClientWidth, ClientHeight: integer;
begin
 LeftPanel.Width:=300;
 PageControl1.height:=form1.height-uppanel.height-20;
 cxVerticalGrid1.height:=PageControl1.height-80;
 cxVerticalGrid2.height:=PageControl1.height-80;
 cxVerticalGrid3.height:=PageControl1.height-80;
 cxVerticalGrid4.height:=PageControl1.height-80;
 cxVerticalGrid5.height:=PageControl1.height-80;
 Button1.Top := cxVerticalGrid1.height+5;
 Button2.Top := cxVerticalGrid2.height+5;
 Button3.Top := cxVerticalGrid3.height+5;
 Button4.Top := cxVerticalGrid4.height+5;
 Button5.Top := cxVerticalGrid5.height+5;

 CenterPanelResize (sender);

end;

