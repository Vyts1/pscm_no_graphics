procedure GenShablon(maxR:integer);
var tmpR,tmp45, i,j, i2:integer;// �� ����� ��������� �������
    tmpf, tmpfmin : Double;
    mini:integer;
    tmpshablon_point:shablon_point;
    a1,a2:integer;


begin
//==============================================================================
//                 ���������� ������
//==============================================================================

   try
   shablon_array:=nil;
//   vrb.max_radius:=iniVar.dpmax_d;
//   SetLength (shablon_array,  vrb.max_radius*2+1);  // ������ ������ (��� ��������� ��� �������� (Ds / 2) +1!)
   SetLength (shablon_array,  maxR+1);  // ������ ������ (��� ��������� ��� �������� (Ds / 2) +1!)
   log ('��� ������ ������� ��������: '+inttostr(maxR)+' ��������� ');

   except
//     ShowMessage('������ ������������� ������ ������� - �������');
     log ('������ ������������� ������ ������� - �������');
     Application.Terminate;
   end;
 // ������ tmpR=1

 put_to_shablon(0, 0, 0,  1); //3

 put_to_shablon(1, +1, 0, 3); //3
 put_to_shablon(1, -1, 0, 1); //1
 put_to_shablon(1, 0, +1, 2); //2
 put_to_shablon(1, 0, -1, 4); //4


 for tmpR:=2 to maxR do
  begin
   //tmpR:=5;
   tmp45 := trunc(  sqrt(  tmpR*tmpR/2  )    );
   // ��� �����

   put_to_shablon(tmpR, +tmpR, 0, 3);
   put_to_shablon(tmpR, -tmpR, 0, 1);
   put_to_shablon(tmpR, 0, +tmpR, 2);
   put_to_shablon(tmpR, 0, -tmpR, 4);


   // ��� �������� �����
   for i:=1 to tmp45-1 do
    begin
      j:= trunc(sqrt(tmpR*tmpR - (i*i))  );

      put_to_shablon(tmpR, +j, +i, 3);
      put_to_shablon(tmpR, -j, +i, 1);
      put_to_shablon(tmpR, -j, -i, 5);
      put_to_shablon(tmpR, +j, -i, 3);

      put_to_shablon(tmpR, +i, +j, 2);
      put_to_shablon(tmpR, -i, +j, 2);
      put_to_shablon(tmpR, -i, -j, 4);
      put_to_shablon(tmpR, +i, -j, 4);



      j:=j-1;
      if j*j + i*i > (tmpR-1)*(tmpR-1) then
                   begin
                      put_to_shablon(tmpR, +j, +i, 3);
                      put_to_shablon(tmpR, -j, +i, 1);
                      put_to_shablon(tmpR, -j, -i, 5);
                      put_to_shablon(tmpR, +j, -i, 3);

                      put_to_shablon(tmpR, +i, +j, 2);
                      put_to_shablon(tmpR, -i, +j, 2);
                      put_to_shablon(tmpR, -i, -j, 4);
                      put_to_shablon(tmpR, +i, -j, 4);
                   end;
    end;

     // ��� ������ ��� 45 � �����
     i:=tmp45;
     j:= trunc(sqrt(tmpR*tmpR - (i*i))  );

     // ��� ������������ ��� ��������������� ����� ���� ��������

     put_to_shablon(tmpR, +j, +i, 3);
     put_to_shablon(tmpR, -j, +i, 2);
     put_to_shablon(tmpR, +j, -i, 4);
     put_to_shablon(tmpR, -j, -i, 5);



     if i<j then  // true - ���� ���������������� else ���� �������������
                 begin
                  // ��������������� ����� �� ������������

                  put_to_shablon(tmpR, +i, +j, 2);
                  put_to_shablon(tmpR, -i, +j, 2);
                  put_to_shablon(tmpR, +i, -j, 4);
                  put_to_shablon(tmpR, -i, -j, 4);


                  j:=j-1; //j:=i=tmp45;
                  if j*j + i*i > (tmpR-1)*(tmpR-1) then
                    begin
                          // ������������
                      put_to_shablon(tmpR, +j, +i, 2);
                      put_to_shablon(tmpR, -j, +i, 2);
                      put_to_shablon(tmpR, +j, -i, 4);
                      put_to_shablon(tmpR, -j, -i, 4);

                    end;
                 end;



 end; // tmpR


 //dump (1);

   for j:=0 to maxR do
   begin

      a1 := Low(shablon_array[j]);
      a2 := High(shablon_array[j]);

      if (a2 - a1 > 0) then
        begin

           for i2 := a1 to a2-1 do
             begin
               mini := i2;
               tmpfmin := GetATgDeg (shablon_array[j, mini].x, shablon_array[j, mini].y);

               for i:=i2+1 to a2 do
                  begin
                    tmpf := GetATgDeg (shablon_array[j, i].x, shablon_array[j, i].y);

                    if tmpfmin > tmpf  then
                                         begin
                                           mini := i;
                                           tmpfmin := tmpf;
                                         end;

                  end;

               tmpshablon_point := shablon_array[j, i2];
               shablon_array[j, i2] := shablon_array[j, mini];
               shablon_array[j, mini] := tmpshablon_point;
             end;


        end;
   end;

 //dump (1);

 //*****************************
   try
   src_array:=nil;
   SetLength (src_array,  High(shablon_array[maxR])-Low(shablon_array[maxR])+2);  // ������ ��� �������� ������. ���������� +1 ��� ���������� ������
   vrb.csrc_array := 0;
   log ('��� ������ ������ ��������: '+inttostr(High(shablon_array[maxR])-Low(shablon_array[maxR])+2)+' ��������� ');

   except
     log ('������ ������������� ������ ������');
     Application.Terminate;
   end;

end;
