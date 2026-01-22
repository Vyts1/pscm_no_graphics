
  // Временные засечки (для анализа производительности)
  freq_HRT_prgstrt, begin_time_prgstrt, end_time_prgstrt:int64; // Время выполнения программы
  freq_HRT_uklsplat, begin_time_uklsplat, end_time_uklsplat:int64; // Время укладки одного сплэта.
//  freq_HRT_spline, begin_time_spline, end_time_spline:int64; // Время сплайн апроксимации, включая инициализацию.
  freq_HRT_mkcoat, begin_time_mkcoat, end_time_mkcoat:int64; // Время на генерацию покрытия (всего).
  freq_HRT_srez, begin_time_srez, end_time_srez:int64; // Время на деланье шлифов
  freq_HRT_analiz, begin_time_analiz, end_time_analiz:int64; // Адгезия/когезия глоб пористость.

  freq_HRT_poisk_min, begin_time_poisk_min, end_time_poisk_min:int64; // 

  freq_HRT_sozdaem_hmap_iz_dugi, begin_time_sozdaem_hmap_iz_dugi, end_time_sozdaem_hmap_iz_dugi:int64; //
  freq_HRT_sozdaem_hmap_iz_tochek_vishe, begin_time_sozdaem_hmap_iz_tochek_vishe, end_time_sozdaem_hmap_iz_tochek_vishe:int64; //
  freq_HRT_progon_hmap_1, begin_time_progon_hmap_1, end_time_progon_hmap_1:int64; //
  freq_HRT_progon_hmap_i, begin_time_progon_hmap_i, end_time_progon_hmap_i:int64; //
  freq_HRT_progon_dobavit_izmeneniya_v_up, begin_time_progon_dobavit_izmeneniya_v_up, end_time_progon_dobavit_izmeneniya_v_up:int64; //
  freq_HRT_sozdat_subfild, begin_time_sozdat_subfild, end_time_sozdat_subfild:int64; //
  freq_HRT_volnovoi_algoritm, begin_time_volnovoi_algoritm, end_time_volnovoi_algoritm:int64; //
  freq_HRT_razdviganie, begin_time_razdviganie, end_time_razdviganie:int64; //
  freq_HRT_spline1, begin_time_spline1, end_time_spline1:int64; //
  freq_HRT_sborka_niz, begin_time_sborka_niz, end_time_sborka_niz:int64; //
  freq_HRT_spline2, begin_time_spline2, end_time_spline2:int64; //
  freq_HRT_sborka_verh, begin_time_sborka_verh, end_time_sborka_verh:int64; //
  freq_HRT_dobavlenie_v_up, begin_time_dobavlenie_v_up, end_time_dobavlenie_v_up:int64; //
  freq_HRT_hmap_iz_dugi, begin_time_hmap_iz_dugi, end_time_hmap_iz_dugi:int64; //
  freq_HRT_hmap_iz_tochek_vishe, begin_time_hmap_iz_tochek_vishe, end_time_hmap_iz_tochek_vishe:int64; //

  freq_HRT_korektirovka_volni, begin_time_korektirovka_volni, end_time_korektirovka_volni:int64; //
  freq_HRT_poschitat_Ki, begin_time_poschitat_Ki, end_time_poschitat_Ki:int64; //

  freq_HRT_make_volume_array, begin_time_make_volume_array, end_time_make_volume_array:int64; //

//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //
//  freq_HRT_, begin_time_, end_time_:int64; //


  // Имя файла логов программы
  logfile:string = 'system.log';


  iniVar : Tini;

  vrb : Tcoatvar;



  p_v : p2;              // исходный массив
  uknot : p3x;
  vknot : p3y;
  weight:p4;           // весовые коэф.
  oo:r1;               // результат

  //------------------OpenGL------------------------------------
  // Контексты OpenGL.
//  DC : HDC;
//  hrc: HGLRC;

  LightPos0 : Array [0..3] of GLfloat;
  LightPos1 : Array [0..3] of GLfloat;
  LightPos2 : Array [0..3] of GLfloat;
  LightPos3 : Array [0..3] of GLfloat;
  LightPos4 : Array [0..3] of GLfloat;
  LightPos5 : Array [0..3] of GLfloat;
  LightPos6 : Array [0..3] of GLfloat;
  LightPos7 : Array [0..3] of GLfloat;
  LightPos8 : Array [0..3] of GLfloat;
  //------------------------------------------------------------

  LogArh :array of TLogArhItem;


  //------ Управление мышью сценой------------------------------
  MouseDownF : boolean;
  MousewrkX,MousewrkY : integer;
  //------------------------------------------------------------



  fild : mas;     // поле моделирования - плоскость.
  up :kub;
  cup:ckub;  // Это массив для хранения всего объема.
  volna : Tvolna;
  subfild  : submas; //выделеный массив
  subfild2 : submas2; //выделеный массив2
  subfild3 : submas2; //выделеный массив2
  subfild4 : submas2; //выделеный массив2

  shablon_array: array of array of shablon_point; // массив под шаблон окружностей
  src_array : Tversh_double_color; // массив кольца

  hmap : array of real;
  hsrez : array of array of LongWord;


  mtwist_mt:array[0..mtwist_n] of Cardinal;
  mtwist_mti:Integer;


  kol_9cheek_x, kol_9cheek_y:integer;
  random_karta : array of boolean;
  karta_col_used : integer;
  tochek_in_x, tochek_in_y:integer;

  maincaunter:integer;

  LogRec : Tlog;
