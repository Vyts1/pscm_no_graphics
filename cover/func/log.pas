// Запись в лог файл
procedure log (S:string);
const maxFsize = 1024*1024*1800;
//      maxLines = 20;
      maxLines = 1024*1800;
//const maxFsize = 102;
var f:textfile;
    i:int64;
    t:string;
begin

 if not iniVar.main_log then exit;

 if iniVar.logstrnum > maxLines then
   begin
     iniVar.logfilenum := iniVar.logfilenum + 1;
     iniVar.logstrnum := 0;
   end else iniVar.logstrnum := iniVar.logstrnum + 1;

 {
 if iniVar.logfilenum = 0
    then i := GetFileSize2 (logfile)
    else i := GetFileSize2 (logfile+inttostr(iniVar.logfilenum));

 if (i > maxFsize) then iniVar.logfilenum := iniVar.logfilenum + 1;
 }



 if iniVar.logfilenum>0 then t:= inttostr(iniVar.first_time)+logfile+inttostr(iniVar.logfilenum)
                        else t := inttostr(iniVar.first_time)+logfile;

 AssignFile (f, t);
 if FileExists(t) then append(F) else rewrite(F);
 writeln (F,s);
 closefile (f);
end;


// Запись в лог файл
procedure LogReport (S:string);
var f:textfile;
    i:int64;
    t:string;
begin
 t:='Report_File.diz';
 AssignFile (f, t);
 if FileExists(t) then append(F) else rewrite(F);
 writeln (F,s);
 closefile (f);
end;


procedure AddToLogArh (n:integer; name:string; valT:byte; i:integer; r:real; s:string);
var l:integer;
begin
  l := length(LogArh);
  SetLength(LogArh, l+1);

  LogArh[l].num := n;
  LogArh[l].name := name;

  LogArh[l].valueR := r;
  LogArh[l].valueS := s;
  LogArh[l].valueI := i;
  LogArh[l].t := valT;
end;


procedure SaveArh;
var namearr : array of string;
    numarray : array of integer;
    i, j, k : integer;
    f:textfile;
    s,t:string;
    w:boolean;


begin
  //Сделаем строки/столбцы
  for I := 0 to length(LogArh)-1 do
    begin
      //-----------------------------------------------------------
      w := false;
      for j := 0 to length(namearr)-1 do
        begin
         if namearr[j] = logarh[i].name then
           begin
           w := true;
           Break;
           end;
        end;
      if not w then
        begin
          SetLength(namearr, length(namearr)+1);
          namearr[length(namearr)-1] := logarh[i].name;
        end;
      //-----------------------------------------------------------


      //-----------------------------------------------------------
      w := false;
      for j := 0 to length(numarray)-1 do
        begin
         if numarray[j] = logarh[i].num then
           begin
           w := true;
           Break;
           end;
        end;
      if not w then
        begin
          SetLength(numarray, length(numarray)+1);
          numarray[length(numarray)-1] := logarh[i].num;
        end;
      //-----------------------------------------------------------
    end;

 t:='ARH.CSV';
 AssignFile (f, t);
 rewrite(F);

 S:='#;';

 for I := 0 to length(namearr)-1 do
   begin
     S := S + namearr[i] + ';';
   end;

 writeln (F, s);
 for I := 0 to length(numarray)-1 do
   begin
     s := inttostr(numarray[i]) + ';';

     for j := 0 to length(namearr) - 1 do
       begin
         w := false;
         for k := 0 to length(LogArh) - 1 do
           begin
             if (LogArh[k].num = numarray[i]) AND (LogArh[k].name = namearr[j]) then
               begin
                 w:=true;
                 case LogArh[k].t of
                   1 : S:=S+inttostr(LogArh[k].valueI)+';';
                   2 : S:=S+floattostr(LogArh[k].valueR)+';';
                   3 : S := S + LogArh[k].valueS + ';';
                 end;
                 Break;
               end;
           end;
         if NOT W then
           begin
             S := S + '?;';
           end;
       end;
     writeln (F, s);
   end;



 closefile (f);



end;



procedure ProcLog (a:real; s:string);
var f:textfile;
    i:int64;
    t, s2:string;
    c:char;
