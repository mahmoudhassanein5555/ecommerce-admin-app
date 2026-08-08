import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';

class MessageDto extends MessageEntity {
  MessageDto({
    required super.senderName,
    required super.senderId,
    required super.text,
    super.attachedMetaData,
    required super.timestamp,
    required super.isAdminSender,
    required super.isProductAttachment,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      senderName: json['senderName']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      attachedMetaData:
          json['attachedMetaData'] != null &&
              json['attachedMetaData'] is Map<String, dynamic>
          ? AttachedMetaDataDto.fromJson(
              json['attachedMetaData'] as Map<String, dynamic>,
            )
          : null,
      timestamp: json['timestamp'] is Timestamp
          ? json['timestamp'] as Timestamp
          : (json['timestamp'] is DateTime
                ? Timestamp.fromDate(json['timestamp'] as DateTime)
                : Timestamp.now()),
      isAdminSender: json['isAdminSender'] as bool? ?? false,
      isProductAttachment: json['isProductAttachment'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'senderId': senderId,
      'text': text,
      if (attachedMetaData != null)
        'attachedMetaData': AttachedMetaDataDto.fromEntity(
          attachedMetaData!,
        ).toJson(),
      'timestamp': timestamp,
      'isAdminSender': isAdminSender,
      'isProductAttachment': isProductAttachment,
    };
  }

  factory MessageDto.fromEntity(MessageEntity entity) {
    return MessageDto(
      senderName: entity.senderName,
      senderId: entity.senderId,
      text: entity.text,
      attachedMetaData: entity.attachedMetaData != null
          ? AttachedMetaDataDto.fromEntity(entity.attachedMetaData!)
          : null,
      timestamp: entity.timestamp,
      isAdminSender: entity.isAdminSender,
      isProductAttachment: entity.isProductAttachment,
    );
  }
}

class AttachedMetaDataDto extends AttachedMetaDataEntity {
  AttachedMetaDataDto({
    required super.productTitle,
    required super.productPrice,
    required super.productImageUrl,
    required super.attachedId,
  });

  factory AttachedMetaDataDto.fromJson(Map<String, dynamic> json) {
    return AttachedMetaDataDto(
      productTitle: json['productTitle']?.toString() ?? '',
      productPrice: (json['productPrice'] as num?)?.toInt() ?? 0,
      productImageUrl: json['productImageUrl']?.toString() ?? '',
      attachedId: json['attachedId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productImageUrl': productImageUrl,
      'attachedId': attachedId,
    };
  }

  factory AttachedMetaDataDto.fromEntity(AttachedMetaDataEntity entity) {
    return AttachedMetaDataDto(
      productTitle: entity.productTitle,
      productPrice: entity.productPrice,
      productImageUrl: entity.productImageUrl,
      attachedId: entity.attachedId,
    );
  }
}
