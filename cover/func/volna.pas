procedure GetPredok (izvx, izvy:integer; xc, yc:integer; R:integer; var rezX:integer; var rezY:integer );
var
    l:real;

    signX, signY : integer;
    x1,x2,y1,y2 : integer;

begin

    if izvx < xc then signX := -1
                 else signX := +1;
    if izvy < yc then signY := -1
                 else signY := +1;


    x2 := izvx - signX;
    y2 := izvy - signY;
    l := sqrt ( sqr(xc-x2) + sqr(yc-y2) );

    if UpRound(l) = R then begin rezx:=x2; rezy:=y2; end
                             else
                               begin
                                x1 := izvx - signX;
                                y1 := izvy;

                                l := sqrt ( sqr(xc-x1) + sqr(yc-y1) );
                                if UpRound(l) = R then begin rezx:=x1; rezy:=y1; end
                                                         else
                                                          begin
                                                            rezx:=izvx;
                                                            rezy:=izvy - signY;
                                                          end;

                               end;
end;


procedure GetPredok2 (izvx, izvy:integer; xc, yc:integer; R:integer; var rezX:integer; var rezY:integer );
var
    l1,l2,l3:real;

    signX, signY : integer;
    x1,x2,y1,y2,x3,y3 : integer;

begin

    if izvx < xc then signX := -1
                 else signX := +1;
    if izvy < yc then signY := -1
                 else signY := +1;


    x1 := izvx;
    y1 := izvy - signY;

    x2 := izvx - signX;
    y2 := izvy - signY;

    x3 := izvx - signX;
    y3 := izvy;


    l1 := sqrt ( sqr(xc-x1) + sqr(yc-y1) );
    l2 := sqrt ( sqr(xc-x2) + sqr(yc-y2) );
    l3 := sqrt ( sqr(xc-x3) + sqr(yc-y3) );

    if (l1 <= l2) AND (l1<=l3) then
      begin
        rezx:=x1;
        rezy:=y1;
        exit;
      end;

    if (l2 <= l1) AND (l2<=l3) then
      begin
        rezx:=x2;
        rezy:=y2;
        exit;
      end;

    if (l3 <= l1) AND (l3<=l2) then
      begin
        rezx:=x3;
        rezy:=y3;
        exit;
      end;
   log(' GetPredok2 - Жопа');
end;



function GetRad (dy, dx:real):real;
var r:real;

begin
  if dx<>0 then r:= arctan (dy / dx)
           else r:= pi/2;

  if (dx<0) and (dy<0) then r:=r+pi;
  if (dx<0) and (dy>0) then r:=r+pi;
  if (dx>0) and (dy<0) then r:=r+2*pi;

  GetRad:= 180*r/pi;
end;


function RaschetProvisaniya (Ri, Si_pred, Si_pred_R, hs, Rp, Rs, Up, divizor: real ):real;
var  alfa, hc, c2, c0, c1,  Ro_mod, Up_mod : real;

begin

 case iniVar.metod_provisaniya of

  1 :
      begin
     //  log ('Тип расчета провисания: Up/*');
       alfa:=Ln(Rp/hs)/Ln(Rs/Rp)*iniVar.koef_provisaniya;
       if divizor=0 then RaschetProvisaniya := Si_pred+Rp*(exp(-alfa * ln(Ri/Rp))-  exp(-alfa * ln((Si_pred_R)/Rp)) )
                    else RaschetProvisaniya := Si_pred+(Up/divizor)*Rp*(exp(-alfa * ln(Ri/Rp))-exp(-alfa * ln((Si_pred_R)/Rp)) );
      end;

  2 : begin
     //  log ('Тип расчета провисания: (Up/*)^2');
       alfa:=Ln(Rp/hs)/Ln(Rs/Rp)*iniVar.koef_provisaniya;
       if divizor=0 then RaschetProvisaniya := Si_pred+Rp*(exp(-alfa * ln(Ri/Rp))-  exp(-alfa * ln((Si_pred_R)/Rp)) )
                    else RaschetProvisaniya := Si_pred+sqr(Up/divizor)*Rp*(exp(-alfa * ln(Ri/Rp))-exp(-alfa * ln((Si_pred_R)/Rp)) );
      end;

  3 :
      begin
       hc := hs / 2;
       alfa := 1;

       c0 := iniVar.const_c0;

       Ro_mod := 3960;
       Up_mod := 483;
       //   c1 := Ro_mod * sqr(Up_mod);
       c1 := 1;
       c2 := c0 * iniVar.part_class.m_ROml*sqr(Up) / c1 ;

       //   RaschetProvisaniya := Si_pred+ c2*Si_pred_R* (Si_pred_R/Ri -1) * hc * (Ri/Si_pred_R - 1) ;
       RaschetProvisaniya := Si_pred + c2*Si_pred_R* (Si_pred_R/Ri -1) - hc * (Ri/Si_pred_R - 1) ;

