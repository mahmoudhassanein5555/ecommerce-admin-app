import 'package:ecommerce_admin_app/core/common/widgets/custom_text_form_field.dart';
import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/dialogs/app_toasts.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/email_availability_feedback_banner.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/email_availability_status_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/form_field_label.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_role_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AddAdminDialog extends StatefulWidget {
  const AddAdminDialog({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = BlocProvider.of<CustomersBloc>(context);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: bloc,
          child: const AddAdminDialog(),
        );
      },
    );
  }

  @override
  State<AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<AddAdminDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  bool? _isEmailAvailable;
  String _lastCheckedEmail = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _triggerEmailAvailabilityCheck();
      }
    });
  }

  void _triggerEmailAvailabilityCheck() {
    final email = _emailController.text.trim();
    if (email.isNotEmpty && email.contains('@') && email != _lastCheckedEmail) {
      _lastCheckedEmail = email;
      context.read<CustomersBloc>().add(CheckEmailAvailabilityEvent(email));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_isEmailAvailable == false) {
      AppToast.showToast(
        context: context,
        title: 'Invalid Email',
        description: AppStrings.emailTakenText,
        type: ToastificationType.error,
      );
      return;
    }

    final request = CreateUserRequestEntity(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      avatar: 'https://picsum.photos/800',
      role: 'admin',
    );

    context.read<CustomersBloc>().add(CreateAdminEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 540.w, maxHeight: 680.h),
        child: BlocConsumer<CustomersBloc, CustomersState>(
          listenWhen: (prev, curr) =>
              curr is CreateAdminSuccess ||
              curr is CreateAdminError ||
              curr is EmailAvailabilityChecked ||
              curr is EmailAvailabilityError,
          listener: (context, state) {
            if (state is EmailAvailabilityChecked) {
              setState(() {
                _isEmailAvailable = state.isAvailable;
              });
            } else if (state is EmailAvailabilityError) {
              setState(() {
                _isEmailAvailable = null;
              });
            }

            if (state is CreateAdminSuccess) {
              AppToast.showToast(
                context: context,
                title: AppStrings.adminCreatedSuccessTitle,
                description: AppStrings.adminCreatedSuccessDesc,
                type: ToastificationType.success,
              );
              Navigator.of(context).pop();
            } else if (state is CreateAdminError) {
              AppToast.showToast(
                context: context,
                title: 'Failed to Create Admin',
                description: state.message,
                type: ToastificationType.error,
              );
            }
          },
          builder: (context, state) {
            final isSubmitting = state is CreateAdminLoading;

            return Padding(
              padding: EdgeInsets.all(28.0.r),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  Icons.person_add_alt_1_rounded,
                                  color: AppColors.goldAccent,
                                  size: 22.r,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                AppStrings.addNewAdmin,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  fontFamily: 'SwiftBuyHeading',
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: isSubmitting ? null : () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close, size: 22.r, color: AppColors.grey600),
                            splashRadius: 20.r,
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.borderLight),
                      SizedBox(height: 16.h),

                      // Name field
                      const FormFieldLabel(label: AppStrings.nameLabel),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: AppStrings.nameHint,
                        prefixIcon: const Icon(Icons.person_outline, size: 20, color: AppColors.iconSlate),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter administrator name';
                          }
                          if (val.trim().length < 2) {
                            return 'Name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      // Email field with real-time availability check
                      const FormFieldLabel(label: AppStrings.emailLabel),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        hintText: AppStrings.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColors.iconSlate),
                        suffixWidget: EmailAvailabilityStatusWidget(
                          state: state,
                          isEmailAvailable: _isEmailAvailable,
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter email address';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(val.trim())) {
                            return 'Please enter a valid email address';
                          }
                          if (_isEmailAvailable == false) {
                            return AppStrings.emailTakenText;
                          }
                          return null;
                        },
                      ),
                      EmailAvailabilityFeedbackBanner(
                        state: state,
                        isEmailAvailable: _isEmailAvailable,
                      ),
                      SizedBox(height: 16.h),

                      // Password field
                      const FormFieldLabel(label: AppStrings.passwordLabel),
                      SizedBox(height: 6.h),
                      CustomTextFormField(
                        controller: _passwordController,
                        isPassword: true,
                        hintText: AppStrings.passwordHint,
                        prefixIcon: const Icon(Icons.lock_outline, size: 20, color: AppColors.iconSlate),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter a password';
                          }
                          if (val.trim().length < 4) {
                            return 'Password must be at least 4 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Assigned Role Display
                      const Row(
                        children: [
                          Text(
                            'Assigned Role: ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          UserRoleBadge(
                            role: 'admin',
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          ),
                        ],
                      ),

                      SizedBox(height: 28.h),

                      // Actions Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: isSubmitting ? null : () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.borderMuted),
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                            child: Text(
                              AppStrings.cancel,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          ElevatedButton(
                            onPressed: isSubmitting ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.goldAccent,
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              elevation: 0,
                            ),
                            child: isSubmitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check, size: 18, color: Colors.white),
                                      SizedBox(width: 8.w),
                                      Text(
                                        AppStrings.createAdminButton,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
