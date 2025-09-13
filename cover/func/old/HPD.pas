// металл - первая (не исправленная) версия
procedure HPB1 (var REGIME:integer; var FOS:real; var TAUS:real; var HP:real;
                var HB:real; var TK0:real; var TK:real; var PE:real; var KEBP:real;
                var KUPL:real; var KUBS:real; var FPB:real;
                var DP:real; var UP:real; var TP0:real; var TB0:real;

      ROPS: real; ROPL: real; CPS: real;  CPL: real;  LPS: real;
      LPL: real;  TPM: real; LP: real;  MUPL: real;

      ROBS: real; ROBL: real;  CBS: real;  CBL: real; LBS: real;
      LBL: real;  TBM: real;  LB: real;  MUBL: real
                );

var TTP0,TTB0,TTBM,APL,TTK0,LPPLS,R1,P,Q,CDZ,TTK,HPR,LBPLL,LBPSL,LBBSL,R2,CKS,RE,LBPLS,LPPSL,D1,D2,CND:real;
    SQRTPI,ALFAC,LPBLL,NREG1,NREG2,NREG3,NREG4,NREG,PI:real;

label 1,100,101,20,10, 201, lreturn,200,120,300,310,311,330,312,320,321,322,1000;
begin

      PI:=3.1415926;
      SQRTPI:=SQRT(PI);
      ALFAC:=0.259;
      TTP0:=TP0/TPM;
      TTB0:=TB0/TPM;
      TTBM:=TBM/TPM;

      APL:=LPL/(ROPL*CPL);
      PE:=UP*DP/APL;
      KUPL:=LP/(CPL*TPM);
      KUBS:=LB/(CBS*TBM);
      FPB:=ROPL*LP/(ROBS*LB);
      KEBP:=SQRT(ROBS*CBS*LBS/(ROPL*CPL*LPL));

      LPPLS:=LPL/LPS;
      LPPSL:=1/LPPLS;
      LBPLL:=LBL/LPL;
      LPBLL:=1/LBPLL;
      LBPSL:=LBS/LPL;
      LBBSL:=LBS/LBL;
      LBPLS:=LBL/LPS;
      TTK0:=(TTP0+KEBP*TTB0)/(1+KEBP);
      NREG1:=0;
      NREG2:=0;
      NREG3:=0;
      NREG4:=0;
      TTK:=TTK0; //		! Zero approach to real contact temperature

1000:  IF ( (TTK >= 1 ) OR (TTK >=TTBM) ) then  GOTO 100;

//C*******************************************************************
//C                          REGIME=1                                *
//C*******************************************************************
//C   The solidification of liquid particle on the solid substrate.  *
//C*******************************************************************

1:
      REGIME:=1;
      NREG:=NREG+1;

      log ('Режим 1 The solidification of liquid particle on the solid substrate.');

      P:=(PI*LPPSL*KUPL+2*(1+ALFAC)*KEBP*(TTP0-1))/(SQRTPI*KEBP*KUPL); // LPPSP  странная переменная!
      Q:=1-((1+ALFAC)*(TTP0-1))/((1-TTB0)*KEBP);
      IF (Q <= 0) then GOTO 101;



//	If Q<0 solidification of flattening droplet is absent.
//	We change the regime on REGIME=2 or may be then REGIME=3.
      Q:=2*LPPSL*(1-TTB0)*Q/KUPL;
      CDZ:=P*(SQRT(1+4*Q/ step(P,2))-1)/2; // <======!!!!!!!!

      TTK:=(1+LPPLS*KEBP*TTB0*CDZ/SQRTPI)/(1+LPPLS*KEBP*CDZ/SQRTPI);
//	We have to check the new contact temperature and may be
//  to change regime on REGIME=4. Because CDZ>0 and TTK<1, we
//  check the inequality TTK<TTBM.
      IF ( TTK >= TTBM ) then  GOTO 300;
      FOS:=CDZ*(SQRT(1+4*PE/ step(CDZ,2) )-1)/(2*PE);     // <======== !!!!!!
      FOS:=FOS*FOS;
      TAUS:=FOS*DP*DP/APL;
//	Now we check the criterion of changing the regime of splat
//	formation PeFo*>0.96.
      IF ( PE*FOS > 0.96 ) then GOTO 101;
      HB:=0;
      HP:=1-PE*FOS;

10:
      TK0:=TTK0*TPM;
      TK:=TTK*TPM;
      goto lRETURN;


100:
      IF ( (TTK < 1 ) OR (TTK < TTBM) ) then GOTO 200;


//C*******************************************************************
//C                             REGIME=2                             *
//C*******************************************************************
//C   The flattening of the droplet with simultaneous                *
//C   partial melting of the substrate.                              *
//C*******************************************************************

