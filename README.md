# Üniversite Mezun Platformu (Alumni Platform)

Bu proje JSP, Servlet ve MongoDB kullanılarak geliştirilmiş bir Mezun/Yıllık platformudur.

## Gereksinimler

Projenin çalışması için bilgisayarınızda aşağıdakilerden **en az biri** kurulu olmalıdır:

1.  **Docker** (Önerilen)
2.  **Java JDK 17+**, **Maven** ve **Tomcat 10+** (veya yerel MongoDB)

## Kurulum ve Çalıştırma

### Yöntem 1: Docker ile Çalıştırma (En Kolay)

Eğer Docker masaüstü uygulamanız varsa, Mongo veritabanı kurulumuyla uğraşmadan projeyi direkt ayağa kaldırabilirsiniz. Ancak bu projede Dockerfile sadece Tomcat sunucusunu içerir. Veritabanı için iki seçeneğiniz vardır:
1.  Bilgisayarınızda çalışan yerel bir MongoDB.
2.  Cloud (Atlas/Railway) MongoDB URI adresi.

**Adımlar:**

1.  Projeyi derleyin (Terminal proje dizininde iken):
    ```bash
    docker build -t alumni-app .
    ```

2.  Projeyi çalıştırın:
    *   **Eğer yerel MongoDB kullanıyorsanız** (host networkunu kullanır):
        ```bash
        docker run --network="host" alumni-app
        ```
    *   **Eğer Cloud MongoDB (örn: Railway/Atlas) kullanıyorsanız**:
        ```bash
        docker run -p 8080:8080 -e MONGO_URI="mongodb+srv://..." alumni-app
        ```

Uygulama `http://localhost:8080` adresinde çalışacaktır.

---

### Yöntem 2: Maven ve Tomcat ile Manuel Kurulum

1.  **Projeyi Derleyin:**
    Terminalde proje klasöründe şu komutu çalıştırın:
    ```bash
    mvn clean package
    ```
    Bu işlem `target/` klasörü altında `alumni-platform.war` dosyasını oluşturacaktır.

2.  **Tomcat'e Yükleyin:**
    *   `alumni-platform.war` dosyasını Tomcat kurulumunuzun `webapps/` klasörüne kopyalayın.
    *   Dosya adını `ROOT.war` olarak değiştirirseniz direkt `localhost:8080` adresinde açılır. Değiştirmezseniz `localhost:8080/alumni-platform` adresinde açılır.

3.  **Veritabanı Bağlantısı:**
    *   Bilgisayarınızda MongoDB kurulu ve çalışıyor olmalıdır (Varsayılan: `localhost:27017`).
    *   Uygulama otomatik olarak yerel veritabanına bağlanmayı deneyecektir.

### Yöntem 3: IDE (IntelliJ IDEA / Eclipse)

1.  Projeyi IDE'de "Maven Project" olarak açın.
2.  Tomcat konfigürasyonunu "Run Configuration" kısmından ekleyin.
3.  Deploy edilecek artifact olarak `alumni-platform:war exploded` seçin.
4.  Çalıştırın.

## Varsayılan Kullanıcılar

Sistemi test etmek için kayıt ol sayfasından yeni bir kullanıcı oluşturabilirsiniz.
*   **Admin Yetkisi Vermek İçin:**
    *   MongoDB veritabanında `users` koleksiyonunda ilgili kullanıcının `role` alanını `admin` olarak güncelleyin.
    *   Veya `DatabaseManager` veya geçici bir kod ile ilk kullanıcıyı admin yapabilirsiniz.

## Proje Yapısı

*   `src/main/java`: Backend kodları (Model, DAO, Controller).
*   `src/main/webapp`: Frontend kodları (JSP, CSS, Resimler).
*   `Dockerfile`: Konteyner yapılandırması.
*   `pom.xml`: Maven bağımlılıkları.
