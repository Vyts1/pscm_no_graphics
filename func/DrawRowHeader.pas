procedure TForm1.cxVerticalGrid1DrawRowHeader(Sender: TObject;
  ACanvas: TcxCanvas; APainter: TcxvgPainter;
  AHeaderViewInfo: TcxCustomRowHeaderInfo; var Done: Boolean);

var u:integer;
    MyRect, MyOther: TRect;
    tempimage:Tbitmap;
begin
  u:=AHeaderViewInfo.Row.Tag;

//  if (AHeaderViewInfo is TcxMultiEditorRowHeaderInfo) AND (u>=1 ) AND (u<=count_md_items) AND (MD11Array[u].tip=3) then
  if ((AHeaderViewInfo is TcxMultiEditorRowHeaderInfo) OR (AHeaderViewInfo is TcxEditorRowHeaderInfo)) AND (u>=1 ) AND (u<=count_md_items)  then
   begin




    with AHeaderViewInfo do
      begin
        Transparent := True;
        ACanvas.Brush.Color := ViewParams.Color;
//        ACanvas.FillRect(HeaderRect);
        ACanvas.FillRect(HeaderRect, ClWhite);
        ACanvas.Font.Color := ClBlack;

        if (MD11Array[u].index = -1)
           then
             begin
               if Lang=0 then ACanvas.DrawTexT( MD11Array[u].RU, HeaderRect, cxAlignLeft or cxAlignVCenter or cxShowEndEllipsis) // центрирование текста
                         else ACanvas.DrawTexT( MD11Array[u].EN, HeaderRect, cxAlignLeft or cxAlignVCenter or cxShowEndEllipsis); // центрирование текста
             end
           else
             begin

               tempimage:=TBitmap.Create;
               //tempimage.LoadFromFile('23.bmp');
               //ImageList1.GetBitmap(0,Image1.Picture.Bitmap);
               case MD11Array[u].menunum of
                 1: ImageList4md1.GetBitmap(MD11Array[u].index, tempimage);
                 2: ImageList4md1.GetBitmap(MD11Array[u].index, tempimage);
                 3: ImageList4md3.GetBitmap(MD11Array[u].index, tempimage);
                 4: ImageList4md4.GetBitmap(MD11Array[u].index, tempimage);
                 5: ImageList4md5.GetBitmap(MD11Array[u].index, tempimage);
               end;
               {
               if (u<=25) then ImageList4md1.GetBitmap(MD11Array[u].index, tempimage);
               if ((u>=26) and (u<=54)) then ImageList4md1.GetBitmap(MD11Array[u].index, tempimage);
               if (u>=55) and (u<=77)  then ImageList4md3.GetBitmap(MD11Array[u].index, tempimage);
               if (u>=78) and (u<=106) then ImageList4md4.GetBitmap(MD11Array[u].index, tempimage);
               if (u>=107) and (u<=125)  then ImageList4md5.GetBitmap(MD11Array[u].index, tempimage);
               }
               
//               ImageList4md1.GetBitmap(MD11Array[u].index, tempimage);

               MyRect := Rect(0,0,tempimage.Width,tempimage.Height);

               MyOther:=HeaderRect;

               MyOther.Right:=MyOther.Left+tempimage.Width;
               MyOther.Bottom:=MyOther.Top+tempimage.Height;
               u:=HeaderRect.Right-HeaderRect.Left-tempimage.Width;
               u:=u div 2;
               MyOther.Left:=MyOther.Left+u;
               MyOther.Right:=MyOther.Right+u;

               u:=HeaderRect.Bottom-HeaderRect.Top-tempimage.Height;
               u:=u div 2;
               MyOther.Top:=MyOther.Top+u;
               MyOther.Bottom:=MyOther.Bottom+u;

               ACanvas.CopyRect(MyOther, tempimage.Canvas, MyRect);
               //ACanvas.CopyRect(HeaderRect, tempimage.Canvas, MyRect); // полное растяжение
               tempimage.Free;

             end;



        Done := True;
      end;


   end;




end;
