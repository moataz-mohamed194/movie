import 'package:flutter/material.dart';
import 'package:movie/view/model/navigation_model.dart';
import 'package:movie/view/model/theme.dart';
import '../Widgets/LogInListTile.dart';
import '../Widgets/collapsing_list_tile_widget.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth =60;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
        elevation: 30.0,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: drawerBackgroundColor,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                        isCollapsed
                            ? _animationController.forward()
                            : _animationController.reverse();
                      });
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _animationController,
                      color: selectedColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  titles[currentSelectedIndex]
                ],
              ),
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: widthAnimation.value,
                  color: drawerBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      LogInListTile(
                        
                        animationController: _animationController,
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 40.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, counter) {
                            return Divider(height: 12.0);
                          },
                          itemBuilder: (context, counter) {
                            return CollapsingListTile(
                              onTap: () {
                                setState(() {
                                  currentSelectedIndex = counter;
                                });
                              },
                              isSelected: currentSelectedIndex == counter,
                              title: navigationItems[counter].title,
                              icon: navigationItems[counter].icon,
                              animationController: _animationController,
                            );
                          },
                          itemCount: navigationItems.length,
                        ),
                      ),
                    ],
                  ),
                ),
                data[currentSelectedIndex]
              ],
            )));
  }
}
