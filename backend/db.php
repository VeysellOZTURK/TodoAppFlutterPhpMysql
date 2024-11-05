<?php
$host = 'localhost'; // Veritabanı sunucusu adresi
$db = 'todo_app'; // Kullandığımız veritabanı adı
$user = 'root'; // Veritabanı kullanıcı adı
$pass = ''; // Veritabanı parolası (eğer varsa buraya yazılmalı)

$conn = new mysqli($host, $user, $pass, $db); // MySQL veritabanına bağlantı kuruyoruz

if ($conn->connect_error) { // Eğer bağlantıda bir hata varsa kontrol ediyoruz
    die("Connection failed: " . $conn->connect_error); // Hata varsa işlemi durdurup hata mesajını gösteriyoruz
}
?>
