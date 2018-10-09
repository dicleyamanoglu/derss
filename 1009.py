import sys
from PyQt4.QtGui import *
uyg=QApplication(sys.argv)
pencere=QWidget()
etiket=QLabel('<font color="purple" size="+3">Merhaba Dünya</font>')
dugme=QPushButton('Tıkla')
kutu=QVBoxLayout()
kutu.addWidget(etiket)
kutu.addWidget(dugme)
pencere.setLayout(kutu)
pencere.setWindowTitle("Programlama")
pencere.show()
uyg.exec_

#etiket.show()
#pencere.setWindowTitle("Programlama")
#QVBoxLayout dikey, QHBoxLayout yatay
#izgara=QGridLayout()
#izgara.addWidget(eklenecek parçacık,başlangıç satırı,baş.sütunu,satır genişliği,sütun gen.)
