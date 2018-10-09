import sys
from PyQt4.QtGui import *
from PyQt4.QtCore import *
def kirmiziMetin():
    metin.setText('<center><font color="red" >Kırmızı</font> </center>')

def maviMetin():
    metin.setText('<center><font color="blue" >Mavi</font> </center>')

uyg=QApplication(sys.argv)
pencere=QWidget()
izgara=QGridLayout()

metin=QLabel("YBS")
buttonKirmizi=QPushButton("Kırmızı")
pencere.connect(buttonKirmizi,SIGNAL("pressed()"),kirmiziMetin)
buttonMavi=QPushButton("Mavi")
pencere.connect(buttonMavi,SIGNAL("pressed()"),maviMetin)

izgara.addWidget(metin,0,1,2,1)
izgara.addWidget(buttonKirmizi,0,0)
izgara.addWidget(buttonMavi,1,0)

pencere.setLayout(izgara)
pencere.show()
uyg.exec_

#pencere.setFixedsize pencere büyüklüğünü sabitleme
