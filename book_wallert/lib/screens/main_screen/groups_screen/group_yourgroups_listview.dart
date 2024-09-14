import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/group_controller.dart';
import 'package:book_wallert/widgets/cards/group_cards/group_card_yourgroup.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class YourGroupListView extends StatefulWidget {
  final int globalUserId;

  const YourGroupListView({
    super.key,
    required this.globalUserId,
  });

  @override
  State<YourGroupListView> createState() => _YourGroupListViewState();
}

class _YourGroupListViewState extends State<YourGroupListView> {
  late GroupController _groupController;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _groupController = GroupController();
    _fetchMoreGroups();

    // Add listener for infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreGroups();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMoreGroups() async {
    setState(() {
      _isLoading = true;
    });

    await _groupController.fetchGroupsByUserId((updatedGroups) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: _isLoading && _groupController.groups.isEmpty
          ? Center(child: buildProgressIndicator())
          : _groupController.groups.isEmpty
              ? const Center(
                  child: Text('No groups found',
                      style: TextStyle(color: MyColors.textColor)),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      _groupController.groups.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _groupController.groups.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 3),
                          GroupCardYourgroup(
                            group: _groupController.groups[index],
                          ),
                        ],
                      );
                    } else {
                      return buildProgressIndicator(); // Show loading indicator while fetching more groups
                    }
                  },
                ),
    );
  }
}
