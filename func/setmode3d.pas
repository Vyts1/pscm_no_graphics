procedure setmode3d (m:integer);
begin
 if OpenGLmode <> m then
                 begin
                   if (m >=0) AND (m <= 5) then
                                           begin
                                             OpenGLmode:=m;
                                             alfaX:=215;  alfaY:=135;  alfaZ:=65;
                                             centX:=0;  centY:=0;  centZ:=0;
                                             scale:=1.5;
                                             if m=3 then fix:=true
                                                    else fix:=false;
                                           end;

                 end;

end;
