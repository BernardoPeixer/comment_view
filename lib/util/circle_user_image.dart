import 'package:fluent_ui/fluent_ui.dart';

class CircleUserImage extends StatelessWidget {
  const CircleUserImage({
    super.key,
    this.image,
    this.icon,
    this.backgroundColor,
  });

  final String? image;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Container(
        color: backgroundColor ?? Colors.blue,
        child: image != null
            ? Image.network(image!)
            : Icon(icon ?? FluentIcons.contact),
      ),
    );
  }
}
