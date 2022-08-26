abstract class CustomerStates {}

class Customer_InitalState extends CustomerStates {}

class ProductCustomerLoading extends CustomerStates {}

class ProductCustomerDone extends CustomerStates {}
class ProductCustomerDonePagi extends CustomerStates {}
class ProductCustomerNull extends CustomerStates {}
class ProductCustomerNullPagi extends CustomerStates {}
class ProductCustomerFail extends CustomerStates {}
class ProductCustomerFailPagi extends CustomerStates {}

class ShopChangeMens extends CustomerStates {}

class ShopColorsWomMen extends CustomerStates {}

class ShopColorsBaby extends CustomerStates {}

class SearchingProduct extends CustomerStates {}

class TakeImageState extends CustomerStates {}

class LoadingShowCustomer extends CustomerStates {}

class ShowingCustomerData extends CustomerStates {}

class FailShowCustomerData extends CustomerStates {}

class WaitingCustomerUpdtatingState extends CustomerStates {}

class CustomerUpdatingSucessState extends CustomerStates {}

class CustomerUpdatingErrorState extends CustomerStates {}

class Loadingchecking extends CustomerStates {}

class CheckingCustomerSucessState extends CustomerStates {}

class CheckingCustomerErrorState extends CustomerStates {}

class InsertCustomerSucessState extends CustomerStates {}

class InsertCustomerErrorState extends CustomerStates {}

class ConnectingShopSuecssState extends CustomerStates {}

class ConnectingShopErrorState extends CustomerStates {}

class LoadingLatestProduct extends CustomerStates {}

class GettingLatestProductSucess extends CustomerStates {}
class GettingStatisticSucess extends CustomerStates {}
class GettingStatisticLoading extends CustomerStates {}

class GettingLatestProductError extends CustomerStates {}
class GettingStatisticError extends CustomerStates {}
