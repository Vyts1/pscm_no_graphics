function CalcAVG:real;
var i,j:integer;
    stepx,stepy:integer;
    sum:real;
    k:integer;

begin

 stepx := round ((vrb.fild_x-2*iniVar.obrezka) / 10);
 stepy := round ((vrb.fild_y-2*iniVar.obrezka) / 10);

 sum:=0;
 k:=0;

 j:=iniVar.obrezka;
 while j <= vrb.fild_y-iniVar.obrezka do
  begin
    i:=iniVar.obrezka;
    while i <= vrb.fild_x-iniVar.obrezka do
      begin

        sum:=sum+up[cup[j,i],j,i].s2-zerolevel;
        k:=k+1;

        i:=i+stepx;
      end;

    j:=j+stepy;
  end;

 sum:=sum*iniVar.diskret_x;

 if k<>0 then CalcAVG := sum / k
         else CalcAVG := 0;
end;



