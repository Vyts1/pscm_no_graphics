{$I 'cover\func\HPD2.pas'}  // металл
{$I 'cover\func\HPD4.pas'}  // Металлокерамика2
{$I 'cover\func\HPD5.pas'}  // Оксиды

{
Поле Описание
nId Порядковый номер материала в таблице
Material  Обозначение материала
ROms Плотность материала в твердом состоянии
ROml Плотность материала в жидком состоянии
CPms Теплоемкость материала в твердом состоянии
CPml Теплоемкость материала в жидком состоянии
Lms Теплопроводность материала в твердом состоянии
Lml Теплопроводность материала в жидком состоянии
Tm Температура плавления
TBoil Температура кипения
Lm Теплота плавления
AW Атомная единица массы
}


// Оксиды
procedure advcalculator_oksid (zabilipodlojku: boolean; Dp, Tpo, TB0, V:real;
                             partmat, basemat:CCutBoxSet;
                             var H :real; var Ds_vozvr:real; var scen:integer;
                             var glub_pronikn:real; SplatNum:integer);

var REGIME:integer;
    NAME : array [1..NMMAX] of string[8];
    NAMEP, NAMEB, NAMEPb, NAMEPi  : Integer;

    KEBP,KUPL,KUBS:Real;

    LPS,LPL,LP,MUPL,LBS,LBL,LB,MUBL, LPSEf,LPLEf,LGas:Real;
    LPSb,LPLb,LPb,MUPLb:Real;
    LPSi,LPLi,LPi,MUPLi:Real;
//C !!!! Если добавляются новые материалы, необходимо откорректировать
//C !!!! размерности массивов NAME(?), PROP(10,?) и переменную NMMAX

    PROP:array [1..NPMAX,1..NMMAX] of real;
    PROPP, PROPB, PROPPi, PROPPb :array [1..NPMAX] of real;

//------------------------------------------------------------------------------
    PI:real;

    Up, Tp  :real;

    TEMP0, Smax, FFact, RNUPL:real;
    i,j:integer;
    ROPS,ROPL,CPS,CPL,TPM,SIGMAP, LBOILP, AWP, ROBS,ROBL,CBS,CBL,TBM,SIGMAB, LBOILB, AWB: real;
    Tspl,TDspl,HP,HB,TK0,TK,
    RE,WE,PR,PE,FPB,CDZ,
    TP0, Tvisc, Tdnd, DS, DSD, HPD :real;
    Por, ROPSEf, ROPLEf, CPSEf,CPLEf, ROGas, CPGas:Real;
    ABS:real;

    REPART, WEBERP, ZETAM, ZETAMD, REPLUS, HPMD, HPJD, ZETAJD, ZETAC, HPCD,
    ZETACD, ZETAU, ZETAUD, HPUD:real;

    td : real;
    s:string;


label 50, 60, 70, 80, 90, 100;


begin
  log ('advcalculator_mk5');

 // {$INCLUDE  'cover\func\init_mat.pas'}

  Tp:=Tpo;
  TEMP0:=Tp;
  TP0 := Tp;
  // <- Материаллы !
//  NAMEPb:=ReadIniDataInt('met_cer', 'Pb', 21);
//  NAMEB :=ReadIniDataInt('met_cer', 'B', 16);
//  VolCon:=ReadIniDataReal ('met_cer', 'VolCon', 0.6);

  Por:=0;
  if zabilipodlojku
    then
      begin
        log ('Забыли подложку');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал подложки B такой же как частиц');
      end
    else
      begin
        log ('Еще помним подложку или просто не дошли до второй проверки');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал подложки B =' + inttostr(basemat.m_nId) + ' это ' + basemat.m_Material );
      end;

  Up:= V;

  //Si =11
{  i:=NAMEB;
  ROBS:=PROP[1,i];
  ROBL:=PROP[2,i];
  CBS:=PROP[3,i];
  CBL:=PROP[4,i];
  LBS:=PROP[5,i];
  LBL:=PROP[6,i];
  TBM:=PROP[7,i];
  LB:=PROP[8,i];
  MUBL:=PROP[9,i];
  SIGMAB:=PROP[10,i];
 }


 ROPS  :=partmat.m_ROms;
ROPL  :=partmat.m_ROml;
CPS   :=partmat.m_CPms;
CPL   :=partmat.m_CPml;
LPS   :=partmat.m_Lms;
LPL   :=partmat.m_Lml;
TPM   :=partmat.m_Tm;
LP    :=partmat.m_Lm;
MUPL  :=partmat.m_MUml;
SIGMAP:=partmat.m_SIGml;
LBOILP:=partmat.m_LBoil;
AWP   :=partmat.m_AW;

