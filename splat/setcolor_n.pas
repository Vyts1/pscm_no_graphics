
 if NOT bCondition
 then
  begin
    for i:=-1 to 1 do
      for j:=-1 to 1 do
        for k:=-1 to 1 do
          if (itpo+i >= 0) AND
             (itbo+j >= 0) AND
             (ipe+k  >= 0) AND
             (itpo+i <= m_nTrian[0]) AND
             (itbo+j <= m_nTrian[1]) AND
             (ipe+k  <= m_nTrian[2]) AND
             (m_colors_cube[itpo+i][itbo+j][ipe+k] = 0)
          then
              m_colors_cube[itpo+i][itbo+j][ipe+k] := nColor;

 nColor:=nColor+1;
  end;


