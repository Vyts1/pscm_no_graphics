program Project1;

{$APPTYPE CONSOLE}

//uses
//  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//  Dialogs, Menus, XPMan, ComCtrls, ExtCtrls, StdCtrls, cxStyles,
//  cxGraphics, cxEdit, cxDropDownEdit, cxVGrid, cxControls,
//  cxInplaceContainer, ImgList, cxTextEdit, cxImageComboBox, cxImage,
//  cxShellComboBox, cxCurrencyEdit, cxCheckBox, dxSkinsCore,
//  dxSkinsDefaultPainters, cxRadioGroup, Buttons, datamoduleDB, math, OpenGL, DGLUT,
//  DateUtils, ConvUtils, cxVGridViewInfo, Types, db_form, MyIni, JPEG;

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  datamoduleDB,
  math,
  OpenGL,
  DGLUT,
  DateUtils,
  ConvUtils,
  Types,
  MyIni,
  JPEG,
  const in 'const.pas';

{$I 'const.pas'}

type
  TForm1 = class(TForm)
//    MainMenu1: TMainMenu;
//    StatusBar1: TStatusBar;
//    XPManifest1: TXPManifest;
//    PageControl1: TPageControl;
//    UpPanel: TPanel;
//    LeftPanel: TPanel;
//    CenterPanel: TPanel;
//    A1: TMenuItem;
//    N1: TMenuItem;
//    N2: TMenuItem;
//    N3: TMenuItem;
//    Mode1: TTabSheet;
//    Mode2: TTabSheet;
//    Mode3: TTabSheet;
//    cxVerticalGrid1: TcxVerticalGrid;
//    cxVerticalGrid2: TcxVerticalGrid;
//    cxVerticalGrid3: TcxVerticalGrid;
//    Mode4: TTabSheet;
//    Mode5: TTabSheet;
//    cxVerticalGrid4: TcxVerticalGrid;
//    cxVerticalGrid5: TcxVerticalGrid;
//    Button1: TButton;
//    Button2: TButton;
//    Button3: TButton;
//    Button4: TButton;
//    Button5: TButton;
//    BitBtn1: TBitBtn;
//    Timer1: TTimer;
//    BitBtn2: TBitBtn;
//    BitBtn3: TBitBtn;
//    BitBtn4: TBitBtn;
//    BitBtn5: TBitBtn;
//    BitBtn6: TBitBtn;
//    BitBtn7: TBitBtn;
//    BitBtn8: TBitBtn;
//    BitBtn9: TBitBtn;
//    BitBtn10: TBitBtn;
//    BitBtn11: TBitBtn;
//    BitBtn12: TBitBtn;
//    BitBtn13: TBitBtn;
//    BitBtn14: TBitBtn;
//    BitBtn15: TBitBtn;
//    BitBtn16: TBitBtn;
//    AutostartTimer: TTimer;
  end;


{$I 'type.pas'}
{$I 'cover\types2.pas'}
{$I 'var.pas'}
{$I 'cover\var_global.pas'}
  tmpD, tmpD1, tmpD2 : real;
  scen:integer;
  h:real;
  absolut_max_velos:real;

  
  tempimage:TBitmap;
  tempstr:string;
  t:integer;
  ipos:integer;


{$I 'cover\functions.pas'}
//{$I 'cover\DrawCoating.pas'}





function FloatIsNorm(f:real):boolean;
begin
 result :=  NOT ((IsNaN(f) or IsInfinite(f)));
end;





procedure ReadINI();
var r, r2:real;
    tempmat: Tmaterial;
