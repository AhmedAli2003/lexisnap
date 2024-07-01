class WordNotifierTransactionResult {
  final bool success;
  final String message;

  const WordNotifierTransactionResult(this.success, this.message);

  factory WordNotifierTransactionResult.stateIsNull() {
    return const WordNotifierTransactionResult(false, 'state is null');
  }

  factory WordNotifierTransactionResult.itemAlreadyExists() {
    return const WordNotifierTransactionResult(false, 'item already exists');
  }

  factory WordNotifierTransactionResult.itemDoesNotExist() {
    return const WordNotifierTransactionResult(false, 'item does not exist');
  }

  factory WordNotifierTransactionResult.success() {
    return const WordNotifierTransactionResult(true, 'success');
  }

  factory WordNotifierTransactionResult.unknownError() {
    return const WordNotifierTransactionResult(false, 'Unknown error happened');
  }
}
