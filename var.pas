var
  Form1: TForm1;
  ImageList4md1, ImageList4Scen, ImageList4LH, ImageList4Pet, ImageList4Arg, ImageList4md3, ImageList4md4, ImageList4md5: TImageList;
  MD11Array:array [1..count_md_items]  of TMD11Array;   // Пространство 1 + Чувствительность + Пространство 2

  MD3Array:array [0..13]  of TMD3Array;    // Функции в корреляциях

  ScenArray:array [0..3] of TScenArray;
  PetArray :array [0..2] of TPetArray;
  ArgArray :array [0..3] of TArgArray;
  LHArray :array [0..1] of TLHArray;
  Lang : byte;
  ErrorArray:array [0..10] of TErrorArray;



  BN : byte;  // Индикатор какая кнопка нажата.
  OpenGLmode : byte; // Режим отображения графики. 0 ничего. 1 - леонов пространство. 2 - корреляции.

  //--------------------------------------
  //     GL
  DC : HDC;
  hrc: HGLRC;

  ScecSizeX1, ScecSizeX2,
  ScecSizeY1, ScecSizeY2,
  ScecSizeZ1, ScecSizeZ2: GLfloat;

  alfaX, alfaY, alfaZ : real;
  centX, centY, centZ :real;
  scale : real;

  predelS : real;

//  mode3d : integer;
  fix : boolean;

  {$I 'func\DrawTextVar.pas'} // <---5

  
  //--------------------------------------
  //Леоновская часть

  xi, w, hs1, k2, p, q, a, b, c, d, tau1, t1, deff, td :double;
  TDspl, HDspl, DDspl, Hb:double;
  Re, We, Pr, mu:double;
  pe:double;
  tetac, Tc, cz, cxi, ts:double;
  Tbspl:double;
  Fo:double;

//  m_cube : array [0..metok, 0..metok, 0..metok] of integer;

  m_cube : array of array of array of integer;

  m_cube_minX, m_cube_maxX,  // размерности
  m_cube_minY, m_cube_maxY,
  m_cube_minZ, m_cube_maxZ : real;
  m_cube_X, m_cube_Y, m_cube_Z : string;

  //Для работы главного блока
  m_calc:CCalculations;

    razbieny_kuba : integer;

    //--------------------- 2ой режим

    bCondition, m_bEmpty:boolean;
    num_i,i, j, k, nColor, i0, i1, i2:integer;
    ddpo, dtbo, dupo, dtpo, tpo, tbo, upo, dpo, function_result:real;
    m_nTrian : array[0..3] of integer;
    //}

    //--------------------- 1ый режим
    nCondition:boolean;
//    nColor:integer;
    ac,ghsm,gDsm,ghs,Dp, dpe:real;
    itpo, itbo, ipe, iitbo, iitpo, iipe:integer;

    tpoMin, tpoMax, tboMin, tboMax, peMin, peMax, Ke, Kupl, Lppsl:real;
    dAxis: array [0..2] of real;
    a_g1, a_g2, a_g3, a_g4, a_g5, // значения альфа для геометрических характеристик
    a_t1, a_t2, // для температурно-временных характеристик
    var_a // значения переменных для расчетов
    :real;
    bEqDp, // равенство Dpmin = Dpmax
    bMenu5:boolean;
//    m_nTrian : array[0..3] of integer;
//    m_bEmpty:boolean;

    metok : integer;
//    m_colors_cube: array [0..300, 0..300, 0..300] of byte;

    m_colors_cube: array of array of array of byte;


    col_R, col_G, col_B : array [0..ccolorsarray] of real;

    fillcubemode:integer;



  //}

    //--------------------- режим графиков
    data_size: integer;
    countFunctions: integer;
    drawmode:integer;


    data: array [0..25, 0..1000] of real;
    nFunction:integer;
    data_min, data_max:real;
    data_min_arg, data_max_arg:real;

    general_step :integer;
    grid_data_max, grid_data_min :real;


//    dupo, dDpo:real;
//    tpo, tbo, upo, Dpo:real;



  //--------------------------------------



  //--------------------------------------
  