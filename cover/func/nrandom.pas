// Функция генерирует значение исходя из нормального распределения
// Как пользоваться     r:=NRand(150,200);
// Значит r = [50;250] пик будет в 150. 
// Идеальное распределение бесконечно, так что это усеченное нормальное распределение.
// Усечение идет за счет последнего if`а, если его закаментировать, то будет простое норм распред.

FUNCTION NRand( Mean : REAL;  StdDev : REAL; koef:real ) : REAL;
VAR
   V1 : REAL;
   V2 : REAL;
   R  : REAL;
   Fac: REAL;

   razbros, temp:real;

//   NRand_Available : BOOLEAN     (* If number already available -- *);
//   Saved_NRand     : REAL        (* saved from last time through.  *);

label ttt;

BEGIN (* NRand *)
   ttt:

//   NRand_Available:=false;  // нет, забыли прошлое значение, оно нам больше не нужно
//   Saved_NRand:=0;          // пусть старое число в центре

   razbros:=StdDev/2;
   StdDev:=StdDev*koef; // коэфициент 0,15 вычислен эксперементально.

                                   (* Return 2nd random number calculated *)
                                   (* last time through here.             *)
{   IF NRand_Available THEN
      BEGIN
         NRand           := Saved_NRand * StdDev + Mean;
         temp:=Saved_NRand * StdDev + Mean;
         NRand_Available := FALSE;
      END
   ELSE}
      BEGIN                        (* Calculate two new random numbers *)
                                   (* using Box-Muller transformation  *)
         REPEAT
            V1 := 2.0 * RANDOM - 1.0;
            V2 := 2.0 * RANDOM - 1.0;
            R  := SQR( V1 ) + SQR( V2 );
         UNTIL (R > 0) AND ( R <= 1.0 );
                                   (* Return 1st number this time, and *)
                                   (* save second one for next time    *)
                                   (* through.                         *)

         Fac             := SQRT( -2.0 * LN( R ) / R );

         NRand           := V1 * Fac * StdDev + Mean;
         temp:=V1 * Fac * StdDev + Mean;

//         Saved_NRand     := V2 * Fac;
//         NRand_Available := TRUE;

      END;

  if (temp > (Mean+razbros)) or (temp < (Mean-razbros)) then goto ttt;

END;
