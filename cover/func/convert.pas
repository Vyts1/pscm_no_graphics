//function submastosubmas2 (x:integer; t1,t2:integer):integer;
//begin
//     submastosubmas2:=x;
//
//     if x>t2 then submastosubmas2:=x+4;
//     if x=t2 then submastosubmas2:=x+2;
//     if (x>t1) and (x<t2) then submastosubmas2:=x+2;
//     if (x=t1)  then submastosubmas2:=x+2;
//     if (x<t1)  then submastosubmas2:=x+0;
//
//end;
//
//function submas2tosubmas (x:integer; t1,t2:integer):integer;
//var x2:integer;
//begin
//     if (x = t1) or (x = t1+1) or
//        (x = t2+3) or (x = t2+4)
//     then
//      begin
//        x2:=-1;
//        // ïîïàëî âî âñòàâûøû
//      end
//     else
//      begin
//        //ïğåîáğàçóåì.
//        if (x>=0) and (x<t1) then x2:=x
//                             else if (x>=t1+2) and (x<=t2+2) then x2:=x-2
//                                                             else x2:=x-4;
//
//
//      end;
//
// submas2tosubmas:=x2;
//end;
