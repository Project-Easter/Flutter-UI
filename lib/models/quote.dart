import 'dart:math';

List<Quote> quotesList = <Quote>[
  Quote(
      text:
          'Genius is one percent inspiration and ninety-nine percent perspiration.',
      author: 'Thomas Edison'),
  Quote(text: 'Be the chief but never the lord.', author: 'Lao Tzu'),
  Quote(
      text:
          'Genius is one percent inspiration and ninety-nine percent perspiration.',
      author: 'Thomas Edison'),
  Quote(
      text: 'Fate is in your hands and no one elses', author: 'Byron Pulsifer'),
  Quote(
      text: 'Difficulties increase the nearer we get to the goal.',
      author: 'Johann Wolfgang von Goethe'),
  Quote(
      text: 'A house divided against itself cannot stand.',
      author: 'Abraham Lincoln'),
  Quote(text: 'You can observe a lot just by watching.', author: 'Yogi Berra'),
  Quote(text: 'Well begun is half done.', author: 'Aristotle'),
];

class Quote {
  String text;
  String author;
  Quote({this.text, this.author});

  Quote getQuote() {
    final Random random = Random();
    final int randomNumber = random.nextInt(7);
    return quotesList[randomNumber];
  }
}
