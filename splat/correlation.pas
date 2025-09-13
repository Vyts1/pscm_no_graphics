  data_size:=100;


//  m_calc.m_data.m_corr_argument:=0;//!!!!
//  m_calc.m_data.m_corr_author:=19;//!!!!!
//  m_calc.m_data.m_corr_Scen:=0;

//  m_calc.m_data.m_corr_bCheckedhsm:=false;//
//  m_calc.m_data.m_corr_bCheckedDsm:=false;//


  countFunctions:= m_calc.m_data.m_corr_author;

//  m_calc.m_DBSet_part.Open;
  m_calc.m_DBSet_part.Move(m_calc.m_data.m_corr_partMaterial+1);
//  m_calc.m_DBSet_part.Close;

//  m_calc.m_DBSet_sub.Open;
  m_calc.m_DBSet_sub.Move(m_calc.m_data.m_corr_subMaterial+1);
//  m_calc.m_DBSet_sub.Close;

  m_calc.PrepareFunction(-1);
  m_calc.PrepareFunction(200);

  nFunction := 0;

  dtpo := (m_calc.m_corr_tpmax-m_calc.m_corr_tpmin)/data_size;
  dupo := (m_calc.m_corr_upmax-m_calc.m_corr_upmin)/data_size;
  dDpo := (m_calc.m_corr_Dpmax-m_calc.m_corr_Dpmin)/data_size;
  dtbo := (m_calc.m_corr_tbmax-m_calc.m_corr_tbmin)/data_size;

  I2:=countFunctions;
//  for I2:=0 to countFunctions-1 do
    for i1:=0 to data_size do
     begin
      case m_calc.m_data.m_corr_argument of
       0:
          begin
           tpo := m_calc.m_corr_tpmin+i1*dtpo;
           tbo := m_calc.m_corr_tbo;
           upo := m_calc.m_corr_upo;
           Dpo := m_calc.m_corr_Dpo;
          end;

       1:
          begin
           tpo := m_calc.m_corr_tpo;
           tbo := m_calc.m_corr_tbo;
           upo := m_calc.m_corr_upmin+i1*dupo;
           Dpo := m_calc.m_corr_Dpo;
          end;

       2:
          begin
           tpo := m_calc.m_corr_tpo;
           tbo := m_calc.m_corr_tbo;
           upo := m_calc.m_corr_upo;
           Dpo := m_calc.m_corr_Dpmin+i1*dDpo;
          end;

       3:
          begin
           tpo := m_calc.m_corr_tpo;
           tbo := m_calc.m_corr_tbmin+i1*dtbo;
           upo := m_calc.m_corr_upo;
           Dpo := m_calc.m_corr_Dpo;
          end;

      end;
     end; 

  case m_calc.m_data.m_corr_argument of
   0:
      begin
        data_min_arg := m_calc.m_corr_tpmin;
        data_max_arg := m_calc.m_corr_tpmax;
        m_cube_X:='Tp';
      end;
   1:
      begin
        data_min_arg := m_calc.m_corr_upmin;
        data_max_arg := m_calc.m_corr_upmax;
        m_cube_X:='up';
      end;
   2:
      begin
        data_min_arg := m_calc.m_corr_Dpmin;
        data_max_arg := m_calc.m_corr_Dpmax;
        m_cube_X:='Dp';
      end;
   3:
      begin
        data_min_arg := m_calc.m_corr_tbmin;
        data_max_arg := m_calc.m_corr_tbmax;
        m_cube_X:='Tb';
      end;
  end;



  if m_calc.m_data.m_corr_bCheckedhsm OR m_calc.m_data.m_corr_bCheckedDsm then
BEGIN

  if (m_calc.m_data.m_corr_bCheckedhsm) then nFunction := 200;
  if (m_calc.m_data.m_corr_bCheckedDsm) then nFunction := 201;

  I2:=m_calc.m_data.m_corr_author;

//  case m_calc.m_data.m_corr_author of
//  end;


  // создаем массив значений функции
