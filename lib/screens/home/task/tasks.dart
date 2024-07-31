// Tasks.dart

part of '../../../index.dart';

Box<TaskModel> taskBox = Hive.box<TaskModel>(taskBoxName);

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final todoList = taskBox.values.toList();
    final taskDates = todoList
        .map((task) => DateTime(task.date.year, task.date.month, task.date.day))
        .toSet()
        .toList();

    String day = _selectedDate.toJalali().day.toPersianNumberInt();
    String month = _selectedDate.toJalali().month.toPesianMonth();
    String year = _selectedDate.toJalali().year.toPersianNumberInt();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: AppDimens.medium),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.medium),
          child: Text(
            ' $day, $month , $year',
            style: AppTextStyles.appTopText,
            textDirection: TextDirection.rtl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimens.medium),
          child: PersianHorizontalDatePicker(
            selectedDayTextStyle: AppTextStyles.selectedTextStyle
                .apply(color: Theme.of(context).colorScheme.surface),
            selectedMonthTextStyle: AppTextStyles.selectedTextStyle
                .apply(color: Theme.of(context).colorScheme.surface),
            selectedWeekDayTextStyle: AppTextStyles.selectedTextStyle
                .apply(color: Theme.of(context).colorScheme.surface),
            selectedMarkedDotColor: Theme.of(context).colorScheme.surface,
            markedDotColor: Theme.of(context).colorScheme.onSurface,
            markedDates: taskDates,
            hasSelectedItemShadow: false,
            initialSelectedDate: DateTime.now(),
            datePickerHeight: 90,
            startDate: DateTime(2024, 6, 31),
            endDate: DateTime.now().add(const Duration(days: 30)),
            backgroundColor: Colors.transparent,
            textColor: Theme.of(context).colorScheme.onSurface,
            selectedTextColor: Theme.of(context).colorScheme.surface,
            selectedBackgroundColor: Theme.of(context).colorScheme.onSurface,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date!;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.medium),
              child: IconButton.filled(
                iconSize: 35,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddTaskScreen(
                        date: _selectedDate,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.medium),
              child: InkWell(
                onTap: () {
                },
                child: Text(
                  AppStrings.planning,
                  style: AppTextStyles.bodyTitleTextStyle.apply(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
        BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is DeleteTaskState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(
                    'تسک با موفقیت حذف شد ',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TaskLoadedState) {
              return TaskList(
                selectedDate: _selectedDate,
              );
            } else if (state is DeleteAllTasksState ||
                state is DeleteTaskState ||
                state is SaveTaskState ||
                state is UpdateTaskState) {
              return TaskList(
                selectedDate: _selectedDate,
              );
            } else if (state is TaskError) {
              return const Text('خطا');
            } else if (state is TaskLoadingState) {
              return const LinearProgressIndicator();
            } else {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TaskBloc>(context).add(TaskInit());
                },
                child: const Text('تلاش مجدد'),
              );
            }
          },
        ),
      ],
    );
  }
}
