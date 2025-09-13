  ImageList4md1:=TImageList.Create(Mode1);
  ImageList4md3:=TImageList.Create(Mode3);
  ImageList4md4:=TImageList.Create(Mode3);
  ImageList4Scen:=TImageList.Create(Form1);
  ImageList4LH:=TImageList.Create(Form1);
  ImageList4Pet:=TImageList.Create(Form1);
  ImageList4Arg:=TImageList.Create(Form1);
  ImageList4md5:=TImageList.Create(Mode3);

  with ImageList4md1 do
   begin
     CreateSize(108,15);
     BkColor:=clWhite;
   end;

  with ImageList4md3 do
   begin
     CreateSize(108,20);
     BkColor:=clWhite;
   end;

  with ImageList4md4 do
   begin
     CreateSize(108,20);
     BkColor:=clWhite;
   end;

  with ImageList4md5 do
   begin
     CreateSize(61,25);
     BkColor:=clWhite;
   end;


  with ImageList4Scen do
   begin
     CreateSize(184,88);
     BkColor:=clWhite;
   end;

  with ImageList4LH do
   begin
     CreateSize(11,11);
     BkColor:=clWhite;
   end;

  with ImageList4Pet do
   begin
     CreateSize(15,15);
     BkColor:=clWhite;
   end;

  with ImageList4Arg do
   begin
     CreateSize(16,14);
     BkColor:=clWhite;
   end;
