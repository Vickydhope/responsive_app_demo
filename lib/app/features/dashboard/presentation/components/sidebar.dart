part of '../view/dashboard.dart';

class _Sidebar extends StatelessWidget {
  final ProjectCardData projectCardData;

  const _Sidebar({
    Key? key,
    required this.projectCardData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ProjectCard(data: projectCardData),
          const SizedBox(
            height: 20,
          ),
          SidebarDestination(
            data: [
              SidebarDestinationData(
                activeIcon: EvaIcons.home,
                icon: EvaIcons.homeOutline,
                label: "Home",
              ),
              SidebarDestinationData(
                activeIcon: EvaIcons.archive,
                icon: EvaIcons.archiveOutline,
                label: "Reports",
              ),
              SidebarDestinationData(
                activeIcon: EvaIcons.calendar,
                icon: EvaIcons.calendarOutline,
                label: "Calendar",
              ),
              SidebarDestinationData(
                activeIcon: EvaIcons.email,
                icon: EvaIcons.emailOutline,
                label: "Email",
              ),
              SidebarDestinationData(
                activeIcon: EvaIcons.person,
                icon: EvaIcons.personOutline,
                label: "Profile",
              ),
              SidebarDestinationData(
                activeIcon: EvaIcons.settings,
                icon: EvaIcons.settingsOutline,
                label: "Settings",
              ),
            ],
            onSelected: (index, value) {},
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.all(10),
            child: UpgradePremiumCard(
              onPressed: () {},
            ),
          ),
          gapH20
        ],
      ),
    );
  }
}
