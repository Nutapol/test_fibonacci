enum PageType { albumList, playList, setting }

extension PageTypeExtension on PageType {
  int get index {
    switch (this) {
      case PageType.albumList:
        return 0;
      case PageType.playList:
        return 1;
      case PageType.setting:
        return 2;
    }
  }
}
