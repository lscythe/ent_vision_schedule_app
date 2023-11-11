import 'package:driver/app/themes/themes.dart';
import 'package:driver/constants/constants.dart';
import 'package:driver/extensions/extensions.dart';
import 'package:driver/features/features.dart';
import 'package:driver/features/login/cubit/login_cubit.dart';
import 'package:driver/generated/assets.gen.dart';
import 'package:driver/locator/locator.dart';
import 'package:driver/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'widgets/background.dart';

part 'widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String path = "/login";
  static const String name = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => locator.get<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (previous, current) => previous.state != current.state,
          listener: (context, state) {
            if (state.state == PageState.failure &&
                state.errorMessage != null) {
              context.scaffoldMessage
                  .showSnackBar(_errorSnackBar(state.errorMessage!));
            } else if (state.state == PageState.success) {
              context.go(CheckInScreen.path);
            }
          },
          builder: (context, state) => Stack(
            children: [
              const Background(),
              Padding(
                padding: Paddings.v16h28.size,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Assets.images.appLogo.image(scale: 3),
                      Spaces.h32.size,
                      Text(
                        context.localization.loginTitle,
                        textAlign: TextAlign.start,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spaces.h16.size,
                      KTextField(
                        hint: context.localization.usernameHint,
                        borderRadius: Radius.r32.size,
                        prefixIcon: const Icon(AppIcons.username),
                        focusNode: _usernameNode,
                        onEditingComplete: () => _usernameNode.nextFocus(),
                        textInputAction: TextInputAction.next,
                        onChanged: context.read<LoginCubit>().onUsernameChanged,
                      ),
                      Spaces.h16.size,
                      KTextField(
                        hint: context.localization.passwordHint,
                        borderRadius: Radius.r32.size,
                        prefixIcon: const Icon(AppIcons.password),
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                          onPressed: _changePasswordVisibility,
                          icon: Icon(
                            _obscureText ? AppIcons.hide : AppIcons.show,
                          ),
                        ),
                        focusNode: _passwordNode,
                        onChanged: context.read<LoginCubit>().onPasswordChanged,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: Paddings.a14.size,
                          child: Text(
                            context.localization.forgotPassword,
                            textAlign: TextAlign.end,
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                      ),
                      KElevatedButton(
                        label: context.localization.loginBtn,
                        onPressed: () {
                          context.hideKeyboard();
                          context.read<LoginCubit>().login();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (state.state == PageState.loading)
                const LoadingIndicator()
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _changePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  SnackBar _errorSnackBar(String message) => SnackBar(content: Text(message));
}
