import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/modules/auth/provider/login_provider.dart';
import 'package:idea/modules/shared/navigation_utils.dart';
import 'package:idea/modules/shared/view_state.dart';
import 'package:idea/modules/shared/widgets/custom_button.dart';
import 'package:idea/modules/shared/widgets/custom_snacbar.dart';
import 'package:idea/modules/shared/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        
      ),
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(builder: (context, model, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                const Text('Login', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),),
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
                    }else if (value.length < 6) {
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
                          title: 'Login',
                          isActive: model.emailController.text.isNotEmpty &&
                              model.passwordController.text.isNotEmpty,
                          onPress: model.isButtonEnabled
                              ? () async {
                                  bool isSubmitted = await model.login(
                                      model.emailController.text.trim(),
                                      model.passwordController.text.trim());
                                  if (isSubmitted) {
                                    openIdeaHomeScreen(context);
                                  } else {
                                    snackBar(
                                        context: context,
                                        title: 'Error',
                                        message: model.message ??
                                            'An error occurred',
                                        isError: true);
                                  }
                                }
                              : null,
                        ),
                      ),
                const SizedBox(height: 32),
                GestureDetector(
                    onTap: () {
                      openRegisterScreen(context);
                    },
                    child: Center(child: Text('Create user'))),
              ],
            ),
          ),
        );
      }),
    );
  }
}
