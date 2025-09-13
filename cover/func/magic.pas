procedure random_karta_clear; var i:integer; begin  for I := 0 to length(random_karta)-1 do random_karta[i] := false; karta_col_used := 0; log('Рендом, чистка поля'); end;


//случайным образом ищет нужный квадрат
procedure findkvadrat (var kx:integer; var ky:integer);
var  k, tempvalue : integer;

begin

  if karta_col_used >= kol_9cheek_x * kol_9cheek_y then
    begin
      random_karta_clear;
    end;

  k := 0;
  repeat
    k:=k+1;
    tempvalue := random(kol_9cheek_x * kol_9cheek_y);

    if length(random_karta)<=tempvalue then
      begin
        ShowMessage('Вылет за карту');
        Application.terminate;
      end;
  until NOT (random_karta[tempvalue]) OR ( K > 10*kol_9cheek_x * kol_9cheek_y);

  //если вылетели по счетчику, тогда надо искать перебором, сколько можно ждать
  if ( K > 10*kol_9cheek_x * kol_9cheek_y) then
    begin
     for k := 0 to length(random_karta)-1 do
        begin
          if NOT random_karta[k] then
            begin
              tempvalue := k;
              break;
            end;
        end;
    end;

  karta_col_used := karta_col_used + 1;

  if random_karta[tempvalue] then 
      showmessage('ERROR:find');
      
  random_karta[tempvalue] := true;

  ky := tempvalue div kol_9cheek_y;
  kx := tempvalue mod kol_9cheek_y;


 // dump(21);


  logk2 (maincaunter, tempvalue, kx,ky );

end;



procedure magic_real (var crkl_center_x: integer; var crkl_center_y: integer;
                      var crkl_Rp_OP: integer; var crkl_Rs_OP: integer; var crkl_height_OP : real;
                      var crkl_Rp_J: integer; var crkl_Rs_J: integer; var crkl_height_J : real;
                      var Vol: real;
                      var Tp0:real; var Up0:real; var Tb0:real; splattype:integer; SplatNum:integer);
var
    dp_stddev,
    tp_stddev,
    up_stddev,
    dp_abs,
    up_abs,
    tp_abs,
    h_abs, Ds_abs:real;
    danger:integer;
    scen:integer;
    zabili_podlojku:boolean;

    tmp : integer;

    hpronikn:real;

    kx,ky : integer;
    i :integer;

label zabili;


function FloatIsNorm(f:real):boolean;
begin
 result :=  NOT ((IsNaN(f) or IsInfinite(f)));
end;

begin

  danger:=0;

  repeat

    danger:=danger+1;
    zabili_podlojku := false;

//   dpmin_abs // Dp abs  мкм.
//   dpmax_abs // Dp abs  мкм.

    zabili:    //если режим "забыли подложку" то надо пересчитать прыгнув по этой метке

    //Dp - надо сгененрировать
    //а должно оно быть между:
    //iniVar.dpmin_abs
    //iniVar.dpmax_abs

    case iniVar.sposob_vvoda of
      0,1: //Это классический способ генерации
         begin
           dp_stddev:=(iniVar.dpmax_abs-iniVar.dpmin_abs);

           dp_abs:=NRand ( iniVar.dpmin_abs+dp_stddev/2, dp_stddev, iniVar.dp_stdiv);

           up_abs:=NRand ( iniVar.velos_min+up_stddev/2, up_stddev, iniVar.up_stdiv);

         end;
        2: //Это гистограммный
         begin
           tmp := random(iniVar.histogram[iniVar.hist_n].sm) + 1;

           for i := 0 to iniVar.histogram[iniVar.hist_n].k - 1 do
             begin  //вычитаем из сгенерированного числа, на нужном интервале число станет нулевым или отрицательным
               tmp := tmp - iniVar.histogram[iniVar.hist_n].a[i];
               if tmp <= 0 then break;
             end;
           //теперь берем середину интервала i
