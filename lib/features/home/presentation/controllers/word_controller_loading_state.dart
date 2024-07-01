class WordLoadingState {
  final bool getWordsOverview;
  final bool getAllWords;
  final bool getWordById;
  final bool createWord;
  final bool updateWord;
  final bool deleteWord;

  const WordLoadingState({
    this.getWordsOverview = false,
    this.getAllWords = false,
    this.getWordById = false,
    this.createWord = false,
    this.updateWord = false,
    this.deleteWord = false,
  });

  WordLoadingState copyWith({
    bool? getWordsOverview,
    bool? getAllWords,
    bool? getWordById,
    bool? createWord,
    bool? updateWord,
    bool? deleteWord,
  }) {
    return WordLoadingState(
      getWordsOverview: getWordsOverview ?? this.getWordsOverview,
      getAllWords: getAllWords ?? this.getAllWords,
      getWordById: getWordById ?? this.getWordById,
      createWord: createWord ?? this.createWord,
      updateWord: updateWord ?? this.updateWord,
      deleteWord: deleteWord ?? this.deleteWord,
    );
  }
}
