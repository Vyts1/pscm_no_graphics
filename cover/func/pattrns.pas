function GetPiramH (xi, yi, a, b, ca, cb, h : real) : real;
var x, y : real;
    l1,l2:boolean;
begin

  x := xi - (a + ca) * trunc (xi / (a + ca));
  y := yi - (b + cb) * trunc (yi / (b + cb));



  if (x > a) OR (y > b) then //если попали в интервал...
  Result:=0
                        else
    begin
      // Это две прямые пирамидки.
      // a и b это грани, а ca и cb это интервалы
      // сама пирамида находится в углу в нулевой точке, ее центр (a/2; b/2)


      l1 := y >= (b*x)/a ;
      l2 := y >= ((-b*x)/a + b) ;


      if  l1      AND      l2  then
       begin
         Result:= 2*h* (b-y) / b;
       end;
      if      l1  AND (NOT l2) then
       begin
         Result := 2*h*x / a;
       end;
      if (NOT l1) AND      l2  then
       begin
         Result:= 2*h* (a-x) / a;
       end;
      if (NOT l1) AND (NOT l2) then
        begin
          Result := 2*h*y / b;
        end;


    end;

end;


function GetKonusH_norm (xi, yi, r1, r2, h : real) : real;
var x, y : real;
    l:real;
begin

  // сам паттерн радиуса 2*R2, а в центре конус радиуса R1

  x := xi - (2*r2) * trunc (xi / (2*r2));
  y := yi - (2*r2) * trunc (yi / (2*r2));

  l := sqrt ( sqr(r2-x) + sqr(r2-y) );
  if l > r1 then
                  Result:=0
            else
                  Result := h*(r1-l)/r1;

end;


function GetKonusH_plotn (xi, yi, r1, r2, h : real) : real;
var x, y : real;
    a, l, l2:real;
begin
  a := sqrt(2) * r2;

  x := xi - (a) * trunc (xi / (a));
  y := yi - (a) * trunc (yi / (a));


  l := sqrt ( sqr(a/2-x) + sqr(a/2-y) );

  if l > r1 then
   begin
     if x < a/2 then
       begin
          if y < a/2 then l2 := sqrt ( sqr(0-x) + sqr(0-y) )
                     else l2 := sqrt ( sqr(0-x) + sqr(a-y) );
       end      else
       begin
          if y < a/2 then l2 := sqrt ( sqr(a-x) + sqr(0-y) )
                     else l2 := sqrt ( sqr(a-x) + sqr(a-y) );
       end;

     if l2<=r1 then Result := h*(r1-l2)/r1
               else Result := 0;
   end
            else  Result := h*(r1-l)/r1;

end;