ROBS  :=basemat.m_ROms;
ROBL  :=basemat.m_ROml;
CBS   :=basemat.m_CPms;
CBL   :=basemat.m_CPml;
LBS   :=basemat.m_Lms;
LBL   :=basemat.m_Lml;
TBM   :=basemat.m_Tm;
LB    :=basemat.m_Lm;
MUBL  :=basemat.m_MUml;
SIGMAB:=basemat.m_SIGml;
LBOILB:=basemat.m_LBoil;
AWB   :=basemat.m_AW;



  if zabilipodlojku then
    begin
        ROBS := ROPS;
        ROBL := ROPL;
        CBS := CPS;
        CBL :=CPL;
        LBS := LPS;
        LBL := LPL;
        TBM := TPM;
        LB := LP;
        MUBL := MUPL;
        SIGMAB := SIGMAP;
        LBOILB:=LBOILP;
        AWB   :=AWP;
    end;


  if zabilipodlojku then
    begin // Забыли подложку, свойства принадлежат частице
        ROBS := ROPS;
        ROBL := ROPL;
        CBS := CPS;
        CBL :=CPL;
        LBS := LPS;
        LBL := LPL;
        TBM := TPM;
        LB := LP;
        MUBL := MUPL;
        SIGMAB := SIGMAP;
    end;


    S:= 'Св-ва частицы: 1 ROPS '+floattostr(ROPS)+';'   +
      '2 ROPL '+floattostr(ROPL)+';'  +
      '3 CPS '+floattostr(CPS)+';'   +
      '4 CPL '+floattostr(CPL)+';'  +
      '5 LPS '+floattostr(LPS)+';' +
      '6 LPL '+floattostr(LPL)+';' +
      '7 TPM '+floattostr(TPM)+';' +
      '8 LP '+floattostr(LP)+';' +
      '9 MUPL '+floattostr(MUPL)+';' +
      '10 SIGMAP '+floattostr(SIGMAP)+';';


    S:= s + '   Св-ва подложки: 1 ROBS '+floattostr(ROBS)+';'   +
      '2 ROBL '+floattostr(ROBL)+';'  +
      '3 CBS '+floattostr(CBS)+';'   +
      '4 CBL '+floattostr(CBL)+';'  +
      '5 LBS '+floattostr(LBS)+';' +
      '6 LBL '+floattostr(LBL)+';' +
      '7 TBM '+floattostr(TBM)+';' +
      '8 LB '+floattostr(LB)+';' +
      '9 MUBL '+floattostr(MUBL)+';' +
      '10 SIGMAB '+floattostr(SIGMAB)+';';

    log (S);

    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('');
        if (SplatNum = 1) then logreport ('Первый сплэт: '+S)
                          else logreport ('Сплэт с забыванием: '+S);
        logreport ('');
      end;




  //============================================================================

  HPB5
        (REGIME, Tspl, TDspl,HP,HB,TK0,TK,
        RE,WE,PR,PE,KEBP,KUPL,KUBS,FPB,CDZ,
        DP,UP,TP0,TB0,Vrb.Tc,
        ROPS,ROPL,CPS,CPL,LPS,LPL,TPM,LP,MUPL,SIGMAP,
        ROBS,ROBL,CBS,CBL,LBS,LBL,TBM,LB,MUBL,SIGMAB, SplatNum);



  IF ( REGIME=1) then
    begin

{      Td:=DP/UP;
      Tvisc:=DP*DP/RNUPL;
      Tdnd:=TDspl/Td;
      log ( 'Scenario=' + inttostr(REGIME));

      DS:=SQRT(2/(3*HP)); // ! Diameter of splat from balance of mass
      DSD:=DP*DS;
      HPD:=HP*DP;
      H:=HPD;
      Ds_vozvr:=DSD;

      ABS:=LBS/(ROBS*CBS);
      glub_pronikn := 4*sqrt(TDspl*ABS);


      log ('Computed dimensional diameter & thickness of splat');
      log ('    Ds,dim=' + floattostr(DSD) +' , mcm;   Hs,dim=' + floattostr(HPD) + ', mcm;');
      log ('Computed non-dimensional diameter & thickness of splat');
      log ('Ds,non-dim=' + floattostr(DS) + '      Hs,non-dim=' + floattostr(HP));
 }
       Td:=DP/UP;
      Tdnd:=TDspl/Td;
//      WRITELN ('--- Results characterizing the splat formation:---');
//      WRITELN ('Scenario=', REGIME                                 );
//      WRITELN ('Criterions: Re, We, Pr, Pe, Kebp, Kupl, Kubs, Fpb' );
//      WRITELN (             RE, WE, PR, PE, KEBP, KUPL, KUBS, FPB  );
//      WRITELN ('--- Temperature - time characteristics: ---'       );
//      WRITELN ('Characteristic time of droplet deformation Td='    );
//      WRITELN (       Td , ' second'                                );
//      WRITELN ('Dimensional time of splat formation Ts,dim='      );
//      WRITELN (       TDspl , ', second'                            );
//      WRITELN ('Non-dimensional time of splat formation Ts/Td='   );
//      WRITELN (       Tdnd                                         );
//      WRITELN ('Characteristic of the solidification rate Cdz='   );
//      WRITELN (       CDZ                                          );
//      WRITELN ('Contact temperature disregarding phase transitions');
//      WRITELN (      ' Tco=' , TK0, ' K'                            );
//      WRITELN ('Contact temperature regarding phase transitions'  );
//      WRITELN (      ' Tc=', TK, ' K'                              );
//      WRITELN ('Non-dimensional thickness of melted substrate layer');
//      WRITELN (      '  Hb=', HB                                   );


      DS:=SQRT(2/(3*HP)); // Diameter of splat from balance of mass
      DSD:=DP*DS;  //*1E6; я пока считаю в метрах
      HPD:=HP*DP;  //*1E6;


      H:=HPD;
      Ds_vozvr:=DSD;

      ABS:=LBS/(ROBS*CBS);
      glub_pronikn := 4*sqrt(TDspl*ABS);



    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('Режим :'+inttostr(REGIME));
        logreport ('Ds,dim=' + floattostr(DSD) + ', mkm  Hs,dim=' + floattostr(HPD));
        logreport ('Ds,non-dim=' + floattostr(DS) + ', mkm  Hs,non-dim=' + floattostr(HP));

        if (SplatNum = 1) then
          begin
            LogRec.REG1 := REGIME ;

            LogRec.DsDim1 := round(DSD * 1E6 );
            LogRec.HsDim1 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim1 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim1 := round(HP * 1000) / 1000 ;
            LogRec.Tc1 := Vrb.Tc;
          end
        else
          begin
            LogRec.REG2 := REGIME ;

            LogRec.DsDim2 := round(DSD * 1E6 );
            LogRec.HsDim2 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim2 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim2 := round(HP * 1000) / 1000   ;
            LogRec.Tc2 := Vrb.Tc;
          end;

      end;


