part of 'reports_widgets_imports.dart';

class SaveAndShareButtons extends StatelessWidget {
  const SaveAndShareButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.watch<AppThemeCubit>().isDarkMode
          ? AppDarkColors.backgroundColor
          : MyColors.white,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Row(
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  CustomToast.showSimpleToast(msg: 'قيد التطوير حاليا');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45.h),
                  backgroundColor: context.watch<AppThemeCubit>().isDarkMode
                      ? AppDarkColors.primary
                      : MyColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  tr(context, 'save'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox.square(dimension: 10.r),
            ElevatedButton(
              onPressed: () {
                CustomToast.showSimpleToast(msg: 'قيد التطوير حاليا');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(45.w, 45.h),
                backgroundColor: context.watch<AppThemeCubit>().isDarkMode
                    ? AppDarkColors.primary
                    : MyColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Icon(
                Icons.share_outlined,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
