import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/utilities/routers/RouterImports.gr.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/user/screens/budget/widget/custom_icon.dart';
import 'package:expenses/user/screens/budget/widget/item_budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Budget extends StatelessWidget {
  const Budget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
          color: MyColors.white,
        ),
        centerTitle: true,
        title: MyText(
          title: "الميزانية والخطط المالية",
          color: MyColors.white,
          size: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(children: [
        Container(
          height: 500.h,
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (context, index) => const ItemBudget(
                precent: 0.4,
                title: "title",
                value: "value",
                secValue: "secValue"),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: MyColors.black,
              );
            },
          ),
        ),
        CustomIcon(
          onPressed: () {
            AutoRouter.of(context).push(AddTransactionBudgetRoute());
          },
        ),
      ]),
    );
  }
}
