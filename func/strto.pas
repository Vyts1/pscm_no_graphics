function strtoint2 (str:string; error:integer):integer;
var r:integer;
    Code: Integer;
begin
  Val(str, r, Code);
  if Code <> 0 then strtoint2:=error else strtoint2:=r;
end;


function strtofloat2 (str:string; error:real):real;
var r:real;
    Code: Integer;

begin
//  S := '   123.5';
  { Convert spaces to zeros }
  while Pos(',', STR) > 0 do
    STR[Pos(',', STR)] := '.';


  Val(str, r, Code);
  if Code <> 0 then strtofloat2:=error else strtofloat2:=r;
end;
