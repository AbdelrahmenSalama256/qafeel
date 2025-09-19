import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());

  void updateCarType(String? value) {
    emit(state.copyWith(carType: value));
  }

  void updateCarModel(String? value) {
    emit(state.copyWith(carModel: value));
  }

  void updateManufacturingYear(String? value) {
    emit(state.copyWith(manufacturingYear: value));
  }

  void updateCarColor(String? value) {
    emit(state.copyWith(carColor: value));
  }

  void updatePlateLetter(int index, String value) {
    final updatedLetters = List<String>.from(state.plateLetters);
    if (index < updatedLetters.length) {
      updatedLetters[index] = value;
    } else {
      updatedLetters.add(value);
    }
    emit(state.copyWith(plateLetters: updatedLetters));
  }

  void updatePlateNumber(int index, String value) {
    final updatedNumbers = List<String>.from(state.plateNumbers);
    if (index < updatedNumbers.length) {
      updatedNumbers[index] = value;
    } else {
      updatedNumbers.add(value);
    }
    emit(state.copyWith(plateNumbers: updatedNumbers));
  }

  void removePlateLetter(int index) {
    final updatedLetters = List<String>.from(state.plateLetters);
    if (index < updatedLetters.length) {
      updatedLetters.removeAt(index);
    }
    emit(state.copyWith(plateLetters: updatedLetters));
  }

  void removePlateNumber(int index) {
    final updatedNumbers = List<String>.from(state.plateNumbers);
    if (index < updatedNumbers.length) {
      updatedNumbers.removeAt(index);
    }
    emit(state.copyWith(plateNumbers: updatedNumbers));
  }

  void addCarImage(String imagePath) {
    final updatedImages = List<String>.from(state.carImages)..add(imagePath);
    emit(state.copyWith(carImages: updatedImages));
  }

  void removeCarImage(int index) {
    final updatedImages = List<String>.from(state.carImages)..removeAt(index);
    emit(state.copyWith(carImages: updatedImages));
  }

  void submitCar() {
    emit(state.copyWith(isSubmitting: true));
    Future.delayed(Duration(seconds: 2), () {
      emit(state.copyWith(isSubmitting: false, isSubmitted: true));
    });
  }

  void resetForm() {
    emit(AddCarInitial());
  }

  void increaseVisibleNumbers() {
    if (state.visibleNumbersCount < 4) {
      emit(state.copyWith(visibleNumbersCount: state.visibleNumbersCount + 1));
    }
  }

  void increaseVisibleLetters() {
    if (state.visibleLettersCount < 4) {
      emit(state.copyWith(visibleLettersCount: state.visibleLettersCount + 1));
    }
  }
}
