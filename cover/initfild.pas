//==============================================================================
//                ��������� ����. (�������� �����������)
//                     ���� ������ �������
//==============================================================================
//==============================================================================
  for j:=0 to vrb.fild_y do
   for i:=0 to vrb.fild_x do
    begin
      fild [j,i].x := mstx(i);
      fild [j,i].y := mstx(j);
      cup [j,i]:=-1;

      cv:=1;


      case iniVar.modefild of
       1: // ������������� �����
          begin
//            log ('����������� �������� ��������: ����� ������������');

            if ((i mod (inivar.a1d + inivar.a4d)) < inivar.a1d) AND
               ((j mod (inivar.a2d + inivar.a5d)) < inivar.a2d)
               then
                 begin
                   fild [j,i].z := zerolevel + iniVar.a3;
                 end
               else
                 begin
                   fild [j,i].z := zerolevel;
                 end;

          end;


       2: // �����
          begin
//            log ('����������� �������� ��������: ����� �����');

//------------ �����
            fild [j,i].z := zerolevel; // ���� ����� ������� 0


//            if  (sqrt ( sqr(600-i) + sqr(800-j) ) <= 300)
//               then
//                  begin
//                    fild [j,i].z := fild [j,i].z + ((300 - (sqrt ( sqr(600-i) + sqr(800-j) )) * 300)/300);
//                  end;
            // 600 - x -> 450  inivar.a1d
            // 800 - y -> 480  inivar.a2d
            // 300 - r -> 300  inivar.a4d

            if  (sqrt ( sqr(inivar.a1d-i) + sqr(inivar.a2d-j) ) <= inivar.a4d)
               then
                  begin
                    fild [j,i].z := fild [j,i].z +  sqrt (inivar.a4d*inivar.a4d - ( sqr(inivar.a1d-i) + sqr(inivar.a2d-j) ));

                  end;
//------------ �����

          end;

       3:  // ��������
          begin
//            log ('����������� �������� ��������: ����� ��������');
            tmpint := i mod ( inivar.a1d + 2*inivar.a2d - 1 );

            if tmpint >= inivar.a1d then
                                      begin
                                        tmpint := tmpint - inivar.a1d;

                                        if tmpint >= inivar.a2d then
                                               begin
                                                 tmpint := tmpint - (inivar.a2d - 1);
                                                 fild [j,i].z := zerolevel + iniVar.a3 * ( tmpint / (inivar.a2d - 1));
                                               end
                                                                else
                                               begin
                                                 fild [j,i].z := zerolevel + iniVar.a3 * ((inivar.a2d - 1 - tmpint) / (inivar.a2d - 1));
                                               end;
                                      end
                                    else
                                      begin
                                        fild [j,i].z := zerolevel + iniVar.a3;
                                      end;




          end;

       4:   //��������� ��.
          begin
//            log ('����������� �������� ��������: ����� ��������� ���������');

            if (inivar.a1d <= i) AND (i <= inivar.a1d + inivar.a2d-1) then
              begin
                tmpint := i - inivar.a1d;
                fild [j,i].z := zerolevel + iniVar.a3 * ((inivar.a2d-1)-tmpint) / (inivar.a2d-1);
              end
            else
              begin
                fild [j,i].z := zerolevel;
              end;
          end;

       5:   //������� ����
          begin
//            log ('����������� �������� ��������: ����� �������� ����');

            tmpint1 := (i mod ( inivar.a1d ));
            tmpint2 := (j mod ( inivar.a1d ));
            rr1:= tmpint1 + 0.5;
            rr2:= tmpint2 + 0.5;

            fild [j,i].z := zerolevel;

            rr :=   sqrt(  sqr(rr1 - (inivar.a1d/2))   +    sqr(rr2 - (inivar.a1d/2))  );

            if (rr <= inivar.a1d/2) then
              begin
                fild [j,i].z := zerolevel + sqrt ( sqr(inivar.a1d/2) - rr*rr );
              end;

          end;

       6:   //������� ������
          begin
