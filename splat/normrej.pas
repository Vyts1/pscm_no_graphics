//==============================================================================
//                            Основной блок
//==============================================================================

 //-------------------------------------------------

//  m_calc.m_DBSet_part.Open;
  m_calc.m_DBSet_part.Move(m_calc.m_data.m_partMaterial+1);
//  m_calc.m_DBSet_part.Close;

//  m_calc.m_DBSet_sub.Open;
  m_calc.m_DBSet_sub.Move(m_calc.m_data.m_subMaterial+1);
//  m_calc.m_DBSet_sub.Close;

 //-------------------------------------------------
 m_nTrian[0]:=metok;
 m_nTrian[1]:=metok;
 m_nTrian[2]:=metok;
 m_nTrian[3]:=metok;


// НАДО ОБЕСПЕЧИВАТЬ СВЯЗЬ:
//    m_calc.m_data.m_bCheckedghs:=true;
//    m_calc.m_data.m_ghs:=3.5;

//    m_calc.m_data.m_bCheckedgDs:=true;
//    m_calc.m_data.m_gDs:=110.410;


//    m_calc.m_data.m_bCheckedgDsm:=true;
//    m_calc.m_data.m_bCheckedghcritm:=true;

//    m_calc.m_data.m_bCheckedIS:=true;  //тестируем чувствительность
//    m_calc.m_data.m_bCheckedDS:=true;


    m_calc.PrepareFunction(-1);
    m_calc.PrepareFunction(8);
    m_calc.PrepareFunction(9);
    m_calc.PrepareFunction(10);


    tpoMin := m_calc.m_data.m_Tpmin;
    tpoMax := m_calc.m_data.m_Tpmax;
    tboMin := m_calc.m_data.m_Tbmin;
    tboMax := m_calc.m_data.m_Tbmax;


    Ke := sqrt(m_calc.m_DBSet_sub.m_Lms * m_calc.m_DBSet_sub.m_ROms * m_calc.m_DBSet_sub.m_CPms /(m_calc.m_DBSet_part.m_Lml*m_calc.m_DBSet_part.m_ROml*m_calc.m_DBSet_part.m_CPml));
    var_a := m_calc.m_DBSet_part.m_Lml/m_calc.m_DBSet_part.m_ROml/m_calc.m_DBSet_part.m_CPml;
    peMin := m_calc.GetPeMin();
    peMax := m_calc.GetPeMax();

    // 0 - Tpo, 1 - Tbo, 2 - Pe
    dAxis[0] := (tpoMax-tpoMin)/m_nTrian[0];
    dAxis[1] := (tboMax-tboMin)/m_nTrian[1];
    dAxis[2] := (peMax-peMin)/m_nTrian[2];

    m_cube_minZ:=tpoMin;
    m_cube_maxZ:=tpoMax;

    m_cube_minY:=tboMin;
    m_cube_maxY:=tboMax;

    m_cube_minX:=peMin;
    m_cube_maxX:=peMax;

    m_cube_Z:='Tp';
    m_cube_Y:='Tb';
    m_cube_X:='Pe';


    Kupl := m_calc.m_Kupl;
    Lppsl := m_calc.m_DBSet_part.m_Lms/m_calc.m_DBSet_part.m_Lml;


    ac := 0.259;
    A := sqrt(PI)*Lppsl/Ke;  //<--- Это Пи ????
    B := 2.0*(1.0+ac)/sqrt(PI)/Kupl;
    C := 2.0*Lppsl/Kupl;
    D := -2.0*Lppsl*(1.+ac)/Ke/Kupl;

    a_g1 := 0.041;



    if (m_calc.m_data.m_bCheckedghsm) then
    begin
      ghsm := m_calc.m_data.m_ghsm;
      a_g2 := ghsm/sqrt(1.0-ghsm);
    end;

    if (m_calc.m_data.m_bCheckedgDsm) then
    begin
      gDsm := m_calc.m_data.m_gDsm;
      a_g3 := sqrt(2/3)/gDsm/sqrt(3/2*gDsm*gDsm-1);
    end;


    bEqDp := m_calc.m_data.m_Dpmax = m_calc.m_data.m_Dpmin;


