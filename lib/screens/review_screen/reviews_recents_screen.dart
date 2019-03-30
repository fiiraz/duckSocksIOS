import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/layouts/comment_builder.dart';
import 'package:simplefire/screens/layouts/dialog.dart';
import 'package:simplefire/screens/widgets/star_rating.dart';


class ReviewsRecentsScreen extends StatefulWidget {
  ReviewsPresenter presenter;

  ReviewsRecentsScreen(presenter) {
    this.presenter = presenter;
  }

  @override
  _ReviewsRecentsScreenState createState() => new _ReviewsRecentsScreenState();
}

class _ReviewsRecentsScreenState extends State<ReviewsRecentsScreen> {
  ScrollController controller;

  @override
  void initState() {
    if (!this.mounted) {
      super.initState();
      this.widget.presenter = new ReviewsPresenter(this);
      this.widget.presenter.prepareScreen();
    }
    controller = new ScrollController()..addListener(_scrollListener);
  }

  showDialogBox(name, title, context, image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return showReview(name, title, context, image);
      },
    );
  }

  @override
  void dispose() {
    this.widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.presenter.recentReviews.isEmpty) {
      return Container();
    } else {
      return Scrollbar(
        child: ListView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            var text = widget.presenter.recentReviews[index].comment;
            var name = widget.presenter.recentReviews[index].reviewer.title;
            /* var image = widget
                .presenter
                .recentReviews[index]
                .reviewer.lastPhotoUrl;*/
            var image = 'assets/images/sock1.jpeg';
            double rate =
            double.parse(widget.presenter.recentReviews[index].rate);
            return Card(
              elevation: 3.0,
              //   margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
                child: new ListTile(
                  onTap: () {
                    showDialogBox(name, text, context, image);
                  },
                  title: Container(
                    //      padding: EdgeInsets.only(right: 10),
                    child: new Text(CommentBuilder.SurnameBuilder(name)),
                  ),
                  leading: Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height / 30.85, 0, 0),
                    //    height: MediaQuery.of(context).size.height/8.85,
                    width: MediaQuery.of(context).size.width/6,
                    child: new Image.asset(
                      image,
                    ),
                  ),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width /2.8,
                    child: StarRate(rate),
                  ),
                  subtitle: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: Text(
                                    text,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: widget.presenter.recentReviews.length,
        ),
      );
    }
  }

/*  fillData() {
    setState(() {});
  }*/

  void _scrollListener() {
//    print(controller.position.extentAfter);
    if ((controller.position.extentAfter <= 0) &&
        (controller.position.pixels == controller.position.maxScrollExtent)) {
      this.widget.presenter.loadMoreRecents().then((_) {
        setState(() {
        });
      });
    }
  }
}