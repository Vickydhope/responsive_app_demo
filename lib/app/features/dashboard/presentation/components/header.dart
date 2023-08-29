part of "../view/dashboard.dart";

class _Header extends StatelessWidget {
  const _Header({Key? key, this.axis = Axis.horizontal}) : super(key: key);
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TodayText(),
        if (axis == Axis.horizontal) ...{
          const SizedBox(width: kSpacing),
          Expanded(child: SearchField()),
        }
      ],
    );
  }
}
