class Coffee{
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap(){
    return {
      'Name': name,
      'Price': price,
      'Image': imagePath
    };
  }
  static Coffee fromMap(Map<String, dynamic> map) {
    print(map);
    return Coffee(
      name: map['Name'], // מזהה המשתמש
      price: map['Price'], // כתובת הדוא"ל של המשתמש
      imagePath: map['Image'] , // מציין אם יש למשתמש הודעות לא נקראות (ברירת מחדל: אין הודעות לא נקראות)
    );
  }


}