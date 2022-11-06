abstract class CustomerOrderStates {}

class CustomerOrder_InitalState extends CustomerOrderStates {}

class CustomerOrderLoading extends CustomerOrderStates {}

class CustomerGetOrderDone extends CustomerOrderStates {}

class CustomerGetOrderFail extends CustomerOrderStates {}

class CustomerOrderError extends CustomerOrderStates {}

class ChangeSelcect extends CustomerOrderStates {}
class SearchingCustomer extends CustomerOrderStates {}
class GetNewOrderCustomer extends CustomerOrderStates {}
class UpdateOrderCustomerLoading extends CustomerOrderStates {}
class UpdateOrderCustomerDone extends CustomerOrderStates {}
class UpdateOrderCustomerFail extends CustomerOrderStates {}
class ListCustomerdone extends CustomerOrderStates {}
