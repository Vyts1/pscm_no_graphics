

 if MD11Array[i].tip<>3 then // ��� ������
                          begin
                            with (tempTcxCustomRow as TcxEditorRow) do
                               begin
//                                 if (MD11Array[i].tip = 1) OR (MD11Array[i].tip = 4) then
//                                 Properties.Value:=1;// <------- ������������������� !!!!

                                                        tag:=i;
                                                        if MD11Array[i].index<>-1 then Properties.ImageIndex:=MD11Array[i].index
                                                                                  else
                                                                                    begin
                                                                                      Properties.HeaderAlignmentHorz:=taLeftJustify;
                                                                                      if Lang=0
                                                                                                 then Properties.Caption:=MD11Array[i].RU
                                                                                                 else Properties.Caption:=MD11Array[i].EN;
                                                                                      Properties.ImageIndex:=-1;
                                                                                    end;

                                                        if MD11Array[i].tip=4 then // ���� ��� �������
                                                                                begin
                                                                                  Properties.EditPropertiesClass:=TcxCheckBoxProperties;
                                                                                 (Properties.EditProperties as TcxCheckBoxProperties).ValueChecked:=true;
                                                                                 (Properties.EditProperties as TcxCheckBoxProperties).ValueUnchecked:=false;
//                                                                                  Properties.Value:=true;
                                                                                  Properties.Value:=MD11Array[i].valueB;
                                                                                end;
                               end;
                          end
                        else  // ��� ������������
                          begin
                            with (tempTcxCustomRow as TcxMultiEditorRow) do
                              begin
                                 tag:=i;
                                 properties.separatorKind:=skString;
                                 
                                 tempTcxEditorRowItemProperties := Properties.Editors.Add;
                                 //----------------------- �������� + �������
                                 tempTcxEditorRowItemProperties.EditPropertiesClass:=TcxCheckBoxProperties;

                                 if MD11Array[i].index<>-1
                                   then
                                        begin
                                         tempTcxEditorRowItemProperties.ImageIndex:=MD11Array[i].index;
                                        end
                                   else
                                        begin
                                          if Lang=0
                                                   then Caption:=MD11Array[i].RU
                                                   else Caption:=MD11Array[i].EN;
                                        end;
//                                 tempTcxEditorRowItemProperties.width:=100;
                                 with tempTcxEditorRowItemProperties.EditProperties as TcxCheckBoxProperties do
                                   begin
                                     ValueChecked:=true;
                                     ValueUnchecked:=false;
                                   end;
//                                 tempTcxEditorRowItemProperties.Value:=true; //<----- �������������������!
                                 tempTcxEditorRowItemProperties.Value:=MD11Array[i].valueB; //<----- �������������������!

                                 //------------------------ ����
                                 tempTcxEditorRowItemProperties := Properties.Editors.Add;

//                                 tempTcxEditorRowItemProperties.width:=0;
                                 tempTcxEditorRowItemProperties.EditPropertiesClass:=TcxImageComboBoxProperties;

                                 with tempTcxEditorRowItemProperties.EditProperties as TcxImageComboBoxProperties do
                                   begin
                                     Images:=ImageList4LH;
                                     Items.Clear;
                                     Items.Add.Value:=false;
                                     Items.Add.Value:=true;
                                     Items[0].ImageIndex:=LHArray[0].Index;
                                     Items[1].ImageIndex:=LHArray[1].Index;

                                   end;
                                 if MD11Array[i].valueI=1 then
                                                            tempTcxEditorRowItemProperties.value:=true
                                                          else
                                                            tempTcxEditorRowItemProperties.value:=false;
//                                 tempTcxEditorRowItemProperties.value:=MD11Array[i].valueI;

                                 //------------------------ ����
                                 tempTcxEditorRowItemProperties := Properties.Editors.Add;
                                 tempTcxEditorRowItemProperties.EditPropertiesClass:=TcxTextEditProperties;

                                 tempTcxEditorRowItemProperties.value:=floattostr(MD11Array[i].valueR);
//                                 tempTcxEditorRowItemProperties.Properties.Editors[3].value:=floattostr(MD11Array[i].valueR);
//                                 with tempTcxEditorRowItemProperties.EditProperties as TcxTextEditProperties do
//                                 Properties.Value:=floattostr(MD11Array[i].valueR);


                              end;

                          end;


