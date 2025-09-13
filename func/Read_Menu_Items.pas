function TForm1.Read_Menu_Items (BTN:integer) : boolean;
var i:integer;
    s:string;
    w:boolean;
begin

  w:=true;

  for i:=1 to count_md_items do
    begin
      if MD11Array[i].tip <> 3
         then
           begin
             with (MD11Array[i].row as TcxEditorRow) do
               begin
                 case MD11Array[i].tip of
                  0,2,5,6,7,8,9,10,11,12,13,14,15: // ComboBox`ы
                    begin
                      //s:=s+Properties.Value+#10+#13;

                      MD11Array[i].valueI := strtoint2 (Properties.Value, 0);

                      case MD11Array[i].codenum of
                       1:  begin
                             if (BTN = 1) then
                             m_calc.m_data.m_partMaterial:= MD11Array[i].valueI;
                           end;

                       8:  begin
                             if (BTN = 1) then
                             m_calc.m_data.m_subMaterial:=MD11Array[i].valueI;
                           end;

                       11: begin
                             if (BTN = 1) then
                             m_calc.m_data.m_Scen:=MD11Array[i].valueI;
                           end;

                       26: begin
                             if (BTN = 2) then
                             m_calc.m_data.m_partMaterial:=MD11Array[i].valueI;
                           end;

                       33: begin
                             if (BTN = 2) then
                             m_calc.m_data.m_subMaterial:=MD11Array[i].valueI;
                           end;

                       36: begin
                             if (BTN = 2) then
                             m_calc.m_data.m_Scen:=MD11Array[i].valueI;
                           end;

                       53: begin
                             m_calc.m_data.m_isCalcValue := MD11Array[i].valueI;
                           end;

                       54: begin
                             m_calc.m_data.m_isRoughly := MD11Array[i].valueI;
                           end;

                       55: begin
                             m_calc.m_data.m_corr_partMaterial := MD11Array[i].valueI;
                           end;

                       56: begin
                             m_calc.m_data.m_corr_subMaterial := MD11Array[i].valueI;
                           end;
                       69: begin
                             m_calc.m_data.m_corr_argument := MD11Array[i].valueI;
                           end;
                       70: begin
                             m_calc.m_data.m_corr_Scen := MD11Array[i].valueI;
                           end;
                       71: begin
                             m_calc.m_data.m_corr_bCheckedhsm:=false;
                             m_calc.m_data.m_corr_bCheckedDsm:=false;
                             m_calc.m_data.m_corr_bCheckedD1:=false;
                             m_calc.m_data.m_corr_bCheckedD2:=false;
                             m_calc.m_data.m_corr_bCheckedTav:=false;
                             m_calc.m_data.m_corr_bChecked_dzdt:=false;
                             m_calc.m_data.m_corr_bChecked_cz:=false;
                             m_calc.m_data.m_corr_bChecked_cxi:=false;
                             m_calc.m_data.m_corr_bChecked_hbm:=false;
                             m_calc.m_data.m_corr_bChecked_Tc:=false;
                             m_calc.m_data.m_corr_bChecked_q:=false;
                             m_calc.m_data.m_corr_bChecked_Tspl:=false;
                             m_calc.m_data.m_corr_bChecked_SGbm:=false;
                             m_calc.m_data.m_corr_bChecked_Fo:=false;


                             case MD11Array[i].valueI of
                              0: begin
                                   m_calc.m_data.m_corr_bCheckedhsm:=true;
                                 end;
                              1: begin
                                   m_calc.m_data.m_corr_bCheckedDsm:=true;
                                 end;
                              2: begin
                                   m_calc.m_data.m_corr_bChecked_hbm:=true;
                                 end;
                              3: begin
                                   m_calc.m_data.m_corr_bCheckedTav:=true;
                                 end;
                              4: begin
                                   m_calc.m_data.m_corr_bCheckedD1:=true;
                                 end;
                              5: begin
                                   m_calc.m_data.m_corr_bCheckedD2:=true;
                                 end;
                              6: begin
                                   m_calc.m_data.m_corr_bChecked_dzdt:=true;
                                 end;
                              7: begin
                                   m_calc.m_data.m_corr_bChecked_cz:=true;
                                 end;
                              8: begin
                                   m_calc.m_data.m_corr_bChecked_cxi:=true;
                                 end;
                              9: begin
                                   m_calc.m_data.m_corr_bChecked_Tc:=true;
                                 end;
                              10:begin
                                   m_calc.m_data.m_corr_bChecked_q:=true;
                                 end;
                              11:begin
                                   m_calc.m_data.m_corr_bChecked_Tspl:=true;
                                 end;
                              12:begin
                                   m_calc.m_data.m_corr_bChecked_SGbm:=true;
                                 end;
                              13:begin
                                   m_calc.m_data.m_corr_bChecked_Fo:=true;
                                 end;
                             end;

                           end;
                       72: begin
                             m_calc.m_data.m_corr_author := MD11Array[i].valueI;
                           end;
                       78: begin
                             m_calc.m_data.m_xconst_partMaterial := MD11Array[i].valueI;
                           end;
                       79: begin
                             m_calc.m_data.m_xconst_subMaterial := MD11Array[i].valueI;
                           end;
                       92: begin
                             m_calc.m_data.m_xconst_argument := MD11Array[i].valueI;
                           end;
                       93: begin
                             m_calc.m_data.m_xconst_nScen := MD11Array[i].valueI;
                           end;





                       107:
                           begin
                             iniVar.partmat := MD11Array[i].valueI;
                           end;
                       129:
                           begin
                             iniVar.incmat := MD11Array[i].valueI;
                           end;
                       114:
                           begin
                             iniVar.basemat := MD11Array[i].valueI;
                           end;
                       119:
                           begin
                             iniVar.modefild := MD11Array[i].valueI;
                           end;
                       125:
                           begin
                             if MD11Array[i].valueI = 1 then
                                                  begin
                                                    iniVar.is_col := true;
