function GetATgDeg (x, y : double) : double;
var f:double;
begin
   if x<>0 then
     begin
       f := ArcTan(y / x) * 180 / PI;
       if x > 0 then
         begin
            if y < 0 then
                       begin
                         f := 360+f;
                       end;
         end    else
         begin  //X<0
            if y > 0 then
                       begin
                         f:=180+f;
                       end
                     else
                       begin
                         f:=180+f;
                       end;

         end;

     end   else
     begin
       if Y > 0 then f := 90
                else f := 270;
     end;
  GetATgdeg := f;
end;
