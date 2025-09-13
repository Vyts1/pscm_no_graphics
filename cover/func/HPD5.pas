//  оксид
procedure HPB5 (
     var REGIME:integer; var Tspl:Real; var TDspl:Real; var HP:real;
     var HB:real; var TK0:real; var TK:real;
     var RE:real; var WE:real; var PR:real; var PE:real; var KEBP:real;
     var KUPL:real; var KUBS:real; var FPB:real;
     var CDZ:Real; var DP:Real; var UP:Real; var TP0:Real; var TB0:real;
     var Tc:real;

      ROPS: real; ROPL: real; CPS: real;  CPL: real;  LPS: real;
      LPL: real;  TPM: real; LP: real;  MUPL: real; SIGMAP:Real;

      ROBS: real; ROBL: real;  CBS: real;  CBL: real; LBS: real;
      LBL: real;  TBM: real;  LB: real;  MUBL: real; SIGMAB:Real;
      SplatNum : integer
                );

//C***********************************************************************
//C  The program for analysis of the metal oxide droplet - substrate
//C  interaction (Pr>1) with the help of one-dimensional model of the
//C  equilibrium solidification.
//C***********************************************************************


var PI:real;

     tracks : string;

    //  LPS,LPL,LP,MUPL,MUBL,LBS,LBL,LB,
    //  KEBP,KUPL,KUBS,LBPLS,LPPLS,LPPSL,
    //  LBPLL,LBPSL,LBBSL,L0,Kappa,Kappa2 : real;
    TTP0,TTB0,TTBM,
    APL,TTK0,LPPLS,R1,P,Q,TTK,HPR,LBPLL,LBPSL,LBBSL,R2,CKS,LBPLS,LPPSL,D1,D2,CND:real;
    TdD, ALPHAC, DISCR, CDZ0, TTKR, Kappa, Ysqrt, Hsplat, Dsplat, Hsrough, Dsrough:real;

    Alfa, Chi, CW1, CW2, Td, DelMuD, Beta, EtaMu, T0, L0, DelMu, Diam, DiamD,
    Tspl1, TDspl1, Hspl1, HDspl1, Dspl1, AA, BB, CC, DD, PP, QQ, Kappa2,
    Sq_Br, QQQ, WW, Ysq, TDspl2, Hspl2, Tspl2, HDspl2, HDspl, Hspl, Dspl
     :double;


label lreturn, 1,5,6,7,10,20,100;
begin
      tracks := '*0';

      PI:=3.1415926;
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
      Alfa:=UP/(2*DP);
//C     Computing a zero approach to the rate of solidification CDZ0
//C     do not taking into account the convection of the melt




      ALPHAC:=0;
      P:=(PI*LPPSL*KUPL+2*(1+ALPHAC)*KEBP*(TTP0-1))/R1;
      Q:=(2*LPPSL*(1-TTB0)/KUPL)*(1-(1+ALPHAC)*(TTP0-1)/((1-TTB0)*KEBP));
      DISCR:=1+4*Q/(P*P);
      IF ( DISCR < 0 ) then GOTO 20;

      tracks := tracks + '*1';

      CDZ0:=P*(SQRT(DISCR)-1)/2;



//C     Computing the coefficient Chi
      Chi:=(2/3)*(2-CDZ0/SQRT(PR));
      CW1:=step((2*Chi*Chi), 1/3);
      CW2:=step((Chi/SQRT(2)), 1/3);
      Td:=1/(CW1*step(PR,1/3));

//C      DelMuD=Chi*SQRT((MUPL/ROPL)/Alfa)  ! Old approximation !!!!!!!!

      DelMuD:=Chi*DP/SQRT(RE);            //! New approximation (21.10.2001)
      Beta:=UP/(DelMuD*DP);
      EtaMu:=DelMuD/DP;              //! Relative thickness of viscous layer
      T0:=1/ step( (Beta*Beta*APL), 1/3);  // ! Time scale of problem
      L0:=step( (APL/Beta), 1/3);        // ! Space scale of problem
      Kappa:=UP/step((Beta*APL*APL),(1/3));
      DelMu:=DelMuD/L0;
//C     It is taken the more correct constant characterising the
//C     thickness of viscous boundary layer.
      Diam:=SQRT(2/(3*EtaMu));    // ! Relative diameter of viscous layer
//      WRITELN ('Diam. of viscous layer=' + floattostr(Diam)  );
      DiamD:=Diam*DP;                //! Dimensional diameter of layer
      ALPHAC:=(Td/4)*(1+Td/18);   //! Sufficient approximation for Td<1
//C*****
      TTKR:=TTK0;



1:
    tracks := tracks + '*2';
    IF ( TTKR >= MIN(1, TTBM) ) then GOTO 100;
    tracks := tracks + '*3';
//C***********************************************************************
//C                          Scenario=1
//C***********************************************************************
//C   The solidification of liquid particle on the solid substrate
//C***********************************************************************

      REGIME:=1;
