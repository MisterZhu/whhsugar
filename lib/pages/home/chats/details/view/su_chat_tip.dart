import 'dart:ui';
import '../../../../../su_export_comment.dart';

class SUChattedTip extends StatelessWidget {
  final String? model;

  const SUChattedTip(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: Container(
            alignment: Alignment.center,
            color: SUColorSingleton().tipBgColor.withOpacity(0.4),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 3.0.w),
              child: Text(
                model!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: SUColorSingleton().textColor,
                    fontSize: SUColorSingleton().textSecFont12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
