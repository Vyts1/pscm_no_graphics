procedure put_to_shablon (tmpc,i,j:integer; c:byte);
begin
      try
        SetLength(shablon_array[tmpc], Length(shablon_array[tmpc])+1);
      except
//        showMessage ('Кончилась память при генерации шаблона');
        log ('Кончилась память при генерации шаблона, ситльно маленький шаг дискретизации '+SysErrorMessage(GetLastError));
        Application.Terminate;

      end;
      shablon_array[tmpc,High(shablon_array[tmpc])].x:=i;
      shablon_array[tmpc,High(shablon_array[tmpc])].y:=j;
//      shablon_array[tmpc,High(shablon_array[tmpc])].c:=c;


      if abs(i)<>abs(j) then
               begin
                if i>=0 then
                         begin
                          if abs(j)<abs(i) then
                                        shablon_array[tmpc,High(shablon_array[tmpc])].c:=3
                                      else
                                       begin
                                       if j<0 then
                                                shablon_array[tmpc,High(shablon_array[tmpc])].c:=4
                                              else
                                                shablon_array[tmpc,High(shablon_array[tmpc])].c:=2;
                                       end;

                         end
                        else
                         begin
                          if abs(j)<abs(i) then
                                            begin
                                             if j<0 then shablon_array[tmpc,High(shablon_array[tmpc])].c:=5
                                                    else shablon_array[tmpc,High(shablon_array[tmpc])].c:=1
                                            end
                                           else
                                            begin
                                             if j<0 then shablon_array[tmpc,High(shablon_array[tmpc])].c:=4  else shablon_array[tmpc,High(shablon_array[tmpc])].c:=2;
                                            end;

                         end;
               end
              else
               begin
                if i>0 then
                        begin
                         if j>0 then shablon_array[tmpc,High(shablon_array[tmpc])].c:=3
                                else shablon_array[tmpc,High(shablon_array[tmpc])].c:=3;
                        end
                       else
                        begin
                         if j>0 then shablon_array[tmpc,High(shablon_array[tmpc])].c:=1
                                else shablon_array[tmpc,High(shablon_array[tmpc])].c:=5;
                        end;
               end;




end;
