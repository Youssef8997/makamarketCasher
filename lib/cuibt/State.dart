abstract class CasherState{}
  class initState extends CasherState{}
  class ChangeIndex extends CasherState{}
  class ChangeValuee extends CasherState{}
  class ChangeSearchAbilty extends CasherState{}
  class OpenDatabase extends CasherState{}
  class CreateDataBaseSuccessfully extends CasherState{}
  class CreateDataBaseError extends CasherState{}
  class GetDataProductsSuccessfully extends CasherState{}
  class GetDataSupplayersSuccessfully extends CasherState{}
  class GetDataInvoiceSucssesful extends CasherState{}
  class GetDataProductsBaseError extends CasherState{}
  class InsertProductSuccessfully extends CasherState{}
  class InsertProductError extends CasherState{}
  class SetState extends CasherState{}
  class InsertValueIntoControlar extends CasherState{}
  class UpdateProducts extends CasherState{}
  class DeleteProducts extends CasherState{}
  class SureItemNotFound extends CasherState{}
  class SureItemFound extends CasherState{}
  class returnToPage extends CasherState{}
  class InsertIntoOrder extends CasherState{}
  class ErrorInsertIOrder extends CasherState{}
  class DeleteItemOrder extends CasherState{}
  class InsertIntoCashier extends CasherState{}
  class UpdateNumItem extends CasherState{}
  class ChangeSelected extends CasherState{}
  class GetSearchItem extends CasherState{}
  class RecordOrderSuccessfullyl extends CasherState{}
  class RecordOrderError extends CasherState{}
  class calcRiciet extends CasherState{}
class GetRecites extends CasherState{}
class GetReciteError extends CasherState{}
class GetEmployeeAttendance extends CasherState{}
class InsertEmployeeSuccessfully extends CasherState{}
class InsertEmployeeError extends CasherState{}
class InsertDateEmployeeError extends CasherState{}
class InsertDateEmployeeSuccessfully extends CasherState{}
class ChangeEmpo extends CasherState{}
class GetEmployeeSuccessfully extends CasherState{}
class deleteEmpo extends CasherState{}
class ChangeObs extends CasherState{}

//FirebaseState
class CreateBaseUserProfileTr extends CasherState{}
class CreateBaseUserProfileFa extends CasherState{
  final String error;
  CreateBaseUserProfileFa(this.error);
}
class SignInTr extends CasherState{}
class SignInFa extends CasherState{
  final Error;
  SignInFa(this.Error);}
class SignOut extends CasherState{}


