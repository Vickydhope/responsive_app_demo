part of dashboard;

class _OverviewHeader extends StatefulWidget {
  _OverviewHeader({
    Key? key,
    required this.onSelected,
    this.axis = Axis.horizontal,
  }) : super(key: key);
  final Function(TaskType? task) onSelected;
  final Axis axis;

  @override
  State<_OverviewHeader> createState() => _OverviewHeaderState();
}

class _OverviewHeaderState extends State<_OverviewHeader> {
  TaskType? taskType;

  @override
  Widget build(BuildContext context) {
    return widget.axis == Axis.horizontal
        ? Row(
            children: [
              const Text(
                "Task Overview",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Spacer(),
              ..._listButton(
                task: taskType,
                onSelected: (value) {
                  setState(() {
                    taskType = value;
                  });
                  widget.onSelected(value);
                },
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Task Overview",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: _listButton(
                    task: taskType,
                    onSelected: (value) {
                      setState(() {
                        taskType = value;
                      });
                      widget.onSelected(value);
                    },
                  ),
                ),
              ),
            ],
          );
  }

  List<Widget> _listButton({
    required TaskType? task,
    required Function(TaskType? value) onSelected,
  }) {
    return [
      _button(
        selected: task == null,
        label: "All",
        onPressed: () {
          task = null;
          onSelected(null);
        },
      ),
      _button(
        selected: task == TaskType.todo,
        label: "To do",
        onPressed: () {
          task = TaskType.todo;
          onSelected(TaskType.todo);
        },
      ),
      _button(
        selected: task == TaskType.inProgress,
        label: "In progress",
        onPressed: () {
          task = TaskType.inProgress;
          onSelected(TaskType.inProgress);
        },
      ),
      _button(
        selected: task == TaskType.done,
        label: "Done",
        onPressed: () {
          task = TaskType.done;
          onSelected(TaskType.done);
        },
      ),
    ];
  }

  Widget _button({
    required bool selected,
    required String label,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selected ? AppTheme.basic.cardColor : AppTheme.basic.canvasColor,
          foregroundColor:
              selected ? kFontColorPallets[0] : kFontColorPallets[2],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
