procedure TForm1.FormPaint(Sender: TObject);
var i,j,k:integer; // 0,3 - режим
    i1,j1,k1:integer;
    w:boolean;
                 // 3 - режим
    linX, rinX, tinY, binY,  stkx, stky,  intarg, intfunc, darg, dfunc, kfx, kfy : real;
    ht:real;
    align:ArStr;

    f:real;

                 // 2 - режим
    minspace, kb, skb : real;
    basepoint : real;
    p : array [0..7,'x'..'z'] of real;
    s:string;
    wd:real;
    tmpreal:real;
begin

 glEnable (GL_LIGHTING);
 glEnable (GL_LIGHT0);
 glEnable (GL_LIGHT1);
 glEnable (GL_LIGHT2);
 glEnable (GL_LIGHT3);
 glEnable (GL_LIGHT4);
 glEnable (GL_LIGHT5);
 glEnable (GL_LIGHT6);
 glEnable (GL_LIGHT7);
// glEnable (GL_LIGHT8);
 glEnable (GL_DEPTH_TEST);
 glEnable (GL_COLOR_MATERIAL);  // }

 LightPos0 [0] := +10.0;
 LightPos0 [1] := -10.0;
 LightPos0 [2] := +10.0;
 LightPos0 [3] := -5.0;

 LightPos1 [0] := +10.0;
 LightPos1 [1] := +10.0;
 LightPos1 [2] := -10.0;
 LightPos1 [3] := -5.0;

 LightPos2 [0] := +10.0;
 LightPos2 [1] := -10.0;
 LightPos2 [2] := +10.0;
 LightPos2 [3] := -5.0;

 LightPos3 [0] := +10.0;
 LightPos3 [1] := -10.0;
 LightPos3 [2] := +10.0;
 LightPos3 [3] := -5.0;

 LightPos4 [0] := +10.0;
 LightPos4 [1] := -10.0;
 LightPos4 [2] := -10.0;
 LightPos4 [3] := -5.0;

 LightPos5 [0] := -10.0;
 LightPos5 [1] := +10.0;
 LightPos5 [2] := +10.0;
 LightPos5 [3] := -5.0;

 LightPos6 [0] := -10.0;
 LightPos6 [1] := +10.0;
 LightPos6 [2] := -10.0;
 LightPos6 [3] := -5.0;

 LightPos7 [0] := -10.0;
 LightPos7 [1] := -10.0;
 LightPos7 [2] := +10.0;
 LightPos7 [3] := -5.0;

 LightPos8 [0] := -10.0;
 LightPos8 [1] := -10.0;
 LightPos8 [2] := -10.0;
 LightPos8 [3] := -5.0;




 //Задать положение источника света
 glLightfv(GL_LIGHT0, GL_POSITION, @LightPos0);
 glLightfv(GL_LIGHT1, GL_POSITION, @LightPos1);
 glLightfv(GL_LIGHT2, GL_POSITION, @LightPos2);
 glLightfv(GL_LIGHT3, GL_POSITION, @LightPos3);
 glLightfv(GL_LIGHT4, GL_POSITION, @LightPos4);
 glLightfv(GL_LIGHT5, GL_POSITION, @LightPos5);
 glLightfv(GL_LIGHT6, GL_POSITION, @LightPos6);
 glLightfv(GL_LIGHT7, GL_POSITION, @LightPos7);
// glLightfv(GL_LIGHT8, GL_POSITION, @LightPos8);
// }

 glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);      // очистка буфера цвета

 //перед отрисовкой поворачивам сцену как нам надо
 glPushMatrix;

 glScalef (scale, scale, scale);
 glTranslatef (centX, centY, centZ);

 glRotatef (alfaX, 1.0, 0.0, 0.0);
 glRotatef (alfaY, 0.0, 1.0, 0.0);
 glRotatef (alfaZ, 0.0, 0.0, 1.0);

// glRotatef (360-alfaZ, 0.0, 0.0, 1.0);
// glRotatef (360-alfaY, 0.0, 1.0, 0.0);
// glRotatef (360-alfaX, 1.0, 0.0, 0.0);




 CASE OpenGLmode OF
   0 :
       begin // Нулевой режим. (чайник)
         {$I 'func\mode0.pas'}
       end;

   1,4 :
       begin // Второй режим. (кубик)
         glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);

         minspace := MIN ((ScecSizeX2 - ScecSizeX1), (ScecSizeY2 - ScecSizeY1));
         minspace := MIN ((ScecSizeZ2 - ScecSizeZ1), minspace);
         minspace := 0.9 * minspace / sqrt(2);

         kb := minspace * 0.6;
         skb := minspace * 0.2;

         basepoint := -kb/2; // X  Y  Z

         glColor3f (0.0, 0.0, 0.0);
         glLineWidth (0.5);

         glutWireCube ( kb );
