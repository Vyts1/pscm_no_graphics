  // Блок одноразовых подгружений
  //===================== LH
  for i2:=0 to 1 do
    begin
      if FileExists(LHArray[i2].imgfile) then
                                           begin
                                             // <-- добавить эксепшен
                                             tempimage.LoadFromFile(LHArray[i2].imgfile);
                                             LHArray[i2].index := AltAdd(ImageList4LH, tempimage, clWhite);
                                           end
                                                                       else
                                           begin
                                             ShowMessage2(ErrorArray[0], LHArray[i2].imgfile);
                                             Application.Terminate;
                                           end;
    end;

  //===================== Scen
  for i2:=0 to 3 do
    begin
     if FileExists(ScenArray[i2].imgfile) then
                                  begin
                                   // <-- добавить эксепшен
                                   tempimage.LoadFromFile(ScenArray[i2].imgfile);
                                   ScenArray[i2].index := AltAdd(ImageList4Scen, tempimage, clWhite);
                                  end
                                 else
                                  begin
                                   ShowMessage2(ErrorArray[0], ScenArray[i2].imgfile);
                                   Application.Terminate;
                                  end;
    end;


  //===================== Pet
  for i2:=0 to 2 do
    begin
     if FileExists(PetArray[i2].imgfile) then
                                  begin
                                   // <-- добавить эксепшен
                                   tempimage.LoadFromFile(PetArray[i2].imgfile);
                                   PetArray[i2].index := AltAdd(ImageList4Pet, tempimage, clWhite);
                                  end
                                 else
                                  begin
                                   ShowMessage2(ErrorArray[0], PetArray[i2].imgfile);
                                   Application.Terminate;
                                  end;
    end;

  //===================== Arg
  for i2:=0 to 3 do
    begin
     if FileExists(ArgArray[i2].imgfile) then
                                  begin
                                   // <-- добавить эксепшен
                                   tempimage.LoadFromFile(ArgArray[i2].imgfile);
                                   ArgArray[i2].index := AltAdd(ImageList4Arg, tempimage, clWhite);
                                  end
                                 else
                                  begin
                                   ShowMessage2(ErrorArray[0], ArgArray[i2].imgfile);
                                   Application.Terminate;
                                  end;
    end;

  //===================== MD3
  for i2:=0 to 13 do
    begin
     if FileExists(MD3Array[i2].imgfile) then
                                  begin
                                   // <-- добавить эксепшен
                                   tempimage.LoadFromFile(MD3Array[i2].imgfile);
                                   MD3Array[i2].index := AltAdd(ImageList4MD3, tempimage, clWhite);
                                  end
                                 else
                                  begin
                                   ShowMessage2(ErrorArray[0], 'ppp'+MD3Array[i2].imgfile);
                                   Application.Terminate;
                                  end;
    end;