begin
 // Считать данные из INI файла

 SetFile('config.ini');

 // Скрыть в конфигах
 //---------------------------------------------------------------------------------------
 logfile := ReadIniData('system', 'logfile', 'program.log');
 iniVar.logfilenum := 0;
 iniVar.logstrnum := 0;
 //---------------------------------------------------------------------------------------
 iniVar.file_rez := ReadIniData('system', 'fileresult', 'rez');
 //---------------------------------------------------------------------------------------
 iniVar.csv_dump_file:=ReadIniData('system', 'csv_dump', 'file.csv');
 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.krp:=ReadIniDataReal ('k', 'krp', 1);    //
 log ('Коэф. центральной части сплэта равен (k):Rцентра=Rp*k; k=' + floattostr(iniVar.krp) );
 //---------------------------------------------------------------------------------------
 iniVar.koef_provisaniya:=ReadIniDataReal ('k','koef_provisaniya', 1);
 log ('Коэф. провисания = '+floattostr(iniVar.koef_provisaniya));
 //---------------------------------------------------------------------------------------
 iniVar.koef_natek:=ReadIniDataReal ('k','koef_natek', 1);
 log ('Коэф. натекания = '+floattostr(iniVar.koef_natek));
 //---------------------------------------------------------------------------------------
 iniVar.const_c0:=ReadIniDataReal ('k','c0', 2.00*1e-10);
 log ('Коэф. c0 = '+floattostr(iniVar.const_c0));
 //---------------------------------------------------------------------------------------
 iniVar.koef_mediani:=ReadIniDataReal ('k','koef_mediani', 0.004);
 log ('Угол наклона после которого начинается стекание = '+floattostr(iniVar.koef_mediani));
 //---------------------------------------------------------------------------------------


 iniVar.koef_9cheek:=ReadIniDataReal ('k','koef_9cheek', 1);
 log ('Ячейка для равномерного распределения  = '+floattostr(iniVar.koef_9cheek));

 //---------------------------------------------------------------------------------------
 iniVar.koef_w := ReadIniDataReal ('k','koef_w', 0);
 log ('Коэф. w = '+floattostr(iniVar.koef_w)+'');
 //---------------------------------------------------------------------------------------
 iniVar.div2 := ReadIniDataInt('k', 'div', 1);

 //---------------------------------------------------------------------------------------
 razbieny_kuba := ReadIniDataInt('system', 'poligons', 100);

 //---------------------------------------------------------------------------------------
 iniVar.obrezat_k_ds:=ReadIniDataReal ('k', 'obrezat_k_ds', 1.5);    //
 //---------------------------------------------------------------------------------------


 if ReadIniDataInt('mode', 'polaya_chastica', 0) = 0
   then iniVar.polaya_chastica := false
   else iniVar.polaya_chastica := true;



 iniVar.metod_provisaniya := ReadIniDataInt('k', 'metod_provisaniya', 2);
 case iniVar.metod_provisaniya of
  1 : log ('Тип расчета провисания: Up/*');
  2 : log ('Тип расчета провисания: (Up/*)^2');
  3 : log ('Тип расчета провисания: через c1, c0');
 end;

 iniVar.up_divizor:=ReadIniDataReal ('k', 'up_divizor', 0);    //
 if iniVar.up_divizor = 0 then
                             log ('Провисание без коэф Up/*** ')
                          else
                             log ('Коэф провисания будет Up/'+floattostr(iniVar.up_divizor)+'');


 iniVar.sloev_v_shlife := ReadIniDataInt('slise', 'sloev_v_shlife', 5);

 if ReadIniDataInt('mode', 'sdvigspletov', 0)=1 then iniVar.sdvigspleta:=true
                                                else iniVar.sdvigspleta:=false;


 iniVar.SplatType := ReadIniDataInt('init', 'splattype', 0);

 case iniVar.SplatType of
   0 : log ('Сплэты в виде цилиндра');
   1 : log ('Сплэты с гладкой поверхностью');
 end;


 if iniVar.sdvigspleta then log ('Сплэты будут сдвигаться (медианный фильтр и т.д.)')
                       else log ('Сплэты НЕ будут сдвигаться (медианный фильтр и т.д.)');


 iniVar.noise:=ReadIniDataReal ('mode', 'noise_fild', 0);    //
 
 if iniVar.noise = 0 then
                             log ('Шума на поверхности нет ')
                          else
                             log ('Шум на поверхности будет '+floattostr(iniVar.noise)+' мкм');



 iniVar.stoh := ReadIniDataInt ('system', 'stoh', 0);


 //---------------------------------------------------------------------------------------
 iniVar.k3mode := ReadIniDataInt('mode', 'k3mode', 0);
 //---------------------------------------------------------------------------------------
 iniVar.sloev:=ReadIniDataInt ('mode','sloev', 40); //максимальное число слоев может быть..
 //---------------------------------------------------------------------------------------
 iniVar.el_max:=ReadIniDataInt ('mode','el_max', iniVar.sloev); //максимальное число эл в массиве может быть
 log ('В очереди может быть: '+inttostr(iniVar.el_max)+' элементов по высоте.');
 //---------------------------------------------------------------------------------------


 if ReadIniDataInt ('mode','random_on', 0)<>0 then
  begin
    randomize;
  end;



 // Вынести в отдельное меню настроек!
 //---------------------------------------------------------------------------------------
 iniVar.tochekvdiskrete:=ReadIniDataInt ('mode','tochekvdiskrete', 2);
 iniVar.tochekvdiskrete2:=ReadIniDataInt ('mode','tochekvdiskrete2', 2);
 iniVar.tochekvdiskretesvg:=ReadIniDataReal ('mode','tochekvdiskretesvg', 10);
 //---------------------------------------------------------------------------------------
 iniVar.colormode := ReadIniDataInt('mode','colormode', 0);
 case iniVar.colormode of
  0: log ('Режим отображения срезов: Центр и переф. однородные по цвету.');
  1: log ('Режим отображения срезов: Центр и переф. разные по цвету.');
 end;
 //---------------------------------------------------------------------------------------




