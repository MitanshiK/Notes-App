
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBookController extends GetxController{

final notebookController=TextEditingController().obs;
final selected = "assets/moonTower2.webp".obs;

void getCover(String cover){
  selected(cover);
}

}