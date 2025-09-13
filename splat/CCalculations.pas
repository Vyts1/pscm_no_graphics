constructor CCalculations.Create;
begin
// ShowMessage('bla');
	m_tetapo := 0;
	m_tetabo := 0;

  m_data:=CMyData.Create;

  m_DBSet_part:=CCutBoxSet.Create;
  m_DBSet_sub:=CCutBoxSet.Create;



  { cc1:=CCutBoxSet.Create;
 if cc1.Open then
   cc1.Move(1);
 }

{
  m_DBSet_part.Open;
//  m_DBSet_part.Move(1);
  m_DBSet_part.Move(m_data.m_xconst_partMaterial+1);
  m_DBSet_part.Close;

  m_DBSet_sub.Open;
  m_DBSet_sub.Move(m_data.m_xconst_subMaterial+1);
//  m_DBSet_sub.Move(2);
  m_DBSet_sub.Close;
 }

	m_bScenario := true; // Сначала установим, что условия выбранного сценария выполняются
	m_bScenario_old := true;
	m_bScenario_result := true;
	m_scen_tpo := 0;
	m_bScenario_left_set := false;

  inherited Create;

end; //}





function CCalculations.GetPeMin() : double;
var a : double;
begin
//----------
	a := m_DBSet_part.m_Lml/m_DBSet_part.m_ROml/m_DBSet_part.m_CPml*1e6;
	GetPeMin:= (m_data.m_Dpmin * m_data.m_upmin) / a;
end;

function CCalculations.GetPeMax() : double;
var a : double;
begin
//----------
	a := m_DBSet_part.m_Lml/m_DBSet_part.m_ROml/m_DBSet_part.m_CPml*1e6;
	GetPeMax:=(m_data.m_Dpmax)*(m_data.m_upmax)/a;
end;


function CCalculations.GetFoMin() : double;
begin
//----------
	GetFoMin:= m_DBSet_part.m_Lml/m_DBSet_part.m_ROml/m_DBSet_part.m_CPml*(m_data.m_Dpmin)/(m_data.m_Dpmax)/(m_data.m_Dpmax)/(m_data.m_upmax)*1e6;
end;

function CCalculations.GetFoMax() : double;
begin
//----------
	GetFoMax:=m_DBSet_part.m_Lml/m_DBSet_part.m_ROml/m_DBSet_part.m_CPml*(m_data.m_Dpmax)/(m_data.m_Dpmin)/(m_data.m_Dpmin)/(m_data.m_upmin)*1e6;
end;

function CCalculations.GetTpmin_min() : double;
begin
//----------
	GetTpmin_min:=m_DBSet_part.m_Tm;
end;

function CCalculations.GetTpmin_max() : double;
begin
//----------
	GetTpmin_max:=m_DBSet_part.m_TBoil;
end;




