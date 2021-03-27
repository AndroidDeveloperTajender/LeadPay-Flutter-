class banks{

  final String image;


  banks({this.image});

  static List<banks> allCities()
  {
    var lstOfCities = new List<banks>();


    lstOfCities.add(new banks(image: "assets/Logo/Logo1.jpg"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo2.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo3.jpg"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo4.jpg"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo5.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo6.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo7.jpg"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo8.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo9.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo10.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo11.png"));
    lstOfCities.add(new banks(image: "assets/Logo/Logo12.jpg"));



    return lstOfCities;
  }
}