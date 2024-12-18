
import 'package:notes_app/database/art_db_helper.dart';
import 'package:notes_app/drawing_view/model/art_model.dart';
import 'package:riverpod/riverpod.dart';

final allArtNotifierProvider =
    NotifierProvider<AllArtNotifier, Map<String, dynamic>>(() {
  return AllArtNotifier();
});


class AllArtNotifier extends Notifier<Map<String,dynamic>>{

  List<ArtModal> artList = [];

  @override
  Map<String, dynamic> build() {
   return {
     "artList": artList,
        };
  }

  void update(){
   state={
    ...state,
    "artList": artList,

   };
  }

    fetchNotes() async {
    final notesMaps = await ArtDbHelper.instance.queryAllArt();
    var list;
      list = notesMaps.map((userMap) => ArtModal.fromMap(userMap)).toList(); 
      print("first item in artlist is ${list[0]}");
      artList.clear();
      for(ArtModal item in list){
          artList.add(item);
      }
      update();
  }

  fetchOne() async{
    final notesMaps = await ArtDbHelper.instance.queryOne();
     var list = notesMaps.map((userMap) => ArtModal.fromMap(userMap)).toList(); 
    
  }

}