procedure CCalculations.PrepareFunction(n:integer);
var temp_var:double;
begin
//----------
 case n of
   -1:
       begin // Расчет общих переменных
		m_Dpmin := m_data.m_Dpmin*(1e-6);
		m_Dpmax := m_data.m_Dpmax*(1e-6);
		m_a := m_DBSet_part.m_Lml/m_DBSet_part.m_ROml/m_DBSet_part.m_CPml;

		m_Kupl := m_DBSet_part.m_Lm/m_DBSet_part.m_CPml/m_DBSet_part.m_Tm;
		m_Lppsl := m_DBSet_part.m_Lms/m_DBSet_part.m_Lml;
		m_Ke:=sqrt(m_DBSet_sub.m_Lms*m_DBSet_sub.m_ROms*m_DBSet_sub.m_CPms/(m_DBSet_part.m_Lml*m_DBSet_part.m_ROml*m_DBSet_part.m_CPml));
		m_ac := 0.0;

       end;

   8:
       begin
		var8_A := sqrt(CALC_PI)*m_Lppsl/m_Ke;
		var8_B := 2.0*(1.0+m_ac)/CALC_SQRT_PI/m_Kupl;
		var8_C := 2.0*m_Lppsl/m_Kupl;
		var8_D := -2.0*m_Lppsl*(1.0+m_ac)/m_Ke/m_Kupl;

       end;

   9:
       begin
		temp_var := m_data.m_ghsm;
		var9_a := temp_var/sqrt(1-temp_var);

       end;


   10:
       begin
		temp_var := m_data.m_gDsm;
		var10_a := sqrt(2/3)/temp_var/sqrt(3/2*temp_var*temp_var-1);

       end;

   17:
       begin
		var17_1 := CALC_PI*m_Lppsl*m_Kupl;
		var17_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var17_3 := 2*m_Lppsl/m_Kupl;
		var17_4 := m_Ke/m_Lppsl;
		m_ttdTdt := m_data.m_ttdTdt;
		var17_5 := m_ttdTdt*m_Dpmin*m_Dpmin/m_a/m_DBSet_part.m_Tm;

       end;

   18:
       begin
		var17_1 := CALC_PI*m_Lppsl*m_Kupl;
		var17_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var17_3 := 2.*m_Lppsl/m_Kupl;
		var17_4 := m_Ke/m_Lppsl;
		var18_1 := m_Dpmin*m_Dpmin/m_a;
		var18_2 := m_Lppsl*m_Ke;
		m_tcSGbm := m_data.m_tcSGbm;
		var18_3 := ln(1-m_tcSGbm);
		var18_4 := CALC_SQRT_PI*m_DBSet_part.m_Tm;

       end;


   100:
       begin

		m_sens_hs := (m_data.m_dshsm);
		m_dPe := (m_data.m_dsdPe)/100.;
		m_dtetapo := (m_data.m_dsdTetaPo)/100;
		m_dtetabo := (m_data.m_dsdTetaBo)/100;
		var100_1 := CALC_PI*m_Lppsl*m_Kupl;
		var100_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var100_3 := 2.*m_Lppsl/m_Kupl;
		var100_A := sqrt(CALC_PI)*m_Lppsl/m_Ke;
		var100_B := 2.*(1.+m_ac)/CALC_SQRT_PI/m_Kupl;
		var100_C := 2.*m_Lppsl/m_Kupl;
		var100_D := -2.*m_Lppsl*(1.+m_ac)/m_Ke/m_Kupl;

       end;


   102:
       begin
		m_sens_hs := (m_data.m_ishsm);
		m_sens_dhs := (m_data.m_isdhsm);
		m_pe := (m_data.m_isPe);
		m_tpo := (m_data.m_isTpo);
		m_tbo := (m_data.m_isTbo);
		m_dPe := (m_data.m_isdPe)/100.;
		m_dtetapo := (m_data.m_isdtetapo)/100.;
		m_dtetabo := (m_data.m_isdtetabo)/100.;
		var100_1 := CALC_PI*m_Lppsl*m_Kupl;
		var100_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var100_3 := 2.*m_Lppsl/m_Kupl;
		var100_A := sqrt(CALC_PI)*m_Lppsl/m_Ke;
		var100_B := 2.*(1.+m_ac)/CALC_SQRT_PI/m_Kupl;
		var100_C := 2.*m_Lppsl/m_Kupl;
		var100_D := -2.*m_Lppsl*(1.+m_ac)/m_Ke/m_Kupl;

       end;


   200:
       begin
    // Корреляции
		var200_1 := CALC_PI*m_Lppsl*m_Kupl;
		var200_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var200_3 := 2.*m_Lppsl/m_Kupl;
		var200_4 := m_Ke/m_Lppsl;
		m_corr_tpmin := m_data.m_corr_Tpmin;
		m_corr_tpmax := m_data.m_corr_Tpmax;
		m_corr_tpo := m_data.m_corr_Tpo;
		m_corr_tbmin := m_data.m_corr_Tbmin;
		m_corr_tbmax := m_data.m_corr_Tbmax;
		m_corr_tbo := m_data.m_corr_Tbo;
		m_corr_upmin := m_data.m_corr_upmin;
		m_corr_upmax := m_data.m_corr_upmax;
		m_corr_upo := m_data.m_corr_upo;
		m_corr_Dpmin := (m_data.m_corr_Dpmin)*1e-6;
		m_corr_Dpmax := (m_data.m_corr_Dpmax)*1e-6;
		m_corr_Dpo := (m_data.m_corr_Dpo)*1e-6;
		m_corr_A1 := (m_data.m_corr_A1);
		m_corr_alpha := (m_data.m_corr_alpha);
		m_corr_beta := (m_data.m_corr_beta);
		m_corr_B1 := m_data.m_corr_B1;
		m_corr_gamma := (m_data.m_corr_gamma);
		m_Spb := m_DBSet_part.m_ROml*m_DBSet_part.m_Lml/m_DBSet_sub.m_ROml/m_DBSet_sub.m_Lml;
		m_Lbpls := m_DBSet_sub.m_Lml/m_DBSet_part.m_Lms;
		m_Lbpll := m_DBSet_sub.m_Lml/m_DBSet_part.m_Lml;


       end;


   300:
       begin
    // Постоянный один из четырех аргументов
		var200_1 := CALC_PI*m_Lppsl*m_Kupl;
		var200_2 := CALC_SQRT_PI*m_Ke*m_Kupl;
		var200_3 := 2.*m_Lppsl/m_Kupl;
		var200_4 := m_Ke/m_Lppsl;

		m_Spb := m_DBSet_part.m_ROml*m_DBSet_part.m_Lml/m_DBSet_sub.m_ROml/m_DBSet_sub.m_Lml;
		m_Lbpls := m_DBSet_sub.m_Lml/m_DBSet_part.m_Lms;
		m_Lbpll := m_DBSet_sub.m_Lml/m_DBSet_part.m_Lml;

		m_xconst_tpmin := (m_data.m_xconst_Tpmin);
		m_xconst_tpmax := (m_data.m_xconst_Tpmax);
		m_xconst_tpo := (m_data.m_xconst_Tpo);
		m_xconst_tbmin := (m_data.m_xconst_Tbmin);
		m_xconst_tbmax := (m_data.m_xconst_Tbmax);
		m_xconst_tbo := (m_data.m_xconst_Tbo);
		m_xconst_upmin := (m_data.m_xconst_upmin);
		m_xconst_upmax := (m_data.m_xconst_upmax);
		m_xconst_upo := (m_data.m_xconst_upo);
		m_xconst_Dpmin := (m_data.m_xconst_Dpmin)*1.0e-6;
		m_xconst_Dpmax := (m_data.m_xconst_Dpmax)*1.0e-6;
		m_xconst_Dpo := (m_data.m_xconst_Dpo)*1.0e-6;

       end;

 end;

end;

