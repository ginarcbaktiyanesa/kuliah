program MenghitungIPMahasiswa;
uses crt;
const
  MaxMhs = 10; //maksimal data mahasiswa
  MaxMk  = 5;  //maksmimal data mata kuliah
type
  MataKuliah = record
    KodeMk : string;
    NamaMk : string;
    SKS    : integer;
  end; //endrecord

  RecNilai = record
    Nilai   :integer;
    indeks  :char;
    Bobot   :integer;
  end; //endrecord

  //tipe data buatan dari record nilai
  ArrayNilai     = Array[1..MaxMk] of RecNilai;

  Mhsiswa = record
    Nama       : string;
    NIM        : string;
    NilaiMhs   : ArrayNilai;
    IP         : real;
  end; //endrecord

  Kelas = record
    NmKelas   :string;
    M         :integer;    //Jumlah Mahasiswa
    N         :integer;   //Jumlah Mata kuliah
    TotalSKS  :integer;
    Semester  :char;
  end; //endrecord

  //tipe data buatan
  ArrayMhs = array[1..MaxMhs] of Mhsiswa;
  ArrayMK  = array[1..MaxMk] of MataKuliah;

var
  Mahasiswa            : ArrayMhs;
  Matkul               : ArrayMk;
  DataKelas            : Kelas;
  Menu                 : integer;

function CekKodeMatkul(KodeMkCek : string; IndeksTerakhir : integer; Matkul : ArrayMk) : boolean; //untuk kode mata kuliah unik
{I.S.: Kode mata kuliah pada data mata kuliah dan indeks terakhir sudah terdefinisi}
{F.S.: Mengembalikan nilai true jika Kode mata kuliah yang diinput sudah ada}
var 
  i : integer;
begin
  CekKodeMatkul := false;
  i := 1;
  while (not CekKodeMatkul) and (i < IndeksTerakhir) do
    if(Matkul[i].KodeMk = KodeMkCek)
      then
        CekKodeMatkul := true
      else
        i := i + 1;
end; //endfunction

function CekNIM(NIMDicek : string; Mahasiswa : ArrayMhs; IndeksTerakhir : integer) : boolean; //untuk NIM unik
{I.S: NIM pada data mahasiswa dan indeks terakhir sudah terdefenisi}
{F.S: Mengembalikan nilai true jika NIM yang diinput sudah ada}
var 
  i : integer;
begin
  CekNIM := false;
  i := 1;
  //jika NIM sudah ada, maka validasi NIM bernilai true dan sebaliknya
  while (not CekNIM) and (i < IndeksTerakhir) do
    if(Mahasiswa[i].NIM = NIMDicek)
      then
        CekNIM := true
      else
        i := i +1;
end; //endfunction

procedure IsiDataMahasiswa(var Mahasiswa:ArrayMhs; var DataKelas:kelas);
{I.S: User memasukkan kelas, semester, banyaknya mhasiswa, banyaknya mata kuliah, NIM dan nama mahasiswa}
{F.S: Menghasilkan NIM dan nama mahasiswa pada record mahasiswa(1:M)}
var 
  i,No,j:integer;
begin
  //memasukkan kelas dan semester
  write('Kelas                 : IF-'); readln(DataKelas.NmKelas);
  write('Semester              : '); readln(DataKelas.Semester);

  //memasukkan banyaknya mahasiswa
  write('Banyaknya Mahasiswa   : '); readln(DataKelas.M);

  //validasi banyaknya data mahasiswa
  while(DataKelas.M > MaxMhs) do
  begin
    gotoxy(1,4); textcolor(yellow);
    writeln('Banyaknya Mahasiswa antara 1 - ',MaxMhs,' Ulangi,Tekan Enter!'); readln;
    gotoxy(25,3); clreol;
    gotoxy(1,4); clreol;
    textcolor(15);
    gotoxy(25,3);
    readln(DataKelas.M);
  end;//endwhile

  //memasukkan banyaknya mata kuliah
  write('Banyaknya Mata Kuliah : '); readln(DataKelas.N);

  //validasi banyaknya mata kuliah
  while(DataKelas.N > MaxMk) do
  begin
    gotoxy(1,5);textcolor(yellow);
    write('Banyaknya Mata Kuliah Antara 1 - ',MaxMk,' Ulangi,Tekan Enter!');readln;
    gotoxy(25,4); clreol;
    gotoxy(1,5); clreol;
    textcolor(15);
    gotoxy(25,4);
    readln(DataKelas.N);
  end;//endwhile

  //memasukkan data mahasiswa
  clrscr;
  textcolor(yellow);
  gotoxy(52,3); writeln('Daftar Mahasiswa');
  textcolor(15);
  gotoxy(35,5); writeln('Kelas/Semester : IF-',DataKelas.NmKelas,'/',DataKelas.Semester);
  gotoxy(35,6); writeln('===================================================');
  gotoxy(35,7); writeln('| No |    NIM    |         Nama Mahasiswa         |');
  gotoxy(35,8); writeln('---------------------------------------------------');

  i  := 1;
  No := 0;
  for j := i to DataKelas.M do
  begin
    No := No + 1;
    gotoxy(35,No+8);
    writeln('|    |           |                                |');
    gotoxy(37,No+8);write(No);
  end;//endfor
  writeln;
  gotoxy(35,DataKelas.M+9); writeln('---------------------------------------------------');

  //memasukkan NIM mahasiswa
  for i := 1 to DataKelas.M do
  begin
    for j := 1 to DataKelas.M do
    gotoxy(42,i+8); textcolor(15); readln(Mahasiswa[i].NIM);

      //validasi NIM
      while (CekNIM(Mahasiswa[i].NIM, Mahasiswa, i) = true) do
      begin
        gotoxy(35,DataKelas.M+10); textcolor(yellow);
        write('NIM ',Mahasiswa[i].NIM,' Sudah Ada! Tekan Enter'); readln;
        gotoxy(35,DataKelas.M+10);clreol;
        gotoxy(42,i+8);clreol;
        gotoxy(42,i+8);textcolor(15);write('          |                                |');
        gotoxy(42,i+8);textcolor(15);readln(Mahasiswa[i].NIM);
      end; //endwhile
  end; //endfor
   
  //memasukkan nama mahasiswa
  for i := 1 to DataKelas.M do
  begin
    for j := 1 to DataKelas.M do
    gotoxy(54,i+8); textcolor(15); readln(Mahasiswa[i].Nama);
  end; //endfor
  textcolor(yellow);
  gotoxy(35,DataKelas.M+10); writeln('Tekan Enter Untuk Kembali Ke Menu Isi Data'); readln;
