function GetH (x,y, xc, yc, R : integer;  h:real):real;
var alpha:real;
    l,rz:real;
begin
  alpha := 3.30277;
  l := sqrt ( sqr(xc-x) + sqr(yc-y) );
  if l <= R then rz := h * step(1-l/R, 1/alpha )
            else rz := 0;

  if rz < 0 then
     rz:=0;

  GetH := rz;
end;



function GetJH (Rp:real):real;
var V, h:real;
begin
  V := (4/3) * PI*Rp*Rp*Rp;
  GetJH := V / (PI*sqr(Rp));
end;

function GetJRs (h,Rp:real):real;
var v:real;
begin
  V := (4/3) * PI*Rp*Rp*Rp;
  GetJRs := Rp * sqrt( 2*Rp / h);
end;

