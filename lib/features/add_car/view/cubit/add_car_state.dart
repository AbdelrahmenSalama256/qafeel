class AddCarState {
  final String? carType;
  final int visibleNumbersCount;
  final int visibleLettersCount;

  final String? carModel;
  final String? manufacturingYear;
  final String? carColor;
  final List<String> plateLetters;
  final List<String> plateNumbers;
  final List<String> carImages;
  final bool isSubmitting;
  final bool isSubmitted;

  const AddCarState({
    this.carType,
    this.carModel,
    this.manufacturingYear,
    this.carColor,
    this.plateLetters = const [],
    this.plateNumbers = const [],
    this.carImages = const [],
    this.isSubmitting = false,
    this.visibleNumbersCount = 3,
    this.visibleLettersCount = 3,
    this.isSubmitted = false,
  });

  AddCarState copyWith({
    String? carType,
    int? visibleNumbersCount,
    int? visibleLettersCount,
    String? carModel,
    String? manufacturingYear,
    String? carColor,
    List<String>? plateLetters,
    List<String>? plateNumbers,
    List<String>? carImages,
    bool? isSubmitting,
    bool? isSubmitted,
  }) {
    return AddCarState(
      carType: carType ?? this.carType,
      carModel: carModel ?? this.carModel,
      manufacturingYear: manufacturingYear ?? this.manufacturingYear,
      carColor: carColor ?? this.carColor,
      plateLetters: plateLetters ?? this.plateLetters,
      plateNumbers: plateNumbers ?? this.plateNumbers,
      carImages: carImages ?? this.carImages,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      visibleNumbersCount: visibleNumbersCount ?? this.visibleNumbersCount,
      visibleLettersCount: visibleLettersCount ?? this.visibleLettersCount,
    );
  }
}

class AddCarInitial extends AddCarState {}
