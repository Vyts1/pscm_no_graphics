 glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);
 for j:=1 to 6 do
   begin
     // выбор цветов
     case j of
      1,4: glColor3f (1.0, 0.0, 0.0);
      2,5: glColor3f (0.0, 1.0, 0.0);
      3,6: glColor3f (0.0, 0.0, 1.0);
     end;

     // Рисуем оси:
     glBegin (GL_LINES);
     case j of
      1:
         begin
          glVertex3f ( +1, 0, 0);
          glVertex3f ( -1, 0, 0);
         end;
      2:
         begin
          glVertex3f ( 0, +1, 0);
          glVertex3f ( 0, -1, 0);
         end;
      3:
         begin
          glVertex3f ( 0, 0, +1);
          glVertex3f ( 0, 0, -1);
         end;

     end;
     glEnd;

     glPushMatrix;
     // зарубки
     for i:=1 to 10 do
       begin
         case j of
         1: glTranslatef (0.1, 0.0, 0.0);
         2: glTranslatef (0.0, 0.1, 0.0);
         3: glTranslatef (0.0, 0.0, 0.1);
         4: glTranslatef (-0.1, 0.0, 0.0);
         5: glTranslatef (0.0, -0.1, 0.0);
         6: glTranslatef (0.0, 0.0, -0.1);
         end;
         glutSolidSphere(predelS/100, 10, 10 );
       end;

     // рисуем конусы
     if j<=3 then
       begin
         case j of
         1:
            begin
             glRotatef (90, 1.0, 0.0, 0.0);
             glRotatef (90, 0.0, 1.0, 0.0);
            end;
         2:
            begin
             glRotatef (-90, 1.0, 0.0, 0.0);
            end;
         end;
         glutSolidCone (0.02, 0.05, 10, 10);
       end;

     glPopMatrix;
   end;



 glPolygonMode (GL_FRONT_AND_BACK, fillcubemode);
 glColor3f (0.0, 0.0, 1.0);
 glutSolidTeapot(predelS*0.8);
// glutSolidSphere(predelS/100, 10, 10 );

 // доделать тени
 glColor3f (1.0, 0.0, 1.0);
 glBegin (GL_QUADS);
   glVertex3f ( -1*predelS, -1*predelS, 1*predelS);
   glVertex3f ( -1*predelS, +1*predelS, 1*predelS);
   glVertex3f ( +1*predelS, +1*predelS, 1*predelS);
   glVertex3f ( +1*predelS, -1*predelS, 1*predelS);

   glVertex3f ( -1*predelS, -1*predelS, -1*predelS);
   glVertex3f ( -1*predelS, +1*predelS, -1*predelS);
   glVertex3f ( +1*predelS, +1*predelS, -1*predelS);
   glVertex3f ( +1*predelS, -1*predelS, -1*predelS);
 glEnd;




 //glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);
