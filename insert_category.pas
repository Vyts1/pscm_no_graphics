                                 tempTcxCategoryRow:= (tempTcxCustomRow as TcxCategoryRow);
                                 if Lang=0 then
                                 case ipos of
                                  1: tempTcxCategoryRow.Properties.Caption:='�������';
                                  8: tempTcxCategoryRow.Properties.Caption:='��������';
                                  11: tempTcxCategoryRow.Properties.Caption:='��������';

                                  12: tempTcxCategoryRow.Properties.Caption:='�������������� �����������';
                                  18: tempTcxCategoryRow.Properties.Caption:='�����-������������� �����������';
                                  24: tempTcxCategoryRow.Properties.Caption:='��������������� �����������';

                                  26: tempTcxCategoryRow.Properties.Caption:='�������';
                                  33: tempTcxCategoryRow.Properties.Caption:='��������';
                                  36: tempTcxCategoryRow.Properties.Caption:='��������';

                                  37: tempTcxCategoryRow.Properties.Caption:='������ ����������������';
                                  43: tempTcxCategoryRow.Properties.Caption:='�������� ����������������';

                                  55: tempTcxCategoryRow.Properties.Caption:='���������';
                                  57: tempTcxCategoryRow.Properties.Caption:='��������';
                                  70: tempTcxCategoryRow.Properties.Caption:='��������';
                                  71: tempTcxCategoryRow.Properties.Caption:='�������';
                                  72: tempTcxCategoryRow.Properties.Caption:='���������';

                                  78: tempTcxCategoryRow.Properties.Caption:='���������';
                                  80: tempTcxCategoryRow.Properties.Caption:='���������';
                                  93: tempTcxCategoryRow.Properties.Caption:='��������';
                                  94: tempTcxCategoryRow.Properties.Caption:='�����������';

                                  107: tempTcxCategoryRow.Properties.Caption:='��������� ������';
                                  114: tempTcxCategoryRow.Properties.Caption:='��������� ��������';
                                  125: tempTcxCategoryRow.Properties.Caption:='��������� ��������';
                                  128: tempTcxCategoryRow.Properties.Caption:='���������� ������';
                                 end
                                           else
                                 case ipos of
                                  1: tempTcxCategoryRow.Properties.Caption:='Particle';
                                  8: tempTcxCategoryRow.Properties.Caption:='Substrate';
                                  11: tempTcxCategoryRow.Properties.Caption:='Scenarios';

                                  12: tempTcxCategoryRow.Properties.Caption:='Geometry';
                                  18: tempTcxCategoryRow.Properties.Caption:='Time-Temp';
                                  24: tempTcxCategoryRow.Properties.Caption:='Tecnolog';

                                  26: tempTcxCategoryRow.Properties.Caption:='Particle';
                                  33: tempTcxCategoryRow.Properties.Caption:='Substrate';
                                  36: tempTcxCategoryRow.Properties.Caption:='Scenarios';

                                  37: tempTcxCategoryRow.Properties.Caption:='Sensetive';
                                  43: tempTcxCategoryRow.Properties.Caption:='Back sensetive';

                                  55: tempTcxCategoryRow.Properties.Caption:='Materials';
                                  57: tempTcxCategoryRow.Properties.Caption:='Argument';
                                  70: tempTcxCategoryRow.Properties.Caption:='Scenarios';
                                  71: tempTcxCategoryRow.Properties.Caption:='Function';
                                  72: tempTcxCategoryRow.Properties.Caption:='Parameters';

                                  78: tempTcxCategoryRow.Properties.Caption:='Materials';
                                  80: tempTcxCategoryRow.Properties.Caption:='Arguments';
                                  93: tempTcxCategoryRow.Properties.Caption:='Scenarious';
                                  94: tempTcxCategoryRow.Properties.Caption:='Splat design';

                                  107: tempTcxCategoryRow.Properties.Caption:='Particles';
                                  114: tempTcxCategoryRow.Properties.Caption:='Substrate';
                                  125: tempTcxCategoryRow.Properties.Caption:='Coating';
                                  128: tempTcxCategoryRow.Properties.Caption:='Slise';
                                 end;
                                 tempTcxCategoryRow.Tag:=1000;
