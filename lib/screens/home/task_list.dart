part of '../../index.dart';

class TaskList extends StatelessWidget {
  final bool darkModeOn;
  final Box<TaskModel> box;
  final int colorCode;
  const TaskList({
    super.key,
    required this.darkModeOn,
    required this.box,
    required this.colorCode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 475,
      child: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: box.listenable(),
        builder: (context, taskBox, child) {
          final todoList = taskBox.values.toList();

          if (todoList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    darkModeOn
                        ? Assets.images.svg.vcEmptyDark
                        : Assets.images.svg.vcEmptyLight,
                    height: 200,
                  ),
                  AppDimens.medium.height,
                  Text(
                    'امروز برنامه ای نداری',
                    style: AppTextStyles.emptyTextStyle.copyWith(
                        background: Paint()
                          ..strokeJoin = StrokeJoin.round
                          ..style = PaintingStyle.stroke
                          ..color = Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.1)
                          ..strokeWidth = 25),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (contxt, index) {
                todoList[index].id = index;
                return Padding(
                  padding: const EdgeInsets.all(AppDimens.medium),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(todoList[index].color.code),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppDimens.small),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.small),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    AddTaskScreen(
                                                  taskModel: TaskModel(
                                                      id: todoList[index].id,
                                                      title:
                                                          todoList[index].title,
                                                      note:
                                                          todoList[index].note,
                                                      isCompleted:
                                                          todoList[index]
                                                              .isCompleted,
                                                      date:
                                                          todoList[index].date,
                                                      startTime: todoList[index]
                                                          .startTime,
                                                      endTime: todoList[index]
                                                          .endTime,
                                                      color:
                                                          todoList[index].color,
                                                      remind: todoList[index]
                                                          .remind,
                                                      repeat: todoList[index]
                                                          .repeat,
                                                      place: todoList[index]
                                                          .place),
                                                ),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            height: 30,
                                            child: Icon(
                                              Icons.edit_note_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(DeleteTaskEvent(index));
                                          },
                                          child: SizedBox(
                                            height: 30,
                                            child: Icon(
                                              Icons.delete_outline_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.small),
                                    child: Text(
                                      todoList[index].title,
                                      style: AppTextStyles.taskTitleTextStyle
                                          .apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Divider(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.small),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: ' ساعت ',
                                        style: AppTextStyles
                                            .taskInfoTitleTextStyle
                                            .apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                      TextSpan(
                                        text:
                                            '${todoList[index].startTime.toPersianNumber()} تا ${todoList[index].endTime.toPersianNumber()}',
                                        style: AppTextStyles.taskInfoTextStyle
                                            .apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      )
                                    ]),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'مکان ',
                                        style: AppTextStyles
                                            .taskInfoTitleTextStyle
                                            .apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                      TextSpan(
                                        text: todoList[index].place,
                                        style: AppTextStyles.taskInfoTextStyle
                                            .apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      )
                                    ]),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'یادداشت ',
                                          style: AppTextStyles
                                              .taskInfoTitleTextStyle
                                              .apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                        ),
                                        TextSpan(
                                          text: todoList[index].note,
                                          style: AppTextStyles.taskInfoTextStyle
                                              .apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}