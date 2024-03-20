class SUChattedState {
  SUChattedState() {
    ///Initialize variables
  }
}

class ChatItemModel {
  final String avatarUrl;
  final String name;
  final String lastMessage;
  final String lastTime;
  final bool isSelect;

  ChatItemModel({
    required this.avatarUrl,
    required this.name,
    required this.lastMessage,
    required this.lastTime,
    required this.isSelect,
  });
}
