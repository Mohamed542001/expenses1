import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/packages/generic_bloc/generic_cubit.dart';
import 'package:expenses/general/packages/localization/Localizations.dart';
import 'package:expenses/general/themes/app_colors.dart';
import 'package:expenses/general/themes/cubit/app_theme_cubit.dart';
import 'package:expenses/general/utilities/routers/RouterImports.gr.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/general/widgets/widgets_imports.dart';
import 'package:expenses/res.dart';
import 'package:expenses/user/models/pie_chart_data_model/pie_chart_data_model.dart';
import 'package:expenses/user/screens/budget/budget.dart';
import 'package:expenses/user/screens/database/database_imports.dart';
import 'package:expenses/user/screens/home/home_imports.dart';
import 'package:expenses/user/screens/home/taps/main/widgets/main_widgets_imports.dart';
import 'package:expenses/user/screens/reports/reports_imports.dart';
import 'package:expenses/user/screens/settings/settings_imports.dart';
import 'package:expenses/user/screens/transactions/transactions_imports.dart';
import 'package:expenses/user/screens/wallet/wallet_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

part 'main.dart';
part 'main_data.dart';
