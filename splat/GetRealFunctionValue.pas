function GetRealFunctionValue(nFunction, i, j:integer): integer;
var res:integer;
      ac, tpo, tbo, pe, Fo, Dp, a, tetac:real;
begin
  // 0 - Tpo, 1 - Tbo, 2 - Pe
  res := 0;
  ac := 0.259;

  case (nFunction) of

  6: // i=Tbo, j=Pe, function=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    tpo := -Ke*tbo+(1+Ke)*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  7:
   begin
    tbo := tboMin+i*dAxis[1];
    tpo := -Ke*tbo+(1+Ke)*m_calc.m_DBSet_sub.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
// геометрические характеристики (по пунктам в таблице)
  11: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    tpo := ((C-D)+(B-A)*a_g4*sqrt(pe)-a_g4*a_g4*pe-C*tbo/m_calc.m_DBSet_part.m_Tm)/(a_g4*B*sqrt(pe)-D)*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  12: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    tpo := ((C-D)+(B-A)*a_g5*sqrt(pe)-a_g5*a_g5*pe-C*tbo/m_calc.m_DBSet_part.m_Tm)/(a_g5*B*sqrt(pe)-D)*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
// Температурно-временные характеристики
  13: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    Fo := m_calc.m_data.m_ttFo;
    a_t1 := (1.-pe*Fo)/sqrt(Fo);
    tpo := ((C-D)+(B-A)*a_t1-a_t1*a_t1-C*tbo/m_calc.m_DBSet_part.m_Tm)/(a_t1*B-D)*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  14: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    a := m_calc.m_DBSet_part.m_Lml/m_calc.m_DBSet_part.m_ROml/m_calc.m_DBSet_part.m_CPml;
    Dp := m_calc.m_data.m_Dpmin;
    Fo := a*m_calc.m_data.m_ttt*(1e-6)/(Dp*Dp);
    a_t1 := (1.-pe*Fo)/sqrt(Fo);
    tpo := ((C-D)+(B-A)*a_t1-a_t1*a_t1-C*tbo/m_calc.m_DBSet_part.m_Tm)/(a_t1*B-D)*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  15: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    tetac := m_calc.m_data.m_ttTetac;
    tpo := (1.+(A*A*(1-tetac)-C*(tetac-tbo/m_calc.m_DBSet_part.m_Tm)*(tetac-tbo/m_calc.m_DBSet_part.m_Tm))/(D*(tetac-tbo/m_calc.m_DBSet_part.m_Tm)))*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  16: // i=Tbo, j=Pe, res=Tpo
   begin
    tbo := tboMin+i*dAxis[1];
    pe := peMin+j*dAxis[2];
    tetac := m_calc.m_data.m_ttTc/m_calc.m_DBSet_part.m_Tm;
    tpo := (1.+(A*A*(1-tetac)-C*(tetac-tbo/m_calc.m_DBSet_part.m_Tm)*(tetac-tbo/m_calc.m_DBSet_part.m_Tm))/(D*(tetac-tbo/m_calc.m_DBSet_part.m_Tm)))*m_calc.m_DBSet_part.m_Tm;
    res := round((tpo-tpoMin)/dAxis[0]);
   end;
  end;

  GetRealFunctionValue := res;
end;
