//это функци€ отрисовки массива ј. в виде квадратиков
procedure DrawCoating;
var i,j:word;
//    v : array [1..8] of versh;
    pt1, pt2, pt3, pt4 : versh; //(временные точки с поправленными координатами)

begin

 // —вет
 glEnable (GL_LIGHTING);
 glEnable (GL_LIGHT0);
 glEnable (GL_LIGHT1);

 LightPos0 [0] := 0.0;
 LightPos0 [1] := 5.0;
 LightPos0 [2] := -10.0;
 LightPos0 [3] := 0.0;


 LightPos1 [0] := 0.0;
 LightPos1 [1] := 5.0;
 LightPos1 [2] := 10.0;
 LightPos1 [3] := 0.0;



 //«адать положение источника света
 glLightfv(GL_LIGHT0, GL_POSITION, @LightPos0);
 glLightfv(GL_LIGHT1, GL_POSITION, @LightPos1);


{ fAmbient[0]:=0.15; fAmbient[1]:=0.15; fAmbient[2]:=0.15; fAmbient[3]:=0;
 fDiffuse[0]:=0.7; fDiffuse[1]:=0.7; fDiffuse[2]:=0.7; fDiffuse[3]:=0;
 fSpecular[0]:=1; fSpecular[1]:=1;  fSpecular[2]:=1;  fSpecular[3]:=0;
 fAmbMat[0]:=1;  fAmbMat[1]:=1;  fAmbMat[2]:=1;  fAmbMat[3]:=0;
 fDifMat[0]:=1;  fDifMat[1]:=1;  fDifMat[2]:=1;  fDifMat[3]:=1;
 fSpecMat[0]:=0.4;  fSpecMat[1]:=0.4;  fSpecMat[2]:=0.4;  fSpecMat[3]:=0;
 fShine:=100;
 fEmission[0]:=0;  fEmission[1]:=0;  fEmission[2]:=0;  fEmission[3]:=0;
 //}

{ glLightfv(GL_LIGHT0, GL_AMBIENT, @fAmbient);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @fDiffuse);
 glLightfv(GL_LIGHT0, GL_SPECULAR, @fSpecular);
 //}

 {	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, @fAmbMat);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @fDifMat);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @fSpecMat);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, fShine);
	glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @fEmission);
// }


  { /рисование разметочной части
 glColor3f (0.0, 0.4, 0.8);
 glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
 glBegin (GL_QUADS);
 glNormal3f(0, 0, 1);
 glVertex3f ( -sx, -sy, 0);
 glVertex3f ( -sx, +sy, 0);
 glVertex3f ( +sx, +sy, 0);
 glVertex3f ( +sx, -sy, 0);
 glEnd;
 // }

// glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
 glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);

// glutSolidTeapot(1.0);

 glBegin (GL_TRIANGLES);
  //тут идет перебор всего массива
   for j:=0 to vrb.fild_y-1 do  // -1 т.к. в формулах стоит что надо использовать последующую точку, которой нет.
    for i:=0 to vrb.fild_x-1 do
     begin

          pt1:=fild[j,i];
          pt2:=fild[j,i+1];
          pt3:=fild[j+1,i];
          pt4:=fild[j+1,i+1];

          pt1.x:=fild[j,i].x*vrb.kfm-vrb.kox;
          pt1.y:=fild[j,i].y*vrb.kfm-vrb.koy;
          pt1.z:=fild[j,i].z*vrb.kfm-vrb.koz;


          pt2.x:=fild[j,i+1].x*vrb.kfm-vrb.kox;
          pt2.y:=fild[j,i+1].y*vrb.kfm-vrb.koy;
          pt2.z:=fild[j,i+1].z*vrb.kfm-vrb.koz;

          pt3.x:=fild[j+1,i].x*vrb.kfm-vrb.kox;
          pt3.y:=fild[j+1,i].y*vrb.kfm-vrb.koy;
          pt3.z:=fild[j+1,i].z*vrb.kfm-vrb.koz;

          pt4.x:=fild[j+1,i+1].x*vrb.kfm-vrb.kox;
          pt4.y:=fild[j+1,i+1].y*vrb.kfm-vrb.koy;
          pt4.z:=fild[j+1,i+1].z*vrb.kfm-vrb.koz;


          calculateNormal (
                           pt3.x, pt3.y, pt3.z,
                           pt4.x, pt4.y, pt4.z,
                           pt2.x, pt2.y, pt2.z
                          );

          setcol(pt3.c);
//          glColor3f (0.2, 0.3, 0.7);
          glVertex3f (pt3.x, pt3.y, pt3.z);

          setcol(pt4.c);
//          glColor3f (0.2, 0.2, 0.9);
          glVertex3f (pt4.x, pt4.y, pt4.z);

          setcol(pt2.c);
//          glColor3f (0.2, 0.3, 0.6);
          glVertex3f (pt2.x, pt2.y, pt2.z);



          calculateNormal (
                            pt1.x, pt1.y, pt1.z,
                            pt3.x, pt3.y, pt3.z,
                            pt2.x, pt2.y, pt2.z
                          );

          setcol(pt1.c);
//          glColor3f (0.2, 0.2, 0.8);
          glVertex3f (pt1.x, pt1.y, pt1.z);

          setcol(pt3.c);
//          glColor3f (0.2, 0.3, 0.7);
          glVertex3f (pt3.x, pt3.y, pt3.z);

          setcol(pt2.c);
//          glColor3f (0.2, 0.3, 0.6);
          glVertex3f (pt2.x, pt2.y, pt2.z);


     end;
 glEnd;
// }


end;
