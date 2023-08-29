import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_app_demo/app/constants/app_constants.dart';

class GetPremiumCard extends StatelessWidget {
  const GetPremiumCard(
      {required this.onPressed, this.backgroundColor, Key? key})
      : super(key: key);
  final Color? backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
            minHeight: 200,
            maxHeight: 200,
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                ImageVectorPath.wavyBus,
                width: 160,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const _Info()
          ]),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Get\nPremium\nAccount",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "To add more members",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
