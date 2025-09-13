
                              with (t as TcxEditorRow) do
                                begin
                                  Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                                  with TcxImageComboBoxProperties(Properties.EditProperties) do
                                    begin
                                      MD11Array[i].valueI:=Properties.value;

                                      Items.Clear;
                                      DataModule1.ADOTable1.Open;
                                      DataModule1.ADOTable1.First;

                                      i2:=0;
                                      while not DataModule1.ADOTable1.Eof do
                                        begin


                                          Items.Add.Value:=strtoint(DataModule1.ADOTable1.FieldByName('nId').AsString)-1;
//                                          Items.Add.Value:=inttostr(i2);
                                          Items[i2].Description:=DataModule1.ADOTable1.FieldByName('Material').AsString;
                                          DataModule1.ADOTable1.Next;
                                          i2:=i2+1;
                                        end; //}
                                      DataModule1.ADOTable1.close;
                                      Properties.value:=inttostr(MD11Array[i].valueI);
                                    end;

                                end;
