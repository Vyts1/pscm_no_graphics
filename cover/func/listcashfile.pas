function ListCashFile (s:string):integer;
var   f : file of dumppair;
      fout : TextFile;
      i, j : integer;
      tempel:dumppair;
      s2:string;

begin
  AssignFile (f,'cash\'+s);
  reset (f);
  AssignFile (fout,'tlist.csv');
  rewrite (fout);

  writeln (fout, 'Дамп файла ' + s);
  s2:='TX;TY;NUM;NUM2;EL_P0;EL_S1;EL_S2;S2-P0;S2-S1;S1-P0;EL_TP;EL_SLOY;EL_NUM';
  writeln (fout, s2);
  j := 0;

  for i:=0 to FileSize (f)-1 do
   begin
     read (f, tempel);
     s2 := '';

     s2 := s2 + inttostr(tempel.tx) + ';';
     s2 := s2 + inttostr(tempel.ty) + ';';
     s2 := s2 + inttostr(tempel.num) + ';';
     s2 := s2 + tempel.num2 + ';';

     s2 := s2 + FloatToStr(tempel.el.p0) + ';';
     s2 := s2 + FloatToStr(tempel.el.s1) + ';';
     s2 := s2 + FloatToStr(tempel.el.s2) + ';';

     s2 := s2 + FloatToStr(tempel.el.s2-tempel.el.p0) + ';';
     s2 := s2 + FloatToStr(tempel.el.s2-tempel.el.s1) + ';';
     s2 := s2 + FloatToStr(tempel.el.s1-tempel.el.p0) + ';';


     s2 := s2 + inttostr(tempel.el.tp) + ';';

     s2 := s2 + inttostr(tempel.el.sloy) + ';';
     s2 := s2 + inttostr(tempel.el.num) + ';';

     writeln (fout, s2);
     j := j + 1;
   end;

  CloseFile (f);
  result := j;

end;