//       log ('Тип расчета провисания: через c0, c1, c2, Ro_mod, Up_mod, hc'+floattostr(c0)+floattostr(c1)+floattostr(c2)+floattostr(Ro_mod)+floattostr(Up_mod)+floattostr(hc));
      end;

  else
    begin
      showmessage ('Капут! метод провисания не определен');
      Application.terminate;
    end;
 end;

end;
//}

{
function RaschetProvisaniya (Ri, Si_pred, Si_pred_R, hs, Rp, Rs, Up: real):real;
var   alfa:real;
begin
  //K
    alfa:=Ln(Rp/hs)/Ln(Rs/Rp)*iniVar.koef_provisaniya;
    RaschetProvisaniya := Si_pred+(Up/200)*Rp*(exp(-alfa * ln(Ri/Rp))-exp(-alfa * ln((Si_pred_R)/Rp)) );
end;
//}
{
function RaschetProvisaniya (Ri, Si_pred, Si_pred_R, hs, Rp, Rs, Up: real):real;
var   alfa:real;
begin
  //K^2

    alfa:=Ln(Rp/hs)/Ln(Rs/Rp)*iniVar.koef_provisaniya;
    RaschetProvisaniya := Si_pred+sqr(Up/200)*Rp*(exp(-alfa * ln(Ri/Rp))-exp(-alfa * ln((Si_pred_R)/Rp)) );
end;
//}

procedure GetLast (izvx, izvy:integer; xc, yc:integer; Rs:integer; var rezX:integer; var rezY:integer );
var l:real;
    minX, maxX, minY, maxY, i, j, t1, t2:integer;
    angl, tmpangl, izvangl:real;
begin
 l:= (sqrt ( sqr(xc-izvx) + sqr(yc-izvy) ));

 t1:=round(xc + (Rs)*(izvx-xc)/l);
 t2:=round(yc + (Rs)*(izvy-yc)/l);

 rezX:=xc;
 rezY:=yc;
 angl:=0;
 izvangl:= GetRad (izvy-yc, izvx-xc);

 minX := t1-2;
 maxX := t1+2;

 minY := t2-2;
 maxY := t2+2;


 for i:=minX to maxX do
  for j:=minY to maxY do
   begin
    t1:= UpRound( sqrt ( sqr(xc-i) + sqr(yc-j) ) );
    if  t1 = Rs then
                                                     begin
                                                      if  (rezX=xc) and (rezY=yc) then
                                                        begin
                                                         rezX:=i;
                                                         rezY:=j;
                                                         angl:= GetRad (j-yc, i-xc);
                                                        end
                                                                                  else
                                                        begin
                                                          tmpangl:= GetRad (j-yc, i-xc);
                                                          if abs (angl-izvangl) > abs(tmpangl-izvangl) then
                                                                        begin
                                                                          angl:=tmpangl;
                                                                          rezX:=i;
                                                                          rezY:=j;
                                                                        end;
                                                        end;
                                                     end;
   end;
//}



end;