//    float maxi = (rect.Width()-2*x0)/11.;

      case nFunction-200 of
       0: m_cube_Y:='Hs безразм';
       1: m_cube_Y:='Ds безразм';
       else
         m_cube_Y:='???';
      end;


{      data_tpo[I2,i1] := tpo;
      data_tbo[I2,i1] := tbo;
      data_upo[I2,i1] := upo;
      data_Dpo[I2,i1] := Dpo;}

//      data[0,0] := m_calc.GetAuthorFunctionValue(I2, nFunction-200, tpo, tbo, upo, Dpo);
      for i1:=0 to data_size do
        begin


           case m_calc.m_data.m_corr_argument of
              0:
                 begin
                  tpo := m_calc.m_corr_tpmin+i1*dtpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;

              1:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upmin+i1*dupo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;

              2:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpmin+i1*dDpo;
                 end;

              3:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbmin+i1*dtbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;
            end;

          data[0,i1] := m_calc.GetAuthorFunctionValue(I2, nFunction-200, tpo, tbo, upo, Dpo);
        //  data[0,i1]:=round(data[0,i1]*1E6)/1E6;

      if (i1=0)  then
                            begin
                              data_max := data[0][i1];
                              data_min := data[0][i1];
                            end
                           else
                            begin
                              if (data[0][i1] < data_min) then data_min := data[0][i1];
                              if (data[0][i1] > data_max) then data_max := data[0][i1];
                            end;

        end;




END
ELSE
BEGIN

//--------------------------------------------------------------------------------------------------------------
//    m_calc.m_data.m_corr_bCheckedTav:=true;//!!!!!!!!!!!!
//    m_calc.m_data.m_corr_bCheckedD1:=true;//!!!!!!!!!!!!
//    m_calc.m_data.m_corr_bCheckedD2:=true;//!!!!!!!!!!!!
//    m_calc.m_data.m_corr_bChecked_dzdt:=true;
//    m_calc.m_data.m_corr_bChecked_cz:=true;
//    m_calc.m_data.m_corr_bChecked_Tc:=true;
//    m_calc.m_data.m_corr_bChecked_q:=true; // разобраться с висом
//    m_calc.m_data.m_corr_bChecked_Tspl:=true;
//    m_calc.m_data.m_corr_bChecked_SGbm:=true;
//    m_calc.m_data.m_corr_bChecked_Fo:=true;

    // редкие режимы:
//    m_calc.m_data.m_corr_bChecked_hbm:=true;
//    m_calc.m_data.m_corr_bChecked_cxi:=true;

    if (m_calc.m_data.m_corr_bCheckedTav) then
                                            begin
                                              nFunction := 202;
                                              m_cube_Y:='Tav, К/сек';
                                            end;
    if (m_calc.m_data.m_corr_bCheckedD1) then
                                            begin
    nFunction := 203;
                                              m_cube_Y:='d1, м';
                                            end;
    if (m_calc.m_data.m_corr_bCheckedD2) then
                                            begin
    nFunction := 204;
                                              m_cube_Y:='d2, м';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_dzdt) then
                                            begin
    nFunction := 205;
                                              m_cube_Y:='dz/dt, м/с';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_cz) then
                                            begin
    nFunction := 206;
                                              m_cube_Y:='Czetta, ';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_Tc) then
                                            begin
    nFunction := 207;
                                              m_cube_Y:='Tc, К';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_q) then
                                            begin
    nFunction := 208;
                                              m_cube_Y:='q, Вт/м*м';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_Tspl) then
                                            begin
    nFunction := 209;
                                              m_cube_Y:='ts, сек';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_SGbm) then
                                            begin
    nFunction := 213;
                                              m_cube_Y:='Sigma bm ';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_Fo) then
                                            begin
    nFunction := 214;
                                              m_cube_Y:='Fo ';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_cxi) then
                                            begin
    nFunction := 215;
                                              m_cube_Y:='C ksi';
                                            end;
    if (m_calc.m_data.m_corr_bChecked_hbm) then
                                            begin
    nFunction := 216;
                                              m_cube_Y:='Hb';
                                            end;

