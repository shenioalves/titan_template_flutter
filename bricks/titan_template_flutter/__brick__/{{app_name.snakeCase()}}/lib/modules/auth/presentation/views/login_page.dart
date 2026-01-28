import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:remixicon/remixicon.dart';
import '../../../../core/presentation/components/titan_background.dart';
import '../../../../core/presentation/components/titan_button.dart';
import '../../../../core/presentation/components/titan_icon.dart';
import '../../../../core/presentation/components/titan_rich_text.dart';
import '../../../../core/presentation/components/titan_text.dart';
import '../../../../core/presentation/components/titan_text_field.dart';
import '../../../../core/presentation/legacy/color_theme.dart';
import '../../../../core/presentation/legacy/titan_typography.dart';
import '../../../../core/presentation/state_management/bloc_view.dart';
import '../../../../core/utils/mixins_utils.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../view_models/login_bloc.dart';
import '../view_models/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MixinsUtils {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final responsiveUtils = ResponsiveUtils();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocView<LoginBloc, LoginState>(
        builder: (context, state) => BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              Modular.to.navigate('/home');
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorTheme.background,
            body: Stack(
              children: [
                const Positioned.fill(
                  child: TitanBackground(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SafeArea(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                
                                  const SizedBox(height: 100),
                                  const TitanText(
                                    text: 'E-mail',
                                    typography: TitanTypography.titleLgMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  TitanTextField(
                                    controller: _emailController,
                                    inputType: TextInputType.emailAddress,
                                    validateInput: validateEmail,
                                    texHint: 'E-mail cadastrado',
                                  ),
                                  const SizedBox(height: 24),
                                  const TitanText(
                                    text: 'Senha',
                                    typography: TitanTypography.titleLgMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  TitanTextField(
                                    controller: _passwordController,
                                    validateInput: moreThanSeven,
                                    texHint: 'Senha',
                                    isPassword: true,
                                  ),
                                  const SizedBox(height: 24),
                                  TitanButton(
                                    label: 'Acessar',
                                    isLoading: state.isLoading,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        context.read<LoginBloc>().login(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  Center(
                                    child: TitanRichText(
                                      textSpans: [
                                        TitanTextSpan(
                                          text: 'Esqueceu a senha? ',
                                          typography: TitanTypography.buttonMd,
                                          color: ColorTheme.gray_100,
                                          context: context,
                                        ),
                                        TitanTextSpan(
                                          text: 'Clique aqui',
                                          typography: TitanTypography.buttonMd,
                                          color: ColorTheme.white,
                                          context: context,
                                          onTap: () {
                                            // Modular.to.pushNamed('/auth/recovery');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: ColorTheme.dark_2,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Row(
                                        children: [
                                          const TitanIcon(
                                            icon: Remix.information_line,
                                            color: ColorTheme.brown_200,
                                          ),
                                          Expanded(
                                            child: TitanRichText(
                                              textAlign: TextAlign.center,
                                              textSpans: [
                                                TitanTextSpan(
                                                  text:
                                                      'Não tem cadastro? Fale com o ',
                                                  color: ColorTheme.gray_100,
                                                  context: context,
                                                ),
                                                TitanTextSpan(
                                                  text: 'administrador',
                                                  color: ColorTheme.white,
                                                  context: context,
                                                ),
                                                TitanTextSpan(
                                                  text: ' da sua EJ.',
                                                  color: ColorTheme.gray_100,
                                                  context: context,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
