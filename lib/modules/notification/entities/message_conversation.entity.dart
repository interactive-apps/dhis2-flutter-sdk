import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'message.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'messageconversation', apiResourceName: 'messageConversations')
class MessageConversation extends IdentifiableEntity {
  @Column(type: ColumnType.TEXT)
  String status;

  @Column(type: ColumnType.TEXT)
  String subject;

  @Column(type: ColumnType.TEXT)
  String messageType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? lastMessage;

  @Column(type: ColumnType.BOOLEAN)
  bool read;

  @OneToMany(table: Message)
  List<Message>? messages;

  MessageConversation(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required this.subject,
      required this.status,
      required this.messageType,
      required this.read,
      String? displayName,
      this.messages,
      this.lastMessage,
      required bool dirty})
      : super(
            id: id,
            name: name,
            displayName: displayName,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory MessageConversation.fromJson(Map<String, dynamic> json) {
    return MessageConversation(
        id: json['id'],
        name: json['name'],
        subject: json['subject'],
        created: json['created'],
        displayName: json['displayName'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        status: json['status'],
        messageType: json['messageType'],
        read: json['read'],
        lastMessage: json['lastMessage'],
        messages: (json['messages'] ?? [])
            .map<Message>((message) => Message.fromJson({
                  ...message,
                  'dirty': false,
                  'messageConversation': json['id']
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['subject'] = this.subject;
    data['displayName'] = this.displayName;
    data['status'] = this.status;
    data['messageType'] = this.messageType;
    data['read'] = this.read;
    data['lastMessage'] = this.lastMessage;
    data['dirty'] = this.dirty;

    return data;
  }
}
