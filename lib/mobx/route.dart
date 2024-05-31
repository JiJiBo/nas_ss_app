import 'package:event_bus/event_bus.dart';
import 'package:mobx/mobx.dart';

// This is our generated file (we'll see this soon!)
part 'route.g.dart';

// We expose this to be used throughout our project
class route = _route with _$route;

final routeStore = route();
var eventBus = EventBus();

// Our store class
abstract class _route with Store {
  String welcome_ui_route = "/welcome_ui_route";
  String home_ui_route = "/home_ui_route";
  String add_ui_route = "/add_ui_route";
  String index_ui_route = "/index_ui_route";
  String small_say_route = "/small_say_route";
  String small_say_mid_route = "/small_say_mid_route";
  String play_route = "/play_route";
  String setting_route = "/setting_route";
  String register_route = "/register_route";
  String login_route = "/login_route";
  String user_route = "/user_route";
  String small_say_detail_route = "/small_say_detail_route";

  String keyOfLoginToken = "keyOfLoginToken";
  String url = "";
  String fileUrl = "";
  String port = "";
  String filePort = "";
}
