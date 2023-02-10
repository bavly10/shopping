abstract class CustomerStates {}

class Customer_InitalState extends CustomerStates {}



class ShopChangeMens extends CustomerStates {}

class ShopColorsWomMen extends CustomerStates {}

class ShopColorsBaby extends CustomerStates {}

class SearchingProduct extends CustomerStates {}

class TakeImageState extends CustomerStates {}

class WaitingCustomerUpdtatingState extends CustomerStates {}

class CustomerUpdatingSucessState extends CustomerStates {}
class CustomerUpdatingErrorDataState extends CustomerStates {final String error;

  CustomerUpdatingErrorDataState(this.error);}

class CustomerUpdatingErrorState extends CustomerStates {}

class Loadingchecking extends CustomerStates {}

class CheckingCustomerSucessState extends CustomerStates {}

class CheckingCustomerErrorState extends CustomerStates {}

class InsertCustomerLoadingState extends CustomerStates {}
class InsertCustomerSucessState extends CustomerStates {}

class InsertCustomerErrorState extends CustomerStates {}

class ConnectingShopSuecssState extends CustomerStates {}

class ConnectingShopErrorState extends CustomerStates {}

class GettingStatisticSucess extends CustomerStates {}
class GettingStatisticLoading extends CustomerStates {}
class GettingStatisticError extends CustomerStates {}

