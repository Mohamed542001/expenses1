part of 'main_imports.dart';

class MainData{

  GenericBloc<int?> touchCubit = GenericBloc(-1);

  int? touchedIndex;


  List<PieChartSectionData> getSections()=> data.asMap().map<int,PieChartSectionData>((i,data){
    final value= PieChartSectionData(
      color: data.color,
      value: data.percent,
      title: data.name,
      radius: 100.r,

      titlePositionPercentageOffset: 0.6,
      titleStyle: TextStyle(
        color: MyColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13.sp,
      )
    );

    return MapEntry(i, value);
  }).values.toList();

  List<PieChartDataModel> data = [
    PieChartDataModel(
      name: "المحافظ \nوالمصادر",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "الميزانية \nوالخطط المالية",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "السجل \nوقواعد البيانات",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "الضبط \nوالاعدادات",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "التقارير \nوالاحصائيات",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "المعاملات \nوالمصروفات",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "المساعدة \nوالشرح",
      percent: 45,
      color: MyColors.primary,
    ),
    PieChartDataModel(
      name: "الأدوات \nالمساعدة",
      percent: 45,
      color: MyColors.primary,
    ),
  ];


  List<Widget> widgets=[
    const Wallet(),
    const Budget(),
     Database(),
    const Settings(),
    const Reports(),
    const Transactions(),
    Container(),
    Container(),
  ];

}