function CCalculations.GetFunctionValue(n:integer; tpo:double; tbo:double; pe:double):double;
var
//	double tetac, cz;
  Fo, sqrt_Fo,	P, Q, PP,	res :double;

	tetapo, tetabo,	var1:double;

	Ea, const_k, gamma:double;

	V, t,
	hs, var_a, Rp, Rb:double;
	dhs,
	dPe, dtetapo, dtetabo:double;
	hsm:double;
//	CFile file;
//	float test1, test2;
  hso:double;

begin
//----------
	Ea := 0.5*m_DBSet_sub.m_LBoil*m_DBSet_sub.m_AW/9.64862e7;
	const_k := 1.38e-23/1.60219e-19;
	gamma := 1.0;
  hso:=0.041;

 case n of
   8:
       begin

		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		GetFunctionValue:= (hso*var8_B*sqrt(pe)-var8_D)*tetapo+var8_C*tetabo-((var8_C-var8_D)+(var8_B-var8_A)*hso*sqrt(pe)-hso*hso*pe);

       end;



   9:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		GetFunctionValue:= (var9_a*var8_B*sqrt(pe)-var8_D)*tetapo+var8_C*tetabo-((var8_C-var8_D)+(var8_B-var8_A)*var9_a*sqrt(pe)-var9_a*var9_a*pe);
       end;


   10:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		GetFunctionValue := (var10_a*var8_B*sqrt(pe)-var8_D)*tetapo+var8_C*tetabo-((var8_C-var8_D)+(var8_B-var8_A)*var10_a*sqrt(pe)-var10_a*var10_a*pe);
       end;

   17:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var17_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var17_2;
		Q := var17_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		var1 := var17_4*cz;
		tetac := (CALC_SQRT_PI+var1*tetabo)/(CALC_SQRT_PI+var1);
		Fo := cz*(sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
		GetFunctionValue:= (m_Lppsl*(1.-tetac)-m_Kupl*cz*cz/2)/2./Fo-var17_5;
       end;

   18:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		PP := 0;
		V := 1e13;
		P := (var17_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var17_2;
		Q := var17_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		var1 := var17_4*cz;
		tetac := (CALC_SQRT_PI+var1*tetabo)/(CALC_SQRT_PI+var1);
		Fo := cz*(sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
		t := Fo*var18_1;
		res := (var18_4+var18_2*cz*tbo)/(CALC_SQRT_PI+var18_2*cz)-(Ea-gamma*0)/const_k/ln(-V*t/var18_3);
		GetFunctionValue:=res;
       end;

   100:
       begin

// Прямая чувствительность
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var100_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var100_2;
		Q := var100_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		Rp := 4.*(1+m_ac)*tetapo/CALC_SQRT_PI/(2.*cz+P)/m_Kupl*(1.+CALC_SQRT_PI*m_Lppsl/cz/m_Ke);
		Rb := 4.*m_Lppsl*tetabo/(2.*cz+P)/cz/m_Kupl;
		dhs := -(1.-m_sens_hs)/(2.-m_sens_hs)*(m_dPe+Rp*m_dtetapo+Rb*m_dtetabo)*m_sens_hs;
		hs := m_sens_hs-dhs;
		var_a := hs/sqrt(1.-hs);
		GetFunctionValue:= (var_a*var100_B*sqrt(pe)-var100_D)*tetapo+var100_C*tetabo-((var100_C-var100_D)+(var100_B-var100_A)*var_a*sqrt(pe)-var_a*var_a*pe);

       end;

   101:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		hs := m_sens_hs+dhs;
		var_a := hs/sqrt(1.-hs);
		GetFunctionValue:= (var_a*var100_B*sqrt(pe)-var100_D)*tetapo+var100_C*tetabo-((var100_C-var100_D)+(var100_B-var100_A)*var_a*sqrt(pe)-var_a*var_a*pe);

       end;

   102:
       begin
    // Обратная чувствительность
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		hs := m_sens_hs+m_sens_dhs;
		var_a := hs/sqrt(1.-hs);
		GetFunctionValue:= (var_a*var100_B*sqrt(pe)-var100_D)*tetapo+var100_C*tetabo-((var100_C-var100_D)+(var100_B-var100_A)*var_a*sqrt(pe)-var_a*var_a*pe);

       end;

   103:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		hs := m_sens_hs-m_sens_dhs;
		var_a := hs/sqrt(1.-hs);
		GetFunctionValue:= (var_a*var100_B*sqrt(pe)-var100_D)*tetapo+var100_C*tetabo-((var100_C-var100_D)+(var100_B-var100_A)*var_a*sqrt(pe)-var_a*var_a*pe);

       end;

   104:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var100_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var100_2;
		Q := var100_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		Rp := 4.*(1+m_ac)*tetapo/CALC_SQRT_PI/(2.*cz+P)/m_Kupl*(1.+CALC_SQRT_PI*m_Lppsl/cz/m_Ke);
		Rb := 4.*m_Lppsl*tetabo/(2.*cz+P)/cz/m_Kupl;
		dPe := ((2.-m_sens_hs)/(1.-m_sens_hs)*m_sens_dhs/m_sens_hs+Rp*m_dtetapo+Rb*m_dtetabo)*pe;
		GetFunctionValue:= dPe;

       end;

   105:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var100_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var100_2;
		Q := var100_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		Rp := 4.*(1+m_ac)*tetapo/CALC_SQRT_PI/(2.*cz+P)/m_Kupl*(1.+CALC_SQRT_PI*m_Lppsl/cz/m_Ke);
		Rb := 4.*m_Lppsl*tetabo/(2.*cz+P)/cz/m_Kupl;
		dtetapo := tpo/Rp*(m_dPe-(2.-m_sens_hs)/(1.-m_sens_hs)*m_sens_dhs/m_sens_hs-Rb*m_dtetabo);
		GetFunctionValue:= dtetapo;

       end;

   106:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var100_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var100_2;
		Q := var100_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		Rp := 4.*(1+m_ac)*tetapo/CALC_SQRT_PI/(2.*cz+P)/m_Kupl*(1.+CALC_SQRT_PI*m_Lppsl/cz/m_Ke);
		Rb := 4.*m_Lppsl*tetabo/(2.*cz+P)/cz/m_Kupl;
		dtetabo := tbo/Rb*(m_dPe-(2.-m_sens_hs)/(1.-m_sens_hs)*m_sens_dhs/m_sens_hs-Rp*m_dtetapo);
		GetFunctionValue:= dtetabo;


       end;

   200:
       begin
// Для графиков зависимостей
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var200_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var200_2;
		Q := var200_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		sqrt_Fo := (cz*sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
		hsm := cz*sqrt_Fo;
		GetFunctionValue:= hsm;

       end;


   201:
       begin
		tetapo := tpo/m_DBSet_part.m_Tm;
		tetabo := tbo/m_DBSet_part.m_Tm;
		P := (var200_1+2.*(1.+m_ac)*m_Ke*(tetapo-1))/var200_2;
		Q := var200_3*(1.-tetabo)*(1.-(1.+m_ac)*(tetapo-1)/((1.-tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;
		sqrt_Fo := (cz*sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
		hsm := cz*sqrt_Fo;
		GetFunctionValue:= sqrt(2./(3.*hsm));

       end;

 end;





end;


function erf( x:double):double;
var P,A1,A2,A3,T:double;
begin
//----------
	P:=0.47047;
  A1:=0.34802;
  A2:=-0.09588;
  A3:=0.74785;
	if (x <= 5.0) then begin erf:=1.0; end
  else
   begin
  	T := 1.0/(1.0+P*x);
  	erf:= 1.0-T*(A1+T*(A2+T*A3))*exp(-x*x);
  end;
end;


procedure CCalculations.CalcCorrelations(tpo:double; tbo:double; upo:double; dpo:double);
var m_tetabm,m_Kubs:double;
    nScen:integer;
    P,Q,alpha:double;

    cw1,cw2,Td,DelMuD,beta,EtaMu,T0,L0,kappa,DelMu,Tspl1,TDspl1,Hspl1,HDspl1,Dspl1:double;

    kappa2,Sq_Br:double;
    Ysq,Tspl2,TDspl2,Hspl2,HDspl2,Tspl,var1,sqrt_Fo:double;
	  d1, d2,Tco,abms,Xs:double;

    str:string [100];
begin
//----------

	pe := upo*dpo/m_a;
	m_tetapo := tpo/m_DBSet_part.m_Tm;
	m_tetabo := tbo/m_DBSet_part.m_Tm;
	m_tetabm := m_DBSet_sub.m_Tm/m_DBSet_part.m_Tm;
	m_Kubs := m_DBSet_sub.m_Lm/m_DBSet_sub.m_CPms/m_DBSet_sub.m_Tm;

//  !!!!!!!! Важный момент выбор сценария
//	CMainFrame* pMainWnd = (CMainFrame*)m_pMainWnd;
//	nScen := pMainWnd->m_bMenu4 ? m_data.m_corr_Scen : m_data.m_xconst_nScen;

//	nScen := m_data.m_xconst_nScen; // <<---------- режим пространство2
//	nScen := m_data.m_Scen; // <<---------- обычный режим
//	nScen := m_data.m_corr_Scen; // <<---------- для режима графиков

  case BN of
   1,2: nScen := m_data.m_Scen;
   3: nScen := m_data.m_corr_Scen;
   4: nScen := m_data.m_xconst_nScen;
   else showmessage ('Как тут этот режим попал сюда!!!');
  end;


	if (Pr >= 1) then
	begin
		// ac = 0
		// Керамики, оксиды
		m_ac := 0;

		P := (var200_1+2.*(1.+m_ac)*m_Ke*(m_tetapo-1))/var200_2;
		Q := var200_3*(1.-m_tetabo)*(1.-(1.+m_ac)*(m_tetapo-1)/((1.-m_tetabo)*m_Ke));
		cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;

		alpha := upo/2./dpo;
		td := dpo/upo;
		xi := sqrt(2)*(2.-cz/sqrt(Pr))/3.;



		cw1 := step(2.*xi*xi, 1/3);
		cw2 := step(xi/sqrt(2), 1/3);
		Td := 1./(cw1*step(Pr, 1/3));
		DelMuD := xi*dpo/sqrt(Re);
		beta := upo/DelMuD/dpo;
		EtaMu := DelMuD/dpo;
		T0 := 1./step(beta*beta*m_a, 1/3);
		L0 := step(m_a/beta, 1/3);
		kappa := upo/step(beta*m_a*m_a, 1/3);
		DelMu := DelMuD/L0;
		Tspl1 := step(cz/2./kappa, 2)*step(sqrt(1.+4.*pe*(1.-EtaMu)/cz/cz)-1, 2);
		TDspl1 := Tspl1*T0;
		Hspl1 := cz*sqrt(Tspl1);
		HDspl1 := dpo*cz*cz/2./pe*(sqrt(1.+4.*pe*(1.-EtaMu)/cz/cz)-1);
		Dspl1 := sqrt(2./3./Hspl1);

		p := -Hspl1*Hspl1/3./cz/cz+(1.-DelMu*Tspl1)/DelMu;
		q := -(2./27.*step(Hspl1/cz, 3)+(3.*DelMu+2.*(1.-DelMu*Tspl1)*Hspl1)/3./cz/DelMu);


		kappa2 := 4.*p*p*p/27./q/q;

		if (1+kappa2 >= 1)   then
                               Sq_Br := step(sqrt(1.+kappa2)+1., 1/3)-step(sqrt(1.+kappa2)-1., 1/3)
                         else
                               Sq_Br := step(sqrt(1.+kappa2)+1., 1/3)+step(1.-sqrt(1.+kappa2), 1/3);

		w := step(abs(q)/2., 1/3)*Sq_Br;


		Ysq := w+Hspl1/3./cz;
		Tspl2 := Ysq*Ysq-Tspl1;
		TDspl2 := Tspl2*T0;
		Hspl2 := cz*sqrt(Tspl1+Tspl2)-Hspl1;
		HDspl2 := Hspl2*L0;
		Tspl := Tspl1+Tspl2;

		TDspl := TDspl1+TDspl2;
		HDspl := HDspl1+HDspl2;
		DDspl := dpo*sqrt(2./3./HDspl*dpo);
		m_Hspl := HDspl/dpo;
		m_Dspl := sqrt(2./3./m_Hspl);
		Fo := TDspl*m_a/dpo/dpo;

		var1 := var200_4*cz;
		tetac := (CALC_SQRT_PI+var1*m_tetabo)/(CALC_SQRT_PI+var1);
		Tc := tetac*m_DBSet_part.m_Tm;

		m_bScenario := (Tc < m_DBSet_part.m_Tm) AND (Tc < m_DBSet_sub.m_Tm);
	end
                else
	begin
    // т.е. Pr < 1
		// ac = 0.259
		// Металлы
		m_ac := 0.259;
    case nScen of
      0: // Первый сценарий
         begin
			     P := (var200_1+2.*(1.+m_ac)*m_Ke*(m_tetapo-1))/var200_2;
			     Q := var200_3*(1.-m_tetabo)*(1.-(1.+m_ac)*(m_tetapo-1)/((1.-m_tetabo)*m_Ke));
			     cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.0;

			     sqrt_Fo := (cz*sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
           Fo := sqrt_Fo*sqrt_Fo;
			     m_Hspl := cz*sqrt_Fo;
			     m_Dspl := sqrt(2./3./m_Hspl);
			     TDspl := sqrt_Fo*sqrt_Fo*dpo*dpo/m_a;
			     HDspl := cz*sqrt(m_a*dpo/upo);
			     DDspl := dpo*sqrt(2./3./HDspl*dpo);

			     var1 := var200_4*cz;
			     tetac := (CALC_SQRT_PI+var1*m_tetabo)/(CALC_SQRT_PI+var1);
			     Tc := tetac*m_DBSet_part.m_Tm;

			     m_bScenario := (Tc < m_DBSet_part.m_Tm) AND (Tc < m_DBSet_sub.m_Tm);
         end;

      1:// Второй сценарий
         begin
			     d1 := m_Ke*(m_tetabm - m_tetabo)/CALC_SQRT_PI;
			     d2 := (1.+m_ac)*(m_tetapo - 1)/CALC_SQRT_PI;
			     P := 2.*(d2*(2.*m_Spb+m_Lbpls)-d1*m_Spb)/m_Kupl/(m_Spb+m_Lbpls);
			     Q := 2.*(2.*d2*(d2-d1)*m_Spb-m_Lbpll*m_Kupl*(1.-m_tetabm))/m_Kupl/m_Kupl/(m_Spb+m_Lbpls);
			     cz := P*(sqrt(1.+4.*Q/P/P)-1)/2.;
			     cxi := m_Spb*(cz+2.*(d2-d1)/m_Kupl);
			     tetac := 1.-m_Lbpls*(1.-m_tetabm)*cz/m_Spb*1./(2.*(d2-d1)/m_Kupl+(1.+m_Lbpls/m_Spb)*cz);
			     Tc := tetac*m_DBSet_part.m_Tm;
			     sqrt_Fo := (cz*sqrt(1.+4.*pe/cz/cz)-1)/2./pe;
			     Fo := sqrt_Fo*sqrt_Fo;
			     Hb := cxi*sqrt_Fo;

			     m_Hspl := cz*sqrt_Fo;
			     m_Dspl := sqrt(2./3./m_Hspl);
			     TDspl := sqrt_Fo*sqrt_Fo*dpo*dpo/m_a;
			     HDspl := cz*sqrt(m_a*dpo/upo);
			     DDspl := dpo*sqrt(2./3./HDspl*dpo);

			     m_bScenario := (tetac < 1) AND (tetac > m_tetabm);
         end;

      2:// третий сценарий
         begin
			     m_Hspl := 0.495*step(Re, -0.25);
			     m_Dspl := sqrt(2./3./m_Hspl);
			     TDspl := (1.-m_Hspl)*dpo/upo;
			     Fo := m_a*TDspl/dpo/dpo;
			     Tco := (tpo+m_Ke*tbo)/(1.+m_Ke);
			     abms := m_DBSet_sub.m_Lms/m_DBSet_sub.m_ROms/m_DBSet_sub.m_CPms;
			     kappa := abms/m_a;
			     Xs := pe*Fo/kappa;
			     Tc := Tco + m_Ke/(1.+m_Ke)*(tpo-tbo)*(1.-exp(-Xs/4./(1.+m_Ke)));
			     tetac := Tc/m_DBSet_part.m_Tm;

			     m_bScenario := (Tc <= m_DBSet_sub.m_Tm) AND (Tc >= m_DBSet_part.m_Tm);
         end;

      3: // четвертый сценарий
         begin
			     cz := 0.;
			     P := sqrt(CALC_PI*m_Lbpll)/(1.+m_ac)+(1.-m_tetabo/m_tetabm)/m_Lbpls/CALC_SQRT_PI/m_Ke/m_Kubs;
			     Q := m_Lbpll/m_Lbpls*(1.-m_tetabo/m_tetabm)/(1.+m_ac)/m_Ke/m_Kubs*(1.-(1.+m_ac)*(m_tetapo/m_tetabm-1)/m_Ke/(1.-m_tetabo/m_tetabm));
			     cxi := P*(sqrt(1.-4.*Q/P/P)-1)/2.;
			     tetac := (CALC_SQRT_PI*m_tetabm+(1.+m_ac)/m_Lbpll*m_tetapo*cxi)/(CALC_SQRT_PI+(1.+m_ac)/m_Lbpll*cxi);
			     Tc := tetac*m_DBSet_part.m_Tm;

			     m_Hspl := 0.495*step(Re, -0.25);
			     m_Dspl := sqrt(2./3./m_Hspl);
			     HDspl := m_Hspl*dpo;
			     DDspl := m_Dspl*dpo;
			     TDspl := (dpo-HDspl)/upo;
			     Fo := m_a*TDspl/dpo/dpo;
			     Hb := cxi*sqrt(Fo);

			     m_bScenario := (Tc >= m_DBSet_part.m_Tm) AND (Tc >= m_DBSet_sub.m_Tm);
         end;

    end;

  end;

	if (m_bScenario_result) then m_bScenario_result := m_bScenario;

	if ( NOT (m_bScenario_left_set) AND m_bScenario) then
                                             begin
                                              m_scen_dpo_left := dpo;
                                              m_scen_tpo_left := tpo;
                                              m_scen_tbo_left := tbo;
                                              m_scen_upo_left := upo;
                                              m_bScenario_left_set := true;
	                                           end
                                            else
                                             begin
                                               if (m_bScenario_left_set AND m_bScenario_old AND m_bScenario) then
	                                                                                                          begin
		                                                                                                         m_scen_dpo := dpo;
		                                                                                                         m_scen_tpo := tpo;
		                                                                                                         m_scen_tbo := tbo;
		                                                                                                         m_scen_upo := upo;
	                                                                                                          end;
                                             end;
// Доделать!!!!!!!!!
//		sprintf(str, "Изменено значение %d -> %d\nТочка: Tpo=%.2f, Tbo=%.2f, upo=%.2f, Dpo=%.2f", m_bScenario_old, m_bScenario, m_scen_tpo, m_scen_tbo, m_scen_upo, m_scen_dpo*1.e6);

	m_bScenario_old := m_bScenario;


end;



function CCalculations.GetXconstFunctionValue(nFunction: integer; tpo:double; tbo:double; upo:double; dpo:double):double;
begin
//----------
	case nFunction of
	0:
	 // Возвращает значение первого выражения сценария 1
    begin
		 GetXconstFunctionValue:= tpo+m_Ke*tbo-(1.+m_Ke)*m_DBSet_part.m_Tm;
		end;

	 1: // Возвращает значение второго выражения сценария 1
    begin
		 GetXconstFunctionValue:= tpo+m_Ke*tbo-(1.+m_Ke)*m_DBSet_sub.m_Tm;
		end;
  else
	 GetXconstFunctionValue:= 0;
  end;


end;

//
// Авторские формулы для расчета безразмерных толщин и диаметров сплэтов
// В дальнейшем расширена и для расчета других функций
//
function CCalculations.GetAuthorFunctionValue(nAuthor:integer; nFunction:integer; tpo:double; tbo:double; upo:double; dpo:double):double;
var res:double;
    count:integer;
    xn, xn1, eps, k, T0, t, tc2:double;
    Ea,V,const_k:double;

begin
//----------

	Re := m_DBSet_part.m_ROml/m_DBSet_part.m_MUml*dpo*upo;
	We := m_DBSet_part.m_ROml/m_DBSet_part.m_SIGml*dpo*upo*upo;
	mu := m_DBSet_part.m_MUml/m_DBSet_part.m_ROml;
	Pr := mu/m_a;

	xn:=1;
  eps:=0.00000001;

	case nFunction of
    0:
       begin
		    case nAuthor of
		      0: // Madejski-1
 	           GetAuthorFunctionValue := 2./We;
		      1: // Madejski-2
			       GetAuthorFunctionValue := 0.398*step(Re, -0.4);
		      2: // Madejski-3
			       GetAuthorFunctionValue := 0.398*step(Re+0.952, -0.4);
		      3: // Madejski-4
             begin
			        T0 := m_DBSet_part.m_Lms*(m_DBSet_part.m_Tm-tbo)/m_DBSet_part.m_ROms/m_a/m_DBSet_part.m_LBoil;
			        xn :=1.0;
			        xn1 := xn - (CALC_SQRT_PI*xn/2.*erf(xn/2)*exp(xn*xn/4)-T0)/(CALC_SQRT_PI*exp(xn*xn/4)*(0.5*erf(xn/2)+xn*xn*xn*xn/4./CALC_SQRT_PI/exp(-xn*xn/4)+xn*xn/4.*erf(0.5*xn)));
			        count:=0;
			        while (abs(xn1-xn)/xn > eps) do
               begin
				        count:=count+1;
				        xn := xn1;
				        xn1 := xn - (CALC_SQRT_PI*xn/2.*erf(xn/2)*exp(xn*xn/4)-T0)/(CALC_SQRT_PI*exp(xn*xn/4)*(0.5*erf(xn/2)+xn*xn*xn*xn/4./CALC_SQRT_PI/exp(-xn*xn/4)+xn*xn/4.*erf(0.5*xn)));
			         end;

			        pe := upo*dpo/m_a;
			        k := 6*0.25*xn1*m_DBSet_part.m_ROml*sqrt(0.5/pe);
			        GetAuthorFunctionValue := 0.281*step(k, 0.79);
             end;
		      4: // Lui
			       GetAuthorFunctionValue := 0.616*step(Re, -0.4);
	        5: // Trapaga
			       GetAuthorFunctionValue := 0.67*step(Re, -0.4);
		      6: // Bertagnolli
			       GetAuthorFunctionValue := 0.693*step(Re, -0.4);
		      7: // Yoshida
			       GetAuthorFunctionValue := 0.968*step(Re, -0.4);
		      8: // Watanabe
			       GetAuthorFunctionValue := 0.991*step(Re, -0.4);
		      9: // Montavon
			       GetAuthorFunctionValue := 66.7*step(Re, -0.4);
		     10: // Pasandideh
			       GetAuthorFunctionValue := 2.667/sqrt(Re);
		     11: // Gasin
		         GetAuthorFunctionValue := 0.784/sqrt(Re);
		     12: // Kurukawa
			       GetAuthorFunctionValue := 0.723*step(Re, -0.19)*step(We, -0.168);
		     13: // Collings
			       GetAuthorFunctionValue := 4./We;
		     14: // Cheng
			       GetAuthorFunctionValue := 1./sqrt(We);
		     15: // Akao
			       GetAuthorFunctionValue := 1.77*step(We, -0.78);
		     16: // Chandra
			       GetAuthorFunctionValue := 1.413/sqrt(Re);
		     17: // McPherson
		         GetAuthorFunctionValue := 1.774*step(We, -0.78);
		     18: // Jones
			       GetAuthorFunctionValue := 0.495*step(Re, -0.25);
		     19: // Solonenko
             begin
			        CalcCorrelations(tpo, tbo, upo, dpo);
		        	GetAuthorFunctionValue := m_Hspl;
             end;
		    end; //end case nAuthor
	     end; // end case nFunction=0

  1:
       begin
		    case nAuthor of
		     0:
		      	 GetAuthorFunctionValue := 0.577*sqrt(We);
		     1:
			       GetAuthorFunctionValue := 1.29*step(Re, 0.2);
		     2:
			       GetAuthorFunctionValue := 1.29*step(Re+0.952, 0.2);
		     3:
             begin
			        T0 := m_DBSet_part.m_Lms*(m_DBSet_part.m_Tm-tbo)/m_DBSet_part.m_ROms/m_a/m_DBSet_part.m_LBoil;
			        xn := 1.;
			        xn1 := xn - (CALC_SQRT_PI*xn/2.*erf(xn/2)*exp(xn*xn/4)-T0)/(CALC_SQRT_PI*exp(xn*xn/4)*(0.5*erf(xn/2)+xn*xn*xn*xn/4./CALC_SQRT_PI/exp(-xn*xn/4)+xn*xn/4.*erf(0.5*xn)));
			        while (abs(xn1-xn)/xn <= eps) do
			         begin
			        	xn := xn1;
				        xn1 := xn - (CALC_SQRT_PI*xn/2.*erf(xn/2)*exp(xn*xn/4)-T0)/(CALC_SQRT_PI*exp(xn*xn/4)*(0.5*erf(xn/2)+xn*xn*xn*xn/4./CALC_SQRT_PI/exp(-xn*xn/4)+xn*xn/4.*erf(0.5*xn)));
			         end;
			        pe := upo*dpo/m_a;
			        k := 6*0.25*xn1*m_DBSet_part.m_ROml*sqrt(0.5/pe);
			        GetAuthorFunctionValue := 1.5344*step(k, -0.395);
			       end;
		     4:
			       GetAuthorFunctionValue := 1.04*step(Re, 0.2);
		     5:
			       GetAuthorFunctionValue := step(Re, 0.2);
		     6:
			       GetAuthorFunctionValue := 0.925*step(Re, 0.2);
		     7:
			       GetAuthorFunctionValue := 0.83*step(Re, 0.2);
		     8:
			       GetAuthorFunctionValue := 0.82*step(Re, 0.2);
		     9:
			       GetAuthorFunctionValue := 0.1*step(Re, 0.2);
        10:
			       GetAuthorFunctionValue := 0.5*step(Re, 0.25);
		    11:
			       GetAuthorFunctionValue := 0.922*step(Re, 0.25);
        12:
			       GetAuthorFunctionValue := 0.96*step(Re, 0.095)*step(We, 0.084);
		    13:
			       GetAuthorFunctionValue := 0.408*sqrt(We);
		    14:
			       GetAuthorFunctionValue := 0.816*step(We, 0.25);
		    15:
			       GetAuthorFunctionValue := 0.613*step(We, 0.39);
		    16:
			       GetAuthorFunctionValue := 0.687*step(Re, 0.25);
		    17:
			       GetAuthorFunctionValue := 0.613*step(We, 0.39);
		    18:
			       GetAuthorFunctionValue := 1.16*step(Re, 0.125);
		    19:
             begin
			        CalcCorrelations(tpo, tbo, upo, dpo);
			        GetAuthorFunctionValue := m_Dspl;
		         end;
        end; //end case nAuthor
		   end;//end case nFunction=1


	2: // Tav    nFunction=2
		   begin
		  	CalcCorrelations(tpo, tbo, upo, dpo);
			  tc2 := 1e-11;
			  t := TDspl;
			  GetAuthorFunctionValue := (m_DBSet_part.m_Lms*m_DBSet_part.m_Tm*(1.-tetac)-0.5*m_DBSet_part.m_ROml*m_DBSet_part.m_Lm*cz*cz*m_a)/(2.*m_DBSet_part.m_Lml)*ln(t/tc2)/(t-tc2);
		   end;

	3: // d1
		   begin
		   	CalcCorrelations(tpo, tbo, upo, dpo);
			  t := TDspl;
			  GetAuthorFunctionValue := 2.*m_corr_A1/(2.+m_corr_alpha+m_corr_beta)*step((m_DBSet_part.m_Lms*(m_DBSet_part.m_Tm - Tc)/cz/sqrt(m_a)-0.5*m_DBSet_part.m_ROml*m_DBSet_part.m_Lm*cz*sqrt(m_a))/m_DBSet_part.m_Lml, -m_corr_alpha)*step(0.5*cz*sqrt(m_a), -m_corr_beta)*step(t, 0.5*(m_corr_alpha+m_corr_beta));
        //косяк в данных выше!!!
		   end;
	4: // d2
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  t := TDspl;
			  GetAuthorFunctionValue := 2.*m_corr_B1/(1.+m_corr_gamma)*step(0.5*cz*sqrt(m_a)*(m_DBSet_part.m_Lms*(m_DBSet_part.m_Tm - Tc)/cz/sqrt(m_a)-0.5*m_DBSet_part.m_ROml*m_DBSet_part.m_Lm*cz*sqrt(m_a))/m_DBSet_part.m_Lml, -m_corr_gamma)*step(t, m_corr_gamma);
		   end;

	5: // dz/dt
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  t := TDspl;
			  GetAuthorFunctionValue := cz*sqrt(m_a/t);
		   end;

  6: // cz
		   begin
		    CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := cz;
		   end;


	7: // Tc
		   begin
		    CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := Tc;
		   end;

	8: // <q>
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  t := TDspl;
			  GetAuthorFunctionValue := 2.*m_DBSet_part.m_Lms*(m_DBSet_part.m_Tm-Tc)/cz/sqrt(m_a*t);
		   end;

	9: // Tspl
		   begin
		    CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := TDspl;
		   end;

	10: // Tetac
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := tetac;
		   end;
	11: // HDspl
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := HDspl;
		   end;
	12: // DDspl
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue :=DDspl;
		   end;

	13: // sigma b
		   begin
		  	CalcCorrelations(tpo, tbo, upo, dpo);
			  Ea := 0.5*m_DBSet_sub.m_LBoil*m_DBSet_sub.m_AW/9.64862e7;

        m_DBSet_sub.m_LBoil:=m_DBSet_sub.m_LBoil+1;
        m_DBSet_sub.m_LBoil:=m_DBSet_sub.m_LBoil-1;


			  V := 1.0e13;
			  const_k := 1.38e-23/1.60219e-19;
			  GetAuthorFunctionValue := 1.-exp(-V*TDspl/exp(Ea/const_k/Tc));
		   end;
	14: // Fo
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := Fo;
		   end;
	15: // cxi
		   begin
		    CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := cxi;
		   end;

	16: // hb
		   begin
			  CalcCorrelations(tpo, tbo, upo, dpo);
			  GetAuthorFunctionValue := Hb;
		   end;
  else
        GetAuthorFunctionValue := 0;
end;  //end case nFunction

end; // end function GetAuthorFunctionValue




function CalcDm(hm:double):double;
begin
  // безразмерный Dcrit
	CalcDm:=sqrt(2.0/(hm*3.0));
end;
function Calchm(Dm:double):double;
begin
  // безразмерная hcrit
	Calchm:=2.0/(Dm*Dm*3.0);
end;
function CalcD(h:double; Dp:double):double;
begin
  // размерный Dcrit
	CalcD:=Dp*sqrt(2*Dp/(3*h));
end;
function Calch(D:double; Dp:double):double;
begin
  // размерная hcrit
	Calch:=2*Dp*Dp*Dp/(3*D*D);
end;




destructor CCalculations.Destroy;
begin
  m_DBSet_part.Free;
  m_DBSet_sub.Free;
  m_data.Free;
  inherited Destroy;
//----------
end;
