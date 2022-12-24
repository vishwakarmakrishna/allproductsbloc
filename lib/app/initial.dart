import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'const/constant.dart';

Future<void> initServices() async {
  await Hive.initFlutter();
  await Hive.openBox(AppConstant.settings);
  await Hive.openBox(AppConstant.local);
  await Hive.openBox(AppConstant.qrCode);
  await Supabase.initialize(
    url: AppConstant.supabaseUrl,
    anonKey: AppConstant.supabaseKey,
  );
}
