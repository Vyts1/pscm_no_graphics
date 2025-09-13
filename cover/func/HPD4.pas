//  Металлокерамика дополненная
procedure HPB4 (
     var REGIME:integer; var Tspl:Real; var TDspl:Real; var HP:real;
     var HB:real; var TK0:real; var TK:real;
     var RE:real; var WE:real; var PR:real; var PE:real; var KEBP:real;
     var KUPL:real; var KUBS:real; var FPB:real;
     var CDZ:Real; var DP:Real; var UP:Real; var TP0:Real; var TB0:real;
     var Tc:real;  var Ds_m2:Real; var hs_m2_J:real; //var hs_m2_S:real;

      ROPS: real; ROPL: real; CPS: real;  CPL: real;  LPS: real;
      LPL: real;  TPM: real; LP: real;  MUPL: real; SIGMAP:Real;

      ROBS: real; ROBL: real;  CBS: real;  CBL: real; LBS: real;
      LBL: real;  TBM: real;  LB: real;  MUBL: real; SIGMAB:Real;
      LBOILB:real; AWB:real;  SplatNum : integer );

//C***********************************************************************
//C  The program for analysis of the metal oxide droplet - substrate
//C  interaction (Pr>1) with the help of one-dimensional model of the
//C  equilibrium solidification.
//C***********************************************************************


var TTP0,TTB0,TTBM,APL,TTK0,LPPLS,R1,P,Q,TTK,HPR,LBPLL,LBPSL,LBBSL,R2,CKS,LBPLS,LPPSL,D1,D2,CND:real;
    TdD, ALPHAC, DISCR, CDZ0, TTKR, Kappa, Ysqrt, Hsplat, Dsplat, Hsrough, Dsrough:real;

    Ath_m2, DltaP_m2, ROeff_m2 : real;
    ROeffD_m2 : real;

    V, t2, Ea, const_k :real;

    tracks : string;

//    SQRTPI,ALFAC,LPBLL,NREG1,NREG2,NREG3,NREG4,NREG:real;
//var
//      REAL     LPS,LPL,LP,MUPL,MUBL,LBS,LBL,LB,
//     *         KEBP,KUPL,KUBS,LBPLS,LPPLS,LPPSL,
//     *         LBPLL,LBPSL,LBBSL,Kappa

label lreturn, 1,10,20,100;
begin
      tracks := '*0';

      //PI:=3.1415926;
      TTP0:=TP0/TPM;
      TTB0:=TB0/TPM;
      TTBM:=TBM/TPM;
      KUPL:=LP/(CPL*TPM);
      KUBS:=LB/(CBS*TBM);
      FPB:=ROPL*LP/(ROBS*LB);
      KEBP:=SQRT(ROBS*CBS*LBS/(ROPL*CPL*LPL));
      LPPSL:=LPS/LPL;
      R1:=SQRT(PI)*KEBP*KUPL;
      TTK0:=(TTP0+KEBP*TTB0)/(1.+KEBP);
      APL:=LPL/(ROPL*CPL);
      RE:=ROPL*DP*UP/MUPL;
      WE:=ROPL*DP*(UP*UP)/SIGMAP;
      PE:=DP*UP/APL;
      PR:=(MUPL/ROPL)/APL;
      TdD:=DP/UP;




//C     Computing a zero approach to the rate of solidification CDZ0
//C     do not taking into account the convection of the melt
      ALPHAC:=0;
      P:=(PI*LPPSL*KUPL+2*(1+ALPHAC)*KEBP*(TTP0-1))/R1;
      Q:=(2*LPPSL*(1-TTB0)/KUPL)*(1-(1+ALPHAC)*(TTP0-1)/((1-TTB0)*KEBP));
      DISCR:=1+4*Q/(P*P);
      IF ( DISCR < 0 ) then GOTO 20;

      tracks := tracks + '*1';

      CDZ0:=P*(SQRT(DISCR)-1)/2;
//C*****
      TTKR:=TTK0;
1:
      tracks := tracks + '*2';
      IF ( TTKR >= MIN(1, TTBM) ) then GOTO 100;
      tracks := tracks + '*3';
      TTK:=(LPPSL*SQRT(PI)+CDZ0*KEBP*TTB0)/(LPPSL*SQRT(PI)+CDZ0*KEBP);
      TTKR:=TTK;
      IF ( TTKR >= MIN(1,TTBM) ) then  GOTO 100;
      tracks := tracks + '*4';
//C
//C***********************************************************************
//C                          Scenario=1
//C***********************************************************************
//C   The solidification of liquid particle on the solid substrate
//C***********************************************************************
      REGIME:=1;
//C  Calculation of Cdzeta characterizing the propagation rate
//C  of melt solidification taking into account the convection
//C  of melt in the vicinity of stagnation point
//C!
//C  Convection of the melt is not taken into account now !!!!!!!
//C!
      ALPHAC:=0;

      P:=(PI*LPPSL*KUPL+2*(1+ALPHAC)*KEBP*(TTP0-1))/R1;
      Q:=(2*LPPSL*(1-TTB0)/KUPL)*(1-(1+ALPHAC)*(TTP0-1)/((1-TTB0)*KEBP));
      DISCR:=1+4*Q/(P*P);
      IF ( DISCR < 0 ) then  GOTO 20;
      tracks := tracks + '*5';
      CDZ:=P*(SQRT(DISCR)-1)/2;

//C     The contact temperature TTK taking into account the melting heat,
//C     see zero approach to contact temperature TTK0.

      TTK:=(LPPSL*SQRT(PI)+CDZ*KEBP*TTB0)/(LPPSL*SQRT(PI)+CDZ*KEBP);
      TTKR:=TTK;
      IF ( (TTK >= 1) OR (TTBM <= TTK) ) then GOTO 1;
      tracks := tracks + '*6';
