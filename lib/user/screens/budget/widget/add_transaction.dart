import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/widgets/DefaultButton.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_cubit.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_state.dart';
import 'package:expenses/user/screens/reports/statistics/statistics_imports.dart';
import 'package:expenses/user/screens/settings/widgets/settings_widgets_imports.dart';
import 'package:expenses/user/screens/wallet/wallet_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:googleapis/shared.dart';

class AddTransactionBudget extends StatefulWidget {
  const AddTransactionBudget({super.key});

  @override
  State<AddTransactionBudget> createState() => _AddTransactionBudgetState();
}

class _AddTransactionBudgetState extends State<AddTransactionBudget> {
  bool repeatSwitchValue = false;
  bool notificationSwitchvalu = false;
  DateTimeRange selectRangeDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  TextEditingController rangeDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WalletData data = WalletData();

    return BlocProvider(
        create: (context) => BudgetCubit()..getBudgetData(context),
        child: BlocBuilder<BudgetCubit, BudgetState>(
            buildWhen: (previos, current) {
          return (previos is AddBudgetLoading || current is AddBudgetLoading) ||
              (previos is AddBudgetSuccess || current is AddBudgetSuccess);
        }, builder: (context, state) {
          if (state is AddBudgetLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AddBudgetSuccess) {
            return const StatisticsBody(option: "option");
          }
          return Column(
            children: [
              Container(
                height: 105.h,
                width: double.infinity,
                color: MyColors.primary,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: MyColors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "رجاء ادخال اسم المحفظة";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.right,
                      cursorColor: MyColors.primary,
                      decoration: InputDecoration(
                          hoverColor: MyColors.primary,
                          fillColor: MyColors.primary,
                          hintText: " enter value",
                          hintStyle:
                              TextStyle(fontSize: 18.sp, color: MyColors.grey),
                          focusColor: MyColors.primary),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "اختيار محفظة",
                            color: MyColors.black,
                            size: 14.sp),
                        SizedBox(
                          width: 150.w,
                          child: BlocBuilder<BudgetCubit, BudgetState>(
                            builder: (context, state) {
                              List<String> walletNames = context
                                  .read<BudgetCubit>()
                                  .wallets
                                  .map((wallet) => wallet.name)
                                  .toList();

                              return TileDropdownButton(
                                menuList: walletNames,
                                onChanged: (value) => {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "اختيار المعاملة",
                            color: MyColors.black,
                            size: 14.sp),
                        SizedBox(
                          width: 150.w,
                          child: BlocBuilder<BudgetCubit, BudgetState>(
                            builder: (context, state) {
                              List<String> transactionName = context
                                  .read<BudgetCubit>()
                                  .transactioList
                                  .map((transaction) =>
                                      transaction.transactionName!)
                                  .toList();
                              return TileDropdownButton(
                                menuList: transactionName,
                                onChanged: (value) => {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "اختيار المدة",
                            color: MyColors.black,
                            size: 14.sp),
                        IconButton(
                            onPressed: () {
                              dateRange();
                            },
                            icon: Icon(Icons.calendar_month_outlined))
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "تكرار المحفظة",
                            color: MyColors.black,
                            size: 14.sp),
                        Visibility(
                          visible: repeatSwitchValue,
                          child: SizedBox(
                            width: 150.w,
                            child: TileDropdownButton(
                                menuList: [], value: "", onChanged: (value) {}),
                          ),
                        ),
                        CupertinoSwitch(
                          value: repeatSwitchValue,
                          onChanged: (value) {
                            setState(() {
                              repeatSwitchValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "تنبيه انتهاء المعالمة",
                            color: MyColors.black,
                            size: 14.sp),
                        Visibility(
                          visible: notificationSwitchvalu,
                          child: SizedBox(
                            width: 150.w,
                            child: Container(),
                          ),
                        ),
                        CupertinoSwitch(
                          value: notificationSwitchvalu,
                          onChanged: (value) {
                            setState(() {
                              notificationSwitchvalu = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    DefaultButton(
                      fontSize: 14.sp,
                      borderColor: MyColors.primary,
                      title: "إضافة محفظة",
                      color: MyColors.primary,
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }

  void dateRange() async {
    DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: context.read<BudgetCubit>().startDate,
      lastDate: context.read<BudgetCubit>().endDate,
    );

    if (dateRange != null) {
      setState(() {
        selectRangeDate = dateRange;
        rangeDateController.text =
            "${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year} - ${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}";
      });
    }
  }
}
