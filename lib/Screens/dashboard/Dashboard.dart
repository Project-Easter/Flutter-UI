import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books_app/Models/books.dart';
import 'package:books_app/Models/book.dart';
import 'package:books_app/Models/user.dart';
import 'book_list.dart';
import 'user_choice.dart';
import 'quotes.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var discoverNew = Provider.of<Books>(context).discoverNew;
    var recommendedBooks = Provider.of<Books>(context).recommendedBooks;
    final userData = Provider.of<UserData>(context);
    print(userData);
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Quotes(),
            UserChoice(),
            BookList('Discover New', discoverNew),
            BookList('Recommended for you', recommendedBooks),
            UserChoiceBooks(title: 'Based on your Interest'),
          ],
        ),
      ),
    );
  }

  // booksTile(String title) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
  //         child: Text(title,
  //             style: GoogleFonts.poppins(
  //                 color: Colors.black,
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.w600)),
  //       ),
  //       Container(
  //         height: 320,
  //         child: ListView(
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           children: <Widget>[
  //             book(
  //                 'https://images.unsplash.com/photo-1592903189708-add4d2987b1d?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=508&q=80',
  //                 'The Golem and the Jinni',
  //                 'Helence Wecker'),
  //             book(
  //                 'https://images.unsplash.com/photo-1607948937289-5ca19c59e70f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8bm92ZWx8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //                 'Economics:The User Guide',
  //                 'Ha-Joon Chang'),
  //             book(
  //                 'https://images.unsplash.com/photo-1573488721809-e0f256ad3ad8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTV8fG5vdmVsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  //                 'Endurance',
  //                 'Alfred Lansing'),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  // book(String imageLink, String bookName, String authorName) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: GestureDetector(
  //             child: Container(
  //               height: 192,
  //               width: 140,
  //               decoration: new BoxDecoration(
  //                   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
  //                   borderRadius: BorderRadius.circular(10),
  //                   image: new DecorationImage(
  //                       image: NetworkImage(imageLink), fit: BoxFit.fill)),
  //             ),
  //             onTap: () {
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (context) => BookDescription(
  //                     imgLink: imageLink,
  //                     authorName: authorName,
  //                     bookName: bookName,
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         Text(
  //           bookName,
  //           style: GoogleFonts.poppins(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         Text(
  //           authorName,
  //           style: GoogleFonts.poppins(
  //             color: Colors.black.withOpacity(0.5),
  //             fontWeight: FontWeight.w500,
  //             fontSize: 12,
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(left: 100),
  //           child: IconButton(
  //             alignment: Alignment.topRight,
  //             onPressed: () {},
  //             icon: Icon(Icons.bookmark_outline_rounded),
  //             iconSize: 20,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // userChoice() {
  //   return Padding(
  //     padding: const EdgeInsets.all(15),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30),
  //         color: Colors.white10,
  //         border: Border.all(color: Colors.black),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
  //         child: Column(
  //           children: <Widget>[
  //             Text(
  //               'Whats Your Choice?',
  //               style:
  //                   GoogleFonts.muli(fontSize: 24, fontWeight: FontWeight.w700),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.fromLTRB(30, 8, 30, 0),
  //               child: Text(
  //                 'Share your interests for best recommendations of books within your location range',
  //                 softWrap: true,
  //                 textAlign: TextAlign.center,
  //                 style: GoogleFonts.muli(
  //                     fontSize: 14,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //             ),
  //             //-----------------
  //             Padding(
  //               padding: const EdgeInsets.all(20),
  //               child: AspectRatio(
  //                 aspectRatio: 343 / 52,
  //                 child: Container(
  //                   child: MaterialButton(
  //                     color: blackButton,
  //                     child: new Text(
  //                       'Personalize',
  //                       style: GoogleFonts.poppins(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 16),
  //                     ),
  //                     onPressed: () async {
  //                       userPreferences(context);
  //                     },
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(16)),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //TODO:GET quotes from Quotes API
  //This is a placeholder quote new quote every time.
  //***End of class
}

// class UserChoiceBooks extends StatelessWidget {
//   const UserChoiceBooks({Key key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       builder: (context, snapshot) {
//         // if(snapshot.h)
//       },
//     );
//   }
// }

class UserChoiceBooks extends StatelessWidget {
  final String title;
  UserChoiceBooks({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Books>(context, listen: false)
            .getRecommendedBooks("test"),
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final List<Book> recommendedBooksML = snapshot.data;
              return BookList(title, recommendedBooksML);
            } else {
              return SizedBox.shrink();
            }
          } else {
            return Container();
          }
        }
        //  ... some code here
        );
  }
}
