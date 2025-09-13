// металл исправленный

procedure HPB2 (var REGIME:integer; var FOS:real; var TAUS:real; var HP:real;
                var HB:real; var TK0:real; var TK:real; var PE:real; var KEBP:real;
                var KUPL:real; var KUBS:real; var FPB:real;
                var DP:real; var UP:real; var TP0:real; var TB0:real;
                var Tc:real; var SigmaI:real;


      ROPS: real; ROPL: real; CPS: real;  CPL: real;  LPS: real;
      LPL: real;  TPM: real; LP: real;  MUPL: real; //LBOILP: real; AWP: real;

      ROBS: real; ROBL: real;  CBS: real;  CBL: real; LBS: real;
      LBL: real;  TBM: real;  LB: real;  MUBL: real; LBOILB: real; AWB: real;
      SplatNum : integer

                );

var TTP0,TTB0,TTBM,APL,TTK0,LPPLS,R1,P,Q,CDZ,TTK,HPR,LBPLL,LBPSL,LBBSL,R2,CKS,RE,LBPLS,LPPSL,D1,D2,CND:real;
    SQRTPI,ALFAC,LPBLL,NREG1,NREG2,NREG3,NREG4,NREG,PI, TS:real;

    t1,t2,t3,t4:real;

    V, TDspl, Ea, const_k :real;
    tracks : string;



label 1,100,101,20,10, 201, lreturn,200,120,300,310,311,330,312,320,321,322,1000;
begin
      tracks := '*0';

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



1000:
  tracks := tracks + '*1';
  IF ( (TTK >= 1 ) OR (TTK >=TTBM) ) then  GOTO 100;

//C*******************************************************************
//C                          REGIME=1                                *
//C*******************************************************************
//C   The solidification of liquid particle on the solid substrate.  *
//C*******************************************************************
1:
      tracks := tracks + '*2';
      REGIME:=1;
      NREG:=NREG+1;

      log ('Режим 1 The solidification of liquid particle on the solid substrate.');

      P:=(PI*LPPSL*KUPL+2*(1+ALFAC)*KEBP*(TTP0-1))/(SQRTPI*KEBP*KUPL); // LPPSP  странная переменная!
      Q:=1-((1+ALFAC)*(TTP0-1))/((1-TTB0)*KEBP);
      IF (Q <= 0) then GOTO 101;

      tracks := tracks + '*3';


//	If Q<0 solidification of flattening droplet is absent.
//	We change the regime on REGIME=2 or may be then REGIME=3.
      Q:=2*LPPSL*(1-TTB0)*Q/KUPL;
      CDZ:=P*(SQRT(1+4*Q/ step(P,2))-1)/2; // <======!!!!!!!!

      TTK:=(1+LPPLS*KEBP*TTB0*CDZ/SQRTPI)/(1+LPPLS*KEBP*CDZ/SQRTPI);
//	We have to check the new contact temperature and may be
//  to change regime on REGIME=4. Because CDZ>0 and TTK<1, we
//  check the inequality TTK<TTBM.
      IF ( TTK >= TTBM ) then  GOTO 300;
      tracks := tracks + '*4';

      FOS:=CDZ*(SQRT(1+4*PE/ step(CDZ,2) )-1)/(2*PE);     // <======== !!!!!!
      FOS:=FOS*FOS;
      TAUS:=FOS*DP*DP/APL;
//	Now we check the criterion of changing the regime of splat
//	formation PeFo*>0.96.
      IF ( PE*FOS > 0.96 ) then GOTO 101;
      tracks := tracks + '*5';
      HB:=0;
      HP:=1-PE*FOS;

10:
      tracks := tracks + '*6';
      TK0:=TTK0*TPM;
      TK:=TTK*TPM;
      goto lRETURN;


100:
      tracks := tracks + '*7';
      IF ( (TTK < 1 ) OR (TTK < TTBM) ) then GOTO 200;

      tracks := tracks + '*8';

//C*******************************************************************
//C                             REGIME=2                             *
//C*******************************************************************
//C   The flattening of the droplet with simultaneous                *
//C   partial melting of the substrate.                              *
//C*******************************************************************


101:
      tracks := tracks + '*9';
      REGIME:=2;
      NREG2:=NREG2+1;

      P:=SQRTPI*LBPLL/(1+ALFAC);
      P:=P+LBPSL*(1-TTB0/TTBM)/(SQRTPI*KEBP*KUBS);
      Q:=1-(1+ALFAC)*(TTP0/TTBM-1)/(KEBP*(1-TTB0/TTBM));
      IF ( Q >= 0 ) then GOTO 201;
      tracks := tracks + '*10';
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
      tracks := tracks + '*11';

      IF ( (TTK < 1 ) AND (TTK < TTBM) ) then GOTO 1;
      tracks := tracks + '*12';
      GOTO 10;
