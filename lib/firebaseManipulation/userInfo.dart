import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentID;

  const GetUserName({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference fisioterapeutas =
        FirebaseFirestore.instance.collection("fisioterapeuta");

    // print("Dentro da funçaõ");
    // print(documentID);
    // print(fisioterapeutas.where(documentID));

    return StreamBuilder<DocumentSnapshot>(
      stream: fisioterapeutas.doc(documentID).snapshots(),
      builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // print("Dentro do stream");
        // print(snapshot);

        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          //Informação carregada
          // print("Data value:  ");
          // print(snapshot.data!["nome"]);
          /* Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
          print("Data value 2:  ");
          print(data); */
          return Text('${snapshot.data!["nome"]}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ));
        }
        return const Text('Carregando Nome...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ));
      }),
    );
  }
}

class GetUserEmail extends StatelessWidget {
  final String documentID;

  const GetUserEmail({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference fisioterapeutas =
        FirebaseFirestore.instance.collection("fisioterapeuta");

    return StreamBuilder<DocumentSnapshot>(
      stream: fisioterapeutas.doc(documentID).snapshots(),
      builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          //Informação carregada
          // print("Data value:  ");
          // print(snapshot.data!["email"]);
          return Text(
              '${snapshot.data!["email"]}', //Cargo do profissional(Fisioterapeuta Intensivo, enfermeiro(a) etc)
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ));
        }
        return const Text('Carregando email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ));
      }),
    );
  }
}

class GetUserCrefito extends StatelessWidget {
  final String documentID;

  const GetUserCrefito({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    CollectionReference fisioterapeutas =
        FirebaseFirestore.instance.collection("fisioterapeuta");

    return StreamBuilder<DocumentSnapshot>(
      stream: fisioterapeutas.doc(documentID).snapshots(),
      builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          //Informação carregada
          // print("Data value:  ");
          // print(snapshot.data!["crefito"]);
          return Text(
            '${snapshot.data!["crefito"]}',
            style: const TextStyle(
              fontSize: 15.0,
            ),
          );
        }
        return const Text('error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ));
      }),
    );
  }
}

class GetPacientsNum extends StatelessWidget {
  final String documentID;

  const GetPacientsNum({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("pacientes")
          .where('fisioID', isEqualTo: documentID)
          .snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          final num = snapshot.data!.docs.length;
          return Text(
            '$num',
            style: const TextStyle(
              fontSize: 15.0,
            ),
          );
        }
        return const Text('error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ));
      }),
    );
  }
}

class GetPacientsTotal extends StatelessWidget {
  final String documentID;

  const GetPacientsTotal({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("pacientes").snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          final num = snapshot.data!.docs.length;
          return Text(
            '$num',
            style: const TextStyle(
              fontSize: 15.0,
            ),
          );
        }
        return const Text('error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ));
      }),
    );
  }
}
