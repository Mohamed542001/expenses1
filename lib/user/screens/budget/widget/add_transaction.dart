import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/packages/input_fields/GenericTextField.dart';
import 'package:expenses/general/widgets/DefaultButton.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/res.dart';
import 'package:expenses/user/screens/budget/budget_imports.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_cubit.dart';
import 'package:expenses/user/screens/budget/data/cubit/budget_state.dart';
import 'package:expenses/user/screens/budget/data/model/budget_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransactionBudget extends StatefulWidget {
  const AddTransactionBudget({super.key});

  @override
  State<AddTransactionBudget> createState() => _AddTransactionBudgetState();
}

class _AddTransactionBudgetState extends State<AddTransactionBudget> {
  bool favorite = false;
  bool notificationSwitchvalu = false;

  var formKey = GlobalKey<FormState>();
  double parsedNumber = 0;
  // BudgetData data = BudgetData();
  String? selectTransactionValue;
  String? selectWalletValue;
  DateTime? selectedDate;
  DateTime? closedDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetCubit()..getBudgetData(context),
      child:
          BlocBuilder<BudgetCubit, BudgetState>(buildWhen: (previos, current) {
        return (previos is AddBudgetLoading || current is AddBudgetLoading) ||
            (current is OpenBudget || current is OpenBudget);
      }, builder: (context, state) {
        if (state is AddBudgetLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OpenBudget) {
          List<String> walletsName = context
              .read<BudgetCubit>()
              .wallets
              .map((wallet) => wallet.name)
              .toList();
          List<String> transactionName = context
              .read<BudgetCubit>()
              .transactioList
              .map((transaction) => transaction.transactionType?.name ?? "")
              .toList();
          print(transactionName);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Image.asset(Res.back),
                onPressed: () => AutoRouter.of(context).pop(),
              ),
              backgroundColor: MyColors.white,
              title: Center(
                child: MyText(
                  title: "إضفة ميزانية",
                  color: MyColors.black,
                  size: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.greyWhite),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: const Text("إختيار المعاملات"),
                        children: [
                          ...transactionName.asMap().entries.map(
                            (entry) {
                              final String item = entry.value;
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0.r),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Radio<String>(
                                          value: item,
                                          groupValue: selectTransactionValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectTransactionValue = value;
                                              context
                                                  .read<BudgetCubit>()
                                                  .transactionNameController
                                                  .text = value.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: MyColors.semiTransparentColor,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.greyWhite),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: const Text("إختيار المحفظة"),
                        children: [
                          ...walletsName.asMap().entries.map(
                            (entry) {
                              final String item = entry.value;
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0.r),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Radio<String>(
                                          value: item,
                                          groupValue: selectWalletValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectWalletValue = value;
                                              context
                                                  .read<BudgetCubit>()
                                                  .walletNameController
                                                  .text = value.toString();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: MyColors.semiTransparentColor,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(Res.calender),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "إختيار المدة",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            openDate(context);
                          },
                          child: Container(
                              height: 44.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: MyColors.semiTransparentColor),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedDate != null
                                            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                            : "من",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: selectedDate != null
                                              ? Colors.black
                                              : Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            closeDate(context);
                          },
                          child: Container(
                              height: 44.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: MyColors.semiTransparentColor),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          closedDate != null
                                              ? "${closedDate?.toLocal()}"
                                                  .split(' ')[0]
                                              : "الي",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: closedDate != null
                                                ? Colors.black
                                                : Colors.grey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GenericTextField(
                      controller:
                          context.read<BudgetCubit>().budgetValueController,
                      hint: "تحديد القيمة",
                      fieldTypes: FieldTypes.normal,
                      type: TextInputType.number,
                      action: TextInputAction.next,
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return "رجاء ادخل القمية";
                        }
                        return null;
                      },
                      onChange: (value) {
                        parsedNumber = double.parse(context
                            .read<BudgetCubit>()
                            .budgetValueController
                            .text);
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                            title: "تكرار المعاملة",
                            color: MyColors.black,
                            size: 16.sp),
                        Checkbox(
                            activeColor: MyColors.primary,
                            value: context.read<BudgetCubit>().checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                context.read<BudgetCubit>().checkedValue =
                                    newValue!;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "إضافة ملاحظة",
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 284.w,
                          child: GenericTextField(
                            controller:
                                context.read<BudgetCubit>().noteController,
                            hint: "ملاحظاتك",
                            maxLength: 9,
                            fieldTypes: FieldTypes.normal,
                            type: TextInputType.number,
                            action: TextInputAction.next,
                            validate: (text) {
                              if (text == null || text.isEmpty) {
                                return "رجاء ادخل ملاحظاتك";
                              }
                              return null;
                            },
                            onChange: (value) {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          height: 58.h,
                          width: 328.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.greyWhite,
                              ),
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Row(
                            children: [
                              Text(
                                "إضافة صورة",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.black,
                                ),
                              ),
                              SizedBox(
                                width: 120.w,
                              ),
                              Image.asset(Res.camera),
                              SizedBox(
                                width: 7.w,
                              ),
                              VerticalDivider(
                                width: 45.h,
                                color: MyColors.grey,
                              ),
                              Image.asset(Res.image),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Container(
                          height: 57.h,
                          width: 57.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.greyWhite,
                              ),
                              borderRadius: BorderRadius.circular(12.r)),
                          child: IconButton(
                              onPressed: () {}, icon: Image.asset(Res.qrcode)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffF7F7F6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyText(
                              title: "تنبيه عند انتهاء 20%",
                              color: MyColors.black,
                              size: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 58.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffF7F7F6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyText(
                              title: "المفضلة",
                              color: MyColors.black,
                              size: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Visibility(
                            visible: favorite,
                            child: SizedBox(
                              width: 150.w,
                              child: Container(),
                            ),
                          ),
                          CupertinoSwitch(
                            value: favorite,
                            onChanged: (value) {
                              setState(() {
                                favorite = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Row(
                      children: [
                        DefaultButton(
                          onTap: () {
                            double transactionValue = context
                                .read<BudgetCubit>()
                                .transactioList
                                .map((value) =>
                                    double.tryParse(value.total ?? '0.0') ??
                                    0.0)
                                .fold(
                                    0.0,
                                    ((previousValue, current) =>
                                        previousValue + current));
                            double deficiency = parsedNumber - transactionValue;
                            double percentageValue = deficiency / parsedNumber;
                            print(percentageValue);
                            var budgetData = BudgetModel(
                                percentValue: percentageValue,
                                budgetValue: parsedNumber,
                                transactionName: context
                                    .read<BudgetCubit>()
                                    .transactionNameController
                                    .text,
                                waletName: context
                                    .read<BudgetCubit>()
                                    .walletNameController
                                    .text,
                                startBudget: context
                                    .read<BudgetCubit>()
                                    .openDateController
                                    .text,
                                endBudget: context
                                    .read<BudgetCubit>()
                                    .closeDateController
                                    .text,
                                addNote: context
                                    .read<BudgetCubit>()
                                    .noteController
                                    .text);

                            context.read<BudgetCubit>().addData(budgetData);
                            AutoRouter.of(context).pop();
                          },
                          height: 57.h,
                          width: 170.w,
                          title: "تطبيق",
                          color: MyColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        DefaultButton(
                          onTap: () {
                            AutoRouter.of(context).pop();
                          },
                          height: 57.h,
                          width: 170.w,
                          borderColor: MyColors.primary,
                          title: "الغاء",
                          textColor: MyColors.primary,
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );

    // BlocProvider(
    //     create: (context) => BudgetCubit()..getBudgetData(context),
    //     child: BlocBuilder<BudgetCubit, BudgetState>(
    //         buildWhen: (previos, current) {
    //       return (previos is AddBudgetLoading || current is AddBudgetLoading) ||
    //           (current is OpenBudget || current is OpenBudget);
    //     }, builder: (context, state) {
    //       if (state is AddBudgetLoading) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (state is OpenBudget) {
    //         return Column(
    //           children: [
    //             Container(
    //               height: 110.h,
    //               width: double.infinity,
    //               color: MyColors.primary,
    //               child: Align(
    //                 alignment: Alignment.bottomRight,
    //                 child: Row(
    //                   children: [
    //                     IconButton(
    //                       onPressed: () => AutoRouter.of(context).pop(),
    //                       icon: const Icon(Icons.arrow_back_ios),
    //                       color: MyColors.white,
    //                     ),
    //                     SizedBox(width: 15.w),
    //                     MyText(
    //                       title: tr(context, 'add'),
    //                       color: Colors.white,
    //                       size: 16.sp,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(16.w),
    //               child: Form(
    //                 key: formKey,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(height: 15.h),
    //                     MyText(
    //                         title: "قيمة الميزانية",
    //                         color: MyColors.black,
    //                         size: 16.sp),
    //                     SizedBox(
    //                       height: 10.h,
    //                     ),
    //                     GenericTextField(
    //                       controller: budgetValue,
    //                       hint: "pleas enter value",
    //                       fieldTypes: FieldTypes.normal,
    //                       type: TextInputType.number,
    //                       action: TextInputAction.next,
    //                       validate: (text) {
    //                         if (text == null || text.isEmpty) {
    //                           return "رجاء إدخال قيمة الميزانية";
    //                         }
    //                         return null;
    //                       },
    //                       onChange: (value) {
    //                         parsedNumber = double.parse(budgetValue.text);
    //                       },
    //                     ),
    //                     SizedBox(
    //                       height: 15.h,
    //                     ),
    //                     MyText(
    //                         title: "اسم الميزانية",
    //                         color: MyColors.black,
    //                         size: 16.sp),
    //                     SizedBox(
    //                       height: 10.h,
    //                     ),
    //                     GenericTextField(
    //                       controller: budgetName,
    //                       hint: "pleas enter value",
    //                       fieldTypes: FieldTypes.normal,
    //                       type: TextInputType.text,
    //                       action: TextInputAction.next,
    //                       validate: (text) {
    //                         if (text == null || text.isEmpty) {
    //                           return "رجاء إدخال قيمة الميزانية";
    //                         }
    //                         return null;
    //                       },
    //                       onChange: (value) {
    //                         parsedNumber = double.parse(budgetName.text);
    //                       },
    //                     ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     MyText(
    //         title: "اختيار محفظة",
    //         color: MyColors.black,
    //         size: 14.sp),
    //     SizedBox(
    //       width: 150.w,
    //       child: BlocBuilder<BudgetCubit, BudgetState>(
    //         builder: (context, state) {
    //           List<String> walletNames = context
    //               .read<BudgetCubit>()
    //               .wallets
    //               .map((wallet) => wallet.name)
    //               .toList();
    //           return TileDropdownButton(
    //             menuList: walletNames,
    //             onChanged: (value) => {
    //               walletNameController.text =
    //                   value as String,
    //             },
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // ),
    // SizedBox(height: 15.h),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     MyText(
    //         title: "اختيار المعاملة",
    //         color: MyColors.black,
    //         size: 14.sp),
    //     SizedBox(
    //       width: 150.w,
    //       child: BlocBuilder<BudgetCubit, BudgetState>(
    //         builder: (context, state) {
    //           List<String> transactionName = context
    //               .read<BudgetCubit>()
    //               .transactioList
    //               .map((transaction) =>
    //                   transaction.transactionName!)
    //               .toList();
    //           return TileDropdownButton(
    //             menuList: transactionName,
    //             onChanged: (value) => {
    //               transactionController.text =
    //                   value as String,
    //             },
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // ),
    //                     SizedBox(height: 15.h),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         MyText(
    //                             title: "اختيار المدة",
    //                             color: MyColors.black,
    //                             size: 14.sp),
    //                         IconButton(
    //                             onPressed: () {
    //                               dateRange();
    //                             },
    //                             icon: const Icon(Icons.calendar_month_outlined))
    //                       ],
    //                     ),
    //                     SizedBox(height: 15.h),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Expanded(
    //                           child: MyText(
    //                               title: "تكرار المحفظة",
    //                               color: MyColors.black,
    //                               size: 14.sp),
    //                         ),
    //                         Visibility(
    //                           visible: repeatSwitchValue,
    //                           child: SizedBox(
    //                             width: 150.w,
    //                             child: TileDropdownButton(
    //                                 menuList: data.repeatTransaction,
    //                                 value: data.repeatTransaction.first,
    //                                 onChanged: (value) {}),
    //                           ),
    //                         ),
    //                         CupertinoSwitch(
    //                           value: repeatSwitchValue,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               repeatSwitchValue = value;
    //                             });
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 15.h,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Expanded(
    //                           child: MyText(
    //                               title: "تنبيه انتهاء المعالمة",
    //                               color: MyColors.black,
    //                               size: 15.sp),
    //                         ),
    //                         Visibility(
    //                           visible: notificationSwitchvalu,
    //                           child: SizedBox(
    //                             width: 150.w,
    //                             child: Container(),
    //                           ),
    //                         ),
    //                         CupertinoSwitch(
    //                           value: notificationSwitchvalu,
    //                           onChanged: (value) {
    //                             setState(() {
    //                               notificationSwitchvalu = value;
    //                             });
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 30.h,
    //                     ),
    //                     DefaultButton(
    //                       fontSize: 14.sp,
    //                       borderColor: MyColors.primary,
    //                       title: "إضافة ميزانية",
    //                       color: MyColors.primary,
    //                       onTap: () async {
    //                         if (formKey.currentState!.validate()) {
    // List<String?> transactionValue = context
    //     .read<BudgetCubit>()
    //     .transactioList
    //     .map((value) => value.total)
    //     .toList();
    // List<double> parsedValues = context
    //     .read<BudgetCubit>()
    //     .transactioList
    //     .map((value) =>
    //         double.tryParse(value.total ?? '0.0') ??
    //         0.0)
    //     .toList();
    // List<double> dividedValues = parsedValues.map((value) => value / 100.0).toList();
    // List<double> parsedValues = transactionValue
    //     .where((value) =>
    //         value != null) // Filter out null values
    //     .map((value) => double.parse(
    //         value!)) // Convert String to double
    //     .toList();
    // var result= parsedNumber/parsedValues
    //                           double transactionValue = context
    //                               .read<BudgetCubit>()
    //                               .transactioList
    //                               .map((value) =>
    //                                   double.tryParse(value.total ?? '0.0') ??
    //                                   0.0)
    //                               .fold(
    //                                   0.0,
    //                                   ((previousValue, current) =>
    //                                       previousValue + current));
    //                           double deficiency =
    //                               parsedNumber - transactionValue;
    //                           double percentageValue =
    //                               deficiency / parsedNumber;

    //                           var budgetModel = BudgetModel(
    //                               name: budgetName.text,
    //                               percentValue: 1.0,
    //                               selectTransaction: transactionController.text,
    //                               selectWallet: walletNameController.text,
    //                               budgetPeriod: rangeDateController.text,
    //                               value: parsedNumber);

    //                           await context
    //                               .read<BudgetCubit>()
    //                               .addData(budgetModel);
    //                           if (context.mounted) {
    //                             AutoRouter.of(context).pop();
    //                           }
    //                         }
    //                       },
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       }
    //       return const SizedBox();
    //     }));
  }

  // void dateRange() async {
  //   DateTimeRange? dateRange = await showDateRangePicker(
  //     context: context,
  //     firstDate: context.read<BudgetCubit>().startDate,
  //     lastDate: context.read<BudgetCubit>().endDate,
  //   );

  //   if (dateRange != null) {
  //     setState(() {
  //       selectRangeDate = dateRange;
  //       rangeDateController.text =
  //           "${dateRange.start.day}/${dateRange.start.month}/${dateRange.start.year} - ${dateRange.end.day}/${dateRange.end.month}/${dateRange.end.year}";
  //     });
  //   }
  // }
  Future<void> openDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        context.read<BudgetCubit>().openDateController.text =
            selectedDate.toString();
      });
    }
  }

  Future<void> closeDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: closedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != closedDate) {
      setState(() {
        closedDate = picked;
        context.read<BudgetCubit>().closeDateController.text =
            closedDate.toString();
      });
    }
  }
}
