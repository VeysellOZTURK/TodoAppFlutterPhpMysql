<?php
include 'db.php'; // Veritabanı bağlantısı dosyasını dahil ediyoruz

if ($_SERVER['REQUEST_METHOD'] === 'POST') { // Sadece POST isteği ile çalışmasını sağlıyoruz
    $id = $_POST['id']; // Görevin kimliğini alıyoruz
    $stmt = $conn->prepare("DELETE FROM todos WHERE id = ?"); // Görevi silmek için SQL sorgusu hazırlıyoruz
    $stmt->bind_param("i", $id); // Görev kimliğini sorguya ekliyoruz
    
    if ($stmt->execute()) { // Sorgu başarılıysa
        echo json_encode(["status" => "success", "message" => "Todo deleted"]); // Başarı mesajı gönderiyoruz
    } else { // Hata varsa
        echo json_encode(["status" => "error", "message" => "Failed to delete todo"]); // Hata mesajı gönderiyoruz
    }

    $stmt->close(); // Sorguyu kapatıyoruz
}
$conn->close(); // Veritabanı bağlantısını kapatıyoruz
?>
