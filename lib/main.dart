import 'package:comment_view/view/feed_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return const FluentApp(
      debugShowCheckedModeBanner: false,
      home: FeedView(),
    );
  }
}