begin
 t:='!PROC.LOG';
 AssignFile (f, t);
 rewrite(F);
 writeln (F, floattostr( round(a * 100)) + '%   ' + s);
 closefile (f);
end;


procedure complexLog (S:string);
var f:textfile;
    i:int64;
    t, s2:string;
    c:char;
begin
 t:='CL.csv';
 AssignFile (f, t);
 if FileExists(t) then append(F) else
 rewrite(F);

 c:=';';
 s2 := '';
 s2 := s2 + '#Слой'+c;
 s2 := s2 + 'матер'+c;
 s2 := s2 + 'Сплэт'+c;
 s2 := s2 + 'Формула'+c;
 s2 := s2 + 'Полая'+c;
 s2 := s2 + 'Подл'+c;
 s2 := s2 + 'Tp'+c;
 s2 := s2 + 'Up'+c;
 s2 := s2 + 'Dp'+c;
 s2 := s2 + 'Tb'+c;
 s2 := s2 + 'dx'+c;

 s2 := s2 + 'P,%'+c;
 s2 := s2 + 'Rx,мкм'+c;

 s2 := s2 + 'Rs,мкм (первый слой)'+c;
 s2 := s2 + 'Ds,мкм (первый слой)'+c;
 s2 := s2 + 'Hs,мкм (первый слой)'+c;
 s2 := s2 + 'Ds,о.е. (первый слой)'+c;
 s2 := s2 + 'Hs,о.е. (первый слой)'+c;
 s2 := s2 + 'Тс, К. (первый слой)'+c;
 s2 := s2 + 'Режим (первый слой)'+c;

 s2 := s2 + 'Rs,мкм (забыли подл)'+c;
 s2 := s2 + 'Ds,мкм (забыли подл)'+c;
 s2 := s2 + 'Hs,мкм (забыли подл)'+c;
 s2 := s2 + 'Ds,о.е. (забыли подл)'+c;
 s2 := s2 + 'Hs,о.е. (забыли подл)'+c;
 s2 := s2 + 'Тс, К. (забыли подл)'+c;
 s2 := s2 + 'Режим (забыли подл)'+c;


 s2 := s2 + 'Время,мин'+c;
 s2 := s2 + 'кол-во'+c;
 s2 := s2 + 'толщ'+c;
 s2 := s2 + 'Адгезия'+c;
 s2 := s2 + 'Адгез. коэф'+c;
 s2 := s2 + 'Адгезия коэф контакта'+c;
 s2 := s2 + 'крит'+c;
 s2 := s2 + LogRec.PorAdd_Head + c;


 writeln (F,s2);

 s2 := '';

 s2 := s2 + inttostr(LogRec.LayerN)+' слой' + c;

 s2 := s2 + LogRec.PartName + ' на '+ LogRec.BaseName + c;


 if LogRec.typ = 0 then
   s2 := s2 + 'Цил' + c
 else
   s2 := s2 + 'Глад' + c;


 if LogRec.formula = 0 then s2 := s2 + 'Металлы' + c
 else
   begin
     if LogRec.formula = 1 then s2 := s2 + 'Оксиды' + c
       else s2 := s2 + 'Кермет' + c
   end;

 if LogRec.polaya then s2 := s2 + 'Полая' + c
                  else s2 := s2 + 'Сплошная' + c;




 s2 := s2 + inttostr(LogRec.x) + 'x' + inttostr(LogRec.y) + c;

 s2 := s2 + inttostr(round(LogRec.Tp)) + c;
 s2 := s2 + inttostr(round(LogRec.Up)) + c;
 s2 := s2 + inttostr(round(LogRec.Dp)) + c;
 s2 := s2 + inttostr(round(LogRec.Tb)) + c;

 s2 := s2 + floattostr(round(LogRec.dx*10)/10) + c;

 s2 := s2 + FloatToStrF(LogRec.P, ffGeneral, 14, 10) + c;
 s2 := s2 + FloatToStrF(LogRec.R, ffGeneral, 14, 10) + c;

 s2 := s2 + inttostr(LogRec.Rs1) + c;
 s2 := s2 + floattostr(LogRec.DsDim1) + c;
 s2 := s2 + floattostr(LogRec.HsDim1) + c;
 s2 := s2 + floattostr(LogRec.DsNONDim1) + c;
 s2 := s2 + floattostr(LogRec.HsNONDim1) + c;
 s2 := s2 + floattostr(LogRec.Tc1) + c;
 s2 := s2 + inttostr(LogRec.REG1) + c;

 s2 := s2 + inttostr(LogRec.Rs2) + c;
 s2 := s2 + floattostr(LogRec.DsDim2) + c;
 s2 := s2 + floattostr(LogRec.HsDim2) + c;
 s2 := s2 + floattostr(LogRec.DsNONDim2) + c;
 s2 := s2 + floattostr(LogRec.HsNONDim2) + c;
 s2 := s2 + floattostr(LogRec.Tc2) + c;
 s2 := s2 + inttostr(LogRec.REG2) + c;

 s2 := s2 + inttostr(LogRec.Time) + c;
 s2 := s2 + inttostr(LogRec.NR) + c;
 s2 := s2 + inttostr(LogRec.HR) + c;

 s2 := s2 + FloatToStrF(LogRec.adg, ffGeneral, 5, 1) + c;

 s2 := s2 + FloatToStrF(LogRec.Adg1, ffGeneral, 5, 1) + c;
 s2 := s2 + FloatToStrF(LogRec.Adg2, ffGeneral, 5, 1) + c;


 if LogRec.Sk = 1 then
    s2 := s2 + inttostr(LogRec.N) + ' шт' + c
  else
    s2 := s2 + inttostr(LogRec.H) + ' мкм' + c;

 s2 := s2 + LogRec.PorAdd_Content + c;

 writeln (F,s2);

 closefile (f);