end; //endprocedure

procedure isiMatkul(var Matkul:ArrayMk; var DataKelas:kelas);
{I.S: User memasukkan kode mata kuliah, nama mata kuliah dan SKS per mata kuliah}
{F.S: Menghasilkan record Data Matkul(1:N) dan total sks}
var 
  i, j, No : integer;
begin
  textcolor(yellow);
  gotoxy(51,3); writeln('Daftar Mata Kuliah');
  textcolor(15);
  gotoxy(28,5); writeln('Kelas/Semester : IF-',DataKelas.NmKelas,'/',DataKelas.Semester);
  gotoxy(28,6); writeln('=================================================================');
  gotoxy(28,7); writeln('| No | Kode Mata Kuliah |         Nama Mata Kuliah        | SKS |');
  gotoxy(28,8); writeln('-----------------------------------------------------------------');

  i  := 1;
  No := 0;
  for j := i to DataKelas.N do
  begin
    No := No + 1;
    gotoxy(28,No+8);
    writeln('|    |                  |                                 |     |');
    gotoxy(30,No+8);write(No);
  end;//endfor
  gotoxy(28,DataKelas.N+9);write('-----------------------------------------------------------------');

  //memasukkan Kode Mata Kuliah
  for i := 1 to DataKelas.N do
  begin
    for j := 1 to DataKelas.N do
    gotoxy(35,i+8); textcolor(15); write('IF-');readln(Matkul[i].KodeMk);
    while (CekKodeMatkul(Matkul[i].KodeMk, i, Matkul)= true) do
    begin
      gotoxy(35,DataKelas.M+10); textcolor(yellow);
      write('Kode Matkul ',Matkul[i].KodeMk,' Sudah Ada! Tekan Enter');
      readln;
      gotoxy(35,DataKelas.M+10); clreol;
      gotoxy(35,i+8); clreol;
      gotoxy(52,i+8); textcolor(15);write('|                                 |     |');
      gotoxy(35,i+8); textcolor(15); write('IF-');readln(Matkul[i].KodeMk);
    end; //endwhile
  end; //endfor

  for i := 1 to DataKelas.N do
  begin
    gotoxy(55,i+8); textcolor(15); readln(Matkul[i].NamaMk);
    gotoxy(89,i+8); textcolor(15); readln(Matkul[i].SKS);
  end;

  //hitung total SKS
  DataKelas.TotalSKS := 0;
  for i := 1 to DataKelas.N do
  begin
    DataKelas.TotalSKS := DataKelas.TotalSKS + Matkul[i].SKS;
  end;
  textcolor(yellow);
  gotoxy(28,DataKelas.N+10); writeln('Tekan Enter Untuk Kembali Ke Menu Isi Data'); readln;
end; //endprocedure

function IndeksNilai( var Nilai : integer) : char;
{I.S. : Nilai per mata kuliah sudah terdefinisi}
{F.S. : Menghasilkan fungsi indeks nilai}
begin
  case (Nilai) of
    80..100 : IndeksNilai := 'A';
    70..79  : IndeksNilai := 'B';
    60..69  : IndeksNilai := 'C';
    50..59  : IndeksNilai := 'D';
    0..49   : IndeksNilai := 'E';
  end; //endcase
end; //endfunction

function BobotNilai(Indeks : char) : integer;
{I.S : indeks sudah terdefinisi}
{F.S : menghasilkan bobot nilai}
begin
  case(Indeks) of
    'A' : BobotNilai := 4;
    'B' : BobotNilai := 3;
    'C' : BobotNilai := 2;
    'D' : BobotNilai := 1;
    'E' : BobotNilai := 0;
  end;//endcase
end;//endfunction

function HitungIP(IndeksMhs:integer; DataKelas:Kelas; Matkul:ArrayMk; Mahasiswa:ArrayMhs):real;
{I.S: SKS per mata kuliah, total SKS, dan bobot nilai mahasiswa sudah terdefenisi}
{F.S: Menghasilkan nilai IP Mahasiswa}
var 
    TotalBobot  : real;
    i, Bobot:integer;
