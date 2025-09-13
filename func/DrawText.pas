//-----------------------------------------------------------------------------
//Вывод текста
function DrawText ( text :string;
                   x,y,z :Real;
              var height :Real;
                     pos :Arstr;
                maxwidth :Real;
                       gl:real;
                 ax,ay,az:Real;
                     on_ :boolean;
                    gmf1 : TGlyphMetricsFloat): real;
                    
 var
   i2, i1 :Integer;
   Litera : PChar;
   length_string_of_point,
   up_, down_
   :Extended;
   koef : real;
begin
text := text;//chr(129)+ chr(103);
Litera := PAnsiChar(text);


length_string_of_point := 0;

MaxFontVertSize := 0;
up_ := 0;
down_ := 0;
for i2:=0 to 255 do
 begin
  i1:= i2;
  if (Ord('h') = i2) then
    up_ := gmf1[i2].gmfptGlyphOrigin.Y;
  if (Ord('g') = i2) then
    down_ := gmf1[i2].gmfBlackBoxY - gmf1[i2].gmfptGlyphOrigin.Y;
 end;
 MaxFontVertSize :=  up_ + down_;


for i1:=1 to Length(text)-1 do
 begin
 length_string_of_point:=length_string_of_point+
  gmf1[ord(text[i1])].gmfCellIncX;
 end;
i1 := Length(text);
if (i1 > 0) then length_string_of_point:=length_string_of_point+
  gmf1[ord(text[i1])].gmfBlackBoxX + gmf1[ord(text[i1])].gmfptGlyphOrigin.X;

koef := height/MaxFontVertSize;
if (((length_string_of_point * koef) > maxwidth) and (maxwidth > 0 )) then
 koef := maxwidth / length_string_of_point;

 if (on_) then
 begin
 glPushAttrib(GL_ALL_ATTRIB_BITS);
 glPushMatrix();
 //Перемещение в опорную точку
 glTranslatef (x, y, z);

 glRotatef (az, 0.0, 0.0, 1.0);
 glRotatef (ay, 0.0, 1.0, 0.0);
 glRotatef (ax, 1.0, 0.0, 0.0);

 //Перемещение в базовую точку (Откуда тект пишется)
 glTranslatef (0, down_ * koef, 0);
 if (pos[2] = 'c') then z:= gl/2;
 if (pos[2] = 'r') then z:= gl;

 if (pos[0] = 'c') then x:=  -length_string_of_point * koef/2;
 if (pos[0] = 'r') then x:=  -length_string_of_point * koef;

 if (pos[1] = 'c') then y:= -MaxFontVertSize * koef/2;
 if (pos[1] = 'r') then y:=  -MaxFontVertSize * koef;
 //Перемещение в соответствии с смещением alighn
 glTranslatef (x, y, z);

 glScalef(koef, koef, 1);
 glListBase(GLF_START_LIST);
 glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
 glPopAttrib();
 glPopMatrix();
 end;

height := MaxFontVertSize * koef;
DrawText := length_string_of_point * koef;
end;




//-----------------------------------------------------------------------------
//Вывод текста
function DrawText2 ( text :string;
                   x,y,z :Real;
              var height :Real;
                     pos :Arstr;
                maxwidth :Real;
                       gl:real;
                 ax,ay,az:Real;
                 ax2,ay2,az2:Real;
                     on_ :boolean;
                    gmf1 : TGlyphMetricsFloat): real;
                    
 var
   i2, i1 :Integer;
   Litera : PChar;
   length_string_of_point,
   up_, down_
   :Extended;
   koef : real;
begin
text := text;//chr(129)+ chr(103);
Litera := PAnsiChar(text);


length_string_of_point := 0;

MaxFontVertSize := 0;
up_ := 0;
down_ := 0;
for i2:=0 to 255 do
 begin
  i1:= i2;
  if (Ord('h') = i2) then
    up_ := gmf1[i2].gmfptGlyphOrigin.Y;
  if (Ord('g') = i2) then
    down_ := gmf1[i2].gmfBlackBoxY - gmf1[i2].gmfptGlyphOrigin.Y;
 end;
 MaxFontVertSize :=  up_ + down_;


for i1:=1 to Length(text)-1 do
 begin
 length_string_of_point:=length_string_of_point+
  gmf1[ord(text[i1])].gmfCellIncX;
 end;
i1 := Length(text);
if (i1 > 0) then length_string_of_point:=length_string_of_point+
  gmf1[ord(text[i1])].gmfBlackBoxX + gmf1[ord(text[i1])].gmfptGlyphOrigin.X;

koef := height/MaxFontVertSize;
if (((length_string_of_point * koef) > maxwidth) and (maxwidth > 0 )) then
 koef := maxwidth / length_string_of_point;

 if (on_) then
 begin
 glPushAttrib(GL_ALL_ATTRIB_BITS);
 glPushMatrix();
 //Перемещение в опорную точку
 glTranslatef (x, y, z);

 glRotatef (az, 0.0, 0.0, 1.0);
 glRotatef (ay, 0.0, 1.0, 0.0);
 glRotatef (ax, 1.0, 0.0, 0.0);

 glRotatef (ax2, 1.0, 0.0, 0.0);
 glRotatef (ay2, 0.0, 1.0, 0.0);
 glRotatef (az2, 0.0, 0.0, 1.0);


 //Перемещение в базовую точку (Откуда тект пишется)
 glTranslatef (0, down_ * koef, 0);
 if (pos[2] = 'c') then z:= gl/2;
 if (pos[2] = 'r') then z:= gl;

 if (pos[0] = 'c') then x:=  -length_string_of_point * koef/2;
 if (pos[0] = 'r') then x:=  -length_string_of_point * koef;

 if (pos[1] = 'c') then y:= -MaxFontVertSize * koef/2;
 if (pos[1] = 'r') then y:=  -MaxFontVertSize * koef;
 //Перемещение в соответствии с смещением alighn
 glTranslatef (x, y, z);

 glScalef(koef, koef, 1);
 glListBase(GLF_START_LIST);
 glCallLists(Length (Litera), GL_UNSIGNED_BYTE, Litera);
 glPopAttrib();
 glPopMatrix();
 end;

height := MaxFontVertSize * koef;
DrawText2 := length_string_of_point * koef;
end;