//            log ('����������� �������� ��������: ����� �������� �����');

            tmpint1 := (i mod ( inivar.a1d )) ;
            tmpint2 := (j mod ( inivar.a1d )) ;
            rr1:= tmpint1 + 0;
            rr2:= tmpint2 + 0;


            fild [j,i].z := zerolevel;

            rr :=   sqrt(  sqr(rr1 - (inivar.a1d/2))   +    sqr(rr2 - (inivar.a1d/2))  );

            if (rr <= inivar.a1d/2) then
              begin
                fild [j,i].z := zerolevel + (iniVar.a3 * rr)/(inivar.a1d/2);
              end;

          end;


       7:   //�����
          begin
//            log ('����������� �������� ��������: ����� �����');
            if  (inivar.a1d-(inivar.a2d-1) <= i) AND (i <= inivar.a1d+(inivar.a2d-1))
                               then fild [j,i].z := zerolevel + iniVar.a3
                               else fild [j,i].z := zerolevel;
          end;

       8:   //������� ����
          begin

//            log ('����������� �������� ��������: ����� ������� ����');

            tmpint1 := (i mod ( inivar.a1d + 2*inivar.a2d+1 ));
            tmpint2 := (j mod ( inivar.a1d + 2*inivar.a2d+1 ));

            if (tmpint1 < inivar.a1d) OR (tmpint2 < inivar.a1d) then
              begin
                fild [j,i].z := zerolevel + iniVar.a3;
              end
            else
              begin
                tmpint1 := tmpint1 - inivar.a1d;
                tmpint2 := tmpint2 - inivar.a1d;

                for tmpint:=0 to inivar.a2d do
                  begin
                    if (((tmpint1 = inivar.a2d-tmpint) OR (tmpint1 = inivar.a2d+tmpint)) AND ( (inivar.a2d-tmpint <= tmpint2) AND (tmpint2 <= inivar.a2d+tmpint))) OR
                       (((tmpint2 = inivar.a2d-tmpint) OR (tmpint2 = inivar.a2d+tmpint)) AND ( (inivar.a2d-tmpint <= tmpint1) AND (tmpint1 <= inivar.a2d+tmpint)))
                    then
                      break;
                  end;

                fild [j,i].z := zerolevel+tmpint*(iniVar.a3) / inivar.a2d;

              end;


          end;


       9:   // ���������
          begin
//            log ('����������� �������� ��������: ����� ���������');

            tmpint1 := (i mod ( inivar.a1d + 2*inivar.a2d+1 ));
            tmpint2 := (j mod ( inivar.a1d + 2*inivar.a2d+1 ));

            if (tmpint1 < inivar.a1d) OR (tmpint2 < inivar.a1d) then
              begin
                fild [j,i].z := zerolevel ;
              end
            else
              begin
                tmpint1 := tmpint1 - inivar.a1d;
                tmpint2 := tmpint2 - inivar.a1d;

                for tmpint:=0 to inivar.a2d do
                  begin
                    if (((tmpint1 = inivar.a2d-tmpint) OR (tmpint1 = inivar.a2d+tmpint)) AND ( (inivar.a2d-tmpint <= tmpint2) AND (tmpint2 <= inivar.a2d+tmpint))) OR
                       (((tmpint2 = inivar.a2d-tmpint) OR (tmpint2 = inivar.a2d+tmpint)) AND ( (inivar.a2d-tmpint <= tmpint1) AND (tmpint1 <= inivar.a2d+tmpint)))
                    then
                      break;
                  end;

                fild [j,i].z := zerolevel+(inivar.a2d-tmpint)*(iniVar.a3) / inivar.a2d;

              end;


          end;


       10:   // ������
          begin
//            log ('����������� �������� ��������: ����� ������');

            rr :=   sqrt(  sqr(i - inivar.a1d)   +    sqr(j - inivar.a2d)  );

            if (rr < inivar.a4d  ) OR (inivar.a4d+inivar.a5d < rr) then
              begin
                fild [j,i].z := zerolevel ;
              end
            else
              begin
                fild [j,i].z := zerolevel + iniVar.a3;
              end;


          end;


       11:   // ����
          begin
//            log ('����������� �������� ��������: ����� ����');

            if ((inivar.a1d <= i) AND (i < inivar.a1d+inivar.a4d)) AND
               ((inivar.a2d <= j) AND (j < inivar.a2d+inivar.a5d))
            then
                fild [j,i].z := zerolevel
            else
                fild [j,i].z := zerolevel + iniVar.a3;

          end;

       12:   // ������ �����
          begin
