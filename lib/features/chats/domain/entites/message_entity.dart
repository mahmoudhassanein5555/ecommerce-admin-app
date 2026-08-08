import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  final String text;
  final Timestamp timestamp;
  final String senderName;
  final String senderId;
  final bool isAdminSender;
  final bool isProductAttachment;
  final AttachedMetaDataEntity? attachedMetaData;

  MessageEntity({
    required this.senderName,
    required this.senderId,
    required this.text,
    this.attachedMetaData = const AttachedMetaDataEntity(
      productTitle: "",
      productPrice: 0,
      productImageUrl: "",
      attachedId: "",
    ),
    required this.timestamp,
    required this.isProductAttachment,
    required this.isAdminSender,
  });
}

class AttachedMetaDataEntity {
  final String productTitle;
  final int productPrice;
  final String productImageUrl;
  final String attachedId;

  const AttachedMetaDataEntity({
    required this.productTitle,
    required this.productPrice,
    required this.productImageUrl,
    required this.attachedId,
  });
}
