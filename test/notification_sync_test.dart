import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/notification/entities/message_conversation.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/message_conversation.sample.dart';
import 'notification_sync_test.reflectable.dart';
import '../sample/database_sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: randomStrings(),
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/messageConversations.json?fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,status,subject,messageType,lastMessage,read,messages[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,sender,text,messageConversation]&paging=false',
    (server) => server.reply(200, sampleMessageConversations),
  );

  await d2.notificationModule.messageConversation.download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<MessageConversation> messageConversations =
      await d2.notificationModule.messageConversation.get();

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/messageConversations.json?filter=read:eq:false&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,status,subject,messageType,lastMessage,read,messages[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,sender,text,messageConversation]&paging=false',
    (server) => server.reply(200, sampleMessageConversations),
  );

  final onlineNotifications = await d2.notificationModule.messageConversation
      .where(attribute: 'read', value: false)
      .get(online: true, dioTestClient: dio);

  test('should store all incoming  notification', () {
    expect(messageConversations.length, 50);
    expect(onlineNotifications.length, 50);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/messageConversations.json?filter=subject:ilike:Scheduler&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,status,subject,messageType,lastMessage,read,messages[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,sender,text,messageConversation]&paging=false',
    (server) => server.reply(200, sampleFilteredMessageConversations),
  );

  await d2.notificationModule.messageConversation
      .ilike(attribute: 'subject', value: 'Scheduler')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  MessageConversation filteredMessageConversation = await d2
      .notificationModule.messageConversation
      .byId('u9gjt9pG88l')
      .getOne();

  test('should store all filtered  notification', () {
    expect(filteredMessageConversation?.id, 'u9gjt9pG88l');
  });

  await d2.dispose();
}
