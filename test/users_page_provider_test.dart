//Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

//Providers
import 'package:chat_app_custom/providers/users_page_provider.dart';
import 'package:chat_app_custom/providers/authentication_provider.dart';

//Models
import 'package:chat_app_custom/models/chat_user.dart';

//Services
import 'package:chat_app_custom/services/database_service.dart';
import 'package:chat_app_custom/services/navigation_service.dart';

class MockAuthenticationProvider extends Mock
    implements AuthenticationProvider {}

void main() {
  late UsersPageProvider sut;
  late MockAuthenticationProvider mockAuthenticationProvider;

  setUp(() async {
    // await GetIt.I.reset();
    setupFirebaseAuthMocks();
    await Firebase.initializeApp();

    if (!GetIt.I.isRegistered<DatabaseService>()) {
      GetIt.instance.registerSingleton<DatabaseService>(
        DatabaseService(),
      );
    }
    if (!GetIt.I.isRegistered<NavigationService>()) {
      GetIt.instance.registerSingleton<NavigationService>(
        NavigationService(),
      );
    }
    mockAuthenticationProvider = MockAuthenticationProvider();
    sut = UsersPageProvider(mockAuthenticationProvider);
  });

  //Todo: asynchronous gap修正
  test(
    "初期値の生成のテスト",
    () {
      // await GetIt.I.reset();
      expect(sut.users, null);
    },
  );

  group('createChat', () {
    void arrangeChatUser() {
      when(() => mockAuthenticationProvider.user).thenAnswer(
        (_) => ChatUser(
          uid: "",
          name: "",
          email: "",
          imageURL: "",
          lastActive: DateTime.now(),
        ),
      );
    }

    test("create chat", () {
      arrangeChatUser();
      expect(mockAuthenticationProvider.user.runtimeType, ChatUser);
      sut.createChat();
      verify(() => mockAuthenticationProvider.user.uid).called(2);
    });
  });
}

typedef Callback = void Function(MethodCall call);
void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}
