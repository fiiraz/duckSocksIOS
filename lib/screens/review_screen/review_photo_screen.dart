import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/layouts/dialog.dart';

class PhotoScreen extends StatefulWidget {
  ReviewsPresenter presenter;

  PhotoScreen(presenter) {
    this.presenter = presenter;
  }

  @override
  _PhotoScreenState createState() => new _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  ScrollController controller;

  @override
  void initState() {
    if (!this.mounted) {
      super.initState();
      this.widget.presenter = new ReviewsPresenter(this);
      this.widget.presenter.prepareScreen();
      controller = new ScrollController()..addListener(_scrollListener);
    }
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
          itemExtent: 180,
          controller: controller,
          itemBuilder: (context, index) {
            var image = 'assets/images/sock1.jpeg';
            return Card(
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: new ListTile(
                onTap: () {},
                title: new Image.asset(
                  image,
                  height: 140,
                  width: 420,
                  fit: BoxFit.fill,
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
        //  setState(() {});
      });
    }
  }
}