//         glutWireCube ((kb + skb));

         glColor3f (1.0, 0.0, 0.0);
         glLineWidth (1.0);

         // Рисуем оси с текстом
         for i:=0 to razbieny_kuba+1 do
          begin

              {$REGION 'Зарубки'}
              if i<=razbieny_kuba then
              begin


              if i mod (razbieny_kuba div 10) = 0 then
                begin
             glColor3f (1.0, 0.0, 0.0);
             glBegin (GL_LINES);
             glVertex3f ((-1) *  (basepoint+i*(kb/razbieny_kuba)) , basepoint , basepoint-(skb*0.1));
             glVertex3f ((-1) *  (basepoint+i*(kb/razbieny_kuba)) , basepoint , basepoint+(skb*0.1));
             glEnd;

             glBegin (GL_LINES);
             glVertex3f ((-1) * ( basepoint-(skb*0.1)) , basepoint , basepoint+i*(kb/razbieny_kuba));
             glVertex3f ((-1) * ( basepoint+(skb*0.1)) , basepoint , basepoint+i*(kb/razbieny_kuba));
             glEnd;

             glBegin (GL_LINES);
             glVertex3f ((-1) * ( basepoint-(skb*0.1)) , basepoint+i*(kb/razbieny_kuba) , basepoint+kb);
             glVertex3f ((-1) * ( basepoint+(skb*0.1)) , basepoint+i*(kb/razbieny_kuba) , basepoint+kb);
             glEnd;

                end;
              end;

  {$ENDREGION}

             // Подписываем текст.
//             if (i=0) OR (((razbieny_kuba mod 2) = 0) AND (i=razbieny_kuba div 2) ) OR (i = razbieny_kuba)



             if (i<=razbieny_kuba) AND (i mod (razbieny_kuba div 5) = 0)
               then
                 begin
                   glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);

                   // По оси X (горизонтальные)
                   ht:= 0.07*kb;

                   {$REGION 'Подписи ось X'}
                   glColor3f (1.0, 0.0, 0.0);

                   s:= floattostr(round(m_cube_minX + ((m_cube_maxX-m_cube_minX)/razbieny_kuba)*i));
                   wd:=(kb / razbieny_kuba);
                   wd:=(kb / (razbieny_kuba div 10));


                   if (i = razbieny_kuba) then
                   begin
//                     s:=s+'   '+m_cube_X;
                     wd:=3*wd;
                   end;
                   align[0]:='c';
                   align[1]:='l';
                   align[2]:='c';

//                   DrawText( floattostr (i),                      //тут добавить нормальные значения!
//                   DrawText( floattostr(m_cube_minX + ((m_cube_maxX-m_cube_minX)/razbieny_kuba)*i),

// glPushMatrix;
// glRotatef (-alfaX, 1.0, 0.0, 0.0);
// glRotatef (-alfaY, 0.0, 1.0, 0.0);
// glRotatef (-alfaZ, 0.0, 0.0, 1.0);


                   DrawText( s,
                             (-1) *  (basepoint+(kb / razbieny_kuba)*i),
                             basepoint+0.15,
                             basepoint,
                             ht,
                             align,
                             wd,
                             0,

                             0,
                             0,
                             0,
                             true,
                             gmf1); //}

// glPopMatrix;

//                   DrawText( s,
//                             (-1) *  (basepoint+(kb / razbieny_kuba)*i),
//                             basepoint+0.15,
//                             basepoint,
//                             ht,
//                             align,
//                             wd,
//                             0,
//
//                             -alfaX,
//                             -alfaY,
//                             -alfaZ,
//                             true,
//                             gmf1);


                   align[0]:='l';
                   align[1]:='l';
                   align[2]:='l';

//                   DrawText2( s,
////                             basepoint+(kb / ((razbieny_kuba)))*i,
//                             -kb/4+(kb / (2*(razbieny_kuba)))*i,
//                             -kb/4,
//                             -kb/4,
//                             ht,
//                             align,
//                             wd,
//                             0,
//
//                             -alfaX,
//                             -alfaY,
//                             -alfaZ,
//                             0,
//                             0,
//                             0,
//
//                             true,
//                             gmf1);


  {$ENDREGION}

                   {$REGION 'Подписи ось Y'}
                   //  По оси Y (вертикальные)
                   glColor3f (0.0, 1.0, 0.0);
                   align[0]:='l';
                   align[1]:='c';
                   align[2]:='c';

                   s:=floattostr(round(m_cube_minY + ((m_cube_maxY-m_cube_minY)/razbieny_kuba)*i));
                   wd:=(kb / razbieny_kuba);
                   wd:=(kb / (razbieny_kuba div 10));

                   if (i = razbieny_kuba) then
                   begin
