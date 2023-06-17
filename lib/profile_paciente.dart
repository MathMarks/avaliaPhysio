import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_tcc_2/relatorios/relatorioMRC.dart';

class ProfilePaciente extends StatefulWidget {
  final dynamic data;
  const ProfilePaciente({Key? key, required this.data}) : super(key: key);

  @override
  State<ProfilePaciente> createState() => _ProfilePacienteState();
}

class _ProfilePacienteState extends State<ProfilePaciente> {
  final double imagemFundoHeight = 280;
  final double imagemPerfilHeight = 144;

  @override
  void initState() {
    //print("Dentro do profile" + widget.data.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil Paciente"),
      ),
      body: ListView(
        children: <Widget>[
          _constroiImagensTopo(),
          _constroiInfo(),
        ],
      ),
    );
  }

  Widget _constroiImagensTopo() {
    final top = imagemFundoHeight - (imagemPerfilHeight / 2);
    final bottom = imagemPerfilHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom), child: _imagemDeFundo()),
        Positioned(
          top: top,
          child: _imagemDePerfil(),
        ),
      ],
    );
  }

  Widget _imagemDeFundo() => Container(
        color: Colors.grey,
        child: Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdKoXL2oPJDIUVcHzUR3DtRh_jYMaUoi-C1A&usqp=CAU",
          width: double.infinity,
          height: imagemFundoHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget _imagemDePerfil() => CircleAvatar(
        radius: imagemPerfilHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const NetworkImage(
          "https://media.istockphoto.com/id/1208297649/vector/doctor-therapist-talk-to-disabled-woman-patient.jpg?s=612x612&w=0&k=20&c=SqCYHeaYpbSmP92fI4quIhRmQI50ApUnGHDenVQnUN4=",
        ),
      );

  Widget _constroiInfo() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            '${widget.data['nome']}',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.data['cpf']}",
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _constroiObservacao(),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          )
        ],
      );

  Widget _constroiObservacao() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Relatórios",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 30, left: 60, right: 60),
                      backgroundColor: Colors.blue.shade400),
                  onPressed: () {
                    //print(widget.data['cpf']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RelatorioMRC(cpf: widget.data['cpf'])));
                  },
                  child: const Text("Relatório MRC")),
            )
          ],
        ),
      );
}
