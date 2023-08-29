library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_app_demo/app/config/themes/app_theme.dart';
import 'package:responsive_app_demo/app/constants/app_constants.dart';
import 'package:responsive_app_demo/app/shared_components/app_gap_manager.dart';
import 'package:responsive_app_demo/app/shared_components/get_premium_card.dart';
import 'package:responsive_app_demo/app/shared_components/list_profile_image.dart';
import 'package:responsive_app_demo/app/shared_components/progress_card.dart';
import 'package:responsive_app_demo/app/shared_components/progress_report_card.dart';
import 'package:responsive_app_demo/app/shared_components/project_card.dart';
import 'package:responsive_app_demo/app/shared_components/search_field.dart';
import 'package:responsive_app_demo/app/shared_components/sidebar_destination.dart';
import 'package:responsive_app_demo/app/shared_components/upgrade_permium_card.dart';
import 'package:responsive_app_demo/responsive_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../shared_components/task_card.dart';
import '../../../../shared_components/today_text.dart';
import '../../../../utils/helpers/app_helpers.dart';

part '../components/sidebar.dart';

part '../components/overview_header.dart';

part '../components/header.dart';

part '../components/profile_tile.dart';

part '../components/team_member.dart';

part '../../models/profile.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: _Sidebar(
                  projectCardData: ProjectCardData(
                    projectImage: const NetworkImage(
                        "https://i.pinimg.com/474x/47/1d/4e/471d4e1a8a3daea6c72e948f0c7524b5--logo-pilates-chinese-logo.jpg"),
                    projectName: "Beetle The Bug",
                    releaseTime: DateTime.now(),
                    percent: 50 / 100,
                  ),
                ),
              ),
            ),
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) => Column(
            children: [
              SizedBox(height: kSpacing * (kIsWeb ? 1 : 2.5)),
              _buildHeader(
                axis: Axis.vertical,
                onMenuPress: () => scaffoldKey.currentState?.openDrawer(),
              ),
              const SizedBox(height: kSpacing / 2),
              const Divider(),
              const SizedBox(height: kSpacing / 2),
              _buildProfile(),
              gapH20,
              _buildProgress(axis: Axis.vertical),
              gapH20,
              _buildTeamMember(),
              gapH20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              gapH20,
              _buildTaskOverview(
                data: getAllTask(),
                headerAxis: Axis.vertical,
                crossAxisCount: 1,
              ),
              gapH20,
              gapH20,
            ],
          ),
          tabletBuilder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 950) ? 6 : 9,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      child: _buildHeader(
                        axis: constraints.maxWidth < 950
                            ? Axis.vertical
                            : Axis.horizontal,
                        onMenuPress: () =>
                            scaffoldKey.currentState?.openDrawer(),
                      ),
                    ),
                    _buildProgress(
                        axis: constraints.maxWidth < 950
                            ? Axis.vertical
                            : Axis.horizontal),
                    gapH20,
                    _buildTaskOverview(
                      data: getAllTask(),
                      headerAxis: constraints.maxWidth < 950
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisCount: constraints.maxWidth < 950 ? 1 : 2,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    _buildTeamMember(),
                    gapH20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                      child: GetPremiumCard(onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
          desktopBuilder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: (constraints.maxWidth < 1360) ? 4 : 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(kSpacing),
                    bottomRight: Radius.circular(kSpacing),
                  ),
                  child: _Sidebar(
                    projectCardData: ProjectCardData(
                      projectImage: const NetworkImage(
                          "https://i.pinimg.com/474x/47/1d/4e/471d4e1a8a3daea6c72e948f0c7524b5--logo-pilates-chinese-logo.jpg"),
                      projectName: "projectName",
                      releaseTime: DateTime.now(),
                      percent: 50 / 100,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 9,
                child: Column(
                  children: [
                    _buildHeader(),
                    gapH20,
                    _buildProgress(),
                    gapH20,
                    _buildTaskOverview(
                      data: getAllTask(),
                      crossAxisCount: (constraints.maxWidth < 1360) ? 2 : 3,
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(height: kSpacing / 2),
                    _buildProfile(),
                    const Divider(thickness: 1),
                    _buildTeamMember(),
                    gapH20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                      child: GetPremiumCard(onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: axis == Axis.horizontal
          ? Row(
              children: [
                Flexible(
                  flex: 5,
                  child: ProgressCard(
                    data: const ProgressCardData(
                      totalUndone: 3,
                      totalTaskInProress: 3,
                    ),
                    onPressedCheck: () {},
                  ),
                ),
                gapW20,
                const Flexible(
                    flex: 4,
                    child: ProgressReportCard(
                      data: ProgressReportCardData(
                          percent: 0.5,
                          title: "First Sprint",
                          task: 6,
                          doneTask: 3,
                          undoneTask: 3),
                    )),
              ],
            )
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(
                      totalUndone: 3, totalTaskInProress: 2),
                  onPressedCheck: () {},
                ),
                gapH20,
                const ProgressReportCard(
                    data: ProgressReportCardData(
                        percent: 0.5,
                        title: "First Sprint",
                        task: 6,
                        doneTask: 3,
                        undoneTask: 3))
              ],
            ),
    );
  }

  _buildHeader({
    Function()? onMenuPress,
    Axis axis = Axis.horizontal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kSpacing, vertical: kSpacing / 2),
      child: axis == Axis.horizontal
          ? Row(
              children: [
                if (onMenuPress != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: kSpacing,
                    ),
                    child: GestureDetector(
                      onTap: onMenuPress,
                      child: const Icon(Icons.menu),
                    ),
                  ),
                const Expanded(
                  child: _Header(),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    if (onMenuPress != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: kSpacing,
                        ),
                        child: GestureDetector(
                          onTap: onMenuPress,
                          child: const Icon(Icons.menu),
                        ),
                      ),
                    _Header(
                      axis: axis,
                    ),
                  ],
                ),
                gapH8,
                SearchField()
              ],
            ),
    );
  }

  _buildProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ProfilTile(
          data: const _Profile(
              photo: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJEcCSAuboDTd9lDlFJlgK7ht7VNJ7mDscVA&usqp=CAU"),
              name: "John Wick",
              email: "johnwick@gmail.com"),
          onPressedNotification: () {}),
    );
  }

  _buildTeamMember() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeamMember(
            totalMember: 5,
            onPressedAdd: () {},
          ),
          ListProfileImage(
            maxImages: 5,
            images: getMember(),
          )
        ],
      ),
    );
  }

  Widget _buildTaskOverview({
    required List<TaskCardData> data,
    int crossAxisCount = 6,
    Axis headerAxis = Axis.horizontal,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: kSpacing, right: kSpacing),
          child: _OverviewHeader(
            axis: headerAxis,
            onSelected: (task) {},
          ),
        ),
        gapH20,
        AlignedGridView.count(
          crossAxisCount: crossAxisCount,
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TaskCard(
              data: data[index],
              onPressedMore: () {},
              onPressedTask: () {},
              onPressedContributors: () {},
              onPressedComments: () {},
            );
          },
        ),
      ],
    );
  }

  List<ImageProvider> getMember() {
    return const [
      AssetImage(ImageRasterPath.avatar1),
      AssetImage(ImageRasterPath.avatar2),
      AssetImage(ImageRasterPath.avatar3),
      AssetImage(ImageRasterPath.avatar4),
      AssetImage(ImageRasterPath.avatar5),
      AssetImage(ImageRasterPath.avatar6),
    ];
  }

  List<TaskCardData> getAllTask() {
    return [
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: 2,
        totalComments: 50,
        type: TaskType.todo,
        totalContributors: 30,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar1),
          AssetImage(ImageRasterPath.avatar2),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
        ],
      ),
      const TaskCardData(
        title: "Landing page UI Design",
        dueDay: -1,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.inProgress,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar6),
          AssetImage(ImageRasterPath.avatar7),
          AssetImage(ImageRasterPath.avatar8),
        ],
      ),
      const TaskCardData(
        title: "Profile page UI Design",
        dueDay: 3,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.done,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
          AssetImage(ImageRasterPath.avatar2),
        ],
      ),
      const TaskCardData(
        title: "Dashboard UI Design",
        dueDay: 10,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.inProgress,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
          AssetImage(ImageRasterPath.avatar2),
        ],
      ),
      const TaskCardData(
        title: "Order page UI Design",
        dueDay: 0,
        totalComments: 50,
        totalContributors: 34,
        type: TaskType.todo,
        profilContributors: [
          AssetImage(ImageRasterPath.avatar5),
          AssetImage(ImageRasterPath.avatar3),
          AssetImage(ImageRasterPath.avatar4),
          AssetImage(ImageRasterPath.avatar2),
        ],
      ),
    ];
  }
}
