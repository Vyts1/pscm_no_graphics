constructor CCutBoxSet.Create;
begin
//--------
  connected:= 0; //We are not connected to the server
  inherited Create;
end;

function CCutBoxSet.Open ():boolean; // для открытия и закрытия БД
var
   host, user, passwd: String;

   db: String;
   retval: Integer;

begin
  if connected=1 then Open:=true
                 else Open:=false;
//---------
end;

function CCutBoxSet.Close ():boolean;
begin
    Close:=true; 
end;


destructor CCutBoxSet.Destroy;
begin

  inherited Destroy;
//----------
end;


function CCutBoxSet.Move (inp:integer): boolean;
var
     i2:integer;
     b:boolean;

begin



                                      DataModule1.ADOTable1.Open;
                                      DataModule1.ADOTable1.First;

                                      i2:=0;
                                      b:=false;
                                        repeat
                                        begin

                                          if strtoint (DataModule1.ADOTable1.FieldByName('nId').AsString) = inp then b:=true
                                          else 
                                            begin 
                                             try
                                             DataModule1.ADOTable1.Next;
                                             i2:=i2+1;
                                             except
                                              break;
                                             end;
                                            end;
                                        end //}
                                        until b;

if not b then showmessage ('Нет такокого материала с индексом '+inttostr(inp))
         else
          begin
m_nId     :=strtoint (DataModule1.ADOTable1.FieldByName('nId').AsString);
m_Material:=DataModule1.ADOTable1.FieldByName('Material').AsString;
m_ROms    :=strtofloat2 (DataModule1.ADOTable1.FieldByName('ROms').AsString,0);
m_ROml    :=strtofloat2 (DataModule1.ADOTable1.FieldByName('ROml').AsString,0);
m_CPms    :=strtofloat2 (DataModule1.ADOTable1.FieldByName('CPms').AsString,0);
m_CPml    :=strtofloat2 (DataModule1.ADOTable1.FieldByName('CPml').AsString,0);
m_Lms     :=strtofloat2 (DataModule1.ADOTable1.FieldByName('Lms').AsString,0);
m_Lml     :=strtofloat2 (DataModule1.ADOTable1.FieldByName('Lml').AsString,0);
m_Tm      :=strtofloat2 (DataModule1.ADOTable1.FieldByName('Tm').AsString,0);
m_TBoil   :=strtofloat2 (DataModule1.ADOTable1.FieldByName('TBoil').AsString,0);
m_Lm      :=strtofloat2 (DataModule1.ADOTable1.FieldByName('Lm').AsString,0);



m_MUml    :=strtofloat2 (DataModule1.ADOTable1.FieldByName('MUml').AsString,0);
m_SIGml   :=strtofloat2 (DataModule1.ADOTable1.FieldByName('SIGml').AsString,0);


m_LBoil   :=strtofloat2 (DataModule1.ADOTable1.FieldByName('LBoil').AsString,0);


m_AW      :=strtofloat2 (DataModule1.ADOTable1.FieldByName('AW').AsString,0);


          end;
                                //      showmessage ('Выбран материал: '+DataModule1.ADOTable1.FieldByName('Material').AsString);
                                      DataModule1.ADOTable1.close;



end;



