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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //remove a faixa de debug no canto superior direito da tela
      title:'contador de inspeção',
      //titulo interno do app 
      home: TelaContador(),
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
}

class _TelaContadorState extends State<TelaContador>{
  //essa e a classe que efetivamente guarda os dados que podem mudar durante o uso do app
  int _pecasAprovadas = 0;
  //variavel que guarfa a contagem autal de paças aprovadas
  final _nomeControler = TextEditingController();
  //controlador do campo de texto que guarda o nome do inspetor
  // e o nosso codigo dart guarda o text digitando e o merite le-lo

  final List<String> _registros =[];
  //função que guarda o historico de registros de aprovacao de pecas
  void _aprovarPeca(){
    //função que incrementa a contagem de peças aprovadas e atualiza a interface do usuário
    setState((){
      //sempre que a contagem mudar, chamamos setState para avisar o flutter que a interface precisa ser atualizada
      _pecasAprovadas+= 1;
      //incrementa a contagem de peças aprovadas
    });
  }
  
  void registrarEZerar(){
    //função chamada quando o botao registrar e zerar for pressionado
    final nome = _nomeControler.text.trim().isEmpty
      ?'Sem nome'
      : _nomeControler.text.trim();
      //operador ternario que verifica se o campo de texto esta vazio,
      // se estiver atribui 'Sem nome' a variavel nome, caso contrario atribui o valor digitado
      // no campo de texto
    setState((){
      //chamamos setState para avisar o flutter que a interface precisa ser atualizada
      _registros.add('$nome - $_pecasAprovadas peças(s)');
      //adiciona o registro ao historico de registros
      _pecasAprovadas = 0;
      //zera a contagem de peças aprovadas
      //chamamos setState para avisar o flutter que a interface precisa ser atualizada
    });
  }
  @override 
  void dispose(){
    //dispose e chamado quando o widget e removido da arvore de widgets, ou seja, quando a tela e fechada
    _nomeControler.dispose();
    //libera os recursos utilizados pelo controlador do campo de texto
    super.dispose();
    //chama o dispose da classe pai
    //Devemos sempre chamar o dispose do controlador de texto para evitar vazamentos de memória
  }
  @override
  Widget build(BuildContext context){ 
    //monta e devolve a interface do usuário da tela de contagem
    //no estado atual(com valores atuais das variaveis)
    return Scaffold(
      appBar:AppBar( 
        title: const Text('inspeção de Peças'),
        //titulo fixo na barra do topo da tela
      ),
      body:Padding(
        //adiciona um padding em torno do corpo da tela
        padding: const EdgeInsets.all(16.0),
        child: Column(
        // organiza os widgets filhos em uma coluna vertical
        //(nome do inspetor, contagem de peças aprovadas, botões e historico)
        children:[
          TextField( 
            //campo de texto onde o inspetor digita seu nome
            controller: _nomeControler,
            //ligar este mundo ao controller declarado no estado da tela,
            // para que possamos ler o valor digitado
            decoration: const InputDecoration( 
              labelText:"nome do inspetor do turno",
              border: OutlineInputBorder(),
              //desenha uma borda em torno do campo de texto
            ),
            onChanged:(texto){
              setState((){});
            },
          ),
          const SizedBox(height: 16),
          //espaço vertical entre o campo de texto e a contagem de peças aprovadas

          Text(
            _nomeControler.text.trim().isEmpty
            ?'Responsavel: não informado'
            :'Responsavel: ${_nomeControler.text.trim()}',
            //operador ternario que verifica se o campo de texto esta vazio,
            // se estiver exibe 'Responsavel: não informado', caso contrario exibe o nome digitado
            style: const TextStyle(fontSize:16, color: Colors.grey)
          ),
          const SizedBox(height: 16),
          Text(
            '$_pecasAprovadas',
            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              FilledButton.icon(
                //estilo de botao ja preenchido
                onPressed:_aprovarPeca,
                //quando tocado o botao chama a função
                icon: const Icon(Icons.add),
                label: const Text('+ Peça'),
                //texto do botao
              ),
              const SizedBox(width:12),

              OutlinedButton.icon(
                onPressed: registrarEZerar,
                icon: const Icon(Icons.save_alt),
                label: const Text('Registrar e zerar'),
              ),
            ],
          ),
          
          const SizedBox(height:16), // Corrigido o erro de layout (itens soltos dentro do Row)

          const Align(
            //allign posiciona seus filhos dentro do espaco disponivel
            // vamos usar aqui para forçar o titulo da lista a ficar alinhado 
            //a esquerda
            alignment: Alignment.centerLeft,
            child:Text('historico do turno',
            style:TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(height:8),
          Expanded(
            child:_registros.isEmpty
            ? const Center(child: Text('Nenhum registro ainda'))
            :ListView.builder(
              itemCount: _registros.length,
              itemBuilder:(context, index){
                //List view.builder e um widget que controi uma lista 
                return Card(
                  child: ListTile( 
                    leading: const Icon(Icons.history), 
                    title: Text(_registros[index])
                  ),
                );
              }
            ),
          ),
        ],
        ),
      ),
    );
  }
}