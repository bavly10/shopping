abstract class ProductStates {}

class ProductShop_InitalState extends ProductStates {}

class ProductChangeSCreens extends ProductStates {}

class TakeImage_State extends ProductStates {}

class ChangeCheckedState extends ProductStates {}

class ChangeCheckedsState extends ProductStates {}

class ChangeCheckedssState extends ProductStates {}

class ChangeCheckedSssstate extends ProductStates {}

class AddAmount extends ProductStates {}

class MinusAmount extends ProductStates {}

class ChangeCheckedSstate extends ProductStates {}

class ChangeCheckedSswtate extends ProductStates {}

class ChangeCheckedSsztate extends ProductStates {}

class Changestate extends ProductStates {}


class loadingProduct extends ProductStates {}
class ShowingProduct extends ProductStates {}
class failProduct extends ProductStates {}

class DeletingImageProduct extends ProductStates {}

class UpdatingSueccs extends ProductStates {}
class UpdatingError extends ProductStates {final String error;

  UpdatingError(this.error);}
class UpdatingProductError extends ProductStates {final String error;

UpdatingProductError(this.error);}

class CreatingSueccs extends ProductStates {}

class CreatingError extends ProductStates {}

class GettingProductData extends ProductStates {}

class GettingProductDataNull extends ProductStates {}

class GettingProductDataError extends ProductStates {}

class GettingProductDataLoading extends ProductStates {}

class GettingLogoutDone extends ProductStates {}

class GettingLogoutError extends ProductStates {}

class ShopAddItems extends ProductStates {}

class ShopRemoveItems extends ProductStates {}

class ShopRemoveItem extends ProductStates {}

class ShopChangeplus extends ProductStates {}

class ShopChangeminus extends ProductStates {}

class ChooseSize extends ProductStates {}

class InsertOrderLoadingState extends ProductStates {}
class InsertOrderSucessState extends ProductStates {}

class InsertOrderErrorState extends ProductStates {}

class LoadingShowCustomer extends ProductStates {}

class ShowingCustomerData extends ProductStates {}

class FailShowCustomerData extends ProductStates {}

class ShopEarnLoadingState extends ProductStates {}
class ShopEarnSuessState extends ProductStates {}

class ErrorEarnState extends ProductStates {}

class SearchingProduct extends ProductStates {}

class ChangedPrivacyyState extends ProductStates {}

class ChooseAcceptState extends ProductStates {}

class SallaPrivacyPolicyLoadingState extends ProductStates {}

class SallaPrivacyPolicySueccState extends ProductStates {}

class SallaPrivacyPolicyErrorState extends ProductStates {}
class LoadingCat extends ProductStates {}
class DoneCat extends ProductStates {}
class ErrorCat extends ProductStates {}
