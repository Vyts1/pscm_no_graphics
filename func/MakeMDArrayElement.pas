// Главный массив меню
function MakeMD11ArrayElement2 (codenum:integer; numVertGrid: integer; filenameRU, filenameEN, RU, EN:string; R:real; I:integer; B:boolean; tp:byte)  :TMD11Array;
var a:TMD11Array;
    i2:integer;
begin
{ for I2 := 1 to count_md_items do
   begin
     if MD11Array[i2].codenum = codenum then
       showmessage('Повтор индекса codenum:'+inttostr(codenum));
   end;
 }

 a.codenum := codenum;
 a.menunum := numVertGrid;

 a.imgfileRU:=filenameRU;
 a.imgfileEN:=filenameEN;
 a.RU:=RU;
 a.EN:=EN;
 a.tip:=tp;
 a.index:=-1;
 a.visible:=true;
 a.valueR:=R;
 a.valueI:=I;
 a.valueB:=B;

 MakeMD11ArrayElement2:=a;
end;


// Массив который в корреляциях, имя функции 
function MakeMD3ArrayElement (filename, RU, EN:string; w:boolean)  :TMD3Array;
var a:TMD3Array;
begin
 a.imgfile:=filename;
 a.RU:=RU;
 a.EN:=EN;
 a.index:=-1;
 a.visible:=w;
 MakeMD3ArrayElement:=a;
end;
