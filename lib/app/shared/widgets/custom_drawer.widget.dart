import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_drawer.tile.dart';

class CustomDrawerWidget extends StatefulWidget {
  @override
  _CustomDrawerWidgetState createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  Offset _offset = Offset(0, 0);
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];

  bool isMenuOpen = false;

  @override
  void initState() {
    limits = [0, 0, 0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback(getPosition);
    super.initState();
  }

  getPosition(duration) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double contLimit = position.dy + renderBox.size.height - 20;
    double step = (contLimit - start) / 5;
    limits = [];
    for (double x = start; x <= contLimit; x = x + step) {
      limits.add(x);
    }
    setState(() {
      limits = limits;
    });
  }

  double getSize(int x) {
    double size =
        (_offset.dy > limits[x] && _offset.dy < limits[x + 1]) ? 25 : 20;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    double sidebarSize = mediaQuery.width * 0.65;
    double menuContainerHeight = mediaQuery.height / 2;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 1500),
      left: isMenuOpen ? 0 : -sidebarSize + 20,
      top: 0,
      curve: Curves.elasticOut,
      child: SizedBox(
        width: sidebarSize,
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.localPosition.dx <= sidebarSize) {
              setState(() {
                _offset = details.localPosition;
              });
            }

            if (details.localPosition.dx > sidebarSize - 20 &&
                details.delta.distanceSquared > 2) {
              setState(() {
                isMenuOpen = true;
              });
            }
          },
          onPanEnd: (details) {
            setState(() {
              _offset = Offset(0, 0);
            });
          },
          child: Stack(
            children: <Widget>[
              CustomPaint(
                size: Size(sidebarSize, mediaQuery.height),
                painter: DrawerPainter(offset: _offset),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        "assets/profile_pic.jpeg",
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Erick Anjos de Lima",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        "erick.adlima@gmail.com",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      key: globalKey,
                      width: double.infinity,
                      height: menuContainerHeight,
                      child: Column(
                        children: <Widget>[
                          CustomDrawerTile(
                            text: "Profile",
                            iconData: Icons.person,
                            textSize: getSize(0),
                          ),
                          CustomDrawerTile(
                            text: "Carrer",
                            iconData: Icons.work,
                            textSize: getSize(1),
                          ),
                          CustomDrawerTile(
                            text: "Graduation",
                            iconData: Icons.computer,
                            textSize: getSize(2),
                          ),
                          CustomDrawerTile(
                            text: "Works",
                            iconData: Icons.settings,
                            textSize: getSize(3),
                          ),
                          CustomDrawerTile(
                            text: "My Resume",
                            iconData: Icons.attach_file,
                            textSize: getSize(4),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                right: (isMenuOpen) ? 10 : sidebarSize,
                bottom: 30,
                child: IconButton(
                  enableFeedback: true,
                  icon: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black45,
                    size: 30,
                  ),
                  onPressed: () {
                    this.setState(() {
                      isMenuOpen = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerPainter extends CustomPainter {
  final Offset offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else {
      return offset.dx > width ? offset.dx : width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
