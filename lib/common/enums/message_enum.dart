enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  final String type;

  const MessageEnum(this.type);
}
// using when receive data from firebase
extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'text':
        return MessageEnum.text;
      case 'image':
        return MessageEnum.image;
      case 'audio':
        return MessageEnum.audio;
      case 'video':
        return MessageEnum.video;
      case 'gif':
        return MessageEnum.gif;
      default:
        return MessageEnum.text;
    }
  }
}
