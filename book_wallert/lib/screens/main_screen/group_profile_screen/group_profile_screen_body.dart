import 'package:book_wallert/controllers/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_list_view.dart';
import 'package:book_wallert/screens/main_screen/group_profile_screen/group_profile_screen_details.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';
import 'package:book_wallert/colors.dart';

class GroupProfileScreenBody extends StatefulWidget {
  final int groupId;

  const GroupProfileScreenBody({super.key, required this.groupId});

  @override
  State<GroupProfileScreenBody> createState() => _GroupProfileScreenBodyState();
}

class _GroupProfileScreenBodyState extends State<GroupProfileScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late GroupController _groupController;
  GroupModel? _group;
  bool _isLoading = true;

  final List<String> _tabNames = ['Reviews', 'Books'];
  final double scrollThreshold = 100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _groupController = GroupController();
    _fetchGroupDetails();
  }

  Future<void> _fetchGroupDetails() async {
    _groupController.fetchGroupById(widget.groupId.toString(), (group) {
      setState(() {
        _group = group;
        _isLoading = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= scrollThreshold &&
        !_scrollController.position.outOfRange) {
      _scrollController.jumpTo(scrollThreshold);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: GroupProfileScreenDetails(group: _group!),
                ),
                SliverToBoxAdapter(
                  child: SelectionBar(
                      tabController: _tabController, tabNames: _tabNames),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      GroupProfileScreenListView(
                        screenName: 'Reviews',
                        groupId: widget.groupId,
                      ), // Reviews
                      GroupProfileScreenListView(
                        screenName: 'Books',
                        groupId: widget.groupId,
                      ), // Books
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
