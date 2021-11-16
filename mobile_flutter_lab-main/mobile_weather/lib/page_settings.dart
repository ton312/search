import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Единицы измерения',
              style: NeumorphicTheme.currentTheme(context).textTheme.subtitle1!,
            ),
            const SizedBox(height: 20),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              ),
              child: Column(
                children: [
                  _Toggle(
                    title: 'Температура',
                    a: '°C',
                    b: '°F',
                    selectedIndex: 1,
                    onChanged: (index) {},
                  ),
                  const Divider(),
                  _Toggle(
                    title: 'Сила ветра',
                    a: 'м/c',
                    b: 'км/ч',
                    selectedIndex:
                    1,
                    onChanged: (index) {
                    },
                  ),
                  const Divider(),
                  _Toggle(
                    title: 'Давление',
                    a: 'мм.рт.ст.',
                    b: 'гПа',
                    selectedIndex:
                    1,
                    onChanged: (index) {

                    },
                  ),
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
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
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
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