//      WRITELN('Computed dimensional diameter & thickness of splat' );
//      WRITELN('    Ds,dim=',DSD,' , mkm;   Hs,dim=', HPD, ', mkm;' );
//      WRITELN('Computed non-dimensional diameter & thickness of splat');
//      WRITELN('Ds,non-dim=',DS, '      Hs,non-dim=', HP            );


{ //Эта часть лишняя....

//C*******************************************************************
//C     The results of calculations by using defferent               *
//C     formula: 1) Madejski; 2) Jones; 3) Cheng.                    *
//C*******************************************************************
      REPART:=0;
      IF ( MUPL > 1E-10 ) THEN GOTO 50;
//      WRITE ( 'You must to define the viscosity (MUpl)');
      GOTO 60;
50:    REPART:=ROPL*DP*UP/MUPL;
60:    WEBERP:=0;

      IF ( SIGMAP > 1E-10 ) THEN GOTO 70;
//      WRITE ( 'You must to define the surface tension (SIGMAp)');
      GOTO 80;
70:    WEBERP:=ROPL*DP*UP*UP/SIGMAP;
80: //   WRITELN ( '****The values of Reynolds and Weber number****');
    //  WRITELN ( 'Re=' , REPART , '        We=',WEBERP);
      //PAUSE 2


      IF ( REPART = 0 ) THEN GOTO 90;
//C@@@@@      Formula of Madejski.
      REPLUS:=REPART+0.9517;

      ZETAM:=1.2941*step(REPLUS, 0.2);
      ZETAMD:=ZETAM*DP;
      HPMD:=(2/3)*DP/(ZETAM*ZETAM);
      //WRITELN ( 'The computed values Ds,Hp (m) by Madejski');
      //WRITELN ( ZETAMD , HPMD );
//C@@@@@      Formula of Jones.
      HPJD:=0.496*DP/step(REPART, 0.25);
      ZETAJD:=DP*SQRT((2/3)*(DP/HPJD));
      //WRITELN ( 'The computed values Ds,Hp (m) by Jones');
      //WRITELN ( ZETAJD,HPJD );

90:    IF (WEBERP = 0) THEN GOTO 100;
      ZETAC:=0.816*step(WEBERP, 0.25);
      HPCD:=(2/3)*DP/(ZETAC*ZETAC);
      ZETACD:=ZETAC*DP;
      //WRITELN ( 'The computed values Ds,Hp (m) by Cheng');
      //WRITELN ( ZETACD , HPCD);
      IF ( REPART = 0 ) THEN GOTO 100;
//C@@@@@      Formula of Uryukov.
      ZETAU:=0.922*step(REPART, 0.25);
      ZETAUD:=ZETAU*DP;
      HPUD:=(2/3)*DP/(ZETAU*ZETAU);
      //WRITELN ('The computed values Ds,Hp (m) by Uryukov');
      //WRITELN ( ZETAUD , HPUD);
 }



    end
 else
    begin
      // Заглушка для 2 сценария ! Это кактастрофа
      log ('Ёпт! Сценарий не тот !!!!!!!!!!! !!!!!!!!!');
{      scen:=REGIME;
      HP := Dp / 20;   //<- залушка для отвлечения внимания!
      DS:=SQRT(2./(3.*HP));
      DSD:=DP*DS;
      HPD:=HP*DP;
      H:=HPD;
      Ds_vozvr:=DSD;}
      showmessage ('Для оксидов сейнарий не реализован. Заглушки нет.');
      Application.Terminate;

    end;


 scen:=REGIME;



end;




// Металлокерамика2

procedure advcalculator_metKer (zabilipodlojku: boolean; Dp, Tpo, TB0, V:real;
                             partmat, incmat, basemat:CCutBoxSet;
                             var H :real; var Ds_vozvr:real; var scen:integer;
                             volcon:real; formula:integer; var glub_pronikn:real; SplatNum:integer);

var REGIME:integer;
    NAME : array [1..NMMAX] of string[8];
    NAMEP, NAMEB, NAMEPb, NAMEPi  : Integer;

    KEBP,KUPL,KUBS:Real;

    LPS,LPL,LP,MUPL,LBS,LBL,LB,MUBL, LPSEf,LPLEf,LGas:Real;
    LPSb,LPLb,LPb,MUPLb:Real;
    LPSi,LPLi,LPi,MUPLi:Real;
