abstract class PaymentStates {}

class PaymentInitalState extends PaymentStates {}
class PaymentLoading extends PaymentStates {}
class PaymentLinkDone extends PaymentStates {}
class RequestPaymentLoading extends PaymentStates {}
class RequestPaymentDone extends PaymentStates {}
class RequestPaymentFailed extends PaymentStates {}
class PaymentSuccess extends PaymentStates {}
class PaymentError extends PaymentStates {}
class PaymentFailed extends PaymentStates {}



