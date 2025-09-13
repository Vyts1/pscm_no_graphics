procedure TForm1.FormDestroy(Sender: TObject);
begin
 iniVar.histogram := nil;

 ImageList4md1.Free;
 ImageList4md3.Free;
 ImageList4md4.Free;
 ImageList4md5.Free;
 ImageList4Pet.Free;
 ImageList4arg.Free;

 ImageList4Scen.Free;
 ImageList4LH.Free;


 {$I 'func\DrawTextDestroy.pas'}   //<--- 4

 wglMakeCurrent(0, 0);
 wglDeleteContext(hrc);
 ReleaseDC (Handle, DC);
 DeleteDC (DC);


 m_calc.Destroy();


end;
