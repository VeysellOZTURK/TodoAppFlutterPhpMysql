<?php
include 'db.php'; // Veritabanı bağlantısı dosyasını dahil ediyoruz

if ($_SERVER['REQUEST_METHOD'] === 'POST') { // Sadece POST isteği ile çalışmasını sağlıyoruz
    $title = $_POST['title']; // Görev başlığını alıyoruz
    $stmt = $conn->prepare("INSERT INTO todos (title) VALUES (?)"); // Yeni görevi eklemek için SQL sorgusu hazırlıyoruz
    $stmt->bind_param("s", $title); // Görev başlığını sorguya ekliyoruz
    
    if ($stmt->execute()) { // Sorgu başarılıysa
        echo json_encode(["status" => "success", "message" => "Todo added"]); // Başarı mesajı gönderiyoruz
    } else { // Hata varsa
        echo json_encode(["status" => "error", "message" => "Failed to add todo"]); // Hata mesajı gönderiyoruz
    }

    $stmt->close(); // Sorguyu kapatıyoruz
}
$conn->close(); // Veritabanı bağlantısını kapatıyoruz
?>