end;





procedure logt (m:integer; r:real);
var f:textfile;
begin
 if not iniVar.time_log then exit;

 AssignFile (f, 'time.csv');
 if FileExists('time.csv') then append(F) else rewrite(F);
 case m of
  0: write (F,'Файл хронометража времени');
  1: write (F,floattostr(r)+';');
  2: writeln (F,'');
 end;
 closefile (f);
end;

procedure logt2 (m:integer; s:string);
var f:textfile;
begin
 if not iniVar.time_log then exit;

 AssignFile (f, 'time.csv');
 if FileExists('time.csv') then append(F) else rewrite(F);
 case m of
  0: write (F,'Файл хронометража времени');
  1: write (F, s + ';');
  2: writeln (F,'');
 end;
 closefile (f);
end;


procedure log3 (s:string);
var f:textfile;
begin
 if not iniVar.random_log then exit;

 AssignFile (f, 'random.csv');
 if FileExists('random.csv') then append(F) else rewrite(F);
 writeln (F, s);
 closefile (f);
end;


procedure log4 (s:string);
var f:textfile;
begin
 if not iniVar.koord_log then exit;

 AssignFile (f, 'median.csv');
 if FileExists('median.csv') then append(F) else rewrite(F);
 writeln (F, s);
 closefile (f);
end;


procedure logk (n, x,y, Rs, Rp:integer);
var f:textfile;
    s:string;
const
      size = 1000;
      a1 = 10;
      a2 = 20;
      a3 = 40;
      a4 = 50;
      a5 = 100;

      b1 = size div a1;
      b2 = size div a2;
      b3 = size div a3;
      b4 = size div a4;
      b5 = size div a5;

begin
 if not iniVar.koord_log then exit;

 AssignFile (f, 'koordinati.csv');
 if FileExists('koordinati.csv') then append(F) else
   begin
      rewrite(F);
      s:='N;x;y;rs;rp;space;10;20;40;50;100';
      writeln (F, s);
   end;

 s:='';
 s:=s + inttostr(n)+';';
 s:=s + inttostr(x)+';';
 s:=s + inttostr(y)+';';
 s:=s + inttostr(rs)+';';
 s:=s + inttostr(rp)+';';
 s:=s + ';';



 s:=s + inttostr( (y div b1) * a1 + (x div b1) )+';';
 s:=s + inttostr( (y div b2) * a2 + (x div b2) )+';';
 s:=s + inttostr( (y div b3) * a3 + (x div b3) )+';';
 s:=s + inttostr( (y div b4) * a4 + (x div b4) )+';';
 s:=s + inttostr( (y div b5) * a5 + (x div b5) )+';';

 writeln (F, s);
 closefile (f);