begin
    TotalBobot := 0;
    for i := 1 to DataKelas.M do
    begin
        Bobot := Matkul[i].SKS * BobotNIlai(Mahasiswa[IndeksMhs].NilaiMhs[i].indeks);
        TotalBobot := TotalBobot + Bobot;
    end;
    HitungIP := TotalBobot / DataKelas.TotalSKS;
end;

procedure IsiNilai(var Mahasiswa:ArrayMhs; Matkul:ArrayMk;DataKelas:kelas);
{I.S : user memasukkan nilai mahasiswa per mata kuliah}
{F.S : menampilkan indeks nilai mahasiswa}
var
  i, j, No : integer;
begin
    No    := 0;
    for i := 0 to (DataKelas.N-1) do
    begin
        textcolor(yellow);
        gotoxy(49,3+No); writeln('Daftar Nilai Mahasiswa');
        textcolor(15);
        gotoxy(26,5+No); writeln('Kelas/Semester : IF-',DataKelas.NmKelas,'/',DataKelas.Semester);
        gotoxy(26,6+No); writeln('Mata Kuliah    : ',Matkul[i+1].NamaMk);
        gotoxy(26,7+No); writeln('====================================================================');
        gotoxy(26,8+No); writeln('| No |    NIM    |         Nama Mahasiswa         | Nilai | Indeks |');
        gotoxy(26,9+No); writeln('--------------------------------------------------------------------');

        for j := 0 to (DataKelas.M - 1) do
        begin
            gotoxy(26,10+No);writeln('|    |           |                                |       |        |');
            gotoxy(29,10+No); writeln(j+1);
            gotoxy(34,10+No); writeln(Mahasiswa[j+1].NIM);
            gotoxy(46,10+No); writeln(Mahasiswa[j+1].Nama);
            gotoxy(79,10+No); readln(Mahasiswa[j+1].NilaiMhs[i+1].Nilai);
            Mahasiswa[j+1].NilaiMhs[i+1].Indeks := IndeksNilai(Mahasiswa[j+1].NilaiMhs[i+1].Nilai);
            gotoxy(88,10+No); writeln(Mahasiswa[j+1].NilaiMhs[i+1].indeks);

            No := No + 1;
            Mahasiswa[j+1].NilaiMhs[i+1].Bobot := Matkul[i+1].SKS * BobotNilai(Mahasiswa[j+1].NilaiMhs[i+1].Indeks);
        end;
        gotoxy(26,10+No); writeln('--------------------------------------------------------------------');
        No := No + 8 + i;
    end;
    readln;
    for i := 1 to DataKelas.M do
         Mahasiswa[i].IP := HitungIP(i, DataKelas, Matkul, Mahasiswa);
end; //endprocedure

procedure MenuIsiData(Menu : integer);
{I.S. : user memasukkan nomor menu}
{F.S. : menghasilkan nomor menu}
begin
  repeat
    clrscr;
    textcolor(15);
    gotoxy(41,10); writeln('+ + + + + + + + + + + + + + + + + + + +');
    gotoxy(41,11);writeln('+             MENU ISI DATA           +');
    gotoxy(41,12);writeln('+  =================================  +');
    gotoxy(41,13);writeln('+ 1. Isi Data Mahasiswa               +');
    gotoxy(41,14);writeln('+ 2. Isi Data Mata Kuliah             +');
    gotoxy(41,15);writeln('+ 3. Isi Data Nilai Per Mata Kuliah   +');
    gotoxy(41,16);writeln('+ 0. Kembali Ke Menu Pilihan          +');
    gotoxy(41,17);write('+ Masukkan Pilihan Anda :             +');
    gotoxy(41,18); writeln('+ + + + + + + + + + + + + + + + + + + +');
    gotoxy(67,17); readln(Menu);

    case (Menu) of
      1 : begin
            clrscr;
            IsiDataMahasiswa(Mahasiswa, DataKelas);
          end;
      2 : begin
            clrscr;
            if (DataKelas.N = 0)
              then
              begin
                textcolor(yellow);
                writeln('Silahkan Isi Data Mahasiswa Terlebih Dahulu')
              end
              else
                isiMatkul(Matkul, DataKelas); readln;
          end;
      3 : begin
            clrscr;
            if (DataKelas.N = 0)
              then
              begin
                textcolor(yellow);
                writeln('Silahkan Isi Data Mahasiswa Terlebih Dahulu')
              end
              else
                IsiNilai(Mahasiswa,Matkul,DataKelas);
          end;
    end; //endcase
  until menu=0;
end; //endprocedure

procedure TampilNilai(Mahasiswa : ArrayMhs; DataKelas:kelas);
{I.S.: banyaknya mahasiswa (M) dan record nilai Mahasiswa sudah terdefinisi}
{F.S.: menampilkan daftar nilai mahasiswa}
var
  i, No, idx : integer;
  Cari : string;
  ketemu : boolean;
