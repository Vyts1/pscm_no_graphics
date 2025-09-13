function convertX (x,kb,basepoint:real):real;
//var max:real;
begin
// metok
// max:=8;

// convertX:=((max*(x-(metok+1)/2))/(metok));
//  kb  metok


  convertX:=((x*kb)/(metok+1)) + basepoint;

  //Меняем местами оси
//  convertX:=(( (metok - x )*kb)/(metok+1)) + basepoint;
end;


function convertX3 ( x, linx, minarg, kfx, ScecSizeX2 : real):real;
begin
 //
 //
{  if c='x' then
            begin
             //? = linx + (X-minarg)  * kfx - ScecSizeX2;
             convertX3:= linx + (X-minarg)  * kfx - ScecSizeX2;
            end
           else
            begin}
             convertX3:= linx + (X-minarg)  * kfx - ScecSizeX2;
           // end;




end;


 //       (data_max-data_min)  0.8
 //         data[I2][0]         x
 //       x:= (data[I2][0]*0.8)/(data_max-data_min)

 