//=============================================================================================================================
// ��� ����� �������� ������ ������ �������� � ��� ����� � ��������������.
     if (MD11Array[i].tip=0) OR (MD11Array[i].tip=1) OR (MD11Array[i].tip=2) OR (MD11Array[i].tip=5) OR (MD11Array[i].tip=6) OR (MD11Array[i].tip=7) OR (MD11Array[i].tip=8) OR (MD11Array[i].tip=9) OR (MD11Array[i].tip=10) OR (MD11Array[i].tip=11) OR (MD11Array[i].tip=12) OR (MD11Array[i].tip=13) OR (MD11Array[i].tip=14) OR (MD11Array[i].tip=15) then //<--- �������� ���� ����� ������!
       begin
          with (tempTcxCustomRow as TcxEditorRow) do
            begin

              case MD11Array[i].tip of
               0: // ���� � �����������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;

                       DataModule1.ADOTable1.Open;
                       i2:=0;
                       while not DataModule1.ADOTable1.Eof do
                         begin

//                           Items.Add.Value:=DataModule1.ADOTable1.FieldByName('nId').AsString;
//                           Items.Add.Value:=inttostr(i2);
                           Items.Add.Value:=strtoint(DataModule1.ADOTable1.FieldByName('nId').AsString)-1;
                           Items[i2].Description:=DataModule1.ADOTable1.FieldByName('Material').AsString;
                           DataModule1.ADOTable1.Next;
                           i2:=i2+1;
                         end; //}
                       DataModule1.ADOTable1.close;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);

                 end;//----- tip 0

               1: // TextEdit
                 begin
                   Properties.EditPropertiesClass:=TcxTextEditProperties;
                   Properties.Value:=floattostr(MD11Array[i].valueR);
//                   with TcxTextEditProperties(Properties.EditProperties) do  // ��� ����� �������� ���������� ���������
//                     begin
//                     end;

                 end;//----- tip 1

               2:  // ���� �� ����������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Images:=ImageList4Scen;
                       for i2:=0 to 3 do
                         begin
                           Items.Add.Value:=i2;
                           Items[i2].ImageIndex:=ScenArray[i2].Index;
                           if Lang=0 then Items[i2].Description:=ScenArray[i2].RU
                                     else Items[i2].Description:=ScenArray[i2].EN;
                         end;
                       //DefaultImageIndex:=0;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 2

               5:  // ���� � ������� Pe/Tpo/Tbo
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Images:=ImageList4Pet;
                       for i2:=0 to 2 do
                         begin
                           Items.Add.Value:=i2;
                           Items[i2].ImageIndex:=PetArray[i2].Index;
                         end;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 5

               6:  // ���� � ������� Yes/No
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=1;
                       Items.Add.Value:=0;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='��';
                                    Items[1].Description:='���';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='Yes';
                                    Items[1].Description:='No';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 6


               7:  // ���� � ������� /Tpo/upo/Dpo/Tbo
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Images:=ImageList4arg;
                       for i2:=0 to 3 do
                         begin
                           Items.Add.Value:=i2;
                           Items[i2].ImageIndex:=ArgArray[i2].Index;
                         end;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 7


               8:  // ���� � ������� �������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Images:=ImageList4MD3;
                       i3:=-1;
                       for i2:=0 to 13 do
                         begin
                           if MD3Array[i2].visible then
                                                    begin
                                                     i3:=i3+1;
                                                     Items.Add.Value:=i2;
                                                     Items[i3].ImageIndex:=MD3Array[i2].Index;

                                                     if Lang=0 then Items[i3].Description:=MD3Array[i2].RU
                                                               else Items[i3].Description:=MD3Array[i2].EN;
                                                    end;

                         end;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 8

               9: // ���� � ��������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       for i2:=0 to 19 do
                         begin
