{
procedure randinit(i:Cardinal);
var k:Integer;
begin
 mtwist_mt[0]:=i and $ffffffff;
 for k:=1 to mtwist_n do begin
  mtwist_mt[k]:=(1812433253 * (mtwist_mt[k-1] xor (mtwist_mt[k-1] shr 30)) + k);
  mtwist_mt[k]:=mtwist_mt[k] and $ffffffff;
 end;
 mtwist_mti:=0;
end;

function mrand:Cardinal;
var y:Cardinal;  kk:integer;
 mag01:Array[0..1] of Cardinal;
begin
    mag01[0]:=0;mag01[1]:=$9908b0df;
    if (mtwist_mti >= mtwist_N) then begin
        if (mtwist_mti = mtwist_N+1) then  randinit(5489);
        kk:=0; while kk<=(mtwist_N-mtwist_M) do begin
            y := (mtwist_mt[kk] and UPPER_MASK) or (mtwist_mt[kk+1] and LOWER_MASK);
            mtwist_mt[kk] := mtwist_mt[kk+mtwist_M] xor (y shr 1) or mag01[y and 1];
           inc(kk);
        end;
        while kk<(mtwist_N-1) do begin
            y := (mtwist_mt[kk] and UPPER_MASK) or (mtwist_mt[kk+1] and LOWER_MASK);
            mtwist_mt[kk] := mtwist_mt[kk+(mtwist_M-mtwist_N)] or (y shr 1) xor mag01[y and 1];
         inc(kk);
        end;

        y := (mtwist_mt[mtwist_N-1]  and UPPER_MASK)or(mtwist_mt[0] and LOWER_MASK);
        mtwist_mt[mtwist_N-1] := mtwist_mt[mtwist_M-1] xor (y shr 1) xor mag01[y and 1];

        mtwist_mti := 0;
    end;

    y := mtwist_mt[mtwist_mti];inc(mtwist_mti);

    y := y xor (y shr 11);
    y := y xor ((y shl 7) and $9d2c5680);
    y := y xor ((y shl 15) and $efc60000);
    y := y xor (y shr 18);

    result:=y;
end;


function MersentRand (A : integer) : integer;
var t:cardinal;
begin
  t:=mrand;
//  MersentRand := t mod A; // мое преобразование

//  MersentRand :=  trunc (t / ($ffffffff/(A+1)) );

  MersentRand :=  round (t * ((A-1)/$ffffffff) );
  
end;
 }