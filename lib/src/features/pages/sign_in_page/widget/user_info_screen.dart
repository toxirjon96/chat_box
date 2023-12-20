import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/style/app_colors.dart';
import '../../../../common/style/app_insets.dart';
import '../../../dependencies/widget/dependencies_scope.dart';
import '../../main_page/main_page.dart';
import '../bloc/user_data_bloc/user_info_bloc.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late final TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();
  String? imageUrl;

  late final UserInfoBloc bloc;

  Future<void> showPickerDialog() async {
    final result = await showDialog<File?>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: const Text('Choose your option'),
        actions: [
          TextButton(
            onPressed: () => pickImage(ImageSource.gallery),
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => pickImage(ImageSource.camera),
            child: const Text('Camera'),
          ),
        ],
      ),
    );

    if (result != null) {
      final fileName = result.path.split('/').last;
      final byteData = await result.readAsBytes();

      bloc.add(
        UserInfoEvent.upload(
          fileName: fileName,
          imageByteData: byteData,
        ),
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);

    if (xFile != null) {
      final file = File(xFile.path);

      if (context.mounted) {
        Navigator.pop<File>(context, file);
      }
      return;
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void saveData() {
    if (imageUrl != null) {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        bloc.add(
          UserInfoEvent.save(
            displayName: nameController.text.trim(),
            avatarImageUrl: imageUrl!,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select image'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bloc = UserInfoBloc(
      repository: DependenciesScope.of(context).authorizationRepository,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    bloc.close();
    super.dispose();
  }

  /* #endregion */

  @override
  Widget build(BuildContext context) => BlocProvider<UserInfoBloc>.value(
        value: bloc,
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome To Chat Box',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppInsets.leftAndRightPadding,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please select your image*',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                  bloc: bloc,
                  builder: (BuildContext context, UserInfoState state) {
                    return Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightMainColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: SizedBox.expand(
                          child: GestureDetector(
                            onTap: showPickerDialog,
                            child: imageUrl != null
                                ? CachedNetworkImage(
                                  imageUrl: imageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                                : Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.upload_file,
                                      color:
                                          Theme.of(context).colorScheme.background,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.leftAndRightPadding),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Display name would be at least 3 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          labelText: 'Name',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: saveData,
                  child: BlocConsumer<UserInfoBloc, UserInfoState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is ImageUploadedUserState) {
                        imageUrl = state.imageUrl;
                      }
                      if (state is SaveUserInfoState) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MainPage(
                              user: state.user,
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ErrorUserState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                            ),
                          ),
                        );
                      }
                      if (state is LoadingUserState) {
                        return const SizedBox.square(
                          dimension: 50,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: RepaintBoundary(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text(
                          'Save',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
