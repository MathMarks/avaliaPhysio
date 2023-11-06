class GrupoMuscular {
  String nome = '';
  int valorDireito = 0;
  int valorEsquerdo = 0;

  //Método construtor
  GrupoMuscular(String nome, int valorDireito, int valorEsquerdo) {
    this.nome = nome;
    this.valorDireito = valorDireito;
    this.valorEsquerdo = valorEsquerdo;
  }

  String verificarValores() {
    if (valorDireito == 0) {
      return "${this.nome} direito está em zero, favor verificar.";
    } else if (valorEsquerdo == 0) {
      return "${this.nome} esquerdo está em zero, favor verificar.";
    } else {
      return "ok";
    }
  }

  int totalValores() {
    return valorDireito + valorEsquerdo;
  }
}
