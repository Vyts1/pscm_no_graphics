procedure write_rectangle (x1,y1,x2,y2:integer; c1,c2:TColor; canva:TCanvas);
var w:boolean;
    tmp:integer;
begin

 canva.pen.color:=c1;
 canva.Brush.color:=c2;

 w:=true;

 if x2<x1 then
           begin
            tmp:=x2;
            x2:=x1;
            x1:=tmp;
           end;


 if y2<y1 then
           begin
            tmp:=y2;
            y2:=y1;
            y1:=tmp;
           end;

 if w AND (x1=x2) AND (y1=y2) then
                         begin
                           canva.Pixels[x1,y1]:=c1;
                           w:=false;
                         end;

 if w AND (x1=x2) then
             begin
              canva.MoveTo(x1,y1);
              canva.LineTo(x2,y2+1);
              w:=false;
             end;

 if w AND (y1=y2) then
             begin
              canva.MoveTo(x1,y1);
              canva.LineTo(x2+1,y2);
              w:=false;
             end;

 if w then
             begin
              Canva.Rectangle(x1, y1, x2+1, y2+1);
              //w:=false;
             end;

end;