//            log ('����������� �������� ��������: ����� ������ �����');

            inivar.a1d:=300;

            iniVar.a3:=150;

            inivar.a4d:=30;

            fild [j,i].z := 50;

            rr :=   sqrt(  sqr( i - 500 )   +    sqr( j - 500 )  );

            if (rr <= inivar.a1d) then
              begin
                fild [j,i].z := 50 + (iniVar.a3 * (inivar.a1d-rr))/(inivar.a1d);
              end;

            rr1 := iniVar.a3 * (inivar.a1d - inivar.a4d) / inivar.a1d;

            if (rr <= inivar.a4d) then
              begin
                fild [j,i].z := 50 + rr1;
              end;

            // x 200 500
            // y 400 600
            inivar.a1d:=537;
            inivar.a4d:=510;

            inivar.a2d:=570;
            inivar.a5d:=470;


            if (inivar.a1d<=i) AND (i<=inivar.a2d) then
             begin

               tmpint1 := round ((i-inivar.a1d)*(inivar.a5d-inivar.a4d)/(inivar.a2d-inivar.a1d));

               if (inivar.a4d+tmpint1=j) OR (inivar.a4d+tmpint1+1=j) OR (inivar.a4d+tmpint1+2=j) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;


            if (inivar.a4d<=j) AND (j<=inivar.a5d) then
             begin
               tmpint1 := round ( (j-inivar.a4d)*(inivar.a2d-inivar.a1d)  /(inivar.a5d-inivar.a4d)  );

               if (inivar.a1d+tmpint1=i) OR (inivar.a1d+tmpint1+1=i) OR (inivar.a1d+tmpint1+2=i) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;


            inivar.a1d:=300;
            inivar.a4d:=800;

            inivar.a2d:=580;
            inivar.a5d:=470;


            if (inivar.a1d<=i) AND (i<=inivar.a2d) then
             begin

               tmpint1 := round ((i-inivar.a1d)*(inivar.a5d-inivar.a4d)/(inivar.a2d-inivar.a1d));

               if (inivar.a4d+tmpint1=j) OR (inivar.a4d+tmpint1+1=j) OR (inivar.a4d+tmpint1+2=j) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;


            if (inivar.a4d<=j) AND (j<=inivar.a5d) then
             begin
               tmpint1 := round ( (j-inivar.a4d)*(inivar.a2d-inivar.a1d)  /(inivar.a5d-inivar.a4d)  );

               if (inivar.a1d+tmpint1=i) OR (inivar.a1d+tmpint1+1=i) OR (inivar.a1d+tmpint1+2=i) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;


            inivar.a1d:=550;
            inivar.a4d:=370;

            inivar.a2d:=570;
            inivar.a5d:=480;


            if (inivar.a1d<=i) AND (i<=inivar.a2d) then
             begin

               tmpint1 := round ((i-inivar.a1d)*(inivar.a5d-inivar.a4d)/(inivar.a2d-inivar.a1d));

               if (inivar.a4d+tmpint1=j) OR (inivar.a4d+tmpint1+1=j) OR (inivar.a4d+tmpint1+2=j) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;


            if (inivar.a4d<=j) AND (j<=inivar.a5d) then
             begin
               tmpint1 := round ( (j-inivar.a4d)*(inivar.a2d-inivar.a1d)  /(inivar.a5d-inivar.a4d)  );

               if (inivar.a1d+tmpint1=i) OR (inivar.a1d+tmpint1+1=i) OR (inivar.a1d+tmpint1+2=i) then
                                                                  fild [j,i].z:=fild [j,i].z+20;
             end;



//            if (572 <= i) AND (i <= 580) AND
//               (450 <= j) AND (j <= 471)
//            then
//              fild [j,i].z:=fild [j,i].z-5;

          end;

       13:   // ������s
          begin
//            log ('����������� �������� ��������: ����� �������');

            rr :=   sqrt(  sqr(i - 500)   +    sqr(j - 500)  );

            if   (( 5  <= rr )  AND   ( rr <= 6 )) OR
                 (( 35  <= rr )  AND   ( rr <= 37 ))
            then
              begin
                fild [j,i].z := zerolevel + 10;
                cv:=4;
              end
            else
              begin
                fild [j,i].z := zerolevel ;

              end;


          end;



       14:   // ��������� �������� �����
          begin
            fild [j,i].z := zerolevel + GetPiramH (i,j, iniVar.a1, iniVar.a2, iniVar.a3, iniVar.a4, iniVar.a5);
