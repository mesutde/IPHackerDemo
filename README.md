# IPHackerDemo

---

## 📌 Açıklama | Description

**Türkçe:**  
Bu proje, Delphi ile geliştirilmiş bir IP konum analiz aracıdır. Komut satırında çalışan açık kaynaklı [IP-Hacker](https://github.com/rsbench/IP-Hacker) uygulaması ile entegre şekilde çalışır. Kullanıcıdan alınan IP adresini komut satırı aracılığıyla sorgular, gelen JSON verisini çözümler ve sonuçları Delphi `TStringGrid` bileşenlerinde "başarılı" ve "başarısız" olarak listeler.

**English:**  
This project is an IP geolocation analysis tool developed in Delphi. It works in integration with the open-source [IP-Hacker](https://github.com/rsbench/IP-Hacker) command-line tool. It queries the given IP address through the CLI, parses the returned JSON data, and displays the results in Delphi's `TStringGrid` components categorized as "successful" or "failed".

---

## 🖥️ Özellikler | Features

- ✅ `TMaskEdit` ile IP adresi giriş kontrolü ve doğrulama  
- ✅ Komut satırından çalışan IP-Hacker çıktısını okuma  
- ✅ JSON verisini Delphi'de ayrıştırma ve UTF-8 desteği  
- ✅ Başarılı ve başarısız sonuçları iki ayrı gridde listeleme  

---

## 📷 Ekran Görüntüsü | Screenshot

![image](https://github.com/user-attachments/assets/d6b7b550-0b95-4647-beeb-d28ee0f53cdf)


---

## 🔧 Gereksinimler | Requirements

**Türkçe:**  
- Delphi XE veya üzeri  
- Windows işletim sistemi  
- [IP-Hacker.exe](https://github.com/rsbench/IP-Hacker) dosyası çalıştırılabilir olarak proje klasöründe bulunmalıdır  

**English:**  
- Delphi XE or later  
- Windows OS  
- [IP-Hacker.exe](https://github.com/rsbench/IP-Hacker) must be placed in the project directory

---

## 🚀 Kullanım | How to Use

**Türkçe:**

1. `IP-Hacker.exe` dosyasını proje klasörüne ekleyin  
2. Delphi projesini çalıştırın  
3. `TMaskEdit` alanına geçerli bir IP adresi girin (örn: 11.45.1.4)  
4. "Başlat" butonuna tıklayın  
5. Sonuçlar `TStringGrid` bileşenlerinde listelenecektir  

**English:**

1. Add `IP-Hacker.exe` into the project folder  
2. Run the Delphi project  
3. Enter a valid IP address into the `TMaskEdit` field (e.g., 11.45.1.4)  
4. Click the "Start" button  
5. Results will be displayed in `TStringGrid` components

---

## 🔗 Kaynak | Reference

Bu projede aşağıdaki açık kaynaklı araç kullanılmıştır:  
This project makes use of the following open-source tool:

- [IP-Hacker by rsbench](https://github.com/rsbench/IP-Hacker)

---

## 🧾 Lisans ve Teşekkür | License & Credits

**Türkçe:**  
Bu proje sadece demo ve eğitim amaçlı hazırlanmıştır.  
`IP-Hacker.exe` aracı [rsbench/IP-Hacker](https://github.com/rsbench/IP-Hacker) projesinden alınmıştır.  
Tüm telif hakları orijinal geliştiricisine aittir.

**English:**  
This project is for demonstration and educational purposes only.  
`IP-Hacker.exe` was taken from the [rsbench/IP-Hacker](https://github.com/rsbench/IP-Hacker) repository.  
All rights belong to the original creator.

---

## ✍️ Geliştirici | Developer

Mesut Demirci  
🇹🇷 Türkiye | Turkey, 2025
