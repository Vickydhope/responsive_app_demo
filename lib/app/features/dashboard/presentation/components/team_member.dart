part of dashboard;

class _TeamMember extends StatelessWidget {
  const _TeamMember({
    Key? key,
    required this.onPressedAdd,
    required this.totalMember,
  }) : super(key: key);
  final int totalMember;
  final Function() onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kFontColorPallets[0],
              ),
              children: [
                const TextSpan(text: "Team Member "),
                TextSpan(
                  text: "($totalMember)",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: kFontColorPallets[2],
                  ),
                ),
              ]),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(EvaIcons.plus))
      ],
    );
  }
}
