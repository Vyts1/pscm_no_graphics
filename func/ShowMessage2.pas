procedure ShowMessage2 (T:TErrorArray; s:string);
begin
 if Lang=0 then ShowMessage(T.RU+' '+s)
           else ShowMessage(T.EN+' '+s);
end;
