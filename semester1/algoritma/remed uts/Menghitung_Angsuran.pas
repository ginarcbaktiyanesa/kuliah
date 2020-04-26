program Menghitung_Angsuran;
uses crt;
{I.S. : user memasukkan merk motor, harga motor, uang muka, dan lama angsuran}
{F.S. : menampilkan besar angsuran perbulan dan jumlah sisa angsuran}

var
   Merk : string;
   HargaMotor, UangMuka, AngsuranBulan1, AngsuranBulan2, AngsuranBulan3 , Bunga, Tagihan : real;
   LamaAngsuran, AngsuranPerbulan : integer;
   y : integer;

begin
   gotoxy(54,2);
   writeln('KREDIT MOTOR');
   gotoxy(50,4); write('Merk Motor    : '); readln(Merk);
   gotoxy(50,5); write('Harga Motor   : Rp. '); readln(HargaMotor);
   gotoxy(50,6); write('Uang Muka     : Rp. '); readln(UangMuka);
   gotoxy(50,7); write('Lama Angsuran : '); readln(LamaAngsuran);

   //proses perhitungan
   if (LamaAngsuran = 11)
     then
     begin
       Bunga := 0.2653;
       AngsuranBulan1 := HargaMotor * Bunga;
       AngsuranBulan1 := AngsuranBulan1 + HargaMotor;
       AngsuranBulan2 := AngsuranBulan1 - UangMuka;
       AngsuranBulan2 := AngsuranBulan2 / LamaAngsuran;
       AngsuranBulan3 := 1000 * (AngsuranBulan2 / 1000);
       Tagihan := AngsuranBulan3 * 10;
     end
     else
       if (LamaAngsuran = 17)
       then
       begin
         Bunga := 0.355;
         AngsuranBulan1 := HargaMotor * Bunga;
         AngsuranBulan1 := AngsuranBulan1 + HargaMotor;
         AngsuranBulan2 := AngsuranBulan1 - UangMuka;
         AngsuranBulan2 := AngsuranBulan2 / LamaAngsuran;
         AngsuranBulan3 := 1000 * (AngsuranBulan2 / 1000);
         Tagihan := AngsuranBulan3 * 16;
     end
     else
      if (LamaAngsuran = 23)
        then
        begin
          Bunga := 0.3796;
          AngsuranBulan1 := HargaMotor * Bunga;
          AngsuranBulan1 := AngsuranBulan1 + HargaMotor;
          AngsuranBulan2 := AngsuranBulan1 - UangMuka;
          AngsuranBulan2 := AngsuranBulan2 / LamaAngsuran;
          AngsuranBulan3 := 1000 *(AngsuranBulan2 / 1000);
          Tagihan := AngsuranBulan3 * 16;
        end;

        writeln;
        gotoxy(38,9);
        writeln('Besar Angsuran Per Bulan : Rp. ', AngsuranBulan2:0:2, ' (Rp. ',AngsuranBulan3:0:0,')');
        gotoxy(36,10);
        writeln('Daftar Angsuran Untuk ', LamaAngsuran, ' Bulan Merk Motor ', Merk);
        gotoxy(41,11);
        write('Bayar Angsuran Ke- ');
        gotoxy(64,11);
        write('Sisa Pembayaran');

        // inisialisasi bulan
        y := 12;
        AngsuranPerbulan := 1;
        repeat
          gotoxy(48,y);
          write(AngsuranPerbulan);
          gotoxy(67,y);
          write('Rp. ',Tagihan:0:0);
          Tagihan := Tagihan - AngsuranBulan3;
          AngsuranPerbulan := angsuranPerbulan + 1;
          y := y + 1;
        until (Tagihan < 0);
   readln;
end.
