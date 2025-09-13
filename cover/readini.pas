procedure ReadINI();
var r, r2:real;
    tempmat: Tmaterial;
begin
 // ������� ������ �� INI �����

 SetFile('config.ini');
 //---------------------------------------------------------------------------------------
 logfile := ReadIniData('system', 'logfile', 'program.log');

 iniVar.file_rez := ReadIniData('system', 'fileresult', 'rez');
 iniVar.csv_dump_file:=ReadIniData('system', 'csv_dump', 'file.csv');

 if ReadIniDataInt('system', 'is_col', 1) = 1 then
                                                  begin
                                                    log ('����������� �� ���������� �������');
                                                    iniVar.is_col := true;
                                                  end
                                                else
                                                  begin
                                                    iniVar.is_col := false;
                                                    log ('����������� �� ������� ��������');
                                                  end;
 //---------------------------------------------------------------------------------------

 iniVar.k3mode := ReadIniDataInt('system', 'k3mode', 0);



 //---------------------------------------------------------------------------------------
 SystemVar.sx:=ReadIniDataInt ('3d','screensizex_sx', 2);
 SystemVar.sy:=ReadIniDataInt ('3d','screensizex_sy', 2);
 SystemVar.sz:=ReadIniDataInt ('3d','screensizex_sz', 2);
 //---------------------------------------------------------------------------------------


 //---------------------------------------------------------------------------------------
 // ������������� ���������� � ���������
 iniVar.temp_base := (ReadIniDataReal ('process','temp_base', 300));

 iniVar.temp_patic_min := (ReadIniDataReal ('process','temp_patic_min', 1500));
 iniVar.temp_patic_max := (ReadIniDataReal ('process','temp_patic_max', 1500));

 iniVar.velos_min := (ReadIniDataReal ('process','velos_min', 100));
 iniVar.velos_max := (ReadIniDataReal ('process','velos_max', 100));

 if iniVar.temp_patic_min > iniVar.temp_patic_max then
         begin
           r:=iniVar.temp_patic_min;
           iniVar.temp_patic_min:=iniVar.temp_patic_max;
           iniVar.temp_patic_max:=r;
           log ('!!!! �������� temp_patic_max ������ ��� temp_patic_min.  �� �������� �� �������.');
         end;

 if iniVar.velos_min > iniVar.velos_max then
         begin
           r:=iniVar.velos_min;
           iniVar.velos_min:=iniVar.velos_max;
           iniVar.velos_max:=r;
           log ('!!!! �������� velos_max ������ ��� velos_min.  �� �������� �� �������.');
         end;

 log ('Tb='+floattostr(iniVar.temp_base)+' �');

 log ('Tp_min='+floattostr(iniVar.temp_patic_min)+' �');
 log ('Tp_max='+floattostr(iniVar.temp_patic_max)+' �');

 log ('up_min='+floattostr(iniVar.velos_min)+' �/�');
 log ('up_max='+floattostr(iniVar.velos_max)+' �/�');


 //---------------------------------------------------------------------------------------

 // ��� ������� ���������� �� ��.

 case ReadIniDataInt ('process','partmat', 2) of
   {$i 'cover\case_material.pas'}
 end;
 iniVar.partmat:=tempmat;


 case ReadIniDataInt ('substrate','basemat', 1) of
   {$i 'cover\case_material.pas'}
 end;
 iniVar.basemat:=tempmat;




