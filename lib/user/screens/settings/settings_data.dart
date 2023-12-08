part of 'settings_imports.dart';

class SettingsData {
  String selectedLanguage = 'عربي';

  List<String> languages = ['عربي', 'انجليزي'];

  List<String> monthDays =
      List.generate(30, (index) => (1 + index++).toString());

  List<String> weekDays = [
    'السبت',
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  List<String> countries = ['مصر', 'السعودية'];

  List<String> currency = [
    'الجنيه المصري',
    'الريال السعودي',
    'الدولار الأمريكي'
  ];

  List<String> numberFormat = ['عربي', 'انجليزي'];

  List<String> decimal = ['رقم', 'رقمين'];

  List<String> saveFormat = ['PDF', 'DOCX'];

  List<String> syncOptions = ['Google Drive', 'Firebase'];
}