//
//	Then it takes place the processes of recoiling and
//	simultaneous cooling and solidification of the obtained layerS.
//
200:
   tracks := tracks + '*13';
   IF ( (TTBM <= TTK) AND (TTK < 1) ) then GOTO 300;

//C*******************************************************************
//C                            REGIME=3                              *
//C*******************************************************************
//C   The flattening of the liquid particle on the solid substrate.  *
//C*******************************************************************
201:
      tracks := tracks + '*14';
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
      tracks := tracks + '*15';
      REGIME:=4;
      log ('Режим 4. The particles solidification with simultaneous partial melting of the substrate.');
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
      tracks := tracks + '*16';

      IF (P=0) then goto 310;
      tracks := tracks + '*17';
      IF (P>0) then goto 320;
      tracks := tracks + '*18';
310:
      tracks := tracks + '*19';
      IF (Q<0) then goto 311;
      tracks := tracks + '*20';
      IF (Q>=0) then goto 312;
      tracks := tracks + '*21';
//************                P=0,Q<=0             ******************
311:
      tracks := tracks + '*22';
      CDZ:=SQRT(-Q);
      GOTO 330;

312:
      tracks := tracks + '*23';
      writeln  ('P=0,Q>0,  REGIME=4');
      goto lRETURN;
320:
      tracks := tracks + '*24';
      if Q < 0 then goto 322;
      tracks := tracks + '*25';
      if Q >= 0 then goto 321;
      tracks := tracks + '*26';

321:
      tracks := tracks + '*27';
      writeln  ('P<0,Q>=0,  REGIME=4');
      goto lRETURN;

322:
      tracks := tracks + '*28';
      CDZ:=-P/2+SQRT(step((P/2),2)-Q);
330:
      tracks := tracks + '*29';
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
      tracks := tracks + '*30';
      Tc := TTK*TPM;

//      vrb.Tc:=TTK*TPM;

      log ('Температура в контакте '+floattostr(Tc)+' К');

//			CalcCorrelations(tpo, tbo, upo, dpo);
      Ea := 0.5*LBOILB*AWB/9.64862e7;
			V := 1.0e13;
      const_k := 1.38e-23/1.60219e-19;
      TDspl:= ((DP*DP)/(APL)) * FOS ;  //поправить
      t1:=Ea/const_k/Tc;
      t2:=-V*TDspl/exp(t1);
//      vrb.adg_sigma_i := 1.-exp(-V*TDspl/exp(Ea/const_k/vrb.Tc));
//      vrb.adg_sigma_i := 1.-exp(t2);
      SigmaI := 1.-exp(t2);

     if (SplatNum = 1) then
        begin
          AddToLogArh (1, 'TTK', 2, 0, TTK,  '');
          AddToLogArh (1, 'Ea', 2, 0, Ea,  '');
          AddToLogArh (1, 'FOS', 2, 0, FOS,  '');
          AddToLogArh (1, 'HB', 2, 0, HB,  '');
          AddToLogArh (1, 'TAUS', 2, 0, TAUS,  '');
          AddToLogArh (1, 't1', 2, 0, t1,  '');
          AddToLogArh (1, 't2', 2, 0, t2,  '');
          AddToLogArh (1, 'SigmaI', 2, 0, SigmaI,  '');
          AddToLogArh (1, 'TDspl', 2, 0, TDspl,  '');
          AddToLogArh (1, 'HP', 2, 0, HP,  '');
          AddToLogArh (1, 'CDZ', 2, 0, CDZ,  '');
          AddToLogArh (1, 'P', 2, 0, P,  '');
          AddToLogArh (1, 'Q', 2, 0, Q,  '');
          AddToLogArh (1, 'RE', 2, 0, RE,  '');
          AddToLogArh (1, 'CKS', 2, 0, CKS,  '');
          AddToLogArh (1, 'TK0', 2, 0, TK0,  '');
          AddToLogArh (1, 'APL', 2, 0, APL,  '');
          AddToLogArh (1, 'PE', 2, 0, PE,  '');
          AddToLogArh (1, 'KEBP', 2, 0, KEBP,  '');

          AddToLogArh (1, 'TRACK', 3, 0, 0,  tracks);

        end;


      log ('Коэф сцепления сплэта: '+ floattostr(SigmaI));

end;
