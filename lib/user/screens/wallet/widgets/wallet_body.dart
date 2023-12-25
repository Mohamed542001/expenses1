import 'package:expenses/user/screens/expense/widgets/expense_widgets_imports.dart';
import 'package:expenses/user/screens/wallet/data/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:expenses/user/screens/wallet/data/cubit/wallet_cubit/wallet_state.dart';
import 'package:expenses/user/screens/wallet/data/model/wallet_model.dart';
import 'package:expenses/user/screens/wallet/widgets/cstom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletBody extends StatefulWidget {
  const WalletBody({super.key});

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  @override
  void initState() {
    BlocProvider.of<WalletCubit>(context).fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        List<WalletModel> wallet =
            BlocProvider.of<WalletCubit>(context).walletList;
        return Padding(
          padding: EdgeInsets.all(12.w),
          child: wallet.isEmpty
              ? const BuildNoRecord()
              : ListView.builder(
                  itemCount: wallet.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Gradient itemGradient = index % 2 == 0
                        ? const LinearGradient(
                            colors: [Color(0xff24C6DC), Color(0xff514A9D)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xffC33764), Color(0xff1D2671)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          );

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: CustomContainer(
                        model: wallet[index],
                        gradient: itemGradient,
                      ),
                    );
                  }),
        );
      },
    );
  }
}
