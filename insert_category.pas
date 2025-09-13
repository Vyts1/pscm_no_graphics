                                 tempTcxCategoryRow:= (tempTcxCustomRow as TcxCategoryRow);
                                 if Lang=0 then
                                 case ipos of
                                  1: tempTcxCategoryRow.Properties.Caption:='Частица';
                                  8: tempTcxCategoryRow.Properties.Caption:='Подложка';
                                  11: tempTcxCategoryRow.Properties.Caption:='Сценарии';

                                  12: tempTcxCategoryRow.Properties.Caption:='Геометрические ограничения';
                                  18: tempTcxCategoryRow.Properties.Caption:='Время-температурные ограничения';
                                  24: tempTcxCategoryRow.Properties.Caption:='Технологические ограничения';

                                  26: tempTcxCategoryRow.Properties.Caption:='Частица';
                                  33: tempTcxCategoryRow.Properties.Caption:='Подложка';
                                  36: tempTcxCategoryRow.Properties.Caption:='Сценарии';

                                  37: tempTcxCategoryRow.Properties.Caption:='Прямая чувствительность';
                                  43: tempTcxCategoryRow.Properties.Caption:='Обратная чувствительность';

                                  55: tempTcxCategoryRow.Properties.Caption:='Материалы';
                                  57: tempTcxCategoryRow.Properties.Caption:='Аргумент';
                                  70: tempTcxCategoryRow.Properties.Caption:='Сценарий';
                                  71: tempTcxCategoryRow.Properties.Caption:='Функция';
                                  72: tempTcxCategoryRow.Properties.Caption:='Параметры';

                                  78: tempTcxCategoryRow.Properties.Caption:='Материалы';
                                  80: tempTcxCategoryRow.Properties.Caption:='Аргументы';
                                  93: tempTcxCategoryRow.Properties.Caption:='Сценарии';
                                  94: tempTcxCategoryRow.Properties.Caption:='Ограничения';

                                  107: tempTcxCategoryRow.Properties.Caption:='Параметры частиц';
                                  114: tempTcxCategoryRow.Properties.Caption:='Параметры подложки';
                                  125: tempTcxCategoryRow.Properties.Caption:='Параметры покрытия';
                                  128: tempTcxCategoryRow.Properties.Caption:='Построение шлифов';
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
