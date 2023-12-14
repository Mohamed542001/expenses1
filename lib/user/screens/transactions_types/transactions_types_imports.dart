import 'package:auto_route/auto_route.dart';
import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/packages/generic_bloc/generic_cubit.dart';
import 'package:expenses/general/utilities/utils_functions/ApiNames.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:expenses/user/models/dropdown_model/dropdown_model.dart';
import 'package:expenses/user/models/transaction_type_model/transaction_content_model.dart';
import 'package:expenses/user/models/transaction_type_model/transaction_type_model.dart';
import 'package:expenses/user/screens/add_transaction/widgets/add_transaction_widgets_imports.dart';
import 'package:expenses/user/screens/commitments/commitments_imports.dart';
import 'package:expenses/user/screens/commitments/widgets/commitments_widgets_imports.dart';
import 'package:expenses/user/screens/transactions_types/widgets/transactions_types_widgets_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transactions_types.dart';
part 'transactions_types_data.dart';