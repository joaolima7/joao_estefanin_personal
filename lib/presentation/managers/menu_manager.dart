import 'scroll_manager.dart';

class MenuManager {
  final ScrollManager scrollManager;

  MenuManager({required this.scrollManager});

  void onMenuClick(int index) {
    scrollManager.scrollToSection(index);
  }
}
