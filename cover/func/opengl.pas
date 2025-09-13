

//—читает нормаль к плоскости заданой 3€ точками
procedure calculateNormal (x1,y1,z1, x2,y2,z2, x3,y3,z3:real );
var l:real;
     x,y,z:real;
begin
 X:=y1*(z2-z3)+y2*(z3-z1)+y3*(z1-z2);
 Y:=z1*(x2-x3)+z2*(x3-x1)+z3*(x1-x2);
 Z:=x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2);
 l:=sqrt(X*X+Y*Y+Z*Z);
 if l<>0 then glNormal3f(X/l, Y/l, Z/l)
         else glNormal3f(0, 0, 1);
end;

procedure newstath;
var statmax:real;
begin
 statmax := Max (vrb.stat_x, vrb.stat_y);
 statmax := Max (vrb.stat_h, statmax);

 vrb.kfm:= 1 / (statmax);

 vrb.Koy:= vrb.stat_y*vrb.kfm/2;
 vrb.Kox:= vrb.stat_x*vrb.kfm/2;
 vrb.Koz:= vrb.stat_h*vrb.kfm/2;;
end;

procedure setcol (c:byte);
begin
  case c of

   1 : glColor3f (1.0, 0.0, 0.0);
   2 : glColor3f (0.0, 1.0, 0.0);
   3 : glColor3f (0.0, 0.0, 1.0);
   4 : glColor3f (0.0, 0.0, 0.0);
   5 : glColor3f (1.0, 1.0, 1.0);
   6 : glColor3f (0.3, 0.3, 0.3);
//   ClYellow : glColor3f (1.0, 1.0, 0.0);

  else glColor3f (1.0, 1.0, 0.0);
  end;


end;