//           dp_abs := round ( iniVar.dpmin_abs + ((iniVar.dpmax_abs-iniVar.dpmin_abs) / iniVar.histogram[iniVar.hist_n].k) * (i + 1/2) );
           dp_abs := round ( iniVar.dpmin_abs + (  (iniVar.dpmax_abs - iniVar.dpmin_abs) / iniVar.histogram[iniVar.hist_n].k ) * (i +  1000 / (random(1000)+1)  ) );

           if iniVar.histogram[iniVar.hist_n].u[i] > 0 then up_abs:= iniVar.histogram[iniVar.hist_n].u[i]   //Если значение определено, тогда берем его, иначе по старому
                                                       else up_abs:=NRand ( iniVar.velos_min+up_stddev/2, up_stddev, iniVar.up_stdiv);


         end;
    end;

    tp_stddev:=(iniVar.temp_patic_max-iniVar.temp_patic_min);
    up_stddev:=(iniVar.velos_max-iniVar.velos_min);
    tp_abs:=NRand ( iniVar.temp_patic_min+tp_stddev/2, tp_stddev, iniVar.tp_stdiv);


    log ('dp='+floattostr(dp_abs)+' мкм');
    log ('tp='+floattostr(tp_abs)+' К');
    log ('up='+floattostr(up_abs)+' м/с');



    Tp0:=tp_abs;
    Up0:=up_abs;
    Tb0:=iniVar.temp_base;

   //====================================================================================================
   //     Метод О.П.
   //====================================================================================================
//   if splattype = 0 then
     begin

      if Vrb.IsSecondType = 1 then SplatNum := -1;

      case iniVar.tip_materiala of
         0 :
             begin
             //  log ('Используем расчет по формуле металлов');

        advcalculator_metal     (zabili_podlojku, dp_abs/1000000, tp_abs, iniVar.temp_base,
                           up_abs, iniVar.part_class, iniVar.sub_class,
                           h_abs, Ds_abs, scen,
                           hpronikn, SplatNum);

             end;
         1 : begin
             //  log ('Используем расчет по формеле оксидов');


        advcalculator_oksid (zabili_podlojku, dp_abs/1000000, tp_abs, iniVar.temp_base,
                           up_abs, iniVar.part_class, iniVar.sub_class,
                           h_abs, Ds_abs, scen,
                           hpronikn, SplatNum);

             end;
         2 : begin
              // log ('Используем расчет по формуле металлокерамики');

        advcalculator_metKer (zabili_podlojku, dp_abs/1000000, tp_abs, iniVar.temp_base,
                           up_abs, iniVar.part_class, iniVar.inc_class, iniVar.sub_class,
                           h_abs, Ds_abs, scen, iniVar.VolCon,
                           iniVar.formula,
                           hpronikn, SplatNum);

             end;
      end;


//procedure advcalculator     (zabili_podlojku: boolean;
//                             Dp, Tpo, TB0, V:real;
//                             partmat, basemat:CCutBoxSet;
//                             var H :real; var Ds_vozvr:real; var scen:integer);

//procedure advcalculator_mk3 (
//                             zabilipodlojku: boolean;
//                             Dp, Tpo, TB0, V:real;
//                             partmat, incmat, basemat:CCutBoxSet;
//                             var H :real; var Ds_vozvr:real; var scen:integer;
//                             volcon:real );

