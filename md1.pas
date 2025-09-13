
  // MD11
  for i:=1 to count_md_items do
   begin
     if Lang=0 then tempstr:=MD11Array[i].imgfileRU else tempstr:=MD11Array[i].imgfileEN;
     if tempstr<>'none' then
                         begin
                           if FileExists(tempstr) then
                                                    begin
                                                      // <-- добавить эксепшен
                                                      tempimage.LoadFromFile(tempstr);
                                                      case MD11Array[i].menunum of
                                                       1,2: MD11Array[i].index := AltAdd(ImageList4md1, tempimage, clWhite);
                                                       3: MD11Array[i].index := AltAdd(ImageList4md3, tempimage, clWhite);
                                                       4: MD11Array[i].index := AltAdd(ImageList4md4, tempimage, clWhite);
                                                       5: MD11Array[i].index := AltAdd(ImageList4md5, tempimage, clWhite);
                                                      end;
                                                    end
                                                  else
                                                    begin
                                                      ShowMessage2(ErrorArray[0], tempstr);
                                                      Application.Terminate;
                                                    end;
                         end;

   end; // for i=1 to конец

  //---------------------------------------------------------------------------------------------

  //---------------------------------------------------------------------------------------------
  // Второй проход, вот теперь за дело.
  cxVerticalGrid1.Images:=ImageList4md1;
  cxVerticalGrid2.Images:=ImageList4md1;
  cxVerticalGrid3.Images:=ImageList4md3;
  cxVerticalGrid4.Images:=ImageList4md4;
  cxVerticalGrid5.Images:=ImageList4md5;

  for j := 1 to count_md_items do
    begin
//      for j2 := 1 to count_md_items do
        begin
//          if MD11Array[j2].codenum = j then
                                         begin
//                                           i:=MD11Array[j2].codenum;
                                           i:=j;
                                           // Создание разделителей ----------------------------------------------------------------
                                           ipos:=MD11Array[i].codenum;

                                           case ipos of
                                             1,8,11,12,18,24,26,33,36,37,43,55,57,70,71,72,78,80,93,94,107,114,125,128:
                                               begin
                                                 case MD11Array[i].menunum of
                                                   1: tempTcxCustomRow:=cxVerticalGrid1.Add(TcxCategoryRow);
                                                   2: tempTcxCustomRow:=cxVerticalGrid2.Add(TcxCategoryRow);
                                                   3: tempTcxCustomRow:=cxVerticalGrid3.Add(TcxCategoryRow);
                                                   4: tempTcxCustomRow:=cxVerticalGrid4.Add(TcxCategoryRow);
                                                   5: tempTcxCustomRow:=cxVerticalGrid5.Add(TcxCategoryRow);
                                                 end;
                                                 {$I 'insert_category.pas'}
                                               end;
                                           end;

                                           //if MD11Array[i].menunum = 1 then
                                             begin
                                               if MD11Array[i].tip <> 3 then
                                                          begin
                                                            case MD11Array[i].menunum of
                                                              1: MD11Array[i].row :=cxVerticalGrid1.Add(TcxEditorRow);
                                                              2: MD11Array[i].row :=cxVerticalGrid2.Add(TcxEditorRow);
                                                              3: MD11Array[i].row :=cxVerticalGrid3.Add(TcxEditorRow);
                                                              4: MD11Array[i].row :=cxVerticalGrid4.Add(TcxEditorRow);
                                                              5: MD11Array[i].row :=cxVerticalGrid5.Add(TcxEditorRow);
                                                            end;
                                                          end
                                                                        else
                                                          begin
                                                            case MD11Array[i].menunum of
                                                              1: MD11Array[i].row :=cxVerticalGrid1.Add(TcxMultiEditorRow);
                                                              2: MD11Array[i].row :=cxVerticalGrid2.Add(TcxMultiEditorRow);
                                                              3: MD11Array[i].row :=cxVerticalGrid3.Add(TcxMultiEditorRow);
                                                              4: MD11Array[i].row :=cxVerticalGrid4.Add(TcxMultiEditorRow);
                                                              5: MD11Array[i].row :=cxVerticalGrid5.Add(TcxMultiEditorRow);
                                                            end;
                                                          end;
                                               tempTcxCustomRow:=MD11Array[i].row;
                                               {$I 'insert_editors.pas'}
                                             end;

//-------------------------------------------------------------------------------------------------------
                                         end;
        end;
    end;
  //---------------------------------------------------------------------------------------------