end;






procedure logk2 (n, p, x,y :integer);
var f:textfile;
    s:string;
begin
 if not iniVar.koord_log then exit;

 AssignFile (f, 'koordinati2.csv');
 if FileExists('koordinati2.csv') then append(F) else
   begin
      rewrite(F);
      s:='N;p;x;y';
      writeln (F, s);
   end;

 s:='';
 s:=s + inttostr(n)+';';
 s:=s + inttostr(p)+';';
 s:=s + inttostr(x)+';';
 s:=s + inttostr(y)+'';
 //s:=s + ';';


 writeln (F, s);
 closefile (f);
end;



// ==============================================================================================

procedure dump (mode:integer);
var i,j,k:integer;
    f:textfile;
    s1:string;

    freq_HRT_dump, begin_time_dump, end_time_dump:int64;

begin

  QueryPerformanceFrequency(freq_HRT_dump);
  QueryPerformanceCounter(begin_time_dump);

  AssignFile (f, iniVar.csv_dump_file);
  if FileExists(iniVar.csv_dump_file) then append(F) else rewrite(F);

  case mode of
    1:
       begin
       // =========================== ВЫВОД ШАБЛОНА ОКРУЖНОСТЕЙ ========================
       writeln (f, 'shablon_array [1  '+inttostr(vrb.max_radius)+']');
       for j:=1 to vrb.max_radius do
         begin
           for i:=Low(shablon_array[j]) to High(shablon_array[j]) do
            begin
              s1 := format ('(%3d %3d) %3f;', [shablon_array [j,i].x , shablon_array [j,i].y, GetATgDeg (shablon_array [j,i].x , shablon_array [j,i].y)]  );
              write (f, s1);
            end;
           writeln (f, '');
         end;
       // ==============================================================================
       end;

    2: begin // <== разкаментировать как только введу переменные t11...
       // =================== ВЫВОД ЗНАЧЕНИЙ ДЛЯ РАЗДВИГАНИЯ ===========================
       writeln (f, '');
       writeln (f,'t11='+inttostr(vrb.t1)+'; t21='+inttostr(vrb.t2));
       writeln (f,'t12='+inttostr(vrb.t1)+'; t22='+inttostr(vrb.t2));

       s1 := format ('(%5f %5f %5f)-%1d;', [subfild [vrb.t1,vrb.t1].x, subfild [vrb.t1,vrb.t1].y, subfild [vrb.t1,vrb.t1].z, subfild [vrb.t1,vrb.t1].c]);
       write (f, s1);

       s1 := format ('(%5f %5f %5f)-%1d;', [subfild [vrb.t2,vrb.t2].x, subfild [vrb.t2,vrb.t2].y, subfild [vrb.t2,vrb.t2].z, subfild [vrb.t2,vrb.t2].c]);
       write (f, s1);
       // ==============================================================================
       //}
       end;

    3: begin
       // ===================== FILD ===================================================
       writeln (f, '');
       writeln (f, 'fild:');
       writeln (f, '');
       writeln (f, '');

       for j:=inivar.fild_size_y_d downto 0 do
         begin
           write (f, format ('%3d--> ;', [j])); // подсказка слева

           for i:=0 to inivar.fild_size_x_d do
             begin
               s1 := format ('(%5f %5f %5f)-%1d;', [fild [j,i].x, fild [j,i].y, fild [j,i].z, fild [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then    // ПЕЧАТЬ строки подсказки винизу
                      begin
                        write (f, '   --> ;');

                        for i:=0 to inivar.fild_size_x_d do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;

    4: begin
       // ======================== subfild =============================================
       writeln (f, '');
       writeln (f, 'subfild:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild_size_x do
             begin
               s1 := format ('(%5f %5f %5f)-%1d;', [subfild [j,i].x, subfild [j,i].y, subfild [j,i].z, subfild [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                       begin
                         write (f, '   --> ;');

                         for i:=0 to vrb.subfild_size_x do
                                                           begin
                                                             s1:=format ('%9d            ;', [i]);
                                                             write (f, s1);
                                                           end;
                         writeln (f,'');
                       end;
         end;
       // ==============================================================================
       //}
       end;
    5: begin
       // ===================== Печать subfild2 ========================================
       writeln (f, '');
       writeln (f, 'subfild2:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
   //          s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
   //          s1 := format ('%5f;', [subfild2 [j,i].z]);

   //          s1 := format ('spl=%5f K=%1d P=%1d Si.R=%3d Si.Z=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Pi, volna[j, i].Si.R, volna[j, i].Si.Zreal]);
               if volna[j, i].Si.R <> 0 then
                                          s1 := format ('spl=%5f K=%1d Si.R=%3d Si.Z=%3f Si.dh=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Si.R, volna[j, i].Si.Zreal, volna[j, i].Si.dh])
                                        else
                                          s1:='-; ';


               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;
    6: begin
       // ========================== Вывод oo: =========================================

       writeln (f, '');
       writeln (f, 'oo:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.oo_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.oo_size_x do
             begin
               s1 := format ('(%5f %5f %5f);', [oo [i,j][0], oo [i,j][1], oo [i,j][2]]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                         for i:=0 to vrb.oo_size_x do
                                                      begin
                                                        s1:=format ('%9d            ;', [i]);
                                                        write (f, s1);
                                                      end;
                         writeln (f,'');
                      end;

         end;  //}
       // ==============================================================================
       end;

    7: begin
       // ======================== Вывод subfild3 ======================================
       writeln (f, '');
       writeln (f, 'subfild3:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild3_size_y downto 0 do
         begin

           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild3_size_x do
             begin
               s1 := format ('(%5f %5f %5f)-%1d;', [subfild3 [j,i].x, subfild3 [j,i].y, subfild3 [j,i].z, subfild3 [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild3_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;
    8: begin
       // ======================== Вывод subfild4 ======================================
       writeln (f, '');
       writeln (f, 'subfild4:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild4_size_y downto 0 do
         begin

           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild4_size_x do
             begin
               s1 := format ('(%5f %5f %5f)-%1d;', [subfild4 [j,i].x, subfild4 [j,i].y, subfild4 [j,i].z, subfild4 [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild4_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;
    9: begin
       // ====================== Вывод UP ==============================================
       writeln (f, '');
       writeln (f, 'up:');
       writeln (f, '');
       writeln (f, '');


       for j:=inivar.fild_size_y_d downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to inivar.fild_size_x_d do
             begin
               s1:='';
               for k:=0 to cup[j,i] do
                 begin
                   s1 := s1 + format ('(%5f %5f->%5d) ', [up[k,j,i].s1, up[k,j,i].s2, up[k,j,i].tp]);
                 end;
               s1:=s1+';';
               write (f, s1);
             end;
           writeln (f,'');
         end;
       // ==============================================================================
       //}
       end;

    10: begin
       // ===================== FILD ===================================================
       writeln (f, '');
       writeln (f, 'fild:');
       writeln (f, '');
       writeln (f, '');

       for j:=inivar.fild_size_y_d downto 0 do
         begin
           write (f, format ('%3d--> ;', [j])); // подсказка слева

           for i:=0 to inivar.fild_size_x_d do
             begin
//               s1 := format ('(%5f %5f %5f)-%1d;', [fild [j,i].x, fild [j,i].y, fild [j,i].z, fild [j,i].c]);
               s1 := floattostr(fild [j,i].z)+';';
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then    // ПЕЧАТЬ строки подсказки винизу
                      begin
                        write (f, '   --> ;');

                        for i:=0 to inivar.fild_size_x_d do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;


    11: begin
       // ======================== Вывод subfild2 ======================================
       writeln (f, '');
       writeln (f, 'subfild2:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin

           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
               s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;


    12: begin
       // ====================== Вывод UP ==============================================
       writeln (f, '');
       writeln (f, 'up:');
       writeln (f, '');
       writeln (f, '');


       for j:=inivar.fild_size_y_d downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to inivar.fild_size_x_d do
             begin
               s1:='';
               for k:=0 to cup[j,i] do
                 begin
                   s1 := s1 + format ('(%5f-%5f) ', [up[k,j,i].s1, up[k,j,i].s2]);
                 end;
               s1:=s1+';';
               write (f, s1);
             end;
           writeln (f,'');
         end;
       // ==============================================================================
       //}
       end;

    13: begin
       // ===================== Печать volna Ki ========================================
       writeln (f, '');
       writeln (f, 'volna Ki:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
   //          s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
   //          s1 := format ('%5f;', [subfild2 [j,i].z]);

   //          s1 := format ('spl=%5f K=%1d P=%1d Si.R=%3d Si.Z=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Pi, volna[j, i].Si.R, volna[j, i].Si.Zreal]);
//               if volna[j, i].Si.R <> 0 then
               if true then
                                          s1 := format ('%1d; ', [volna[j, i].Ki])
                                        else
                                          s1:='-; ';


               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;


    14: begin
       // ===================== Печать верх  ========================================
       writeln (f, '');
       writeln (f, 'volna[j, i].Si.Zreal:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
   //          s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
   //          s1 := format ('%5f;', [subfild2 [j,i].z]);

   //          s1 := format ('spl=%5f K=%1d P=%1d Si.R=%3d Si.Z=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Pi, volna[j, i].Si.R, volna[j, i].Si.Zreal]);
               if volna[j, i].Si.R <> 0 then
                                          s1 := format ('%5f; ', [volna[j, i].Si.Zreal])
                                        else
                                          s1:='-; ';


               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;

    15: begin
       // ===================== Печать верх - низ  ========================================
       writeln (f, '');
       writeln (f, 'верх-низ:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
   //          s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
   //          s1 := format ('%5f;', [subfild2 [j,i].z]);

   //          s1 := format ('spl=%5f K=%1d P=%1d Si.R=%3d Si.Z=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Pi, volna[j, i].Si.R, volna[j, i].Si.Zreal]);
               if volna[j, i].Si.R <> 0 then
                                          s1 := format ('%5f; ', [volna[j, i].Si.Zreal-subfild2 [j,i].z])
                                        else
                                          s1:='-; ';


               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;

    16: begin
       // ===================== Печать subfild2 Z ========================================
       writeln (f, '');
       writeln (f, 'низ: subfild2 [j,i].z');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild2_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild2_size_x do
             begin
   //          s1 := format ('(%5f %5f %5f)-%1d;', [subfild2 [j,i].x, subfild2 [j,i].y, subfild2 [j,i].z, subfild2 [j,i].c]);
   //          s1 := format ('%5f;', [subfild2 [j,i].z]);

   //          s1 := format ('spl=%5f K=%1d P=%1d Si.R=%3d Si.Z=%3f; ', [subfild2 [j,i].z, volna[j, i].Ki, volna[j, i].Pi, volna[j, i].Si.R, volna[j, i].Si.Zreal]);
               if volna[j, i].Si.R <> 0 then
                                          s1 := format ('%5f; ', [subfild2 [j,i].z])
                                        else
                                          s1:='-; ';


               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild2_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
       // ==============================================================================
       //}
       end;


    17: begin
       // ======================== subfild =============================================
       writeln (f, '');
       writeln (f, 'subfild:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild_size_x do
             begin
               s1 := format ('%5f;', [subfild [j,i].z]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                       begin
                         write (f, '   --> ;');

                         for i:=0 to vrb.subfild_size_x do
                                                           begin
                                                             s1:=format ('%9d            ;', [i]);
                                                             write (f, s1);
                                                           end;
                         writeln (f,'');
                       end;
         end;
       end;
       // ==============================================================================
       //}


    18: begin
       // ======================== subfild3 Z =============================================
       writeln (f, '');
       writeln (f, 'subfild3 Z:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild3_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild3_size_x do
             begin
               s1 := format ('%5f;', [subfild3 [j,i].z]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                       begin
                         write (f, '   --> ;');

                         for i:=0 to vrb.subfild3_size_x do
                                                           begin
                                                             s1:=format ('%9d            ;', [i]);
                                                             write (f, s1);
                                                           end;
                         writeln (f,'');
                       end;
         end;
       end;
       // ==============================================================================
       //}

    19: begin
       // ======================== Вывод subfild4 ======================================
       writeln (f, '');
       writeln (f, 'subfild4.Z:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild4_size_y downto 0 do
         begin

           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild4_size_x do
             begin
               s1 := format ('%5f;', [subfild4 [j,i].z]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                      begin
                        write (f, '   --> ;');

                        for i:=0 to vrb.subfild4_size_x do
                          begin
                            s1:=format ('%9d            ;', [i]);
                            write (f, s1);
                          end;
                        writeln (f,'');
                      end;
         end;
          end;
       // ==============================================================================
       //}



    20: begin
       // ====================== Вывод UP ==============================================
       writeln (f, '');
       writeln (f, 'up (cup):');
       writeln (f, '');
       writeln (f, '');


       for j:=inivar.fild_size_y_d downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to inivar.fild_size_x_d do
             begin
               s1:='';
               k:=cup[j,i];
                 s1 := s1 + format ('(%5f-%5f) ', [up[k,j,i].s1, up[k,j,i].s2]);
                 s1:=s1+';';
               write (f, s1);
             end;
           writeln (f,'');
         end;
       // ==============================================================================
       //}
       end;



    21: begin
       // ====================== Вывод Рэндом ==============================================
//       writeln (f, '');
//       writeln (f, 'random_karta:');
//       writeln (f, '');
//       writeln (f, '');

       i:=0;
       for j:=0 to length(random_karta)-1 do
         begin
           if random_karta[j] then i:=i+1;
         end;
       write (f, inttostr(i)+';');

       for j:=0 to length(random_karta)-1 do
         begin
           if random_karta[j] then  write (f, '+;')
                              else  write (f, '.;');

         end;
       writeln (f,'');
       // ==============================================================================
       //}
       end;



    22: begin
       // ======================== subfild =============================================
       writeln (f, '');
       writeln (f, 'subfild:');
       writeln (f, '');
       writeln (f, '');

       for j:=vrb.subfild_size_y downto 0 do
         begin
           write (f, format ('%3d--> ;', [j]));

           for i:=0 to vrb.subfild_size_x do
             begin
               s1 := format ('%1d;', [subfild [j,i].c]);
               write (f, s1);
             end;
           writeln (f,'');

           if j = 0 then
                       begin
                         write (f, '   --> ;');

                         for i:=0 to vrb.subfild_size_x do
                                                           begin
                                                             s1:=format ('%9d            ;', [i]);
                                                             write (f, s1);
                                                           end;
                         writeln (f,'');
                       end;
         end;
       // ==============================================================================
       //}
       end;


    23: begin
       // ======================== src_array, vrb.csrc_array =============================================
       writeln (f, '');
       writeln (f, 'src_array:');
       writeln (f, '');
       writeln (f, '');

       for j:=0 to vrb.csrc_array-1 do
         begin
           write (f, format ('%3d--> ;', [j]));
           write (f, format ('%4f ;', [src_array[j].z]));
           writeln (f,'');
         end;
       // ==============================================================================
       //}
       end;


    24: begin
       // ======================== src_array, vrb.csrc_array =============================================
//       writeln (f, '');
//       writeln (f, 'src_array:');
//       writeln (f, '');
//       writeln (f, '');
       write (f, inttostr(maincaunter)+ ';');

       for j:=0 to vrb.csrc_array-1 do
         begin
           write (f, format ('%3d--> (%4f, %4f, %4f);', [j, src_array[j].x, src_array[j].y, src_array[j].z]));
         end;
       writeln (f,'');
       // ==============================================================================
       //}
       end;



  end; // case end

  CloseFile (f);
  QueryPerformanceCounter(end_time_dump);
  log( 'Создание дампа, режим: '+inttostr(mode)+ '. Время: ' + floattostr( trunc(((end_time_dump - begin_time_dump)/freq_HRT_dump)*10000000)/10            ) + ' мкс');
end;
