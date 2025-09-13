function N3x (n:integer; i:integer; u:real; knot:p3x) :real;
begin


 if n=0 then
         begin
          if (knot[i] <= u) AND (u < knot[i+1]) then N3x:=1 else N3x:=0;
         end
        else
         begin
          N3x:=( u - knot[i] ) * N3x( n-1, i, u, knot ) / (knot[i+n] - knot[i]) +
            ( knot[i+n+1] - u ) * N3x( n-1, i+1, u, knot ) / (knot[i+n+1] - knot[i+1]) ;


         end;


end;


function N3y (n:integer; i:integer; u:real; knot:p3y) :real;
begin


 if n=0 then
         begin
          if (knot[i] <= u) AND (u < knot[i+1]) then N3y:=1 else N3y:=0;
         end
        else
         begin
          N3y:=( u - knot[i] ) * N3y( n-1, i, u, knot ) / (knot[i+n] - knot[i]) +
            ( knot[i+n+1] - u ) * N3y( n-1, i+1, u, knot ) / (knot[i+n+1] - knot[i+1]) ;


         end;


end;


function N32xd (const n:integer; const i:integer; const u,u2,u3:double; const knot:p3x):Double;
begin
case i of
 0 : N32xd:= (1-u)*(1-u)*(1-u)/6;
 1 : N32xd:= (3*u3-6*u2+4)/6;
 2 : N32xd:= (-3*u3+3*u2+3*u+1)/6;
 3 : N32xd:= u3/6;
else N32xd:=0;
end;
end;



function N32yd (const n:integer; const i:integer; const u,u2,u3:double; const knot:p3y) :double;
begin
case i of
 0 : N32yd:= (1-u)*(1-u)*(1-u)/6;
 1 : N32yd:= (3*u3-6*u2+4)/6;
 2 : N32yd:= (-3*u3+3*u2+3*u+1)/6;
 3 : N32yd:= u3/6;
else N32yd:=0;
end;
end;





procedure VecAddS (t:double; a:point; b:point; var c:point );
begin
 C[0] := A[0]*t+B[0]; C[1] := A[1]*t+B[1]; C[2] := A[2]*t+B[2];
end;


procedure VecDiv ( a:point; t:double; var b:point );
begin
B[0] := A[0] / t; B[1] := A[1] / t; B[2] := A[2] / t;
end;


procedure nurbs_3_3 (p:p2; w:p4; uknot:p3x;  vknot:p3y ; k, l, n :integer; u, v: double; const d1 : integer; const d2 : integer; var out2:Point);
var z,q:point;
    t,s2,s1:real;
    u1,u2,u3,v1,v2,v3:double;
    j2,i,i2,j:integer;                        // i k x u        j l y v

    min, max:real;


begin

  u1:=d1/vrb.div2x;

  u2:=u1*u1;
  u3:=u2*u1;

  v1:=d2/vrb.div2y;

  v2:=v1*v1;
  v3:=v2*v1;

  z[0]:=0; z[1]:=0; z[2]:=0;
  s2:=0;
 

  //переопределить w[i,j].
  for  i := k-3 to k do
    for j := l-3 to l do
      begin
        if (i=k-3) AND (j=l-3) then
                                begin
                                 min:=p[i, j][2];
                                 max:=p[i, j][2];
                                end
                               else
                                begin
                                  if min > p[i, j][2] then min:=p[i, j][2];
                                  if max < p[i, j][2] then max:=p[i, j][2];
                                end;
      end;

  if max=min then
               begin
                 for  i := k-3 to k do
                   for j := l-3 to l do
                    begin
                     if w[i,j] < iniVar.koef_w*2 then
                                                   w[i,j]:=1;
                    end;
               end
             else
               begin
                 for  i := k-3 to k do
                   for j := l-3 to l do
                     if w[i,j] < iniVar.koef_w*2 then
                         w[i,j]:=1+(iniVar.koef_w*(p[i, j][2]-min))/(max-min);
               end;

  //}

  for  i := k-3 to k do
   begin
    s1 := 0 ;
    q[0]:=0; q[1]:=0; q[2]:=0;
    i2:=i-(k-3);


    for j := l-3 to l do
      begin


       j2:=j-(l-3);

       if vrb.div2y <> 1 then
                      begin
                       t:= N32yd( 3, j2, v1, v2, v3, vknot ) * w[i,j];

                      end
                     else
                      begin
       if d2=0 then
                begin
                 case j2 of
                  0 : t:= w[i,j]/6;
                  1 : t:= (w[i,j]*2)/3;
                  2 : t:= w[i,j]/6;
                  3 : t:= 0;
                  else t:=555;
                 end;
                end
               else
                begin
                 case j2 of
                  0 : t:= 0;
                  1 : t:= w[i,j]/6;
                  2 : t:= (w[i,j]*2)/3;
                  3 : t:= w[i,j]/6;
                  else t:=777;
                 end;
                end;


                      end;




	      s1 := s1 + t ;
	      VecAddS( t,  p[i, j], q, q );
	    end;



       if vrb.div2x <> 1 then
                      begin
                       t:= N32xd( 3, i2, u1, u2, u3, uknot ) ;
                      end

                     else
                      begin

       if d1=0 then
                begin
                 case i2 of
                  0 : t:= 1/6;
                  1 : t:= 2/3;
                  2 : t:= 1/6;
                  3 : t:= 0;
                  else t:=555;
                 end;
                end
               else
                begin
                 case i2 of
                  0 : t:= 0;
                  1 : t:= 1/6;
                  2 : t:= 2/3;
                  3 : t:= 1/6;
                  else t:=777;
                 end;
                end;


                      end;

    s2 := s2 + t * s1 ;
    VecAddS( t, q, z, z );
   end;

 VecDiv( z, s2, out2) ;


end;


procedure nurbs_surface( p:p2; weight:p4; uknot:p3x; vknot:p3y;
		     m, n, div_x, div_y : integer; var output:r1 );
var i, j, d1, d2 :integer;
    u, v, du, dv:double;
begin               // j v y - связаны       u i x



    for j:=3 to n-1 do
      for i := 3 to m-1 do
       begin

       if (j=60) AND (i=9)  then
       log('то место!');

	      v := vknot[ j ] ;                    //значение в текущей точке
	      dv := (vknot[j+1] - v ) / div_y ;  //производная в текущей точке
	      for d2 := 0 to div_y do   //перебираем точки v ломаной
	       begin
		      u := uknot[i];                //для каждой точки v ломаной смотрим текущее значение u ломаной
		      du := (uknot[i+1] - u)/div_x ; //и ее производную
		      for d1 := 0 to div_x do //перебираем точки u ломаной
           begin
		        nurbs_3_3( p, weight, uknot, vknot, i, j, n, u, v, d1, d2, output [(i-3)*div_x+d1, (j-3)*div_y+d2] );
		        u := u+du ;
//		        ttt:=ttt+1;
		       end;
		      v :=v+ dv ;
	       end;



	     end;


end;