begin
  textcolor(15);
  gotoxy(1,1); clreol;
  gotoxy(3,2); write('Mata Kuliah Yang Dicari : '); readln(cari);
  
  idx := 1;
  ketemu := false;
  while ((idx <= DataKelas.M) and (not ketemu)) do   //untuk membaca huruf kecil
    if (lowercase(Matkul[idx].NamaMk) = lowercase(cari))
      then
        ketemu := true
      else
        idx := idx + 1;
        
    if (ketemu = true)
      then
      begin
        textcolor(15);
        gotoxy(27,6); writeln('Kelas/Semester : ',DataKelas.NmKelas,'/',DataKelas.Semester);
        gotoxy(27,7); writeln('Mata Kuliah    : ',Matkul[idx].NamaMk);
        gotoxy(27,8); writeln('==================================================================');
        gotoxy(27,9); writeln('| No |    NIM    |        Nama Mahasiswa        | Nilai | Indeks |');
        gotoxy(27,10); writeln('------------------------------------------------------------------');

        i := 1;
        No := 0;
        for i := 1 to DataKelas.M do
        begin
          No:= No+1;
          gotoxy(27,No+10);
          writeln('|    |           |                              |       |        |');
          gotoxy(29,No+10);writeln(No);
          gotoxy(34,i+10); writeln(Mahasiswa[i].NIM);
          gotoxy(46,i+10); writeln(Mahasiswa[i].Nama);
          gotoxy(79,i+10); writeln(Mahasiswa[i].NilaiMhs[idx].Nilai);
          gotoxy(88,i+10); writeln(Mahasiswa[i].NilaiMhs[idx].Indeks);
          gotoxy(27,No+11);writeln('------------------------------------------------------------------');
        end;//endfor
      end
      else
        writeln('Mata kuliiah tidak ditemukan!');
        gotoxy(27,No+12); writeln('Tekan Enter Untuk Kembali Ke Menu Tampil Data'); readln;
end; //endprocedure

procedure UrutNIMAsc(var Mahasiswa : ArrayMhs; DataKelas : kelas);
{I.S.: record mahasiswa (1..M) data banyaknya mahasiswa sudah terdefinisi}
{F.S.: menghasilkan record mahasiswa(1..M) yang sudah tersusun secara ascending berdasarkan NIM menggunakan bubble sort}
var
  i, j : integer;
  Temp : Mhsiswa;
begin
  textcolor(yellow);
  gotoxy(34,4); writeln('Daftar Nilai Mahasiswa Terurut NIM Secara Ascending');
  for i := 1 to (DataKelas.M-1) do
    for j := DataKelas.M downto (i+1) do
    begin
      if(Mahasiswa[j].NIM < Mahasiswa[j-1].NIM)
        then
        begin
          Temp           := Mahasiswa[j];
          Mahasiswa[j]   := Mahasiswa[j-1];
          Mahasiswa[j-1] := Temp;
        end;
    end; //endfor
end; //endprocedure

procedure UrutNilaiDsc(var Mahasiswa : ArrayMhs; DataKelas:kelas);
{I.S.: record mahasiswa (1..M) dan banyaknya data sudah terdefinisi}
{F.S.: menghasilkan record mahasiswa(1..M) yang sudah tersusun secara descending berdasarkan nilai menggunakan bubble sort}
var
  i, j      : integer;
  Temp      : Mhsiswa;
begin
  textcolor(yellow);
  gotoxy(34,4); writeln('Daftar Nilai Mahasiswa Terurut Nilai Secara Descending');
  for i := 1 to  (DataKelas.M - 1)  do
        for j := 1 to (DataKelas.M-i) do
        begin
            if (Mahasiswa[j].NilaiMhs[i].nilai < Mahasiswa[j+1].NilaiMhs[i].nilai )
              then
              begin
               Temp           := Mahasiswa[j];
                 Mahasiswa[j]   := Mahasiswa[j+1];
                   Mahasiswa[j+1] := Temp;
                   end;
  end; //endfor
end; //endprocedure

procedure TampilIP( var Mahasiswa :ArrayMhs; DataKelas:Kelas );
{I.S. : NIM dan nama mahasiswa sudah terdefinisi sudah terdefinisi}
{F.S. : menampilkan nilai IP mahasiswa}
var
   i, No: integer;
begin
  gotoxy(1,1); clreol;
  textcolor(yellow);
  gotoxy(42,3);write('Daftar Indeks Prestasi(IP) Mahasiswa');
  gotoxy(48,4);writeln('Kelas/Semester : ','IF-', DataKelas.NmKelas,'/',DataKelas.Semester);
  textcolor(15);
  gotoxy(32,6);writeln('========================================================');
  gotoxy(32,7);writeln('| No |    NIM    |        Nama Mahasiswa        |  IP  |');
  gotoxy(32,8);writeln('--------------------------------------------------------');
  i  := 1;
  No := 0;
  Mahasiswa[i].IP := 0;
    for i := 1 to DataKelas.M do
    begin
      No := No + 1;
      gotoxy(32,No+8);
      writeln('|    |           |                              |      |');
      gotoxy(34,No+8);write(No);
      gotoxy(39,i+8); write(Mahasiswa[i].NIM);
      gotoxy(51,i+8); write(Mahasiswa[i].Nama);
      Mahasiswa[i].IP := HitungIP(i, DataKelas, Matkul, Mahasiswa);
      gotoxy(82,i+8); write(Mahasiswa[i].IP:0:2);
      gotoxy(32,No+9);write('--------------------------------------------------------');
   end;//endfor
   readln;
end;//endprocedure

