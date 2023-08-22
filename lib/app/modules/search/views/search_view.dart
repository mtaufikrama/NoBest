import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nobes/app/data/model/usda_list.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/icon_app.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:nobes/app/data/services/translate.dart';
import 'package:nobes/app/data/widget/refresh_page.dart';
import 'package:nobes/app/routes/app_pages.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchsController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: teksLanguage(
          'Search Food',
          style: Font.regular(),
        ),
        centerTitle: true,
        leading: Publics.leading,
      ),
      body: RefreshPage(
        routes: Routes.SEARCH,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      label: teksLanguage(
                        "Search Food",
                        style: Font.regular(
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Warna.primary,
                        ),
                      ),
                    ),
                    onEditingComplete: controller.onSubmit,
                  ),
                ),
                IconButton(
                  onPressed: controller.onSubmit,
                  icon: const ImageIcon(
                    AssetImage(
                      IconApp.send,
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              return ListView.builder(
                itemCount: controller.getSearch.length,
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await controller.onSearch(controller.getSearch[index]);
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          controller.getSearch[index].toString(),
                          style: Font.regular(
                            fontSize: 15.0,
                            color: Warna.baseWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ListFoodWidget extends StatelessWidget {
  const ListFoodWidget({
    super.key,
    required this.datas,
  });

  final List<USDAList> datas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: datas.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        USDAList data = datas[index];
        double kalori = (data.foodNutrients!
                    .firstWhere(
                      (data) =>
                          data.unitName == 'KCAL' && data.name == 'Energy',
                      orElse: () => FoodNutrients(amount: 0),
                    )
                    .amount ??
                0)
            .toDouble();
        return Card(
          child: ListTile(
            leading: Text(kalori.toString()),
            title: Text(data.description!),
            subtitle: Text(data.publicationDate!),
          ),
        );
      },
    );
  }
}
