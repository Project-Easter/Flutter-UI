import 'package:books_app/constants/colors.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/book.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/widgets/book_description/genres.dart';
import 'package:books_app/widgets/book_description/owner_info.dart';
import 'package:books_app/widgets/button.dart';
import 'package:books_app/widgets/error_dialog.dart';
import 'package:books_app/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class BookDescription extends StatefulWidget {
  final Book? bookFromList;
  const BookDescription({Key? key, this.bookFromList}) : super(key: key);
  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription>
    with SingleTickerProviderStateMixin {
  final FirebaseAuthService _authService = FirebaseAuthService();
  TabController? _tabController;

  Widget bookDescription(String? description) {
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
            widget.bookFromList!.description!,
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
    print(widget.bookFromList!.rating);
    print(_tabController!.index);
    return SafeArea(
      child: Scaffold(
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
            style: GoogleFonts.lato(color: Colors.black),
          ),
        ),
        body: NestedScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
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
                              image:
                                  NetworkImage(widget.bookFromList!.imageUrl!),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Text(
                      widget.bookFromList!.title!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.bookFromList!.author!,
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
                              widget.bookFromList!.changeBookMark();
                              _databaseService
                                  .updateBookMark(widget.bookFromList!);
                            });
                            // _databaseService.updateBookMark(widget.bookFromList);
                          } catch (e) {
                            print(e.toString());
                          }
                          print('Book Marked');
                        },
                        icon: widget.bookFromList!.isBookMarked!
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
                  bookDescription(widget.bookFromList!.description),
                  const Divider(
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Genres(),
                  const Divider(
                    thickness: 1,
                    indent: 15,
                    endIndent: 15,
                  ),
                  // Reviews(),

                  if (widget.bookFromList!.isOwned == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Button(
                              // color: blackButton,
                              name: 'Rate this Book',
                              myFunction: () async {
                                final int? stars = await showDialog(
                                    context: context,
                                    builder: (_) => RatingDialog());
                                if (stars == null) return;
                                print('Selected rate stars: $stars');
                                // _databaseService.updateRating(
                                //     stars.toDouble(), widget.bookFromList.isbn);
                                print('Update Ratings');
                              }),
                          Button(
                              // color: blackButton,
                              name: 'Remove this Book',
                              myFunction: () async {
                                _databaseService
                                    .removeBook(widget.bookFromList!.isbn);
                                Navigator.of(context).pop();
                                print('Book Removed');
                              }),
                        ],
                      ),
                    )
                  else
                    Button(
                        // color: blackButton,
                        name: 'Exchange this Book',
                        myFunction: () async {}),
                ],
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  OwnerInfo(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Button(
                          name: 'Exchange this Book',
                          color: Theme.of(context).colorScheme.onSecondary,
                          textColor: Colors.white,
                          myFunction: () => showErrorDialog(
                            context,
                            'Note : The exchange will be done on the consent of both the users and an autogenerated mail will be sent to both when the exchange gets finally completed',
                          ),
                        ),
                        Button(
                          // color: blackButton,
                          name: 'Visit Profile',
                          myFunction: () async {
                            Navigator.pushNamed(context, Routes.PUBLIC_PROFILE);
                          },
                        )
                        // Button(context, blackButton, 'Visit Profile',
                        //     Routes.PUBLIC_PROFILE),
                        // button(context, greenButton, 'Exchange this Book',
                        //     Routes.CHAT),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // Widget ratings() {
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: Text(
  //       'Note : The exchange will be done on the consent of both the users and an autogenerated mail will be sent to both when the exchange gets finally completed',
  //       style: GoogleFonts.muli(
  //           color: Colors.redAccent, fontWeight: FontWeight.bold),
  //       softWrap: true,
  //     ),
  //   );
  // }
}
