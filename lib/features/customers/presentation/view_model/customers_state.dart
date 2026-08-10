import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object?> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersError extends CustomersState {
  final String message;

  const CustomersError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetUsersSuccess extends CustomersState {
  final List<UserEntity> allUsers;
  final List<UserEntity> filteredUsers;
  final String searchQuery;
  final String? selectedRole;

  const GetUsersSuccess({
    required this.allUsers,
    required this.filteredUsers,
    this.searchQuery = '',
    this.selectedRole,
  });

  GetUsersSuccess copyWith({
    List<UserEntity>? allUsers,
    List<UserEntity>? filteredUsers,
    String? searchQuery,
    String? selectedRole,
    bool clearRole = false,
  }) {
    return GetUsersSuccess(
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRole: clearRole ? null : (selectedRole ?? this.selectedRole),
    );
  }

  @override
  List<Object?> get props => [allUsers, filteredUsers, searchQuery, selectedRole];
}

/// Profile details states
class UserProfileLoading extends CustomersState {}

class UserProfileSuccess extends CustomersState {
  final UserEntity user;

  const UserProfileSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserProfileError extends CustomersState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Email availability states
class EmailAvailabilityInitial extends CustomersState {}

class EmailAvailabilityLoading extends CustomersState {}

class EmailAvailabilityChecked extends CustomersState {
  final bool isAvailable;
  final String email;

  const EmailAvailabilityChecked({
    required this.isAvailable,
    required this.email,
  });

  @override
  List<Object?> get props => [isAvailable, email];
}

class EmailAvailabilityError extends CustomersState {
  final String message;

  const EmailAvailabilityError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Create admin states
class CreateAdminLoading extends CustomersState {}

class CreateAdminSuccess extends CustomersState {
  final UserEntity user;

  const CreateAdminSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class CreateAdminError extends CustomersState {
  final String message;

  const CreateAdminError(this.message);

  @override
  List<Object?> get props => [message];
}