procedure UrutIP(DataKelas : kelas; var Mahasiswa : ArrayMhs);
{I.S : record mahasiswa (1..M) data banyaknya mahasiswa(M) sudah terdefinisi}
{F.S : menghasilkan record mahasiswa(1..M) yang sudah tersusun secara descending berdasarkan IP menggunakan miniimum selection sort}
var
  i, j, maks : integer;
  temp : Mhsiswa;
begin
 for i := 1 to  (DataKelas.M - 1)  do begin
        Maks := i;
        for j := (i + 1) to DataKelas.M do
            if (Mahasiswa[j].IP > Mahasiswa[Maks].IP) then
                Maks := j;


    Temp           := Mahasiswa[i];
    Mahasiswa[i]   := Mahasiswa[maks];
    Mahasiswa[maks] := Temp;
  end; //endfor
end; //endprocedure

procedure MenuTampilData(Menu : integer);
{I.S. : user memasukkan pilihan nomor menu}
{F.S. : menghasilkan nomor menu}
begin
  repeat
    clrscr;
    textcolor(15);
    gotoxy(35,10); writeln('+ + + + + + + + + + + + + + + + + + + + + + + + +');
    gotoxy(35,11); writeln('+                MENU TAMPIL DATA               +');
    gotoxy(35,12); writeln('+ ============================================  +');
    gotoxy(35,13); writeln('+ 1. Daftar Nilai Mahasiswa Terurut NIM Asc.    +');
    gotoxy(35,14); writeln('+ 2. Daftar Nilai Mahasiswa Terurut Nilai Dsc.  +');
    gotoxy(35,15); writeln('+ 3. Daftar IP Mahasiswa Terurut IP.            +');
    gotoxy(35,16); writeln('+ 0. Kembali Ke Menu Pilihan                    +');
    gotoxy(35,17); write('+ Masukkan Pilihan Anda :                       +');
    gotoxy(35,18); writeln('+ + + + + + + + + + + + + + + + + + + + + + + + +');
    gotoxy(61,17); readln(Menu);

    case (Menu) of
     1 : begin
            clrscr;
            if(DataKelas.N=0)
              then
              begin
                textcolor(yellow);
                writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
              end
              else
                UrutNIMAsc(Mahasiswa, DataKelas);
                TampilNilai(Mahasiswa, DataKelas);
          end;
      2 : begin
            clrscr;
            if(DataKelas.N = 0)
              then
              begin
                textcolor(yellow);
                writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
              end
              else
                UrutNilaiDsc(Mahasiswa, DataKelas);
                TampilNilai(Mahasiswa, DataKelas);
          end;         
      3 : begin
            clrscr;
          if(DataKelas.N = 0)
              then
              begin
                textcolor(yellow);
                writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
              end
              else             
                UrutIP(DataKelas, Mahasiswa);
                TampilIP(Mahasiswa,DataKelas); readln;
          end;
    end; //endcase
  until menu=0;
end; //endprocedure

procedure CariNIM(var Mahasiswa : ArrayMhs; DataKelas:Kelas);
{I.S.: banyaknya data mahasiswa(M) dan record(1:M) sudah terdefinisi}
{F.S.: menampilkan hasil pencarian NIM menggunakan metode binary search}
var
  KodeCari  : string;
  Ia, Ib, K : integer;
  Ketemu    : boolean;
  i, j : integer;
  Temp : Mhsiswa;
begin
  //memasukkan NIM yang dicari
  write('NIM Yang Dicari : '); readln(KodeCari);
    
  for i := 1 to (DataKelas.M-1) do
    for j := DataKelas.M downto (i+1) do
    begin
      if(Mahasiswa[j].NIM < Mahasiswa[j-1].NIM)
        then
        begin
          Temp           := Mahasiswa[j];
          Mahasiswa[j]   := Mahasiswa[j-1];
          Mahasiswa[j-1] := Temp;
        end;
    end; //endfor
    
  //proses pencarian(searching)
  Ia := 1;
  Ib := DataKelas.M;
  Ketemu := false;
  while (Not Ketemu) and (Ia <= Ib) do
  begin
    //menghitung posisi tengah array
    k := (Ia + Ib) div 2;
    if(Mahasiswa[k].NIM = KodeCari)
      then
        Ketemu := true
      else
        if(Mahasiswa[k].NIM < KodeCari)
          then
            Ia := k + 1 //pencarian dilanjutkan ke bagian kanan
          else
            Ib := k - 1; //pencarian dilanjutkan ke bagian kiri
  end; //endwhile

  //menampilkan hasil pencarian NIM
  clrscr;
  if(Ketemu)
    then
    begin
      clrscr;
      textcolor(15);
      gotoxy(26,7); write('NIM Yang Dicari : ',KodeCari);
      gotoxy(26,8); write('==============================================================');
      gotoxy(26,9); write('|    NIM    |        Nama Mahasiswa        | Semester |  IP  |');
      gotoxy(26,10); write('--------------------------------------------------------------');
      gotoxy(26,11); write('|           |                              |          |      |');
      gotoxy(28,11); write(Mahasiswa[k].NIM);
      gotoxy(42,11); write(Mahasiswa[k].Nama);
      gotoxy(74,11); write(DataKelas.Semester);
      gotoxy(81,11); write(Mahasiswa[k].IP:0:2);
      gotoxy(26,12); write('--------------------------------------------------------------');
      gotoxy(26,13); write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end
    else //untuk NIM yang tidak ditemukan
    begin
      textcolor(15); write('NIM ');
      textcolor(red); write(KodeCari);
      textcolor(15); write('Tidak Ada');
      write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end;
