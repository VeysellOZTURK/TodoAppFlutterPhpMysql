import 'package:flutter/material.dart'; // Flutter'ın temel UI kütüphanesini içe aktarıyoruz
import 'dart:convert'; // JSON işlemleri için kütüphane
import 'package:http/http.dart'
    as http; // HTTP istekleri için http kütüphanesini kullanıyoruz

void main() {
  runApp(TodoApp()); // Uygulamayı başlatıyoruz
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App', // Uygulama başlığını tanımlıyoruz
      home:
          TodoListScreen(), // Ana ekran olarak TodoListScreen widget'ını belirliyoruz
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() =>
      _TodoListScreenState(); // Ekranın durum yönetimi
}

class _TodoListScreenState extends State<TodoListScreen> {
  List todos = []; // Görevleri saklamak için bir dizi tanımlıyoruz

  @override
  void initState() {
    super.initState();
    fetchTodos(); // Ekran yüklendiğinde görevleri alıyoruz
  }

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse(
        'http://localhost/api/get_todos.php')); // Görevleri listelemek için GET isteği gönderiyoruz
    if (response.statusCode == 200) {
      // İstek başarılıysa
      setState(() {
        todos = json.decode(response
            .body); // Görevleri JSON formatında çözüp diziye aktarıyoruz
      });
    }
  }

  Future<void> addTodo(String title) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/api/add_todo.php'), // Yeni görev eklemek için POST isteği gönderiyoruz
      body: {'title': title}, // İstek gövdesine görev başlığını ekliyoruz
    );

    if (response.statusCode == 200) {
      fetchTodos(); // Görev eklendikten sonra listeyi yeniliyoruz
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/api/delete_todo.php'), // Görev silmek için POST isteği gönderiyoruz
      body: {'id': id.toString()}, // İstek gövdesine görev kimliğini ekliyoruz
    );

    if (response.statusCode == 200) {
      fetchTodos(); // Görev silindikten sonra listeyi yeniliyoruz
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(); // Görev ekleme için metin kontrolörü oluşturuyoruz

    return Scaffold(
      appBar: AppBar(
          title: Text("Todo List")), // Başlık çubuğuna uygulama adı ekliyoruz
      body: Column(
        children: [
          TextField(
            controller: titleController, // Metin alanını kontrolöre bağlıyoruz
            decoration: InputDecoration(
                labelText: 'New Todo'), // Metin alanına etiket ekliyoruz
          ),
          ElevatedButton(
            onPressed: () {
              addTodo(titleController
                  .text); // Butona basıldığında yeni görevi ekliyoruz
              titleController
                  .clear(); // Görev eklendikten sonra metin alanını temizliyoruz
            },
            child: Text("Add Todo"), // Buton etiketini belirliyoruz
          ),
          Expanded(
            child: ListView.builder(
              // Görevleri listelemek için liste oluşturuyoruz
              itemCount:
                  todos.length, // Görev sayısı kadar liste öğesi oluşturuyoruz
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      todos[index]['title']), // Görev başlığını gösteriyoruz
                  trailing: IconButton(
                    icon: Icon(Icons.delete), // Silme ikonu ekliyoruz
                    onPressed: () => deleteTodo(
                        todos[index]['id']), // Silme işlemi başlatıyoruz
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
