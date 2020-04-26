program Coklat_Gratis;
uses crt;
{I.S. : user memasukkan jumlah bungkus coklat yang ditukarkan}
{F.S. : menampilkan total coklat gratis yang diterima}

var
   Bungkus, X, Total_Coklat : integer;

begin
   gotoxy(45,10);
   writeln('<< PENUKARAN COKLAT GRATIS >>');
   writeln;
   gotoxy(50,12);
   write('Bungkus       : '); readln(Bungkus);
   if (Bungkus <= 100)
     then
     begin
       while (Bungkus <> 1) do
       begin
         if (Bungkus mod 3 = 1)
           then
           begin
             Bungkus := Bungkus div 3;
             X := Bungkus + 1;
             Total_Coklat := Total_Coklat + Bungkus;
             Bungkus := X;
           end
           else
             if (Bungkus mod 3 = 0)
               then
               begin
                 Bungkus := Bungkus div 3;
                 Total_Coklat := Total_Coklat + Bungkus;
               end
               else
                 if (Bungkus = 1)
                   then
                   begin
                     Total_Coklat := Total_Coklat + 1;
                     Bungkus := 0;
                   end;
                 end;
                    gotoxy(50, 13);
                    writeln('Coklat Gratis : ', Total_Coklat);
               end
               else
               begin
                  writeln('Bungkus Coklat Yang Dapat Ditukar Maksimum 100 Bungkus');
               end;
   readln;
end.
