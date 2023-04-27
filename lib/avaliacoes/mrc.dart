class Mrc {
  final String tipo = "mrc";
  int resultado = 0;
  int cpfPaciente = 0;
  String fisioID = "";
  String obsAvaliacao = "";
  late DateTime data;

  Mrc(int resultado, String fisioID, String obsAvaliacao) {
    this.resultado = resultado;
    this.fisioID = fisioID;
    this.obsAvaliacao = obsAvaliacao;
    this.data = DateTime.now();
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