//procedure advcalculator_mk4 (zabilipodlojku: boolean;
//                             Dp, Tpo, TB0, V:real;
//                             partmat, incmat, basemat:CCutBoxSet;
//                             var H :real; var Ds_vozvr:real; var scen:integer;
//                             volcon:real; formula:integer; var glub_pronikn:real);


    if SplatNum = 1 then
      begin
        logreport ('материал частицы Pb=' + inttostr(iniVar.part_class.m_nId) + ' это ' + iniVar.part_class.m_Material);
        logreport ('материал подложки B =' + inttostr(iniVar.sub_class.m_nId) + ' это ' + iniVar.sub_class.m_Material );
        LogRec.PartName := iniVar.part_class.m_Material;
        LogRec.BaseName := iniVar.sub_class.m_Material;

        case iniVar.tip_materiala of
         0: logReport ('Формула металлы ');
         1: logReport ('Формула оксиды ');
         2:
            begin
              logReport ('Формула металлокерамики');
              logreport ('материал включений Pi=' + inttostr(iniVar.inc_class.m_nId) + ' это ' + iniVar.inc_class.m_Material);
              logreport ('объемная концентрация VolCon=' + floattostr(iniVar.VolCon) );

              LogRec.PartName := LogRec.PartName + '+'+floattostr(iniVar.VolCon) + ' '+ iniVar.inc_class.m_Material;
            end;
        end;

        logReport ('Dp: ' + floattostr(iniVar.dpmin_abs) + '-'+ floattostr(iniVar.dpmax_abs));
        logReport ('Tp: ' + floattostr(iniVar.temp_patic_min) + '-'+ floattostr(iniVar.temp_patic_max));
        logReport ('up: ' + floattostr(iniVar.velos_min) + '-'+ floattostr(iniVar.velos_max));
        logReport ('Tb: ' + floattostr(iniVar.temp_base));

        LogRec.Dp := round ((iniVar.dpmin_abs + iniVar.dpmax_abs) / 2);
        LogRec.Tp := round ( (iniVar.temp_patic_min+ iniVar.temp_patic_max) / 2 );
        LogRec.Up := round ((iniVar.velos_min + iniVar.velos_max) / 2);
        LogRec.Tb := round (iniVar.temp_base);




        case iniVar.tip_materiala of
         0: AddToLogArh (1, 'mode', 3, 0, 0,  'metal');
         1: AddToLogArh (1, 'mode', 3, 0, 0,  'oxid');
         2: AddToLogArh (1, 'mode', 3, 0, 0,  'met-ker');
        end;


        if iniVar.tip_materiala = 2 then
            begin
              AddToLogArh (1, 'Pmat', 3, 0, 0,  iniVar.part_class.m_Material + ' (' +floattostr(1-iniVar.VolCon)+')');
              AddToLogArh (1, 'Pbase', 3, 0, 0,  iniVar.sub_class.m_Material );
              AddToLogArh (1, 'Pincl', 3, 0, 0,  iniVar.inc_class.m_Material + ' (' +floattostr(iniVar.VolCon)+')');
            end
        else
            begin
              AddToLogArh (1, 'Pmat', 3, 0, 0,  iniVar.part_class.m_Material + ' (' +floattostr(1-iniVar.VolCon)+')');
              AddToLogArh (1, 'Pb', 3, 0, 0,  iniVar.sub_class.m_Material );
            end;


        AddToLogArh (1, 'Dp', 2, 0, dp_abs,  '');
        AddToLogArh (1, 'up', 2, 0, up_abs,  '');
        AddToLogArh (1, 'Tp', 2, 0, tp_abs,  '');
        AddToLogArh (1, 'Tb', 2, 0, iniVar.temp_base,  '');
        AddToLogArh (1, 'H', 2, 0, h_abs*1000000,  '');
        AddToLogArh (1, 'Ds', 2, 0, Ds_abs*1000000,  '');
        AddToLogArh (1, 'Scen', 1, scen, 0,  '');





      end;



        if (iniVar.tip_materiala<>0) AND (scen<>1) then
           begin
             ShowMessage ('Выход за пределы 1 сценария. Подберите правильно данные.');
             Application.Terminate;
           end;
