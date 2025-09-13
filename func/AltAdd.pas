function AltAdd(ImageList: TImageList; Bitmap: TBitmap; MaskColor: TColor):integer;
var Temp: TBitmap;
begin
 with ImageList do
   if (Bitmap.Width <> Width) or (Bitmap.Height <> Height) then begin
     Temp := TBitmap.Create;
     try
       Temp.Width := Width;
       Temp.Height := Height;
       Temp.Canvas.Brush.Color := MaskColor;
       Temp.Canvas.FillRect(Temp.Canvas.ClipRect);
          // здесь оставишь только одну нужную строку
//     1 вариант с искажением  Temp.Canvas.StretchDraw(Bitmap.Canvas.ClipRect, Bitmap);
//     2 вариант с центрированием Temp.Canvas.Draw((Temp.Width-Bitmap.Width) div 2,(Temp.Height-Bitmap.Height) div 2, Bitmap);
       Temp.Canvas.Draw((Temp.Width-Bitmap.Width) div 2,(Temp.Height-Bitmap.Height) div 2, Bitmap);

       AltAdd:=AddMasked(Temp, MaskColor);
     finally
       Temp.Free;
     end;
   end
   else
     AltAdd:=ImageList.AddMasked(Bitmap, MaskColor);
end;
