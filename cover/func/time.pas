//floattostr(    trunc(((end_time_korektirovka_volni - begin_time_korektirovka_volni)/freq_HRT_korektirovka_volni)*1000*1000*10)/10            ) + ' ìêñ.'
function timeclc (freq_HRT, begin_time, end_time:int64):real; inline;
begin
   if (end_time>begin_time) AND (freq_HRT<>0) then   timeclc:= trunc(((end_time - begin_time)/freq_HRT)*1000*1000*10)/10 // + ' ìêñ.'
                          else
                           begin
//                             if (freq_HRT=0) AND (freq_HRT_prgstrt<>0) then
                             if (freq_HRT=0)  then

//                              timeclc:= trunc(((end_time - begin_time)/freq_HRT_prgstrt)*1000*1000*10)/10 // + ' ìêñ.'

                             timeclc:= -1
                                           else timeclc:= 0;
                           end;


end;
