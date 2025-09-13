procedure dropkub_init (ty,tx:integer; b1, b2:byte; r1,r2:real);
begin

  if (inivar.sloev < 0)  then
                   begin
                    inivar.sloev := inivar.sloev + 5;
                    setlength (up, inivar.sloev+1, inivar.fild_size_y_d+1, inivar.fild_size_x_d+1);
                   end;

  cup[ty,tx]:=0;
  up[cup[ty,tx],ty,tx].p0 := r1;
  up[cup[ty,tx],ty,tx].s1 := r1;
  up[cup[ty,tx],ty,tx].s2 := r2;
  up[cup[ty,tx],ty,tx].tp := b1;
  up[cup[ty,tx],ty,tx].sloy := b2;
  up[cup[ty,tx],ty,tx].num := 0;

  if r2 > vrb.stat_h then vrb.stat_h:=r2;

end;







procedure dropkub3 (ty,tx:integer; v1:versh; b1, b2:byte; h:real; c:Tcolor; Ki:byte);
var r1,r2:real;
    i:integer;

    tempel:dumppair;
    f:file of dumppair;

begin

 if (Ki <> 3) AND (h > 0) then
 begin

 r1 := v1.z;

 if (r1 < fild[ty,tx].z) OR (Ki = 5) then r1 := fild[ty,tx].z;

 r2 := r1 + h;

 if r1 >= fild[ty,tx].z  then
                             begin
                              fild[ty,tx]:=v1;
                              fild[ty,tx].c:=c;
                              fild[ty,tx].z:=r2;
                              fild[ty,tx].sloy:=b2;
                             end;



// if r1<>r2 then    // если есть что докладывать, то докладываем
 begin
 if ((cup[ty,tx] <= inivar.sloev) AND (cup[ty,tx]>=0))  AND ((up[cup[ty,tx],ty,tx].s2 >= r1) AND (up[cup[ty,tx],ty,tx].tp = b1) AND (up[cup[ty,tx],ty,tx].sloy = b2))
         then
          begin
          //надо склеивать с предидущим
           up[cup[ty,tx],ty,tx].s2 := r2;
          end
         else
          begin //надо делать новый слой

           if not (cup[ty,tx] <= inivar.sloev-1) then //сделать новые слои
                                           begin
                                            inivar.sloev:=cup[ty,tx]+2;
                                            setlength (up, inivar.sloev+1, inivar.fild_size_y_d+1, inivar.fild_size_x_d+1);
                                           end;

           if (cup[ty,tx] <= inivar.sloev-1) then //а можно ли его сделать
                                       begin
                                        if (cup[ty,tx]<0) OR  (up[cup[ty,tx],ty,tx].s1 < up[cup[ty,tx],ty,tx].s2) then
                                                                                                                    cup[ty,tx]:=cup[ty,tx] + 1;

                                        up[cup[ty,tx],ty,tx].s1 := r1;
                                        up[cup[ty,tx],ty,tx].s2 := r2;
                                        up[cup[ty,tx],ty,tx].tp := b1;
                                        up[cup[ty,tx],ty,tx].sloy := b2;

                                        if cup[ty,tx]>=1 then
                                                          begin
                                                            up[cup[ty,tx],ty,tx].num := up[cup[ty,tx]-1,ty,tx].num+1;
                                                            up[cup[ty,tx],ty,tx].p0 := up[cup[ty,tx]-1,ty,tx].s2;
                                                          end
                                                        else
                                                          showmessage('Сильно маленький el_min. Должен быть хотябы 1 :'+inttostr(cup[ty,tx]));


                                       end
                                      else
                                       begin
                                        ShowMessage('Некуда ложить, кончилась память......!');
                                       end;


           //<--- сюда вставлять бадягу с дампами
              if cup[ty,tx] > iniVar.el_max-1 then
                                        begin

                                          AssignFile (f,'cash\unt'+inttostr (ty div inivar.srez_interval)+'.tmp');
                                          if FileExists('cash\unt'+inttostr (ty div inivar.srez_interval)+'.tmp')
                                               then reset (f)
                                               else rewrite (f);

                                          CloseFile (f);
                                          reset (f);

                                          seek(f,FileSize (f));
                                          for i:=0 to cup[ty,tx]-el_min do
                                            begin
                                              tempel.el:=up[i,ty,tx];
                                              tempel.tx:=tx;
                                              tempel.ty:=ty;
                                              tempel.num:=up[i,ty,tx].num;
                                              tempel.num2:='_';
                                              tempel.num2:='N_'+inttostr(up[i,ty,tx].num);

                                              write (f,tempel);


//                                              дамп up[i,ty,tx]

                                            end;
                                          CloseFile (f);


                                          for i:=cup[ty,tx]-el_min+1 to cup[ty,tx] do
                                            begin
                                              up[i-(cup[ty,tx]-el_min+1),ty,tx] := up[i,ty,tx];
                                            end;
                                          cup[ty,tx]:=el_min-1;
                                        end;
           //------------------------------------
          end;

 if fild[ty,tx].z > vrb.stat_h then vrb.stat_h:=fild[ty,tx].z; // проверить строку разве в филде значение уже обновилось
 end;

 end
  else
    begin
      if h<0 then showmessage('Толщина сплэта получилась отрицательной. Так не может быть');
    end;

end;

