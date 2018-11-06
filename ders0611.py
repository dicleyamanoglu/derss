import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
isaretci.execute('''CREATE TABLE ogrenciler (kayit_no
INTEGER PRIMARY KEY,adi VARCHAR(50)) ''')



import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
sorgu=isaretci.execute('''INSERT INTO ogrenciler (kayit_no,adi)
VALUES (2,'Can')''')
print(sorgu.lastrowid)
baglanti.commit()
baglanti.close()


import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
sorgu=isaretci.execute('SELECT * FROM ogrenciler')
print(sorgu.fetchone())
print(sorgu.fetchmany(2))
print(sorgu.fetchall())
baglanti.close()


import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
sorgu=isaretci.execute('SELECT * FROM ogrenciler')
for i in sorgu.fetchall():
    print("Adı%s"%i)
baglanti.close()


import sqlite3
baglanti=sqlite3.connect('ornek.db')
baglanti.row_factory=sqlite3.Row
isaretci=baglanti.cursor()
sorgu=isaretci.execute('SELECT * FROM ogrenciler')
for i in sorgu.fetchall():
    print(i['adi'])
baglanti.close()


import sqlite3
baglanti=sqlite3.connect('ornek.db')
baglanti.row_factory=sqlite3.Row
isaretci=baglanti.cursor()
sorgu=isaretci.execute('SELECT * FROM ogrenciler')
#Alan adına göre sorgulama
for i in sorgu.fetchall():
    print(i['adi'])
#Değişken sıralamasına göre sorgulama
for i in sorgu.fetchall():
    print("Adi:%s,Soyadı:%s"%i)#Select * ile olmuyor.
baglanti.close()



import sqlite3
baglanti=sqlite3.connect('ornek.db')
#baglanti.row_factory=sqlite3.Row
isaretci=baglanti.cursor()
sorgu=isaretci.execute('''DELETE FROM ogrenciler
WHERE kayit_no="2" ''')
sorgu=isaretci.execute('SELECT * FROM ogrenciler')
print(sorgu.fetchall())
baglanti.commit() #Yapılan işlemler diske yazılır.
baglanti.close()

import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
##sorgu=isaretci.execute('''CREATE TABLE ogrenci (kayit_no INTEGER PRIMARY KEY
##AUTOINCREMENT,adi VARCHAR(50),soyadi VARCHAR(50),bolum VARCHAR(50))''')
adi=input("Öğrenci adını giriniz:")
soyadi=input("Öğrenci soyadını giriniz:")
bolumu=input("Öğrencinin bölümü:")
isaretci.execute(''' INSERT INTO ogrenci (adi,soyadi,bolum) VALUES("%s","%s"
,"%s")'''%(adi,soyadi,bolumu))
sorgu=isaretci.execute("SELECT * FROM ogrenci")
print(sorgu.fetchall())
baglanti.commit() 
baglanti.close()



import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
##sorgu=isaretci.execute('''CREATE TABLE ogrenci (kayit_no INTEGER PRIMARY KEY
##AUTOINCREMENT,adi VARCHAR(50),soyadi VARCHAR(50),bolum VARCHAR(50))''')
arama=input("Aramak istediğiniz öğrenci adı:")
sorgu=isaretci.execute('''SELECT * FROM ogrenci WHERE
adi LIKE "%(0)%"'''.format(arama))
for i in sorgu.fetchall():
    print(i[3])
baglanti.commit() 
baglanti.close()


import sqlite3
baglanti=sqlite3.connect('ornek.db')
isaretci=baglanti.cursor()
sorgu.isaretci.execute("SELECT * FROM ogrenci sqlite_master")
print(sorgu.fetchall())
baglanti.commit() 
baglanti.close()
