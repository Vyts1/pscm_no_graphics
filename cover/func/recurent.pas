// Рекурсивная функция2 (поиски по Ki). (для затекания только вниз)
function recurent3 (j,i:integer; n:integer):integer;
var i2,j2, t:integer;
    k, dlen:integer;

begin
 k:=0;

 if (n > 0) AND ((volna[j, i].Ki=0) OR (volna[j, i].Ki=1) OR (volna[j, i].Ki=5)) then
   begin
     // если текущая точка 0, 1, 5
     // то бадягу стоит разводить

     // Алгоритм основан на замене 5-ок, значения которых надо проверить на другие числа  

     for t:= 1 to 4 do  //перебор соседей
       begin
         case t of
          1:
            begin
              i2:=i-1;
              j2:=j;
            end;
          2:
            begin
              i2:=i+1;
              j2:=j;
            end;
          3:
            begin
              i2:=i;
              j2:=j-1;
            end;
          4:
            begin
              i2:=i;
              j2:=j+1;
            end;
         end;//case

         dlen := UpRound(sqrt ( sqr(i2-vrb.sub_crkl_center_x) + sqr(j2-vrb.sub_crkl_center_y) ));
         if (dlen<=vrb.crkl_Rs_1) then //если сосед внутри Rs, тогда...
            begin

              // Если текущая точка 0,1,2,3 (, но не 5) то просто копируем ее Z
              if (volna[j, i].Ki=2) OR (volna[j, i].Ki=0) OR (volna[j, i].Ki=1) OR (volna[j, i].Ki=3) then
                volna[j, i].Si.Zreal:=subfild2[j, i].z;

              // Если соседняя точка 0,1,2,3 (, но не 5) то просто копируем ее Z
              if (volna[j2, i2].Ki=2) OR (volna[j2, i2].Ki=0) OR (volna[j2, i2].Ki=1) OR (volna[j2, i2].Ki=3) then
                volna[j2, i2].Si.Zreal:=subfild2[j2, i2].z;

              // Если у нас точка 5, т.е. неизвестно можно ли ее заливать
              if (volna[j, i].Ki=5) then
                   begin // тек точка = 5

                     //смотрим кто у нее сосед
                     case volna[j2, i2].Ki of
                      2: // сосед = 2-болото
                         begin
                           // Есть три варианта
                           // I
                           if subfild2[j2, i2].z  >  volna[j, i].Si.Zreal  then
                              begin
                                //не катит
                                //1
                              end;

                           if subfild2[j2, i2].z  =  volna[j, i].Si.Zreal  then
                              begin
                                volna[j2, i2].Ki := 5;
                                volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                                k:=k+1+recurent3 (j2, i2, n-1);
                                //2
                              end;

                           if subfild2[j2, i2].z  <  volna[j, i].Si.Zreal  then
                              begin
                                volna[j2, i2].Ki := 5;
                                volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                                k:=k+1+recurent3 (j2, i2, n-1);
                                //3
                              end;
                         end;
                      5:
                         begin
                           // II
                           if volna[j, i].Si.Zreal  >  volna[j2, i2].Si.Zreal  then
                              begin
                                // обратное движение (подумать)
                                // 4
//                                log ('-----> 4');
                              end;

                           if volna[j, i].Si.Zreal  =  volna[j2, i2].Si.Zreal  then
                              begin
                                // пустое действие
                                // 5
//                                log ('-----> 5');
                              end;

                           if volna[j, i].Si.Zreal  <  volna[j2, i2].Si.Zreal  then
                              begin

                                 if (subfild2[j2, i2].z > volna[j, i].Si.Zreal) AND (volna[j2, i2].Si.Zreal > subfild2[j2, i2].z)  then
                                   begin
                                     volna[j2, i2].Si.Zreal := subfild2[j2, i2].z;
                                     // ниже опустить нельзя
                                     k:=k+1+recurent3 (j2, i2, n-1);
                                     // 6
//                                     log ('-----> 6');
                                   end;

                                 if (subfild2[j2, i2].z = volna[j, i].Si.Zreal) AND (volna[j2, i2].Si.Zreal > subfild2[j2, i2].z) then
                                   begin
                                     volna[j2, i2].Si.Zreal := subfild2[j2, i2].z;
                                     k:=k+1+recurent3 (j2, i2, n-1);
