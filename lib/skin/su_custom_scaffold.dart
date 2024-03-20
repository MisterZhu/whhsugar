import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar/routes/su_router_helper.dart';
import 'package:sugar/skin/su_custom_scaffold_logic.dart';
import 'package:sugar/su_export_comment.dart';

import '../utils/colors/sc_colors.dart';

class SUCustomScaffold extends StatelessWidget {
  /*body*/
  late Widget body;

  /*是否隐藏返回按钮*/
  late bool showBackIcon;

  /*导航栏是否透明*/
  late bool isTransparent;

  /*标题*/
  late String title;

  /*标题是否居中*/
  late bool centerTitle;

  late double? elevation;

  /*是否显示背景图片*/
  late bool showBackgroundImage;

  /*背景图片url*/
  late String backgroundImageUrl;

  /*自定义title-widget*/
  Widget? customTitleWidget;

  /*NavBackgroundColor*/
  Color? navBackgroundColor;

  /*title-style*/
  TextStyle? textStyle;

  /*leading*/
  Widget? leading;

  /*leading宽度 默认56*/
  double? leadingWidth;

  /*导航栏右侧*/
  List<Widget>? actions;

  /*页面是否随着键盘上移*/
  bool? resizeToAvoidBottomInset;
/*leading*/
  Widget? drawer;
  GlobalKey? keyValue;

  SUCustomScaffold(
      {Key? key,
      required this.body,
      this.drawer,
      this.showBackIcon = true,
      this.isTransparent = false,
      this.title = '',
      this.centerTitle = true,
      this.showBackgroundImage = false,
      this.backgroundImageUrl = '',
      this.navBackgroundColor,
      this.textStyle,
      this.leading,
      this.elevation = 0,
      this.leadingWidth,
      this.actions,
      this.customTitleWidget,
      this.keyValue,
      this.resizeToAvoidBottomInset})
      : super(key: key);

  final SUCustomScaffoldLogic logicLaunch = Get.put(SUCustomScaffoldLogic());
  final state = Get.find<SUCustomScaffoldLogic>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<SUCustomScaffoldLogic>(builder: (state) {
      return Scaffold(
          key: keyValue,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: isTransparent,
          appBar: AppBar(
            title: getTitleWidget(),
            centerTitle: centerTitle,
            iconTheme: IconThemeData(
              color: state.backIconColor,
            ),
            backgroundColor: getNavBackgroundColor(),
            systemOverlayStyle: state.statusBarStyle,
            automaticallyImplyLeading: showBackIcon,
            flexibleSpace: getNavBackgroundImage(),
            elevation: elevation,
            leading: leading ?? _buildCustomLeading(), // 使用自定义的leading部件
            leadingWidth: leadingWidth,
            actions: actions,
          ),
          body: body,
          backgroundColor: SCColors.color_FFFFFF,
          drawer: drawer);
    });
  }

  /*Nav背景图片*/
  Widget getNavBackgroundImage() {
    return showBackgroundImage
        ? (backgroundImageUrl.contains('http')
            ? CachedNetworkImage(
                imageUrl: backgroundImageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              )
            : Image.asset(
                backgroundImageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ))
        : const SizedBox();
  }

  /*Nav背景颜色*/
  Color getNavBackgroundColor() {
    if (showBackgroundImage) {
      return Colors.transparent;
    } else {
      return navBackgroundColor ?? state.primaryColor;
    }
  }

  /*title-widget*/
  Widget getTitleWidget() {
    return customTitleWidget ??
        Text(
          title,
          style: textStyle ?? TextStyle(color: state.titleColor),
        );
  }

  Widget _buildCustomLeading() {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new,
          color: SUColorSingleton().naviDefColor), // 设置自定义的返回箭头图标和颜色
      onPressed: () {
        // 返回按钮点击事件
        SURouterHelper.back(null);
      },
    );
  }
}
