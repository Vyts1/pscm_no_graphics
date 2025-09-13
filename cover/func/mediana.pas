procedure med_filtr (a : Pversh_double_color; c:integer);
const d = 9; // ширина окна
var
  I,j, i1, j2, j3: Integer;
  kol_menshe, kol_bolshe  : integer;
  //c:integer;

begin
//  c := length(a^);

  for i1 := 0 to c-1 do
    begin

  {
  Form1.Memo1.Lines.add('==========================');
  for I := i1 to i1+d-1 do
   begin
    Form1.Memo1.Lines.add(floattostr(a[i]));
   end;
  }

      for i := i1 to i1+d-1 do
        begin
          kol_menshe := 0;
          kol_bolshe := 0;

          for j := i1 to i1+d-1 do
            begin
              if j>c-1 then j2 := j-c
                       else j2 := j;

              if a^[i].z > a^[j2].z then kol_menshe := kol_menshe+1
                              else
                                 begin
                                   if a^[i].z < a^[j2].z then kol_bolshe := kol_bolshe + 1;
                                 end;

            end;

          if NOT ((kol_bolshe > (d div 2)) OR (kol_menshe > (d div 2)))
            then
              begin
                if i1 + d div 2 > c-1 then j2 := i1 + d div 2 - c
                                      else j2 := i1 + d div 2;


                if i > c-1 then j3 := i - c
                           else j3 := i;


                a^[j2].z := a^[j3].z;

                //Form1.Memo1.Lines.add('Нашли медиану '+ inttostr(j3) + '  ' + floattostr(a[j3]));
                Break;
              end;
        end;


  {Form1.Memo1.Lines.add('..........................');

  for I := i1 to i1+d-1 do
   begin
    Form1.Memo1.Lines.add(floattostr(a[i]));
   end;

  Form1.Memo1.Lines.add('==========================');
  Form1.Memo1.Lines.add('==========================');
  Form1.Memo1.Lines.add('==========================');
  Form1.Memo1.Lines.add('==========================');
  }

    end;


//  for I := 0 to c - 1 do
//    Form1.Memo2.Lines.add(floattostr(a^[i]));


end;


procedure GetSmeshenie (x1, y1, z1, x2, y2, z2, x3, y3, z3: real; Rs,Rp:integer; dx:real; var smx:integer; var smy:integer);
var A,B,C,D,N : real;
    smx2,smy2:real;

function sign (a:real) :integer;
     begin
      if a>=0 then sign:=+1 else sign:=-1;
     end;
begin
  A := (y2-y1)*(z3-z1) - (y3-y1)*(z2-z1);
  B := (z2-z1)*(x3-x1) - (x2-x1)*(z3-z1);
  C := (x2-x1)*(y3-y1) - (y2-y1)*(x3-x1);
  N := sqrt (A*A+B*B+C*C);

  D := A*x1 + B*y1 + C*z1;
  if D < 0 then
    begin
      A:=-A;
      B:=-B;
      C:=-C;
    end;


  A := A / N;
  B := B / N;
  C := C / N;


//  if maincaunter = 1 then     log4('#;A;B;C;N;X1;X2;X3;Y1;Y2;Y3;Z1;Z2;Z3');
//  log4(inttostr(maincaunter)+';'+floattostr(A)+';'+floattostr(B)+';'+floattostr(C)+';'+floattostr(N)+';'+floattostr(x1)+';'+floattostr(x2)+';'+floattostr(x3)+';'+floattostr(y1)+';'+floattostr(y2)+';'+floattostr(y3)+';'+floattostr(z1)+';'+floattostr(z2)+';'+floattostr(z3) );




  if abs(C) > (1-iniVar.koef_mediani) then
    begin   //ничего двигать не надо
      smx:=0;
      smy:=0;
    end                else
    begin
      if C < 0 then
         begin
           A:=-A;
           B:=-B;
           C:=-C;
         end;

      if abs(A) < zero then
        begin
          smx := 0;
          smy := round (sign(A)*(Rs-Rp));
        end            else
        begin
          smx := round (sign(A) * (Rs-Rp) / sqrt (1+sqr(B/A)));
          smy := round ((B/A)* sign(A) * (Rs-Rp) / sqrt (1+sqr(B/A)) );
        end;
    end;

//  if smx>Rp then showmessage ('Сильно большое смещение по X');
//  if smy>Rp then showmessage ('Сильно большое смещение по Y');
  if smx>Rp then smx:=Rp;
  if smy>Rp then smy:=Rp;

end;