//                                     log ('-----> 7');
                                     // 7
                                   end;

                                 if subfild2[j2, i2].z < volna[j, i].Si.Zreal  then
                                   begin
                                     volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                                     k:=k+1+recurent3 (j2, i2, n-1);
//                                     log ('-----> 8');
                                     // 8
                                   end;


                              end;




                         end;//II
                     end;//case

                   end   // тек точка = 5
                                    else
                   begin // тек точка = 0,1
                     // III
                     volna[j, i].Si.Zreal := subfild2[j, i].z;

                     case volna[j2, i2].Ki of
                      2:
                         begin
                           if volna[j, i].Si.Zreal > subfild2[j2, i2].z then
                             begin
                               volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                               volna[j2, i2].Ki := 5;
                               k:=k+1+recurent3 (j2, i2, n-1);
//                               log ('-----> 9');
                               //9
                             end;

                           if volna[j, i].Si.Zreal = subfild2[j2, i2].z then
                             begin
                               volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                               volna[j2, i2].Ki := 5;
                               k:=k+1+recurent3 (j2, i2, n-1);
                               //10
//                               log ('-----> 10');
                             end;

                           if volna[j, i].Si.Zreal < subfild2[j2, i2].z then
                             begin
                               // не натекает.
                               //11
//                               log ('-----> 11');
                             end;


                         end;
                      5:
                         begin
                           // IV
                           if volna[j, i].Si.Zreal > volna[j2, i2].Si.Zreal then
                             begin
                               // нефига
                               //12
//                               log ('-----> 12');
                             end;

                           if volna[j, i].Si.Zreal = volna[j2, i2].Si.Zreal then
                             begin
                               // уже все сделано
                               //13
//                               log ('-----> 13');
                             end;

                           if volna[j, i].Si.Zreal < volna[j2, i2].Si.Zreal then
                             begin
                               if (volna[j, i].Si.Zreal = subfild2[j2, i2].z) AND (volna[j2, i2].Si.Zreal > subfild2[j2, i2].z) then
                                 begin
                                   volna[j2, i2].Si.Zreal := subfild2[j2, i2].z;
                                   k:=k+1+recurent3 (j2, i2, n-1);
                                   //14
//                                   log ('-----> 14');
                                 end;

                               if (volna[j, i].Si.Zreal < subfild2[j2, i2].z) AND (volna[j2, i2].Si.Zreal > subfild2[j2, i2].z) then
                                 begin
                                   volna[j2, i2].Si.Zreal := subfild2[j2, i2].z;
                                   k:=k+1+recurent3 (j2, i2, n-1);
//                                   log ('-----> 15');
                                   //15
                                 end;

                               if volna[j, i].Si.Zreal > subfild2[j2, i2].z then
                                 begin
                                   volna[j2, i2].Si.Zreal := volna[j, i].Si.Zreal;
                                   k:=k+1+recurent3 (j2, i2, n-1);
//                                   log ('-----> 16');
                                   //16
                                 end;
                             end;//if


                         end;//IV
                     end;  //case


                   end;  // тек точка = 0,1



            end; // если попадает в Rs
       end;//for
   end; //main if


 recurent3:=k;
end;




// Рекурсивная функция2 (поиски по Ki). (для незатекания в незатекаемые области)
function recurent2 (j,i,n:integer):integer;
var //i,j:integer;
    k, dlen:integer;