//            fild [j,i].z := zerolevel + GetPiramH (i,j, iniVar.a1, iniVar.a3, iniVar.a2, iniVar.a4, iniVar.a5);
           end;



       15:   // ������ �������� ����� ��������� ���������
          begin
            fild [j,i].z := zerolevel + GetKonusH_norm (i,j, iniVar.a1, iniVar.a2, iniVar.a3);
          end;

       16:   // ������ �������� ����� ������� �������
          begin
            fild [j,i].z := zerolevel + GetKonusH_plotn (i,j, iniVar.a1, iniVar.a2, iniVar.a3);
          end;

       17:   // ������ ������������  ���� ������� ���� ����
          begin
            fild [j,i].z := zerolevel + iniVar.a3*5;
          end;


      else
          begin
            //�� � ���� ��� �������������, ����� ������ zerolevel
            fild [j,i].z := zerolevel; // ���� ����� ������� 0


          end;
      end;





end;
// }

      log('zerolevel:' + floattostr(zerolevel));
      //dump(10);



      //iniVar.a1- ������
      //iniVar.a2- ��������� ���������
      //iniVar.a3- ������

      //iniVar.a4- ������� ������ �� ���� �� �� ����� ����
      if iniVar.modefild = 17 then
        begin
          log('modefild = 17');

          tmpint := round (iniVar.a2);
          //log('iniVar.a2:' + inttostr(tmpint));

          tmpint := tmpint * tmpint;
          tm3r := round (iniVar.a1);

          //log('tmpint:' + inttostr(tmpint));
          //log('tm3r:' + inttostr(tm3r));

          tmp_yacheika_x := vrb.fild_x / iniVar.a2;
          tmp_yacheika_y := vrb.fild_y / iniVar.a2;

          for i:=0 to tmpint*round(iniVar.a4)-1 do
            begin
              //�������� �������
              tmp_kv_num := random (tmpint);

              tm2x := round((tmp_kv_num div round(iniVar.a2))*(tmp_yacheika_x));
              tm2y := round((tmp_kv_num mod round(iniVar.a2))*(tmp_yacheika_y));





              tm1y := random (round (tmp_yacheika_y));
              tm1x := random (round (tmp_yacheika_x));

              //log(inttostr(i) + '  (�������)tm2x:' + inttostr(tm2x));
              //log(inttostr(i) + '  (�������)tm2y:' + inttostr(tm2y));

              //log(inttostr(i) + '  tm1y:' + inttostr(tm1y));
              //log(inttostr(i) + '  tm1x:' + inttostr(tm1x));


              {
              //------------------------------------------------------------------------------------
              // ��� � �� ��� �����
              min_point := +100000;
              for i2 := tm2x + tm1x - tm3r - 1 to tm2x + tm1x + tm3r + 1 do
                for j2 := tm2y + tm1y - tm3r - 1 to tm2y + tm1y + tm3r + 1 do
                  begin
                    if (i2 >= 0) and (i2 < vrb.fild_x) and  //���� ��� �� ����� �� �������
                       (j2 >= 0) and (j2 < vrb.fild_y)
                    then
                      begin
                        if UpRound(sqrt (  sqr(i2-(tm2x + tm1x))  + sqr(j2-(tm2y + tm1y)) )) = iniVar.a1-1 then
                          begin
                            if min_point > fild [j2,i2].z then min_point := fild [j2,i2].z;
                          end;
                      end;
                  end;

              //�� ������
              if min_point = 100000 then
                begin
                  showmessage ('������� ��� ��� ��� ���');
                  continue;
                end;

              for i2 := tm2x + tm1x - tm3r to tm2x + tm1x + tm3r do
                for j2 := tm2y + tm1y - tm3r to tm2y + tm1y + tm3r do
                  begin
                    if (i2 >= 0) and (i2 < vrb.fild_x) and  //���� ��� �� ����� �� �������
                       (j2 >= 0) and (j2 < vrb.fild_y)
                    then
                      begin
                        rr := sqrt (  sqr(i2-(tm2x + tm1x))  + sqr(j2-(tm2y + tm1y)) );
                        if rr <= iniVar.a1 then
                          begin
                            fild [j2,i2].z :=  min_point - (iniVar.a3-iniVar.a3 * rr / iniVar.a1);
                          end;
                      end;
                  end;

              //------------------------------------------------------------------------------------}




              //------------------------------------------------------------------------------------
              // ������� ������� ����������
              //------------------------------------------------------------------------------------
              //������ �� ����� ���������

              min_point := -100000;
              for i2 := tm2x + tm1x - tm3r to tm2x + tm1x + tm3r do
                for j2 := tm2y + tm1y - tm3r to tm2y + tm1y + tm3r do
                  begin
                    if (i2 >= 0) and (i2 < vrb.fild_x) and  //���� ��� �� ����� �� �������
                       (j2 >= 0) and (j2 < vrb.fild_y)
                    then
                      begin
                        if UpRound(sqrt (  sqr(i2-(tm2x + tm1x))  + sqr(j2-(tm2y + tm1y)) )) = iniVar.a1-1 then
                          begin
                            if min_point < fild [j2,i2].z then min_point := fild [j2,i2].z;
                          end;
                      end;
                  end;

              //�� ������
              if min_point = -100000 then
                begin
                  showmessage ('������� ��� ��� ��� ���');
                  continue;
                end;



              for i2 := tm2x + tm1x - tm3r to tm2x + tm1x + tm3r do
                for j2 := tm2y + tm1y - tm3r to tm2y + tm1y + tm3r do
                  begin
                    if (i2 >= 0) and (i2 < vrb.fild_x) and  //���� ��� �� ����� �� �������
                       (j2 >= 0) and (j2 < vrb.fild_y)
                    then
                      begin
                        rr := sqrt (  sqr(i2-(tm2x + tm1x))  + sqr(j2-(tm2y + tm1y)) );
                        if rr <= iniVar.a1 then
                          begin

                            if fild [j2,i2].z > min_point - (iniVar.a3 - (iniVar.a3*rr/iniVar.a1)) then
                               fild [j2,i2].z := min_point -(iniVar.a3 - (iniVar.a3*rr/iniVar.a1));

                          end;
                      end;
                  end;
              //------------------------------------------------------------------------------------}



              //------------------------------------------------------------------------------------
              // ��� ������� � ����������
              //------------------------------------------------------------------------------------
              {for i2 := tm2x + tm1x - tm3r to tm2x + tm1x + tm3r do
                for j2 := tm2y + tm1y - tm3r to tm2y + tm1y + tm3r do
                  begin
                    if (i2 >= 0) and (i2 < vrb.fild_x) and  //���� ��� �� ����� �� �������
                       (j2 >= 0) and (j2 < vrb.fild_y)
                    then
                      begin
                        rr := sqrt (  sqr(i2-(tm2x + tm1x))  + sqr(j2-(tm2y + tm1y)) );
                        if rr <= iniVar.a1 then
                          begin
                            fild [j2,i2].z := fild [j2,i2].z - (iniVar.a3-iniVar.a3*rr/iniVar.a1);
                          end;
                      end;
                  end;
               //}
              //------------------------------------------------------------------------------------}
            end;

          {for j:=0 to vrb.fild_y do
            for i:=0 to vrb.fild_x do
              begin
                fild [j,i].x := mstx(i);
                fild [j,i].y := mstx(j);
              end;
           }


        end;



  //dump(10);

  for j:=0 to vrb.fild_y do
   for i:=0 to vrb.fild_x do
    begin


      // ���������� ����
      if iniVar.noise > 0 then
        begin
          if random(2) = 0 then fild [j,i].z := fild [j,i].z + random(round(iniVar.noise*1E6))/1E6
                           else fild [j,i].z := fild [j,i].z - random(round(iniVar.noise*1E6))/1E6;
        end;






      if fild [j,i].z < zerolevel then fild [j,i].z := zerolevel;

      fild [j,i].c := 2;    //2 ���� - ��������
      fild [j,i].sloy := 0; //0`�� ���� - ��������
      // �� 0 �� zerolevel, ���� ��������� 1 (��������),  0 - ����� ���� .
      dropkub_init (j,i,      1, 0,       0, fild [j,i].z); //1 - ���� ��������



    end;// for`s end

  //dump(10);

  vrb.stat_h := 0;
  vrb.stat_x:=mstx(vrb.fild_x);
  vrb.stat_y:=mstx(vrb.fild_y);
  newstath;