//    m_calc.m_data.m_bCheckedghs:=true; //16
//    m_calc.m_data.m_ghs:=2; //16   17
//    m_calc.m_data.m_gDs:=146.059;//17
//    m_calc.m_data.m_bCheckedgDs:=true;  //17

    if (m_calc.m_data.m_bCheckedghs AND bEqDp) then
    begin
      ghs := m_calc.m_data.m_ghs;
      Dp := m_calc.m_data.m_Dpmin;
      a_g4 := ghs/sqrt(Dp*(Dp-ghs));
    end;


    if (m_calc.m_data.m_bCheckedgDs AND bEqDp) then
    begin
      ghs :=m_calc.m_data.m_ghs;
      Dp := m_calc.m_data.m_Dpmin;
      a_g5 := ghs/sqrt(Dp*(Dp-ghs));
    end;


    m_bEmpty := true; // Изначально точек нет.

    if (BN = 1) then
    begin

    if (m_calc.m_data.m_bCheckedghcritm OR m_calc.m_data.m_bCheckedgDcritm OR m_calc.m_data.m_bCheckedghsm OR m_calc.m_data.m_bCheckedgDsm) then m_calc.PrepareFunction(8);
    if (m_calc.m_data.m_bCheckedghsm) then m_calc.PrepareFunction(9);
    if (m_calc.m_data.m_bCheckedgDsm) then m_calc.PrepareFunction(10);
    if (m_calc.m_data.m_bCheckedttdTdt) then m_calc.PrepareFunction(17);
    if (m_calc.m_data.m_bCheckedtcSGbm) then m_calc.PrepareFunction(18);
    end;

    if (BN = 2) then
    begin
    if (m_calc.m_data.m_bCheckedDS) then m_calc.PrepareFunction(100);
    if (m_calc.m_data.m_bCheckedIS) then m_calc.PrepareFunction(102);
    end;


//    #define SET_COLOR if (!nCondition) for (i=-1; i<=1; i++) for (j=-1; j<=1; j++) for (k=-1; k<=1; k++) if (itpo+i >= 0 && itbo+j >= 0 && ipe+k >= 0 && itpo+i <= m_nTrian[0] && itbo+j <= m_nTrian[1] && ipe+k <= m_nTrian[2] && !m_colors_cube[itpo+i][itbo+j][ipe+k]) m_colors_cube[itpo+i][itbo+j][ipe+k] = nColor; nColor++;
//    CMainFrame *pMainWnd = (CMainFrame*)m_pMainWnd;

    nCondition := true;

{    m_cube_Z_min:=tpoMin;
    m_cube_Z_max:=
    m_cube_Z_str:='Tpo';

    m_cube_Y_min:=tboMin;
    m_cube_Y_max:=
    m_cube_Y_str:='Tbo';

    m_cube_X_min:=peMin;
    m_cube_X_max:=
    m_cube_X_str:='Pe';

    tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]
    m_cube[itpo][itbo][ipe]
 }
    for itpo:=0 to m_nTrian[0] do
      begin
       //pMainWnd->m_progress.SetPos(itpo/((float)m_nTrian[0])*100.);
        for itbo:=0 to m_nTrian[1] do
          for ipe:=0 to m_nTrian[2] do
           begin
            nColor := 1;
            if (ipe = 0) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:=nColor+1;
            if (ipe = m_nTrian[2]) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:=nColor+1;
            if (itpo = 0) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:=nColor+1;
            if (itpo = m_nTrian[0]) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:=nColor+1;
            if (itbo = 0) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:= nColor+1;
            if (itbo = m_nTrian[1]) then m_colors_cube[itpo][itbo][ipe] := nColor; nColor:=nColor+1;