end; //endprocedure

procedure CariNama(var Mahasiswa : ArrayMhs; DataKelas:Kelas);
{I.S. : banyaknya data mahasiswa(M) dan record(1:M) sudah terdefinisi}
{F.S. : menampilkan hasil pencarian NIM menggunakan metode binary search}
var
  Ia, Ib, K , i, j: integer;
  Ketemu    : boolean;
  KodeCari  : string;
  temp:Mhsiswa;
begin
  //memasukkan nama mahasiswa yang dicari
  write('Nama Mahasiswa Yang Dicari : '); readln(KodeCari);
    
    for i := 1 to (DataKelas.M-1) do
    for j := DataKelas.M downto (i+1) do
    begin
      if(Mahasiswa[j].NIM < Mahasiswa[j-1].NIM)
        then
        begin
          Temp           := Mahasiswa[j];
          Mahasiswa[j]   := Mahasiswa[j-1];
          Mahasiswa[j-1] := Temp;
        end;
    end; //endfor
    
  //proses pencarian(searching)
  Ia := 1;
  Ib := DataKelas.M;
  Ketemu := false;
  while (Not Ketemu) and (Ia <= Ib) do
  begin
    //menghitung posisi tengah array
    k := (Ia + Ib) div 2;
    if(Mahasiswa[k].Nama = KodeCari)
      then
        Ketemu := true
      else
        if(Mahasiswa[k].Nama < KodeCari)
          then
            Ia := k + 1 //pencarian dilanjutkan ke bagian kanan
          else
            Ib := k - 1; //pencarian dilanjutkan ke bagian kiri
  end; //endwhile

  //menampilkan hasil pencarian Nama mahasiswa
  clrscr;
  if(Ketemu)
    then
    begin
      clrscr;
      textcolor(15);
      gotoxy(25,7); write('Nama Mahasiswa Yang Dicari : ',KodeCari);
      gotoxy(25,8); write('====================================================================');
      gotoxy(25,9); write('|    NIM    |        Nama Mahasiswa        | Kelas | Semester | IP |');
      gotoxy(25,10); write('-------------------------------------------------------------------');
      gotoxy(25,11); write('|           |                              |       |          |    |');
      gotoxy(27,11); write(Mahasiswa[k].NIM);
      textcolor(red);
      gotoxy(41,11); write(Mahasiswa[k].Nama);
      textcolor(15);
      gotoxy(72,11); write(DataKelas.NmKelas);
      gotoxy(81,11); write(DataKelas.Semester);
      gotoxy(88,11); write(Mahasiswa[k].IP:0:2);
      gotoxy(25,12); write('--------------------------------------------------------------------');
      gotoxy(25,13); write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end
    else //untuk NIM yang tidak ditemukan
    begin
      textcolor(15); write('Nama Mahasiswa ');
      textcolor(yellow); write(KodeCari);
      textcolor(15); write(' Tidak Ada');
      write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end;
end; //endprocedure

procedure CariNilai(var Mahasiswa : ArrayMhs);
{I.S. : record mahasiswa(1:M) sudah terdefinisi}
{F.S. : menampilkan hasil pencariian nilai menggunakan binary search}
var
  NilaiMin, NilaiMax,i, No : integer;
  Ketemu    : boolean;
  KodeCari  : string;
begin
    clrscr;
    write('Mata Kuliah yang dicari    : ');readln(KodeCari);
    begin
        writeln('Nilai Mahasiswa yang dicari: Antara    Sampai   ');
        gotoxy(37, 2);readln(NilaiMin);
        gotoxy(47, 2);readln(NilaiMax);
        writeln;
        writeln;
        //searching
         i := 1;
         ketemu := false;
         while (Not Ketemu) and (i <= DataKelas.N) do
         begin
            if (Mahasiswa[i].NilaiMhs[i].Nilai >= NilaiMin) and (Mahasiswa[i].NilaiMhs[i].Nilai <= NilaiMax)
             then
                Ketemu := true
              else
                 i := i + 1
         end; //endwhile

         //menampilkan
         if(ketemu)
         then
         begin
             gotoxy(42,5);writeln('Daftar Nilai Mahasiswa Antara ', NilaiMin,' Sampai', NilaiMax);
             gotoxy(55,6);writeln('Mata Kuliah ', Matkul[i].NamaMk);
             writeln;
             gotoxy(27,8); writeln('==================================================================');
             gotoxy(27,9); writeln('| No |    NIM    |        Nama Mahasiswa        | Nilai | Indeks |');
             gotoxy(27,10); writeln('------------------------------------------------------------------');

               i := 1;
               No := 0;
               for i := 1 to DataKelas.N do
                if (Mahasiswa[i].NilaiMhs[i].Nilai >= NilaiMin) and (Mahasiswa[i].NilaiMhs[i].Nilai <= NilaiMax) then
                  begin
                     No := No+1;
                     gotoxy(27,No+10);
                     writeln('|    |           |                              |       |        |');
                     gotoxy(29,i+10);writeln(i);
                     gotoxy(34,i+10);writeln(Mahasiswa[i].NIM);
                     gotoxy(46,i+10);writeln(Mahasiswa[i].Nama);
                     gotoxy(79,i+10);writeln(Mahasiswa[i].NilaiMhs[i].Nilai);
                     gotoxy(88,i+10);writeln(Mahasiswa[i].NilaiMhs[i].Indeks);

                     gotoxy(27,No+11);writeln('==================================================================');
                  end
                  else
                  begin
                         textcolor(15); write('Nilai Yang Dicari Antara ');
                         textcolor(blue); write(NilaiMin);
                         textcolor(15); write('Sampai ');
                         textcolor(blue); write(NilaiMax);
                         textcolor(15); write('Tidak Ada!');
                  end;
              end;
      end;
