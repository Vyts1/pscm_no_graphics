  TMD11Array = record
                 codenum : integer;
                 menunum : integer;
                 imgfileRU : string;
                 imgfileEN : string;
//                 txtRU, txtEN:string;
                 RU,EN : string;
                 tip : byte;
                 index : integer;
                 //row : TcxCustomRow;
                 //row2 : TcxCustomRow;
                 visible: boolean;
                 valueR : real;
                 valueI : integer;
                 valueB : boolean;
               end;

  TMD3Array = record
                 imgfile : string;

                 RU,EN : string;
//                 tip : byte;
                 index : integer;
//                 row : TcxCustomRow;
                 visible:boolean;
               end;

  TScenArray = record
                 imgfile:string;
                 RU, EN : string;
                 Index:integer;
               end;

  TPetArray =  record
                 imgfile:string;
//                 RU, EN : string;
                 Index:integer;
               end;

  TArgArray =  record
                 imgfile:string;
//                 RU, EN : string;
                 Index:integer;
               end;

  TLHArray =  record
                 imgfile:string;
                 Index:integer;
               end;

  TErrorArray = record
                  RU,EN:string;
                end;

  //GL:
  {$I 'func\DrawTextType.pas'} // <---1

//=========================================================================================
//  Леоновская часть
  CString = string;
  CStringW = string;

  // CCutBoxSet - класс для работы с БД. Соединяется и читает
  CCutBoxSet = class
                public
                  m_nId:integer;
                  m_Material:CStringW;
                  m_ROms:double;
                  m_ROml:double;
                  m_CPms:double;
                  m_CPml:double;
                  m_Lms:double;
                  m_Lml:double;
                  m_Tm:double;
                  m_TBoil:double;  //Температура кипения
                  m_Lm:double;
                  m_MUml:double;
                  m_SIGml:double;
                  m_LBoil:double;
                  m_AW:double;


                  host, user, passwd: String;
                  db: String;
                  retval: Integer;