//            m_calc.m_data.m_Scen := 1;
//            m_calc.m_data.m_Scen := 5;

            if (m_calc.m_data.m_Scen = 0) then
                                    begin
                                      if (m_calc.m_DBSet_part.m_Tm > m_calc.m_DBSet_sub.m_Tm) then
                                                                                  nCondition := itpo<=GetRealFunctionValue(7, itbo, ipe)
                                                                                else
                                                                                  nCondition := itpo<=GetRealFunctionValue(6, itbo, ipe);
                                    end;

            if (m_calc.m_data.m_Scen = 1) then
                                    begin
                                      if (m_calc.m_DBSet_part.m_Tm > m_calc.m_DBSet_sub.m_Tm) then
                                                                                 begin
                                                                                  nCondition := itpo<=GetRealFunctionValue(6, itbo, ipe);
                                                                                   if (nCondition) then nCondition := itpo>=GetRealFunctionValue(7, itbo, ipe);
                                                                                 end
                                                                                else nCondition := false;
                                    end;


            if (m_calc.m_data.m_Scen = 2) then
                                    begin
                                      if (m_calc.m_DBSet_sub.m_Tm > m_calc.m_DBSet_part.m_Tm) then
                                                                                 begin
                                                                                  nCondition := itpo>=GetRealFunctionValue(6, itbo, ipe);
                                                                                  if (nCondition) then nCondition := itpo<=GetRealFunctionValue(7, itbo, ipe);
                                                                                 end
                                                                                else nCondition := false;
                                    end;

            if (m_calc.m_data.m_Scen = 3) then
                                    begin
                                      if (m_calc.m_DBSet_part.m_Tm >= m_calc.m_DBSet_sub.m_Tm) then
                                                                                  nCondition := itpo>=GetRealFunctionValue(6, itbo, ipe)
                                                                                 else
                                                                                  nCondition := itpo>=GetRealFunctionValue(7, itbo, ipe);
                                    end;
            //      SET_COLOR
            {$I 'splat\setcolor_n.pas'}

 //}