101:
      REGIME:=2;
      NREG2:=NREG2+1;

      P:=SQRTPI*LBPLL/(1+ALFAC);
      P:=P+LBPSL*(1-TTB0/TTBM)/(SQRTPI*KEBP*KUBS);
      Q:=1-(1+ALFAC)*(TTP0/TTBM-1)/(KEBP*(1-TTB0/TTBM));
      IF ( Q >= 0 ) then GOTO 201;
      Q:=LBPLL*LBPSL*(1-TTB0/TTBM)/((1+ALFAC)*KEBP*KUBS)*Q;
      CKS:=P*(SQRT(1-4*Q/step(P,2))-1)/2;
      RE:=ROPL*DP*UP/MUPL;

//	The formula of Jones is used to predict the thickness of
//	flattened liquid layer.
      HP:=0.496/step(RE,0.25);
      FOS:=(1-HP)/PE;
      TAUS:=FOS*DP*DP/APL;
      HB:=-CKS*SQRT(FOS);
      TTK:=(TTBM+(1+ALFAC)*LPBLL*CKS*TTP0/SQRTPI)/(1+(1+ALFAC)*LPBLL*CKS/SQRTPI);

      log ('Режим 2 (в новом 4). HB='+ floattostr(HB)+'The flattening of the droplet with simultaneous partial melting of the substrate.');

      IF ( (TTK >= 1) AND (TTK < TTBM) ) then GOTO 201;
      IF ( (TTK < 1 ) AND (TTK < TTBM) ) then GOTO 1;
      GOTO 10;
//
//	Then it takes place the processes of recoiling and
//	simultaneous cooling and solidification of the obtained layerS.
//
200:   IF ( (TTBM <= TTK) AND (TTK < 1) ) then GOTO 300;

//C*******************************************************************
//C                            REGIME=3                              *
//C*******************************************************************
//C   The flattening of the liquid particle on the solid substrate.  *
//C*******************************************************************
201:
      REGIME:=3;
      log ('Режим 3. The flattening of the liquid particle on the solid substrate. ');
      NREG:=NREG+1;
      RE:=ROPL*DP*UP/MUPL;
      HP:=0.496/step(RE,0.4);      //     HP:=0.4/step(RE,0.4);
      R1:=1/KEBP;
      R2:=1+R1;
      TTK:=TTK0+(TTP0-TTB0)*(1-EXP(-R1*R2/4))/R2;
      FOS:=(1-HP)/PE;
      TAUS:=FOS*DP*DP/APL;
      HB:=0;
      GOTO 10;

//	Then it takes place the processes of recoiling and
//	simultaneous cooling and solidification of flattened droplet.

//C*******************************************************************
//C                            REGIME=4                              *
//C*******************************************************************
//C   The particles' solidification with simultaneous partial        *
//C   melting of the substrate.                                      *
//C*******************************************************************
300:
      REGIME:=4;
      NREG4:=NREG4+1;
      D1:=KEBP*(TTBM-TTB0)/SQRTPI;
      D2:=(1+ALFAC)*(TTP0-1)/SQRTPI;
      R1:=FPB+LBPLS;
      R2:=R1+FPB;
      R1:=KUPL*R1;
      P:=2*(D2*R2-D1*FPB)/R1;
      Q:=2*(2*D2*(D2-D1)*FPB-LBPLL*KUPL*(1-TTBM));

      Q:=Q/(KUPL*R1);
      IF (P<0) then goto 320;
      IF (P=0) then goto 310;
      IF (P>0) then goto 320;
310:
      IF (Q<0) then goto 311;
      IF (Q>=0) then goto 312;
//************                P=0,Q<=0             ******************
311:
      CDZ:=SQRT(-Q);
      GOTO 330;

312:
      writeln  ('P=0,Q>0,  REGIME=4');
      goto lRETURN;
320:
      if Q < 0 then goto 322;
      if Q >= 0 then goto 321;

321:   writeln  ('P<0,Q>=0,  REGIME=4');
      goto lRETURN;

322:
      CDZ:=-P/2+SQRT(step((P/2),2)-Q);
330:
      CKS:=FPB*(CDZ+2*(D2-D1)/KUPL);
      CND:=CKS/CDZ;
      TTK:=(CND+LBPLS*TTBM)/(CND+LBPLS);
      FOS:=CDZ*(SQRT(1+4*PE/ step(CDZ,2))-1)/(2*PE);
      FOS:=FOS*FOS;
      TAUS:=FOS*DP*DP/APL;
      HB:=-CKS*SQRT(FOS);
      log ('Режим 4 (в новом 2). HB='+ floattostr(HB));

      HP:=1-PE*FOS;
      GOTO 10;

//      END

//--------------------------------------
  lreturn:

end;
