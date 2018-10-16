from PyQt4.QtCore import *
from PyQt4.QtGui import *

class maliyetHesaplama(QDialog):
    def __init__(self,ebeveyn=None):
        super(maliyetHesaplama,self).__init__(ebeveyn)
#Grid oluşturuldu
        grid=QGridLayout()
#Sabit Maliyet Label Eklendi
        grid.addWidget(QLabel("Sabit Maliyet:"),0,0)
#Sabit Maliyet Text Input oluşturuldu ve eklendi
        self.sabitMaliyet=QLineEdit()
        grid.addWidget(self.sabitMaliyet,0,1)
#Değişken Maliyet Label eklendi
        grid.addWidget(QLabel("Değişken Maliyet:"),1,0)
#Değişken Maliyet Text Input oluşturuldu ve eklendi
        self.degiskenMaliyet=QLineEdit()
        grid.addWidget(self.degiskenMaliyet,1,1)
#Yatırımın ekonomik yılı label ekleme
        grid.addWidget(QLabel("Yatırım Ekonomik Yılı:"),2,0)
#yatırım yılı döner kutusu eklendi
        self.yatirimYil=QSpinBox()
        self.yatirimYil.setRange(1,10)
        self.yatirimYil.setValue(1)
        grid.addWidget(self.yatirimYil,2,1)
#toplam gelir label eklendi
        grid.addWidget(QLabel("Toplam Gider:"),3,0)
#toplam gelir label label eklendi
        self.toplamGider=QLabel("")
        grid.addWidget(self.toplamGider,3,1)
#şirketin durumu label eklendi
        grid.addWidget(QLabel("Şirketin Durumu:"),4,0)
#şirketin durumu label label eklendi
        self.sirketDurum=QLabel("")
        grid.addWidget(self.sirketDurum,4,1)
#Hesapla butonu eklendi
        hesaplaDugme=QPushButton("Hesapla")
        grid.addWidget(hesaplaDugme,5,1)
        self.connect(hesaplaDugme,SIGNAL('pressed()'),self.hesapla)
#grid layout set edildi
        self.setLayout(grid)
#dialog penceresininin başlığı eklendi
        self.setWindowTitle("Maliyet Hesaplama")
        self.resize(250,150)
    def hesapla(self):
        saMa=int(self.sabitMaliyet.text())
        deMa=int(self.degiskenMaliyet.text())
        yaYi=int(self.yatirimYil.text())
        tgider=saMa+(deMa*yaYi)
        self.toplamGider.setText('<font color="purple"><b>%0.1f</b></font>'%tgider)
        tgelir=15000
        kar=tgelir-tgider
        if kar>0:
            self.sirketDurum.setText('Şirketiniz kar etmiştir.')
        elif(kar<0):
            self.sirketDurum.setText('Şirketiniz zarar etmiştir.')
        else:
            self.sirketDurum.setText('Şirketiniz başabaş noktasındadır.')
            
uygulama=QApplication([])
pencere=maliyetHesaplama()
pencere.show()
uygulama.exec_
