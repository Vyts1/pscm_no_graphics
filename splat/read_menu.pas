



 //-------------------------------------------------
 m_calc.m_data.m_partMaterial:=3;
 m_calc.m_data.m_Tpmin:=1730;
 m_calc.m_data.m_Tpmax:=3000;
 m_calc.m_data.m_upmin:=75;
 m_calc.m_data.m_upmax:=200;
 m_calc.m_data.m_Dpmin:=40;
 m_calc.m_data.m_Dpmax:=40;

  // подложка
 m_calc.m_data.m_subMaterial:=2;
 m_calc.m_data.m_Tbmin:=300;
 m_calc.m_data.m_Tbmax:=500;

  // сценарий
 m_calc.m_data.m_Scen:=0;
 //-------------------------------------------------
 // геометрические ограничения
 m_calc.m_data.m_bIsMoreghsm:=true;
 m_calc.m_data.m_bIsMoregDsm:=false;
 m_calc.m_data.m_bIsMoreghcritm:=true;
 m_calc.m_data.m_bIsMoreghs:=true;
 m_calc.m_data.m_bIsMoregDs:=false;
 m_calc.m_data.m_bIsMoregDcritm:=false;

 m_calc.m_data.m_bCheckedghsm:=false;
 m_calc.m_data.m_bCheckedgDsm:=false;
 m_calc.m_data.m_bCheckedghcritm:=false;
 m_calc.m_data.m_bCheckedghs:=false;
 m_calc.m_data.m_bCheckedgDs:=false;
 m_calc.m_data.m_bCheckedgDcritm:=false;
 
 m_calc.m_data.m_ghsm:=0.1;
 m_calc.m_data.m_gDsm:=2.582;
 m_calc.m_data.m_ghcritm:=0.041;
 m_calc.m_data.m_gDcritm:=4.032;
 m_calc.m_data.m_ghs:=0;
 m_calc.m_data.m_gDs:=0;

 // время-температурные ограничения
 m_calc.m_data.m_bIsMorettFo:=true;
 m_calc.m_data.m_bIsMorettt:=true;
 m_calc.m_data.m_bIsMorettTetac:=true;
 m_calc.m_data.m_bIsMorettTc:=true;
 m_calc.m_data.m_bIsMorettdTdt:=true;
 m_calc.m_data.m_bIsMorettFocrit:=true;     

 m_calc.m_data.m_bCheckedttFo:=false;
 m_calc.m_data.m_bCheckedttt:=false;
 m_calc.m_data.m_bCheckedttTetac:=false;
 m_calc.m_data.m_bCheckedttTc:=false;
 m_calc.m_data.m_bCheckedttdTdt:=false; 

 m_calc.m_data.m_ttFo:=0.01;
 m_calc.m_data.m_ttt:=1;
 m_calc.m_data.m_ttTetac:=0.5;
 m_calc.m_data.m_ttTc:=1200;
 m_calc.m_data.m_ttdTdt:=1E7;
 m_calc.m_data.m_ttFocrit:=1;


 // технологические ограничения
 m_calc.m_data.m_tcSGbSGb0:=1;
 m_calc.m_data.m_bCheckedtcSGbSGb0:=false;

 m_calc.m_data.m_tcSGbm:=0.5;
 m_calc.m_data.m_bCheckedtcSGbm:=false;

