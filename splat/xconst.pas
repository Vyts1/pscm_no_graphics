 //-------------------------------------------------

//  m_calc.m_DBSet_part.Open;
  m_calc.m_DBSet_part.Move(m_calc.m_data.m_xconst_partMaterial+1);
//  m_calc.m_DBSet_part.Close;

//  m_calc.m_DBSet_sub.Open;
  m_calc.m_DBSet_sub.Move(m_calc.m_data.m_xconst_subMaterial+1);
//  m_calc.m_DBSet_sub.Close;

 //-------------------------------------------------



 m_calc.PrepareFunction(-1);
 m_calc.PrepareFunction(300);

 m_nTrian[0]:=metok;
 m_nTrian[1]:=metok;
 m_nTrian[2]:=metok;
 m_nTrian[3]:=metok;

 num_i:=0;
 dtpo := (m_calc.m_xconst_tpmax-m_calc.m_xconst_tpmin)/m_nTrian[num_i];
 if (m_calc.m_data.m_xconst_argument <> 0) then num_i:=num_i+1;

 dtbo := (m_calc.m_xconst_tbmax-m_calc.m_xconst_tbmin)/m_nTrian[num_i];
 if (m_calc.m_data.m_xconst_argument <> 1) then num_i:=num_i+1;

 dupo := (m_calc.m_xconst_upmax-m_calc.m_xconst_upmin)/m_nTrian[num_i];
 if (m_calc.m_data.m_xconst_argument <> 2) then num_i:=num_i+1;

 ddpo := (m_calc.m_xconst_Dpmax-m_calc.m_xconst_Dpmin)/m_nTrian[num_i];

 bCondition := true;
 m_bEmpty := true;

 case (m_calc.m_data.m_xconst_argument) of
   0: //Tpo = const
     begin
       m_cube_minZ:=m_calc.m_xconst_tbmin;
       m_cube_maxZ:=m_calc.m_xconst_tbmax;

       m_cube_minY:=m_calc.m_xconst_upmin;
       m_cube_maxY:=m_calc.m_xconst_upmax;

       m_cube_minX:=m_calc.m_xconst_Dpmin*1E6;
       m_cube_maxX:=m_calc.m_xconst_Dpmax*1E6;

       m_cube_Z:='Tb=';
       m_cube_Y:='up=';
       m_cube_X:='Dp=';
     end;
   1: //upo = const
     begin
       m_cube_minZ:=m_calc.m_xconst_tpmin;
       m_cube_maxZ:=m_calc.m_xconst_tpmax;

       m_cube_minY:=m_calc.m_xconst_tbmin;
       m_cube_maxY:=m_calc.m_xconst_tbmax;

       m_cube_minX:=m_calc.m_xconst_Dpmin*1E6;
       m_cube_maxX:=m_calc.m_xconst_Dpmax*1E6;

       m_cube_Z:='Tp=';
       m_cube_Y:='Tb=';
       m_cube_X:='Dp=';
     end;

   2: //Dpo = const
     begin
       m_cube_minZ:=m_calc.m_xconst_tpmin;
       m_cube_maxZ:=m_calc.m_xconst_tpmax;

       m_cube_minY:=m_calc.m_xconst_tbmin;
       m_cube_maxY:=m_calc.m_xconst_tbmax;

       m_cube_minX:=m_calc.m_xconst_upmin;
       m_cube_maxX:=m_calc.m_xconst_upmax;

       m_cube_Z:='Tp=';
       m_cube_Y:='Tb=';
       m_cube_X:='up=';
     end;

   3: //Tbo = const
     begin
       m_cube_minZ:=m_calc.m_xconst_tpmin;
       m_cube_maxZ:=m_calc.m_xconst_tpmax;

       m_cube_minY:=m_calc.m_xconst_upmin;
       m_cube_maxY:=m_calc.m_xconst_upmax;

       m_cube_minX:=m_calc.m_xconst_dpmin*1E6;
       m_cube_maxX:=m_calc.m_xconst_dpmax*1E6;

       m_cube_Z:='Tp=';
       m_cube_Y:='up=';
       m_cube_X:='Dp=';
     end;

 end;

 for i0:=0 to m_nTrian[0] do
  begin