//            m_calc.m_data.m_Scen := 1;

    if (BN = 1) then
    begin

            // проверяем геометрические ограничения
            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedghsm) then
               begin
                function_result := m_calc.GetFunctionValue(9, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                if m_calc.m_data.m_bIsMoreghsm then
                                         nCondition :=  function_result<=0
                                        else
                                         nCondition := function_result>=0;
                //SET_COLOR
                {$I 'splat\setcolor_n.pas'}
               end;
             end;


            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedgDsm) then
               begin
                function_result := m_calc.GetFunctionValue(10, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                if m_calc.m_data.m_bIsMoregDsm  then nCondition :=  function_result>=0 else nCondition := function_result<=0;
                //SET_COLOR
                {$I 'splat\setcolor_n.pas'}
               end;
             end;


            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedghcritm OR m_calc.m_data.m_bCheckedgDcritm) then
               begin
                nCondition := m_calc.GetFunctionValue(8, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2])<=0;
                //SET_COLOR
                {$I 'splat\setcolor_n.pas'}
               end;
             end;




            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedghs AND bEqDp) then        // 16 размерная толщина
                begin
                  if m_calc.m_data.m_bIsMoreghs then nCondition := itpo<=GetRealFunctionValue(11, itbo, ipe)
                                                else nCondition := itpo>=GetRealFunctionValue(11, itbo, ipe);
                  //SET_COLOR
                {$I 'splat\setcolor_n.pas'}
                end;
             end;

            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedgDs AND bEqDp) then        //  17 размерный диаметр
                          begin
                            if m_calc.m_data.m_bIsMoregDs then nCondition := itpo<=GetRealFunctionValue(12, itbo, ipe)
                                                          else nCondition := itpo>=GetRealFunctionValue(12, itbo, ipe);
                            //SET_COLOR
                            {$I 'splat\setcolor_n.pas'}
                          end;
             end;


            // температурно-временные ограничения
            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedttFo) then
                          begin
                            if m_calc.m_data.m_bIsMorettFo then nCondition := itpo>=GetRealFunctionValue(13, itbo, ipe)
                                                           else nCondition := itpo<=GetRealFunctionValue(13, itbo, ipe);
                           //SET_COLOR
                           {$I 'splat\setcolor_n.pas'}
                          end;
             end;

            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedttt) then
                          begin
                           if m_calc.m_data.m_bIsMorettt then nCondition := itpo>=GetRealFunctionValue(14, itbo, ipe)
                                                         else nCondition := itpo<=GetRealFunctionValue(14, itbo, ipe);
                           //SET_COLOR
                           {$I 'splat\setcolor_n.pas'}
                          end;
             end;

            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedttTetac) then
                                              begin
                                               if m_calc.m_data.m_bIsMorettTetac then nCondition := itpo>=GetRealFunctionValue(15, itbo, ipe)
                                                                                 else nCondition := itpo<=GetRealFunctionValue(15, itbo, ipe);
                                               //SET_COLOR
                                               {$I 'splat\setcolor_n.pas'}
                                              end;
             end;

            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedttTc) then
                                          begin
                                           if m_calc.m_data.m_bIsMorettTc  then nCondition := itpo>=GetRealFunctionValue(16, itbo, ipe)
                                                                           else nCondition := itpo<=GetRealFunctionValue(16, itbo, ipe);
                                           //SET_COLOR
                                           {$I 'splat\setcolor_n.pas'}
                                          end;
             end;

            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedttdTdt) then
                                            begin
                                             function_result := m_calc.GetFunctionValue(17, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                             if m_calc.m_data.m_bIsMorettdTdt
                                                                       then nCondition := function_result>=0
                                                                       else nCondition := function_result<=0;
                                             //SET_COLOR
                                             {$I 'splat\setcolor_n.pas'}
                                            end;
             end;

            // Технологические характеристики
            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedtcSGbm) then
                                            begin
                                             function_result := m_calc.GetFunctionValue(18, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                             if m_calc.m_data.m_bIsMoretcSGbm then nCondition := function_result>=0
                                                                              else nCondition := function_result<=0;
                                             //SET_COLOR
                                             {$I 'splat\setcolor_n.pas'}
                                            end;
             end;
    end;


    if (BN = 2) then
    begin

            // Прямая чувствительность
            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedDS) then
                                          begin
                                           nCondition := 0<=m_calc.GetFunctionValue(100, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                           if (nCondition) then
                                                            nCondition := 0>=m_calc.GetFunctionValue(101, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                           //SET_COLOR
                                           {$I 'splat\setcolor_n.pas'}
                                          end;
             end;


            // Обратная чувствительность
            if (nCondition) then
             begin
              if (m_calc.m_data.m_bCheckedIS) then
                                        begin
                                         nCondition := 0<=m_calc.GetFunctionValue(102, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                         if (nCondition) then
                                                           nCondition := 0>=m_calc.GetFunctionValue(103, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                                         //SET_COLOR
                                         {$I 'splat\setcolor_n.pas'}
                                        end;
             end;
    end;

//            if (NOT nCondition) then m_cube[itpo][itbo][ipe] := 0;
            if (nCondition) then m_cube[itpo][itbo][ipe] := 0  // Будет выводиться!
                            else m_cube[itpo][itbo][ipe] := 1; // Не будет выводиться!

            if (m_bEmpty) then m_bEmpty := NOT nCondition; // Если empty=true, то массив пуст
                                                           // empty=false, то в массиве есть точка.


           end;
      end;

    if (BN = 2) then
    begin

  //я тут заменил, на что приравнивать вместо 0 поставил 1. так оно по логике должно быть, а то лажа получается, артефакты вылезают.
  // Для обратной чувствительности обводим контур и обрезаем Pe+-dPe
    if (m_calc.m_data.m_bCheckedIS) then
             begin
               if (m_calc.m_data.m_isCalcValue = 0) then   //Это выбрано Tpo
                     begin
                       iitpo := round((m_calc.m_data.m_isTpo-tpoMin)/dAxis[0]);
                       for ipe:=0 to m_nTrian[2] do
                          for itbo:=0 to m_nTrian[1] do
                             begin
                               dtpo := m_calc.GetFunctionValue(105, tpoMin+iitpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+ipe*dAxis[2]);
                               for itpo:=0 to m_nTrian[0] do
                                 begin
                                    nCondition := (tpoMin+itpo*dAxis[0]-m_calc.m_tpo-dtpo >= 0) AND (tpoMin+itpo*dAxis[0]-m_calc.m_tpo+dtpo <= 0);
                                    if ( not nCondition) then
                                                           begin
//                                                             m_cube[itpo][itbo][ipe] := 0;
                                                             m_cube[itpo][itbo][ipe] := 1;
                                                             nColor := 13;
                                                             //SET_COLOR
                                                           end
                                                         else
                                                             m_colors_cube[iitpo][itbo][ipe] := 0;

                                    if m_bEmpty then m_bEmpty := not nCondition;
                                 end;
                             end;
                     end;


               if (m_calc.m_data.m_isCalcValue = 1) then    //Это выбрано Tbo
                     begin
                       iitbo := round((m_calc.m_data.m_isTbo-tboMin)/dAxis[1]);
                       for ipe:=0 to m_nTrian[2] do
                          for itpo:=0 to m_nTrian[0] do
                             begin
                               dtbo := m_calc.GetFunctionValue(106, tpoMin+itpo*dAxis[0], tboMin+iitbo*dAxis[1], peMin+ipe*dAxis[2]);
                               for itbo:=0 to m_nTrian[1] do
                                 begin
                                    nCondition := (tboMin+itbo*dAxis[1]-m_calc.m_tbo-dtbo >= 0) AND (tboMin+itbo*dAxis[1]-m_calc.m_tbo+dtbo <= 0);
                                    if ( not nCondition) then
                                                           begin
//                                                             m_cube[itpo][itbo][ipe] := 0;
                                                             m_cube[itpo][itbo][ipe] := 1;
                                                             nColor := 13;
                                                             //SET_COLOR
                                                           end
                                                         else
                                                           m_colors_cube[itpo][iitbo][ipe] := 0;

                                    if (m_bEmpty) then m_bEmpty := not nCondition;
                                 end;
                             end;
                     end;


               if (m_calc.m_data.m_isCalcValue = 2) then    // Это выбрано Pe
                     begin
                       iipe := round((m_calc.m_data.m_isPe-peMin)/dAxis[2]);

                       for itpo:=0 to m_nTrian[0] do
                          for itbo:=0 to m_nTrian[1] do
                             begin
                               dpe := m_calc.GetFunctionValue(104, tpoMin+itpo*dAxis[0], tboMin+itbo*dAxis[1], peMin+iipe*dAxis[2]);
                               for ipe:=0 to m_nTrian[2] do
                                  begin
                                    nCondition := (peMin+ipe*dAxis[2]-m_calc.m_pe-dpe <= 0) AND (peMin+ipe*dAxis[2]-m_calc.m_pe+dpe >= 0);
                                    if (not nCondition) then
                                                          begin
//                                                            m_cube[itpo][itbo][ipe] := 0;
                                                            m_cube[itpo][itbo][ipe] := 1;
                                                            nColor := 13;
                                                            //SET_COLOR
                                                          end
                                                        else
                                                          m_colors_cube[itpo][itbo][iipe] := 0;
                                    if (m_bEmpty) then m_bEmpty := not nCondition;
                                  end;
                             end;
                     end;

             end; // конец "обводки" IS ???


  // }
    end;




//==============================================================================