//C  Calculation of Cdzeta characterizing the propagation rate
//C  of melt solidification taking into account the convection
//C  of melt in the vicinity of stagnation point




      P:=(PI*LPPSL*KUPL+2*(1+ALPHAC)*KEBP*(TTP0-1))/R1;
      Q:=(2*LPPSL*(1-TTB0)/KUPL)*(1-(1+ALPHAC)*(TTP0-1)/((1-TTB0)*KEBP));
      DISCR:=1+4*Q/(P*P);
      IF ( DISCR < 0 ) then  GOTO 20;
      tracks := tracks + '*4';
      CDZ:=P*(SQRT(DISCR)-1)/2;

//C     The contact temperature TTK taking into account the melting heat,
//C     see zero approach to contact temperature TTK0.

      TTK:=(LPPSL*SQRT(PI)+CDZ*KEBP*TTB0)/(LPPSL*SQRT(PI)+CDZ*KEBP);
      TTKR:=TTK;
      IF ( (TTK >= 1) OR (TTBM <= TTK) ) then GOTO 1;
      tracks := tracks + '*5';
//C     If new contact temperature changes the scenario of splat formation
//C     than go to the block of scenarios control
//C***********************************************************************
//C     The 1st stage: ideal sreading the drop over the surface
//C***********************************************************************


      Tspl1:= (sqr(CDZ/(2*Kappa)))* sqr(SQRT(1+4*PE*(1-EtaMu)/(CDZ*CDZ))-1);
      TDspl1:=Tspl1*T0;
      Hspl1:=CDZ*SQRT(Tspl1);    //  ! According to definition of solidification
      HDspl1:=DP*(CDZ*CDZ/(2*PE))*(SQRT(1+4*PE*(1-EtaMu)/(CDZ*CDZ))-1);
      Dspl1:=SQRT(2/(3*Hspl1)); //! Diameter of splat from balance of mass
//      WRITELN ('Dspl1=' + floattostr(Dspl1)); // !!!!! Control after 1st stage


//C***********************************************************************
//C     The 2nd stage: viscous inertia sreading the drop over the surface
//C***********************************************************************
      AA:=CDZ*DelMu;
      BB:=-Hspl1*DelMu;
      CC:=(1-DelMu*Tspl1)*CDZ;
      DD:=-(DelMu+(1-DelMu*Tspl1)*Hspl1);


//C***********************************************************************
//C     There were computed the coefficients of affected cubic equation
//C     a*y^3/2 + b*y + c*y^1/2 +d = 0
//C***********************************************************************
      PP:=-(Hspl1*Hspl1/(3*CDZ*CDZ)-(1-DelMu*Tspl1)/DelMu);
      QQ:=-((2/27)*step((Hspl1/CDZ),3)+(3*DelMu+2*(1-DelMu*Tspl1)*Hspl1)/(3*CDZ*DelMu));
//C***********************************************************************
//C     There were computed the coefficients of reduced cubic equation
//C     w^3 + p*w + q = 0
//C***********************************************************************




      Kappa2 := (4*(PP*PP*PP))/(27*(QQ*QQ));
      IF ( (1+Kappa2) >= 0 ) THEN GOTO 5;
      tracks := tracks + '*6';

//      WRITELN ( '1+Kappa2<0: Kappa2= '+ floattostr(Kappa2) );
      GOTO LRETURN;

5:
     tracks := tracks + '*7';
     IF ( (1+Kappa2) < 1 ) THEN GOTO 6;
     tracks := tracks + '*8';

      Sq_Br:=step ((SQRT(1+Kappa2)+1), 1/3 )-  step((SQRT(1+Kappa2)-1), 1/3);
      GOTO 7;
      tracks := tracks + '*9';

6:
      tracks := tracks + '*10';
      Sq_Br:=step((SQRT(1+Kappa2)+1),1/3)+  step((1-SQRT(1+Kappa2)),(1/3));
7:
      tracks := tracks + '*11';
      QQQ:=QQ;
      IF ( QQQ < 0 ) then QQQ:=-QQQ;
      WW:=step((QQQ/2),1/3)*Sq_Br;
      Ysq:=WW+Hspl1/(3*CDZ);

//C***********************************************************************
//C     The output parameters of 2nd stage
//C***********************************************************************
      Tspl2:=Ysq*Ysq-Tspl1;
      TDspl2:=Tspl2*T0;
      Hspl2:=CDZ*SQRT(Tspl1+Tspl2)-Hspl1;
      HDspl2:=Hspl2*L0;
//C***********************************************************************
//C     The final parameters of splat formed
//C***********************************************************************
      Tspl:= Tspl1+Tspl2;
      TDspl:=TDspl1+TDspl2;
      HDspl:=HDspl1+HDspl2;
//C**** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      Hspl:=CDZ*SQRT(Tspl1+Tspl2);
      Dspl:=SQRT(2/(3*Hspl)); // ! Diameter of splat from balance of mass
//      WRITELN ( 'Dspl=' + floattostr(Dspl)); // !!!!! Control after 2nd stage
//C**** !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      HB:=0;
      HP:=HDspl/DP;
10:
      tracks := tracks + '*12';
      TK0:=TTK0*TPM;
      TK:=TTK*TPM;


      GOTO LRETURN;