end;


procedure MenuCariDataMhs(Menu : integer);
{I.S. : user memasukkan pilihan nomor menu}
{F.S. : menghasilkan nomor menu}
begin
  repeat
    clrscr;
    textcolor(15);
    gotoxy(46,10); writeln('x x x x x x x x x x x x x x x x x x x');
    gotoxy(46,11); writeln('x     MENU CARI DATA MAHASISWA      x');
    gotoxy(46,12); writeln('x ================================= x');
    gotoxy(46,13); writeln('x 1. Cari NIM Mahasiswa             x');
    gotoxy(46,14); writeln('x 2. Cari Nama Mahasiswa            x');
    gotoxy(46,15); writeln('x 3. Cari Nilai Mahasiswa           x');
    gotoxy(46,16); writeln('x 0. Kembali Ke Menu Cari Data      x');
    gotoxy(46,17); write('x Masukkan Pilihan Anda :           x');
    gotoxy(46,18); writeln('x x x x x x x x x x x x x x x x x x x');
    gotoxy(72,17); readln(Menu);

   case (Menu) of
      1 : begin
            clrscr;
            if(DataKelas.N = 0)
              then
              begin
                textcolor(yellow);
                writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
              end
              else
                CariNIM(Mahasiswa, DataKelas);
                 readln;
          end;
      2 : begin
            clrscr;
              if(DataKelas.N = 0)
                then
                begin
                  textcolor(yellow);
                  writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
                end
                else
                  CariNama(Mahasiswa,  DataKelas); 
                  readln;
          end;
      3 : begin
            clrscr;
              if(DataKelas.N = 0)
                then
                begin
                  textcolor(yellow);
                  writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
                end
                else
                  CariNilai(Mahasiswa);
                  readln;
         end;
    end; //endcase  
  until(Menu = 0);
end; //endprocedure

procedure CariMatkul(Matkul : ArrayMk; DataKelas:Kelas);
{I.S.: banyaknya data mata kuliah(N) dan record(1:N) sudah terdefinisi}
{F.S.: menampilkan hasil pencarian NIM menggunakan metode binary search}
var
  KodeCari  : string;
  Ia, Ib, K : integer;
  Ketemu    : boolean;
begin
  //memasukkan kode mata kuliah yang dicari
  write('Kode Mata Kuliah Yang Dicari : '); readln(KodeCari);

  //proses pencarian(searching)
  Ia := 1;
  Ib := DataKelas.M;
  Ketemu := false;
  while (Not Ketemu) and (Ia <= Ib) do
  begin
    //menghitung posisi tengah array
    k := (Ia + Ib) div 2;
    if(Matkul[k].KodeMk = KodeCari)
      then
        Ketemu := true
      else
        if(Matkul[k].KodeMk < KodeCari)
          then
            Ia := k + 1 //pencarian dilanjutkan ke bagian kanan
          else
            Ib := k - 1; //pencarian dilanjutkan ke bagian kiri
  end; //endwhile
  //menampilkan hasil pencarian mata kuliah
  clrscr;
  if(Ketemu)
    then
    begin
      clrscr;
      textcolor(15);
      gotoxy(24,7); write('Kode Mata Kuliah Yang Dicari : IF- ',KodeCari);
      gotoxy(24,8); write('============================================================');
      gotoxy(24,9); write('| Kode Mata Kuliah |         Nama Mata Kuliah        | SKS |');
      gotoxy(24,10); write('------------------------------------------------------------');
      gotoxy(24,11); write('|                  |                                 |     |');
      gotoxy(28,11); write(Matkul[k].KodeMk);
      gotoxy(45,11); write(Matkul[k].NamaMk);
      gotoxy(80,11); write(Matkul[k].SKS);
      gotoxy(24,12); write('------------------------------------------------------------');
       gotoxy(24,13); write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end
    else //untuk mata kuliah yang tidak ditemukan
    begin
      textcolor(15); write('Kode Mata Kuliah IF- ');
      textcolor(yellow); write(KodeCari);
      textcolor(15); write(' Tidak Ada ');
      write('Tekan Enter Untuk Kembali Ke Menu Cari Data Mahasiswa'); readln;
    end;
end; //endprocedure

procedure CariKHS( var Mahasiswa : ArrayMhs; var Matkul : ArrayMk);
{I.S. : record mahasiswa(1:M) dan record mata kuliah(1:N) sudah terdefinisi}
{F.S. : menampilkan hasil searching kartu hasil studi mahasiswa menggunakan metode sequential search}
var
  i,No : integer;
  ketemu : boolean;
  cari : string;