// m_calc.m_data.m_bIsMoretcSGbSGb0:=false;
// m_calc.m_data.m_bIsMoretcSGbm:=false;


 // прямая чувствительность
                             m_calc.m_data.m_bCheckedDS := false;
                             m_calc.m_data.m_dshsm := 0.041;
                             m_calc.m_data.m_dsDsm := 4.03;
                             m_calc.m_data.m_dsdPe := 2;
                             m_calc.m_data.m_dsdTetaPo := 2;
                             m_calc.m_data.m_dsdTetaBo := 2;


  //обратная чувствительность
                             m_calc.m_data.m_bCheckedIS := false;
                             m_calc.m_data.m_ishsm := 0.041;
                             m_calc.m_data.m_isdhsm := 0.008;
                             m_calc.m_data.m_isDs := 4.03;
                             m_calc.m_data.m_isTpo := 2400;
                             m_calc.m_data.m_isTbo := 400;
                             m_calc.m_data.m_isPe := 400;
                             m_calc.m_data.m_isdtetapo := 2;
                             m_calc.m_data.m_isdtetabo := 2;
                             m_calc.m_data.m_isdPe := 2;
                             m_calc.m_data.m_isCalcValue := 2;
                             m_calc.m_data.m_isRoughly := 0;


                             // Корреляции
                             m_calc.m_data.m_corr_partMaterial := 0;
                             m_calc.m_data.m_corr_subMaterial := 2;
                             m_calc.m_data.m_corr_Tpo := 2000;
                             m_calc.m_data.m_corr_Tpmin := 1730;
                             m_calc.m_data.m_corr_Tpmax := 2100;
                             m_calc.m_data.m_corr_upo := 100;
                             m_calc.m_data.m_corr_upmin := 75;
                             m_calc.m_data.m_corr_upmax := 200;
                             m_calc.m_data.m_corr_Dpo := 40;
                             m_calc.m_data.m_corr_Dpmin := 40;
                             m_calc.m_data.m_corr_Dpmax := 100;
                             m_calc.m_data.m_corr_Tbo := 400;
                             m_calc.m_data.m_corr_Tbmin := 300;
                             m_calc.m_data.m_corr_Tbmax := 500;
                             m_calc.m_data.m_corr_argument := 0;
                             m_calc.m_data.m_corr_Scen := 0;
                             m_calc.m_data.m_corr_bCheckedhsm := true;
                             m_calc.m_data.m_corr_hsm := 0;
                             m_calc.m_data.m_corr_Dsm := 0;
                             m_calc.m_data.m_corr_bCheckedDsm := false;
                             m_calc.m_data.m_corr_bCheckedD1 := false;
                             m_calc.m_data.m_corr_A1 := 0.0152;
                             m_calc.m_data.m_corr_alpha := 0.72;
                             m_calc.m_data.m_corr_beta := 0.26;
                             m_calc.m_data.m_corr_B1 := 1.09e-4;
                             m_calc.m_data.m_corr_gamma := 0.44;
                             m_calc.m_data.m_corr_bCheckedD2 := false;
                             m_calc.m_data.m_corr_bCheckedTav := false;
                             m_calc.m_data.m_corr_bChecked_dzdt := false;
                             m_calc.m_data.m_corr_bChecked_cz := false;
                             m_calc.m_data.m_corr_bChecked_cxi := false;
                             m_calc.m_data.m_corr_bChecked_hbm := false;
                             m_calc.m_data.m_corr_bChecked_Tc := false;
                             m_calc.m_data.m_corr_bChecked_q := false;
                             m_calc.m_data.m_corr_bChecked_Tspl := false;
                             m_calc.m_data.m_corr_bChecked_SGbm := false;
                             m_calc.m_data.m_corr_bChecked_Fo := false;
                             m_calc.m_data.m_corr_author := 0;
                           
                             m_calc.m_data.m_corr_bCheckedFile := false;
                             m_calc.m_data.m_corr_file := 'values.mdb';
                             m_calc.m_data.m_corr_file_x := 0;
                             m_calc.m_data.m_corr_file_y := 0;
                           
                             // Куб при постоянно одном из четырех параметров
                             m_calc.m_data.m_xconst_partMaterial := 0;
                             m_calc.m_data.m_xconst_subMaterial := 2;
                             m_calc.m_data.m_xconst_Tpo := 2000;
                             m_calc.m_data.m_xconst_Tpmin := 1730;
                             m_calc.m_data.m_xconst_Tpmax := 2100;
                             m_calc.m_data.m_xconst_upo := 100;
                             m_calc.m_data.m_xconst_upmin := 75;
                             m_calc.m_data.m_xconst_upmax := 200;
                             m_calc.m_data.m_xconst_Dpo := 40;
                             m_calc.m_data.m_xconst_Dpmin := 40;
                             m_calc.m_data.m_xconst_Dpmax := 100;
                             m_calc.m_data.m_xconst_Tbo := 400;
                             m_calc.m_data.m_xconst_Tbmin := 300;
                             m_calc.m_data.m_xconst_Tbmax := 500;
                             m_calc.m_data.m_xconst_argument := 0;
                             m_calc.m_data.m_xconst_nScen := 0;
                           
                             m_calc.m_data.m_xconst_hsm := 0.1;
                             m_calc.m_data.m_xconst_Dsm := 2.582;
                             m_calc.m_data.m_xconst_hcritm := 0.041;
                             m_calc.m_data.m_xconst_Dcritm := 4.032;
                             m_calc.m_data.m_xconst_hs := 0;
                             m_calc.m_data.m_xconst_Ds := 0;
                             m_calc.m_data.m_xconst_Fo := 0;
                             m_calc.m_data.m_xconst_t := 0;
                             m_calc.m_data.m_xconst_tetac := 0;
                             m_calc.m_data.m_xconst_Tc := 0;
                             m_calc.m_data.m_xconst_Tav := 0;
                             m_calc.m_data.m_xconst_SGbm := 0;
                             m_calc.m_data.m_xconst_Fo := 0;
                             m_calc.m_data.m_xconst_hbm := 0;
                             m_calc.m_data.m_xconst_bChecked_hsm := false;
                             m_calc.m_data.m_xconst_bChecked_Dsm := false;
                             m_calc.m_data.m_xconst_bChecked_hcritm := false;
                             m_calc.m_data.m_xconst_bChecked_Dcritm := false;
                             m_calc.m_data.m_xconst_bChecked_hs := false;
                             m_calc.m_data.m_xconst_bChecked_Ds := false;
                             m_calc.m_data.m_xconst_bChecked_Fo := false;
                             m_calc.m_data.m_xconst_bChecked_t := false;
                             m_calc.m_data.m_xconst_bChecked_tetac := false;
                             m_calc.m_data.m_xconst_bChecked_Tc := false;
                             m_calc.m_data.m_xconst_bChecked_Tav := false;
                             m_calc.m_data.m_xconst_bChecked_SGbm := false;
                             m_calc.m_data.m_xconst_bChecked_hbm := false;
                             m_calc.m_data.m_xconst_bIsMore_hsm := false;
                             m_calc.m_data.m_xconst_bIsMore_Dsm := false;;
                             m_calc.m_data.m_xconst_bIsMore_hcritm := true;
                             m_calc.m_data.m_xconst_bIsMore_Dcritm := false;
                             m_calc.m_data.m_xconst_bIsMore_hs := false;
                             m_calc.m_data.m_xconst_bIsMore_Ds := false;
                             m_calc.m_data.m_xconst_bIsMore_Fo := false;
                             m_calc.m_data.m_xconst_bIsMore_t := false;
                             m_calc.m_data.m_xconst_bIsMore_tetac := false;
                             m_calc.m_data.m_xconst_bIsMore_Tc := false;
                             m_calc.m_data.m_xconst_bIsMore_Tav := false;
                             m_calc.m_data.m_xconst_bIsMore_SGbm := false;
                             m_calc.m_data.m_xconst_bIsMore_hbm := false;
                           
                           
                           
                           
                           
                           