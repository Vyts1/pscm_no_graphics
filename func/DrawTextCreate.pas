    FillChar(lf, SizeOf(lf), 0);
               lf.lfHeight               :=   -28 ;
               lf.lfWeight               :=   FW_NORMAL ;
               lf.lfCharSet              :=   DEFAULT_CHARSET;
               lf.lfOutPrecision         :=   OUT_DEFAULT_PRECIS ;
               lf.lfClipPrecision        :=   CLIP_DEFAULT_PRECIS ;
               lf.lfQuality              :=   DEFAULT_QUALITY ;
               lf.lfPitchAndFamily       :=   FF_DONTCARE OR DEFAULT_PITCH;
               lstrcpy (lf.lfFaceName, 'Tahoma') ;

//==============================================================================
//Это полигонизирует шрифт
hFontNew := CreateFontIndirect(lf);
hOldFont := SelectObject(DC,hFontNew);

//wglUseFontOutlines(DC, 0, 255, GLF_START_LIST, 0.0, gl, WGL_FONT_POLYGONS, @gmf1);
wglUseFontOutlines(DC, 0, 255, GLF_START_LIST, 0.0, 0, WGL_FONT_POLYGONS, @gmf1);

//wglUseFontOutlines(DC, 0, 255, GLF_START_LIST, 0.0, 0.002, WGL_FONT_POLYGONS, @gmf2);


DeleteObject(SelectObject(DC,hOldFont));
DeleteObject(SelectObject(DC,hFontNew));
//==============================================================================