//C***********************************************************************
//C     If new contact temperature changes the scenario of splat formation
//C     than go to the block of scenarios control
//C***********************************************************************
//C***********************************************************************
//C
//C***********************************************************************
//C
//C!! Exact solution for non-dimensional thickness and diameter of splat
//C
//C***********************************************************************



//C!!   Начало: Версия без учета начальной стадии t0
//C
//C     Kappa := 4*CDZ*CDZ/(27*PE);
//C     Ysqrt :=(1 /step (2*PE*CDZ, 1/3)) * (step ( (SQRT(1+Kappa)+1) , 1/3)-  step ((SQRT(1+Kappa)-1),1/3));
//C!!   Конец: Версия без учета начальной стадии t0
//C!!
//C***********************************************************************
//C!!   Начало: Версия c учетом начальной стадии t0
//C
      Kappa:=512*CDZ*CDZ/(5625*PE);
      Ysqrt:=( step ((25/(72*PE*CDZ)), (1/3))  ) * (step ( (SQRT(1+Kappa)+1) , 1/3)-  step ((SQRT(1+Kappa)-1),1/3));
//C!!   Конец: Версия с учетом начальной стадии t0
//C!!
//C***********************************************************************
      Hsplat:=CDZ*Ysqrt;
      Dsplat:=SQRT(2/(3*Hsplat)); // !Diameter of splat from mass balance
      Tspl:=Ysqrt*Ysqrt;
      TDspl:=Tspl*DP*DP/APL;
//      WRITELN ( 'Exact values for non-dimentional Hsplat and Dsplat');
//      WRITELN ( 'Hsplat=', Hsplat, 'Dsplat=', Dsplat);
//C***********************************************************************
//C
//C!! Approximate solution for thickness and diameter of splat
//C
//C***********************************************************************
//C!!   Начало: Версия без учета начальной стадии t0
//C
//C     Hsrough=(CDZ**2/PE)**(1./3.)
//C     Dsrough=SQRT(2./3.)*(PE**(1./6.))/CDZ**(1./3.)
//C!!   Конец: Версия без учета начальной стадии t0
//C!!
//C***********************************************************************
//C!!   Начало: Версия c учетом начальной стадии t0
//C
      Hsrough := step( (25*CDZ*CDZ/(36*PE)) , 1/3);
      Dsrough := step( (32*PE/(75.*CDZ*CDZ)), 1/6);
//C!!   Конец: Версия с учетом начальной стадии t0
//C!!
//C***********************************************************************
//      WRITELN ( 'Rough values for non-dimentional Hsplat and Dsplat');
//      WRITELN ( 'Hsrough=', Hsrough, 'Dsrough=', Dsrough);

//C***********************************************************************
//C     w^3 + p*w + q = 0
//C***********************************************************************
//C
//C***********************************************************************
//C     The final parameters of splat formed
//C***********************************************************************
      HB:=0;
      HP:=Hsplat;
10:
      tracks := tracks + '*7';
      TK0:=TTK0*TPM;
      TK:=TTK*TPM;
      goto lRETURN;
20:
      tracks := tracks + '*8';
   // WRITELN ( 'DISC<0  ????, Scenario=1');
      goto lRETURN;
100:
      tracks := tracks + '*9';
  // WRITELN ( 'By now only the 1st scenario is realized');

//--------------------------------------
  lreturn:

     tracks := tracks + '*10';
     Tc := TTK*TPM;


   //  ROeffD_m2 := 4140;   // Эксперементальная константа из работ Чеснокова-Гуляева

     ROeffD_m2 := 0.47361918272090788450098384661145 * ROPS ;

     ROeff_m2 := ROeffD_m2 / ROPS; // Безразмерная Роэфф
     //DltaP_m2 := 0.0965;
     DltaP_m2 := 0.5 * (1 - step(1- ROeff_m2, 1/3));


//     Ath_m2 := 1 - 0.2 * CDZ / sqrt(PR) +  0.025 * CDZ * CDZ / PR;//Original formula
     Ath_m2 := 1 / (1 + 0.2054 * CDZ / sqrt(PR)) ;// модернезировали для более верного варианта


     Ds_m2 := 1.2941 * step( RE, 0.2 ) * step (1 - step (1-2*DltaP_m2, 3), 0.4) * Ath_m2  ;
//     Ds_m2 := 1.2941 * step( RE, 0.2 ) * Ath_m2  ; // модернезировали для более верного варианта

     hs_m2_J := ROeff_m2 / (Ds_m2 * Ds_m2);
   //  hs_m2_S := 2 * hs_m2_J / 3;


     if (SplatNum = 1) then
        begin
          AddToLogArh (1, 'RE', 2, 0, RE,  '');
          AddToLogArh (1, 'WE', 2, 0, WE,  '');
          AddToLogArh (1, 'PE', 2, 0, PE,  '');
          AddToLogArh (1, 'PR', 2, 0, PR,  '');
          AddToLogArh (1, 'TK0', 2, 0, TK0,  '');
          AddToLogArh (1, 'TK', 2, 0, TK,  '');
          AddToLogArh (1, 'HP', 2, 0, HP,  '');
          AddToLogArh (1, 'Dsplat', 2, 0, Dsplat,  '');

          AddToLogArh (1, 'Hsrough', 2, 0, Hsrough,  '');
          AddToLogArh (1, 'Dsrough', 2, 0, Dsrough,  '');
          AddToLogArh (1, 'P', 2, 0, P,  '');
          AddToLogArh (1, 'Q', 2, 0, Q,  '');

          AddToLogArh (1, 'TRACK', 3, 0, 0,  tracks);

        end;




end;

