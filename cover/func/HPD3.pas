//  Металлокерамика
procedure HPB3 (
     var REGIME:integer; var Tspl:Real; var TDspl:Real; var HP:real;
     var HB:real; var TK0:real; var TK:real;
     var RE:real; var WE:real; var PR:real; var PE:real; var KEBP:real;
     var KUPL:real; var KUBS:real; var FPB:real;
     var CDZ:Real; var DP:Real; var UP:Real; var TP0:Real; var TB0:real;

      ROPS: real; ROPL: real; CPS: real;  CPL: real;  LPS: real;
      LPL: real;  TPM: real; LP: real;  MUPL: real; SIGMAP:Real;

      ROBS: real; ROBL: real;  CBS: real;  CBL: real; LBS: real;
      LBL: real;  TBM: real;  LB: real;  MUBL: real; SIGMAB:Real
                );

//C***********************************************************************
//C  The program for analysis of the metal oxide droplet - substrate
//C  interaction (Pr>1) with the help of one-dimensional model of the
//C  equilibrium solidification.
//C***********************************************************************


var TTP0,TTB0,TTBM,APL,TTK0,LPPLS,R1,P,Q,TTK,HPR,LBPLL,LBPSL,LBBSL,R2,CKS,LBPLS,LPPSL,D1,D2,CND:real;
    TdD, ALPHAC, DISCR, CDZ0, TTKR, Kappa, Ysqrt, Hsplat, Dsplat, Hsrough, Dsrough:real;

    PI:real;

//    SQRTPI,ALFAC,LPBLL,NREG1,NREG2,NREG3,NREG4,NREG:real;
//var
//      REAL     LPS,LPL,LP,MUPL,MUBL,LBS,LBL,LB,
//     *         KEBP,KUPL,KUBS,LBPLS,LPPLS,LPPSL,
//     *         LBPLL,LBPSL,LBBSL,Kappa

label lreturn, 1,10,20,100;
begin

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
//C     Computing a zero approach to the rate of solidification CDZ0
//C     do not taking into account the convection of the melt
      ALPHAC:=0;
      P:=(PI*LPPSL*KUPL+2*(1+ALPHAC)*KEBP*(TTP0-1))/R1;
      Q:=(2*LPPSL*(1-TTB0)/KUPL)*(1-(1+ALPHAC)*(TTP0-1)/((1-TTB0)*KEBP));
      DISCR:=1+4*Q/(P*P);
      IF ( DISCR < 0 ) then GOTO 20;
      CDZ0:=P*(SQRT(DISCR)-1)/2;
//C*****
      TTKR:=TTK0;
1:     IF ( TTKR >= MIN(1, TTBM) ) then GOTO 100;
      TTK:=(LPPSL*SQRT(PI)+CDZ0*KEBP*TTB0)/(LPPSL*SQRT(PI)+CDZ0*KEBP);
      TTKR:=TTK;
      IF ( TTKR >= MIN(1,TTBM) ) then  GOTO 100;
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
      CDZ:=P*(SQRT(DISCR)-1)/2;

//C     The contact temperature TTK taking into account the melting heat,
//C     see zero approach to contact temperature TTK0.

      TTK:=(LPPSL*SQRT(PI)+CDZ*KEBP*TTB0)/(LPPSL*SQRT(PI)+CDZ*KEBP);
      TTKR:=TTK;
      IF ( (TTK >= 1) OR (TTBM <= TTK) ) then GOTO 1;
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
      Kappa := 4*CDZ*CDZ/(27*PE);
      Ysqrt :=(1 /step (2*PE*CDZ, 1/3))* (step ( (SQRT(1+Kappa)+1) , 1/3)-  step ((SQRT(1+Kappa)-1),1/3));
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
      Hsrough:=step ((CDZ*CDZ/PE), 1/3);
      Dsrough:=SQRT(2/3)*( step (PE,1/6)) /  step (CDZ, 1/3);
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
10:    TK0:=TTK0*TPM;
      TK:=TTK*TPM;
      goto lRETURN;
20:  //  WRITELN ( 'DISC<0  ????, Scenario=1');
      goto lRETURN;
100:  // WRITELN ( 'By now only the 1st scenario is realized');

//--------------------------------------
  lreturn:
 //}
end;
