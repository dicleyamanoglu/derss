import sys
from PyQt4.QtGui import *
#Objeler tanımlandı.
uyg=QApplication(sys.argv)
pencere=QWidget()
etiket=QLabel('<font color="blue" size="+3">Merhaba Dünya</font>')
dugme=QPushButton('Tıkla')
kutu=QVBoxLayout()
kutu.addWidget(etiket)
kutu.addWidget(dugme)
pencere.setLayout(kutu)
pencere.show()
uyg.exec_
