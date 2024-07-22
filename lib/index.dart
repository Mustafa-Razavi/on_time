import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_time/data/models/language_model.dart';
import 'package:on_time/data/models/task_model.dart';
import 'package:on_time/gen/assets.gen.dart';
import 'package:on_time/generated/l10n.dart';
import 'package:on_time/resource/themes/bloc/theme_bloc.dart';
import 'package:on_time/resource/widgets/test_date_picker/date_picker_widget.dart';
import 'package:on_time/screens/home/bloc/home_bloc.dart';
import 'package:on_time/screens/settings/bloc/localizations_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


part 'screens/my_app.dart';
part 'screens/settings/settings_page.dart';
part 'screens/home/add_task_screen.dart';
part 'screens/home/home_page.dart';
part 'screens/home/tasks.dart';
part 'screens/home/task_list.dart';
part 'resource/constants.dart';
part 'resource/app_dimens.dart';
part 'resource/widgets/custom_app_bar.dart';
part 'resource/widgets/input_feild.dart';
part 'resource/utils/extensions.dart';
part 'resource/themes/themes.dart';
part 'resource/components/text_style.dart';
part 'data/repositories/task_repo.dart';
part 'data/repositories/task_local_repo.dart';
part 'data/sources/task_data_src.dart';
part 'data/sources/task_local_data_src.dart';

