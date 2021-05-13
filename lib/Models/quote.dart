import 'dart:math';

class Quote {
  String text;
  String author;
  Quote({this.text, this.author});

  //Get a single quote
  Quote getQuote() {
    Random random = new Random();
    int randomNumber = random.nextInt(7);
    return quotesList[randomNumber];
  }
}

List<Quote> quotesList = [
  new Quote(text: "Genius is one percent inspiration and ninety-nine percent perspiration.", author: "Thomas Edison"),
  new Quote(text: "Be the chief but never the lord.", author: "Lao Tzu"),
  new Quote(text: "Genius is one percent inspiration and ninety-nine percent perspiration.", author: "Thomas Edison"),
  new Quote(text: "Fate is in your hands and no one elses", author: "Byron Pulsifer"),
  new Quote(text: "Difficulties increase the nearer we get to the goal.", author: "Johann Wolfgang von Goethe"),
  new Quote(text: "A house divided against itself cannot stand.", author: "Abraham Lincoln"),
  new Quote(text: "You can observe a lot just by watching.", author: "Yogi Berra"),
  new Quote(text: "Well begun is half done.", author: "Aristotle"),
];