//C !!!! Если добавляются новые материалы, необходимо откорректировать
//C !!!! размерности массивов NAME(?), PROP(10,?) и переменную NMMAX

    PROP:array [1..NPMAX,1..NMMAX] of real;
    PROPP, PROPB, PROPPi, PROPPb :array [1..NPMAX] of real;

//------------------------------------------------------------------------------
    PI:real;

    Up, Tp  :real;

    TEMP0, Smax, FFact, RNUPL:real;
    i,j:integer;
    ROPS,ROPL,CPS,CPL,TPM,SIGMAP, ROBS,ROBL,CBS,CBL,TBM,SIGMAB: real;

    //пара параметров для адгезии
    LBOILB:real;
    AWB:real;

    Tspl,TDspl,HP,HB,TK0,TK,
    RE,WE,PR,PE,FPB,CDZ,
    TP0, Tvisc, Tdnd, DS, DSD, HPD :real;
    Por, ROPSEf, ROPLEf, CPSEf,CPLEf, ROGas, CPGas:Real;
    ABS:real;

    Ds_m2, hs_m2_J, hs_m2_S:Real;

    REPART, WEBERP, ZETAM, ZETAMD, REPLUS, HPMD, HPJD, ZETAJD, ZETAC, HPCD,
    ZETACD, ZETAU, ZETAUD, HPUD:real;

    td : real;
    s:string;
    FOS,TAUS:real;


label 50, 60, 70, 80, 90, 100;


begin
  log ('advcalculator_mk4');

 // {$INCLUDE  'cover\func\init_mat.pas'}

  Tp:=Tpo;
  TEMP0:=Tp;

//  VolCon:=0.6;
  // <- Материаллы !
//  NAMEPb:=ReadIniDataInt('met_cer', 'Pb', 21);
//  NAMEPi:=ReadIniDataInt('met_cer', 'Pi', 22);
//  NAMEB :=ReadIniDataInt('met_cer', 'B', 16);
//  VolCon:=ReadIniDataReal ('met_cer', 'VolCon', 0.6);

  Por:=0;
  if zabilipodlojku
    then
      begin
        log ('Забыли подложку');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал включений Pi=' + inttostr(incmat.m_nId) + ' это ' + incmat.m_Material);
        log ('материал подложки B такой же как частиц');
      end
    else
      begin
        log ('Еще помним подложку или просто не дошли до второй проверки');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал включений Pi=' + inttostr(incmat.m_nId) + ' это ' + incmat.m_Material);
        log ('материал подложки B =' + inttostr(basemat.m_nId) + ' это ' + basemat.m_Material );
      end;

  log ('объемная концентрация VolCon=' + floattostr(VolCon) );

  Up:= V;

  //Si =11
{  i:=NAMEB;
  ROBS:=PROP[1,i];
  ROBL:=PROP[2,i];
  CBS:=PROP[3,i];
  CBL:=PROP[4,i];
  LBS:=PROP[5,i];
  LBL:=PROP[6,i];
  TBM:=PROP[7,i];
  LB:=PROP[8,i];
  MUBL:=PROP[9,i];
  SIGMAB:=PROP[10,i];
 }

  ROBS  :=basemat.m_ROms;
  ROBL  :=basemat.m_ROml;
  CBS   :=basemat.m_CPms;
  CBL   :=basemat.m_CPml;
  LBS   :=basemat.m_Lms;
  LBL   :=basemat.m_Lml;
  TBM   :=basemat.m_Tm;
  LB    :=basemat.m_Lm;
  MUBL  :=basemat.m_MUml;
  SIGMAB:=basemat.m_SIGml;

  //добавлено
  LBOILB:=basemat.m_LBoil;
  AWB   :=basemat.m_AW;


  td := Dp/Up;

//C_______________________________________________________________________
//C
//C! Preparation of properties of metal-ceramic particle taking into
//C! account volume concentration of ultra-fine inclusions in bonding melt
//C_______________________________________________________________________
//C
//C!    Por - пористость гетерогенного материала частицы
//C!    ROGas, CPGas, LGas - плотность, теплоемкость и теплопроводность
//C!    газа при температуре плавления связки.
//C-----------------------------------------------------------------------
//C!    Аргон при температуре плавления кобальта (Tm=1766 K)
      ROGas:=0.3;
      CPGas:=520;
      LGas :=0.091;
