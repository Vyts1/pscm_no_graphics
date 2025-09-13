//Модуль для работы с данными в конфигурационном файле.
//Функции упрощают использование конфиг. файлов.
//Данный материал можно изменять по Вашему усмотрению...
//При нахождении ошибкок пишите на guedda@yandex.ru

unit MyIni;



interface
uses IniFiles;

procedure WriteIniData(Section, Ident, Value : string);
procedure WriteIniDataInt(Section, Ident : string; Value : Integer);
procedure WriteIniDataBool(Section, Ident : string; Value : boolean);
function ReadIniData(Section, Ident : string; Default : string = '') : string;
function ReadIniDataInt (Section, Ident : string; Default : Integer = 0) : Integer;
function ReadIniDataReal(Section, Ident : string; Default : real = 0) : real;
function ReadIniDataBool(Section, Ident : string; Default : boolean = false) : boolean;

procedure SetPath (S:string);
procedure SetFile (S:string); 



implementation

var
IniFile : TIniFile;
Path : string;
fn:string;

procedure SetPath (S:string); 
begin
 path:=s;
end;


procedure SetFile (S:string); 
begin
 fn:=s;
end;

//config.ini

procedure WriteIniData(Section, Ident, Value : string);

begin

IniFile := TIniFile.Create(Path + '\'+fn);

IniFile.WriteString(Section, Ident, Value);

IniFile.Free;

end;

 

procedure WriteIniDataInt(Section, Ident : string; Value : Integer);

begin

IniFile := TIniFile.Create(Path + '\'+fn);

IniFile.WriteInteger(Section, Ident, Value);

IniFile.Free;

end;

 

procedure WriteIniDataBool(Section, Ident : string; Value : boolean);

begin

IniFile := TIniFile.Create(Path + '\'+fn);

IniFile.WriteBool(Section, Ident, Value);

IniFile.Free;

end;

 

function ReadIniData(Section, Ident : string; Default : string = '') : string;

begin

IniFile := TIniFile.Create(Path + '\'+fn);

Result := IniFile.ReadString(Section, Ident, Default);

IniFile.Free;

end;

 

function ReadIniDataInt(Section, Ident : string; Default : Integer = 0) : Integer;

begin

IniFile := TIniFile.Create(Path + '\'+fn);

Result := IniFile.ReadInteger(Section, Ident, Default);

IniFile.Free;

end;



function ReadIniDataBool(Section, Ident : string; Default : boolean = false) : boolean;

begin

IniFile := TIniFile.Create(Path + '\'+fn);

Result := IniFile.ReadBool(Section, Ident, Default);

IniFile.Free;

end;


function ReadIniDataReal(Section, Ident : string; Default : real = 0) : real;
var s:string;
    r:real;
    cod:integer;
begin

IniFile := TIniFile.Create(Path + '\'+fn);

s:=IniFile.ReadString(Section, Ident, '');

while Pos(',', S) > 0 do
   S[Pos(',', S)] := '.';


  cod:=5; 
  val (s, r, cod);
  if cod = 0 then Result := r
             else Result := Default;

//Result := IniFile.ReadFloat(Section, Ident, Default);

IniFile.Free;

end;



initialization

GetDir(0, Path);
fn:='config.ini';
 

end.
