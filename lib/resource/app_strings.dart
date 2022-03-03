class AppStrings {
  //LoginPage
  static const String appTitle = "チャットアプリ";

  //HomePage
  static const String navigationTitleChats = "会話";
  static const String navigationTitleUsers = "友達";
  static const String navigationTitleMySettings = "マイページ";

  //ChatsPage
  static const String chatsPageTitle = "メッセージ";
  static const String emptyChatsText = "メッセージがありません";
  static const String imageSentText = "画像を送信しました";

  //ChatPage
  static const String encourageGreetingsText = "挨拶しよう";
  static const String regExForMessage = r"^(?!\s*$).+";
  static const String inputHintText = "入力";

  //UsersPage
  static const String usersPageTitle = "ユーザー";
  static const String searchInputHintText = "ユーザーを探す";
  static const String lastActiveText = "最終ログイン: ";
  static const String noFoundUsersText = "そんな人はいません";
  static const String talkWithText = "と話す";
  static const String createGroup = "グループを作成する";
  static const String updateButton = "更新する";

  //MySettingsPage
  static const String mySettingsPageTitle = "マイページ";
  static const String regExForName = r".{8,}";
  static const String nameInputHintText = "名前を入力しよう";
  static const String regExForEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String emailInputHintText = "メアドを入力しよう";
  static const String regExForPassword = r".{8,}";
  static const String passwordInputHintText = "更新のためにパスワードを入力してください";

  //common
  static const String isEmptyText = "";
}
