
  //============================================================================
  // ��� �����, ������������ �� ����� �� ��������
  point = array [0..2] of double; // ����� �������
  p2 = array of array of point;   // ������� (�������) ������ (p)
  p3x = array of double;          // u ������������
  p3y = array of double;          // v ������������
  p4 = array of array of double;  // w ������������
  r1 = array of array of point;   // ��������� (������)       (oo)
  //============================================================================

  versh = record          // ������� ��� ������� fild
            x:real;
            y:real;
            z:real;
            c:byte;
            sloy:byte;
          end;

  pair = record           // ��� ��� UP
            s1: real;
            s2: real;
            p0: real;

            tp: byte;
            sloy : byte;
            num:integer;
         end;

  dumppair = record
               el:pair;
               tx, ty : integer;
               num:integer;
               num2:string[10];
             end;

  Tfilllayer = record
                 zalito, nezalito:real;
               end;

  TLogArhItem = record
     num : integer;
     name : string[30];
     valueR : real;
     valueS : string;
     valueI : integer;
     t : byte;

  end;

  Tvolna_memory = record  // ������ �����
                   r : integer;
                   Zreal : real;
                   dh : real;
                  end;

   volnai = record        // �����
             Ki:byte;
             Si:Tvolna_memory;
     //      Pi:byte;
            end;

   Tageziya = record
                v : boolean; // ��������� ��������, true-������ false-����� ��� �����
                w : boolean; // ������ ����� � �������� ��������� ���� ���� ? true - ������
                u : boolean; // ������ ������� ����  true - ����� �����,  false - ����� �����
              end;

   shablon_point = record                   // ����� ������� �����������
                      x,y:integer;
//                      c:tcolor;
                      c:byte;
                   end;

   versh_double_color = record    // < -------- ����������
                         x:real;
                         y:real;
                         z:real;
                         c:byte;
                         color:byte;
                        end;

  mas = array of  array of versh; //�������� ������ fild

  kub = array of array of array of pair;
  ckub =array of array of shortint;
  Tvolna = array of array of volnai;

  submas = array of array of versh_double_color; //������ ������  (�������� �� ��� versh!!!)

  Tversh_double_color = array of versh_double_color;
  Pversh_double_color = ^Tversh_double_color;

  submas2 = array of array of versh; //������ ������


  Tmaterial = record
                  m_nId:integer;
                  m_Material:String;
                  m_ROms:real;
                  m_ROml:real;
                  m_CPms:real;
                  m_CPml:real;
                  m_Lms:real;
                  m_Lml:real;
                  m_Tm:real;
                  m_TBoil:real;
                  m_Lm:real;
                  m_MUml:real;
                  m_SIGml:real;
                  m_LBoil:real;
                  m_AW:real;
                  Ac:real;
               end;


  THistogram = record
     name : string;
     dpmin, dpmax : real;
     k : integer;
     material : integer;
     a : array of integer;
     u : array of integer;
     sm : integer;
     w : boolean;
     w2 : boolean;
  end;

  //============================================================================
  // ���������� ��� �����, ��������� ��������
  Tini     = record
              file_rez : string;
              csv_dump_file : string;

              tochekvdiskrete : integer; // ����� ����� � 1 �������� ��� ����������� � �����
              tochekvdiskrete2 : integer; // ����� ����� � 1 �������� ��� ����������� � �����
              tochekvdiskretesvg : real; // ����� ����� � 1 �������� ��� ����������� � �����

              fild_size_X, fild_size_Y, fild_size_Z : real; // ������� ���� fild ��� ���. �� �������
              diskret_x : real; //������ �������� ��� �� �� diskret_y, diskret_z

              stoh, sloev:integer; // ����������� �� cup

              sloev_v_shlife:integer; // ����� �����. ��� ��� ������� ��������.

              kol_spletov:integer; // ����� �������, ������� ������

              coat : real;
              is_col: boolean;


              polaya_chastica: boolean;

              noise:real;

              fild_size_x_d, fild_size_y_d:integer; // ������� ������� fild ���������� (� ������ +6)

              modefild:integer;
              a1,a2,a3,a4,a5:real;
              a1d,a2d,a3d,a4d,a5d:integer;

              sdvigspleta : boolean;

              metod_provisaniya : integer;

              formula : integer;
              tip_materiala : integer;


              const_c0 : real;


              srez_interval:integer; // �������� ��� ����� ������

              dpmin_abs, dpmax_abs:real; // ������� ������� ��� (�������)
              temp_base,
              temp_patic_min, temp_patic_max,
              velos_min, velos_max: real; // ����������� � ��������

              dp_stdiv, tp_stdiv, up_stdiv :real;

              obrezka : integer;
              obrezat_k_ds : real;

              el_max:integer;

              dpmin_d, dpmax_d, razmeri_spleta_razbros:integer;  // ������ ������� �������   (�������� �� R �����)
              div2 : integer;