//C-----------------------------------------------------------------------


  ROPSEf:=VolCon*incmat.m_ROms +(1-VolCon)*partmat.m_ROms;
  ROPLEf:=VolCon*incmat.m_ROml +(1-VolCon)*partmat.m_ROml;
  CPSEf :=VolCon*incmat.m_CPms +(1-VolCon)*partmat.m_CPms;
  CPLEf :=VolCon*incmat.m_CPml +(1-VolCon)*partmat.m_CPml;
  LPSEf :=VolCon*incmat.m_Lms +(1-VolCon)*partmat.m_Lms;
  LPLEf :=VolCon*incmat.m_Lml +(1-VolCon)*partmat.m_Lml;


  S:='1 Pi '+floattostr(incmat.m_ROms)+';' + '2 Pi '+floattostr(incmat.m_ROml)+';'+'3 Pi '+floattostr(incmat.m_CPms)+';'+'4 Pi '+floattostr(incmat.m_CPml)+';'+'5 Pi '+floattostr(incmat.m_Lms)+';'+'6 Pi '+floattostr(incmat.m_Lml)+';'+'7 Pi '+floattostr(incmat.m_Tm)+';'+'8 Pi '+floattostr(incmat.m_Lm)+';'+'9 Pi '+floattostr(incmat.m_MUml)+';'+'10 Pi '+floattostr(incmat.m_SIGml)+';';

  log(S);

  S := '1 Pb '+floattostr(partmat.m_ROms)+';' +
  '2 Pb '+floattostr(partmat.m_ROml)+';' +
  '3 Pb '+floattostr(partmat.m_CPms)+';' +
  '4 Pb '+floattostr(partmat.m_CPml)+';' +
  '5 Pb '+floattostr(partmat.m_Lms)+';' +
  '6 Pb '+floattostr(partmat.m_Lml)+';' +
  '7 Pb '+floattostr(partmat.m_Tm)+';' +
  '8 Pb '+floattostr(partmat.m_Lm)+';' +
  '9 Pb '+floattostr(partmat.m_MUml)+';' +
  '10 Pb '+floattostr(partmat.m_SIGml)+';';
  log (S);

  ROPS  :=(1-Por)*ROPSEf+Por*ROGas;
  ROPL  :=(1-Por)*ROPLEf+Por*ROGas;
  CPS   :=(1-Por)*CPSEf+Por*CPGas;
  CPL   :=(1-Por)*CPLEf+Por*CPGas;

//C      LPS   =LPSEf/(1.+Por*(LPSEf/LGas-1.))
//C      LPL   =LPLEf/(1.+Por*(LPLEf/LGas-1.))
//C      Эти формулы для нашего случая не работают
  LPS   :=LPSEf*(1-Por)/(1+Por/2);
  LPL   :=LPLEf/(1-Por)/(1+Por/2);

  TPM := partmat.m_Tm;

//  LP  :=(1-Por)*(1-VolCon)*PROP[2,NAMEPb]*PROP[8,NAMEPb]/ROPL;
// переход на массовую долю от объемной
  LP  :=(1-Por)*(1-VolCon)*partmat.m_ROml*partmat.m_Lm/ROPL;

//C!  Правка LP в соответствии со статьей в JTST (18.04.2012)


  Smax:=0.63;
//C! Всавить контроль объемной концентрации включений (s < Smax)
//C! Вязкость чистой связующей берется при ее температуре плавления.
//C!    Viscosity in accordance with Uriev
//C!  FFact:=step(1/(1-VolCon/Smax), 2.5*Smax);
//C
//C!    Viscosity in accordance with Soo


//  if ReadIniDataInt('met_cer', 'formula', 1)= 1 then

  log ('Вязкость ' + inttostr(formula) + '  1-Урьев  0-Классика');
  log ('Объемная доля включений ' + floattostr(VolCon) + '');
  log ('Smax ' + floattostr(Smax) + '');
  log ('Por ' + floattostr(Por) + '');


  if formula = 1 then
    begin  //1
      FFact:=step(1/(1-VolCon/Smax), 2.5*Smax);
    end
    else
    begin  //0
      FFact:=1/(1-VolCon);
    end;

  MUPL:=partmat.m_MUml*FFact;
  RNUPL:=MUPL/ROPL;
  SIGMAP:=partmat.m_SIGml;
//  log ('Fact=' + floattostr(FFact) + ' Mu(s)=' + floattostr(MUPL));

