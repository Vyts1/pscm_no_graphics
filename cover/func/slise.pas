function zarubki (zr:integer; maxd:integer; maxa:real): integer;
var //mina,maxa:real;
    //mind,maxd:integer;
    r1,i,i2:integer;
    r2,r3:real;
    r4:integer;

begin
// mina:=0;
// maxa:=2800;


// mind := 0;
// maxd := 1028;
 // ƒописать чтоб в обратную сторону работало!!!!!!!

// 50

 r1 := round (maxd / zr);
 if r1=0 then r4:=zr
         else
          begin

 r2 := maxa / r1;


 r3:=r2;
 i:=0;

 while r3>10 do
   begin
    r3:=r3/10;
    i:=i+1;
   end;

 if abs (r3-1) < abs (r3-2) then
                             begin
                              r4:=1;
                             end
                            else
                             begin
                               if  abs (r3-2) < abs (r3-5) then
                                                            begin
                                                             r4:=2;
                                                            end
                                                           else
                                                            begin
                                                             r4:=5;
                                                            end;

                             end;
 for i2:=1 to i do
  r4:=r4*10;
    end;

 zarubki:=r4;
end;


function RazmerPeresecheniy ( a1,a2,b1,b2:real):real;
//var w,q:boolean;
begin
  // a1-a2 базовый интервал, т.е. от 1/4 от максимальной высоты
  // b1-b2 провер€емый интервал up, т.е. то, что считали

  if (a1>a2) or (b1>b2) then
                         showmessage ('ќшибка вызова функции RazmerPeresecheniy. »нтервал отрицательный!'+' a1='+ floattostr(a1)+' a2='+ floattostr(a2)+' b1='+ floattostr(b1)+' b2='+ floattostr(b2) );

  if (b2<a1) or (b1>a2)
     then      // нет пересечений интервалов
       begin
         RazmerPeresecheniy:=0;
       end
     else      // есть пересечени€
       begin

         if  (b2<=a2) then
                        begin
                          if  (b1<=a1) then
                                         begin
                                           RazmerPeresecheniy:=b2-a1;
                                         end
                                       else
                                         begin
                                           RazmerPeresecheniy:=b2-b1;
                                         end;

                        end
                      else // b2 > a2
                        begin
                          if  (b1<=a1) then
                                         begin
                                           RazmerPeresecheniy:=a2-b1;
                                         end
                                       else
                                         begin
                                           RazmerPeresecheniy:=a2-a1;
                                         end;
                        end;
       end;
end;

procedure GetRealValues_2 (y,x:integer; r1,r2:real; var zalito:real; var vsego:real);
var i, g :integer;
    nashli, nedoehali, proehali :boolean;
    tmp, ccup, zalito_vnutri_up, por_vnutri_up:real;

    w1,w2:byte;

begin


 if r2 < r1 then
             begin
              tmp:=r1;
              r1:=r2;
              r2:=tmp;
             end;

 zalito := 0;
 vsego := 0;


 if cup [y,x]>=0 then ccup:=up[cup[y,x],y,x].s2
                 else ccup:=0;

 if r2<=0 then // оба отрицательные      r1|____|r2    .0   => готово
            begin
             r1:=r2;
            end;

 if (r1<0) and (r2>=0) then   // проходит через ноль    r1|_____.0____|r2   =>   r1|.0____|r2
            begin
//              zalito:=zalito+(0-r1);
              r1:=0;
            end;


 if ccup <= r1 then     // .cup   r1|___________|r2  => готово
            begin
//              pora:=pora+(r2-r1);
              r1:=r2;
            end;

 if (r1 <= ccup) and ( ccup < r2) then    //     r1|___.cup________|r2  =>  r1|___|.cup=r2
            begin
//              pora:=pora+(r2-ccup);
              r2:=ccup;
            end;



 if r1<>r2 then //≈сли они равны, значит между ними не может быть ни пор ни пустот.
   begin

                                                                 proehali:=false;
                                                                 zalito_vnutri_up := 0;
                                                                 por_vnutri_up := 0;

                                                                 for i:=0 to cup [y,x] do
                                                                  begin
                                                                   w1:=0;
                                                                   w2:=0;

                                                                   if r1 < up[i,y,x].s1 then w1:=1;
                                                                   if r1 > up[i,y,x].s2 then w1:=2;
                                                                   if (up[i,y,x].s1 <= r1) and (r1 <= up[i,y,x].s2) then w1:=3;

                                                                   if r2 < up[i,y,x].s1 then w2:=1;
                                                                   if r2 > up[i,y,x].s2 then w2:=2;
                                                                   if (up[i,y,x].s1 <= r2) and (r2 <= up[i,y,x].s2) then w2:=3;


                                                                   if (w1=0) or (w2=0) then ShowMessage('Ётого не может быть с точки зрени€ математики, точка неизвестно где');

                                                                   if (w1 = 1) AND (w2 = 1) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+0;
                                                                                              proehali:=true;
                                                                                             end;


                                                                   if (w1 = 1) AND (w2 = 2) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+(up[i,y,x].s2-up[i,y,x].s1);
                                                                                             end;

                                                                   if (w1 = 1) AND (w2 = 3) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+(r2-up[i,y,x].s1);
                                                                                             end;

                                                                   if (w1 = 2) AND (w2 = 1) then
                                                                                             begin
                                                                                              ShowMessage('Ќеверный интервал');
                                                                                             end;

                                                                   if (w1 = 2) AND (w2 = 2) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+0;
                                                                                             end;

                                                                   if (w1 = 2) AND (w2 = 3) then
                                                                                             begin
                                                                                              ShowMessage('Ќеверный интервал');
                                                                                             end;

                                                                   if (w1 = 3) AND (w2 = 1) then
                                                                                             begin
                                                                                              ShowMessage('Ќеверный интервал');
                                                                                             end;

                                                                   if (w1 = 3) AND (w2 = 2) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+(up[i,y,x].s2-r1);
                                                                                             end;

                                                                   if (w1 = 3) AND (w2 = 3) then
                                                                                             begin
                                                                                              zalito_vnutri_up:=zalito_vnutri_up+(r2-r1);
                                                                                             end;



                                                                   if proehali then
                                                                                         break;

                                                                  end;   // конец цикла for

//                                                                 pora:=abs((r2-r1)-zalito_vnutri_up);
                                                                 zalito:=zalito_vnutri_up;
                                                                 vsego:=r2-r1;





   end;


//========================================

end;
