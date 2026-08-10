import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object?> get props => [];
}

class GetUsersEvent extends CustomersEvent {
  const GetUsersEvent();
}

class GetUserByIdEvent extends CustomersEvent {
  final int id;

  const GetUserByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CheckEmailAvailabilityEvent extends CustomersEvent {
  final String email;

  const CheckEmailAvailabilityEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class ResetEmailAvailabilityEvent extends CustomersEvent {
  const ResetEmailAvailabilityEvent();
}

class CreateAdminEvent extends CustomersEvent {
  final CreateUserRequestEntity request;

  const CreateAdminEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class SearchUsersEvent extends CustomersEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterUsersByRoleEvent extends CustomersEvent {
  final String? role; // null or 'all', 'admin', 'customer'

  const FilterUsersByRoleEvent(this.role);

  @override
  List<Object?> get props => [role];
}
