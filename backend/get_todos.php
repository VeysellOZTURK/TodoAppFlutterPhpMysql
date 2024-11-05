
<?php
include 'db.php'; // Veritabanı bağlantısı dosyasını dahil ediyoruz

$sql = "SELECT * FROM todos ORDER BY created_at DESC"; // Görevleri oluşturulma zamanına göre azalan sırayla seçiyoruz
$result = $conn->query($sql); // Sorguyu çalıştırıp sonuçları alıyoruz

$todos = []; // Görevleri saklamak için boş bir dizi oluşturuyoruz
if ($result->num_rows > 0) { // Eğer satır sayısı 0’dan büyükse
    while ($row = $result->fetch_assoc()) { // Her satırı döngüyle işliyoruz
        $todos[] = $row; // Satırı diziye ekliyoruz
    }
}
echo json_encode($todos); // Görevleri JSON formatında döndürüyoruz

$conn->close(); // Veritabanı bağlantısını kapatıyoruz
?>
