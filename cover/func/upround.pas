function UpRound (r:real):integer;
var absr:real;
    sign:integer;
begin
 if r<0 then sign:=-1
        else sign:=+1;
 absr := abs(r);
 if absr - trunc (absr) > 0 then UpRound:=(trunc (absr)+1)*sign
                            else UpRound:=trunc (absr)*sign;
end;

function upround2 (r:real):integer;
begin
 if trunc(r)<>r then upround2:=trunc(r)+1
                else upround2:=trunc(r);
end;