//  LBOILP :=;
//  AWP    :=;



  if zabilipodlojku then
    begin // Забыли подложку, свойства принадлежат частице
        ROBS := ROPS;
        ROBL := ROPL;
        CBS := CPS;
        CBL :=CPL;
        LBS := LPS;
        LBL := LPL;
        TBM := TPM;
        LB := LP;
        MUBL := MUPL;
        SIGMAB := SIGMAP;
    end;


    S:= 'Св-ва частицы: 1 ROPS '+floattostr(ROPS)+';'   +
      '2 ROPL '+floattostr(ROPL)+';'  +
      '3 CPS '+floattostr(CPS)+';'   +
      '4 CPL '+floattostr(CPL)+';'  +
      '5 LPS '+floattostr(LPS)+';' +
      '6 LPL '+floattostr(LPL)+';' +
      '7 TPM '+floattostr(TPM)+';' +
      '8 LP '+floattostr(LP)+';' +
      '9 MUPL '+floattostr(MUPL)+';' +
      '10 SIGMAP '+floattostr(SIGMAP)+';';


    S:= S + 'Св-ва подложки: 1 ROBS '+floattostr(ROBS)+';'   +
      '2 ROBL '+floattostr(ROBL)+';'  +
      '3 CBS '+floattostr(CBS)+';'   +
      '4 CBL '+floattostr(CBL)+';'  +
      '5 LBS '+floattostr(LBS)+';' +
      '6 LBL '+floattostr(LBL)+';' +
      '7 TBM '+floattostr(TBM)+';' +
      '8 LB '+floattostr(LB)+';' +
      '9 MUBL '+floattostr(MUBL)+';' +
      '10 SIGMAB '+floattostr(SIGMAB)+';';
    log (S);



    if (SplatNum = 1) then
      begin
        AddToLogArh (1, 'MUPL', 2, 0, MUPL,  '');
        AddToLogArh (1, 'RNUPL', 2, 0, RNUPL,  '');
        AddToLogArh (1, 'Smax', 2, 0, Smax,  '');
        AddToLogArh (1, 'VolCon', 2, 0, Smax,  '');
        AddToLogArh (1, 'FFact', 2, 0, FFact,  '');


        AddToLogArh (1, 'ROPS', 2, 0, ROPS,  '');
        AddToLogArh (1, 'ROPL', 2, 0, ROPL,  '');
        AddToLogArh (1, 'CPS', 2, 0, CPS,  '');
        AddToLogArh (1, 'CPL', 2, 0, CPL,  '');
        AddToLogArh (1, 'LPS', 2, 0, LPS,  '');
        AddToLogArh (1, 'LPL', 2, 0, LPL,  '');
        AddToLogArh (1, 'TPM', 2, 0, TPM,  '');
        AddToLogArh (1, 'LP', 2, 0, LP,  '');
        AddToLogArh (1, 'MUPL', 2, 0, MUPL,  '');
        AddToLogArh (1, 'SIGMAP', 2, 0, SIGMAP,  '');



        AddToLogArh (1, 'ROBS', 2, 0, ROBS,  '');
        AddToLogArh (1, 'ROBL', 2, 0, ROBL,  '');
        AddToLogArh (1, 'CBS', 2, 0, CBS,  '');
        AddToLogArh (1, 'CBL', 2, 0, CBL,  '');
        AddToLogArh (1, 'LBS', 2, 0, LBS,  '');
        AddToLogArh (1, 'LBL', 2, 0, LBL,  '');
        AddToLogArh (1, 'TBM', 2, 0, TBM,  '');
        AddToLogArh (1, 'LB', 2, 0, LB,  '');
        AddToLogArh (1, 'MUBL', 2, 0, MUBL,  '');
        AddToLogArh (1, 'SIGMAB', 2, 0, SIGMAB,  '');

      end;



    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('');
        if (SplatNum = 1) then logreport ('Первый сплэт: '+S)
                          else logreport ('Сплэт с забыванием: '+S);
        logreport ('');
      end;





  //============================================================================
      //для начала посчитаем для металлов адгезию...
      HPB2
        (REGIME,FOS,TAUS,HP,HB,TK0,TK,PE,KEBP,KUPL,KUBS,FPB,
         DP,Up,Tp,TB0, Vrb.Tc, vrb.adg_sigma_i,
//         ROPS,ROPL,CPS,CPL,LPS,LPL,TPM,LP,MUPL, //,LBOILP, AWP,
//         ROBS,ROBL,CBS,CBL,LBS,LBL,TBM,LB,MUBL,LBOILB, AWB);

         partmat.m_ROms, partmat.m_ROml, partmat.m_CPms, partmat.m_CPml, partmat.m_Lms, partmat.m_Lml,
         partmat.m_Tm, partmat.m_Lm, partmat.m_MUml,

         basemat.m_ROms, basemat.m_ROml, basemat.m_CPms, basemat.m_CPml, basemat.m_Lms, basemat.m_Lml,
         basemat.m_Tm, basemat.m_Lm, basemat.m_MUml, basemat.m_LBoil, basemat.m_AW, SplatNum
         );

  //============================================================================




  HPB4
        (REGIME, Tspl,TDspl,HP,HB,TK0,TK,
        RE,WE,PR,PE,KEBP,KUPL,KUBS,FPB,CDZ,
        DP,UP,TP,TB0, Vrb.Tc, Ds_m2, hs_m2_J,  // hs_m2_S,
        ROPS,ROPL,CPS,CPL,LPS,LPL,TPM,LP,MUPL,SIGMAP,
        ROBS,ROBL,CBS,CBL,LBS,LBL,TBM,LB,MUBL,SIGMAB, LBOILB, AWB, SplatNum);
  //}

