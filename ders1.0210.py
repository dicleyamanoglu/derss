goruntulenler=[]
secenek=input("Ürün görüntülemek istiyorsanız A harfine görüntüleme sayısi için B harfine tıklayınız.")

def goruntulenme():
    while True:
    urun=input("Görüntülenen ürün:")
    if urun=="q":
        break
    else:
        goruntulenenler.append(urun)
        continue

def goruntulenmeSay():
    arananUrun=input("Aranan Ürün:")
    print("Görüntülenme sayısı:",goruntulenenler.count(arananUrun))
if secenek=="A":
    goruntulenme()
elif secenek=="B":
    goruntulenmeSay()

#pyQt
