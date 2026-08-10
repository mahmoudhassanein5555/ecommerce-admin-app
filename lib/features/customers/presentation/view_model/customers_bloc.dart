import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/check_email_availability_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/create_user_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_user_by_id_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_users_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final CheckEmailAvailabilityUseCase checkEmailAvailabilityUseCase;
  final CreateUserUseCase createUserUseCase;

  List<UserEntity> _allUsers = [];
  String _currentSearchQuery = '';
  String? _currentRoleFilter;

  CustomersBloc({
    required this.getUsersUseCase,
    required this.getUserByIdUseCase,
    required this.checkEmailAvailabilityUseCase,
    required this.createUserUseCase,
  }) : super(CustomersInitial()) {
    on<GetUsersEvent>(_onGetUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    on<FilterUsersByRoleEvent>(_onFilterUsersByRole);
    on<GetUserByIdEvent>(_onGetUserById);
    on<CheckEmailAvailabilityEvent>(_onCheckEmailAvailability);
    on<ResetEmailAvailabilityEvent>(_onResetEmailAvailability);
    on<CreateAdminEvent>(_onCreateAdmin);
  }

  Future<void> _onGetUsers(
    GetUsersEvent event,
    Emitter<CustomersState> emit,
  ) async {
    emit(CustomersLoading());
    final result = await getUsersUseCase.invoke();
    result.fold(
      (failure) => emit(CustomersError(failure.failuremessage)),
      (users) {
        _allUsers = users;
        final filtered = _filterUsers(_allUsers, _currentSearchQuery, _currentRoleFilter);
        emit(
          GetUsersSuccess(
            allUsers: _allUsers,
            filteredUsers: filtered,
            searchQuery: _currentSearchQuery,
            selectedRole: _currentRoleFilter,
          ),
        );
      },
    );
  }

  void _onSearchUsers(
    SearchUsersEvent event,
    Emitter<CustomersState> emit,
  ) {
    _currentSearchQuery = event.query.trim().toLowerCase();
    final filtered = _filterUsers(_allUsers, _currentSearchQuery, _currentRoleFilter);
    emit(
      GetUsersSuccess(
        allUsers: _allUsers,
        filteredUsers: filtered,
        searchQuery: event.query,
        selectedRole: _currentRoleFilter,
      ),
    );
  }

  void _onFilterUsersByRole(
    FilterUsersByRoleEvent event,
    Emitter<CustomersState> emit,
  ) {
    _currentRoleFilter = (event.role == null || event.role == 'all') ? null : event.role?.toLowerCase();
    final filtered = _filterUsers(_allUsers, _currentSearchQuery, _currentRoleFilter);
    emit(
      GetUsersSuccess(
        allUsers: _allUsers,
        filteredUsers: filtered,
        searchQuery: _currentSearchQuery,
        selectedRole: _currentRoleFilter,
      ),
    );
  }

  Future<void> _onGetUserById(
    GetUserByIdEvent event,
    Emitter<CustomersState> emit,
  ) async {
    emit(UserProfileLoading());
    final result = await getUserByIdUseCase.invoke(event.id);
    result.fold(
      (failure) => emit(UserProfileError(failure.failuremessage)),
      (user) => emit(UserProfileSuccess(user)),
    );
  }

  Future<void> _onCheckEmailAvailability(
    CheckEmailAvailabilityEvent event,
    Emitter<CustomersState> emit,
  ) async {
    final email = event.email.trim();
    if (email.isEmpty) {
      emit(const EmailAvailabilityChecked(isAvailable: false, email: ''));
      return;
    }
    emit(EmailAvailabilityLoading());
    final result = await checkEmailAvailabilityUseCase.invoke(email);
    result.fold(
      (failure) => emit(EmailAvailabilityError(failure.failuremessage)),
      (isAvailable) => emit(
        EmailAvailabilityChecked(
          isAvailable: isAvailable,
          email: email,
        ),
      ),
    );
  }

  void _onResetEmailAvailability(
    ResetEmailAvailabilityEvent event,
    Emitter<CustomersState> emit,
  ) {
    emit(EmailAvailabilityInitial());
  }

  Future<void> _onCreateAdmin(
    CreateAdminEvent event,
    Emitter<CustomersState> emit,
  ) async {
    emit(CreateAdminLoading());
    final result = await createUserUseCase.invoke(event.request);
    result.fold(
      (failure) => emit(CreateAdminError(failure.failuremessage)),
      (user) {
        emit(CreateAdminSuccess(user));
        // Auto-refresh users list
        add(const GetUsersEvent());
      },
    );
  }

  List<UserEntity> _filterUsers(
    List<UserEntity> users,
    String query,
    String? role,
  ) {
    return users.where((user) {
      final matchesRole = role == null || user.role.toLowerCase() == role;
      if (!matchesRole) return false;

      if (query.isEmpty) return true;

      final nameMatches = user.name.toLowerCase().contains(query);
      final emailMatches = user.email.toLowerCase().contains(query);
      final idMatches = user.id.toString() == query;

      return nameMatches || emailMatches || idMatches;
    }).toList();
  }
}