{
 iniVar.partmat.m_nId:=4;
 iniVar.partmat.m_Material:='Ni';
 iniVar.partmat.m_ROms:=8902;
 iniVar.partmat.m_ROml:=7790;
 iniVar.partmat.m_CPms:=430;
 iniVar.partmat.m_CPml:=640;
 iniVar.partmat.m_Lms:=67;
 iniVar.partmat.m_Lml:=72;
 iniVar.partmat.m_Tm:=1726;
 iniVar.partmat.m_TBoil:=3653;
 iniVar.partmat.m_Lm:=303000;
 iniVar.partmat.m_MUml:=0;
 iniVar.partmat.m_SIGml:=0;
 iniVar.partmat.m_LBoil:=5900000;
 iniVar.partmat.m_AW:=58.7;
 iniVar.partmat.Ac:=0.259;


 iniVar.basemat.m_nId:=3;
 iniVar.basemat.m_Material:='Cu';
 iniVar.basemat.m_ROms:=8500;
 iniVar.basemat.m_ROml:=8000;
 iniVar.basemat.m_CPms:=490;
 iniVar.basemat.m_CPml:=495;
 iniVar.basemat.m_Lms:=244;
 iniVar.basemat.m_Lml:=166;
 iniVar.basemat.m_Tm:=1356;
 iniVar.basemat.m_TBoil:=2868;
 iniVar.basemat.m_Lm:=206150;
 iniVar.basemat.m_MUml:=0.0045;
 iniVar.basemat.m_SIGml:=1.28;
 iniVar.basemat.m_LBoil:=4800000;
 iniVar.basemat.m_AW:=63.5;
 iniVar.basemat.Ac:=0.259;
 }


 log ('���������: '+iniVar.partmat.m_Material+' ������� �� '+iniVar.basemat.m_Material+' ��������');


 //---------------------------------------------------------------------------------------
 iniVar.div2 := ReadIniDataInt('spline', 'div', 1);
 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.tochekvdiskrete:=ReadIniDataInt ('slise','tochekvdiskrete', 2);
 iniVar.tochekvdiskrete2:=ReadIniDataInt ('slise','tochekvdiskrete2', 2);
 iniVar.tochekvdiskretesvg:=ReadIniDataReal ('slise','tochekvdiskretesvg', 10);

 iniVar.koef_provisaniya:=ReadIniDataReal ('system','koef_provisaniya', 1);
 log ('����. ���������� = '+floattostr(iniVar.koef_provisaniya));

 iniVar.koef_natek:=ReadIniDataReal ('system','koef_natek', 1);
 log ('����. ��������� = '+floattostr(iniVar.koef_natek));
 //---------------------------------------------------------------------------------------



 //---------------------------------------------------------------------------------------
 // ������� 1 �������� �� ��� X ���
 iniVar.diskret_x :=ReadIniDataReal ('substrate','dx',1);    //  = 30/(razmeri_spleta_min+razmeri_spleta_razbros);
 log ('��� ����� dx='+floattostr(iniVar.diskret_x)+' ���');
 //---------------------------------------------------------------------------------------


 iniVar.coat :=ReadIniDataReal ('process','coating',200);    //
 log ('������� �������� ������ ���� ='+floattostr(iniVar.coat)+' ���. ��� ' + floattostr(iniVar.coat / iniVar.diskret_x) + ' �������');
 iniVar.coat:= iniVar.coat / iniVar.diskret_x;



 //---------------------------------------------------------------------------------------
 // Dp
 iniVar.dpmin_abs:=ReadIniDataReal ('process', 'dp_min', iniVar.diskret_x*10*2);    //
 iniVar.dpmax_abs:=ReadIniDataReal ('process', 'dp_max', iniVar.diskret_x*20*2);    //

 iniVar.dp_stdiv:=ReadIniDataReal ('process', 'dp_stdiv', 0.15);
 iniVar.tp_stdiv:=ReadIniDataReal ('process', 'tp_stdiv', 0.15);
 iniVar.up_stdiv:=ReadIniDataReal ('process', 'up_stdiv', 0.15);

 log ('���� ����. ������������� ��� dp '+floattostr(iniVar.dp_stdiv)+'');
 log ('���� ����. ������������� ��� tp '+floattostr(iniVar.tp_stdiv)+'');
 log ('���� ����. ������������� ��� up '+floattostr(iniVar.up_stdiv)+'');


 if iniVar.dpmax_abs < iniVar.dpmin_abs then
                            begin
                             iniVar.dpmax_abs:=iniVar.dpmin_abs;
                             log ('!!!! �������� dpmax ������ ��� dpmin.  �������� dpmax ���� ���������� � dpmin');
                            end;

 iniVar.dpmin_d:=round(iniVar.dpmin_abs/iniVar.diskret_x/2);
 iniVar.dpmax_d:=round(iniVar.dpmax_abs/iniVar.diskret_x/2);      // ������ ��� �� Ds, � Rs !



 if iniVar.dpmin_d<2 then
                      begin
                       iniVar.dpmin_d:=2;
                       iniVar.dpmax_d:=3;

                       iniVar.dpmin_abs:=iniVar.dpmin_d*iniVar.diskret_x*2;
                       iniVar.dpmax_abs:=iniVar.dpmax_d*iniVar.diskret_x*2;

                       log ('!!!! �������� Dpmin/Dpmax ���� ������ 4� ���������, ��� ����� ����, ��������� ��������.');
                      end;

 log ('Dp='+floattostr(iniVar.dpmin_abs)+' - '+floattostr(iniVar.dpmax_abs)+' ���.   (��� ������� ��������� ������)');
 log ('Rp='+inttostr(iniVar.dpmin_d)+' - '+inttostr(iniVar.dpmax_d)+' �������. (��� ������� �������� ������ � ���������)');

 iniVar.razmeri_spleta_razbros:=iniVar.dpmax_d-iniVar.dpmin_d;
 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.krp:=ReadIniDataReal ('process', 'krp', 1);    //
 log ('����. ����������� ����� ������ ����� (k):R������=Rp*k; k=' + floattostr(iniVar.krp) );
 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.modefild:=ReadIniDataInt ('substrate','modefild', 0);

 iniVar.rejim_nijnego_osnovaniya:=ReadIniDataInt ('system','rejim_nijnego_osnovaniya', 0);
 case iniVar.rejim_nijnego_osnovaniya of
  0: log ('������ ��������� ������ ����� ������� �� �������� �������');
  1: log ('������ ��������� ������ ����� ������� �� �������');

 end;



 iniVar.a1:=ReadIniDataReal ('substrate', 'a1', 1);    //
 iniVar.a1d:= round (iniVar.a1 / iniVar.diskret_x);
 if iniVar.a1d < 1 then iniVar.a1d:=1;

 iniVar.a2:=ReadIniDataReal ('substrate', 'a2', 1);    //
 iniVar.a2d:= round (iniVar.a2 / iniVar.diskret_x);
 if iniVar.a2d < 1 then iniVar.a2d:=1;

 iniVar.a3:=ReadIniDataReal ('substrate', 'a3', 1);    //
 iniVar.a3:=iniVar.a3 / iniVar.diskret_x;

 iniVar.a4:=ReadIniDataReal ('substrate', 'a4', 1);    //
 iniVar.a4d:= round (iniVar.a4 / iniVar.diskret_x);
 if iniVar.a4d < 1 then iniVar.a4d:=1;

 iniVar.a5:=ReadIniDataReal ('substrate', 'a5', 1);    //
 iniVar.a5d:= round (iniVar.a5 / iniVar.diskret_x);
 if iniVar.a5d < 1 then iniVar.a5d:=1;

 case iniVar.modefild of
  0:
     begin
       log ('�������� - �������� �����������. modefild=0');
     end;

  1:
     begin
       log ('�������� - � ���� ������������� ���������. modefild=1');
       log ('������ (�� X) '+ floattostr(iniVar.a1) + ' ��� ��� ' + inttostr(iniVar.a1d) + ' �������.');
       log ('������ (�� Y) '+ floattostr(iniVar.a2) + ' ��� ��� ' + inttostr(iniVar.a2d) + ' �������.');
       log ('������ '+ floattostr(iniVar.a3*iniVar.diskret_x) + '���, ��� ' + floattostr(iniVar.a3) + ' �������.');
       log ('�������� �� X '+ floattostr(iniVar.a4) + ' ��� ��� ' + inttostr(iniVar.a4d) + ' �������.');
       log ('�������� �� Y '+ floattostr(iniVar.a5) + ' ��� ��� ' + inttostr(iniVar.a5d) + ' �������.');
     end;

 end;

 //---------------------------------------------------------------------------------------


 //---------------------------------------------------------------------------------------

  log ('������� ������������ ������� ������: ');
  advcalculator (iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, iniVar.velos_max, iniVar.partmat, iniVar.partmat, r, r2);
  advcalculator (iniVar.dpmax_abs/1000000, iniVar.temp_patic_max, iniVar.temp_base, iniVar.velos_max, iniVar.partmat, iniVar.basemat, iniVar.h_max, iniVar.Ds_max_abs);

  if iniVar.h_max < r then
                        begin
                          iniVar.h_max := r;
                        end;

  if iniVar.Ds_max_abs < r2 then
                        begin
                          iniVar.Ds_max_abs := r2;

                        end;


  iniVar.Ds_max_abs:=iniVar.Ds_max_abs*1000000;
  iniVar.h_max:=iniVar.h_max*1000000;

  iniVar.Ds_max_d := round (iniVar.Ds_max_abs / iniVar.diskret_x) + 1;
  vrb.max_radius := (iniVar.Ds_max_d div 2) + 1;

  log ('������������ ������� ������ ='+floattostr(iniVar.Ds_max_abs)+' ��� ��� '+floattostr(iniVar.Ds_max_d)+' �������');
  log ('������������ ������  ������ ='+inttostr(vrb.max_radius)+' �������.');

  log ('��������� ������������ ������� ������� ');

 //---------------------------------------------------------------------------------------

  iniVar.obrezat_k_ds:=ReadIniDataReal ('slise', 'obrezat_k_ds', 1);    //
  iniVar.obrezka := upround (iniVar.Ds_max_d * iniVar.obrezat_k_ds);

  log ('�� ����� �������: ='+inttostr(iniVar.obrezka)+' �������.');



 //---------------------------------------------------------------------------------------
 // ������� ���� � ���
 iniVar.fild_size_X:=ReadIniDataReal ('substrate','fild_size_x',300);
 iniVar.fild_size_Y:=ReadIniDataReal ('substrate','fild_size_y',300);
 iniVar.fild_size_Z:=ReadIniDataReal ('substrate','fild_size_z',300);


 // ��� ��������� ������ ����� ���������������:
 if (iniVar.fild_size_X < iniVar.Ds_max_abs*1) OR
    (iniVar.fild_size_Y < iniVar.Ds_max_abs*1)
    then
      begin

        log ('!!!! ���� ���� ������� ���� �� ��������� � �������� ������. �� ��� ���������.');
        if (iniVar.fild_size_X < iniVar.Ds_max_abs*5) then iniVar.fild_size_X:=iniVar.Ds_max_abs*5;
        if (iniVar.fild_size_Y < iniVar.Ds_max_abs*5) then iniVar.fild_size_Y:=iniVar.Ds_max_abs*5;
        log ('������ fild_size_x:='+floattostr(iniVar.fild_size_X)+'  fild_size_y:='+floattostr(iniVar.fild_size_Y));

      end;
 //}

 // ����� ������� ������ ����...  ��������� ������� ����� ������������ !!!!  <--
 iniVar.fild_size_x_d := round(iniVar.fild_size_X / iniVar.diskret_x) + 6 ;
 iniVar.fild_size_y_d := round(iniVar.fild_size_Y / iniVar.diskret_x) + 6 ;

 log ('������� ���� fild_size_x:='+floattostr(iniVar.fild_size_X)+'  fild_size_y:='+floattostr(iniVar.fild_size_Y)+ ' ���');
 log ('������� ���� fild_size_x:='+inttostr(iniVar.fild_size_x_d)+'  fild_size_y:='+inttostr(iniVar.fild_size_y_d)+ ' �������');

 log ('� ������ ������� X ����� �� '+inttostr(iniVar.obrezka)+' �� '+inttostr(iniVar.fild_size_x_d-iniVar.obrezka)+ ' �������.');
 log ('� ������ ������� Y ����� �� '+inttostr(iniVar.obrezka)+' �� '+inttostr(iniVar.fild_size_y_d-iniVar.obrezka)+ ' �������.');

 //---------------------------------------------------------------------------------------


 //---------------------------------------------------------------------------------------
 iniVar.sloev:=ReadIniDataInt ('substrate','sloev', 40); //������������ ����� ����� ����� ����..
 //---------------------------------------------------------------------------------------

 iniVar.el_max:=ReadIniDataInt ('substrate','el_max', iniVar.sloev); //������������ ����� �� � ������� ����� ����
 log ('� ������� ����� ����: '+inttostr(iniVar.el_max)+' ��������� �� ������.');

 //---------------------------------------------------------------------------------------
 iniVar.kol_spletov := ReadIniDataInt('slise','kol_spletov',2);
 log ('����� �������: '+inttostr(iniVar.kol_spletov)+' �������.');

 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.sloev_v_shlife:=ReadIniDataInt('slise','sloev_v_shlife', 4);
 //---------------------------------------------------------------------------------------

 //---------------------------------------------------------------------------------------
 iniVar.srez_interval := ReadIniDataInt('slise','interval', iniVar.fild_size_y_d div 20);
 //---------------------------------------------------------------------------------------

 iniVar.koef_w := ReadIniDataReal ('spline','koef_w', 0);
 log ('����. w = '+floattostr(iniVar.koef_w)+'');


 //---------------------------------------------------------------------------------------
 iniVar.colormode := ReadIniDataInt('slise','colormode', 0);
 case iniVar.colormode of
  0: log ('����� ����������� ������: ����� � �����. ���������� �� �����.');
  1: log ('����� ����������� ������: ����� � �����. ������ �� �����.');
 end;


 //---------------------------------------------------------------------------------------



end;
