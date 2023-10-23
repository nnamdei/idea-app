import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/modules/auth/provider/register_provider.dart';
import 'package:idea/modules/shared/navigation_utils.dart';
import 'package:idea/modules/shared/view_state.dart';
import 'package:idea/modules/shared/widgets/custom_button.dart';
import 'package:idea/modules/shared/widgets/custom_snacbar.dart';
import 'package:idea/modules/shared/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<RegisterProvider>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'Create User',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: model.emailController,
                  borderRadius: BorderRadius.circular(12),
                  textInputType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormmater: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  hintText: 'Enter username',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    } else if (value.length < 6) {
                      return 'Username is less than six characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  onSaved: (value) {
                    model.updateButtonState(value!);
                  },
                  controller: model.passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormmater: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  obscureText: model.isVisiblePassword,
                  borderRadius: BorderRadius.circular(12),
                  suffixIcon: GestureDetector(
                    onTap: model.visiblePassword,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14.0, right: 16),
                      child: Container(
                        child: Text(model.isVisiblePassword ? 'show' : 'hide'),
                      ),
                    ),
                  ),
                  hintText: 'Enter password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password is less than six characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                model.appState == AppState.loading
                    ? const Center(child: CupertinoActivityIndicator())
                    : Center(
                        child: CustomButton(
                          height: 48,
                          color: Colors.black,
                          title: 'Sign up',
                          isActive: model.emailController.text.isNotEmpty &&
                              model.passwordController.text.isNotEmpty,
                          onPress: model.isButtonEnabled
                              ? () async {
                                  // final user = User(
                                  //     username: model.emailController.text,
                                  //     password: model.passwordController.text);
                                  // model.register(user);
                                  model.saveUserToDb(
                                      model.emailController.text.trim(),
                                      model.passwordController.text.trim());
                                  openIdeaHomeScreen(context);
                                  model.emailController.clear();
                                  model.passwordController.clear();

                                  //
                                }
                              : null,
                        ),
                      ),
                const SizedBox(height: 32),
                GestureDetector(
                    onTap: () {
                      openLoginScreen(context);
                    },
                    child: Center(child: Text('Login'))),
              ],
            ),
          ),
        );
      }),
    );
  }
}
