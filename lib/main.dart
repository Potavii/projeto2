import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o aplicativo e passa o widget ContadorApp como o widget raiz da aplicação
}
class ContadorApp extends StatelessWidget{
  //essa classe é um widget sem estado, ou seja, não tem estado interno que possa mudar ao longo do tempo. Ela é usada para construir a interface do usuário.
  const ContadorApp({super.key});
  //contrutor reapssadno a key para o widget pai
  @override
  Widget build(BuildContext context){
    //monta e devolve a config geral do app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //remove a faixa de debug no canto superior direito da tela
      title:'contador de inspeção',
      //titulo interno do app 
      home: const TelaContador(),
      //A tela Inicial do app e o widget tela contdor definido logo abixo
      
    );

  }
}
class TelaContador extends StatefulWidget{
  //aagora a tela prescisa lembrar de dados que mudam a contagem o nome digitado o historico 
  //esta classe ainda n guarda nada sozinha mas ja declara  que exsiste um state associado a ela
  const TelaContador({super.key});
  @override
  State<TelaContador> createState() => _TelaContadorState();
  //cria o state associado a ela
  // do estado ( telacontadorstate) que vai guardar os dados que mudam ao longo do tempo
  class _TelaContadorState extends State<TelaContador>{
    //essa e a classe que efetivamente guarda os dados que podem mudar durante o uso do app
    int _pecasAprovadas = 0;
    //variavel que guarfa a contagem autal de paças aprovadas
    final _nomeControler = TextEditingController();
    //controlador do campo de texto que guarda o nome do inspetor
    // e o nosso codigo dart guarda o text digitando e o merite le-lo
  }
}
