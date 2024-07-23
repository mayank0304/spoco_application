import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spoco_app/model/turf.dart';// Import your Turf model

class TurfService {
  // String? userID;
  CollectionReference? turfCollection;

  TurfService() {
    turfCollection =
        FirebaseFirestore.instance.collection("turfs");
  }

  // Add a Turf to the Firestore database
  addTurf(Turf turf) {
    turfCollection!.add(turf.toMap());
  }

  // Update an existing Turf in the Firestore database
  updateTurf(Turf turf, String docID) {
    turfCollection!.doc(docID).update(turf.toMap());
  }

  // Delete a Turf from the Firestore database
  deleteTurf(String docID) {
    turfCollection!.doc(docID).delete();
  }

  // Fetch all Turfs from the Firestore database
  Future<List<Turf>> getTurfs() async {
    QuerySnapshot querySnapshot = await turfCollection!.get();
    return querySnapshot.docs.map((doc) => Turf.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
