import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, "/"),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: const Text('Настройки')),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, //выравниваем по горизонтали
          children: [
            Text(
              'Единицы измерения',
              style: NeumorphicTheme.currentTheme(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 20),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              ),
              child: Column(
                children: [
                  NeumorphicToggle(thumb:const null,
                  children: [],
                    
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _Toggle extends StatelessWidget {
  final String title;
  final String a;
  final String b;
  final int selectedIndex;
  final Function(int) onChanged;

  const _Toggle({
    // @required this.name,
    required this.title,
    required this.a,
    required this.b,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: NeumorphicToggle(
        height: 25,
        width: 130,
        selectedIndex: selectedIndex,
        thumb: Neumorphic(),
        onChanged: onChanged,
        children: [
          ToggleElement(
              background: Center(child: Text(a)),
              foreground: Neumorphic(
                style: NeumorphicStyle(
                  color: NeumorphicTheme.accentColor(context),
                ),
                child: Center(
                  child: Text(
                    a,
                    style: NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
                  ),
                ),
              ),
          ),
          ToggleElement(
            background: Center(child: Text(b)),
            foreground: Neumorphic(
              style: NeumorphicStyle(
                color: NeumorphicTheme.accentColor(context),
              ),
              child: Center(
                child: Text(
                  b,
                  style: NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}