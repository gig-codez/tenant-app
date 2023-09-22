import "/exports/exports.dart";

class PropertyController extends Cubit {
  PropertyController() : super([]);
  void fetchProperties() {
    // FirebaseFirestore.instance.collection("properties").get().then((value) {
    //   emit(value.docs);
    // });
  }
}