//                  mysqlrec: mysql; //Global mysql struct
                  connected: Integer; //Global var to keep track of whether we are connected

                  function Move (inp:integer): boolean;
                  constructor Create ();
                  destructor Destroy; override;

                  function Open ():boolean; // для открытия и закрытия БД
                  function Close ():boolean;

               end; // end CCutBoxSet class

     CMyData = class
                public
                  //  m_Tpmin, m_Tpmax, m_upmin, m_upmax, m_Dpmin, m_Dpmax, m_Tbmin, m_Tbmax:CString;
                  m_Tpmin, m_Tpmax, m_upmin, m_upmax, m_Dpmin, m_Dpmax, m_Tbmin, m_Tbmax:double;
                  m_partMaterial, m_subMaterial, m_Scen : integer;
                  m_bIsMoreghsm, m_bIsMoregDsm, m_bIsMoreghcritm, m_bIsMoreghs, m_bIsMoregDs, m_bIsMoregDcritm : boolean;
                  m_bCheckedghsm, m_bCheckedgDsm, m_bCheckedghcritm, m_bCheckedghs, m_bCheckedgDs, m_bCheckedgDcritm : boolean;
                  //  m_ghsm, m_gDsm, m_ghcritm, m_ghs, m_gDs, m_gDcritm:CString;
                  m_ghsm, m_gDsm, m_ghcritm, m_ghs, m_gDs, m_gDcritm:double;
                  m_bIsMorettFo, m_bIsMorettt, m_bIsMorettTetac, m_bIsMorettTc, m_bIsMorettdTdt, m_bIsMorettFocrit : boolean;
                  m_bCheckedttFo, m_bCheckedttt, m_bCheckedttTetac, m_bCheckedttTc, m_bCheckedttdTdt, m_bCheckedttFocrit : boolean;
                  //  m_ttFo, m_ttt, m_ttTetac, m_ttTc, m_ttdTdt, m_ttFocrit:CString;
                  m_ttFo, m_ttt, m_ttTetac, m_ttTc, m_ttdTdt, m_ttFocrit:double;
                  //  m_dshsm, m_dsDsm, m_dsdPe, m_dsdTetaPo, m_dsdTetaBo:CString;
                  m_dshsm, m_dsDsm, m_dsdPe, m_dsdTetaPo, m_dsdTetaBo:double;
                  m_ishsm, m_isdhsm, m_isDs, m_isTpo, m_isTbo, m_isPe, m_isdtetapo, m_isdtetabo, m_isdPe:double;
                  //  m_ishsm, m_isdhsm, m_isDs, m_isTpo, m_isTbo, m_isPe, m_isdtetapo, m_isdtetabo, m_isdPe:CString;
                  m_bCheckedtcSGbSGb0, m_bIsMoretcSGbSGb0, m_bCheckedtcSGbm, m_bIsMoretcSGbm : boolean;
                  //  m_tcSGbSGb0, m_tcSGbm:CString;
                  m_tcSGbSGb0, m_tcSGbm:double;
                  m_isCalcValue, m_isRoughly : integer;
                  m_bCheckedDS, m_bCheckedIS : boolean;
                  m_corr_partMaterial, m_corr_subMaterial, m_corr_Scen, m_corr_argument, m_corr_author : integer;
                  //  m_corr_Tpo, m_corr_Tpmin, m_corr_Tpmax:CString;
                  //  m_corr_upo, m_corr_upmin, m_corr_upmax:CString;
                  //  m_corr_Dpo, m_corr_Dpmin, m_corr_Dpmax:CString;
                  //  m_corr_Tbo, m_corr_Tbmin, m_corr_Tbmax:CString;

                  m_corr_Tpo, m_corr_Tpmin, m_corr_Tpmax, m_corr_upo, m_corr_upmin, m_corr_upmax, m_corr_Dpo, m_corr_Dpmin, m_corr_Dpmax, m_corr_Tbo, m_corr_Tbmin, m_corr_Tbmax:double;
                  //  m_corr_hsm, m_corr_Dsm, m_corr_Tav, m_corr_d1, m_corr_d2, m_corr_A1, m_corr_alpha, m_corr_beta, m_corr_B1, m_corr_gamma:CString;
                  m_corr_hsm, m_corr_Dsm, m_corr_Tav, m_corr_d1, m_corr_d2, m_corr_A1, m_corr_alpha, m_corr_beta, m_corr_B1, m_corr_gamma:double;
                  m_corr_bCheckedhsm, m_corr_bCheckedDsm, m_corr_bCheckedTav, m_corr_bCheckedD1, m_corr_bCheckedD2 : boolean;
                  m_corr_bCheckedFile : boolean;
                  m_corr_bChecked_dzdt, m_corr_bChecked_cz, m_corr_bChecked_Tc, m_corr_bChecked_q, m_corr_bChecked_Tspl, m_corr_bChecked_SGbm, m_corr_bChecked_Fo : boolean;
                  m_corr_bChecked_cxi, m_corr_bChecked_hbm : boolean;
                  m_corr_dzdt, m_corr_cz, m_corr_Tc, m_corr_q, m_corr_SGbm, m_corr_Fo, m_corr_cxi, m_corr_hbm:CString;

                  m_corr_file:CString;
                  m_corr_file_x, m_corr_file_y:Integer;


                  m_xconst_partMaterial, m_xconst_subMaterial, m_xconst_argument, m_xconst_nScen : integer;

                  m_xconst_Tpo, m_xconst_Tpmin, m_xconst_Tpmax,
                  m_xconst_upo, m_xconst_upmin, m_xconst_upmax,
                  m_xconst_Dpo, m_xconst_Dpmin, m_xconst_Dpmax,
                  m_xconst_Tbo, m_xconst_Tbmin, m_xconst_Tbmax,
                  m_xconst_hsm, m_xconst_Dsm, m_xconst_hcritm,
                  m_xconst_Dcritm,  m_xconst_hs, m_xconst_Ds, m_xconst_Fo,
                  m_xconst_t, m_xconst_tetac, m_xconst_Tc, m_xconst_Tav,
                  m_xconst_SGbm, m_xconst_hbm:double;

                  m_xconst_bChecked_hsm, m_xconst_bChecked_Dsm, m_xconst_bChecked_hcritm, m_xconst_bChecked_Dcritm : boolean;
                  m_xconst_bChecked_hs, m_xconst_bChecked_Ds, m_xconst_bChecked_Fo, m_xconst_bChecked_t : boolean;
                  m_xconst_bChecked_tetac, m_xconst_bChecked_Tc, m_xconst_bChecked_Tav, m_xconst_bChecked_SGbm : boolean;
                  m_xconst_bChecked_hbm : boolean;
                  m_xconst_bIsMore_hsm, m_xconst_bIsMore_Dsm, m_xconst_bIsMore_hcritm, m_xconst_bIsMore_Dcritm : boolean;
                  m_xconst_bIsMore_hs, m_xconst_bIsMore_Ds, m_xconst_bIsMore_Fo, m_xconst_bIsMore_t : boolean;
                  m_xconst_bIsMore_tetac, m_xconst_bIsMore_Tc, m_xconst_bIsMore_Tav, m_xconst_bIsMore_SGbm : boolean;
                  m_xconst_bIsMore_hbm : boolean;
               end;

  // Вычислительный класс
  CCalculations = class
                 public
                  m_data:CMyData;
                  m_DBSet_part, m_DBSet_sub:CCutBoxSet;

                  // Переменные, участвующие в расчетах
                  m_Dpmin, m_Dpmax : double;
                  m_a, m_ac, m_Lppsl, m_Kupl, m_Ke: double;
                  m_Spb, m_Lbpls, m_Lbpll: double;
	                var8_A, var8_B, var8_C, var8_D: double;
	                var9_a, var10_a: double;
	                var17_1, var17_2, var17_3, var17_4, var17_5: double;
                  var18_1, var18_2, var18_3, var18_4: double;
	                m_tcSGbm: double;
                  m_ttdTdt: double;
	                m_sens_hs, m_sens_dhs, m_dPe, m_dtetapo, m_dtetabo: double;
                 	m_pe, m_tpo, m_tbo: double;
	                var100_1, var100_2, var100_3, var100_A, var100_B, var100_C, var100_D: double;
	                var200_1, var200_2, var200_3, var200_4: double;
	                m_corr_tpmin, m_corr_tpmax, m_corr_tpo, m_corr_tbmin, m_corr_tbmax, m_corr_tbo: double;
	                m_corr_upmin, m_corr_upmax, m_corr_upo, m_corr_Dpmin, m_corr_Dpmax, m_corr_Dpo: double;
	                m_corr_A1, m_corr_alpha, m_corr_beta, m_corr_B1, m_corr_gamma: double;
	                m_tetapo, m_tetabo: double;
	                m_xconst_tpmin, m_xconst_tpmax, m_xconst_tpo, m_xconst_tbmin,
                  m_xconst_tbmax, m_xconst_tbo: double;
	                m_xconst_upmin, m_xconst_upmax, m_xconst_upo, m_xconst_Dpmin,
                  m_xconst_Dpmax,  m_xconst_Dpo: double;

	                m_Hspl, m_Dspl: double;

	                m_bScenario, m_bScenario_old, m_bScenario_left_set:boolean; // Проверка выполнимости текущего сценария
	                m_bScenario_result:boolean;
	                m_scen_tpo, m_scen_tbo, m_scen_upo, m_scen_dpo: double;
	                m_scen_tpo_left, m_scen_tbo_left, m_scen_upo_left, m_scen_dpo_left: double;
                  //CWnd* m_pMainWnd;

                  function GetPeMin() : double;
                  function GetPeMax() : double;
                  function GetFoMax() : double;
                  function GetFoMin() : double;
                  function GetTpmin_min() : double;
                  function GetTpmin_max() : double;
                  function GetXconstFunctionValue(nFunction: integer; tpo:double; tbo:double; upo:double; dpo:double):double;
                  function GetAuthorFunctionValue(nAuthor:integer; nFunction:integer; tpo:double; tbo:double; upo:double; dpo:double):double;
                  function GetFunctionValue(n:integer; tpo:double; tbo:double; pe:double):double;

                  procedure CalcCorrelations(tpo:double; tbo:double; upo:double; dpo:double);
                  procedure PrepareFunction(n:integer);

                  constructor Create ();
                  destructor Destroy; override;

               end;



//=========================================================================================
//=========================================================================================
//=========================================================================================

