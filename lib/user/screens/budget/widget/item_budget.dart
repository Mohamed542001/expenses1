import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/blocks/lang_cubit/lang_cubit.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/packages/localization/Localizations.dart';
import 'package:expenses/general/themes/app_colors.dart';
import 'package:expenses/general/themes/cubit/app_theme_cubit.dart';
import 'package:expenses/general/utilities/routers/RouterImports.gr.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/res.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_cubit.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_state.dart';
import 'package:expenses/user/screens/budget/data/model/budget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ItemBudget extends StatelessWidget {
  final BudgetModel model;
  const ItemBudget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetCubit, BudgetState>(
      builder: (context, state) {
        double total = 0;
        double percentageValue = 0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.r),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Image.asset(Res.extra),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      tr(
                        context,
                        model.transactionName,
                      ),
                      style: TextStyle(
                          color: context.watch<AppThemeCubit>().isDarkMode
                              ? MyColors.white
                              : AppDarkColors.backgroundColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    LinearPercentIndicator(
                      isRTL:
                          context.read<LangCubit>().state.locale.languageCode ==
                                  "ar"
                              ? true
                              : false,
                      alignment: MainAxisAlignment.end,
                      width: 350.w,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: (model.budgetValue - model.transactionValue!) /
                          model.budgetValue,
                      progressColor: model.percentValue! < 0.2
                          ? Colors.red
                          : MyColors.primary,
                    ),
                    IconButton(
                        onPressed: () async {
                          await AutoRouter.of(context)
                              .push(EditBudgetRoute(model: model));
                          if (context.mounted) {
                            context.read<BudgetCubit>().fetchData();
                          }
                        },
                        icon: Image.asset(Res.edit)),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyText(
                          title: tr(context, model.transactionName),
                          color: MyColors.black,
                          size: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          "${model.transactionValue}",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    MyText(
                        title: tr(context, "from"),
                        color: context.watch<AppThemeCubit>().isDarkMode
                            ? MyColors.white
                            : MyColors.black,
                        size: 14.sp),
                    Row(
                      children: [
                        Text(
                          "${model.budgetValue}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        MyText(
                          title: tr(context, "transaction"),
                          color: context.watch<AppThemeCubit>().isDarkMode
                              ? MyColors.white
                              : MyColors.black,
                          size: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        IconButton(
                            onPressed: () {
                              model.delete();
                              BlocProvider.of<BudgetCubit>(context).fetchData();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: MyColors.primary,
                            )),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyText(
                          title: tr(context, "startDate"),
                          color: context.watch<AppThemeCubit>().isDarkMode
                              ? MyColors.white
                              : MyColors.black,
                          size: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          model.startBudget,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyText(
                          title: tr(context, "endDate"),
                          color: context.watch<AppThemeCubit>().isDarkMode
                              ? MyColors.white
                              : MyColors.black,
                          size: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          model.endBudget,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Divider(
                  color: MyColors.grey,
                )
              ]),
        );
      },
    );
  }
}
