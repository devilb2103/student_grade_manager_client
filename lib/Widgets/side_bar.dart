import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
                color: Colors.transparent,
                height: 60,
                width: 60,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.white,
                    ))),
          ],
        ));
  }
}