//                                                    log ('Ограничение по количеству сплэтов');
                                                  end
                                                else
                                                  begin
                                                    iniVar.is_col := false;
//                                                    log ('Ограничение по толщине покрытия');
                                                  end;

                           end;
                       131:
                           begin
                             iniVar.formula := MD11Array[i].valueI;
                           end;

                       132:
                           begin
                             iniVar.tip_materiala := MD11Array[i].valueI;
                           end;

                       133:
                           begin
                             iniVar.sposob_vvoda := MD11Array[i].valueI;
                           end;

                       134:
                           begin
                             iniVar.hist_n := MD11Array[i].valueI;
                           end;



                      else
                        begin
                         ShowMessage('Пасьянс не сходится (ComboBox). Индекс i='+inttostr(MD11Array[i].codenum)+ ' tip='+inttostr(MD11Array[i].tip)+'.');
                        end;

                      end;


                    end;

                  1: //edit
                    begin
//                      s:=s+Properties.Value+#10+#13;

                      MD11Array[i].valueR := strtofloat2 (Properties.Value, 0);
                      case MD11Array[i].codenum of
                       // пространство 1
                       2 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Tpmin:=MD11Array[i].valueR;

                           end;
                       3 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Tpmax:=MD11Array[i].valueR;
                           end;
                       4 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_upmin:=MD11Array[i].valueR;
                           end;
                       5 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_upmax:=MD11Array[i].valueR;
                           end;
                       6 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Dpmin:=MD11Array[i].valueR;
                           end;
                       7 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Dpmax:=MD11Array[i].valueR;
                           end;
                       9 : begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Tbmin:=MD11Array[i].valueR;
                           end;
                       10: begin
                             if (BTN = 1) then
                                            m_calc.m_data.m_Tbmax:=MD11Array[i].valueR;
                           end;

                       //  Пространство 1. Режим анализа чувствительности.
                       27: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Tpmin:=MD11Array[i].valueR;
                           end;
                       28: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Tpmax:=MD11Array[i].valueR;
                           end;
                       29: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_upmin:=MD11Array[i].valueR;
                           end;
                       30: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_upmax:=MD11Array[i].valueR;
                           end;
                       31: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Dpmin:=MD11Array[i].valueR;
                           end;
                       32: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Dpmax:=MD11Array[i].valueR;
                           end;
                       34: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Tbmin:=MD11Array[i].valueR;
                           end;
                       35: begin
                             if (BTN = 2) then
                                            m_calc.m_data.m_Tbmax:=MD11Array[i].valueR;
                           end;

                       //  чувствительность
                       38: begin
                             m_calc.m_data.m_dshsm := MD11Array[i].valueR;
                           end;
                       39: begin
                             m_calc.m_data.m_dsDsm := MD11Array[i].valueR;
                           end;
                       40: begin
                             m_calc.m_data.m_dsdPe := MD11Array[i].valueR;
                           end;
                       41: begin
                             m_calc.m_data.m_dsdTetaPo := MD11Array[i].valueR;
                           end;
                       42: begin
                             m_calc.m_data.m_dsdTetaBo := MD11Array[i].valueR;
                           end;
                       //---
                       44: begin
                             m_calc.m_data.m_ishsm := MD11Array[i].valueR;
                           end;
                       45: begin
                             m_calc.m_data.m_isdhsm := MD11Array[i].valueR;
                           end;
                       46: begin
                             m_calc.m_data.m_isDs := MD11Array[i].valueR;
                           end;
                       47: begin
                             m_calc.m_data.m_isTpo := MD11Array[i].valueR;
                           end;
                       48: begin
                             m_calc.m_data.m_isTbo := MD11Array[i].valueR;
                           end;
                       49: begin
                             m_calc.m_data.m_isPe := MD11Array[i].valueR;
                           end;
                       50: begin
                             m_calc.m_data.m_isdtetapo := MD11Array[i].valueR;
                           end;
                       51: begin
                             m_calc.m_data.m_isdtetabo := MD11Array[i].valueR;
                           end;
                       52: begin
                             m_calc.m_data.m_isdPe := MD11Array[i].valueR;
                           end;

                       // корреляции
                       57 : begin
                             m_calc.m_data.m_corr_Tpo := MD11Array[i].valueR;
                           end;
                       58 : begin
                             m_calc.m_data.m_corr_Tpmin := MD11Array[i].valueR;
                           end;
                       59 : begin
                             m_calc.m_data.m_corr_Tpmax := MD11Array[i].valueR;
                           end;
                       60 : begin
                             m_calc.m_data.m_corr_upo := MD11Array[i].valueR;
                           end;
                       61 : begin
                             m_calc.m_data.m_corr_upmin := MD11Array[i].valueR;
                           end;
                       62 : begin
                             m_calc.m_data.m_corr_upmax := MD11Array[i].valueR;
                           end;
                       63 : begin
                             m_calc.m_data.m_corr_Dpo := MD11Array[i].valueR;
                           end;
                       64 : begin
                             m_calc.m_data.m_corr_Dpmin := MD11Array[i].valueR;
                           end;
                       65 : begin
                             m_calc.m_data.m_corr_Dpmax := MD11Array[i].valueR;
                           end;
                       66 : begin
                             m_calc.m_data.m_corr_Tbo := MD11Array[i].valueR;
                           end;
                       67 : begin
                             m_calc.m_data.m_corr_Tbmin := MD11Array[i].valueR;
                           end;
                       68 : begin
                             m_calc.m_data.m_corr_Tbmax := MD11Array[i].valueR;
                           end;

                       73 : begin
                             m_calc.m_data.m_corr_A1 := MD11Array[i].valueR;
                           end;
                       74 : begin
                             m_calc.m_data.m_corr_alpha := MD11Array[i].valueR;
                           end;
                       75 : begin
                             m_calc.m_data.m_corr_beta := MD11Array[i].valueR;
                           end;
                       76 : begin
                             m_calc.m_data.m_corr_B1 := MD11Array[i].valueR;
                           end;
                       77 : begin
                             m_calc.m_data.m_corr_gamma := MD11Array[i].valueR;
                           end;
                       //  пространство 2
                       80 : begin
                             m_calc.m_data.m_xconst_Tpo := MD11Array[i].valueR;
                           end;
                       81 : begin
                             m_calc.m_data.m_xconst_Tpmin := MD11Array[i].valueR;
                           end;
                       82 : begin
                             m_calc.m_data.m_xconst_Tpmax := MD11Array[i].valueR;
                           end;
                       83 : begin
                             m_calc.m_data.m_xconst_upo := MD11Array[i].valueR;
                           end;
                       84 : begin
                             m_calc.m_data.m_xconst_upmin := MD11Array[i].valueR;
                           end;
                       85 : begin
                             m_calc.m_data.m_xconst_upmax := MD11Array[i].valueR;
                           end;
                       86 : begin
                             m_calc.m_data.m_xconst_Dpo := MD11Array[i].valueR;
                           end;
                       87 : begin
                             m_calc.m_data.m_xconst_Dpmin := MD11Array[i].valueR;
                           end;
                       88 : begin
                             m_calc.m_data.m_xconst_Dpmax := MD11Array[i].valueR;
                           end;
                       89 : begin
                             m_calc.m_data.m_xconst_Tbo := MD11Array[i].valueR;
                           end;
                       90 : begin
                             m_calc.m_data.m_xconst_Tbmin := MD11Array[i].valueR;
                           end;
                       91 : begin
                             m_calc.m_data.m_xconst_Tbmax := MD11Array[i].valueR;
                           end;



                       // Покрытие
                       108 : begin
                             iniVar.dpmin_abs := MD11Array[i].valueR;
                           end;
                       109 : begin
                             iniVar.dpmax_abs := MD11Array[i].valueR;
                           end;

                       110 : begin
                             iniVar.temp_patic_min := MD11Array[i].valueR;
                           end;
                       111 : begin
                             iniVar.temp_patic_max := MD11Array[i].valueR;
                           end;
                       112 : begin
                             iniVar.velos_min := MD11Array[i].valueR;
                           end;
                       113 : begin
                             iniVar.velos_max := MD11Array[i].valueR;
                           end;
                       115 : begin
                             iniVar.temp_base := MD11Array[i].valueR;
                           end;
                       116 : begin
                             iniVar.fild_size_X := MD11Array[i].valueR;
                           end;
                       117 : begin
                             iniVar.fild_size_Y := MD11Array[i].valueR;
                           end;
                       118 : begin
                             iniVar.diskret_x := MD11Array[i].valueR;
                           end;
                       120 : begin
                             iniVar.a1 := MD11Array[i].valueR;
                           end;
                       121 : begin
                             iniVar.a2 := MD11Array[i].valueR;
                           end;
                       122 : begin
                             iniVar.a3 := MD11Array[i].valueR;
                           end;
                       123 : begin
                             iniVar.a4 := MD11Array[i].valueR;
                           end;
                       124 : begin
                             iniVar.a5 := MD11Array[i].valueR;
                           end;
                       126 : begin
                             iniVar.kol_spletov := round(MD11Array[i].valueR);
                           end;
                       127 : begin
                             iniVar.coat := MD11Array[i].valueR;
                           end;

                       128 : begin
                             iniVar.srez_interval := round(MD11Array[i].valueR);
                           end;

                       130 : begin
                             iniVar.VolCon := MD11Array[i].valueR;
                           end;


                      else
                        begin
                         ShowMessage('Пасьянс не сходится (Edit`ы). Индекс i='+inttostr(MD11Array[i].codenum)+ ' tip='+inttostr(MD11Array[i].tip)+'.');
                        end;

                      end;

                    end;

                  4: //check
                    begin

                      MD11Array[i].valueB := Properties.Value;
                      case MD11Array[i].codenum of
                       37: begin
                             m_calc.m_data.m_bCheckedDS := MD11Array[i].valueB;
                           end;
                       43: begin
                             m_calc.m_data.m_bCheckedIS := MD11Array[i].valueB;
                           end;

                      else
                        begin
                         ShowMessage('Пасьянс не сходится (CheckBox`ы). Индекс i='+inttostr(MD11Array[i].codenum)+ ' tip='+inttostr(MD11Array[i].tip)+'.');
                        end;
                      end;

                    end;
                 end; //case
               end; // with

           end // then-end
         else  // tip=3 (multi editors)
           begin
             with (MD11Array[i].row as TcxMultiEditorRow) do
               begin
                 MD11Array[i].valueB := Properties.Editors[0].Value;

                 if Properties.Editors[1].Value then MD11Array[i].valueI := 1
                                                else MD11Array[i].valueI := 0;

                 MD11Array[i].valueR := strtofloat2 (Properties.Editors[2].Value, 0);


                 case MD11Array[i].codenum of
                  12: begin
                        m_calc.m_data.m_bIsMoreghsm:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedghsm:=MD11Array[i].valueB;
                        m_calc.m_data.m_ghsm:=MD11Array[i].valueR;
                      end;
                  13: begin
                        m_calc.m_data.m_bIsMoregDsm:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedgDsm:=MD11Array[i].valueB;
                        m_calc.m_data.m_gDsm:=MD11Array[i].valueR;
                      end;
                  14: begin
                        m_calc.m_data.m_bIsMoreghcritm:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedghcritm:=MD11Array[i].valueB;
                        m_calc.m_data.m_ghcritm:=MD11Array[i].valueR;
                      end;
                  15: begin
                        m_calc.m_data.m_bIsMoreghs:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedghs:=MD11Array[i].valueB;
                        m_calc.m_data.m_gDcritm:=MD11Array[i].valueR;
                      end;
                  16: begin
                        m_calc.m_data.m_bIsMoregDs:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedgDs:=MD11Array[i].valueB;
                        m_calc.m_data.m_ghs:=MD11Array[i].valueR;
                      end;
                  17: begin
                        m_calc.m_data.m_bIsMoregDcritm:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedgDcritm:=MD11Array[i].valueB;
                        m_calc.m_data.m_gDs:=MD11Array[i].valueR;
                      end;
                  18: begin
                        m_calc.m_data.m_bIsMorettFo:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedttFo:=MD11Array[i].valueB;
                        m_calc.m_data.m_ttFo:=MD11Array[i].valueR;
                      end;
                  19: begin
                        m_calc.m_data.m_bIsMorettt:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedttt:=MD11Array[i].valueB;
                        m_calc.m_data.m_ttt:=MD11Array[i].valueR;
                      end;
                  20: begin
                        m_calc.m_data.m_bIsMorettTetac:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedttTetac:=MD11Array[i].valueB;
                        m_calc.m_data.m_ttTetac:=MD11Array[i].valueR;
                      end;
                  21: begin
                        m_calc.m_data.m_bIsMorettTc:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedttTc:=MD11Array[i].valueB;
                        m_calc.m_data.m_ttTc:=MD11Array[i].valueR;
                      end;
                  22: begin
                        m_calc.m_data.m_bIsMorettdTdt:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedttdTdt:=MD11Array[i].valueB;
                        m_calc.m_data.m_ttdTdt:=MD11Array[i].valueR;
                      end;
                  23: begin
                        m_calc.m_data.m_bIsMorettFocrit:=Properties.Editors[1].Value;
                        // ПОТЕРЯЛИ !!!!
                        m_calc.m_data.m_ttFocrit:=MD11Array[i].valueR;
                      end;
                  24: begin
                        // m_calc.m_data.m_bIsMoretcSGbSGb0:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedtcSGbSGb0:=MD11Array[i].valueB;
                        m_calc.m_data.m_tcSGbSGb0:=MD11Array[i].valueR;
                      end;
                  25: begin
                        // m_calc.m_data.m_bIsMoretcSGbm:=Properties.Editors[1].Value;
                        m_calc.m_data.m_bCheckedtcSGbm:=MD11Array[i].valueB;
                        m_calc.m_data.m_tcSGbm:=MD11Array[i].valueR;
                      end;


                  94: begin
                        m_calc.m_data.m_xconst_hsm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_hsm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_hsm := Properties.Editors[1].Value;
                      end;
                  96: begin
                        m_calc.m_data.m_xconst_hbm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_hbm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_hbm := Properties.Editors[1].Value;
                      end;
                  95: begin
                        m_calc.m_data.m_xconst_Dsm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Dsm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Dsm := Properties.Editors[1].Value;
                      end;
                  97: begin
                        m_calc.m_data.m_xconst_hcritm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_hcritm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_hcritm := Properties.Editors[1].Value;
                      end;
                  98: begin
                        m_calc.m_data.m_xconst_Dcritm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Dcritm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Dcritm := Properties.Editors[1].Value;
                      end;
                  99: begin
                        m_calc.m_data.m_xconst_hs := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_hs := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_hs := Properties.Editors[1].Value;
                      end;
                  100:begin
                        m_calc.m_data.m_xconst_Ds := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Ds := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Ds := Properties.Editors[1].Value;
                      end;
                  101:begin
                        m_calc.m_data.m_xconst_Fo := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Fo := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Fo := Properties.Editors[1].Value;
                      end;
                  102:begin
                        m_calc.m_data.m_xconst_t := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_t := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_t := Properties.Editors[1].Value;
                      end;
                  103:begin
                        m_calc.m_data.m_xconst_tetac := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_tetac := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_tetac := Properties.Editors[1].Value;
                      end;
                  104:begin
                        m_calc.m_data.m_xconst_Tc := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Tc := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Tc := Properties.Editors[1].Value;
                      end;
                  105:begin
                        m_calc.m_data.m_xconst_Tav := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_Tav := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_Tav := Properties.Editors[1].Value;
                      end;
                  106:begin
                        m_calc.m_data.m_xconst_SGbm := MD11Array[i].valueR;
                        m_calc.m_data.m_xconst_bChecked_SGbm := MD11Array[i].valueB;
                        m_calc.m_data.m_xconst_bIsMore_SGbm := Properties.Editors[1].Value;
                      end;


                 else
                   begin
                     ShowMessage('Пасьянс не сходится (Multieditor). Индекс i='+inttostr(MD11Array[i].codenum)+ ' tip='+inttostr(MD11Array[i].tip)+'.');
                   end;
                 end;

               end;

           end;
    end; // for-end
  //}


  Read_Menu_Items:=w;
end;
