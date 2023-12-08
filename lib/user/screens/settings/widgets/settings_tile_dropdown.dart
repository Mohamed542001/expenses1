part of 'settings_widgets_imports.dart';

class TileDropdownButton extends StatelessWidget {
  const TileDropdownButton({
    Key? key,
    required this.menuList,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final List menuList;
  final Object value;
  final Function(Object? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      value: value,
      iconSize: 0.0,
      menuMaxHeight: 0.3.sh,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: MyColors.primary,
          size: 22.sp,
        ),
      ),
      items: menuList.map<DropdownMenuItem<String>>(
        (value) {
          return DropdownMenuItem(
            value: value,
            alignment: AlignmentDirectional.center,
            child: MyText(
              title: value.toString(),
              color: MyColors.primary,
              size: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
    );
  }
}
