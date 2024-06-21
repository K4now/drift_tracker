import '../../../drift_sessions/domain/entities/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MensureDataSource {
  Future<void> saveSession(Session session);
}

class MensureDataSourceImpl implements MensureDataSource {
  final FirebaseFirestore firestore;

  MensureDataSourceImpl(this.firestore);

  @override
  Future<void> saveSession(Session session) async {
    await firestore.collection('sessions').doc(session.id).set(session.toMap());
  }
}
