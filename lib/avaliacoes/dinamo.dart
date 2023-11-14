class Dinamo {
  final String tipo = "dinamometria";
  int resultado = 0;
  int cpfPaciente = 0;
  String fisioID = "";
  String obsAvaliacao = "";
  late DateTime data;

  Dinamo(int resultado, String fisioID, String obsAvaliacao) {
    this.resultado = resultado;
    this.fisioID = fisioID;
    this.obsAvaliacao = obsAvaliacao;
    data = DateTime.now();
  }

  String getFisioID() {
    return fisioID;
  }

  int getPacienteID() {
    return cpfPaciente;
  }

  String getObsAvaliacao() {
    return obsAvaliacao;
  }

  String getTipo() {
    return tipo;
  }

  int getResultado() {
    return resultado;
  }
}
