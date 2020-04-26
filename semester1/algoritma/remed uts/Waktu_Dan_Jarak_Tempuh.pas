program Waktu_Dan_Jarak_Tempuh;
uses crt;
{I.S. : user memasukkan waktu mulai dan waktu berakhir}
{F.S. : menampilkan waktu dan jarak tempuh}

var
   JamMulai, MenitMulai, DetikMulai, JamAkhir, MenitAkhir, DetikAkhir, i : integer;
   Jam, Menit, Detik, Jarak, Tempuh, TotalDetik, DetikTempuh, MenitTempuh, JamTempuh : integer;
   JarakTempuh_KM, KecepatanTempuh, JarakTempuh : real;

begin
   write('Mulai Pukul : '); readln(JamMulai);
   write(' '); readln(MenitMulai);
   write(' '); readln(DetikMulai);

   //validasi jam
   while (JamMulai < 0) or (MenitMulai < 0) or (DetikMulai < 0) do
     begin
      writeln('Waktu Tidak Boleh Negatif, Tekan Enter Untuk Input Kembali');
      readln(JamMulai);
      readln(MenitMulai);
      readln(DetikMulai);
     end;

   //validasi menit dan detik
   while (MenitMulai > 60) or (DetikMulai > 60) do
     begin
      writeln('Menit atau Detik < 60, Tekan Enter Untuk Input Kembali');
      readln(MenitMulai);
      readln(DetikMulai);
     end;

    write('Berakhir Pukul    : '); readln(JamAkhir);
    write(' '); readln(MenitAkhir);
    write(' '); readln(DetikAkhir);

    //validasi jam
    while (jamakhir<0) or (menitakhir<0) or (detikakhir<0) do
     begin
      writeln('Waktu Tidak Boleh Negatif, Tekan Enter Untuk Input Kembali');
      readln(jamakhir);
      readln(menitakhir);
      readln(detikakhir);
     end;

    //validasi menit dan detik
    while (menitakhir>60) or (detikakhir>60) do
     begin
      writeln('Menit atau Detik < 60, Tekan Enter Untuk Input Kembali');
      readln(menitakhir);
      readln(detikakhir);
     end;

    if (DetikAkhir < DetikMulai)
     then
     begin
       DetikAkhir := DetikAkhir + 60;
       MenitAkhir := MenitAkhir - 1;
     end;
       DetikTempuh := DetikAkhir - DetikMulai;

   if (MenitAkhir < MenitMulai)
     then
     begin
       MenitAkhir := MenitAkhir + 60;
       JamAkhir := JamAkhir - 1;
     end;
       MenitTempuh := MenitAkhir - MenitMulai;

   if(DetikAkhir>=DetikMulai)
     then
     begin
       Detik := detikakhir - detikmulai;
       if(menitakhir>=menitmulai)
         then
         begin
           menit := menitakhir - menitmulai;
           if(jamakhir >= jammulai)
             then
             begin
               jam := jamakhir - jammulai;
             end;
           end;
         end;

   if (JamAkhir < JamMulai)
     then
     begin
       JamAkhir := JamAkhir + 12;
     end;
       JamTempuh := JamAkhir - JamMulai;

   if Jam <> 0 then
     begin
      JamTempuh := Jam*3600;
     end;
    if menit <> 0 then
        begin
         MenitTempuh := Menit*60;
        end;

    TotalDetik := Detik + MenitTempuh + JamTempuh;

    Jaraktempuh := 0;
    KecepatanTempuh := 5;
    for i := 1 to TotalDetik do
     begin
      if (i mod 600 = 0)
       then
       begin
        KecepatanTempuh +=1
       end;
      JarakTempuh := JarakTempuh + KecepatanTempuh;

     end;
    JarakTempuh_KM := JarakTempuh/1000;

    writeln('Waktu Tempuh   : ',Jam,' Jam ',Menit,' Menit ',Detik,' Detik ');
    writeln('Jarak Tempuh   : ',JarakTempuh_KM:0:1);
   readln;
end.