//                           Items.Add.Value:='V'+inttostr(i2);
                           Items.Add.Value:=inttostr(i2);
                           case i2 of
                            00: begin
                                  Items[i2].Description:='Madejski-1';
                                end;
                            01: begin
                                  Items[i2].Description:='Madejski-2';
                                end;
                            02: begin
                                  Items[i2].Description:='Madejski-3';
                                end;
                            03: begin
                                  Items[i2].Description:='Madejski-4';
                                end;
                            04: begin
                                  Items[i2].Description:='Lui';
                                end;
                            05: begin
                                  Items[i2].Description:='Trapaga';
                                end;
                            06: begin
                                  Items[i2].Description:='Bertagnolli';
                                end;
                            07: begin
                                  Items[i2].Description:='Yoshida';
                                end;
                            08: begin
                                  Items[i2].Description:='Watanable';
                                end;
                            09: begin
                                  Items[i2].Description:='Montavon';
                                end;
                            10: begin
                                  Items[i2].Description:='Pasandideh';
                                end;
                            11: begin
                                  Items[i2].Description:='Gasin';
                                end;
                            12: begin
                                  Items[i2].Description:='Kurukawa';
                                end;
                            13: begin
                                  Items[i2].Description:='Collings';
                                end;
                            14: begin
                                  Items[i2].Description:='Cheng';
                                end;
                            15: begin
                                  Items[i2].Description:='Akao';
                                end;
                            16: begin
                                  Items[i2].Description:='Chandra';
                                end;
                            17: begin
                                  Items[i2].Description:='McPherson';
                                end;
                            18: begin
                                  Items[i2].Description:='Jones';
                                end;
                            19: begin
                                  Items[i2].Description:='Solonenko';
                                end;
                           end;
                         end;
                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 9

               10:  // ���� � ������� ����� ��������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=0;
                       Items.Add.Value:=1;
                       Items.Add.Value:=2;
                       Items.Add.Value:=3;
                       Items.Add.Value:=4;
                       Items.Add.Value:=5;
                       Items.Add.Value:=6;
                       Items.Add.Value:=7;
                       Items.Add.Value:=8;
                       Items.Add.Value:=9;
                       Items.Add.Value:=10;
                       Items.Add.Value:=11;
                       Items.Add.Value:=12;
                       Items.Add.Value:=13;
                       Items.Add.Value:=14;
                       Items.Add.Value:=15;
                       Items.Add.Value:=16;
                       Items.Add.Value:=17;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='�������';
                                    Items[1].Description:='������������� ��������';
                                    Items[2].Description:='�����';
                                    Items[3].Description:='��������';
                                    Items[4].Description:='���������';
                                    Items[5].Description:='�������� ����';
                                    Items[6].Description:='�������� �����';
                                    Items[7].Description:='�����';
                                    Items[8].Description:='������� ����';
                                    Items[9].Description:='���������';
                                    Items[10].Description:='������';
                                    Items[11].Description:='����';
                                    Items[12].Description:='������ �����';
                                    Items[13].Description:='�������';
                                    Items[14].Description:='��������� ��������';
                                    Items[15].Description:='������ �������� ��.�����';
                                    Items[16].Description:='������ �������� �����';
                                    Items[17].Description:='������������';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='Clear';
                                    Items[1].Description:='Paterns';
                                    Items[2].Description:='Sphere';
                                    Items[3].Description:='Furrow';
                                    Items[4].Description:='Slope';
                                    Items[5].Description:='Pattern Sphere';
                                    Items[6].Description:='Pattern Cone';
                                    Items[7].Description:='Baffle';
                                    Items[8].Description:='Double wedge';
                                    Items[9].Description:='Pyramids';
                                    Items[10].Description:='Glass';
                                    Items[11].Description:='Trench';
                                    Items[12].Description:='Mountain brook';
                                    Items[13].Description:='Glass';
                                    Items[14].Description:='Pyram up';
                                    Items[15].Description:='Cone up sq';
                                    Items[16].Description:='Cone up dens';
                                    Items[17].Description:='Random noise';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 10

               11:  // ���� � ������� ��� ����������� ������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=0;
                       Items.Add.Value:=1;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='�� �������';
                                    Items[1].Description:='�� ����������';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='By thikness';
                                    Items[1].Description:='By number';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 11


               12:  // �������� ������� ������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=0;
                       Items.Add.Value:=1;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='1/(1-VolCon)';
                                    Items[1].Description:='�����';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='1/(1-VolCon)';
                                    Items[1].Description:='Uriev';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 12



               13:  // ���� � ������� ������� ���� ���������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=0;
                       Items.Add.Value:=1;
                       Items.Add.Value:=2;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='�������';
                                    Items[1].Description:='������';
                                    Items[2].Description:='���������������';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='Metal';
                                    Items[1].Description:='Oxide';
                                    Items[1].Description:='MetCer';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 13


               14:  // ���� � ������� ������� ������� ���������� ������
                 begin
                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;
                       Items.Add.Value:=0;
                       Items.Add.Value:=1;
                       Items.Add.Value:=2;
                       if Lang=0 then
                                  begin
                                    Items[0].Description:='���������� �������������';
                                    Items[1].Description:='������ ��������';
                                    Items[2].Description:='�����������';
                                  end
                                 else
                                  begin
                                    Items[0].Description:='Normal distribution';
                                    Items[1].Description:='Const value';
                                    Items[1].Description:='Histogram';
                                  end;

                     end;
                   Properties.value:=inttostr(MD11Array[i].valueI);
                 end;//----- tip 14


               15:  // ���� � ������� �����������
                 begin
                   ReadHistogram();

                   Properties.EditPropertiesClass:=TcxImageComboBoxProperties;
                   with TcxImageComboBoxProperties(Properties.EditProperties) do
                     begin
                       Items.Clear;

                       for i2 := 0 to iniVar.hist_col - 1 do
                         begin
                           Items.Add.Value := i2;
                           Items[i2].Description := iniVar.histogram[i2].name;
                         end;

                     end;
                   Properties.value := inttostr(MD11Array[i].valueI);
                 end;//----- tip 15





              end;//case end
            end; // with end

       end; // if i=0 or 3


 MD11Array[i].row.visible := MD11Array[i].visible;

