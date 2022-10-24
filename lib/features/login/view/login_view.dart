import 'dart:async';

import 'package:private_notes/common_libs.dart';
import 'package:private_notes/core/components/default_button.dart';
import 'package:private_notes/core/init/routes/app_router.dart';
import 'package:private_notes/core/init/theme/colors_manager.dart';
import 'package:private_notes/features/forgot_password/view/forgot_password_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/string_constants.dart';
import '../../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;
  Timer? _timer;
  late Color color;

  @override
  void initState() {
    super.initState();
    getLocalData();
    isVisible = false;
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  Future<void> getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isShowOnBoard = prefs.getBool(StringConstants.showOnBoardKey);
    if (!(isShowOnBoard == true)) {
      await prefs.setBool(StringConstants.showOnBoardKey, true);
      context.router.push(const OnBoardRoute());
    }
  }

  void _closeKeyboard() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _closeKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.private_notes_login),
          // actions: [
          //   Padding(
          //     padding: context.right,
          //     child: const ModeSwitcher(),
          //   )
          // ],
        ),
        body: Padding(
          padding: context.lowHorPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomLogo(),
              const CustomSpacer(),
              CustomTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                    RegExp(emojiDeny),
                  ),
                  FilteringTextInputFormatter.deny(
                    RegExp(' '),
                  ),
                ],
                xController: _usernameController,
                hintText: (AppLocalizations.of(context)!.username),
                icon: const Icon(Icons.person),
              ),
              const CustomSpacer(),
              passwordField(context),
              const CustomSpacer(),
              blocConsumer(),
              const CustomSpacer(),
              registerTextButton(context),
              forgotPass(context),
              const CustomSpacer(),
              flagZone(context),
            ],
          ),
        ),
      ),
    );
  }

  Row flagZone(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 5,
        ),
        GestureDetector(
            child: Flag.fromCode(
              FlagsCode.TR,
              height: 30,
              width: 45,
              fit: BoxFit.fill,
            ),
            onTap: () {
              MyApp.setLocale(context, const Locale('tr'));
            }),
        const Spacer(
          flex: 1,
        ),
        GestureDetector(
          child: Flag.fromCode(
            FlagsCode.US,
            height: 30,
            width: 45,
            fit: BoxFit.fill,
          ),
          onTap: () {
            MyApp.setLocale(context, const Locale('en'));
          },
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }

  BlocConsumer<LoginCubit, LoginState> blocConsumer() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          EasyLoading.showSuccess(
              (AppLocalizations.of(context)!.login_success));
          context.router.replace(const TaskGetRoute());
        } else if (state is LoginError) {
          EasyLoading.showError(
              'Failed: ${state.message}\r\nStatus Code: ${state.statusCode}');
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.black12,
                ),
              );
            },
          );
        } else {
          return loginButton;
        }
      },
    );
  }

  TextButton registerTextButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterView()));
          _timer?.cancel();
        },
        child: Text(
          (AppLocalizations.of(context)!.i_dont_have_a_acc),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
  }

  TextButton forgotPass(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgotPasswordView()));
          _timer?.cancel();
        },
        child: Text(
          (AppLocalizations.of(context)!.i_forgot_my_password),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
  }

  TextFormField passwordField(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(emojiDeny),
        ),
      ],
      keyboardType: TextInputType.text,
      controller: _passwordController,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: (AppLocalizations.of(context)!.password),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
    );
  }

  Widget get loginButton => DefaultButton(
        onPressed: () {
          context.read<LoginCubit>().login(
              username: _usernameController.text,
              password: _passwordController.text);
        },
        text: (AppLocalizations.of(context)!.sign_in),
        color: ColorManager.mainTheme,
      );
}