//    I2 := 0;
    countFunctions:=0;
    I2:=countFunctions;

    if (nFunction >= 202) and (nFunction <= 216)   then
      begin
        for i1:=0 to data_size do
          begin
           case m_calc.m_data.m_corr_argument of
              0:
                 begin
                  tpo := m_calc.m_corr_tpmin+i1*dtpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;

              1:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upmin+i1*dupo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;

              2:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpmin+i1*dDpo;
                 end;

              3:
                 begin
                  tpo := m_calc.m_corr_tpo;
                  tbo := m_calc.m_corr_tbmin+i1*dtbo;
                  upo := m_calc.m_corr_upo;
                  Dpo := m_calc.m_corr_Dpo;
                 end;
            end;

           data[0][i1] := m_calc.GetAuthorFunctionValue(I2, nFunction-200, tpo, tbo, upo, Dpo);

           if                         (i1=0) then
                                               begin
                                                 data_min := data[0][i1];
                                                 data_max := data[0][i1];
                                               end
                                             else
                                               begin
                                                 if (data[0][i1] < data_min) then data_min := data[0][i1];
                                                 if (data[0][i1] > data_max) then data_max := data[0][i1];
                                               end;
          end;


  case m_calc.m_data.m_corr_argument of
   0:
      begin
        data_min_arg := m_calc.m_corr_tpmin;
        data_max_arg := m_calc.m_corr_tpmax;
      end;
   1:
      begin
        data_min_arg := m_calc.m_corr_upmin;
        data_max_arg := m_calc.m_corr_upmax;
      end;
   2:
      begin
        data_min_arg := m_calc.m_corr_Dpmin;
        data_max_arg := m_calc.m_corr_Dpmax;
      end;
   3:
      begin
        data_min_arg := m_calc.m_corr_tbmin;
        data_max_arg := m_calc.m_corr_tbmax;
      end;
  end;


      end;

END;


//}

  if data_max_arg = data_min_arg then begin data_max_arg:=data_max_arg+1;  data_min_arg:=data_min_arg-1; end;

  if data_max = data_min         then begin data_max:=data_max+1;          data_min:=data_min-1; end
   else
     begin





    general_step := 0;
    grid_data_max := data_max;
    grid_data_min := data_min;

    if (grid_data_max <> 0.0)   then
    while (abs(grid_data_max) < 1.0)   do
    begin
      grid_data_max := grid_data_max*10.0;
      grid_data_min := grid_data_min*10.0;
      general_step:=general_step+1;
    end;

    if (grid_data_max <> 0.0)   then
    while (abs(grid_data_max) > 10.0) do
    begin
      grid_data_max := grid_data_max/10.0;
      grid_data_min := grid_data_min/10.0;
      general_step:=general_step-1;
    end;

   if general_step <> 0 then
                         begin
                          m_cube_Y := m_cube_Y + ' *10^'+inttostr(general_step);

                          for i1:=0 to data_size do
                            begin
                              for i2 := 1 to abs(general_step) do
                               begin
                                 if general_step>0 then
                                                     data[0,i1] := data[0,i1]*10
                                                   else
                                                     data[0,i1] := data[0,i1]/10;
                               end;

//                              for i2 := general_step downto 1 do
//                                 data[0,i1] := data[0,i1]/10;

                         //     data[0,i1] := data[0,i1]*step(10, general_step);
                             // data[0,i1] := round(data[0,i1]*1E4)/1E4;
                            end;


                              for i2 := 1 to abs(general_step) do
                               begin
                                 if general_step>0 then
                                                     begin
                                                     data_max := data_max*10;
                                                     data_min := data_min*10;
                                                     end
                                                   else
                                                     begin
                                                     data_max := data_max/10;
                                                     data_min := data_min/10;
                                                     end;
                               end;

                         end;


     end;

//  drawmode:=2;