end;

{$I 'cover\GeneratinCoating.pas'}

{$I 'func\convertX.pas'}
//{$I 'func\AltAdd.pas'}
//{$I 'func\MakeMDArrayElement.pas'}
//{$I 'func\ShowMessage2.pas'}
{$I 'func\strto.pas'}


{$I 'splat\CCutBoxSet.pas'}
{$I 'splat\CCalculations.pas'}
{$I 'splat\GetRealFunctionValue.pas'}






//function GetMD11Index(code:integer):integer;
//var i,val:integer;
//begin
//
//  val := -1;
//
//  for i:=1 to count_md_items do
//    begin
//      if MD11Array[i].codenum = code then
//         begin
//           val := i;
//         end;
//    end;
//
//  if val < 1 then
//    begin
//      ShowMessage('Неизвестный индекс: '+inttostr(code));
//      Application.Terminate;
//    end else GetMD11Index:=val;
//
//end;







begin
  //m_calc:=CCalculations.Create;
  //{$I 'splat\init.pas'}
  //{$I 'Init_MD.pas'}
  iniVar.part_class:=CCutBoxSet.Create;
  iniVar.sub_class:=CCutBoxSet.Create;
  iniVar.inc_class:=CCutBoxSet.Create;

  ReadINI ();
  iniVar.first_time := 0;


  
  iniVar.dpmin_abs := 55;
  iniVar.dpmax_abs := 55;
  iniVar.temp_patic_min := 1360;
  iniVar.temp_patic_max := 1360;
  iniVar.velos_min := 400;
  iniVar.velos_max := 400;
  iniVar.temp_base := 400;
  iniVar.fild_size_X := 500;
  iniVar.fild_size_Y := 500;
  iniVar.diskret_x := 1.0;
  iniVar.a1 := 38;
  iniVar.a2 := 70;
  iniVar.a3 := 20;
  iniVar.a4 := 2;
  iniVar.a5 := 2;
  iniVar.kol_spletov := round(0);
  iniVar.coat := 300;
  iniVar.srez_interval := round(10);
  iniVar.VolCon := 0.05;
  iniVar.incmat := 51; // материал включений
  iniVar.basemat := 16; // материал подложки
  iniVar.modefild := 0; // форма подложки
  iniVar.partmat := 2; // материал частицы
  iniVar.sposob_vvoda := 0;
  iniVar.tip_materiala := 2; // формула
  iniVar.is_col := false; // ограничение по толщине покрытия
  iniVar.formula := 1; // вязкость
  iniVar.koef_9cheek := 0.5;
  

  iniVar.part_class.m_nId := 3;
  iniVar.part_class.m_Material := 'Cu';
  iniVar.part_class.m_ROms := 8940;
  iniVar.part_class.m_ROml := 8000;
  iniVar.part_class.m_CPms := 385;
  iniVar.part_class.m_CPml := 545;
  iniVar.part_class.m_Lms := 401;
  iniVar.part_class.m_Lml := 175;
  iniVar.part_class.m_Tm := 1357;
  iniVar.part_class.m_TBoil := 2833;
  iniVar.part_class.m_Lm := 208000;
  iniVar.part_class.m_MUml := 0.00529999984428287;
  iniVar.part_class.m_SIGml := 1.28499996662139;
  iniVar.part_class.m_LBoil := 4820000;
  iniVar.part_class.m_AW := 63.5;

  iniVar.inc_class.m_nId := 52;
  iniVar.inc_class.m_Material := 'Cu2O';
  iniVar.inc_class.m_ROms := 6100;
  iniVar.inc_class.m_ROml := 6000;
  iniVar.inc_class.m_CPms := 430;
  iniVar.inc_class.m_CPml := 440;
  iniVar.inc_class.m_Lms := 1.10000002384185;
  iniVar.inc_class.m_Lml := 1;
  iniVar.inc_class.m_Tm := 1505;
  iniVar.inc_class.m_TBoil := 2073;
  iniVar.inc_class.m_Lm := 448808.4375;
  iniVar.inc_class.m_MUml := 0.0599999986588955;
  iniVar.inc_class.m_SIGml := 0.5;
  iniVar.inc_class.m_LBoil := 10000000;
  iniVar.inc_class.m_AW := 143.08999633789;

  iniVar.sub_class.m_nId := 17;
  iniVar.sub_class.m_Material := 'Steel45';
  iniVar.sub_class.m_ROms := 7826;
  iniVar.sub_class.m_ROml := 7600;
  iniVar.sub_class.m_CPms := 473;
  iniVar.sub_class.m_CPml := 708;
  iniVar.sub_class.m_Lms := 48;
  iniVar.sub_class.m_Lml := 26;
  iniVar.sub_class.m_Tm := 1553;
  iniVar.sub_class.m_TBoil := 3008;
  iniVar.sub_class.m_Lm := 276785;
  iniVar.sub_class.m_MUml := 0.00540000014007092;
  iniVar.sub_class.m_SIGml := 1.40999996662139;
  iniVar.sub_class.m_LBoil := 4500000;
  iniVar.sub_class.m_AW := 60;




  case iniVar.sposob_vvoda of
        0 : ;//классика
        1 : //одинаковые Dpmin-Dpmax
            begin
              iniVar.dpmax_abs := iniVar.dpmin_abs;
              iniVar.temp_patic_max := iniVar.temp_patic_min;
              iniVar.velos_max := iniVar.velos_min;
              iniVar.fild_size_Y := iniVar.fild_size_X;
            end;
  end;


  iniVar.coat:= iniVar.coat;
  iniVar.dp_stdiv := 0.15;
  iniVar.tp_stdiv := 0.15;
  iniVar.up_stdiv := 0.15;

  iniVar.dpmin_d:=round(iniVar.dpmin_abs/iniVar.diskret_x/2);
  iniVar.dpmax_d:=round(iniVar.dpmax_abs/iniVar.diskret_x/2);

  iniVar.razmeri_spleta_razbros:=iniVar.dpmax_d-iniVar.dpmin_d;

  iniVar.a1 := iniVar.a1 / iniVar.diskret_x;
  iniVar.a2 := iniVar.a2 / iniVar.diskret_x;
  iniVar.a3 := iniVar.a3 / iniVar.diskret_x;
  iniVar.a4 := iniVar.a4 / iniVar.diskret_x;
  iniVar.a5 := iniVar.a5 / iniVar.diskret_x;

  iniVar.a1d:= round (iniVar.a1);
  iniVar.a2d:= round (iniVar.a2);
  iniVar.a3d:= round (iniVar.a3);
  iniVar.a4d:= round (iniVar.a4);
  iniVar.a5d:= round (iniVar.a5);

  absolut_max_velos := iniVar.velos_max;


  //ShowMessage(floattostr(iniVar.part_class.m_Tm));
  //ShowMessage(floattostr(h));
  //ShowMessage(floattostr(iniVar.part_class.m_Tm));
  
  case iniVar.tip_materiala of
         1 : begin
               log ('Используем расчет по формеле оксидов');

               tmpD1 := -1;
               tmpD2 := -1;

               //Посчитаем как будет при НЕ забывании подложки
               advcalculator_oksid (false, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, h, -2);

               //Если оно нормальное, то запомним...
               if FloatIsNorm(iniVar.Ds_max_abs) AND FloatIsNorm(iniVar.h_max)
                then  tmpD1 := iniVar.Ds_max_abs
                else
                  begin
                    ShowMessage('Функция advcalculator вернула неопределенное значение и для режима без забывания подложки, первый сплэт мы сгенерить не сможем');
                    //Application.Terminate;
                  end;

               //Посчитаем как будет при забывании подложки
               advcalculator_oksid (true, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, h, -2);
               if FloatIsNorm(iniVar.Ds_max_abs) AND FloatIsNorm(iniVar.h_max)
                then  tmpD2 := iniVar.Ds_max_abs;


               if ((tmpD1>=0) and (tmpD2>=0) and (tmpD1 > tmpD2)) OR
                  ( (tmpD1>=0) and (tmpD2<0) )
               then
                  begin
                   //Посчитаем как будет при НЕ забывании подложки
                   advcalculator_oksid (false, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, h, -2);
                  end
               else
                  begin
                    if ((tmpD1>=0) and (tmpD2>=0) ) OR
                       ( (tmpD1<0) and (tmpD2>=0) )
                    then
                      begin
                       //Посчитаем как будет при забывании подложки
                       advcalculator_oksid (true, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, h, -2);
                      end
                    else
                      begin
                        ShowMessage('Функция advcalculator_mk5 вернула неопределенное значение и для режима с забыванием подложки и для режима без забывания подложки');
                        //Application.Terminate;
                      end;
                  end;

             end;
         2 : begin
               log ('Используем расчет по формуле металлокерамики');


               tmpD1 := -1;
               tmpD2 := -1;

               //Посчитаем как будет при НЕ забывании подложки
               advcalculator_metKer (false, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.inc_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, iniVar.VolCon, iniVar.formula, h, -2);

               //Если оно нормальное, то запомним...
               if FloatIsNorm(iniVar.Ds_max_abs) AND FloatIsNorm(iniVar.h_max)
                then  tmpD1 := iniVar.Ds_max_abs
                else
                  begin
                    ShowMessage('Функция advcalculator вернула неопределенное значение и для режима без забывания подложки, первый сплэт мы сгенерить не сможем');
                    Application.Terminate;
                  end;

               //Посчитаем как будет при забывании подложки
               advcalculator_metKer (true,  iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.inc_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, iniVar.VolCon, iniVar.formula, h, -2);
               if FloatIsNorm(iniVar.Ds_max_abs) AND FloatIsNorm(iniVar.h_max)
                then  tmpD2 := iniVar.Ds_max_abs;


               if ((tmpD1>=0) and (tmpD2>=0) and (tmpD1 > tmpD2)) OR
                  ( (tmpD1>=0) and (tmpD2<0) )
               then
                  begin
                   //Посчитаем как будет при НЕ забывании подложки
                   advcalculator_metKer (false, iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.inc_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, iniVar.VolCon, iniVar.formula, h, -2);
                  end
               else
                  begin
                    if ((tmpD1>=0) and (tmpD2>=0) ) OR
                       ( (tmpD1<0) and (tmpD2>=0) )
                    then
                      begin
                       //Посчитаем как будет при забывании подложки
                       advcalculator_metKer (true,  iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, absolut_max_velos, iniVar.part_class, iniVar.inc_class, iniVar.sub_class, iniVar.h_max, iniVar.Ds_max_abs, scen, iniVar.VolCon, iniVar.formula, h, -2);
                      end
                    else
                      begin
                        ShowMessage('Функция advcalculator вернула неопределенное значение и для режима с забыванием подложки и для режима без забывания подложки');
                        Application.Terminate;
                      end;
                  end;

             end;
  end;




  
  iniVar.Ds_max_abs:=iniVar.Ds_max_abs*1000000;
  iniVar.h_max:=iniVar.h_max*1000000;

  if iniVar.Ds_max_abs < GetJRs (iniVar.h_max, iniVar.dpmax_abs/2)*2  then
    begin
      log ('Иордановкий Rs побольше будет');
      iniVar.Ds_max_abs := GetJRs (iniVar.h_max, iniVar.dpmax_abs/2)*2;
    end;

  iniVar.Ds_max_abs:=iniVar.Ds_max_abs*1.2;

  iniVar.Ds_max_d := round (iniVar.Ds_max_abs / iniVar.diskret_x) + 1;
  vrb.max_radius := (iniVar.Ds_max_d div 2) + 1;



  iniVar.obrezka := upround (iniVar.Ds_max_d * iniVar.obrezat_k_ds);
  if (iniVar.obrezka > iniVar.fild_size_X * 0.15) OR
    (iniVar.obrezka > iniVar.fild_size_Y * 0.15)
  then
    begin
      log ('Защита от большой обрезки по краям было: ' + inttostr(iniVar.obrezka) + ' дск, это сильно много');

      iniVar.obrezka := min (  round (iniVar.fild_size_X * 0.15),
                                round (iniVar.fild_size_Y * 0.15));
    end;


  iniVar.noise := iniVar.noise / iniVar.diskret_x;

      // Для тестового режима можно закоментировать:
  //if (iniVar.fild_size_X < iniVar.Ds_max_abs*1) OR
  //       (iniVar.fild_size_Y < iniVar.Ds_max_abs*1)
  //  then
  //    begin
  //      ShowMessage ('Поле сильно маленькое, даже сплэт может не влезть');
  //
  //      log ('!!!! Поле было слишком мало по отношению к размерам сплэта. Мы его увеличили.');
  //      if (iniVar.fild_size_X < iniVar.Ds_max_abs*5) then iniVar.fild_size_X:=iniVar.Ds_max_abs*5;
  //      if (iniVar.fild_size_Y < iniVar.Ds_max_abs*5) then iniVar.fild_size_Y:=iniVar.Ds_max_abs*5;
  //      log ('Теперь fild_size_x:='+floattostr(iniVar.fild_size_X)+'  fild_size_y:='+floattostr(iniVar.fild_size_Y));
  //    end;



  // Тогда массивы должны быть...  посчитать вручную лучше преувеличить !!!!  <--
  iniVar.fild_size_x_d := round(iniVar.fild_size_X / iniVar.diskret_x) + 6 ;
  iniVar.fild_size_y_d := round(iniVar.fild_size_Y / iniVar.diskret_x) + 6 ;


  if inivar.sloev_v_shlife < 2 then inivar.sloev_v_shlife:=2;

  if iniVar.is_col then log ('Ограничение по количеству сплэтов')
                                 else log ('Ограничение по толщине покрытия');

  log ('Tb='+floattostr(iniVar.temp_base)+' К');
  log ('Tp_min='+floattostr(iniVar.temp_patic_min)+' К');
  log ('Tp_max='+floattostr(iniVar.temp_patic_max)+' К');
  log ('up_min='+floattostr(iniVar.velos_min)+' м/с');
  log ('up_max='+floattostr(iniVar.velos_max)+' м/с');
  log ('Шаг сетки dx='+floattostr(iniVar.diskret_x)+' мкм');
  log ('Толщина покрытия должна быть ='+floattostr(iniVar.coat)+' мкм. Или ' + floattostr(iniVar.coat / iniVar.diskret_x) + ' дискрет');
  log ('Dp='+floattostr(iniVar.dpmin_abs)+' - '+floattostr(iniVar.dpmax_abs)+' мкм.   (это разброс диаметров частиц)');
  log ('Rp='+inttostr(iniVar.dpmin_d)+' - '+inttostr(iniVar.dpmax_d)+' дискрет. (это разброс радиусов частиц в дискретах)');

  case iniVar.rejim_nijnego_osnovaniya of
    0: log ('Нижнее основание сплэта будет браться из опорного массива');
    1: log ('Нижнее основание сплэта будет браться из сплайна');
  end;

  case iniVar.modefild of
    0:
      begin
        log ('Подложка - идеально шлифованная. modefild=0');
      end;

    1:
      begin
        log ('Подложка - в виде прямоугольных паттернов. modefild=1');
        log ('Длинна (по X) '+ floattostr(iniVar.a1) + ' мкм или ' + inttostr(iniVar.a1d) + ' дискрет.');
        log ('Длинна (по Y) '+ floattostr(iniVar.a2) + ' мкм или ' + inttostr(iniVar.a2d) + ' дискрет.');
        log ('Высота '+ floattostr(iniVar.a3*iniVar.diskret_x) + 'мкм, или ' + floattostr(iniVar.a3) + ' дискрет.');
        log ('Интервал по X '+ floattostr(iniVar.a4) + ' мкм или ' + inttostr(iniVar.a4d) + ' дискрет.');
        log ('Интервал по Y '+ floattostr(iniVar.a5) + ' мкм или ' + inttostr(iniVar.a5d) + ' дискрет.');
      end;

  end;

  log ('Максимальный диаметр сплэта ='+floattostr(iniVar.Ds_max_abs)+' мкм или '+floattostr(iniVar.Ds_max_d)+' дискрет');
  log ('Максимальный радиус  сплэта ='+inttostr(vrb.max_radius)+' дискрет.');
  log ('По краям обрежут: ='+inttostr(iniVar.obrezka)+' дискрет.');

  log ('Размеры поля fild_size_x:='+floattostr(iniVar.fild_size_X)+'  fild_size_y:='+floattostr(iniVar.fild_size_Y)+ ' мкм');
  log ('Размеры поля fild_size_x:='+inttostr(iniVar.fild_size_x_d)+'  fild_size_y:='+inttostr(iniVar.fild_size_y_d)+ ' дискрет');

  log ('С учетом обрезки X будет от '+inttostr(iniVar.obrezka)+' до '+inttostr(iniVar.fild_size_x_d-iniVar.obrezka)+ ' дискрет.');
  log ('С учетом обрезки Y будет от '+inttostr(iniVar.obrezka)+' до '+inttostr(iniVar.fild_size_y_d-iniVar.obrezka)+ ' дискрет.');

  log ('Будет уложено: '+inttostr(iniVar.kol_spletov)+' сплэтов.');

  

  iniVar.first_time := iniVar.first_time + 1;
  DateTimeToString( vrb.start_timestamp, 'yyyy_mm_dd__hh_nn_ss', now);

  GenerateCoatingNew();





  //Writeln('Hello, World!');
  //Readln;
end.
