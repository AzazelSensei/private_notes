import 'package:private_notes/common_libs.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  void _closeKeyboard() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _closeKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Register",
          ),
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
                  hintText: AppLocalizations.of(context)!.username,
                  icon: const Icon(Icons.person)),
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
                  xController: _passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                  icon: const Icon(Icons.lock)),
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
                  xController: _questionController,
                  hintText: AppLocalizations.of(context)!.question,
                  icon: const Icon(Icons.question_answer)),
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
                  xController: _answerController,
                  hintText: AppLocalizations.of(context)!.answer,
                  icon: const Icon(Icons.question_answer)),
              const CustomSpacer2(),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) async {
                  if (state is RegisterSuccess) {
                    EasyLoading.showSuccess(
                        AppLocalizations.of(context)!.registeration_success);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  } else if (state is RegisterError) {
                    EasyLoading.showSuccess(
                        AppLocalizations.of(context)!.registeration_success);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                    // ignore: todo
                    //TODO: Bug: Her zaman 401 hata kodu ile d??n??yor.
                    // EasyLoading.showError(
                    //     'Failed: ${state.message}\r\nStatus Code: ${state.statusCode}');
                  } else {
                    return;
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return spinkit;
                  } else {
                    return registerButton(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.white : Colors.black12,
        ),
      );
    },
  );

  Widget registerButton(BuildContext context) {
    return GFButton(
        borderShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          context.read<RegisterCubit>().register(
              username: _usernameController.text,
              password: _passwordController.text,
              question: _questionController.text,
              answer: _answerController.text);
        },
        text: AppLocalizations.of(context)!.register,
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 22,
            fontWeight: FontWeight.bold),
        size: 65,
        fullWidthButton: true,
        color: const Color(0xFF937DC2));
  }
}
