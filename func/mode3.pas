
         glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);

         linx := (ScecSizeX2 - ScecSizeX1) * 0.1;
         rinx := (ScecSizeX2 - ScecSizeX1) * 0.9;
         stkx := (ScecSizeX2 - ScecSizeX1) * 0.8;

         biny := (ScecSizeY2 - ScecSizeY1) * 0.1;
         tiny := (ScecSizeY2 - ScecSizeY1) * 0.9;
         stky := (ScecSizeY2 - ScecSizeY1) * 0.8;

//         intarg:=180;
//         intfunc:=220;
         intarg:=data_max_arg-data_min_arg;
         intfunc:=data_max-data_min;




         darg  := intarg / razbieny_grafika;
         dfunc := intfunc / razbieny_grafika;
         for j:=0 to razbieny_grafika do // рисует линии сетки
           begin
             glColor3f (0.8, 0.8, 0.8);
             glLineWidth (0.5);
             glBegin (GL_LINES);
             for i:=0 to shtrihi do
                 glVertex3f ( linx + j * (stkx / razbieny_grafika) - ScecSizeX2,  biny + (i * stky / shtrihi) - ScecSizeY2, 0);
             glEnd;

             glBegin (GL_LINES);
             for i:=0 to shtrihi do
                 glVertex3f ( linx + (i * stkx / shtrihi) - ScecSizeX2,  biny + j * (stky / razbieny_grafika) - ScecSizeY2, 0);
             glEnd;


             if (j = 0) OR (j = 5) OR (j = razbieny_grafika)
                then
                  begin

                    glColor3f (0.0, 0.0, 0.0);
                    glLineWidth (1.0);

                    ht:= (stky / razbieny_grafika) / 2;
                    align[0]:='r';
                    align[1]:='c';
                    align[2]:='l';

                    // Вертикальные подписи
                    tmpreal:=data_min + j * (intfunc/razbieny_grafika) ;
                    tmpreal:=round(tmpreal*1E6)/1E6;
                    DrawText( floattostr(tmpreal ),
                            (linx * 0.95) - ScecSizeX2,
                            (biny + j * (stky / razbieny_grafika)) - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            false,
                            gmf1); //}

                    DrawText( floattostr( tmpreal ),
                            (linx * 0.95) - ScecSizeX2,
                            (biny + j * (stky / razbieny_grafika)) - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            true,
                            gmf1); //}

                    // Горизонтальные подписи

                    ht:= (stky / razbieny_grafika) / 2;
                    align[0]:='c';
                    align[1]:='r';
                    align[2]:='l';

                    tmpreal:=data_min_arg + j * (intarg/razbieny_grafika) ;
                    tmpreal:=round(tmpreal*1E6)/1E6;
                    DrawText( floattostr(tmpreal),
                            (linx + j * (stkx / razbieny_grafika)) - ScecSizeX2,
                            (biny * 0.95) - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            false,
                            gmf1); //}

                    DrawText( floattostr(tmpreal ),
                            (linx + j * (stkx / razbieny_grafika)) - ScecSizeX2,
                            (biny * 0.95) - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            true,
                            gmf1);


                  end;
//             glVertex3f ( linx + j * (stkx / razbieny_grafika) - ScecSizeX2,  biny - ScecSizeY2, 0);
//             glVertex3f ( linx + j * (stkx / razbieny_grafika) - ScecSizeX2,  tiny - ScecSizeY2, 0);

//             glVertex3f ( linx - ScecSizeX2,  biny + j * (stky / razbieny_grafika) - ScecSizeY2, 0);
//             glVertex3f ( rinx - ScecSizeX2,  biny + j * (stky / razbieny_grafika) - ScecSizeY2, 0);
           end; // Конец рисования линий сетки


                    align[0]:='c';
                    align[1]:='r';
                    align[2]:='l';

                    DrawText(m_cube_X,
                            (linx + stkx) - ScecSizeX2,
                            (biny * 0.95)-ht - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            true,
                            gmf1); //}

                    DrawText(m_cube_Y,
                            (linx * 0.95) - ScecSizeX2,
                            biny + stky+ht*1.5 - ScecSizeY2,
                            0,
                            ht,
                            align,
                            linx*0.9,
                            0,
                            0,
                            0,
                            0,
                            true,
                            gmf1); //}


         kfx := stkx / intarg;
         kfy := stky / intfunc;

//       ? = linx + (X-minarg)  * kfx - ScecSizeX2;
//       ? = biny + (Y-minfunc) * kfy - ScecSizeY2;

        I2:=countFunctions;
        glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);

        glcolor(0.1,0.8,0.1);

        glLineWidth(5.0);

        glBegin (GL_LINE_STRIP);
          glNormal3f(0, 1, 0);




          glVertex2f (
                      convertX3 ( data_min_arg, linx, data_min_arg, kfx, ScecSizeX2),
                      convertX3 ( data[0][0], biny, data_min, kfy, ScecSizeY2)
                     );
{          glVertex2f (
                      convertX3 (data_min_arg,  scx, sclx, data_min_arg, data_max_arg),
                      convertY3 (data[I2][0],  scy, scly1, scly2, data_min, data_max)
                     );}


          for i1:=1 to data_size do
           begin
//             glVertex2f (
//                           convertX3 ( i1*((data_max_arg-data_min_arg)/data_size)+ data_min_arg,  linx, data_min_arg, kfx, ScecSizeX2),
//                           convertX3 ( data[I2][i1], biny, data_min, kfy, ScecSizeY2)
//                        );


             glVertex2f (
                           convertX3 ( i1*((data_max_arg-data_min_arg)/data_size)+ data_min_arg,  linx, data_min_arg, kfx, ScecSizeX2),
                           convertX3 ( data[0][i1], biny, data_min, kfy, ScecSizeY2)
                        );

           end;

        glEnd;

