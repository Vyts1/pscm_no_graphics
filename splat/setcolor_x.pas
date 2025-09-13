 if NOT bCondition then
  begin
    for i:=-1 to 1 do
      for j:=-1 to 1 do
        for k:=-1 to 1 do
          if (i0+i >= 0)           AND
             (i1+j >= 0)           AND
             (i2+k >= 0)           AND
             (i0+i <= m_nTrian[0]) AND
             (i1+j <= m_nTrian[1]) AND
             (i2+k <= m_nTrian[2]) AND
             (m_colors_cube[i0+i][i1+j][i2+k]=0)
          then
              m_colors_cube[i0+i][i1+j][i2+k] := nColor;
  end;
 nColor:=nColor+1;
