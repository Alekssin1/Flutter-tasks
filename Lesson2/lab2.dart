import 'dart:convert';
import 'dart:io';
typedef Json = Map<String, dynamic>;
// mixin що дозволяє відстежувати час створення об’єктів.
mixin TrackableMixin {
  late DateTime _createdAt;
  // метод, щоб додати час створення об'єкта
  void trackCreationTime() {
    _createdAt = DateTime.now();
  }

  // метод, щоб вивести час створення об'єкта
  void printCreationTime() {
    print("Об'єкт створений в: $_createdAt");
  }
}
class Person {
  String name;
  String surname;
  DateTime dateOfBirth;
  
  // Конструктор ініціалізації
  Person.create(this.name, this.surname, this.dateOfBirth) {
    // Перевірка чи не порожній ввід ім'я та прізвища
    if (name.isEmpty || surname.isEmpty) {
      assert(name.isNotEmpty && surname.isNotEmpty, 'Name and surname must not be empty');
    }

    // Перевірка чи правильно задана дата, якщо персона не може бути молодше 17 і старше 100
    int age = DateTime.now().year - dateOfBirth.year - (DateTime.now().month < dateOfBirth.month || (DateTime.now().month == dateOfBirth.month && DateTime.now().day < dateOfBirth.day) ? 1 : 0);
    if (age < 17 || age > 100){
      assert(age >= 17 && age <= 100, "Person's age must be between 17 and 100");
    }
  }

  // Метод для обчислення віку
  int calculateAge() => DateTime.now().year - dateOfBirth.year - (DateTime.now().month < dateOfBirth.month || (DateTime.now().month == dateOfBirth.month && DateTime.now().day < dateOfBirth.day) ? 1 : 0);
}


class Student extends Person with TrackableMixin {
  Map<String, double>? _grades = {};
  String _email;
  String? _address;

  // Кешування для сінглтону
  static final Map<String, Student> _cache = {};

  // Фабричний конструктор
  factory Student(String name, String surname, DateTime dateOfBirth, String email, [String? address, Map<String, double>? _grades]) {
    // Перевірка чи не порожній ввід email
    if (!_isValidEmail(email)) {
      assert(_isValidEmail(email), 'Invalid email address');
    }

    final key = '$name$surname$dateOfBirth$email$address';

    // Перевірка наявності студента у кеші
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }

    final student = Student._internal(name, surname, dateOfBirth, email, address);
    _cache[key] = student;
    return student;
  }

  // Приватний конструктор для внутрішнього використання
  Student._internal(String name, String surname, DateTime dateOfBirth, this._email, [this._address]) : super.create(name, surname, dateOfBirth){
    trackCreationTime();
  }
  
  // Гетер для отримання оцінок
  Map<String, double>? get grades => _grades;

  // Сетер оцінки за певне завдання
  void setGrade(String assignment, double grade) {
    assert(grade >= 0, "Grade can't be less than 0");
    _grades ??= {};
    _grades![assignment] = grade;
  }

  // Сетер оцінок за певні завдання
  void setGrades(Map<String, double>? gradesJson){
    _grades = gradesJson ?? {};
  }

  // Гетер для отримання адреси
  String? get address => _address;

  // Сетер для адреси
  void setAddress(String value) => _address = value.isNotEmpty ? value : throw ArgumentError("Address can't be empty");

  // Гетер для отримання email
  String get email => _email;

  // Сетер email
  void setEmail(String value) {
    if (_isValidEmail(value)) {
      _email = value;
    }
    else {
      assert(_isValidEmail(value), 'Invalid email address');
    }
  }

  // Перевірка email на коректність
  static bool _isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  // Підрахунок середньої оцінки
  double calculateAverageGrade() {
    _grades ??= {};
    if (_grades!.isEmpty) return 0.0;
    double sum = _grades!.values.reduce((a, b) => a + b);
    return sum / _grades!.length;
  }

  @override 
  String toString() => "\nName: $name\nSurname: $surname\nAge: ${calculateAge()} years old\nAverage grade: ${calculateAverageGrade()}";
}

// фільтр студентів за певними критеріями
Set<Student> filterStudents(Set<Student> students, {bool Function(Student)? condition}) {
  condition ??= (student) => student.address != "-";
  Set<Student> filteredStudents = students.where(condition).toSet();
  return filteredStudents;
}

void main() {
  String filePath = 'studentinfo.json';
  // Зчитування JSON з файлу
  String jsonData = '';
  try {
    jsonData = File(filePath).readAsStringSync();
  } catch (e) {
    print('Error reading JSON file: $e');
    return;
  }
  Json json = jsonDecode(jsonData);
  Set<Student> students = {};
  print("Students from JSON: \n");
  json.forEach((key, value) {
    String name = value['name'];
    String surname = value['surname'];
    DateTime dateOfBirth = DateTime.parse(value['dateOfBirth']);
    String email = value['email'];
    String? address = value['address'];
    //Використання null-aware assignment
    address ??= "-";
    Map<String, double>? grades = value['grades'] != null
        ? Map<String, double>.from(value['grades'])
        : null;

    Student student = Student(name, surname, dateOfBirth, email, address)
      ..setAddress(address)
      ..setGrades(grades); 

    students.add(student);
  });

  students.forEach((student) {
    print("$student\nEmail: ${student.email}\nAddress: ${student.address}");
    student.printCreationTime();
  });

  print("\n\nПеревірка, чи студенти вказують на один і той самий об'єкт в кеші");
  Student student1 = Student("Vlad", "Romanchuk", DateTime(2000, 5, 10), "VladRomanchuk@gmail.com")
    ..setAddress('St. Red Kalina, 2')
    ..setGrades({
      'Practice 0': 8,
      'Practice 1': 8,
      'Practice 2': 7,
      'Practice 3': 8,
    });
  Student student2 = Student("Vlad", "Romanchuk", DateTime(2000, 5, 10), "VladRomanchuk@gmail.com");
  print("\nЧи student1 той самий об'єкт, що й student2? ${identical(student1, student2)? 'Так':'Ні'}");
  // Ще один доказ того, що вони вказують на один і той самий об'єкт
  student1.setGrade("Practice 4", 9);
  print("Середня оцінка student1 після додавання 9 балів за 4-ту практичну ${student1.calculateAverageGrade()}");
  student2.grades?.remove("Practice 4");
  print("Середня оцінка student1 після того, як ми приберемо student2 9 балів за 4-ту практичну ${student1.calculateAverageGrade()}");
  students.add(student1);

  // Виведемо студентів чий середній бал вище 5 у порядку спадання
  Set<Student> filteredStudents = filterStudents(students, condition: (student) => student.calculateAverageGrade() >= 5);
  List<Student> sortedStudents = filteredStudents.toList()..sort((a, b) => b.calculateAverageGrade().compareTo(a.calculateAverageGrade()));
  filteredStudents = sortedStudents.toSet();
  print("\n\nРейтинг студентів з оцінкою вище 5");
  filteredStudents.forEach((student) {
    print(student);
  });
  print("\nВивід студентів з вказаною адресою");
  filterStudents(students).forEach((student) { 
    print(student);
  });
}

