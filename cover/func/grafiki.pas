//Адгезия (срез)
procedure ageziya (z_ageziya:real; imgname:string);
var
    ageziya: array of array of Tageziya;
    i,j,k:integer;
    t:TBitmap;
    S_zalito, S_nezalito:integer;
//    w:boolean;
    smx, smy:integer;

    tmpstr:string;
    tmp:integer;
    zx,zy:real;

    tempel:dumppair;
    f:file of dumppair;

begin

  setlength (ageziya, inivar.fild_size_y_d+1, inivar.fild_size_x_d+1);
//  z_ageziya:=1.5;

  t:=TBitMap.Create;

  smx:=100;
  smy:=100;

//  tochekvdiskrete:=10;


  t.Height:= vrb.fild_y*inivar.tochekvdiskrete2+smy+100;
  t.Width := vrb.fild_x*inivar.tochekvdiskrete2+smx+100;


  write_rectangle(smx-2 , t.Height-(smy-2), smx - 1, t.Height-(smy + (vrb.fild_y+1)*inivar.tochekvdiskrete2), ClBlack, ClBlack, t.Canvas);
  write_rectangle(smx-2 , t.Height-(smy-2), smx + (vrb.fild_x+1)*inivar.tochekvdiskrete2, t.Height-(smy - 1), ClBlack, ClBlack, t.Canvas);


  t.canvas.Brush.color:=ClWhite;

  tmpstr := ' Цвета:            -Соприкасается             -Не Соприкасается';
  t.Canvas.TextOut(smx, t.Height-(smy-20), tmpstr );

  write_rectangle(smx+50, t.Height-(smy-20), smx+70, t.Height-(smy-32), ClBlack, ClBlack, t.Canvas); //
  write_rectangle(smx+170, t.Height-(smy-20), smx+190, t.Height-(smy-32), ClGray, ClGray, t.Canvas); //



  t.canvas.Brush.color:=ClWhite;
  tmpstr := 'Сечение на высоте Z=' + floattostr(z_ageziya) + 'мкм от подложки';
  t.Canvas.TextOut(smx, t.Height-(smy-40), tmpstr );



  t.canvas.pen.color:=clBlack;
  t.canvas.Brush.color:=clBlack;

  // Ищем деление сетки для оси.
  zx:=zarubki (100, vrb.fild_x*inivar.tochekvdiskrete2, vrb.fild_x*inivar.diskret_x);
  zy:=zarubki (100, vrb.fild_y*inivar.tochekvdiskrete2, vrb.fild_y*inivar.diskret_x);




//  tmpstr:='';
//  t.canvas.Brush.color:=ClWhite;
//  t.Canvas.TextOut(smx - round(t.Canvas.TextWidth(tmpstr)*1.7), t.Height-(smy-60), tmpstr );

  for j:=0 to vrb.fild_y do
   begin
    for i:=0 to vrb.fild_x do
     begin
      ageziya[j,i].v:=false;
      ageziya[j,i].w:=false;
      ageziya[j,i].u:=false;
     end;
   end;

 j:=iniVar.obrezka;
 while j <= vrb.fild_y-iniVar.obrezka do
   begin
     // 0 fild_x
     if FileExists('cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp')
       then
         begin
           AssignFile (f,'cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp');
           reset (f);
           for i:=0 to FileSize (f)-1 do
             begin

               read (f,tempel);

               if not ageziya[tempel.ty,tempel.tx].w
                    then // кусок не найден, надо посмотреть, что внутри!
                      begin
                        if (tempel.el.p0 <= z_ageziya) AND (z_ageziya <= tempel.el.s2)
                             then
                               begin  // нужный кусочек найден!
                                ageziya[tempel.ty,tempel.tx].w:=true;
                                
                                if (tempel.el.s1 <= z_ageziya) AND (z_ageziya <=tempel.el.s2) // AND (abs(tempel.el.s2-tempel.el.s1) > 0)
                                    then
                                      ageziya[tempel.ty,tempel.tx].v:=true
                                    else
                                      ageziya[tempel.ty,tempel.tx].v:=false;
                               end;

                      end;

             end;
           CloseFile (f);
         end;
     j:=j + inivar.srez_interval;
   end;//for j=0 to fild_y

  S_zalito:=0;
  S_nezalito:=0;

  for j:=iniVar.obrezka to vrb.fild_y-iniVar.obrezka do
   begin

    for i:=iniVar.obrezka to vrb.fild_x-iniVar.obrezka do
     begin

//      ageziya[j,i].v:=false;


      if NOT ageziya[j,i].w then // для элемента ещё неясности есть ?
           begin // ага есть!

             for k:=0 to cup[j,i] do
               begin
                 if (up[k,j,i].p0 <= z_ageziya) AND (z_ageziya <= up[k,j,i].s2)
                    then
                      begin
                      ageziya[j,i].w:=true; // тебя то нам и надо!

                      if (up[k,j,i].s1 <= z_ageziya) AND (z_ageziya <= up[k,j,i].s2)  //AND (up[k,j,i].s2<>up[k,j,i].s1)
                        then
                          begin
                            ageziya[j,i].v:=true;
                          end
                        else
                          begin
                            ageziya[j,i].v:=false;
                          end;
                      end;


                 if ageziya[j,i].w then break;
               end;
           end;


      if (cup[j,i]>=0) AND (up[cup[j,i],j,i].s2>=z_ageziya) then ageziya[j,i].u:=true else ageziya[j,i].u:=false;
      //--ok
      if ageziya[j,i].u then
      begin
      if ageziya[j,i].v then
                       begin
                        write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), ClBlack, ClBlack, t.Canvas);
                        S_zalito:=S_zalito+1;
                       end
                      else
                       begin
                        write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), ClGray, ClGray, t.Canvas);
                        S_nezalito:=S_nezalito+1;
                       end;

      end else
      begin
                        write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), $EFEFEF, $EFEFEF, t.Canvas);
      end;

     end;// i = 0 fild_x
   end;// j =0 fild_y



  if (S_nezalito+S_zalito)>0
                             then
  tmpstr := ' Площадь контакта составляет  ' + floattostr(  round(S_zalito/(S_nezalito+S_zalito)*100*10000 ) / 10000  ) +'% '
                             else
  tmpstr := ' Немогу расчитать площадь контакта ';

  t.canvas.Brush.color:=ClWhite;
  t.Canvas.TextOut(smx, t.Height-(smy-60), tmpstr );



     // OX
     i:=0;
     while zx*i<=vrb.fild_x*inivar.diskret_x  do
       begin
        tmp:=round( (zx*i/inivar.diskret_x)*inivar.tochekvdiskrete2 );