//   ((CMainFrame*)m_pMainWnd)->m_progress.SetPos(i0/((float)m_nTrian[0])*100.);
   for i1:=0 to m_nTrian[1] do
    for i2:=0 to m_nTrian[2] do
    begin
      // Считаем текущие значения аргументов взависимости от выбранного постоянного аргумента
      case (m_calc.m_data.m_xconst_argument) of
       0: //Tpo = const
        begin
         tpo := m_calc.m_xconst_tpo;
         tbo := m_calc.m_xconst_tbmin+i0*dtbo;
         upo := m_calc.m_xconst_upmin+i1*dupo;
         dpo := m_calc.m_xconst_Dpmin+i2*ddpo;
         //break;
        end;
       1: //upo = const
        begin
         tpo := m_calc.m_xconst_tpmin+i0*dtpo;
         tbo := m_calc.m_xconst_tbmin+i1*dtbo;
         upo := m_calc.m_xconst_upo;
         dpo := m_calc.m_xconst_Dpmin+i2*ddpo;
         //break;
        end;
      2: //Dpo = const
        begin
         tpo := m_calc.m_xconst_tpmin+i0*dtpo;
         tbo := m_calc.m_xconst_tbmin+i1*dtbo;
         upo := m_calc.m_xconst_upmin+i2*dupo;
         dpo := m_calc.m_xconst_Dpo;
         //break;
        end;
      3: //Tbo = const
        begin
         tpo := m_calc.m_xconst_tpmin+i0*dtpo;
         tbo := m_calc.m_xconst_tbo;
         upo := m_calc.m_xconst_upmin+i1*dupo;
         dpo := m_calc.m_xconst_Dpmin+i2*ddpo;
         //break;
        end;
      end;

      nColor := 1;
      bCondition := true;
      if (i0 = 0)           then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;
      if (i0 = m_nTrian[0]) then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;
      if (i1 = 0)           then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;
      if (i1 = m_nTrian[1]) then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;
      if (i2 = 0)           then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;
      if (i2 = m_nTrian[2]) then m_colors_cube[i0][i1][i2] := nColor; nColor:=nColor+1;

      // Вырезаем ограничения, накладываемые сценариями
      case (m_calc.m_data.m_xconst_nScen) of
       0: // Первый сценарий
        begin
         if m_calc.m_DBSet_part.m_Tm > m_calc.m_DBSet_sub.m_Tm then
                                                                bCondition :=m_calc.GetXconstFunctionValue(1, tpo, tbo, upo, dpo) < 0
                                                               else
                                                                bCondition :=m_calc.GetXconstFunctionValue(0, tpo, tbo, upo, dpo) < 0;

         //SET_COLOR
         {$I 'splat\setcolor_x.pas'}

         //break;
        end;
       1: // Второй сценарий
        begin

         if m_calc.m_DBSet_part.m_Tm > m_calc.m_DBSet_sub.m_Tm  then
                                                                 bCondition :=(m_calc.GetXconstFunctionValue(0, tpo, tbo, upo, dpo) < 0) AND (m_calc.GetXconstFunctionValue(1, tpo, tbo, upo, dpo) >= 0)
                                                                else
                                                                 bCondition :=false;
         //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
         //break;
        end;
       2: // Третий сценарий
        begin

         if m_calc.m_DBSet_part.m_Tm < m_calc.m_DBSet_sub.m_Tm then
                                                                 bCondition :=(m_calc.GetXconstFunctionValue(0, tpo, tbo, upo, dpo) >= 0) AND (m_calc.GetXconstFunctionValue(1, tpo, tbo, upo, dpo) < 0)
                                                               else
                                                                 bCondition :=false;
         //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
         //break;
        end;
       3: // Четвертый сценарий
        begin

         if m_calc.m_DBSet_part.m_Tm >= m_calc.m_DBSet_sub.m_Tm then
                                                                  bCondition :=m_calc.GetXconstFunctionValue(0, tpo, tbo, upo, dpo) >= 0.
                                                                else
                                                                  bCondition :=m_calc.GetXconstFunctionValue(1, tpo, tbo, upo, dpo) >= 0.;
         //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
         //break;
        end;
      end;
      //}

      //
      // Вырезаем остальные ограничения
      if (m_calc.m_data.m_xconst_bChecked_hsm AND bCondition) then
       begin
        function_result := m_calc.GetAuthorFunctionValue(19, 0, tpo, tbo, upo, dpo);

        if m_calc.m_data.m_xconst_bIsMore_hsm
                                               then bCondition := (function_result >= m_calc.m_data.m_xconst_hsm)
                                               else bCondition := (function_result <= m_calc.m_data.m_xconst_hsm);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
       end;

      if (m_calc.m_data.m_xconst_bChecked_Dsm AND bCondition) then
       begin
        function_result := m_calc.GetAuthorFunctionValue(19, 1, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Dsm then bCondition := function_result >= (m_calc.m_data.m_xconst_Dsm)
                                              else bCondition := function_result <= (m_calc.m_data.m_xconst_Dsm);
        //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
       end;


     m_calc.m_data.m_xconst_bChecked_hcritm:=true;

      if (m_calc.m_data.m_xconst_bChecked_hcritm AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(19, 0, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_hcritm then
                                                   bCondition := function_result >= m_calc.m_data.m_xconst_hcritm
                                                 else
                                                   bCondition := function_result <= m_calc.m_data.m_xconst_hcritm;
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;


      if (m_calc.m_data.m_xconst_bChecked_Dcritm AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(19, 1, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Dcritm
                  then bCondition := function_result >= (m_calc.m_data.m_xconst_Dcritm)
                  else bCondition := function_result <= (m_calc.m_data.m_xconst_Dcritm);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;

      if (m_calc.m_data.m_xconst_bChecked_hs AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 11, tpo, tbo, upo, dpo)*1.e6;
        if m_calc.m_data.m_xconst_bIsMore_hs then bCondition := function_result >= (m_calc.m_data.m_xconst_hs)
                                             else bCondition := function_result <= (m_calc.m_data.m_xconst_hs);
        //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
      end;

      if (m_calc.m_data.m_xconst_bChecked_Ds AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 12, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Ds then bCondition := function_result >= (m_calc.m_data.m_xconst_Ds)
                                             else bCondition := function_result <= (m_calc.m_data.m_xconst_Ds);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;

      if (m_calc.m_data.m_xconst_bChecked_Fo AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 14, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Fo
                                              then   bCondition := function_result >= (m_calc.m_data.m_xconst_Fo)
                                              else   bCondition := function_result <= (m_calc.m_data.m_xconst_Fo);
        //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
      end;

      if (m_calc.m_data.m_xconst_bChecked_t AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 9, tpo, tbo, upo, dpo)*1.e6;
        if m_calc.m_data.m_xconst_bIsMore_t then bCondition :=  function_result >= (m_calc.m_data.m_xconst_t)
                                            else bCondition := function_result <= (m_calc.m_data.m_xconst_t);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;

      if (m_calc.m_data.m_xconst_bChecked_tetac AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 10, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_tetac then bCondition :=  function_result >= (m_calc.m_data.m_xconst_tetac)
                                                else bCondition := function_result <= (m_calc.m_data.m_xconst_tetac);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;
      if (m_calc.m_data.m_xconst_bChecked_Tc AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 7, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Tc then bCondition := function_result >= (m_calc.m_data.m_xconst_Tc)
                                             else bCondition := function_result <= (m_calc.m_data.m_xconst_Tc);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;
      if (m_calc.m_data.m_xconst_bChecked_Tav AND bCondition) then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 2, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_Tav then bCondition := function_result >= (m_calc.m_data.m_xconst_Tav)
                                              else bCondition := function_result <= (m_calc.m_data.m_xconst_Tav);
        //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
      end;

      if (m_calc.m_data.m_xconst_bChecked_SGbm AND bCondition)then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 13, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_SGbm then bCondition :=  function_result >= (m_calc.m_data.m_xconst_SGbm)
                                               else bCondition :=  function_result <= (m_calc.m_data.m_xconst_SGbm);
        //SET_COLOR
         {$I 'splat\setcolor_x.pas'}
      end;

      if (m_calc.m_data.m_xconst_bChecked_hbm AND bCondition)then begin
        function_result := m_calc.GetAuthorFunctionValue(0, 16, tpo, tbo, upo, dpo);
        if m_calc.m_data.m_xconst_bIsMore_hbm then bCondition := function_result >= (m_calc.m_data.m_xconst_hbm)
                                              else bCondition := function_result <= (m_calc.m_data.m_xconst_hbm);
         {$I 'splat\setcolor_x.pas'}
        //SET_COLOR
      end;
     //}

      if ( bCondition) then m_cube[i0,i1,i2] := 1
                       else m_cube[i0,i1,i2] := 0;

//      if (m_bEmpty) then  m_bEmpty := not bCondition;
    end;




  end;
