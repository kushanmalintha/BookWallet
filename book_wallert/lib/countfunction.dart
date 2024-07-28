class CountReact {
  int likeCount;
  int shareCount;

  CountReact({this.likeCount = 100, this.shareCount = 100});

  void likeIncrease() {
    likeCount++;
  }

  void shareIncrease() {
    shareCount++;
  }
}
