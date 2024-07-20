import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// star rating bar
// ignore: must_be_immutable
class RatingBar extends StatelessWidget {
  // rating
  final double rating;
  // size of star
  final double size;
  // rating out of how many
  final int ratingCount;

  const RatingBar(
      {super.key, required this.rating, this.ratingCount = 5, this.size = 15});

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];
    // 3.5 => 3
    int realNum = rating.floor();
    // 3.5 => 0.5
    int partNum = ((rating - realNum) * 10).ceil();
    for (int i = 0; i < ratingCount; i++) {
      if (i < realNum) {
        starList.add(Icon(
          Icons.star,
          color: MyColors.starColor,
          size: size,
        ));
      } else if (i == realNum) {
        starList.add(SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(Icons.star, color: MyColors.starColor, size: size),
                ClipRect(
                  clipper: _Clipper(part: partNum),
                  child: Icon(Icons.star,
                      color: MyColors.nonSelectedItemColor, size: size),
                )
              ],
            )));
      } else {
        starList.add(
            Icon(Icons.star, color: MyColors.nonSelectedItemColor, size: size));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: starList,
    );
  }
}

// clip the star
class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
