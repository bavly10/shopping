abstract class CustomerStates {}

class Customer_InitalState extends CustomerStates {}

class ProductCustomerLoading extends CustomerStates {}
class ProductCustomerDone extends CustomerStates {}
class ProductCustomerFail extends CustomerStates {}