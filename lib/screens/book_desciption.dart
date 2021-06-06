import 'package:books_app/Services/database_service.dart';
import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class BookDescription extends StatefulWidget {
  final Book bookFromList;
  const BookDescription({Key key, this.bookFromList}) : super(key: key);
  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final Type bodyGlobalKey = GlobalKey;
  TabController _tabController;
  bool fixedScroll;

  Widget bookDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
          child: Text(
            'Description',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
          child: ReadMoreText(
            widget.bookFromList.description,
            // "",
            // description,
            style: GoogleFonts.poppins(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
                fontSize: 14),
            trimLines: 6,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            moreStyle: GoogleFonts.poppins(color: Colors.red, fontSize: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic uid = _authService.getUID;
    final DatabaseService _databaseService =
        DatabaseService(uid: uid as String);
    print(widget.bookFromList.rating);
    print(_tabController.index);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Book Description',
          style: GoogleFonts.muli(color: Colors.black),
        ),
      ),
      // body: Consumer<Book>(
      //   builder: (context, book, _) => NestedScrollView(
      //     headerSliverBuilder: (context, value) {
      //       return [
      //         SliverToBoxAdapter(child: bookDisplay(book)),
      //         SliverToBoxAdapter(
      //           child: TabBar(
      //             controller: _tabController,
      //             labelColor: Colors.black,
      //             tabs: [
      //               Tab(
      //                 child: Text(
      //                   'About Book',
      //                   style: GoogleFonts.poppins(
      //                       color: Colors.black,
      //                       fontWeight: FontWeight.w400,
      //                       fontSize: 14),
      //                 ),
      //               ),
      //               Tab(
      //                 child: Text(
      //                   'Owner\'s Info',
      //                   style: GoogleFonts.poppins(
      //                       color: Colors.black,
      //                       fontWeight: FontWeight.w400,
      //                       fontSize: 14),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ];
      //     },
      //     body: Container(
      //       child: TabBarView(
      //         controller: _tabController,
      //         children: [
      //           ListView(
      //             physics: const ClampingScrollPhysics(),
      //             children: <Widget>[
      //               bookDexcription(book.description),
      //               Divider(
      //                 thickness: 1,
      //                 indent: 15,
      //                 endIndent: 15,
      //               ),
      //               genre(),
      //               Divider(
      //                 thickness: 1,
      //                 indent: 15,
      //                 endIndent: 15,
      //               ),
      //               reviews(),
      //               Padding(
      //                 padding: const EdgeInsets.all(18.0),
      //                 child: button(
      //                     context, blackButton, 'Exchange this Book', ''),
      //               ),
      //             ],
      //           ),
      //           ListView(
      //             physics: NeverScrollableScrollPhysics(),
      //             children: <Widget>[
      //               ownerDetails(),
      //               Padding(
      //                 padding: const EdgeInsets.all(15.0),
      //                 child: Column(
      //                   children: [
      //                     button(context, blackButton, 'Visit Profile',
      //                         publicProfile),
      //                     button(
      //                         context, greenButton, 'Exchange this Book', ''),
      //                     ratings(),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool value) {
          return <SliverToBoxAdapter>[
            SliverToBoxAdapter(
                child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 192,
                      width: 140,
                      decoration: BoxDecoration(
                        boxShadow: const <BoxShadow>[
                          BoxShadow(color: Colors.grey, blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.bookFromList.imageUrl),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Text(
                    widget.bookFromList.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.bookFromList.author,
                    // book.author,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: IconButton(
                      alignment: Alignment.topRight,
                      onPressed: () async {
                        try {
                          setState(() {
                            widget.bookFromList.changeBookMark();
                          });
                          _databaseService.updateBookMark(widget.bookFromList);
                        } catch (e) {
                          print(e.toString());
                        }
                        print('Book Marked');
                      },
                      icon: widget.bookFromList.isBookMarked != null
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_outline_rounded),
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                tabs: <Tab>[
                  Tab(
                    child: Text(
                      'About Book',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  Tab(
                    child: Text(
                      // ignore: avoid_escaping_inner_quotes
                      'Owner\'s Info',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ListView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                bookDescription(widget.bookFromList.description),
                const Divider(
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                genre(),
                const Divider(
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                reviews(),
                // Padding(
                //   padding: const EdgeInsets.all(18.0),
                //   child:
                //       button(context, blackButton, 'Exchange this Book', ''),
                // ),
                if (widget.bookFromList.isOwned != null)
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CupertinoStyleButton(
                        color: blackButton,
                        name: 'Rate this Book',
                        myFunction: () async {
                          final int stars = await showDialog(
                              context: context, builder: (_) => RatingDialog());
                          if (stars == null) return;
                          print('Selected rate stars: $stars');
                          _databaseService.updateRating(
                              stars.toDouble(), widget.bookFromList.isbn);
                          print('Update Ratings');
                        }),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CupertinoStyleButton(
                        color: blackButton,
                        name: 'Exchange this Book',
                        myFunction: () async {}),
                  ),
                if (widget.bookFromList.isOwned != null)
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CupertinoStyleButton(
                        color: blackButton,
                        name: 'Remove this Book',
                        myFunction: () async {
                          _databaseService.removeBook(widget.bookFromList.isbn);
                          Navigator.of(context).pop();
                          print('Book Removed');
                        }),
                  )
                else
                  const SizedBox(),
              ],
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                ownerDetails(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      button(context, blackButton, 'Visit Profile',
                          Routes.PUBLIC_PROFILE),
                      button(context, greenButton, 'Exchange this Book', ''),
                      ratings(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // bookDisplay(Book book) {
  //   return Center(
  //     child: Column(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Container(
  //             height: 192,
  //             width: 140,
  //             decoration: new BoxDecoration(
  //               boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 15)],
  //               borderRadius: BorderRadius.circular(10),
  //               image: new DecorationImage(
  //                   image: NetworkImage(widget.bookFromList.imageUrl),
  //                   fit: BoxFit.fill),
  //             ),
  //           ),
  //         ),
  //         Text(
  //           widget.bookFromList.title,
  //           textAlign: TextAlign.center,
  //           style: GoogleFonts.poppins(
  //             color: Colors.black,
  //             fontSize: 22,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         Text(
  //           widget.bookFromList.author,
  //           // book.author,
  //           style: GoogleFonts.poppins(
  //             color: Colors.black.withOpacity(0.5),
  //             fontWeight: FontWeight.w500,
  //             fontSize: 15,
  //           ),
  //         ),
  //         //Try Listening with consumer
  //         Padding(
  //           padding: EdgeInsets.only(left: 100),
  //           child: IconButton(
  //             alignment: Alignment.topRight,
  //             onPressed: () {
  //               _databaseService
  //               setState(() {
  //                 widget.bookFromLsist.changeBookMark();
  //               });
  //               //Needs fix
  //               // book.changeBookMark();
  //             },
  //             icon:
  //                 // book.isBookMarked
  //                 widget.bookFromList.isBookMarked
  //                     ? Icon(Icons.bookmark)
  //                     : Icon(Icons.bookmark_outline_rounded),
  //             iconSize: 20,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget genre() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 28,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text('Action',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
            ),
          ),
          Container(
            height: 28,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Fantasy',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget ownerDetails() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text(
            'Jane Doe',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 36, fontWeight: FontWeight.w400),
          ),
          Text(
            'SAN FRANSISCO, CA',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'jane@example.com',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget ratings() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Note : The exchange will be done on the consent of both the users and an autogenerated mail will be sent to both when the exchange gets finally completed',
        style: GoogleFonts.muli(
            color: Colors.redAccent, fontWeight: FontWeight.bold),
        softWrap: true,
      ),
    );
  }

  Widget reviews() {
    final TextEditingController _commentController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Reviews',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          AspectRatio(
            aspectRatio: 343 / 52,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _commentController,
                maxLines: 5,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: 'Add your comment',
                    hintStyle: GoogleFonts.muli(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
                onSubmitted: (String value) {
                  setState(() {
                    _commentController.text = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
