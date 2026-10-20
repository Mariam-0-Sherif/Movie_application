// لو الـ MovieModel في فايل تاني، متنساش تعمله import
// import '../data/models/movie_model.dart';

abstract class HomeState {}

// 1. الحالة المبدئية أول ما البلوك يشتغل
class HomeInitial extends HomeState {}

// 2. حالة التحميل (عشان نظهر مؤشر تحميل في الشاشة)
class HomeLoading extends HomeState {}

// 3. حالة النجاح (ودي بتشيل لستة الأفلام اللي رجعت من الـ API)
class HomeSuccess extends HomeState {
  final List<dynamic> movies; // هنخليها dynamic مؤقتاً أو MovieModel لو عملته

  HomeSuccess(this.movies);
}

// 4. حالة الفشل (ودي بتشيل رسالة الغلط عشان نعرضها لليوزر)
class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}