20:
      tracks := tracks + '*13';
 //  WRITELN ( 'DISC<0  ????, Scenario=1' );
      GOTO LRETURN;
100:
      tracks := tracks + '*14';
 // WRITELN ( 'By now only the 1st scenario is realized');
      GOTO LRETURN;


//--------------------------------------
  lreturn:

     tracks := tracks + '*20';
     Tc := TTK*TPM;

     if (SplatNum = 1) then
        begin
      AddToLogArh (1, 'KUPL', 2, 0, KUPL,  '');
      AddToLogArh (1, 'KUBS', 2, 0, KUBS,  '');
      AddToLogArh (1, 'FPB', 2, 0, FPB,  '');
      AddToLogArh (1, 'KEBP', 2, 0, KEBP,  '');

      AddToLogArh (1, 'R1', 2, 0, R1,  '');
      AddToLogArh (1, 'TTK0', 2, 0, TTK0,  '');
      AddToLogArh (1, 'APL', 2, 0, APL,  '');

      AddToLogArh (1, 'RE', 2, 0, RE,  '');
      AddToLogArh (1, 'WE', 2, 0, WE,  '');
      AddToLogArh (1, 'PE', 2, 0, PE,  '');
      AddToLogArh (1, 'PR', 2, 0, PR,  '');
      AddToLogArh (1, 'TdD', 2, 0, TdD,  '');
      AddToLogArh (1, 'Alfa', 2, 0, Alfa,  '');

      AddToLogArh (1, 'P', 2, 0, P,  '');
      AddToLogArh (1, 'Q', 2, 0, Q,  '');
      AddToLogArh (1, 'DISCR', 2, 0, DISCR,  '');
      AddToLogArh (1, 'CDZ0', 2, 0, CDZ0,  '');
      AddToLogArh (1, 'Chi', 2, 0, Chi,  '');
      AddToLogArh (1, 'CW1', 2, 0, CW1,  '');
      AddToLogArh (1, 'CW2', 2, 0, CW2,  '');
      AddToLogArh (1, 'Td', 2, 0, Td,  '');


      AddToLogArh (1, 'DelMuD', 2, 0, DelMuD,  '');
      AddToLogArh (1, 'Beta', 2, 0, Beta,  '');
      AddToLogArh (1, 'EtaMu', 2, 0, EtaMu,  '');
      AddToLogArh (1, 'T0', 2, 0, T0,  '');
      AddToLogArh (1, 'L0', 2, 0, L0,  '');
      AddToLogArh (1, 'Kappa', 2, 0, Kappa,  '');
      AddToLogArh (1, 'DiamD', 2, 0, DiamD,  '');
      AddToLogArh (1, 'ALPHAC', 2, 0, ALPHAC,  '');

      AddToLogArh (1, 'TTKR', 2, 0, TTKR,  '');
      AddToLogArh (1, 'CDZ', 2, 0, CDZ,  '');

      AddToLogArh (1, 'Tspl1', 2, 0, Tspl1,  '');
      AddToLogArh (1, 'TDspl1', 2, 0, TDspl1,  '');
      AddToLogArh (1, 'Hspl1', 2, 0, Hspl1,  '');
      AddToLogArh (1, 'HDspl1', 2, 0, HDspl1,  '');
      AddToLogArh (1, 'Dspl1', 2, 0, Dspl1,  '');
      AddToLogArh (1, 'AA', 2, 0, AA,  '');
      AddToLogArh (1, 'BB', 2, 0, BB,  '');
      AddToLogArh (1, 'CC', 2, 0, CC,  '');
      AddToLogArh (1, 'DD', 2, 0, DD,  '');
      AddToLogArh (1, 'PP', 2, 0, PP,  '');
      AddToLogArh (1, 'QQ', 2, 0, QQ,  '');
      AddToLogArh (1, 'Kappa2', 2, 0, Kappa2,  '');
      AddToLogArh (1, 'Sq_Br', 2, 0, Sq_Br,  '');
      AddToLogArh (1, 'QQQ', 2, 0, QQQ,  '');
      AddToLogArh (1, 'WW', 2, 0, WW,  '');
      AddToLogArh (1, 'Ysq', 2, 0, Ysq,  '');
      AddToLogArh (1, 'Tspl2', 2, 0, Tspl2,  '');
      AddToLogArh (1, 'TDspl2', 2, 0, TDspl2,  '');
      AddToLogArh (1, 'Hspl2', 2, 0, Hspl2,  '');
      AddToLogArh (1, 'HDspl2', 2, 0, HDspl2,  '');
      AddToLogArh (1, 'Tspl', 2, 0, Tspl,  '');
      AddToLogArh (1, 'TDspl', 2, 0, TDspl,  '');
      AddToLogArh (1, 'HDspl', 2, 0, HDspl,  '');
      AddToLogArh (1, 'HP', 2, 0, HP,  '');
      AddToLogArh (1, 'HB', 2, 0, HB,  '');

          AddToLogArh (1, 'TRACK', 3, 0, 0,  tracks);

        end;


 //}
end;