//        write_rectangle(smx+tmp   , t.Height-(smy-1), smx+tmp, t.Height-(smy-5), ClBlue, ClBlue, t.Canvas);//короткие засечки

        write_rectangle(smx+tmp   , t.Height-(smy-5), smx+tmp, t.Height-(smy+vrb.fild_y*inivar.tochekvdiskrete2), ClBlue, ClBlue, t.Canvas); //длинные отметки

        tmpstr:=floattostr(zx*i);

        t.canvas.pen.color:=ClYellow;
        t.canvas.Brush.color:=ClWhite;

        t.Canvas.TextOut(smx+tmp-round(t.Canvas.TextWidth(tmpstr) / 2), t.Height-(smy - 8), tmpstr );

        i:=i+1;
       end;

     // OY
     i:=0;
     while zy*i<=vrb.fild_y*inivar.diskret_x   do
       begin
        tmp:=round((zy*i/inivar.diskret_x)*inivar.tochekvdiskrete2);
        write_rectangle(smx-7   , t.Height-(smy+tmp), smx+vrb.fild_x*inivar.tochekvdiskrete2, t.Height-(smy+tmp), ClBlue, ClBlue, t.Canvas); //длинная метка

        tmpstr:=floattostr(zy*i);
        t.canvas.Brush.color:=ClWhite;

        t.Canvas.TextOut(smx-round(t.Canvas.TextWidth(tmpstr)*1.7), t.Height-(smy+tmp + round(t.Canvas.TextHeight(tmpstr)/2) ), tmpstr );

        i:=i+1;
       end;




  t.SaveToFile('rez\'+imgname);
  t.Destroy;
  ageziya:=nil;

end;


//Глобальная пористость. Строит срезы, вызывая атгезию(z).
procedure AnalizPokritiya ();
type TOneLayerPor = record
        vsego, zalito, por, proc, proc2 : double;
        error : boolean;
     end;
var i,j,k:integer;
    zapolneno, vsego, globalnaya_poristost:real;

    poriotzerolevel, poriotzerolevel2, l:real;

    globalnaya_poristost_error, w:boolean;
    rezx, rezy, curx, cury:integer;
{    sherohovatost_avg, sherohovatost_min, sherohovatost_max, sherohovatost_sum:real;
    sherohovatost_ot,    sherohovatost_do :integer;}

    tempel:dumppair;
    f : file of dumppair;

    a: array of array of real;

    t:TBitmap;
    smx, smy:integer;

    min_th, max_th, min_th2, max_th2,sum_sh, min_seroh, max_seroh:real;
    th_k2:integer;

    hsrezka:real;
    otsechka_on:boolean;

    P : array[0..MAX_CHISLO_SLOEV_V_POKRITII] of TOneLayerPor;


begin

 if ReadIniDataInt('slise','on_otsechka', 0) = 1 then otsechka_on:=true
                                                 else otsechka_on:=false;

 if ReadIniDataInt('slise','otsechka_h', 0) = 0 then
      hsrezka := vrb.last_crkl_height+zerolevel
 else
      hsrezka := ReadIniDataInt('slise','otsechka_h', 0)/inivar.diskret_x+zerolevel;

 log ('Уровень нуля: '+floattostr(zerolevel) +' дск  ' + floattostr(zerolevel*inivar.diskret_x) +' мкм');
 log ('Высота отсечки: '+floattostr(hsrezka) +' дск');
 log ('Высота отсечки: '+floattostr(hsrezka*inivar.diskret_x) +' мкм');


 if otsechka_on then log ('Отсечка включена!: '+ '')
                else log ('Отсечка выключена: '+ '');


 if ReadIniDataInt('slise','on_glob_por', 1) = 1 then
 begin

    for i := 0 to MAX_CHISLO_SLOEV_V_POKRITII do
      begin
        p[i].vsego := 0;
        p[i].zalito := 0;
        p[i].por := 0;
        p[i].proc := 0;
        p[i].proc2 := 0;
        p[i].error := false;
      end;

  //1. Глобальная пористость по всему покрытию.
 zapolneno:=0;
 vsego:=0;
 min_seroh:=0;
 max_seroh:=0;

 poriotzerolevel:=0;
 poriotzerolevel2:=0;


 if iniVar.stoh=7 then
   begin
     setlength (a, iniVar.fild_size_y_d+1, iniVar.fild_size_x_d+1);
     t:=TBitMap.Create;

     smx:=100;
     smy:=100;

     t.Height:= vrb.fild_y*inivar.tochekvdiskrete2+smy+100;
     t.Width := vrb.fild_x*inivar.tochekvdiskrete2+smx+100;

     for I := 0 to iniVar.fild_size_y_d do
       for J := 0 to iniVar.fild_size_x_d do
          a[i,j] := -1;
   end;

 j:=iniVar.obrezka;
 while j <= vrb.fild_y-iniVar.obrezka do
   begin
     // 0 fild_x
     if FileExists('cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp')
       then
         begin
           AssignFile (f,'cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp');
           reset (f);


           for i:=0 to FileSize (f)-1 do
             begin
               read (f, tempel);

               if (iniVar.obrezka<=tempel.tx) AND (tempel.tx<=vrb.fild_x-iniVar.obrezka) AND
                  (iniVar.obrezka<=tempel.ty) AND (tempel.ty<=vrb.fild_y-iniVar.obrezka) AND (tempel.el.p0<>0) AND (tempel.el.s1<>0)
               then
                begin
                  //===================================================================================================
                  if iniVar.stoh=7 then
                    begin
                      if tempel.el.p0 = zerolevel then
                         begin
                           poriotzerolevel:= poriotzerolevel + abs(tempel.el.s1-tempel.el.p0);

                           if a[tempel.ty, tempel.tx] = -1 then
                             begin
                               if abs(tempel.el.s1-tempel.el.p0) > 0 then
                                 begin
                                   a[tempel.ty, tempel.tx] := abs(tempel.el.s1-tempel.el.p0);
                                 end                                 else
                                 begin
                                   a[tempel.ty, tempel.tx] := 0;
                                 end;
                             end  else
                             begin
                               log ('Жопа' + inttostr(tempel.ty) + inttostr(tempel.tx));
                             end;


                         end;
                    end;
                  //===================================================================================================

                  if otsechka_on then
                                  begin
                                    if hsrezka < tempel.el.p0 then
                                      begin
                                        //нифига
                                      end;
                                    if (hsrezka > tempel.el.p0) AND (hsrezka < tempel.el.s1) then
                                      begin
                                         zapolneno:=zapolneno + 0;
                                         vsego:=vsego+ abs(hsrezka - tempel.el.p0);


                                         if (tempel.el.sloy >= 0) AND (tempel.el.sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[tempel.el.sloy].vsego := p[tempel.el.sloy].vsego + abs(hsrezka-tempel.el.p0);
                                             p[tempel.el.sloy].zalito := p[tempel.el.sloy].zalito + 0;
                                             p[tempel.el.sloy].por := p[tempel.el.sloy].por + abs(hsrezka-tempel.el.p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;


                                      end;

                                    if (hsrezka > tempel.el.s1) AND (hsrezka < tempel.el.s2) then
                                      begin
                                         zapolneno:=zapolneno + abs(hsrezka - tempel.el.s1);
                                         vsego:=vsego+ abs(hsrezka - tempel.el.p0);


                                         if (tempel.el.sloy >= 0) AND (tempel.el.sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[tempel.el.sloy].vsego := p[tempel.el.sloy].vsego + abs(hsrezka -tempel.el.p0);
                                             p[tempel.el.sloy].zalito := p[tempel.el.sloy].zalito + abs(hsrezka -tempel.el.s1);
                                             p[tempel.el.sloy].por := p[tempel.el.sloy].por + abs(tempel.el.s1-tempel.el.p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;

                                      end;

                                    if (hsrezka > tempel.el.s2) then
                                      begin
                                         zapolneno:=zapolneno + abs(tempel.el.s2-tempel.el.s1);
                                         vsego:=vsego+ abs(tempel.el.s2-tempel.el.p0);

                                         if (tempel.el.sloy >= 0) AND (tempel.el.sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[tempel.el.sloy].vsego := p[tempel.el.sloy].vsego + abs(tempel.el.s2-tempel.el.p0);
                                             p[tempel.el.sloy].zalito := p[tempel.el.sloy].zalito + abs(tempel.el.s2-tempel.el.s1);
                                             p[tempel.el.sloy].por := p[tempel.el.sloy].por + abs(tempel.el.s1-tempel.el.p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;

                                      end;


                                  end
                                 else
                                  begin
                                     zapolneno:=zapolneno + abs(tempel.el.s2-tempel.el.s1);
                                     vsego:=vsego+ abs(tempel.el.s2-tempel.el.p0);

                                     if (tempel.el.sloy >= 0) AND (tempel.el.sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                        begin
                                          p[tempel.el.sloy].vsego := p[tempel.el.sloy].vsego + abs(tempel.el.s2-tempel.el.p0);
                                          p[tempel.el.sloy].zalito := p[tempel.el.sloy].zalito + abs(tempel.el.s2-tempel.el.s1);
                                          p[tempel.el.sloy].por := p[tempel.el.sloy].por + abs(tempel.el.s1-tempel.el.p0);
                                        end   else
                                        begin
                                          //Это если есть слои с неизвестными номерами
                                          log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                        end;


                                  end;


                end;
             end;
           CloseFile (f);
         end;
     j:=j + inivar.srez_interval;
   end;//for j=0 to fild_y

  sum_sh:=0;
  th_k2:=0;

  for j:=iniVar.obrezka to vrb.fild_y-iniVar.obrezka do
   begin
     for i:=iniVar.obrezka to vrb.fild_x-iniVar.obrezka do
       begin
//         vsego:=vsego+up[cup[j,i],j,i].s2;
         for k:=0 to cup[j,i] do
           begin
            if  (up[k,j,i].p0<>0) AND (up[k,j,i].s1<>0) then
              begin

                  if iniVar.stoh=7 then
                    begin
                      if up[k,j,i].p0 = zerolevel then
                         begin
                           poriotzerolevel:= poriotzerolevel + abs(up[k,j,i].s1-up[k,j,i].p0);

                           if a[j, i] = -1 then
                             begin
                               if abs(up[k,j,i].s1-up[k,j,i].p0) > 0 then
                                 begin
                                   a[j, i] := abs(up[k,j,i].s1-up[k,j,i].p0);
                                 end                                 else
                                 begin
                                   a[j, i] := 0;
                                 end;
                             end  else
                             begin
                               log ('Жопа' + inttostr(j) +'  '+ inttostr(i));
                             end;

                         end;
                    end;


                  if otsechka_on then
                                  begin
                                    if hsrezka < up[k,j,i].p0 then
                                      begin
                                        //нифига
                                      end;
                                    if (hsrezka > up[k,j,i].p0) AND (hsrezka < up[k,j,i].s1) then
                                      begin
                                         // Тут есть потенциальная проблема т.к. объем в точках среза приплюсоывается только к одному слою
                                         // а остаток откидывается и вроде как его нет
                                         zapolneno:=zapolneno + 0;
                                         vsego:=vsego+ abs(hsrezka - up[k,j,i].p0);

                                         if (up[k,j,i].sloy >= 0) AND (up[k,j,i].sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[up[k,j,i].sloy].vsego := p[up[k,j,i].sloy].vsego + abs(hsrezka-up[k,j,i].p0);
                                             p[up[k,j,i].sloy].zalito := p[up[k,j,i].sloy].zalito + 0;
                                             p[up[k,j,i].sloy].por := p[up[k,j,i].sloy].por + abs(hsrezka-up[k,j,i].p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;

                                      end;

                                    if (hsrezka > up[k,j,i].s1) AND (hsrezka < up[k,j,i].s2) then
                                      begin
                                         zapolneno:=zapolneno + abs(hsrezka - up[k,j,i].s1);
                                         vsego:=vsego+ abs(hsrezka - up[k,j,i].p0);


                                         if (up[k,j,i].sloy >= 0) AND (up[k,j,i].sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[up[k,j,i].sloy].vsego := p[up[k,j,i].sloy].vsego + abs(hsrezka-up[k,j,i].p0);
                                             p[up[k,j,i].sloy].zalito := p[up[k,j,i].sloy].zalito + abs(hsrezka-up[k,j,i].s1);
                                             p[up[k,j,i].sloy].por := p[up[k,j,i].sloy].por + abs(up[k,j,i].s1-up[k,j,i].p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;


                                      end;

                                    if (hsrezka > up[k,j,i].s2) then
                                      begin
                                         zapolneno := zapolneno + abs(up[k,j,i].s2-up[k,j,i].s1);
                                         vsego := vsego + abs(up[k,j,i].s2-up[k,j,i].p0);

                                         if (up[k,j,i].sloy >= 0) AND (up[k,j,i].sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                           begin
                                             p[up[k,j,i].sloy].vsego := p[up[k,j,i].sloy].vsego + abs(up[k,j,i].s2-up[k,j,i].p0);
                                             p[up[k,j,i].sloy].zalito := p[up[k,j,i].sloy].zalito + abs(up[k,j,i].s2-up[k,j,i].s1);
                                             p[up[k,j,i].sloy].por := p[up[k,j,i].sloy].por + abs(up[k,j,i].s1-up[k,j,i].p0);
                                           end   else
                                           begin
                                             //Это если есть слои с неизвестными номерами
                                             log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                           end;

                                      end;
                                  end
                                 else
                                  begin
                                     zapolneno := zapolneno + abs(up[k,j,i].s2-up[k,j,i].s1);
                                     vsego := vsego + abs(up[k,j,i].s2-up[k,j,i].p0);

                                     if (up[k,j,i].sloy >= 0) AND (up[k,j,i].sloy <= MAX_CHISLO_SLOEV_V_POKRITII) then
                                        begin
                                          p[up[k,j,i].sloy].vsego := p[up[k,j,i].sloy].vsego + abs(up[k,j,i].s2-up[k,j,i].p0);
                                          p[up[k,j,i].sloy].zalito := p[up[k,j,i].sloy].zalito + abs(up[k,j,i].s2-up[k,j,i].s1);
                                          p[up[k,j,i].sloy].por := p[up[k,j,i].sloy].por + abs(up[k,j,i].s1-up[k,j,i].p0);
                                        end   else
                                        begin
                                          //Это если есть слои с неизвестными номерами
                                          log('!!!!!!!!!Слой с неизвестным номером' + inttostr(tempel.el.sloy));
                                        end;

                                  end;

//                zapolneno := zapolneno + abs(up[k,j,i].s2-up[k,j,i].s1);
//                vsego := vsego + abs(up[k,j,i].s2-up[k,j,i].p0);
              end;
           end;

         k:=cup[j,i];

         if (i=iniVar.obrezka) AND (j=iniVar.obrezka) then
                                                       begin
                                                         min_th:=up[k,j,i].s2;
                                                         max_th:=up[k,j,i].s2;

                                                       end
                                                      else
                                                       begin
                                                         if up[k,j,i].s2<min_th then min_th:=up[k,j,i].s2;
                                                         if up[k,j,i].s2>max_th then max_th:=up[k,j,i].s2;
                                                       end;


         if (i=iniVar.obrezka) then    //это первая точка шлифа
                                                       begin
                                                         min_th2:=up[k,j,i].s2;
                                                         max_th2:=up[k,j,i].s2;

                                                       end
                                                      else
                                                       begin
                                                         if up[k,j,i].s2<min_th2 then min_th2:=up[k,j,i].s2;
                                                         if up[k,j,i].s2>max_th2 then max_th2:=up[k,j,i].s2;
                                                       end;

         if (i=vrb.fild_x-iniVar.obrezka) then  //последняя точка шлифа
                                            begin
                                              sum_sh:=sum_sh+(max_th2-min_th2);
                                              th_k2:=th_k2+1;

                                              if j=iniVar.obrezka then
                                                      begin
                                                        min_seroh:=max_th2-min_th2;
                                                        max_seroh:=max_th2-min_th2;
                                                      end
                                                    else
                                                      begin
                                                        if min_seroh>max_th2-min_th2 then  min_seroh:=max_th2-min_th2;
                                                        if max_seroh<max_th2-min_th2 then  max_seroh:=max_th2-min_th2;
                                                      end;
                                            end;

       end;
   end;

  if vsego > 0 then
                begin
//                 globalnaya_poristost:=round((1-zapolneno/vsego)*100*1000) / 1000;
                 globalnaya_poristost:=(1-zapolneno/vsego)*100;
                 globalnaya_poristost_error:=false;
                end
               else
                begin
                 globalnaya_poristost:=0;
                 globalnaya_poristost_error:=true;
                end;

  for i := 0 to MAX_CHISLO_SLOEV_V_POKRITII do
    begin
      if p[i].vsego > 0 then p[i].proc := (1 - p[i].zalito / p[i].vsego) * 100
                        else begin p[i].proc :=0; p[i].error := true; end;

      if p[i].vsego > 0 then p[i].proc2 := (p[i].por / p[i].vsego) * 100
                        else begin p[i].proc2 :=0; p[i].error := true; end;
    end;



  if iniVar.stoh=7 then
  begin

  for j:=iniVar.obrezka to vrb.fild_y-iniVar.obrezka do
   begin
     for i:=iniVar.obrezka to vrb.fild_x-iniVar.obrezka do
       begin

        if a[j, i] > 0 then
        begin



        //log ( 'Y=' + inttostr (j) +'  X='+ inttostr (i));
        // poriotzerolevel2:=0;
//                         GetPredok (izvx, izvy:integer; xc, yc:integer; R:integer; var rezX:integer; var rezY:integer );
//         vrb.first_x  := vrb.crkl_center_x;
//         vrb.first_y  := vrb.crkl_center_y;
//         vrb.first_Rs := vrb.crkl_Rs;
//         vrb.first_Rp := vrb.crkl_Rp;


        if UpRound( sqrt(sqr(i-vrb.first_x) + sqr(j-vrb.first_y)) ) > vrb.first_Rs then
          begin
//            poriotzerolevel2 := poriotzerolevel2 + 0;
            w:=true;

            curx := i;
            cury := j;
            repeat

               GetPredok2 (curx, cury,  vrb.first_x, vrb.first_y, vrb.first_Rs, rezX, rezY);

               curx := rezX;
               cury := rezY;

               if a[cury, curx] <= 0 then w := false;



               l := UpRound(sqrt ( sqr(vrb.first_x-curx) + sqr(vrb.first_y-cury) ));

              // log ( '' + floattostr (l) );

            until (NOT w) OR ( l <= vrb.first_Rs );

            if ( l <= vrb.first_Rs ) then w:=true;

            if w then
              begin
               poriotzerolevel2 := poriotzerolevel2 + a[j,i];
               write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), ClBlack, ClBlack, t.Canvas);
              end else
               write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), ClGray, ClGray, t.Canvas);



          end else
          begin
               write_rectangle(smx + i*inivar.tochekvdiskrete2, t.Height-(smy + j*inivar.tochekvdiskrete2), smx + (i+1)*inivar.tochekvdiskrete2-1, t.Height-(smy + (j+1)*inivar.tochekvdiskrete2-1), ClWhite, ClWhite, t.Canvas);
          end;

        end;
       end;
   end;


//=


  t.SaveToFile('rez\stoh7_srez.bmp');
  t.Destroy;
  a:=nil;

  end;

  if globalnaya_poristost_error then log ('1.ОШИБКА расчета Глобальной пористости: '+floattostr(globalnaya_poristost) +'%')
                                else log ('1.Глобальная пористость: '+floattostr(globalnaya_poristost) +'%');




  LogRec.PorAdd_Head := '';
  LogRec.PorAdd_Content := '';

  for i := 0 to MAX_CHISLO_SLOEV_V_POKRITII do
    begin
      if p[i].error then log ('Слой '+inttostr(i)+' ОШИБКА расчета Глобальной пористости ' + floattostr(p[i].proc) + '%')
                    else log ('Слой '+inttostr(i)+' Глобальная пористость ' + floattostr(p[i].proc) + '% или ' + floattostr(p[i].proc2) + '%');

      log ('Слой '+inttostr(i)+' Залитая часть: '+floattostr(p[i].zalito) +' дск^3');
      log ('Слой '+inttostr(i)+' Всего: '+floattostr(p[i].vsego) +' дск^3');
      //-----------------------------------------------------
      if p[i].error then logReport ('Слой '+inttostr(i)+' ОШИБКА расчета Глобальной пористости ' + floattostr(p[i].proc) + '%')
                    else logReport ('Слой '+inttostr(i)+' Глобальная пористость ' + floattostr(p[i].proc) + '% или ' + floattostr(p[i].proc2) + '%');

      logReport ('Слой '+inttostr(i)+' Залитая часть: '+floattostr(p[i].zalito) +' дск^3');
      logReport ('Слой '+inttostr(i)+' Всего: '+floattostr(p[i].vsego) +' дск^3');
      //-----------------------------------------------------

      if NOT p[i].error then
        begin
          LogRec.PorAdd_Head := LogRec.PorAdd_Head + 'P' + inttostr(i)+',%;';
          LogRec.PorAdd_Content := LogRec.PorAdd_Content + FloatToStrF(p[i].proc, ffGeneral, 14, 10)+';';
        end;

    end;


  //  log ('1.Глобальная пористость: '+floattostr(globalnaya_poristost) +'%');

  log ('Залитая часть: '+floattostr(zapolneno) +' дск^3');
  log ('Всего: '+floattostr(vsego) +' дск^3');

  log ('Мин/макс точка по всему покрытию и их разница');
  log ('Мин. точка ' + floattostr(min_th)+ ' дск. Макс. точка ' +floattostr(max_th)+ ' дск. Шероховатость '+floattostr(max_th-min_th)+' дск.');
  log ('Мин. точка ' + floattostr(min_th*inivar.diskret_x)+ ' мкм. Макс. точка ' +floattostr(max_th*inivar.diskret_x)+ ' мкм. Шероховатость '+floattostr((max_th-min_th)*inivar.diskret_x)+' мкм.');

  log ('Считаем шероховатость по каждому срезу (т.е. 1 дискрет) и смотрим в нем шероховатость, потом из всех таких срезов находим мин и максимальное занчение');
  log ('Мин. значение шероховатости из всех шлифов '+ floattostr(min_seroh*inivar.diskret_x)+' мкм.');
  log ('Макс. значение шероховатости из всех шлифов '+ floattostr(max_seroh*inivar.diskret_x)+' мкм.');


  log ('Считаем шероховатость по каждому срезу (т.е. 1 дискрет), суммируем и делим на колчество таких срезов т.е. усредняем по всем срезам');


  log ('Средняя шероховатость '+ floattostr((sum_sh / th_k2)*inivar.diskret_x) +' мкм.');


  if globalnaya_poristost_error then logReport ('1.ОШИБКА расчета Глобальной пористости: '+floattostr(globalnaya_poristost) +'%')
                                else logReport ('1.Глобальная пористость: '+floattostr(globalnaya_poristost) +'%');

//  logReport ('1.Глобальная пористость: '+floattostr(globalnaya_poristost) +'%');
  logReport ('Залитая часть: '+floattostr(zapolneno) +' дск^3');
  logReport ('Всего: '+floattostr(vsego) +' дск^3');

  logReport ('Мин. точка ' + floattostr(min_th)+ ' дск. Макс. точка ' +floattostr(max_th)+ ' дск. Шероховатость '+floattostr(max_th-min_th)+' дск.');
  logReport ('Мин. точка ' + floattostr(min_th*inivar.diskret_x)+ ' мкм. Макс. точка ' +floattostr(max_th*inivar.diskret_x)+ ' мкм. Шероховатость '+floattostr((max_th-min_th)*inivar.diskret_x)+' мкм.');

  logReport ('Мин. шероховатость '+ floattostr(min_seroh*inivar.diskret_x)+' мкм.');
  logReport ('Макс. шероховатость '+ floattostr(max_seroh*inivar.diskret_x)+' мкм.');

  logReport ('Средняя шероховатость '+ floattostr(round((sum_sh / th_k2)*inivar.diskret_x)) +' мкм.');
  logReport ('Средняя шероховатость '+ floattostr((sum_sh / th_k2)*inivar.diskret_x) +' мкм.');

//  LogRec.P := globalnaya_poristost;
  if globalnaya_poristost_error then LogRec.P := -1
                                else LogRec.P := globalnaya_poristost;


//  LogRec.R := round((sum_sh / th_k2)*inivar.diskret_x);
  LogRec.R := (sum_sh / th_k2)*inivar.diskret_x;




  if iniVar.stoh=7 then
  begin
  log ('Пустая часть, которая лежит на подложке: '+floattostr(poriotzerolevel) +' дск^3');
  log ('Пустая часть, которая лежит на подложке (новый метод): '+floattostr(poriotzerolevel2) +' дск^3');
  end;

 end;




 if ReadIniDataInt('slise','on_srez', 1) = 1 then
 begin
//  ageziya (0, 'ageziya0.bmp');
//  ageziya (0+1E-6, 'ageziya01.bmp');
  ageziya (zerolevel+1E-6, 'ageziya000.bmp');
  ageziya (zerolevel+1, 'ageziya001.bmp');
{  ageziya (inivar.diskret_x+0.04*inivar.diskret_x, 'ageziya004.bmp');
  ageziya (inivar.diskret_x+0.06*inivar.diskret_x, 'ageziya006.bmp');
  ageziya (inivar.diskret_x+0.08*inivar.diskret_x, 'ageziya008.bmp');
  ageziya (inivar.diskret_x+0.10*inivar.diskret_x, 'ageziya010.bmp');
  ageziya (inivar.diskret_x+0.12*inivar.diskret_x, 'ageziya012.bmp');
  ageziya (inivar.diskret_x+0.14*inivar.diskret_x, 'ageziya014.bmp');}
 { ageziya (inivar.diskret_x+0.16*inivar.diskret_x, 'ageziya016.bmp');
  ageziya (inivar.diskret_x+0.18*inivar.diskret_x, 'ageziya018.bmp');
  ageziya (inivar.diskret_x+0.20*inivar.diskret_x, 'ageziya020.bmp');
  ageziya (inivar.diskret_x+0.22*inivar.diskret_x, 'ageziya022.bmp');
  ageziya (inivar.diskret_x+0.24*inivar.diskret_x, 'ageziya024.bmp');
  ageziya (inivar.diskret_x+0.26*inivar.diskret_x, 'ageziya026.bmp');
  ageziya (inivar.diskret_x+0.28*inivar.diskret_x, 'ageziya028.bmp');
  ageziya (inivar.diskret_x+0.30*inivar.diskret_x, 'ageziya030.bmp');
  ageziya (inivar.diskret_x+0.32*inivar.diskret_x, 'ageziya032.bmp');
  ageziya (inivar.diskret_x+0.34*inivar.diskret_x, 'ageziya034.bmp');
  ageziya (inivar.diskret_x+0.36*inivar.diskret_x, 'ageziya036.bmp');
  ageziya (inivar.diskret_x+0.38*inivar.diskret_x, 'ageziya038.bmp');
  ageziya (inivar.diskret_x+0.40*inivar.diskret_x, 'ageziya040.bmp');
  ageziya (inivar.diskret_x+0.42*inivar.diskret_x, 'ageziya042.bmp');
  ageziya (inivar.diskret_x+0.44*inivar.diskret_x, 'ageziya044.bmp');
  ageziya (inivar.diskret_x+0.46*inivar.diskret_x, 'ageziya046.bmp');
  ageziya (inivar.diskret_x+0.48*inivar.diskret_x, 'ageziya048.bmp');
  ageziya (inivar.diskret_x+0.50*inivar.diskret_x, 'ageziya050.bmp');
  ageziya (inivar.diskret_x+0.52*inivar.diskret_x, 'ageziya052.bmp');
  ageziya (inivar.diskret_x+0.54*inivar.diskret_x, 'ageziya054.bmp');
  ageziya (inivar.diskret_x+0.56*inivar.diskret_x, 'ageziya056.bmp');
  ageziya (inivar.diskret_x+0.58*inivar.diskret_x, 'ageziya058.bmp');
  ageziya (inivar.diskret_x+0.60*inivar.diskret_x, 'ageziya060.bmp');
  ageziya (inivar.diskret_x+0.62*inivar.diskret_x, 'ageziya062.bmp');
  ageziya (inivar.diskret_x+0.64*inivar.diskret_x, 'ageziya064.bmp');
  ageziya (inivar.diskret_x+0.66*inivar.diskret_x, 'ageziya066.bmp');
  ageziya (inivar.diskret_x+0.68*inivar.diskret_x, 'ageziya068.bmp');
  ageziya (inivar.diskret_x+0.70*inivar.diskret_x, 'ageziya070.bmp');

{
  ageziya (inivar.diskret_x+3.00*inivar.diskret_x, 'ageziya300.bmp');
  ageziya (inivar.diskret_x+5.00*inivar.diskret_x, 'ageziya500.bmp');
  ageziya (inivar.diskret_x+4.00*inivar.diskret_x, 'ageziya400.bmp');
 }
//  ageziya (inivar.diskret_x*2+1E-6, 'ageziya2.bmp');
//  ageziya (inivar.diskret_x*3+1E-6, 'ageziya3.bmp');
//  ageziya (inivar.diskret_x*4+1E-6, 'ageziya4.bmp');
//  ageziya (inivar.diskret_x*5+1E-6, 'ageziya5.bmp');
 end;

end;



//Строит шлифы!
procedure droptoslise2 ();
var
    poristost_v_sloe: array of real;
    i,j,k,k2:integer;
    t:TImage;
    imgname:string;

    wimage, himage, wchart, hchart, wchart2, hchart2:integer;

    smxchart, smychart:integer;
    x1,x2,y1,y2:integer;
    col:TColor;

    smx,smy:integer;
    smx2,smy2:integer;
    ox_w, oy_w:integer;

    ToJpeg: TJPEGImage;
    zx,zy:real;
    tmp:integer;
    tmpstr:string;


    dz_in_layer:real;
    zalito_v_sloe, vsego_v_sloe, zalito_v_sloe_i, vsego_v_sloe_i, max_v_shlife:real;

    sherohovatost_avg, sherohovatost_min, sherohovatost_max, sherohovatost_sum:real;
    sherohovatost_ot,    sherohovatost_do :integer;

    poristost_shlif_fill, poristost_shlif_vsego, poristost_shlif_value:real;

    tempel:dumppair;
    f:file of dumppair;

    f2:textfile;

    sloiarr : array of Tfilllayer;

    hsvg, smxsvg:real;

begin


   {$REGION 'Подготовка'}
  ox_w:=3; oy_w:=2;


  // Размеры графика 1 (пористость)
  smx:=50; smy:=50;
  wchart:= round( vrb.fild_x  * inivar.tochekvdiskrete);
  hchart:= (upround2(vrb.stat_h) * inivar.tochekvdiskrete);

  // Размеры графика 2 (гистограммы)
  smx2:=smx;
  smy2:=50+hchart+smy;
  wchart2:=inivar.sloev_v_shlife*(50+10)+400;
  hchart2:=300;

  // размеры картинки
  wimage:=smx+round (max(wchart, wchart2)*1.1);
  himage:=smy+round ((hchart+hchart2)*1.1)+20;


  // Для анализа послойной пористости------------------------------
  dz_in_layer:=vrb.stat_h/inivar.sloev_v_shlife;  // толщина делится на кол-во слоев в шлифе.

  zalito_v_sloe:=0;
  vsego_v_sloe:=0;

  setlength (poristost_v_sloe, inivar.sloev_v_shlife);
  //===============================================================

  //  Для анализа шероховатости--------------------------------------
  sherohovatost_ot:=iniVar.obrezka;
  sherohovatost_do:= vrb.fild_x-iniVar.obrezka;
  //  ===============================================================

  setlength (sloiarr, inivar.sloev_v_shlife);

   {$ENDREGION}



  j:=iniVar.obrezka;

 while j <= vrb.fild_y-iniVar.obrezka do
   begin
     // 0 fild_x

//     if j>200 then
//        log ('j>200');



     {$REGION 'Чистим массив, для послойной пористости'}
     for k2:=0 to inivar.sloev_v_shlife-1 do
       begin
        sloiarr[k2].zalito:=0;
        sloiarr[k2].nezalito:=0;
       end;
     // ----------------------------------------------------------------------------
     {$ENDREGION}

     {$REGION 'Инициализация JPEG'}
     t:=TImage.Create(Form1);

     t.Height:= himage;
     t.Width := wimage;

     t.canvas.pen.color:=clRed;
     t.canvas.Brush.color:=clRed;
   {$ENDREGION}

     {$REGION 'Инициализация SVG'}

     if fileexists(format ('rez\'+vrb.start_timestamp+'_%5d_'+'.svg', [j])) then
       DeleteFile(format ('rez\'+vrb.start_timestamp+'_%5d_'+'.svg', [j]));

     AssignFile (f2, format ('rez\'+vrb.start_timestamp+'_%5d_'+'.svg', [j]));
     Rewrite(F2);
     writeln (F2,'<?xml version="1.0" standalone="no"?>');

     hsvg:=upround2(vrb.stat_h)*iniVar.tochekvdiskretesvg*1.5;
     smxsvg:=200;

     writeln (F2,'<svg xmlns="http://www.w3.org/2000/svg" width="'+floattostr((vrb.fild_x-2*iniVar.obrezka)*iniVar.tochekvdiskretesvg+smxsvg+100)  +'" height="'+floattostr(hsvg+100)+'">');
     writeln (F2,'  <title>Shlif #'+inttostr(j)+'</title>');
//     writeln (F2,'  <rect x="10" y="10"  width="10050" height="10"/>');
//     writeln (F2,'');
   {$ENDREGION}

     {$REGION 'Рисование осей координат (основа)'}
     // Рисуем оси, толщиной oy_w и ox_w:
     write_rectangle(smx-oy_w, t.Height-(smy-ox_w), smx+wchart, t.Height-(smy-1), ClRed, ClRed, t.Canvas); // горизонтальная ось
     write_rectangle(smx-oy_w, t.Height-(smy-ox_w), smx-1, t.Height-(smy+hchart), ClRed, ClRed, t.Canvas); // вертикальная ось

//     writeln (F2,'  <rect x="'+floattostr(smxsvg)+'" y="'+floattostr()+'"  width="'+floattostr()+'" height="'+floattostr()+'"/>');
     writeln (F2,'  <line x1="'+floattostr(smxsvg-5)+'" y1="'+floattostr(hsvg)+'" x2="'+floattostr(smxsvg-5)+'" y2="'+floattostr(hsvg-upround2(vrb.stat_h)*iniVar.tochekvdiskretesvg)+'" stroke="#000000" stroke-width="2"  />');
     writeln (F2,'  <line x1="'+floattostr(smxsvg)+'" y1="'+floattostr(hsvg+5)+'" x2="'+floattostr(smxsvg+iniVar.tochekvdiskretesvg*vrb.fild_x)+'" y2="'+floattostr(hsvg+5)+'" stroke="#000000" stroke-width="2"  />');
     {$ENDREGION}

     {$REGION 'Ищем деление сетки для оси.'}
     zx:=zarubki (50, wchart, vrb.fild_x*inivar.diskret_x);
//     zy:=zarubki (50, hchart, vrb.stat_h*inivar.diskret_x);
     zy:=zarubki (5, hchart, vrb.stat_h*inivar.diskret_x);
     {$ENDREGION}

     //====================================================================================================================================
     {$REGION 'Рисование шлифа  (ЧАСТЬ из UP)'}
     // ------------------- Рисуем из массива UP -----------------------------------
     // ----------------------------------------------------------------------------
     for i:=iniVar.obrezka to vrb.fild_x-iniVar.obrezka do
       begin
         for k:=0 to cup[j,i] do
           begin

            x1:=smx+i*inivar.tochekvdiskrete;
            x2:=x1+inivar.tochekvdiskrete-1;

            y1:=smy+round((up[k,j,i].s1)*inivar.tochekvdiskrete);
            y2:=smy+round((up[k,j,i].s2)*inivar.tochekvdiskrete);

            col:=ClBlack;


            {
            case up[k,j,i].tp of
              1:
                 begin
                   col:=ClGray;  //ClGreen; // подложка
                   tmpstr:='#000000';

                 end;
              3:
                 begin
                   col:=ClBlue; // переф.
                   tmpstr:='#808080';
                 end;
              4:
                 begin
                   col:=ClBlack; // центр
                   tmpstr:='#404040';
                 end;
              else
                 begin
                   col:=ClRed;
                   tmpstr:='red';
                 end;
            end;
            }

                     case up[k,j,i].tp of
                      1:
                        begin
                         col:=ClGray; // подложка
                         tmpstr:='#000000';
                        end;
                      3:
                        begin
                         if up[k,j,i].sloy = 1 then
                           begin
                             col:=ClBlue; // переф.
                             tmpstr:='#808080';
                           end                 else
                             if up[k,j,i].sloy = 2 then
                               begin
                                 col:=clTeal; // переф.
                                 tmpstr:='#878787';
                               end else
                               begin
                                 col:=clPurple; // переф.
                                 tmpstr:='#909090';
                               end;
                        end;
                      4:
                        begin

                         if up[k,j,i].sloy = 1 then
                           begin
                             col:=ClBlack; // центр
                             tmpstr:='#404040';
                           end                 else
                             if up[k,j,i].sloy = 2 then
                               begin
                                 col:=clNavy; // центр
                                 tmpstr:='#373737';
                               end else
                               begin
                                 col:=clMaroon; // центр
                                 tmpstr:='#303030';
                               end;


                        end;



                      else
                        begin
                         col:=ClRed;
                         tmpstr:='red';
                        end;
                     end;



            write_rectangle(x1, t.Height-y1, x2, t.Height-y2, col, col, t.Canvas);

            writeln (F2,'  <rect x="'+floattostr(smxsvg+i*iniVar.tochekvdiskretesvg)+'" y="'+floattostr(hsvg-(up[k,j,i].s2)*iniVar.tochekvdiskretesvg)+'"  width="'+floattostr(iniVar.tochekvdiskretesvg)+'" height="'+floattostr(((up[k,j,i].s2-up[k,j,i].s1)*iniVar.tochekvdiskretesvg))+'" fill="'+tmpstr+'"/>');

            for k2:=0 to inivar.sloev_v_shlife-1 do
              begin
                sloiarr[k2].zalito:=sloiarr[k2].zalito     + RazmerPeresecheniy(k2*dz_in_layer, (k2+1)*dz_in_layer, up[k,j,i].s1, up[k,j,i].s2);
                sloiarr[k2].nezalito:=sloiarr[k2].nezalito + RazmerPeresecheniy(k2*dz_in_layer, (k2+1)*dz_in_layer, up[k,j,i].p0, up[k,j,i].s1);
              end;

           end;  ////for k=0 to cup
       end;//for i=0 to fild_x
     // ----------------------------------------------------------------------------


   {$ENDREGION}

     {$REGION 'Рисование шлифа  (ЧАСТЬ из CASH)'}

     // ------------------- Рисуем из кэша -----------------------------------------
     // ----------------------------------------------------------------------------
     if FileExists('cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp')
       then
         begin
           AssignFile (f,'cash\unt'+inttostr (j div inivar.srez_interval)+'.tmp');
           reset (f);

           for k:=0 to FileSize (f)-1 do
             begin
               read (f,tempel);

               if (tempel.ty=j) AND ((iniVar.obrezka <=tempel.tx) AND (tempel.tx <= vrb.fild_x-iniVar.obrezka))
                 then
                   begin
                     i:=tempel.tx;

                     x1:=smx+tempel.tx*inivar.tochekvdiskrete;
                     x2:=x1+inivar.tochekvdiskrete-1;

                     y1:=smy+round((tempel.el.s1)*inivar.tochekvdiskrete);
                     y2:=smy+round((tempel.el.s2)*inivar.tochekvdiskrete);

                     col:=ClBlack;

                     case tempel.el.tp of
                      1:
                        begin
                         col:=ClGray; // подложка
                         tmpstr:='#000000';
                        end;
                      3:
                        begin
                         if tempel.el.sloy = 1 then
                           begin
                             col:=ClBlue; // переф.
                             tmpstr:='#808080';
                           end                 else
                             if tempel.el.sloy = 2 then
                               begin
                                 col:=clTeal; // переф.
                                 tmpstr:='#878787';
                               end else
                               begin
                                 col:=clPurple; // переф.
                                 tmpstr:='#909090';
                               end;
                        end;
                      4:
                        begin

                         if tempel.el.sloy = 1 then
                           begin
                             col:=ClBlack; // центр
                             tmpstr:='#404040';
                           end                 else
                             if tempel.el.sloy = 2 then
                               begin
                                 col:=clNavy; // центр
                                 tmpstr:='#373737';
                               end else
                               begin
                                 col:=clMaroon; // центр
                                 tmpstr:='#303030';
                               end;


                        end;



                      else
                        begin
                         col:=ClRed;
                         tmpstr:='red';
                        end;
                     end;

                     write_rectangle(x1, t.Height-y1, x2, t.Height-y2, col, col, t.Canvas);
                     writeln (F2,'  <rect x="'+floattostr(smxsvg+i*iniVar.tochekvdiskretesvg)+'" y="'+floattostr(hsvg-(tempel.el.s2)*iniVar.tochekvdiskretesvg)+'"  width="'+floattostr(iniVar.tochekvdiskretesvg)+'" height="'+floattostr(((tempel.el.s2-tempel.el.s1)*iniVar.tochekvdiskretesvg))+'" fill="'+tmpstr+'"/>');
//                   writeln (F2,'  <rect x="'+floattostr(smxsvg+i*iniVar.tochekvdiskretesvg)+'" y="'+floattostr(hsvg-(up[k,j,i].s2)*iniVar.tochekvdiskretesvg)+'"  width="'+floattostr(iniVar.tochekvdiskretesvg)+'" height="'+floattostr(((up[k,j,i].s2-up[k,j,i].s1)*iniVar.tochekvdiskretesvg))+'" fill="'+tmpstr+'"/>');

                     for k2:=0 to inivar.sloev_v_shlife-1 do
                       begin
                         sloiarr[k2].zalito:=sloiarr[k2].zalito     + RazmerPeresecheniy(k2*dz_in_layer, (k2+1)*dz_in_layer, tempel.el.s1, tempel.el.s2);
                         sloiarr[k2].nezalito:=sloiarr[k2].nezalito + RazmerPeresecheniy(k2*dz_in_layer, (k2+1)*dz_in_layer, tempel.el.p0, tempel.el.s1);
                       end;

                   end;

             end;

           CloseFile (f);
         end;

   {$ENDREGION}
      //====================================================================================================================================

     {$REGION 'Рисуем зарубки (линии сетки)'}
     t.Canvas.Font.Size:=10;
     writeln (F2,'  <line x1="'+floattostr(smxsvg-5)+'" y1="'+floattostr(hsvg)+'" x2="'+floattostr(smxsvg-5)+'" y2="'+floattostr(hsvg-upround2(vrb.stat_h)*iniVar.tochekvdiskretesvg)+'" stroke="black" stroke-width="2"  />');

     // OX
     i:=0;
     while zx*i<=vrb.fild_x*inivar.diskret_x  do
       begin
        tmp:=round((zx*i/inivar.diskret_x)*inivar.tochekvdiskrete);
        write_rectangle(smx+tmp   , t.Height-(smy-5), smx+tmp, t.Height-(smy+hchart), ClBlue, ClBlue, t.Canvas); //длинные отметки



        if i<>0 then
        writeln (F2,'  <line x1="'+floattostr(smxsvg+(zx*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'" y1="'+floattostr(hsvg)+'" x2="'+floattostr(smxsvg+(zx*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'" y2="'+floattostr(hsvg-vrb.stat_h*iniVar.tochekvdiskretesvg)+'" stroke="#c0c0c0" stroke-width="2"  />');

        tmpstr:=floattostr(zx*i);

        writeln (F2,'  <text x="'+floattostr(smxsvg+(zx*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'" y="'+floattostr(hsvg+50)+'"  font-size="40" font-family="Verdana" >'+tmpstr+' mkm</text>');

        t.canvas.pen.color:=ClYellow;
        t.canvas.Brush.color:=ClWhite;
        t.Canvas.TextOut(smx+tmp-round(t.Canvas.TextWidth(tmpstr) / 2), t.Height-(smy - 7), tmpstr );
        i:=i+1;
       end;

     // OY
     i:=0;
     while zy*i<=vrb.stat_h*inivar.diskret_x  do
       begin
        tmp:=round((zy*i/inivar.diskret_x)*inivar.tochekvdiskrete);
//        write_rectangle(smx-7   , t.Height-(smy+tmp), smx+wchart, t.Height-(smy+tmp), ClBlue, ClBlue, t.Canvas); //длинная метка
        tmpstr:=floattostr(zy*i);

        if i<>0 then
        writeln (F2,'  <line x1="'+floattostr(smxsvg)+'" y1="'+floattostr(hsvg-(zy*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'" x2="'+floattostr(smxsvg+iniVar.tochekvdiskretesvg*vrb.fild_x)+'" y2="'+floattostr(hsvg-(zy*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'" stroke="#c0c0c0" stroke-width="2"  />');

        writeln (F2,'  <text x="'+floattostr(0)+'" y="'+floattostr(hsvg-(zy*i/inivar.diskret_x)*iniVar.tochekvdiskretesvg)+'"  font-size="40" font-family="Verdana" >'+tmpstr+' mkm</text>');

        t.canvas.Brush.color:=ClWhite;
        t.Canvas.TextOut(smx-round(t.Canvas.TextWidth(tmpstr)*1.7), t.Height-(smy+tmp + round(t.Canvas.TextHeight(tmpstr)/2) ), tmpstr );
        i:=i+1;
       end;
// }


     {$ENDREGION}

     {$REGION 'Считает пористость'}
     max_v_shlife:=0;
     poristost_shlif_fill:=0;
     poristost_shlif_vsego:=0;

     for k2:=0 to inivar.sloev_v_shlife-1 do
       begin

         if (sloiarr[k2].zalito+sloiarr[k2].nezalito) > 0 then
                                                           begin
                                                             poristost_v_sloe[k2]:=round((sloiarr[k2].nezalito/(sloiarr[k2].zalito+sloiarr[k2].nezalito)*100*1000))/1000;
                                                           end
                                                          else
                                                           begin
                                                             poristost_v_sloe[k2]:=0;
                                                           end;

         if max_v_shlife < poristost_v_sloe[k2] then max_v_shlife := poristost_v_sloe[k2];

         poristost_shlif_fill:=poristost_shlif_fill+sloiarr[k2].zalito;
         poristost_shlif_vsego:=poristost_shlif_vsego+(sloiarr[k2].zalito+sloiarr[k2].nezalito);
       end;  ////for k=0 to sloev_v_shlife

     // Пористость расчет
     if poristost_shlif_vsego>0 then
                                  begin
                                    poristost_shlif_value:= round((1 - (poristost_shlif_fill/poristost_shlif_vsego))*100*10000)/10000;
                                  end
                                else
                                  begin
                                    poristost_shlif_value:=0;
                                  end;

     write_rectangle(smx2-2, t.Height-(smy2-2), smx2+wchart2, t.Height-(smy2-1), ClBlue, ClBlue, t.Canvas); // метка
     write_rectangle(smx2-2, t.Height-(smy2-2), smx2-1, t.Height-(smy2+hchart2), ClBlue, ClBlue, t.Canvas); // метка
   {$ENDREGION}

     {$REGION 'Рисует столбики гистограммы'}
     for k:=0 to inivar.sloev_v_shlife-1 do        //2
       begin
         tmpstr := floattostr(poristost_v_sloe[k]);

         tmp := round((poristost_v_sloe[k] * (hchart2-10)) / max_v_shlife);

         write_rectangle(smx2+(50+10)*k , t.Height-(smy2-5), smx2+(50+10)*k, t.Height-(smy2-1), ClRed, ClRed, t.Canvas); // метка

         if poristost_v_sloe[k]>0 then
         write_rectangle(smx2+(50+10)*k + 5, t.Height-(smy2), smx2+(50+10)*k + 55, t.Height-(smy2+tmp), ClRed, ClRed, t.Canvas); // сама гистограмма вверху

         //это сторока рисует поперечены на нижнем графике
         write_rectangle(smx, t.Height-(smy +   round((inivar.tochekvdiskrete * k*dz_in_layer)/inivar.diskret_x)   ), smx + wchart , t.Height-(smy + round((inivar.tochekvdiskrete*k*dz_in_layer)/inivar.diskret_x)), ClRed, ClRed, t.Canvas); // линия в нижнем графике

         t.canvas.Brush.color:=ClWhite;

         tmpstr := floattostr(poristost_v_sloe[k])+'%';
         t.Canvas.TextOut(smx2 + round((50+10)*(k+0.5))  - round(t.Canvas.TextWidth(tmpstr)*1.1 / 2) , t.Height-(smy2+tmp+round(t.Canvas.TextHeight(tmpstr))), tmpstr ); // подписать вверху значение

         tmpstr := inttostr(k+1);
         t.Canvas.TextOut(smx2 + round((50+10)*(k+0.5))  - round(t.Canvas.TextWidth(tmpstr)*1.1 / 2) , t.Height-(smy2-5), tmpstr ); // подписать внизу номер

       end;  ////for k=0 to sloev_v_shlife  //2

     write_rectangle(smx2+(50+10)*(k+1), t.Height-(smy2-5), smx2+(50+10)*(k+1), t.Height-(smy2-1), ClRed, ClRed, t.Canvas); // последняя метка, уже после последнего столбика

     write_rectangle(smx, t.Height-(smy +   round((inivar.sloev_v_shlife*dz_in_layer)/inivar.diskret_x)*inivar.tochekvdiskrete   ), smx + wchart , t.Height-(smy + round((inivar.sloev_v_shlife*dz_in_layer)/inivar.diskret_x)*inivar.tochekvdiskrete), ClRed, ClRed, t.Canvas);
   {$ENDREGION}

     {$REGION 'Анализ шероховатости в шлифе'}
   for i:=iniVar.obrezka to vrb.fild_x-iniVar.obrezka do
     begin
        //Анализ шероховатости----------
        if (sherohovatost_ot<=i) AND (i<=sherohovatost_do) then
            begin
                                  if i = sherohovatost_ot then
                                             begin
                                              sherohovatost_avg:=0;
                                              if cup[j,i]>=0 then
                                                              begin
                                                               sherohovatost_min:=up[cup[j,i],j,i].s2;
                                                               sherohovatost_max:=up[cup[j,i],j,i].s2;
                                                              end
                                                             else
                                                              begin
                                                               sherohovatost_min:=0;
                                                               sherohovatost_max:=0;
                                                              end;

                                              sherohovatost_sum:=sherohovatost_max; // т.к. может быть cup=-1.

                                             end
                                            else
                                             begin
                                              if cup[j,i]>=0 then
                                                              begin
                                                               if sherohovatost_max < up[cup[j,i],j,i].s2 then sherohovatost_max := up[cup[j,i],j,i].s2;
                                                               if sherohovatost_min > up[cup[j,i],j,i].s2 then sherohovatost_min := up[cup[j,i],j,i].s2;
                                                               sherohovatost_sum := sherohovatost_sum + up[cup[j,i],j,i].s2;
                                                              end
                                                             else
                                                              begin
                                                               if sherohovatost_min > 0   then sherohovatost_min := 0;
                                                              end;
                                             end;
            end;
     end;// i = 0 fild_x

    // Шероховатость расчет
    if (sherohovatost_do-sherohovatost_ot)<>0 then
                                              sherohovatost_avg:=sherohovatost_sum / (sherohovatost_do-sherohovatost_ot);
   {$ENDREGION}

     {$REGION 'Вывод строк комментариев'}
    log ('');
    log ('==========================================================================================');
    tmpstr := 'Шлиф № ' +inttostr(j);
    log (tmpstr);

    tmpstr := ' Площадь залитой части: ' + floattostr(poristost_shlif_fill) + ' Площадь шлифа : ' + floattostr(poristost_shlif_vsego);
    log (tmpstr);

    tmpstr := ' Общаяя пористость по шлифу : ' + floattostr(poristost_shlif_value) +'%';
    log (tmpstr);
    t.canvas.Brush.color:=ClWhite;
    t.Canvas.TextOut(smx2+(inivar.sloev_v_shlife*(50+10))+50, t.Height-(smy2+hchart2), tmpstr );

    t.canvas.Brush.color:=ClWhite;
    tmpstr := ' Шероховатость срез №' + inttostr(j) + ' : min=' + floattostr(sherohovatost_min) + ' max=' + floattostr(sherohovatost_max) +' avg=' + floattostr(sherohovatost_avg) + ' sum=' + floattostr(sherohovatost_sum);
    log (tmpstr);

    tmpstr := ' Шероховатость срез №' + inttostr(j) +' :';
    t.Canvas.TextOut(smx2+(inivar.sloev_v_shlife*(50+10))+50, t.Height-(smy2+hchart2-15), tmpstr );

    tmpstr := ' Минимальная точка =' + floattostr(sherohovatost_min*inivar.diskret_x) ;
    t.Canvas.TextOut(smx2+(inivar.sloev_v_shlife*(50+10))+50, t.Height-(smy2+hchart2-30), tmpstr );

    tmpstr := ' Максимальная точка =' + floattostr(sherohovatost_max*inivar.diskret_x) ;
    t.Canvas.TextOut(smx2+(inivar.sloev_v_shlife*(50+10))+50, t.Height-(smy2+hchart2-45), tmpstr );

    tmpstr := ' Среднее значение =' + floattostr(sherohovatost_avg*inivar.diskret_x) ;
    t.Canvas.TextOut(smx2+(inivar.sloev_v_shlife*(50+10))+50, t.Height-(smy2+hchart2-60), tmpstr );

    t.canvas.Brush.color:=ClWhite;
    tmpstr:='Шлиф № '+ inttostr(j)+'.';
    t.Canvas.TextOut(round(t.width/2) - round(t.Canvas.TextWidth(tmpstr) / 2), 0,  tmpstr);

    tmpstr:=' мкм';
    t.Canvas.TextOut(smx + wchart, t.Height-(smy - 7),   tmpstr);

    t.Canvas.TextOut(smx - round(t.Canvas.TextWidth(tmpstr)*1.7), t.Height-(smy + hchart + t.Canvas.TextHeight(tmpstr)),   tmpstr);

    log ('==========================================================================================');

   {$ENDREGION}

     {$REGION 'Сохранить в файл картинку'}
     // Сохранить картинку в файл.
//     imgname:=format ('%5d.bmp', [j]);
     imgname:=format ('rez\'+vrb.start_timestamp+'_%5d_'+'.jpg', [j]);

     if fileexists(imgname) then
       DeleteFile(imgname);


//     t.SaveToFile(imgname);
     ToJpeg:=TJPEGImage.Create;

     ToJpeg.Assign(t.Picture.Bitmap);

     ToJpeg.CompressionQuality:=100;

     ToJpeg.SaveToFile(imgname);

     ToJpeg.free;
     t.free;

     writeln (F2,'</svg>');
     closefile (f2);
   {$ENDREGION}


     j:=j + inivar.srez_interval;

   end;//for j=0 to fild_y

 poristost_v_sloe:=nil;
 sloiarr:=nil;
end;

