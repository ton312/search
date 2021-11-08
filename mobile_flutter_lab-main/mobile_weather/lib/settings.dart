import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: must_be_immutable
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
              child: Column(children: [
                _Toggle(
                    title: "Температура",
                    a: "°C",
                    b: "°F",
                    selectedIndex: _Toggle.v1 ? 0 : 1,
                    onChanged: (index) {
                      _Toggle.v1 = !_Toggle.v1;
                    }),
                const Divider(),
                _Toggle(
                    title: "Сила ветра",
                    a: "м/c",
                    b: "км/ч",
                    selectedIndex: _Toggle.v2 ? 0 : 1,
                    onChanged: (index) {
                      _Toggle.v2 = !_Toggle.v2;
                    }),
                const Divider(),
                _Toggle(
                    title: "Давление",
                    a: "мм.рт.ст.",
                    b: "гПа",
                    selectedIndex: _Toggle.v3 ? 0 : 1,
                    onChanged: (index) {
                      _Toggle.v3 = !_Toggle.v3;
                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _Toggle extends StatefulWidget {
  static bool v1 = true;
  static bool v2 = true;
  static bool v3 = true;

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
  State<_Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<_Toggle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      trailing: NeumorphicToggle(
        height: 25,
        width: 130,
        selectedIndex: widget.selectedIndex,
        thumb: Neumorphic(),
        onChanged: (Index) {
          setState(() {
            widget.onChanged;
          });
        },
        children: [
          ToggleElement(
            background: Center(child: Text(widget.a)),
            foreground: Neumorphic(
              style: NeumorphicStyle(
                color: NeumorphicTheme.accentColor(context),
              ),
              child: Center(
                child: Text(
                  widget.a,
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
                ),
              ),
            ),
          ),
          ToggleElement(
            background: Center(child: Text(widget.b)),
            foreground: Neumorphic(
              style: NeumorphicStyle(
                color: NeumorphicTheme.accentColor(context),
              ),
              child: Center(
                child: Text(
                  widget.b,
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
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);
//   static bool v1 = true;
//   static bool v2 = true;
//   static bool v3 = true;
//   @override
//   _SettingsState createState() => _SettingsState();
// }

// class _SettingsState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NeumorphicAppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.pushNamed(context, "/"),
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               size: 20,
//             ),
//           ),
//           title: const Text('Настройки')),
//       body: Padding(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 3 / 100),
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start, //выравниваем по горизонтали
//           children: [
//             Text(
//               'Единицы измерения',
//               style: NeumorphicTheme.currentTheme(context).textTheme.subtitle1,
//             ),
//             const SizedBox(height: 20),
//             Neumorphic(
//               style: NeumorphicStyle(
//                 boxShape:
//                     NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
//               ),
//               child: Column(children: [
//                 toggle(
//                     context, "Температура", "°C", "°F", SettingsPage.v1 ? 0 : 1,
//                     (index) {
//                   SettingsPage.v1 = !SettingsPage.v1;
//                 }),
//                 const Divider(),
//                 toggle(context, "Сила ветра", "м/c", "км/ч",
//                     SettingsPage.v2 ? 0 : 1, (index) {
//                   SettingsPage.v2 = !SettingsPage.v2;
//                 }),
//                 const Divider(),
//                 toggle(context, "Давление", "мм.рт.ст.", "гПа",
//                     SettingsPage.v3 ? 0 : 1, (index) {
//                   SettingsPage.v3 = !SettingsPage.v3;
//                 }),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ListTile toggle(BuildContext context, String title, a, b, int selectedIndex,
//       Function(int) onChanged) {
//     return ListTile(
//       title: Text(title),
//       trailing: NeumorphicToggle(
//         height: 25,
//         width: 130,
//         selectedIndex: selectedIndex,
//         thumb: Neumorphic(),
//         onChanged: (Index) {
//           SettingsPage.v1 = !SettingsPage.v1;
//         },
//         children: [
//           ToggleElement(
//             background: Center(child: Text(a)),
//             foreground: Neumorphic(
//               style: NeumorphicStyle(
//                 color: NeumorphicTheme.accentColor(context),
//               ),
//               child: Center(
//                 child: Text(
//                   a,
//                   style:
//                       NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
//                 ),
//               ),
//             ),
//           ),
//           ToggleElement(
//             background: Center(child: Text(b)),
//             foreground: Neumorphic(
//               style: NeumorphicStyle(
//                 color: NeumorphicTheme.accentColor(context),
//               ),
//               child: Center(
//                 child: Text(
//                   b,
//                   style:
//                       NeumorphicTheme.currentTheme(context).textTheme.subtitle2,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
