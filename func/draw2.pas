
 //создаем окошко openGL
 DC := GetDC (CenterPanel.Handle);

 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (DC, @pfd);
 SetPixelFormat (DC, nPixelFormat, @pfd);

 hrc := wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
 glClearColor (1.0, 1.0, 1.0, 1.0); // цвет фона
 glLineWidth (0.5);
 glEnable(GL_DEPTH_TEST); // включение теста глубины

 glEnable (GL_LIGHTING);
 glEnable (GL_LIGHT0);
 glEnable (GL_DEPTH_TEST);
 glEnable (GL_COLOR_MATERIAL);  // }

 {$I 'func\DrawTextCreate.pas'} // <---3
 
 setmode3d(0);


 


