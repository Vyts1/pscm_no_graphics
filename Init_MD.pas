  ScenArray[0].imgfile:='img\scen\1_small.bmp';
  ScenArray[1].imgfile:='img\scen\2_small.bmp';
  ScenArray[2].imgfile:='img\scen\3_small.bmp';
  ScenArray[3].imgfile:='img\scen\4_small.bmp';
  ScenArray[0].RU:='Растекание и одновременное затвердевание частицы на поверхности твердой подложки и последующее охлаждение сплэта';
  ScenArray[1].RU:='Растекание, одновременное затвердевание капли и подплавление подложки в пятне контакта ее с частицей с последующим затвердеванием подплавленного слоя и охлаждением системы сплэт-основа';
  ScenArray[2].RU:='Полное растекание капли на твердой основе и последующее охлаждение и затвердевание слоя расплава с одновременным возможным его сворачиванием под действием сил поверхностного натяжения';
  ScenArray[3].RU:='Полное растекание капли с одновременным подплавлением основы, последующее охлаждение и затвердевание растекшейся капли и образовавшегося приповерхностного слоя расплава';
  ScenArray[0].EN:='-----';
  ScenArray[1].EN:='-----';
  ScenArray[2].EN:='-----';
  ScenArray[3].EN:='-----';

  PetArray[0].imgfile:='img\pet\42_0.bmp';
  PetArray[1].imgfile:='img\pet\42_1.bmp';
  PetArray[2].imgfile:='img\pet\42_2.bmp';
  PetArray[0].Index:=-1;
  PetArray[1].Index:=-1;
  PetArray[2].Index:=-1;

  ArgArray[0].imgfile:='img\arg\58_0.bmp';
  ArgArray[1].imgfile:='img\arg\58_1.bmp';
  ArgArray[2].imgfile:='img\arg\58_2.bmp';
  ArgArray[3].imgfile:='img\arg\58_3.bmp';
  
  ArgArray[0].Index:=-1;
  ArgArray[1].Index:=-1;
  ArgArray[2].Index:=-1;
  ArgArray[3].Index:=-1;


  LHArray[0].imgfile:='img\lh\l.bmp';
  LHArray[1].imgfile:='img\lh\h.bmp';
  LHArray[0].Index:=-1;
  LHArray[1].Index:=-1;


  MD3Array[0]:=MakeMD3ArrayElement('img\md3_combo\60.bmp',  'Безразмерная толщина сплэта', '', true);
  MD3Array[1]:=MakeMD3ArrayElement('img\md3_combo\61.bmp',  'Безразмерный диаметр сплэта', '', true);
  MD3Array[2]:=MakeMD3ArrayElement('img\md3_combo\62.bmp',  'Безразмерная толщина подплавленного слоя', '', false);
  MD3Array[3]:=MakeMD3ArrayElement('img\md3_combo\63.bmp',  'Средняя скорость охлаждения капли при формировании сплэта', '', true);
  MD3Array[4]:=MakeMD3ArrayElement('img\md3_combo\64.bmp',  'Среднее расстояние между первичными осями дендритов при формировании сплэта', '', true);
  MD3Array[5]:=MakeMD3ArrayElement('img\md3_combo\68.bmp',  'Среднее расстояние между вторичными осями дендритов при формировании сплэта', '', true);
  MD3Array[6]:=MakeMD3ArrayElement('img\md3_combo\71.bmp',  'Скорость движения поверхности раздела твердое - жидкое (фронта затвердевания)', '', true);
  MD3Array[7]:=MakeMD3ArrayElement('img\md3_combo\72.bmp',  'Константа затвердевания', '', true);
  MD3Array[8]:=MakeMD3ArrayElement('img\md3_combo\73.bmp',  'Константа характеризующаяя скорость плавления подложки', '', false);
  MD3Array[9]:=MakeMD3ArrayElement('img\md3_combo\74.bmp',  'Температура в контакте', '', true);
  MD3Array[10]:=MakeMD3ArrayElement('img\md3_combo\75.bmp', 'Осредненная плотность теплового потока от капли в подложку в процессе формирования сплэта', '', true);
  MD3Array[11]:=MakeMD3ArrayElement('img\md3_combo\76.bmp', 'Размерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', '', true);
  MD3Array[12]:=MakeMD3ArrayElement('img\md3_combo\77.bmp', 'Относительная прочность сцепления', '', true);
  MD3Array[13]:=MakeMD3ArrayElement('img\md3_combo\78.bmp', 'Безразмерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', '', true);

  //-------------------------------------------------------------------------------------------------------------------------------
  //                                        ПРОСТРАНСТВО  1
  //-------------------------------------------------------------------------------------------------------------------------------
  //MakeMD11ArrayElement2 (кодовый номер, номер VerticalGrid, имя картинки рус, англ, подпись рус, англ, Real, Integer, Boolean, Тип ячейки)
  //function MakeMD11ArrayElement2 (codenum:integer; numVertGrid: integer; filenameRU, filenameEN, RU, EN:string; R:real; I:integer; B:boolean; tp:byte)  :TMD11Array;

  t:=1;

  MD11Array[t]:=MakeMD11ArrayElement2(1, 1, 'none', 'none', 'Материал частицы', 'Particle Material', 0, 3, false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(2, 1, 'img\md1_1\02.bmp', 'img\md1_1\02.bmp', 'Минимальная температура частицы, К', 'Minimal droplet tempre, K', 1730, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(3, 1, 'img\md1_1\03.bmp', 'img\md1_1\03.bmp', 'Максимальная температура частицы, К', 'Maximal droplet tempre, K', 3000, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(4, 1, 'img\md1_1\04_1.bmp', 'img\md1_1\04_2.bmp', 'Минимальная скорость частицы, м/с', 'Minimal droplet velosity, m/s', 75, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(5, 1, 'img\md1_1\05_1.bmp', 'img\md1_1\05_2.bmp', 'Максимальная скорость частицы, м/с', 'Maximal droplet velosity, m/s', 200, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(6, 1, 'img\md1_1\06_1.bmp', 'img\md1_1\06_2.bmp', 'Минимальный диаметр частицы , мкм', 'Minimal droplet size, mm', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(7, 1, 'img\md1_1\07_1.bmp', 'img\md1_1\07_2.bmp', 'Максимальный диаметр частицы , мкм', 'Maximal droplet size, mm', 40, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(8, 1, 'none', 'none', 'Материал подложки', 'Substrate Material', 0, 2, false, 0); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (9, 1, 'img\md1_1\09.bmp', 'img\md1_1\09.bmp', 'Минимальная температура подложки, К', 'Minimal particle temperature, K', 300, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(10, 1, 'img\md1_1\10.bmp', 'img\md1_1\10.bmp', 'Максимальная температура подложки, К', 'Maximal particle temperature, K', 500, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(11, 1, 'none', 'none', 'Номер Сценария ', 'Scenario nember', 0, 0, false, 2); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (12, 1, 'img\md1_2\12.bmp', 'img\md1_2\12.bmp', 'безразмерная толщина сплэта', 'unsizeable splat height', 0.1, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (13, 1, 'img\md1_2\13.bmp', 'img\md1_2\13.bmp', 'безразмерный диаметр сплэта', 'unsizeable splat diametr', 2.582, 0, false, 3); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (14, 1, 'img\md1_2\14.bmp', 'img\md1_2\14.bmp', 'критическая безразмерная толщина сплэта', 'critical unsizeable splat height', 0.041, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (15, 1, 'img\md1_2\15.bmp', 'img\md1_2\15.bmp', 'критический безразмерный диаметр сплэта', 'critical unsizeable splat diametr', 4.032, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (16, 1, 'img\md1_2\16_1.bmp', 'img\md1_2\16_2.bmp', 'размерная толщина сплэта, мкм', 'sizeable splat height', 0, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (17, 1, 'img\md1_2\17_1.bmp', 'img\md1_2\17_2.bmp', 'размерный диаметр сплэта, мкм', 'sizeable splat diametr', 0, 0, false, 3); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (18, 1, 'img\md1_2\18.bmp', 'img\md1_2\18.bmp', 'Критерий Фурье - безразмерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', 'Furie criterious', 0.01, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (19, 1, 'img\md1_2\19_1.bmp', 'img\md1_2\19_2.bmp', 'Размерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', 'sizable time', 1, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (20, 1, 'img\md1_2\20.bmp', 'img\md1_2\20.bmp', 'Безразмерная температура в точке контакта', 'Unsizable impact point temp', 0.5, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (21, 1, 'img\md1_2\21.bmp', 'img\md1_2\21.bmp', 'Размерная температура в точке контакта, К', 'Impact point temp, K', 1200, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (22, 1, 'img\md1_2\22_1.bmp', 'img\md1_2\22_2.bmp', 'Скорость охлаждения, К/с', 'Cold velosity, K/s', 1E7, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (23, 1, 'img\md1_2\23.bmp', 'img\md1_2\23.bmp', 'Критическое значение числа Фурье', 'Critical value Fure number', 1, 1, false, 3); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (24, 1, 'img\md1_2\24.bmp', 'img\md1_2\24.bmp', 'Отношение относительной прочности соединения отвечающаяя реальным параметрам к теоретически возможной', 'unknow1', 1.0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (25, 1, 'img\md1_2\25.bmp', 'img\md1_2\25.bmp', 'Относительная прочность соединения отвечающаяя реальным параметрам', 'unknow1', 0.5, 0, false, 3); t:=t+1;

  //-------------------------------------------------------------------------------------------------------------------------------
  //                                       ЧУВСТВИТЕЛЬНОСТЬ
  //-------------------------------------------------------------------------------------------------------------------------------

  MD11Array[t]:=MakeMD11ArrayElement2(26, 2, 'none', 'none', 'Материал частицы', 'Particle Material', 0, 3, false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(27, 2, 'img\md1_1\02.bmp', 'img\md1_1\02.bmp', 'Минимальная температура частицы, К', 'Minimal droplet tempre, K', 1730, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(28, 2, 'img\md1_1\03.bmp', 'img\md1_1\03.bmp', 'Максимальная температура частицы, К', 'Maximal droplet tempre, K', 3000, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(29, 2, 'img\md1_1\04_1.bmp', 'img\md1_1\04_2.bmp', 'Минимальная скорость частицы, м/с', 'Minimal droplet velosity, m/s', 75, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(30, 2, 'img\md1_1\05_1.bmp', 'img\md1_1\05_2.bmp', 'Максимальная скорость частицы, м/с', 'Maximal droplet velosity, m/s', 200, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(31, 2, 'img\md1_1\06_1.bmp', 'img\md1_1\06_2.bmp', 'Минимальный диаметр частицы , мкм', 'Minimal droplet size, mm', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(32, 2, 'img\md1_1\07_1.bmp', 'img\md1_1\07_2.bmp', 'Максимальный диаметр частицы , мкм', 'Maximal droplet size, mm', 40, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(33, 2, 'none', 'none', 'Материал подложки', 'Substrate Material', 0, 2, false, 0); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(34, 2, 'img\md1_1\09.bmp', 'img\md1_1\09.bmp', 'Минимальная температура подложки, К', 'Minimal particle temperature, K', 300, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(35, 2, 'img\md1_1\10.bmp', 'img\md1_1\10.bmp', 'Максимальная температура подложки, К', 'Maximal particle temperature, K', 500, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(36, 2, 'none', 'none', 'Номер Сценария ', 'Scenario nember', 0, 0, false, 2); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (37, 2, 'none', 'none', 'Прямая чувствительность', 'Sensetive', 0, 0, false, 4); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (38, 2, 'img\md2_2\38.bmp', 'img\md2_2\38.bmp', 'по высоте сплэта', 'by splat height', 0.041, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (39, 2, 'img\md2_2\39.bmp', 'img\md2_2\39.bmp', 'по диаметру сплэта', 'by splat diametr', 4.03, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (40, 2, 'img\md2_2\40.bmp', 'img\md2_2\40.bmp', '', '', 2, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (41, 2, 'img\md2_2\41.bmp', 'img\md2_2\41.bmp', '', '', 2, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (42, 2, 'img\md2_2\42.bmp', 'img\md2_2\42.bmp', '', '', 2, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (43, 2, 'none', 'none', 'Обратная чувствительность', 'Back Sensetive', 0, 0, false, 4); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2 (44, 2, 'img\md2_2\44.bmp', 'img\md2_2\44.bmp', '', '', 0.041, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (45, 2, 'img\md2_2\45.bmp', 'img\md2_2\45.bmp', '', '', 0.008, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (46, 2, 'img\md2_2\46.bmp', 'img\md2_2\46.bmp', '', '', 4.03, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (47, 2, 'img\md2_2\47.bmp', 'img\md2_2\47.bmp', '', '', 2400, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (48, 2, 'img\md2_2\48.bmp', 'img\md2_2\48.bmp', '', '', 400, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (49, 2, 'img\md2_2\49.bmp', 'img\md2_2\49.bmp', '', '', 400, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (50, 2, 'img\md2_2\50.bmp', 'img\md2_2\50.bmp', '', '', 2, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (51, 2, 'img\md2_2\51.bmp', 'img\md2_2\51.bmp', '', '', 2, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (52, 2, 'img\md2_2\52.bmp', 'img\md2_2\52.bmp', '', '', 1, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (53, 2, 'none', 'none', 'Выч.значение', '', 0, 2, false, 5); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2 (54, 2, 'none', 'none', 'Приблизителы', '', 0, 0, false, 6); t:=t+1;
  MD11Array[GetMD11Index(54)].visible:=false; // стран ное поле



  //-------------------------------------------------------------------------------------------------------------------------------
  //                                    КОРРЕЛЯЦИИ
  //-------------------------------------------------------------------------------------------------------------------------------

  MD11Array[t]:=MakeMD11ArrayElement2(55, 3, 'none', 'none', 'Материал частицы', 'Particle Material', 0, 0, false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(56, 3, 'none', 'none', 'Материал подложки', 'Substrate Material', 0, 2, false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(57, 3, 'img\md3\57.bmp', 'img\md3\57.bmp', 'Температура частиц', 'Particles tempr', 2000, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(58, 3, 'img\md3\58.bmp', 'img\md3\58.bmp', 'Минимальная температура часиц', 'Minimal particles temp', 1730, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(59, 3, 'img\md3\59.bmp', 'img\md3\59.bmp', 'Максимальная температура частиц', 'Maximal particles temp', 2100, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(60, 3, 'img\md3\60_1.bmp', 'img\md3\60_2.bmp', 'Скорость частиц', 'Particles velosity', 100, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(61, 3, 'img\md3\61_1.bmp', 'img\md3\61_2.bmp', 'Минимальная скорость часиц', 'Minimal particles velosity', 75, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(62, 3, 'img\md3\62_1.bmp', 'img\md3\62_2.bmp', 'Максимальная скорость частиц', 'Maximal particles velosity', 200, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(63, 3, 'img\md3\63_1.bmp', 'img\md3\63_2.bmp', 'Диаметр частиц', 'Particles diametr', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(64, 3, 'img\md3\64_1.bmp', 'img\md3\64_2.bmp', 'Минимальный диаметр частиц', 'Minimal particles diametr', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(65, 3, 'img\md3\65_1.bmp', 'img\md3\65_2.bmp', 'Максимальный диаметр частиц', 'Maximal particles diametr', 100, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(66, 3, 'img\md3\66.bmp', 'img\md3\66.bmp', 'Температура подложки', 'Substrate tempr', 400, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(67, 3, 'img\md3\67.bmp', 'img\md3\67.bmp', 'Минимальная температура подложки', 'Minimal Substrate Temp', 300, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(68, 3, 'img\md3\68.bmp', 'img\md3\68.bmp', 'Максимальная температура подложки', 'Maximal Substrate Temp', 500, 0, false, 1); t:=t+1;

  //Из за 69
  MD11Array[GetMD11Index(57)].visible:=false;
  MD11Array[GetMD11Index(61)].visible:=false;
  MD11Array[GetMD11Index(62)].visible:=false;
  MD11Array[GetMD11Index(64)].visible:=false;
  MD11Array[GetMD11Index(65)].visible:=false;
  MD11Array[GetMD11Index(67)].visible:=false;
  MD11Array[GetMD11Index(68)].visible:=false; //}

  MD11Array[t]:=MakeMD11ArrayElement2(69, 3, 'none', 'none', 'Аргумент', 'Argument', 0, 0, false, 7); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(70, 3, 'none', 'none', 'Сценарии', 'Scen', 0, 0, false, 2); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(71, 3, 'none', 'none', 'Функция', 'Function', 0, 0, false, 8); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(72, 3, 'none', 'none', 'Автор', 'Autor', 0, 0, false, 9); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(73, 3, 'img\md3\73.bmp', 'img\md3\73.bmp', 'const', '', 0.0152, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(74, 3, 'img\md3\74.bmp', 'img\md3\74.bmp', 'const', '', 0.72, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(75, 3, 'img\md3\75.bmp', 'img\md3\75.bmp', 'const', '', 0.26, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(76, 3, 'img\md3\76.bmp', 'img\md3\76.bmp', 'эмпирические', '', 1.09E-4, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(77, 3, 'img\md3\77.bmp', 'img\md3\77.bmp', 'эмпирические', '', 0.44, 0, false, 1); t:=t+1;


  MD11Array[GetMD11Index(73)].visible:=false;
  MD11Array[GetMD11Index(74)].visible:=false;
  MD11Array[GetMD11Index(75)].visible:=false;
  MD11Array[GetMD11Index(76)].visible:=false;
  MD11Array[GetMD11Index(77)].visible:=false;


  //-------------------------------------------------------------------------------------------------------------------------------
  //                                ПРОСТРАНСТВО  2
  //-------------------------------------------------------------------------------------------------------------------------------

  MD11Array[t]:=MakeMD11ArrayElement2(78, 4, 'none', 'none', 'Материал частиц', '', 0, 0, false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(79, 4, 'none', 'none', 'Материал подложки', '', 0, 2, false, 0); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(80, 4, 'img\md4\80.bmp', 'img\md4\80.bmp', 'Температура частиц', '', 2000, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(81, 4, 'img\md4\81.bmp', 'img\md4\81.bmp', 'Температура частиц минимальная', '', 1730, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(82, 4, 'img\md4\82.bmp', 'img\md4\82.bmp', 'Температура частиц максимальная', '', 2100, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(83, 4, 'img\md4\83_1.bmp', 'img\md4\83_2.bmp', 'Скорость частиц', '', 100, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(84, 4, 'img\md4\84_1.bmp', 'img\md4\84_2.bmp', 'Скорость частиц минимальная', '', 75, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(85, 4, 'img\md4\85_1.bmp', 'img\md4\85_2.bmp', 'Скорость частиц максимальная', '', 200, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(86, 4, 'img\md4\86_1.bmp', 'img\md4\86_2.bmp', 'Диаметр частиц', '', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(87, 4, 'img\md4\87_1.bmp', 'img\md4\87_2.bmp', 'Диаметр частиц минимальный', '', 40, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(88, 4, 'img\md4\88_1.bmp', 'img\md4\88_2.bmp', 'Диаметр частиц максимальный', '', 100, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(89, 4, 'img\md4\89.bmp', 'img\md4\89.bmp', 'Температура подложки', '', 400, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(90, 4, 'img\md4\90.bmp', 'img\md4\90.bmp', 'Температура подложки минимальная', '', 300, 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(91, 4, 'img\md4\91.bmp', 'img\md4\91.bmp', 'Температура подложки максимальная', '', 500, 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(92, 4, 'none', 'none', 'Аргумент', 'Argument', 0, 0, false, 7); t:=t+1;

  //Из за 92
  MD11Array[GetMD11Index(80)].visible:=false;
  MD11Array[GetMD11Index(84)].visible:=false;
  MD11Array[GetMD11Index(85)].visible:=false;
  MD11Array[GetMD11Index(87)].visible:=false;
  MD11Array[GetMD11Index(88)].visible:=false;
  MD11Array[GetMD11Index(90)].visible:=false;
  MD11Array[GetMD11Index(91)].visible:=false; //}

  MD11Array[t]:=MakeMD11ArrayElement2(93, 4, 'none', 'none', 'Сценарии', 'Scen', 0, 0, false, 2); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(94, 4, 'img\md4\94.bmp', 'img\md4\94.bmp', 'Безразмерная толщина сплэта', '', 0.1, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(95, 4, 'img\md4\95.bmp',  'img\md4\95.bmp',  'Безразмерный диаметр', '', 2.582, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(96, 4, 'img\md4\96.bmp', 'img\md4\96.bmp', 'Толщина подплавленного слоя', '', 0, 0, false, 3); t:=t+1;
  MD11Array[GetMD11Index(96)].visible:=false;

  MD11Array[t]:=MakeMD11ArrayElement2(97, 4, 'img\md4\97.bmp', 'img\md4\97.bmp', 'Критическая безразмерная толщина сплэта', '', 0.041, 1, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(98, 4, 'img\md4\98.bmp', 'img\md4\98.bmp', 'Критический безразмерный диаметр сплэта', '', 4.032, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(99, 4, 'img\md4\99_1.bmp', 'img\md4\99_2.bmp', 'Размерная толщина сплэта', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(100, 4, 'img\md4\100_1.bmp', 'img\md4\100_2.bmp', 'Размерный диаметр сплэта', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(101, 4, 'img\md4\101.bmp', 'img\md4\101.bmp', 'Критерий Фурье - безразмерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(102, 4, 'img\md4\102_1.bmp', 'img\md4\102_2.bmp', 'Размерное время встречи фронта затвердевания расплава с вершиной растекающейся капли', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(103, 4, 'img\md4\103.bmp', 'img\md4\103.bmp', 'Безразмерная температура в точке контакта', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(104, 4, 'img\md4\104.bmp', 'img\md4\104.bmp', 'Размерная температура в точке контакта', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(105, 4, 'img\md4\105.bmp', 'img\md4\105.bmp', 'Средняя скорость охлаждения капли при формировании сплэта', '', 0, 0, false, 3); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(106, 4, 'img\md4\106.bmp', 'img\md4\106.bmp', 'Относительная прочность соединения сплэта с подложкой', '', 0, 0, false, 3); t:=t+1;


  //-------------------------------------------------------------------------------------------------------------------------------
  //                                  ПОДСИСТЕМА "ПОКРЫТИЕ"
  //-------------------------------------------------------------------------------------------------------------------------------
  MD11Array[t]:=MakeMD11ArrayElement2(107, 5, 'none', 'none', 'Материал частицы', '', 0, ReadIniDataInt('init', 'pb', 25), false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(133, 5, 'none', 'none', 'Способ ввода', '', 0, ReadIniDataInt('init', 'sposob_vvoda', 0), false, 14); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(134, 5, 'none', 'none', 'Гистограмма', 'Histogram', 0, ReadIniDataInt('init', 'histogram', 0), false, 15); t:=t+1;
  MD11Array[GetMD11Index(134)].visible:=false;

  MD11Array[t]:=MakeMD11ArrayElement2(132, 5, 'none', 'none', 'Формула', '', 0, ReadIniDataInt('init', 'formula', 2), false, 13); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(131, 5, 'none', 'none', 'Вязкость' , '', 0, 1, false, 12); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(129, 5, 'none', 'none', 'Материал включений', '', 0, ReadIniDataInt('init', 'pi', 26), false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(130, 5, 'none', 'none', 'Объемная концентрация'     , '', ReadIniDataReal('init', 'volcon', 0.81), 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(108, 5, 'img\md4\87_1.bmp', 'img\md4\87_2.bmp', 'Диаметр частиц минимальный, мкм'     , '', ReadIniDataReal('init', 'dp1', 50), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(109, 5, 'img\md4\88_1.bmp', 'img\md4\88_2.bmp', 'Диаметр частиц максимальный, мкм'    , '', ReadIniDataReal('init', 'dp2', 50), 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(110, 5, 'img\md4\81.bmp', 'img\md4\81.bmp', 'Температура частиц минимальная, К' , '', ReadIniDataReal('init', 'tp', 2000), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(111, 5, 'img\md4\82.bmp', 'img\md4\82.bmp', 'Температура частиц максимальная, К', '', ReadIniDataReal('init', 'tp', 2000), 0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(112, 5, 'img\md4\84_1.bmp', 'img\md4\84_2.bmp', 'Скорость частиц минимальная, мс'   , '', ReadIniDataReal('init', 'up', 200), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(113, 5, 'img\md4\85_1.bmp', 'img\md4\85_2.bmp', 'Скорость частиц максимальная, мс'  , '', ReadIniDataReal('init', 'up', 200), 0, false, 1); t:=t+1;

  //-----------------
  MD11Array[t]:=MakeMD11ArrayElement2(114, 5, 'none', 'none', 'Материал подложки',                                        '',   0,  ReadIniDataInt('init', 'b', 16), false, 0); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(115, 5, 'img\md4\89.bmp', 'img\md4\89.bmp', 'Начальная температура подложки, К',  '', ReadIniDataInt('init', 'tb', 300),  0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(116, 5, 'img\md5\109.bmp', 'img\md5\109.bmp', 'Размеры подложки X, мкм',            '', ReadIniDataInt('init', 'x', 2000), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(117, 5, 'img\md5\110.bmp', 'img\md5\110.bmp', 'Размеры подложки Y, мкм',            '', ReadIniDataInt('init', 'y', 2000), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(118, 5, 'img\md5\112.bmp', 'img\md5\112.bmp', 'Шаг дискретизации, мкм',             '', ReadIniDataReal ('init', 'dx', 2.0),  0, false, 1); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(119, 5, 'none', 'none', 'Форма подложки', '', 0, ReadIniDataInt('init', 'fb', 0), false, 10); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(120, 5, 'none', 'none', 'Размер патерна по оси X, мкм', '', ReadIniDataReal ('init', 'a1', 4), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(121, 5, 'none', 'none', 'Размер патерна по оси Y, мкм', '', ReadIniDataReal ('init', 'a2', 4), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(122, 5, 'none', 'none', 'Высота патерна по оси Z, мкм', '', ReadIniDataReal ('init', 'a3', 1), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(123, 5, 'none', 'none', 'Интервал между патернами по оси X, мкм', '', ReadIniDataReal ('init', 'a4', 4), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(124, 5, 'none', 'none', 'Интервал между патернами по оси Y, мкм', '', ReadIniDataReal ('init', 'a5', 4), 0, false, 1); t:=t+1;

  MD11Array[GetMD11Index(120)].visible:=false;
  MD11Array[GetMD11Index(121)].visible:=false;
  MD11Array[GetMD11Index(122)].visible:=false;
  MD11Array[GetMD11Index(123)].visible:=false;
  MD11Array[GetMD11Index(124)].visible:=false;

  //-----------------
  MD11Array[t]:=MakeMD11ArrayElement2(125, 5, 'none', 'none', 'Отсчитывать толщину покрытия по', '', 0, ReadIniDataInt('init', 'exit', 0), false, 11); t:=t+1;

  MD11Array[t]:=MakeMD11ArrayElement2(126, 5, 'none', 'none', 'Кол-во частиц', '', ReadIniDataInt('init', 'kolvo', 1), 0, false, 1); t:=t+1;
  MD11Array[t]:=MakeMD11ArrayElement2(127, 5, 'none', 'none', 'Толщина покрытия, мкм', '', ReadIniDataInt('init', 'tolsh', 100), 0, false, 1); t:=t+1;

  if ReadIniDataInt('init', 'exit', 0) = 0 then MD11Array[GetMD11Index(126)].visible:=false
                                           else MD11Array[GetMD11Index(127)].visible:=false;



  MD11Array[t]:=MakeMD11ArrayElement2(128, 5, 'none', 'none', 'Интервал построения шлифов, дск', '', ReadIniDataInt('init', 'interval_shlifov', 100), 0, false, 1); t:=t+1;



 {
  //----------------------------------------------------------------------------
  КАК добавлять элемент в массив.
  Найти максимальный номер среди первого параметра, и добавить такую же строку,
  тольк с номером +1. Заполнить по образцу. Модернизировать константу count_md_items
  она должна быть равна номеру добавленного элемента
  Упорядочевание идет по порядку добавления, а работа по номеру внутри. в tag
  хранится порядковый номер элемента в массиве (отличается от первого параметра).

  Для добавления нового типа поля надо:
  1 открыть insert_editors и добавить туда в строку
  // Это часть создания правых частей едиторов в том числе и мультиедиторов.
     if (MD11Array[i].tip=0) OR (MD11Array[i].tip=1) OR (MD11Array[i].tip=2) OR (MD11Array[i].tip=5) OR (MD11Array[i].tip=6) OR (MD11Array[i].tip=7) OR (MD11Array[i].tip=8) OR (MD11Array[i].tip=9) OR (MD11Array[i].tip=10) OR (MD11Array[i].tip=11) OR (MD11Array[i].tip=12) then //<--- добавить всех кроме тройки!
   новый номер типа в конец
   и в case дописать его код
  2 OnEditGrid добавить в case к колегам, если надо написать в if обработчик
  3 ReadMenuItems добавить считывание по нажатию

  //----------------------------------------------------------------------------
 }

//  if t<>129 then showmessage ('Это не 129, это '+ inttostr(t));


  //-------------------------------------------------------------------------------------------------------------------------------