//              partmat, basemat:Tmaterial;
              partmat, incmat, basemat : Integer;

              part_class, inc_class, sub_class:CCutBoxSet;

              VolCon:real;

              koef_mediani : real;

              koef_9cheek:real;

              logfilenum : integer;
              logstrnum : int64;


              main_log, koord_log, random_log, time_log : boolean;

              h_max, Ds_max_abs:real;
              Ds_max_d:integer;

              krp:real;

              koef_provisaniya, koef_natek, koef_w:real;
              colormode:byte;

              first_time : integer; // 0- ��� �� ������, 1 - ������ ���, 2 - ������ ����  � �.�.

              k3mode:byte;

              rejim_nijnego_osnovaniya:byte;

              up_divizor:real;

              SplatType : integer;


              sposob_vvoda : integer;
              hist_n : integer;

              histogram : array of THistogram;
              hist_col:integer;
             end;

//  Tsystemini = record
   //           sx, sy, sz : integer;
//             end;

  TLog   = record
      x,y, Time, N, Sk, Sn, typ, Rs1, Rs2, NR, HR, H : integer;
      Tp, up, dp, tb, dx, P, R : real;

      REG1, REG2 : integer;
      LayerN : integer;

      formula : integer;
      polaya : boolean;


      DsDim1, HsDim1, DsNONDim1, HsNONDim1,
      DsDim2, HsDim2, DsNONDim2, HsNONDim2:real;
      Tc1,Tc2 : real;

      Adg :real;
      Adg1 :real;
      Adg2 :real;

      PorAdd_Head, PorAdd_Content : string;

      PartName, BaseName : string;
  end;


  Tcoatvar   = record
              // ��� ���������� �������� ��� ��������
              max_subfild_size_x,  max_subfild_size_y:integer;
              max_subfild2_size_x, max_subfild2_size_y:integer;
              max_subfild3_size_x, max_subfild3_size_y:integer;
              max_subfild4_size_x, max_subfild4_size_y:integer;
              oo_size_x,oo_size_y:integer;


              // ��� �������� �������� ��� �������� ������
              start_subfild_x, start_subfild_y, end_subfild_x, end_subfild_y : integer; // ���������� ������������� ������� � ������� ������
              subfild_size_x, subfild_size_y : integer; // ��� ������� ���� ����������
              subfild2_size_x, subfild2_size_y : integer; // ��� ������� ���� ����������
              subfild3_size_x, subfild3_size_y : integer; // ��� ������� ���� ����������
              subfild4_size_x, subfild4_size_y : integer; // ��� ������� ���� ����������

              //���������� � ��� �������:
              sub_crkl_center_x, sub_crkl_center_y :integer; // ��������� �������-������



//              sub_crkl_rp, sub_crkl_rs : integer;
//              sub_crkl_height:real;
//              crkl_Rp, crkl_Rs : integer;
//              crkl_height : real;

              crkl_Rp_OP, crkl_Rs_OP : integer;
              crkl_Rp_J,  crkl_Rs_J : integer;
              crkl_height_OP, crkl_height_J : real;
              crkl_volume : real;

              crkl_Rp_1, crkl_Rs_1 : integer;
              crkl_height_2, crkl_height_4 : real;
              // 2 - ��� ��� ���������� � ������������� ��������
              // 3 - ��� �������� �������, V=Rs*h3

              //������ Rs ������ ������� ���� ��� h ���� ��� ������, ������ ��� ������� �������, ������ ��� ����������


              //��������, ������� ������� � ������� ������ ����� ����� (�����) �����. �.�. K=3 ����� ��������.
              kol_k0, kol_k1, kol_k2, kol_k3, kol_k4: integer;

              csrc_array:integer; // ������� ������� ��� ������

              M2,N2,    // M - ������ ��,   N - ������ �����.
              M2x,M2y,
              div2x,div2y,
              N2x,N2y:integer;

              fild_x , fild_y : integer; // �������� ������� ����� ����

              max_radius : integer;
              stat_h, stat_x, stat_y, kfm, koy, kox, koz :real;

              crkl_center_x, crkl_center_y : integer;
              up0, tb0, tp0 : real;
              last_crkl_height : real;

              start_timestamp : string;

              fRp:integer;
              t1,t2:integer;

              hsrezsize:integer;

              PolniyObemKapli, DolyaKapli, IshodnayaH, OpornayaH, VolControl, CurrentH : real;

              adg_kol, adg_kol_v_splete, adg_s_pokritiya, adg_kol_v_splete_nekontakt:integer;
              adg_chislitel, adg_sigma_i, adg_sigma_avg, adg_koef_kontakta, adg :real;

              Tc:real;

              first_x, first_y, first_Rs, first_Rp : integer;
              last_x, last_y, last_Rs, last_Rp : integer;

              pervspletX, pervspletY, pervspletRs, pervspletRp : integer;

              smeshenie_x, smeshenie_y : integer;
              //volume

              IsSecondType : integer;

             end;



  //============================================================================


  //============================================================================
  //============================================================================
  //============================================================================
  //============================================================================
  //============================================================================
  //============================================================================
  //============================================================================
  //============================================================================


