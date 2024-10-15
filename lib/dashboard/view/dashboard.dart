import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/category_widget.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/product_widget.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((t) async {
      ZBotToast.loadingShow();
      var vm = Provider.of<BaseVm>(context, listen: false);
      await vm.fetchCategories();
      await vm.fetchProducts();
      ZBotToast.loadingClose();
      context.read<BaseVm>().fetchAppSettings();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalWidgets.buildHeader(context),
            buildBanner(context),
            buildCategories(context),
            buildProducts(context),
            GlobalWidgets.buildFooterWidget(context),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                context.watch<BaseVm>().appData?.bannerImage ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            context.watch<BaseVm>().appData?.bannerText ?? "",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                BoxShadow(
                  color: R.colors.green,
                  blurRadius: 12,
                  offset: const Offset(1, 1),
                  spreadRadius: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Wrap(
            children: List.generate(context.read<BaseVm>().categories.length,
                (index) {
              return CategoryWidget(
                model: context.read<BaseVm>().categories[index],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildProducts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: List.generate(
          context.read<BaseVm>().products.length,
          (index) {
            return ProductWidget(model: context.read<BaseVm>().products[index]);
          },
        ),
      ),
    );
  }
}
