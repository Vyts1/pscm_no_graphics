 // ��������������� ������ !

 if (ARowProperties.Row.Tag<1) OR (ARowProperties.Row.Tag>count_md_items) then ShowMessage('����������� tag')
 else
 begin


 case MD11Array[ARowProperties.Row.Tag].tip of
   0,2,5,6,7,8,9,10,11,12,13,14,15: // ���������� �� ����
      begin
        if ARowProperties.EditPropertiesClassName<>'TcxImageComboBoxProperties'
          then
            begin
         //      ShowMessage('tip '+inttostr(MD11Array[ARowProperties.Row.Tag].tip)+';  ����� ����������:'+ ARowProperties.EditPropertiesClassName)
            end
          else
           begin
             // �������� �������� � �������.
             with (Sender as TcxVerticalGrid).InplaceEditor as TcxImageComboBox do
               begin
//                i:=ItemIndex;     //<--- ���� �� ����������

                i:= strtoint ( (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value);

                MD11Array[ARowProperties.Row.Tag].valueI:=i;

               end;
             //showmessage ('Tag=' + inttostr(ARowProperties.Row.Tag) + '; I=' +inttostr(i) );

             if MD11Array[ARowProperties.Row.Tag].codenum=107 then
                                             begin
                                               // �������� ������ ������
                                               iniVar.partmat:=i;
                                               if iniVar.part_class.Move(i+1) then
                                                 begin
                                                   ShowMessage('������: ��� ������ ��������� ������');
                                                 end;
                                               //showmessage ('������ �������� '+iniVar.part_class.m_Material);
                                             end;

             if MD11Array[ARowProperties.Row.Tag].codenum=129 then
                                             begin
                                               // �������� ��������� ������
                                               iniVar.incmat:=i;
                                               if iniVar.inc_class.Move(i+1) then
                                                 begin
                                                   ShowMessage('������: ��� ������ ��������� ���������');
                                                 end;
                                               //showmessage ('������ �������� '+iniVar.inc_class.m_Material);
                                             end;


             if MD11Array[ARowProperties.Row.Tag].codenum=114 then
                                             begin
                                               // �������� �������� ������
                                               iniVar.basemat:=i;
                                               if iniVar.sub_class.Move(i+1) then
                                                 begin
                                                   ShowMessage('������: ��� ������ ��������� ��������');
                                                 end;
                                               //showmessage ('������ �������� '+iniVar.sub_class.m_Material);
                                             end;


             if MD11Array[ARowProperties.Row.Tag].codenum=93 then
                                           begin
                                             CASE i of
                                              0: begin
                                                   MD11Array[GetMD11Index(96)].row.Visible:=false;
                                                 end;
                                              1: begin
                                                   MD11Array[GetMD11Index(96)].row.Visible:=true;
                                                 end;
                                              2: begin
                                                   MD11Array[GetMD11Index(96)].row.Visible:=false;
                                                 end;
                                              3: begin
                                                   MD11Array[GetMD11Index(96)].row.Visible:=true;
                                                 end;
                                             end;
                                           end;

             if MD11Array[ARowProperties.Row.Tag].codenum=70 then
                                           begin
                                             CASE i of
                                              0:
                                                 begin
                                                   MD3Array[0].visible:=true;
                                                   MD3Array[1].visible:=true;
                                                   MD3Array[2].visible:=false;
                                                   MD3Array[3].visible:=true;
                                                   MD3Array[4].visible:=true;
                                                   MD3Array[5].visible:=true;
                                                   MD3Array[6].visible:=true;
                                                   MD3Array[7].visible:=true;
                                                   MD3Array[8].visible:=false;
                                                   MD3Array[9].visible:=true;
                                                   MD3Array[10].visible:=true;
                                                   MD3Array[11].visible:=true;
                                                   MD3Array[12].visible:=true;
                                                   MD3Array[13].visible:=true;

                                                   MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                 end;

                                              1:
                                                 begin
                                                   MD3Array[0].visible:=true;
                                                   MD3Array[1].visible:=true;
                                                   MD3Array[2].visible:=true;

                                                   MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                   MD3Array[3].visible:=false;

                                                   MD3Array[4].visible:=false;
                                                   MD3Array[5].visible:=false;
                                                   MD3Array[6].visible:=false;
                                                   MD3Array[7].visible:=false;
                                                   MD3Array[8].visible:=true;
                                                   MD3Array[9].visible:=true;
                                                   MD3Array[10].visible:=false;
                                                   MD3Array[11].visible:=false;
                                                   MD3Array[12].visible:=false;
                                                   MD3Array[13].visible:=true;

                                                 end;

                                              2:
                                                 begin
                                                   MD3Array[0].visible:=true;
                                                   MD3Array[1].visible:=true;
                                                   MD3Array[2].visible:=false;
                                                   MD3Array[3].visible:=false;
                                                   MD3Array[4].visible:=false;
                                                   MD3Array[5].visible:=false;
                                                   MD3Array[6].visible:=false;
                                                   MD3Array[7].visible:=false;
                                                   MD3Array[8].visible:=false;
                                                   MD3Array[9].visible:=true;
                                                   MD3Array[10].visible:=false;
                                                   MD3Array[11].visible:=false;
                                                   MD3Array[12].visible:=false;
                                                   MD3Array[13].visible:=true;

                                                   MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                 end;

                                              3:
                                                 begin
                                                   MD3Array[0].visible:=true;
                                                   MD3Array[1].visible:=true;
                                                   MD3Array[2].visible:=true;
                                                   MD3Array[3].visible:=false;
                                                   MD3Array[4].visible:=false;
                                                   MD3Array[5].visible:=false;
                                                   MD3Array[6].visible:=false;
                                                   MD3Array[7].visible:=false;
                                                   MD3Array[8].visible:=true;
                                                   MD3Array[9].visible:=true;
                                                   MD3Array[10].visible:=false;
                                                   MD3Array[11].visible:=false;
                                                   MD3Array[12].visible:=false;
                                                   MD3Array[13].visible:=true;

                                                   MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                   MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                   MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                   MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                   MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                   MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                 end;

                                             END;
//=====================================================================================
              // ����������� ������
               with (MD11Array[GetMD11Index(71)].row as TcxEditorRow ) do
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

                   MD11Array[GetMD11Index(71)].valueI:=0;
                   Properties.value:=inttostr(MD11Array[GetMD11Index(71)].valueI);
                 end;//----- tip 8
//=====================================================================================
                                           end;

             if MD11Array[ARowProperties.Row.Tag].codenum = 71 then
                                           begin
                                              case i of
                                               0:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               1:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;

                                               2:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               3:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               4:
                                                  begin //d1
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               5:
                                                  begin //d2
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=true;
                                                  end;
                                               6:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               7:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               8:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               9:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               10:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               11:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               12:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;
                                               13:
                                                  begin
                                                     MD11Array[GetMD11Index(72)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(73)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(74)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(75)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(76)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(77)].row.Visible:=false;
                                                  end;


                                              end;

                                           end;


             if MD11Array[ARowProperties.Row.Tag].codenum=69 then
                                            begin
                                              case i of
                                                0:
                                                   begin
                                                     MD11Array[GetMD11Index(57)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(58)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(59)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(60)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(61)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(62)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(63)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(64)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(65)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(66)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(67)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(68)].row.Visible:=false;
                                                   end;
                                                1:
                                                   begin
                                                     MD11Array[GetMD11Index(57)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(58)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(59)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(60)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(61)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(62)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(63)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(64)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(65)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(66)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(67)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(68)].row.Visible:=false;
                                                   end;
                                                2:
                                                   begin
                                                     MD11Array[GetMD11Index(57)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(58)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(59)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(60)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(61)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(62)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(63)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(64)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(65)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(66)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(67)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(68)].row.Visible:=false;
                                                   end;
                                                3:
                                                   begin
                                                     MD11Array[GetMD11Index(57)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(58)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(59)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(60)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(61)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(62)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(63)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(64)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(65)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(66)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(67)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(68)].row.Visible:=true;
                                                   end;
                                              end;
                                            end;

             if MD11Array[ARowProperties.Row.Tag].codenum=92 then
                                            begin
                                              case i of
                                                0:
                                                   begin
                                                     MD11Array[GetMD11Index(80)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(81)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(82)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(83)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(84)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(85)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(86)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(87)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(88)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(89)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(90)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(91)].row.Visible:=false;
                                                   end;
                                                1:
                                                   begin
                                                     MD11Array[GetMD11Index(80)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(81)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(82)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(83)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(84)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(85)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(86)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(87)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(88)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(89)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(90)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(91)].row.Visible:=false;
                                                   end;
                                                2:
                                                   begin
                                                     MD11Array[GetMD11Index(80)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(81)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(82)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(83)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(84)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(85)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(86)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(87)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(88)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(89)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(90)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(91)].row.Visible:=false;
                                                   end;
                                                3:
                                                   begin
                                                     MD11Array[GetMD11Index(80)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(81)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(82)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(83)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(84)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(85)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(86)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(87)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(88)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(89)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(90)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(91)].row.Visible:=true;
                                                   end;
                                              end;
                                            end;



             if MD11Array[ARowProperties.Row.Tag].codenum=119 then  //����� ��������
                                            begin
                                              case i of
                                                0:
                                                   begin
                                                     MD11Array[GetMD11Index(120)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
  for t2 := 120 to 124 do
    begin
      tmp := GetMD11Index(t2);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := MD11Array[tmp].RU
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := MD11Array[tmp].EN;
    end;

                                                   end;
                                                1:
                                                   begin

  for t2 := 120 to 124 do
    begin
      tmp := GetMD11Index(t2);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := MD11Array[tmp].RU
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := MD11Array[tmp].EN;
    end;



                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=true;
                                                   end;

                                                2:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '����� ����� X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := 'Sphere center X, mcm';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '����� ����� Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := 'Sphere center, mcm';

      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ �����, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := 'Sphere rad, mcm';


                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;

                                                3:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ����� �������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '��������� �������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '�������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                4:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ �� ������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                5:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� �������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                6:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� �������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                7:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '����� ������ X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '��������� �����, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ �����, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                8:
                                                   begin
      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '�������� ����� �����������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                9:
                                                   begin
      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '�������� ����� �����������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� ���������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                10:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '����� X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '����� Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ������ �������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '��������� ������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(124);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� ������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=true;
                                                   end;
                                                11:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������� ���, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ��� X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(124);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ��� Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=true;
                                                   end;
                                                12:
                                                   begin
                                                     MD11Array[GetMD11Index(120)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;
                                                13:
                                                   begin
                                                     MD11Array[GetMD11Index(120)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;


                                                14:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '��������� X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '��������� Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '�������� X, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '�������� Y, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(124);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ H, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=true;
                                                   end;

                                                15:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '���������� �� ������ , ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := ''
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(124);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := ''
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;

                                                16:
                                                   begin

      tmp := GetMD11Index(120);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������ ������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(121);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '���������� �� ������ >2R , ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(122);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '������, ���'
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(123);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := ''
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';
      tmp := GetMD11Index(124);
      if Lang=0 then (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := ''
                else (MD11Array[tmp].row as TcxEditorRow).Properties.Caption := '';

                                                     MD11Array[GetMD11Index(120)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(121)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(122)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(123)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(124)].row.Visible:=false;
                                                   end;


                                              end;
                                            end;


             if MD11Array[ARowProperties.Row.Tag].codenum=125 then
                                            begin
                                              case i of
                                                0:
                                                   begin
                                                     MD11Array[GetMD11Index(126)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(127)].row.Visible:=true;
                                                   end;
                                                1:
                                                   begin
                                                     MD11Array[GetMD11Index(126)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(127)].row.Visible:=false;
                                                   end;
                                              end;
                                            end;



             if MD11Array[ARowProperties.Row.Tag].codenum=132 then
                                            begin
                                              case i of
                                                0:   //������
                                                   begin
//                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(130)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                   end;
                                                1:   //�����
                                                   begin
//                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(130)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                   end;
                                                2:    //��������������
                                                   begin
//                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(129)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(130)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(131)].row.Visible:=true;


                                                     if MD11Array[GetMD11Index(133)].ValueI = 2 then
                                                       begin //���� ��������
                                                         MD11Array[GetMD11Index(133)].ValueI := 0;
                                                        (MD11Array[GetMD11Index(133)].row as TcxEditorRow).Properties.Value := 0;


                                                     MD11Array[GetMD11Index(108)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(109)].row.Visible:=true;

                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;

                                                     if MD11Array[GetMD11Index(132)].ValueI = 2 then
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=true;
                                                        end
                                                                                                else
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=false;
                                                        end;

                                                     MD11Array[GetMD11Index(134)].row.Visible:=false;


                                                       end;



                                                   end;
                                              end;
                                            end;



             //������ �����
             if MD11Array[ARowProperties.Row.Tag].codenum=133 then
                                            begin
                                              case i of
                                                0:   //����������
                                                   begin
                                                     MD11Array[GetMD11Index(108)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(109)].row.Visible:=true;

                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;

                                                     if MD11Array[GetMD11Index(132)].ValueI = 2 then
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=true;
                                                        end
                                                                                                else
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=false;
                                                        end;

                                                     MD11Array[GetMD11Index(134)].row.Visible:=false;

                                                   end;
                                                1:   //������
                                                   begin
                                                     MD11Array[GetMD11Index(108)].row.Visible:=true;
                                                     MD11Array[GetMD11Index(109)].row.Visible:=true;

                                                     MD11Array[GetMD11Index(107)].row.Visible:=true;

                                                     if MD11Array[GetMD11Index(132)].ValueI = 2 then
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=true;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=true;
                                                        end
                                                                                                else
                                                        begin
                                                          MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                          MD11Array[GetMD11Index(130)].row.Visible:=false;
                                                        end;

                                                     MD11Array[GetMD11Index(134)].row.Visible:=false;

                   (MD11Array[GetMD11Index(109)].row as TcxEditorRow).Properties.Value := (MD11Array[GetMD11Index(108)].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(109)].valueR := MD11Array[GetMD11Index(108)].valueR;

                   (MD11Array[GetMD11Index(111)].row as TcxEditorRow).Properties.Value := (MD11Array[GetMD11Index(110)].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(111)].valueR := MD11Array[GetMD11Index(110)].valueR;

                   (MD11Array[GetMD11Index(113)].row as TcxEditorRow).Properties.Value := (MD11Array[GetMD11Index(112)].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(113)].valueR := MD11Array[GetMD11Index(112)].valueR;

                   (MD11Array[GetMD11Index(117)].row as TcxEditorRow).Properties.Value := (MD11Array[GetMD11Index(116)].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(117)].valueR := MD11Array[GetMD11Index(116)].valueR;


                                                   end;
                                                2:   //�����������
                                                   begin
                                                     MD11Array[GetMD11Index(108)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(109)].row.Visible:=false;

                                                     if MD11Array[GetMD11Index(132)].ValueI = 2 then
                                                       begin //���� ��������
                                                         MD11Array[GetMD11Index(132)].ValueI := 0;
                                                         (MD11Array[GetMD11Index(132)].row as TcxEditorRow).Properties.Value := 0;
                                                       end;

                                                     MD11Array[GetMD11Index(134)].row.Visible:=true;

                                                     MD11Array[GetMD11Index(107)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(131)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(129)].row.Visible:=false;
                                                     MD11Array[GetMD11Index(130)].row.Visible:=false;



                                                   end;
                                              end;
                                            end;


{             if MD11Array[ARowProperties.Row.Tag].tip<>0 then ShowMessage(inttostr(MD11Array[ARowProperties.Row.Tag].valueI))
                                                         else
                                                           begin
                                                            DataModule1.ADOTable1.Open;
                                                            DataModule1.ADOTable1.First;
                                                            for i2:=0 to i-1 do
                                                              DataModule1.ADOTable1.Next;
                                                            showmessage (DataModule1.ADOTable1.FieldByName('Material').AsString);

                                                            DataModule1.ADOTable1.close;

                                                           end;}
           end;
      end;

   1: // Edit
      begin
        if ARowProperties.EditPropertiesClassName<>'TcxTextEditProperties'
          then
            begin
  //            ShowMessage('tip '+inttostr(MD11Array[ARowProperties.Row.Tag].tip)+';  ����� ����������:'+ ARowProperties.EditPropertiesClassName)
            end
          else
           begin
             MD11Array[ARowProperties.Row.Tag].valueR:=strtofloat2 ((MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value, 0);


             if MD11Array[GetMD11Index(133)].valueI = 1 then // ���� ������ ��������, �� ��������� ���
               begin

                if (MD11Array[ARowProperties.Row.Tag].codenum=108) then
                  begin
                   (MD11Array[GetMD11Index(109)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(109)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;


                if (MD11Array[ARowProperties.Row.Tag].codenum=109) then
                  begin
                   (MD11Array[GetMD11Index(108)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(108)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;


                if (MD11Array[ARowProperties.Row.Tag].codenum=110) then
                  begin
                   (MD11Array[GetMD11Index(111)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(111)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

                if (MD11Array[ARowProperties.Row.Tag].codenum=111) then
                  begin
                   (MD11Array[GetMD11Index(110)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(110)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

                if (MD11Array[ARowProperties.Row.Tag].codenum=112) then
                  begin
                   (MD11Array[GetMD11Index(113)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(113)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

                if (MD11Array[ARowProperties.Row.Tag].codenum=113) then
                  begin
                   (MD11Array[GetMD11Index(112)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(112)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

                if (MD11Array[ARowProperties.Row.Tag].codenum=116) then
                  begin
                   (MD11Array[GetMD11Index(117)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(117)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

                if (MD11Array[ARowProperties.Row.Tag].codenum=117) then
                  begin
                   (MD11Array[GetMD11Index(116)].row as TcxEditorRow).Properties.Value := (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow).Properties.Value;
                   MD11Array[GetMD11Index(116)].valueR := MD11Array[ARowProperties.Row.Tag].valueR;
                  end;

               end;



//             showmessage ('Tag=' + inttostr(ARowProperties.Row.Tag) + '; R=' +floattostr(MD11Array[ARowProperties.Row.Tag].valueR));


             case MD11Array[ARowProperties.Row.Tag].codenum of
             108:
                  begin
                    if MD11Array[ARowProperties.Row.Tag].valueR < 10 then
                      showmessage ('������ �������� �������� ������ 10 ���');
                  end;



             end;





           end;

      end;

   3: // �������������
      begin
       if ARowProperties.EditPropertiesClassName='TcxCheckBoxProperties'
         then
           begin
             with (MD11Array[ARowProperties.Row.Tag].row as TcxMultiEditorRow) do
               begin
                                         //         (Properties.Editors.Items[0].EditPropertiesClass as TcxCheckBoxProperties).
                MD11Array[ARowProperties.Row.Tag].valueB := Properties.Editors.Items[0].Value;
//                if Properties.Editors.Items[0].Value then showmessage ('��')
//                                                     else showmessage ('���'); //}
               end;
           end
          else
           begin
            if ARowProperties.EditPropertiesClassName='TcxImageComboBoxProperties'
              then
                begin

                  with (Sender as TcxVerticalGrid).InplaceEditor as TcxImageComboBox do
                    begin
                      i:=ItemIndex;
                      MD11Array[ARowProperties.Row.Tag].valueI:=i;
                    end;
//                  ShowMessage(inttostr(i));

                end
              else
                begin
                  if ARowProperties.EditPropertiesClassName='TcxTextEditProperties'
                    then
                      begin
                        with (Sender as TcxVerticalGrid).InplaceEditor as TcxTextEdit do
                         begin
                          MD11Array[ARowProperties.Row.Tag].valueR:=strtofloat2 (text, 0);
//                          showmessage (Text);
                         end;
                      end
                    else
                      begin
//                         ShowMessage('tip '+inttostr(MD11Array[ARowProperties.Row.Tag].tip)+';  ����� ����������:'+ ARowProperties.EditPropertiesClassName)
                      end;
                end;
           end;
      end;

   4: // ������ �������
      begin

       if ARowProperties.EditPropertiesClassName='TcxCheckBoxProperties'
         then
           begin
             with (MD11Array[ARowProperties.Row.Tag].row as TcxEditorRow) do
               begin
                MD11Array[ARowProperties.Row.Tag].valueB:=Properties.Value;
{                if Properties.Value then showmessage ('��')
                                    else showmessage ('���');}
               end;
           end
         else
           begin
//             ShowMessage('tip '+inttostr(MD11Array[ARowProperties.Row.Tag].tip)+';  ����� ����������:'+ ARowProperties.EditPropertiesClassName)
          end;

      end;

    else
      begin
       ShowMessage('����������� ��� ������'+inttostr(MD11Array[ARowProperties.Row.Tag].tip));
      end;

 end;//  case
 end;//----------- �������� tag
