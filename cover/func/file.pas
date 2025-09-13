
function  SlashSep(Path, FName: string): string;
begin
  if Path[Length(Path)] <> '\' then
   Result:= Path +'\'+ FName
   else Result := Path + FName;
end;



procedure ScanFolder(Folder: string);
var
 st: TSearchRec;
  FileName: string;
begin
 if FindFirst(Folder+'\*.*',faAnyFile ,st)= 0 then  // ���� ����� � �����
  begin
    repeat
      if (st.Name='.') or (st.Name='..') then
       continue;
       FileName:= SlashSep(Folder, st.Name);
//       Application.ProcessMessages; // ����� ���������� ������

//      if kl = 1 then Break;// ��������� �����
 // ��� ����� ��� ���
      if (st.Attr and faDirectory) <> faDirectory then
        begin
//         ShowMessage(FileName);
         DeleteFile(FileName);
        end;
    until FindNext(st) <> 0;

    end;

    FindClose(st);
end;


function GetFileSize2(FileName: string): Int64;
var F: TMemoryStream;
begin
  if NOT FileExists(FileName) then begin Result:=0; exit; end;

  try
    F:=TMemoryStream.Create;
    F.LoadFromFile(FileName);
    Result:=F.Size;
  finally
    F.Free;
  end;
end;