//}


        if (NOT FloatIsNorm(h_abs)) OR  (NOT FloatIsNorm(Ds_abs))
        then
          begin
            showMessage (' Ошибка, Hs или Ds для текущей точки непосчитался. Приложение будет закрыто ');
            log ('Ds= ' + floattostr(Ds_abs) + ' Hs='+ floattostr(h_abs));
            Application.Terminate;
          end;



        h_abs  := h_abs  * 1000000;
        Ds_abs := Ds_abs * 1000000;
        //теперь все в мкм

  {  if SplatNum = 1 then
      begin
        logReport ('Ds до округления, мкм: ' + floattostr(round(Ds_abs*10)/10));
        logReport ('hs до округления, мкм: ' + floattostr(round(h_abs*1000)/1000));
      end;}


      if  iniVar.polaya_chastica = false then
       begin

        //====================== Классическая методика ===================================
        //то, что мы расчитали по методике ОП
        Vol := (4/3) * PI* step(Dp_abs/iniVar.diskret_x/2, 3);

        crkl_Rp_OP := round(Dp_abs/iniVar.diskret_x/2);
        crkl_Rs_OP := round(Ds_abs/iniVar.diskret_x/2);
        crkl_height_OP := h_abs/iniVar.diskret_x;

        // теперь конвертим в метод J
        crkl_Rp_J      := crkl_Rp_OP;
        crkl_height_J  := crkl_height_OP;
        crkl_Rs_J      := round(GetJRs (crkl_height_J, Dp_abs/iniVar.diskret_x/2));


//        RsJ >> RsOP
        if crkl_Rs_OP > crkl_Rs_J then
          begin
             ShowMessage ('Получилось что Rs по ОП больше чем Rs по J');
             Application.Terminate;
          end;
       end
      else
       begin
        //====================== Полые частицы ===================================
        //то, что мы расчитали по методике OP или J
        Vol := (4/3) * PI* step(Dp_abs/iniVar.diskret_x/2, 3); //   4/3 * PI R^3


        // теперь конвертим в метод J
        crkl_Rp_J      := round(Dp_abs/iniVar.diskret_x/2);
        crkl_Rs_J      := round(Ds_abs/iniVar.diskret_x/2);
        crkl_height_J  := h_abs/iniVar.diskret_x;

        crkl_Rp_OP :=   crkl_Rp_J;
        crkl_Rs_OP     := round(Ds_abs/iniVar.diskret_x/2);
        crkl_height_OP := crkl_height_J * 2 / 3;

//        RsJ >> RsOP
        if crkl_Rs_OP > crkl_Rs_J then
          begin
             ShowMessage ('Получилось что Rs по OP больше чем Rs по J для полых частиц');
             Application.Terminate;
          end;

       end;









        // Пусть центр будет равномерное распределение.
        if NOT zabili_podlojku then
          begin
            if  (iniVar.stoh=0)  then
              begin
                if  NOT zabili_podlojku then  findkvadrat ( kx, ky );

                vrb.crkl_center_x := upround(vrb.max_subfild_size_x/2) +  tochek_in_x * kx + random (tochek_in_x);
                vrb.crkl_center_y := upround(vrb.max_subfild_size_y/2) +  tochek_in_y * ky + random (tochek_in_y);

                //vrb.crkl_center_x := random (iniVar.fild_size_x_d-2*crkl_Rs-10)+crkl_Rs+5;
                //vrb.crkl_center_y := random (iniVar.fild_size_y_d-2*crkl_Rs-10)+crkl_Rs+5;

                if splattype = 0 then //OP
                  begin
                     if NOT(
                        (crkl_center_x+crkl_Rs_OP < iniVar.fild_size_x_d - 4) AND
                        (crkl_center_y+crkl_Rs_OP < iniVar.fild_size_y_d - 4) AND
                        (crkl_center_x-crkl_Rs_OP > 4) AND
                        (crkl_center_y-crkl_Rs_OP > 4))
                     then  showmessage('Залет');
                  end            else // J
                  begin
                     if NOT(
                        (crkl_center_x+crkl_Rp_J < iniVar.fild_size_x_d - 4) AND
                        (crkl_center_y+crkl_Rp_J < iniVar.fild_size_y_d - 4) AND
                        (crkl_center_x-crkl_Rp_J > 4) AND
                        (crkl_center_y-crkl_Rp_J > 4))
                     then  showmessage('Залет');
                  end;




              end;
          end;
     end;
   //====================================================================================================


  until ( ((
          (crkl_center_x+crkl_Rs_OP < iniVar.fild_size_x_d - 4) AND
          (crkl_center_y+crkl_Rs_OP < iniVar.fild_size_y_d - 4) AND

          (crkl_center_x-crkl_Rs_OP > 4) AND
          (crkl_center_y-crkl_Rs_OP > 4) AND

          (crkl_Rp_OP>2)) AND (splattype = 0))

          OR (danger>60000)
          OR ((
          (crkl_center_x+crkl_Rs_J < iniVar.fild_size_x_d - 4) AND
          (crkl_center_y+crkl_Rs_J < iniVar.fild_size_y_d - 4) AND

          (crkl_center_x-crkl_Rs_J > 4) AND
          (crkl_center_y-crkl_Rs_J > 4) AND

          (crkl_Rp_J>2)
          ) AND (splattype <> 0))



        );

  if danger>=60000 then
                    begin
                     showMessage (' Ошибка, не могу сгенерировать Dp, оно в поле не влезает. Проверьте введенные параметры. Приложение будет закрыто');
                     Application.Terminate;
                    end;
