
import 'package:get/get.dart';
import 'package:notes_app/create_notebook/create_book_controller.dart';

// for dependency injection
//creating a new StoreBinding class and implementing Bindings. Inside its default dependencies, you need 
//to lazyPut the StoreController by using Get.lazyPut(). Secondly, you need to add the binding class inside the
//initialBinding property in GetMaterialWidget.

class BindingClass implements Bindings{

  @override
  void dependencies() {
   Get.lazyPut(()=> CreateBookController());
  }

}