//  TDspl
//  glub_pronikn

  IF ( REGIME=1) then
    begin

      Td:=DP/UP;
      Tvisc:=DP*DP/RNUPL;
      Tdnd:=TDspl/Td;
      log ( 'Scenario=' + inttostr(REGIME));



      if iniVar.polaya_chastica then //Если частица полая....
        begin
         DS:=Ds_m2; // ! Diameter of splat from balance of mass
         DSD:=DP*DS;

         HPD:=hs_m2_J*DP;
         H:=HPD;
         //Ds_m2, hs_m2_J, hs_m2_S:Real;
        end
      else //Классическая частица
        begin
         DS:=SQRT(2/(3*HP)); // ! Diameter of splat from balance of mass
         DSD:=DP*DS;
         HPD:=HP*DP;
         H:=HPD;
        end;




      Ds_vozvr:=DSD;

      ABS:=LBS/(ROBS*CBS);
      glub_pronikn := 4*sqrt(TDspl*ABS);

    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('Режим :'+inttostr(REGIME));
        logreport ('Ds,dim=' + floattostr(DSD) + ', m    Hs,dim=' + floattostr(HPD)+', m');
        logreport ('Ds,non-dim=' + floattostr(DS) + ',   Hs,non-dim=' + floattostr(HP));

        //logreport ('Ds (pustoi),dim=' + floattostr(Ds_m2*DP) + ', m    Hs (pustoi),dim=' + floattostr(hs_m2_J*DP)+', m');
        //logreport ('Ds (pustoi),non-dim=' + floattostr(Ds_m2) + ',   Hs (pustoi),non-dim=' + floattostr(hs_m2_J));

        if (SplatNum = 1) then
          begin
            LogRec.REG1 := REGIME ;

            LogRec.DsDim1 := round(DSD * 1E6 );
            LogRec.HsDim1 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim1 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim1 := round(HP * 1000) / 1000 ;
            LogRec.Tc1 := Vrb.Tc;
          end
        else
          begin
            LogRec.REG2 := REGIME ;

            LogRec.DsDim2 := round(DSD * 1E6 );
            LogRec.HsDim2 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim2 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim2 := round(HP * 1000) / 1000   ;
            LogRec.Tc2 := Vrb.Tc;
          end;

      end;


      log ('Computed dimensional diameter & thickness of splat');
      log ('    Ds,dim=' + floattostr(DSD) +' , mcm;   Hs,dim=' + floattostr(HPD) + ', mcm;');
      log ('Computed non-dimensional diameter & thickness of splat');
      log ('Ds,non-dim=' + floattostr(DS) + '      Hs,non-dim=' + floattostr(HP));

    end
 else
    begin
      // Заглушка для 2 сценария ! Это кактастрофа
      log ('Ёпт! Сценарий не тот !!!!!!!!!!! !!!!!!!!!');
      scen:=REGIME;
      HP := Dp / 20;   //<- залушка для отвлечения внимания!
      DS:=SQRT(2./(3.*HP));
      DSD:=DP*DS;
      HPD:=HP*DP;
      H:=HPD;
      Ds_vozvr:=DSD;
    end;


 scen:=REGIME;



end;



//Старый вариант:


procedure advcalculator_metal (zabilipodlojku: boolean; Dp, Tpo, TB0, V:real; partmat, basemat:CCutBoxSet;
                          var H :real; var Ds_vozvr:real; var scen:integer; var glub_pronikn:real; SplatNum:integer);
{Описание const из будущей БД
[1. RO_pm_l - Плотность материала частицы в жидком состоянии]
[2. L_pm_s (L_ms) - Теплопроводность материала в твердом состоянии]
[3. L_pm_l (L_ml) - Теплопроводность материала в жидком состоянии]
[4. L_p (L_m) - Теплота плавления]
[5. C_pm_l - Теплоемкость материала в жидком состоянии]
[6. T_p_m (Tm)- Температура плавления]
[7. L_bm_s - Теплопроводность материала базы в твердом состоянии]
[8. A_pm_l - Температуропроводность частицы в жидком состоянии]
[9. A_bm_s - Температуропроводность базы в твердом состоянии]
[   A_c = 0.259 для металлов или 0 для оксидов  относительный вклад конвекции расплава в окрестности точки его торможения в сравнении с кондуктивным теплообменом между растекающейся частицей и основой]
}
var
  ROPS,ROPL,CPS,CPL,LPS,LPL,TPM,LP,MUPL,SIGMAP, LBOILP, AWP,
  ROBS,ROBL,CBS,CBL,LBS,LBL,TBM,LB,MUBL,SIGMAB, LBOILB, AWB: real;

  FOS,TAUS,HP,HB,TK0,TK,PE,KEBP,KUPL,KUBS,FPB:real;
  Upo:real;
  REGIME:integer;
  PeFos,DS,DSD,HPD:real;
  ABS:real;
  s:string;

begin

  log ('advcalculator');

  if zabilipodlojku
    then
      begin
        log ('Забыли подложку');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал подложки B, такой же как частиц');
      end
    else
      begin
        log ('Еще помним подложку или просто не дошли до второй проверки');
        log ('материал частицы Pb=' + inttostr(partmat.m_nId) + ' это ' + partmat.m_Material);
        log ('материал подложки B =' + inttostr(basemat.m_nId) + ' это ' + basemat.m_Material );
      end;



ROPS  :=partmat.m_ROms;
ROPL  :=partmat.m_ROml;
CPS   :=partmat.m_CPms;
CPL   :=partmat.m_CPml;
LPS   :=partmat.m_Lms;
LPL   :=partmat.m_Lml;
TPM   :=partmat.m_Tm;
LP    :=partmat.m_Lm;
MUPL  :=partmat.m_MUml;
SIGMAP:=partmat.m_SIGml;
LBOILP:=partmat.m_LBoil;
AWP   :=partmat.m_AW;