//}

   if NOT zabili_podlojku then
     begin
       if  (iniVar.stoh=0)  then
        begin
          log ('Глубина проникновения расчетная: '+floattostr(hpronikn)+ ' мкм');
          log ('Глубина проникновения расчетная: ' + floattostr(hpronikn*1000000/iniVar.diskret_x)+' дск');
          log ('Высота центра: ' + floattostr(fild [vrb.crkl_center_y, vrb.crkl_center_x].z - zerolevel) + ' дск');
          if fild [vrb.crkl_center_y, vrb.crkl_center_x].z-zerolevel > 0
            then log('Высота центра больше нуля');


          {// Это вариант с забыванием подложки по глубине подплавления
          if (hpronikn*1000000/iniVar.diskret_x <= fild [vrb.crkl_center_y, vrb.crkl_center_x].z-zerolevel) then
            begin
             zabili_podlojku := true;
             log('На такой высоте уже забыли подложку, пересчет');
             goto zabili;
            end;
          }


          // Это вариант с забыванием подложки по типу подложки
          if fild [vrb.crkl_center_y, vrb.crkl_center_x].sloy = iniVar.first_time then
            begin
             zabili_podlojku := true;
             log('С таким типом материала уже забыли подложку, пересчет');

              if Vrb.IsSecondType = 0 then
                 Vrb.IsSecondType := 1;
             goto zabili;
            end;



        end;
     end;

