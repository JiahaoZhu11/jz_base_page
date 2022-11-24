part of 'jz_base_page.dart';

class JZLoadingToast extends StatelessWidget {
  final double padding;

  final double margin;

  final double spacing;

  final double diameter;

  final double strokeWidth;

  final String? message;

  const JZLoadingToast({
    Key? key,
    required this.padding,
    required this.margin,
    required this.spacing,
    required this.diameter,
    required this.strokeWidth,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        // Content
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Message
            if (message != null)
              Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: Text(
                  message!.replaceAll("\n", " ").cancelAutoLines(),
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            // Loading indicator
            Container(
              alignment: Alignment.center,
              width: diameter,
              height: diameter,
              child: SizedBox(
                width: diameter - strokeWidth,
                height: diameter - strokeWidth,
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
