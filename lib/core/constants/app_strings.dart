class AppStrings {
  // 🏢 العناوين الرئيسية والـ App Bar
  static const String productsManagement = 'Products Management';
  static const String manageProductSubheadline =
      'Manage your product listings, pricing, and availability.';
  static const String addNewProduct = 'Add New Product';
  static const String categoriesManagement = 'Categories Management';
  static const String manageCategoriesSubheadline =
      'Manage your category listings, images, and products.';
  static const String addNewCategory = 'Add New Category';
  static const String noProductsFoundInCategory =
      'No products found in this category';
  static const String backToCategories = 'Back to Categories';
  static const String categoryUnexpectedStateMessage =
      'Unexpected state or something went wrong';
  static const String reloadCategories = 'Reload Categories';
  static const String deleteCategoryTitle = 'Delete Category';
  static const String deleteCategoryConfirmation =
      'Are you sure you want to delete this category? This action cannot be undone.';
  static const String delete = 'Delete';
  static const String addCategoryTitle = 'Add Category';
  static const String updateCategoryTitle = 'Update Category';
  static const String categoryNameLabel = 'Category Name *';
  static const String categoryNameHint = 'e.g. Electronics';
  static const String categoryImageLabel = 'Category Image';
  static const String saveCategory = 'Save Category';

  // 🧾 Orders feature strings
  static const String ordersManagement = 'Orders Management';
  static const String manageOrdersSubheadline =
      'Monitor and manage global sales transactions in real-time.';
  static const String exportCsv = 'Export CSV';
  static const String newOrder = 'New Order';
  static const String recentOrders = 'Recent Orders';
  static const String noOrderSelectedTitle = 'Select an order to view details';
  static const String noOrderSelectedSubtitle =
      'Tap any order card from the left panel to review order details, payment breakdown, and customer information.';
  static const String printReceipt = 'Print Receipt';
  static const String updateStatus = 'Update Status';
  static const String orderItems = 'Order Items';
  static const String paymentSummary = 'Payment Summary';
  static const String subtotal = 'Subtotal';
  static const String shippingFees = 'Shipping';
  static const String taxFees = 'Tax fees';
  static const String totalAmount = 'Total amount';
  static const String visaEnding = 'Visa ending 4310';
  static const String transactionId = 'Transaction ID: ';
  static const String paidStatus = 'PAID';
  static const String customerProfile = 'Customer Profile';
  static const String shippingAddress = 'Shipping Address';
  static const String viewFullCustomerProfile = 'View Full Customer Profile';
  static const String quantityPrefix = 'Qty';
  // static const String visaEnding = 'Visa ending 4310';
  static const String transactionIdPrefix = 'Transaction ID:';
  static const String justNow = 'Just now';
  static const String showingOrders = 'Showing 1 to 10 of 420 orders';
  static const String noOrdersAvailable = 'No orders available.';
  static const String tryAgain = 'Try Again';
  static const String itemsLabel = 'items';
  static const String placedLabel = 'Placed';
  static const String orderIdLabel = 'ORDER ID';
  static const String dateLabel = 'DATE';
  static const String customerLabel = 'CUSTOMER';
  static const String amountLabel = 'AMOUNT';
  static const String paymentLabel = 'PAYMENT';
  static const String statusLabel = 'STATUS';
  static const String actionsLabel = 'ACTIONS';

  // 🔍 خانة البحث والفلتر
  static const String searchProductsHint = 'Search products...';
  static const String filterButtonText = 'Filter';

  // 📭 الـ Empty State والـ Errors
  static const String noResultsFound = 'No results found';
  static const String noResultsDescription =
      "We couldn't find what you're looking for. Try checking the spelling or using different keywords.";
  static const String somethingWentWrong = 'Something went wrong';

  // 🔔 رسائل الـ Toasts والـ Notifications
  static const String productDeletedTitle = 'Product Deleted ✅🗑️';
  static const String productDeletedDesc =
      'Product has been removed successfully';

  static const String productAddedTitle = 'Product Added ✅';
  static const String productAddedDesc = 'Product has been Added successfully';

  static const String productUpdatedTitle = 'Product Updated ✅';
  static const String productUpdatedDesc =
      'Product has been Updated successfully';

  static const String errorFetchingProducts = 'Error Fetching Products';
  static const String updateProduct = 'Update Product';
  static const String addNewProductTitle = 'Add New Product';
  static const String productTitleLabel = 'Product Title *';
  static const String productTitleHint =
      'e.g. Wireless Noise-Cancelling Headphones';
  static const String priceUsdLabel = 'Price (USD) *';
  static const String priceHint = r'$ 0.00';
  static const String categoryLabel = 'Category';
  static const String selectCategoryHint = 'Select a category...';
  static const String descriptionLabel = 'Description';
  static const String descriptionHint =
      'Enter a detailed description of the product...';
  static const String productImagesLabel = 'Product Images';
  static const String imagePickerLabel = 'Click to upload or drag and drop';
  static const String imagePickerSubLabel =
      'Main Product Image (max. 800×400px)';
  static const String cancel = 'Cancel';
  static const String saveProduct = 'Save Product';

  // 💬 ميزة المحادثات (Chat Feature)
  static const String messages = 'Messages';
  static const String searchMessagesHint = 'Search messages...';
  static const String selectChatToStartMessaging =
      'Select a chat to start messaging';
  static const String customerDefaultName = 'Customer';
  static const String online = 'Online';
  static const String customerIdPrefix = 'Customer ID: ';
  static const String typeMessageHint = 'Type a message...';
  static const String addNoteOrSendProductHint =
      'Add a note or send this product...';
  static const String attachedProductLabel = 'Attached Product';
  static const String attachProductTooltip = 'Attach Product';
  static const String removeAttachmentTooltip = 'Remove Attachment';
  static const String selectProductToAttachTitle =
      'Select a Product to Attach';
  static const String selectProductToAttachSubtitle =
      'Choose a product from your catalog to share with customer';
  static const String retry = 'Retry';
  static const String defaultProductAttachmentTitle =
      'Wireless Noise-Cancelling Headphones';
  static const String defaultAdminId = 'admin';
  static const String defaultAdminName = 'Admin';
  static const String noProductsFound = 'No products found';

  // 👥 Users & Customers Feature Strings
  static const String usersManagement = 'Users & Customers Management';
  static const String manageUsersSubheadline =
      'Manage customer profiles, administrative access, and role permissions.';
  static const String searchUsersHint = 'Search users by name, email, or ID...';
  static const String allUsers = 'All Users';
  static const String adminsOnly = 'Admins';
  static const String customersOnly = 'Customers';
  static const String addNewAdmin = 'Add New Admin';
  static const String userProfileTitle = 'User Profile Details';
  static const String noUsersFoundTitle = 'No users found';
  static const String noUsersFoundSubtitle =
      'Try searching with a different keyword or change role filter.';
  static const String reloadUsers = 'Reload Users';
  static const String viewProfile = 'View Profile';
  static const String adminCreatedSuccessTitle = 'Admin Created Successfully ✅';
  static const String adminCreatedSuccessDesc =
      'The new administrator account has been added.';
  static const String emailAvailableText = 'Email is available';
  static const String emailTakenText = 'This email is already registered';
  static const String checkingEmailText = 'Checking email availability...';
  static const String adminRole = 'Admin';
  static const String customerRole = 'Customer';
  static const String nameLabel = 'Full Name *';
  static const String nameHint = 'e.g. Nicolas Cage';
  static const String emailLabel = 'Email Address *';
  static const String emailHint = 'e.g. nico@gmail.com';
  static const String passwordLabel = 'Password *';
  static const String passwordHint = 'At least 4 characters';
  static const String avatarUrlLabel = 'Avatar URL *';
  static const String avatarUrlHint = 'https://picsum.photos/800';
  static const String createAdminButton = 'Create Admin Account';
  static const String close = 'Close';
  static const String userDetailsError = 'Failed to load user profile details';
}