begin
 k:=0;
 //volna[j, i].Ki = 2

 if (n > 0) AND ((volna[j, i].Ki=0) OR (volna[j, i].Ki=1) OR (volna[j, i].Ki=4)) then
    begin // то бадягу стоит разводить

      dlen := UpRound(sqrt ( sqr(i-1-vrb.sub_crkl_center_x) + sqr(j-vrb.sub_crkl_center_y) ));
      if (dlen<=vrb.crkl_Rs_1) AND (volna[j, i-1].Ki=2) // добавить условие на l
         then
           begin
             volna[j, i-1].Ki:=4;
             k:=k+1+recurent2 (j, i-1, n-1);
           end;

      dlen := UpRound(sqrt ( sqr(i+1-vrb.sub_crkl_center_x) + sqr(j-vrb.sub_crkl_center_y) ));
      if (dlen<=vrb.crkl_Rs_1) AND (volna[j, i+1].Ki=2)
         then
           begin
             volna[j, i+1].Ki:=4;
             k:=k+1+recurent2 (j, i+1, n-1);
           end;


      dlen := UpRound(sqrt ( sqr(i-vrb.sub_crkl_center_x) + sqr(j-1-vrb.sub_crkl_center_y) ));
      if (dlen<=vrb.crkl_Rs_1) AND (volna[j-1, i].Ki=2) then
           begin
             volna[j-1, i].Ki:=4;
             k:=k+1+recurent2 (j-1, i, n-1);
           end;

      dlen := UpRound(sqrt ( sqr(i-vrb.sub_crkl_center_x) + sqr(j+1-vrb.sub_crkl_center_y) ));
      if (dlen<=vrb.crkl_Rs_1) AND (volna[j+1, i].Ki=2) then
           begin
             volna[j+1, i].Ki:=4;
             k:=k+1+recurent2 (j+1, i, n-1);
           end;

    end
  else
    begin // смысла разводить нету.
     if (volna[j, i].Ki=2) then showmessage ('Вот бля!');
    end;

 recurent2:=k;
end;


// Рекурсивная функция. (Это алгоритм поиска уровней )
function recurent (i,j,n:integer):integer;
var  k:integer;
begin
 k:=0;
 if (hsrez[i,j]<>0) AND (n > 0) then
 begin // то бадягу стоит разводить
 if (i-1>=0) AND (hsrez[i-1,j]<>0) AND (hsrez[i-1,j]<>hsrez[i,j]) then
                                     begin
                                      if hsrez[i-1,j] < hsrez[i,j] then
                                          begin
                                            {bitar[i,j]:=bitar[i-1,j];
                                            k:=k+1;}
                                          end
                                          else
                                          begin
                                            hsrez[i-1,j]:=hsrez[i,j];
                                            k:=k+1+recurent (i-1,j, n-1);

                                          end;
                                     end;

  if (i+1<=vrb.hsrezsize) AND (hsrez[i+1,j]<>0) AND (hsrez[i+1,j]<>hsrez[i,j]) then
                                     begin
                                      if hsrez[i+1,j] < hsrez[i,j] then
                                          begin
                                            {k:=k+1;
                                            bitar[i,j]:=bitar[i+1,j];}
                                          end
                                          else
                                          begin
                                            hsrez[i+1,j]:=hsrez[i,j];
                                            k:=k+1+recurent (i+1,j, n-1);
                                          end;
                                     end;


 if (j-1>=0) AND (hsrez[i,j-1]<>0) AND (hsrez[i,j-1]<>hsrez[i,j]) then
                                     begin
                                      if hsrez[i,j-1] < hsrez[i,j] then
                                          begin
                                            {k:=k+1;
                                            bitar[i,j]:=bitar[i,j-1];}
                                          end
                                          else
                                          begin
                                            hsrez[i,j-1]:=hsrez[i,j];
                                            k:=k+1+recurent (i,j-1,n-1);
                                          end;
                                     end;

 if (j+1<=vrb.hsrezsize) AND (hsrez[i,j+1]<>0) AND (hsrez[i,j+1]<>hsrez[i,j]) then
                                     begin
                                      if hsrez[i,j+1] < hsrez[i,j] then
                                          begin
                                            //k:=k+1;
                                            //bitar[i,j]:=bitar[i,j+1];
                                          end
                                          else
                                          begin
                                            hsrez[i,j+1]:=hsrez[i,j];
                                            k:=k+1+recurent (i,j+1, n-1);
                                          end;
                                     end;

 end;
 recurent:=k;
end;

//Поехали искать
procedure zalivka;
var i,j,k,t:integer;
begin
 t:=0;

 repeat
  t:=t+1;
  k:=0;

  for i := 0 to vrb.hsrezsize do
  begin
   for j := 0 to vrb.hsrezsize do
     begin
      if (hsrez[i,j]<>0) then
                         begin
                          k:=k+recurent (i, j, 25);
                         end;
     end;
  end;

 until (k=0);
// log('Было прогонов hsrez '+inttostr(t));
// ShowMessage(inttostr(t));
end;