begin
  for i := 1 to DataKelas.M do
  begin
     gotoxy(46,3);writeln('Kartu Hasil Studi Mahasiswa');
     gotoxy(46,4);writeln('---------------------------');
     gotoxy(30,5);write('NIM : ');readln(cari);
       ketemu := false;
       i := 1;
       while ((i <= DataKelas.M) and (not ketemu)) do   //untuk membaca huruf kecil
        if (lowercase(Mahasiswa[i].NIM) = lowercase(cari))
        then
           ketemu := true
        else
         i := i + 1;
        
       if (ketemu)
        then
         begin
           gotoxy(30,6); write('Nama          : '); write(Mahasiswa[i].Nama);
           gotoxy(30,7);writeln('Kelas/Semester : IF-',DataKelas.NmKelas,'/',DataKelas.Semester);
           gotoxy(30,8);writeln('=================================================================== ');
           gotoxy(30,9);writeln('|    Kode     |   Nama Mata Kuliah  | SKS | Indeks | SKS x Bobot  | ');
           gotoxy(30,10);writeln('| Mata Kuliah |                     |     |  Nilai | Indeks Nilai | ');
           gotoxy(30,11);writeln('-------------------------------------------------------------------');
           No := 0;
           for i := 1 to DataKelas.M do
            begin
             No:= No+1;
             gotoxy(30,No+11);
             writeln('|             |                     |     |        |              | ');
             gotoxy(32,i+11);writeln(Matkul[i].KodeMk);
             gotoxy(46,i+11); writeln(Matkul[i].NamaMk);
             gotoxy(68,i+11); writeln(Matkul[i].SKS);
             gotoxy(77,i+11); writeln(Mahasiswa[i].NilaiMhs[i].Indeks);
             gotoxy(85,i+11); writeln(Matkul[i].SKS * Mahasiswa[i].NilaiMhs[i].Bobot);
             gotoxy(30,No+12);writeln('--------------------------------------------------------------------');
             gotoxy(30,No+13); write('Indeks Prestasi : ',Mahasiswa[i].IP:0:2); readln;
         end;//endfor
           end
           else
           writeln('NIM tidak ditemukan!');
           gotoxy(28,No+13); writeln('Tekan Enter Untuk Kembali Ke Menu Cari Data'); readln;
   end;
end;//endprocedure

procedure MenuCariData(Menu : integer);
{I.S. : user memasukkan pilihan nomor menu}
{F.S. : menghasilkan nomor menu}
begin
  //N := 0;
  repeat
    clrscr;
    textcolor(15);
    gotoxy(41,10); writeln('+ + + + + + + + + + + + + + + + + + + +');
    gotoxy(41,11);writeln('+            MENU CARI DATA           +');
    gotoxy(41,12);writeln('+  =================================  +');
    gotoxy(41,13);writeln('+ 1. Cari Data Mahasiswa              +');
    gotoxy(41,14);writeln('+ 2. Cari Data Mata Kuliah            +');
    gotoxy(41,15);writeln('+ 3. Cari Kartu Hasil Studi Mahasiswa +');
    gotoxy(41,16);writeln('+ 0. Kembali Ke Menu Pilihan          +');
    gotoxy(41,17);write('+ Masukkan Pilihan Anda :             +');
    gotoxy(41,18); writeln('+ + + + + + + + + + + + + + + + + + + +');
    gotoxy(68,17); readln(Menu);
  
   case (Menu) of
     1 : begin
           clrscr;
           MenuCariDataMhs(Menu);
         end;
     2 : begin
         clrscr;
         if(DataKelas.N = 0)
           then
           begin
             textcolor(yellow);
             writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
           end
           else
             CariMatkul(Matkul, DataKelas);
             readln;
         end;
     3 : begin
         clrscr;
         if(DataKelas.N = 0)
           then
           begin
             textcolor(yellow);
             writeln('Isi Data Mahasiswa Pada Menu Isi Data Terlebih Dahulu')
           end
           else
              CariKHS(Mahasiswa, Matkul);
              readln;
           end;
    end; //endcase 
  until(Menu = 0);
end; //endprocedure

procedure MenuPilihan (var Menu : integer);
{I.S. : user memasukkan pilihan nomor menu}
{F.S. : menghasilkan nomor menu}
begin
   textcolor(15);
   gotoxy(47,10); writeln('* * * * * * * * * * * * * * *');
   gotoxy(47,11);writeln('*        MENU PILIHAN       *');
   gotoxy(47,12);writeln('*  =======================  *');
   gotoxy(47,13);writeln('*  1. Isi Data              *');
   gotoxy(47,14);writeln('*  2. Tampil Data           *');
   gotoxy(47,15);writeln('*  3. Cari Data             *');
   gotoxy(47,16);writeln('*  0. Keluar                *');
   gotoxy(47,17);write('* Masukkan Pilihan Anda :   *');
   gotoxy(47,18); writeln('* * * * * * * * * * * * * * *');
   gotoxy(73,17); readln(Menu);
end; //endprocedure

//algoritma utama
begin
  repeat
    clrscr;
    MenuPilihan(Menu);
    case (Menu) of
        1 : begin
              clrscr;
              MenuIsiData(Menu);
            end;
        2 : begin
              clrscr;
              MenuTampilData(Menu);
            end;
        3 : begin
              clrscr;
              MenuCariData(Menu);
            end;
    end; //endcase
  until Menu=0;
end.