//                     wd:=3*wd;

{                   DrawText( m_cube_Y,
                             basepoint+0.15,
                             basepoint+(kb / razbieny_kuba)*(i+1),
                             basepoint,
                             ht,
                             align,
                             wd,
                             0,
                             0,
                             0,
                             0,
                             true,
                             gmf1); //}

                   end;

                   DrawText( s,
                             (basepoint+0.15+kb/2+wd),
                             basepoint+(kb / razbieny_kuba)*i,
                             basepoint+kb,
                             ht,
                             align,
                             wd,
                             0,
                             0,
                             0,
                             0,
                             true,
                             gmf1); //}





                  { DrawText( s,
                             (-1) * (basepoint),
                             basepoint+(kb / razbieny_kuba)*i,
                             basepoint,
                             ht,
                             align,
                             wd,
                             0,
                             0,
                             0,
                             0,
                             true,
                             gmf1); //}

  {$ENDREGION}

                   {$REGION 'Подписи ось Z'}

                   //  По оси Z (глубинные)
                   glColor3f (0.0, 0.0, 1.0);
                   align[0]:='c';
                   align[1]:='l';
                   align[2]:='c';

                   s:=floattostr(round(m_cube_minZ + ((m_cube_maxZ-m_cube_minZ)/razbieny_kuba)*i));
//                   wd:=(kb / razbieny_kuba);
                   wd:=(kb );
                   wd:=(kb / (razbieny_kuba div 10));

                   if (i = razbieny_kuba) then
                   begin
                     s:=m_cube_Z+'   '+s;
                   end;

//                   DrawText( floattostr (i),                      //тут добавить нормальные значения!
                   DrawText( s,
                             (-1) * (basepoint+wd),
                             basepoint+0.15,
                             basepoint+(kb / razbieny_kuba)*i,
                             ht,
                             align,
                             wd,
                             0,  //gl
                             0,  //ax
                             90,
                             -90,  //az
                             true,
                             gmf1); //}





{                   glColor3f (0.0, 0.0, 1.0);
                   align[0]:='c';
                   align[1]:='l';
                   align[2]:='c';


                   DrawText( floattostr (i),                      //тут добавить нормальные значения!
                             basepoint+kb,
                             basepoint+0.15,
                             basepoint+(kb / razbieny_kuba)*i,
                             ht,
                             align,
                             (kb / razbieny_kuba),
                             0,  //gl
                             0,  //ax
                             -90,
                             0,  //az
                             true,
                             gmf1); //}

  {$ENDREGION}


                 end;
             if i = razbieny_kuba + 1 then
               begin
                   // По оси X (горизонтальные)
                   glColor3f (1.0, 0.0, 0.0);
                   wd:=(kb / (razbieny_kuba div 10));
                   s:=m_cube_X;
                   align[0]:='c';
                   align[1]:='l';
                   align[2]:='c';

                   DrawText( s,
                             (-1) *  (basepoint+(kb * 1.1)),
                             basepoint+0.15,
                             basepoint,
                             ht,
                             align,
                             wd,
                             0,

                             0,
                             0,
                             0,
                             false,
                             gmf1); //}

                   glColor3f (0.0, 1.0, 0.0);
                   align[0]:='l';
                   align[1]:='c';
                   align[2]:='c';

                   s:=m_cube_Y;

                   DrawText( s,
                             basepoint+0.15,
                             basepoint+(kb )*1.1,
                             basepoint,
                             ht,
                             align,
                             wd,
                             0,
                             0,
                             0,
                             0,
                             false,
                             gmf1); //}
                   glColor3f (0.0, 0.0, 1.0);
                   align[0]:='c';
                   align[1]:='l';
                   align[2]:='c';
                   s:=m_cube_Z;
                   DrawText( s,
                             (-1) * (basepoint),
                             basepoint+0.15,
                             basepoint+(kb )*1.1,
                             ht,
                             align,
                             wd,
                             0,  //gl
                             0,  //ax
                             90,
                             0,  //az
                             false,
                             gmf1); //}



               end;



          end;


         if NOT m_bEmpty then
                          begin
                            {$REGION 'Вывод кубика'}

         glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);

         for k:=0 to metok do     //z
          for j:=0 to metok do    //y
           for i:=0 to metok do   //x

            begin
             glcolor(col_R[m_colors_cube[k,j,i]], col_G[m_colors_cube[k,j,i]], col_B[m_colors_cube[k,j,i]] );

             if (k-1>0) and (k+1<=metok) and
                (j-1>0) and (j+1<=metok) and
                (i-1>0) and (i+1<=metok)
             then
               begin
                 w:=false;
                 for i1 := -1 to +1 do
                   for j1 := -1 to +1 do
                     for k1 := -1 to +1 do
                       begin
                         if m_cube[k+k1,j+j1,i+i1] <> 0 then
                           begin
                             w:=true;
                             break;

                           end;

                       end;
               end
             else
               w:=true;


//             if (k-1>0) AND (m_cube[k-1,j,i]=0) AND
//                (j-1>0) AND (m_cube[k,j-1,i]=0) AND
//                (i-1>0) AND (m_cube[k,j,i-1]=0) AND
//                (k+1<=metok) AND (m_cube[k+1,j,i]=0) AND
//                (j+1<=metok) AND (m_cube[k,j+1,i]=0) AND
//                (i+1<=metok) AND (m_cube[k,j,i+1]=0)
//             then
//              w:=false
//             else
//              w:=true;




             if (m_cube[k,j,i]=0) AND w then
//             if (m_cube[k,j,i]=0) then
                                begin
                                 glPushMatrix;
//                               ((x*kb)/(metok+1)) + basepoint;
                                 glTranslatef ((-1) * (convertX((i+0.5),kb,basepoint)), convertX((j+0.5),kb,basepoint),convertX((k+0.5),kb,basepoint));
//                                 glLineWidth (0.0);
//                                 glutSolidCube ( kb/(metok+1)*0.8 );
                                 f:=kb/(metok+1)*0.5;

         glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);

glBegin(GL_QUADS);
  glVertex3f(-1.0*f, +1.0*f, -1.0*f);
  glVertex3f(-1.0*f, +1.0*f, +1.0*f);
  glVertex3f(+1.0*f, +1.0*f, +1.0*f);
  glVertex3f(+1.0*f, +1.0*f, -1.0*f);
glEnd;

glBegin(GL_QUADS);
  glVertex3f(-1.0*f, -1.0*f, -1.0*f);
  glVertex3f(-1.0*f, -1.0*f, +1.0*f);
  glVertex3f(+1.0*f, -1.0*f, +1.0*f);
  glVertex3f(+1.0*f, -1.0*f, -1.0*f);
glEnd;

glBegin(GL_QUADS);
  glVertex3f(+1.0*f, -1.0*f, -1.0*f);
  glVertex3f(+1.0*f, -1.0*f, +1.0*f);
  glVertex3f(+1.0*f, +1.0*f, +1.0*f);
  glVertex3f(+1.0*f, +1.0*f, -1.0*f);
glEnd;

glBegin(GL_QUADS);
  glVertex3f(-1.0*f, -1.0*f, -1.0*f);
  glVertex3f(-1.0*f, -1.0*f, +1.0*f);
  glVertex3f(-1.0*f, +1.0*f, +1.0*f);
  glVertex3f(-1.0*f, +1.0*f, -1.0*f);
glEnd;


glBegin(GL_QUADS);
  glVertex3f(-1.0*f, -1.0*f, +1.0*f);
  glVertex3f(-1.0*f, +1.0*f, +1.0*f);
  glVertex3f(+1.0*f, +1.0*f, +1.0*f);
  glVertex3f(+1.0*f, -1.0*f, +1.0*f);
glEnd;

glBegin(GL_QUADS);
  glVertex3f(-1.0*f, -1.0*f, -1.0*f);
  glVertex3f(-1.0*f, +1.0*f, -1.0*f);
  glVertex3f(+1.0*f, +1.0*f, -1.0*f);
  glVertex3f(+1.0*f, -1.0*f, -1.0*f);
glEnd;






//                              glutWireCube ( kb/(metok+1) );

                                 glPopMatrix;
                                end; // if = 0

            end;// for
            {$ENDREGION}
                          end
                       else
                     begin
                            {$REGION 'Вывод ?'}


                             // Написть "X".

                             glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
                             glColor3f (0.0, 0.0, 1.0);
                             align[0]:='c';
                             align[1]:='c';
                             align[2]:='c';
                             ht:= kb;

                             DrawText( '?',                      //тут добавить нормальные значения!
                             0,
                             0,
                             0,
                             ht,      //height
                             align,   //pos
                             kb,      //maxwidth
                             0,       //gl
                             0,       //ax
                             0,       //ay
                             0,       //az
                             true,    //on/off
                             gmf1); //}


                            {$ENDREGION}
                     end;

       end;

   3 :
       begin // Третий режим. (графики корреляций)
         {$I 'func\mode3.pas'}
       end;


   5 :
       begin // Пятый режим. (покрытие)
          glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);

          DrawCoating(); //вот вызов отрисовки
       end;

 END;



 glPopMatrix;

 SwapBuffers(DC);



end;