ROBS  :=basemat.m_ROms;
ROBL  :=basemat.m_ROml;
CBS   :=basemat.m_CPms;
CBL   :=basemat.m_CPml;
LBS   :=basemat.m_Lms;
LBL   :=basemat.m_Lml;
TBM   :=basemat.m_Tm;
LB    :=basemat.m_Lm;
MUBL  :=basemat.m_MUml;
SIGMAB:=basemat.m_SIGml;
LBOILB:=basemat.m_LBoil;
AWB   :=basemat.m_AW;



  if zabilipodlojku then
    begin
        ROBS := ROPS;
        ROBL := ROPL;
        CBS := CPS;
        CBL :=CPL;
        LBS := LPS;
        LBL := LPL;
        TBM := TPM;
        LB := LP;
        MUBL := MUPL;
        SIGMAB := SIGMAP;
        LBOILB:=LBOILP;
        AWB   :=AWP;
    end;

    S:= 'Св-ва частицы: 1 ROPS '+floattostr(ROPS)+';'   +
      '2 ROPL '+floattostr(ROPL)+';'  +
      '3 CPS '+floattostr(CPS)+';'   +
      '4 CPL '+floattostr(CPL)+';'  +
      '5 LPS '+floattostr(LPS)+';' +
      '6 LPL '+floattostr(LPL)+';' +
      '7 TPM '+floattostr(TPM)+';' +
      '8 LP '+floattostr(LP)+';' +
      '9 MUPL '+floattostr(MUPL)+';' +
      '10 SIGMAP '+floattostr(SIGMAP)+';';


    S:= S + 'Св-ва подложки: 1 ROBS '+floattostr(ROBS)+';'   +
      '2 ROBL '+floattostr(ROBL)+';'  +
      '3 CBS '+floattostr(CBS)+';'   +
      '4 CBL '+floattostr(CBL)+';'  +
      '5 LBS '+floattostr(LBS)+';' +
      '6 LBL '+floattostr(LBL)+';' +
      '7 TBM '+floattostr(TBM)+';' +
      '8 LB '+floattostr(LB)+';' +
      '9 MUBL '+floattostr(MUBL)+';' +
      '10 SIGMAB '+floattostr(SIGMAB)+';';
    log (S);

    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('');
        if (SplatNum = 1) then logreport ('Первый сплэт: '+S)
                          else logreport ('Сплэт с забыванием: '+S);
        logreport ('');
      end;


      Upo:=V;

//=============
//  РАСЧЕТЫ:
//=============
      HPB2
        (REGIME,FOS,TAUS,HP,HB,TK0,TK,PE,KEBP,KUPL,KUBS,FPB,
         DP,Upo,Tpo,TB0, Vrb.Tc, vrb.adg_sigma_i,
         ROPS,ROPL,CPS,CPL,LPS,LPL,TPM,LP,MUPL,//LBOILP, AWP,
         ROBS,ROBL,CBS,CBL,LBS,LBL,TBM,LB,MUBL,LBOILB, AWB, SplatNum);

      scen:=REGIME;
//      Memo1.Lines.Add ( '***********RESULTS OF CALCULATION************');
//      Memo1.Lines.Add ( 'REGIME='+ inttostr(REGIME));
//      Memo1.Lines.Add ( 'CRITERIONS--PE, KEBP, KUPL, KUBS, FPB');
//      Memo1.Lines.Add (  floattostr(PE) + ' ' + floattostr(KEBP) + ' ' + floattostr(KUPL) + ' ' + floattostr(KUBS) + ' ' + floattostr(FPB));
//      Memo1.Lines.Add ( 'Computed results /FO* ,T* ,Pe^Fo* ,HP, HB, TK0, TK/');
      PeFos:=PE*FOS;
//      Memo1.Lines.Add (  floattostr(FOS) + ' ' + floattostr(TAUS) + ' ' + floattostr(PeFos) + ' ' + floattostr(HP) + ' ' + floattostr(HB) + ' ' + floattostr(TK0) + ' ' + floattostr(TK));

      DS:=SQRT(2./(3.*HP));
      DSD:=DP*DS;
      HPD:=HP*DP;
//      Memo1.Lines.Add ( 'COMPUTED VALUES DSD,HPD (m) AND DS,HP (nondimens.)');
//      Memo1.Lines.Add ( 'DSD=' + floattostr(DSD) + ',(m)  HPD=' + floattostr(HPD) + ',(m)  DS=' + floattostr(DS) + '  HP='+ floattostr(HP));

      H:=HPD;
      Ds_vozvr:=DSD;



    if (SplatNum = 1) OR (SplatNum = -1) then
      begin
        logreport ('Режим :'+inttostr(REGIME));
        logreport ('Ds,dim=' + floattostr(DSD) + ', mkm  Hs,dim=' + floattostr(HPD));
        logreport ('Ds,non-dim=' + floattostr(DS) + ', mkm  Hs,non-dim=' + floattostr(HP));

        if (SplatNum = 1) then
          begin
            LogRec.REG1 := REGIME ;

            LogRec.DsDim1 := round(DSD * 1E6 );
            LogRec.HsDim1 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim1 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim1 := round(HP * 1000) / 1000 ;

            LogRec.Tc1 := Vrb.Tc;
          end
        else
          begin
            LogRec.REG2 := REGIME ;

            LogRec.DsDim2 := round(DSD * 1E6 );
            LogRec.HsDim2 := round(HPD * 1E6 * 100) / 100 ;

            LogRec.DsNONDim2 := round(DS * 1000) / 1000   ;
            LogRec.HsNONDim2 := round(HP * 1000) / 1000   ;
            
            LogRec.Tc2 := Vrb.Tc;
          end;

      end;

//***********************************************************
// Этот кусок скопипастен неглядя, надо проверить его физическую правильность
      ABS:=LBS/(ROBS*CBS);
      glub_pronikn := 4*sqrt(TAUS*ABS);
//***********************************************************
//     glub_pronikn := 0;

end;


