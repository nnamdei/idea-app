import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idea/modules/idea/provider/idea_provider.dart';
import 'package:idea/modules/shared/navigation_utils.dart';
import 'package:idea/modules/shared/view_state.dart';
import 'package:idea/modules/shared/widgets/custom_button.dart';
import 'package:idea/modules/shared/widgets/custom_snacbar.dart';
import 'package:idea/modules/shared/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddIdea extends StatelessWidget {
  const AddIdea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add idea",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Consumer<IdeaProvider>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                CustomTextField(
                  controller: model.titleController,
                  borderRadius: BorderRadius.circular(12),
                  textInputType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // inputFormmater: [
                  //   FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  // ],
                  hintText: 'Enter idea title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title is required';
                    } else if (value.length < 3) {
                      return 'Title is less than three characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  onSaved: (value) {
                    model.updateButtonState(value!);
                  },
                  controller: model.descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  borderRadius: BorderRadius.circular(12),
                  hintText: 'Enter idea description',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description is required';
                    } else if (value.length < 6) {
                      return 'Description is less than six characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                model.appState == AppState.loading
                    ? const Center(child: CupertinoActivityIndicator())
                    : Center(
                        child: CustomButton(
                            height: 48,
                            color: Colors.black,
                            title: 'Save',
                            isActive: model.titleController.text.isNotEmpty &&
                                model.descriptionController.text.isNotEmpty,
                            onPress: model.isButtonEnabled
                                ? () async {
                                    if (model.titleController.text.isEmpty ==
                                        true) {
                                      return snackBar(
                                          context: context,
                                          message: 'Idea title is required',
                                          title: 'error',
                                          isError: true);
                                    } else if (model.descriptionController.text
                                            .isEmpty ==
                                        true) {
                                      return snackBar(
                                          context: context,
                                          message: 'Description is required',
                                          title: 'error',
                                          isError: true);
                                    }
                                    model.saveIdeaToDb(
                                        model.descriptionController.text.trim(),
                                        model.titleController.text.trim());
                                    // if (model.isCreated == true) {
                                    openIdeaHomeScreen(context);
                                    model.descriptionController.clear();
                                    model.titleController.clear();
                                    // } else {
                                    //   snackBar(
                                    //       context: context,
                                    //       message: 'Idea not created',
                                    //       title: 'Message',
                                    //       isError: true);
                                    // }
                                  }
                                : null),
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