end;

  //}
{
procedure magic_dsk (var crkl_center_x: integer; var crkl_center_y: integer; var crkl_Rp: integer; var crkl_Rs: integer; var crkl_height : real);
var  // Ds_abs, Dp, h_abs, x_stddev, y_stddev:real;
//    s:string;
   danger:integer;

begin
  danger:=0;

  repeat
    danger:=danger+1;


//   dpmin_abs // Dp abs  мкм.
//   dpmax_abs // Dp abs  мкм.

   vrb.crkl_Rp := random (iniVar.razmeri_spleta_razbros)+iniVar.dpmin_d;
   vrb.crkl_Rs := round (vrb.crkl_Rp*4);
   vrb.crkl_height := (vrb.crkl_Rp / 10);

   if iniVar.mersen_is_on then
                            vrb.crkl_center_x := MersentRand (iniVar.fild_size_x_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5
                          else
                            vrb.crkl_center_x := random (iniVar.fild_size_x_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5;

   if iniVar.mersen_is_on then
                            vrb.crkl_center_y := MersentRand (iniVar.fild_size_y_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5
                          else
                            vrb.crkl_center_y := random (iniVar.fild_size_y_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5;


  until ( (
          (crkl_center_x+crkl_Rs < iniVar.fild_size_x_d - 4) AND
          (crkl_center_y+crkl_Rs < iniVar.fild_size_y_d - 4) AND

          (crkl_center_x-crkl_Rs > 4) AND
          (crkl_center_y-crkl_Rs > 4) AND

          (crkl_Rp>2)) OR (danger>60000)

        );

  if danger>=60000 then
                    begin
                     showMessage (' Ошибка, не могу сгенерировать Dp, оно в поле не влезает. Проверьте введенные параметры. Приложение будет закрыто');
                     Application.Terminate;
                    end;


{   s:='Центр сплета ('+ inttostr(vrb.crkl_center_x)+ ';'+ inttostr(vrb.crkl_center_y)+') Rp='+ inttostr(vrb.crkl_Rp)+' Rs='+ inttostr(crkl_Rs)+' h=' + floattostr(vrb.crkl_height)+' ';
   log (s);

   s:='Центр сплета ('+ floattostr(vrb.crkl_center_x*iniVar.diskret_x)+ ';'+ floattostr(vrb.crkl_center_y*iniVar.diskret_x)+') мкм. Rp='+ floattostr(vrb.crkl_Rp*iniVar.diskret_x)+' мкм.  Rs='+ floattostr(crkl_Rs*iniVar.diskret_x)+' мкм. h=' + floattostr(vrb.crkl_height*iniVar.diskret_x)+'мкм. ';
   log (s);

end;
}
{
procedure magic_test (niter:integer; var crkl_center_x: integer; var crkl_center_y: integer; var crkl_Rp: integer; var crkl_Rs: integer; var crkl_height : real);
begin

   case niter of
    1:  begin
         vrb.crkl_Rp := 25;
         vrb.crkl_Rs := vrb.crkl_Rp*4;
         vrb.crkl_height := vrb.crkl_Rp / 5;

         vrb.crkl_center_x := 150;
         vrb.crkl_center_y := 150;
        end;

    2:  begin
         vrb.crkl_Rp := 25;
         vrb.crkl_Rs := vrb.crkl_Rp*4;
         vrb.crkl_height := vrb.crkl_Rp / 5;

         vrb.crkl_center_x := 200;
         vrb.crkl_center_y := 150;
        end;


   else
     begin

       if iniVar.mersen_is_on then
                            vrb.crkl_Rp := MersentRand (iniVar.razmeri_spleta_razbros)+iniVar.dpmin_d
                          else
                            vrb.crkl_Rp := random (iniVar.razmeri_spleta_razbros)+iniVar.dpmin_d;

       vrb.crkl_Rs := round (vrb.crkl_Rp*4);
       vrb.crkl_height := (vrb.crkl_Rp / 10);

       if iniVar.mersen_is_on then
                                vrb.crkl_center_x := MersentRand (iniVar.fild_size_x_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5
                              else
                                vrb.crkl_center_x := random (iniVar.fild_size_x_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5;

       if iniVar.mersen_is_on then
                                vrb.crkl_center_y := MersentRand (iniVar.fild_size_y_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5
                              else
                                vrb.crkl_center_y := random (iniVar.fild_size_y_d-2*vrb.crkl_Rs-10)+vrb.crkl_Rs+5;
     end;
   end;

  if   NOT
        (  (crkl_center_x+crkl_Rs < iniVar.fild_size_x_d - 4) AND
          (crkl_center_y+crkl_Rs < iniVar.fild_size_y_d - 4) AND

          (crkl_center_x-crkl_Rs > 4) AND
          (crkl_center_y-crkl_Rs > 4))

         then
          showmessage ('Ты херню ввёл, не попадаешь');

  if iniVar.razmeri_spleta_razbros+iniVar.dpmin_d <= vrb.crkl_Rs then showmessage ('Херню ввел, щас вылезешь за границы шаблона');


end;
}
