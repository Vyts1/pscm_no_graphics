 // ������ �������:
//==============================================================================
//  ������ ���� �������� � ��������� ���� ���� �� �����!
   vrb.max_subfild_size_x := iniVar.Ds_max_d + polya_left+polya_right;
   vrb.max_subfild_size_y := iniVar.Ds_max_d + polya_left+polya_right;

   vrb.max_subfild2_size_x := vrb.max_subfild_size_x+4;
   vrb.max_subfild2_size_y := vrb.max_subfild_size_y+4;

   vrb.max_subfild3_size_x := vrb.max_subfild_size_x+4;
   vrb.max_subfild3_size_y := vrb.max_subfild_size_y+4;

//==============================================================================

   ///* ����� ����� � ���������������� ����� */
   vrb.M2 := Max (vrb.max_subfild3_size_x, vrb.max_subfild3_size_y); // < ---- ��������
   vrb.N2  := ((vrb.M2-3)*iniVar.DIV2+1);

   vrb.M2x := vrb.M2;
   vrb.M2y := vrb.M2;

   vrb.div2x := iniVar.div2;
   vrb.div2y := iniVar.div2;

   vrb.N2x  := ((vrb.M2x-3)*vrb.DIV2x+5);
   vrb.N2y  := ((vrb.M2y-3)*vrb.DIV2y+5);

   vrb.max_subfild4_size_x := ((vrb.max_subfild3_size_x-3)*iniVar.DIV2+1);
   vrb.max_subfild4_size_y := ((vrb.max_subfild3_size_y-3)*iniVar.DIV2+1);


//==============================================================================
//==============================================================================
//                         ������ �������.
//==============================================================================
//==============================================================================
 try
   if iniVar.first_time = 1 then
     begin
      // ���� ������� ���, �� ������� ���� ������� ����� ������� ������
      log ('������� ������ up');
      //setlength (up, iniVar.sloev+1, iniVar.fild_size_y_d+1, iniVar.fild_size_x_d+1);
      setlength (up, iniVar.el_max+2, iniVar.fild_size_y_d+1, iniVar.fild_size_x_d+1);
      log ('��� ������ up ��������: ['+inttostr(iniVar.el_max+1)+'; '+ inttostr(iniVar.fild_size_y_d) +'; '+ inttostr(iniVar.fild_size_x_d) +'] ��������� ');

      log ('������� ������ fild');
      setlength (fild, iniVar.fild_size_y_d+1, iniVar.fild_size_x_d+1);

      log ('������� ������ cup');
      setlength (cup, iniVar.fild_size_y_d+1, iniVar.fild_size_x_d+1);
     end;


   log ('������� ������ p');
   setlength (p_v,vrb.M2x-1+1,vrb.M2y-1+1);

   log ('������� ������ oo');
   setlength (oo,vrb.N2x-1+1,vrb.N2y-1+1);

   log ('������� ������ subfild');
   setlength (subfild, vrb.max_subfild_size_y+1, vrb.max_subfild_size_x+1);
   log ('������� ������ subfild2');
   setlength (subfild2, vrb.max_subfild2_size_y+1, vrb.max_subfild2_size_x+1);
   log ('������� ������ subfild3');
   setlength (subfild3, vrb.max_subfild3_size_y+1, vrb.max_subfild3_size_x+1);
   log ('������� ������ subfild4');
   setlength (subfild4, vrb.max_subfild4_size_y+1, vrb.max_subfild4_size_x+1);

   log ('������� ������ volna');
   setlength (volna, vrb.max_subfild_size_y+1, vrb.max_subfild_size_x+1);

   log ('������� ������ hsrez');
   vrb.hsrezsize := iniVar.dpmax_d*2;
   setlength (hsrez, vrb.hsrezsize+1,vrb.hsrezsize+1);

   log ('������� ������ uknot');
   setlength (uknot,vrb.M2x+3+1);

   log ('������� ������ vknot');
   setlength (vknot,vrb.M2y+3+1);

   log ('������� ������ weight');
   setlength (weight,vrb.M2x-1+1,vrb.M2x-1+1);

   vrb.fild_x:=iniVar.fild_size_x_d;
   vrb.fild_y:=iniVar.fild_size_y_d;

{
   kol_9cheek_x := trunc ((iniVar.fild_size_x_d - 10 - 1.5*vrb.max_subfild_size_x) / (iniVar.dpmax_d*2*iniVar.koef_9cheek));
   kol_9cheek_y := trunc ((iniVar.fild_size_y_d - 10 - 1.5*vrb.max_subfild_size_y) / (iniVar.dpmax_d*2*iniVar.koef_9cheek));

   tochek_in_x := upround ( (iniVar.fild_size_x_d - 10 - 1.5*vrb.max_subfild_size_x) / kol_9cheek_x);
   tochek_in_y := upround ( (iniVar.fild_size_y_d - 10 - 1.5*vrb.max_subfild_size_y) / kol_9cheek_y);
 }
   tochek_in_x := round (iniVar.dpmax_d*2*iniVar.koef_9cheek);
   tochek_in_y := round (iniVar.dpmax_d*2*iniVar.koef_9cheek);

   //���� �� ������, ������ ������� ��������:
//   kol_9cheek_x := trunc ((iniVar.fild_size_x_d - 10 - 1.5*vrb.max_subfild_size_x) / tochek_in_x);
//   kol_9cheek_y := trunc ((iniVar.fild_size_y_d - 10 - 1.5*vrb.max_subfild_size_y) / tochek_in_y);


   kol_9cheek_x := trunc ((iniVar.fild_size_x_d - upround(vrb.max_subfild_size_x/2)*2) / tochek_in_x);
   kol_9cheek_y := trunc ((iniVar.fild_size_y_d - upround(vrb.max_subfild_size_y/2)*2) / tochek_in_y);


   log('������, ����� �������� �� Y='+inttostr(kol_9cheek_y)+' �� X='+inttostr(kol_9cheek_x));
   log('������, ������ ������� �� Y='+inttostr(tochek_in_y)+' �� X='+inttostr(tochek_in_x));

   log ('������� ������ random_karta');
   setlength (random_karta, kol_9cheek_x*kol_9cheek_y);
   random_karta_clear();




 except
//   showmessage ('������ ��� �������� ��������: '+SysErrorMessage(GetLastError));
   log ('������ ��� �������� ��������: '+SysErrorMessage(GetLastError));
   log ('��������� ����������');
   Application.Terminate;

 end;

