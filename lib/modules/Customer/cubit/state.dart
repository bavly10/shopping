abstract class CustomerStates {}

class Customer_InitalState extends CustomerStates {}

class ProductCustomerLoading extends CustomerStates {}

class ProductCustomerDone extends CustomerStates {}

class ProductCustomerFail extends CustomerStates {}

class ShopChangeMens extends CustomerStates {}

class ShopColorsWomMen extends CustomerStates {}

class ShopColorsBaby extends CustomerStates {}

class TakeImageState extends CustomerStates {}

class LoadingShowCustomer extends CustomerStates {}

class ShowingCustomerData extends CustomerStates {}

class FailShowCustomerData extends CustomerStates {}

class WaitingCustomerUpdtatingState extends CustomerStates {}

class CustomerUpdatingSucessState extends CustomerStates {}

class CustomerUpdatingErrorState extends CustomerStates {}
