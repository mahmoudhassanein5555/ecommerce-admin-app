abstract class Appexception implements Exception {
  Appexception(this.errormessage);
  final String errormessage;
}

class RemoteException extends Appexception {
  RemoteException(super.errormessage);
}

class LocalException extends Appexception {
  LocalException(super.errormessage);
}
