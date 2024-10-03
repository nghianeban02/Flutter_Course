import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/models/tools_viewmodel.dart';
import 'package:grocery/views/home/search_result_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/constants/app_icons.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/ui_util.dart';
import 'dialogs/product_filters_dialog.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SearchPageHeader(),
            SizedBox(height: 8),
            _RecentSearchList(),
          ],
        ),
      ),
    );
  }
}

class _RecentSearchList extends StatefulWidget {
  const _RecentSearchList({
    Key? key,
  }) : super(key: key);

  @override
  State<_RecentSearchList> createState() => _RecentSearchListState();
}

class _RecentSearchListState extends State<_RecentSearchList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tìm kiếm gần đây',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? LoadingAnimationWidget.discreteCircle(
                      color: Colors.green, size: 35)
                  : SingleChildScrollView(
                      child: SizedBox(
                        width: 500,
                        height: 250,
                        child: Consumer<ToolsVM>(
                          builder: (context, value, child) {
                            // Sort the list by the most recent items
                            return Scaffold(
                              body: SafeArea(
                                child: Scaffold(
                                  body: value.lst.isEmpty
                                      ? Center()
                                      : ListView.builder(
                                          itemCount: value.lst.length,
                                          itemBuilder: ((context, index) {
                                            //đảo ngược danh sách để đưa từ khóa gần nhất lên đầu
                                            final sortByRecently =
                                                value.lst.length - 1 - index;
                                            return itemHistorySearch(
                                                value.lst[sortByRecently]);
                                          })),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemHistorySearch(String name) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => SearchResultPage(
              dataSearch: name,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            SvgPicture.asset(AppIcons.searchTileArrow),
          ],
        ),
      ),
    );
  }
}

class _SearchPageHeader extends StatefulWidget {
  const _SearchPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<_SearchPageHeader> createState() => _SearchPageHeaderState();
}

class _SearchPageHeaderState extends State<_SearchPageHeader> {
  String _searchText = '';

  void _onSearch(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const AppBackButton(),
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              children: [
                /// Search Box
                Consumer<ToolsVM>(
                  builder: (context, value, child) {
                    return Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm sản phẩm',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(AppDefaults.padding),
                            child: SvgPicture.asset(
                              AppIcons.search,
                              color: AppColors.primary,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(),
                          contentPadding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        // onChanged: (String? value) {},
                        onFieldSubmitted: (v) {
                          //thêm từ khóa vào danh sách lịch sử tìm kiếm;
                          value.addSearchResult(v);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SearchResultPage(
                                dataSearch: v,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 0,
                  height: 56,
                  child: SizedBox(
                    width: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        UiUtil.openBottomSheet(
                          context: context,
                          widget: const ProductFiltersDialog(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(AppIcons.filter),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHistoryTile extends StatefulWidget {
  const SearchHistoryTile({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchHistoryTile> createState() => _SearchHistoryTileState();
}

class _SearchHistoryTileState extends State<SearchHistoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.searchResult);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              'Nước tương',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            SvgPicture.asset(AppIcons.searchTileArrow),
          ],
        ),
      ),
    );
  }
}
