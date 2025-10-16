import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';

class HomeScreen extends StatefulWidget {
  final String? loggedEmail;
  const HomeScreen({super.key, this.loggedEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TELA BIBLIOTECA--
  String nomePasta = "Minha Pasta";
  bool _editando = false;
  final TextEditingController _nomeController = TextEditingController();

  void abrirPasta() {
    showDialog(
      context: context,
      builder: (context) {
        String novoNome = nomePasta;

        return AlertDialog(
          backgroundColor: const Color(0xFFFFEAEA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            nomePasta,
            style: const TextStyle(
              color: Color(0xFFE57373),
              fontFamily: "Karla",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.folder_open, color: Color(0xFFE57373), size: 90),
              const SizedBox(height: 12),
              const Text(
                "Nenhum item encontrado",
                style: TextStyle(
                  fontFamily: "Karla",
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Renomear pasta",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => novoNome = value,
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Color(0xFFE57373), fontFamily: "Karla"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (novoNome.trim().isNotEmpty) {
                    nomePasta = novoNome.trim();
                  }
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Salvar",
                style: TextStyle(color: Colors.white, fontFamily: "Karla"),
              ),
            ),
          ],
        );
      },
    );
  }

  // TELA DE NOVO--/ CRIAR--
  Uint8List? _fotoCapa;
  Future<void> _pickCoverImage() async {
    final imageBytes = await ImagePickerWeb.getImageAsBytes();
    if (imageBytes != null) {
      setState(() {
        _fotoCapa = imageBytes;
      });
    }
  }
  final TextEditingController tituloController = TextEditingController();
final TextEditingController valorController = TextEditingController();
final TextEditingController descricaoController = TextEditingController();

  //TELA DE CONTA--
  Uint8List? _fotoPerfil; // foto de perfil

  Future<void> _pickImageFromGallery() async {
    final imageBytes = await ImagePickerWeb.getImageAsBytes();
    if (imageBytes != null) {
      setState(() {
        _fotoPerfil = imageBytes;
      });
    }
  }

  // Conta: dados do usuário
  String userName = "Usuário";
  String userEmail = ""; 
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    userEmail = widget.loggedEmail ?? "";
    nameController.text = userName;
    emailController.text = userEmail;
  }

  Widget buildSectionConta(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFFE57373),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Karla',
        ),
      ),
    );
  }

  Widget buildItemConta(String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE57373), width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Karla',
                color: Colors.black87,
              ),
            ),
            Icon(icon, color: const Color(0xFFE57373), size: 20),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEdicao(
    BuildContext context,
    String titulo,
    TextEditingController controller,
    Function(String) onConfirm, {
    bool obscure = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo, style: const TextStyle(fontFamily: 'Karla')),
          content: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: titulo,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Color(0xFFE57373)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
              ),
              onPressed: () {
                onConfirm(controller.text);
                Navigator.pop(context);
              },
              child: const Text(
                "Salvar",
                style: TextStyle(color: Colors.white, fontFamily: 'Karla'),
              ),
            ),
          ],
        );
      },
    );
  }

  //TELA CALCULADORA--
  List<Map<String, dynamic>> linhas = [
    {"preco": "", "gramasTotal": "", "gramasUsadas": ""},
  ];
  String valorHora = "";
  String horasTrabalhadas = "";
  String porcentagemLucro = "";
  double resultadoFinal = 0.0;

  void calcularPrecoFinal() {
    double custoMateriais = 0.0;

    for (var linha in linhas) {
      if (linha["preco"] != "" &&
          linha["gramasTotal"] != "" &&
          linha["gramasUsadas"] != "") {
        double preco = double.tryParse(linha["preco"]) ?? 0;
        double total = double.tryParse(linha["gramasTotal"]) ?? 0;
        double usadas = double.tryParse(linha["gramasUsadas"]) ?? 0;

        if (total > 0) {
          custoMateriais += (usadas / total) * preco;
        }
      }
    }

    double valorHoraNum = double.tryParse(valorHora) ?? 0;
    double horasNum = double.tryParse(horasTrabalhadas) ?? 0;
    double lucroPerc = double.tryParse(porcentagemLucro) ?? 0;

    double custoTrabalho = valorHoraNum * horasNum;
    double subtotal = custoMateriais + custoTrabalho;
    double totalFinal = subtotal + (subtotal * lucroPerc / 100);

    setState(() {
      resultadoFinal = totalFinal;
    });
  }

  // ISSO É PRA TELA HOME--
  bool croche = false;
  bool costura = false;
  bool amigurumi = false;

  // TELA HOME
  final List<String> categorias = ["Rápido", "Pequenos", "Grandes", "Fácil"];
  final Set<String> categoriasSelecionadas = {};

  void _mostrarFiltros(BuildContext context) {
    final overlay = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: StatefulBuilder(
              builder: (context, setStateSB) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Filtrar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: "Karla",
                      ),
                    ),
                    const SizedBox(height: 6),

                    // categorias selecionaveis
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categorias.map((categoria) {
                        final selecionado = categoriasSelecionadas.contains(
                          categoria,
                        );

                        return FilterChip(
                          label: Text(
                            categoria,
                            style: TextStyle(
                              color: selecionado
                                  ? Colors.white
                                  : Colors.black87,
                              fontFamily: "Karla",
                            ),
                          ),
                          selected: selecionado,
                          selectedColor: const Color.fromARGB(
                            255,
                            247,
                            111,
                            111,
                          ),
                          backgroundColor: Colors.grey.shade200,
                          checkmarkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onSelected: (bool value) {
                            setStateSB(() {
                              if (value) {
                                categoriasSelecionadas.add(categoria);
                              } else {
                                categoriasSelecionadas.remove(categoria);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const Divider(),

                    CheckboxListTile(
                      title: const Text(
                        "Crochê",
                        style: TextStyle(fontFamily: "Karla"),
                      ),
                      value: croche,
                      onChanged: (value) => setStateSB(() => croche = value!),
                      activeColor: const Color.fromARGB(255, 247, 111, 111),
                      checkColor: Colors.white,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "Costura",
                        style: TextStyle(fontFamily: "Karla"),
                      ),
                      value: costura,
                      onChanged: (value) => setStateSB(() => costura = value!),
                      activeColor: const Color.fromARGB(255, 247, 111, 111),
                      checkColor: Colors.white,
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "Amigurumi",
                        style: TextStyle(fontFamily: "Karla"),
                      ),
                      value: amigurumi,
                      onChanged: (value) =>
                          setStateSB(() => amigurumi = value!),
                      activeColor: const Color.fromARGB(255, 247, 111, 111),
                      checkColor: Colors.white,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => overlayEntry?.remove(),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              color: Color.fromARGB(255, 247, 111, 111),
                              fontFamily: "Karla",
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            
                            print("Categorias: $categoriasSelecionadas");
                            print(
                              "Crochê: $croche, Costura: $costura, Amigurumi: $amigurumi",
                            );
                            overlayEntry?.remove();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              247,
                              111,
                              111,
                            ),
                          ),
                          child: const Text(
                            "Aplicar",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Karla",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE57373),
            fontFamily: "Karla",
          ),
        ),
      ),
    );
  }

  Widget buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: Card(
              elevation: 4,
              child: Center(
                child: Text(
                  "Tutorial ${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //NAVIGATION BAR--
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 200, 190),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // Tela 0 - Novo/criar projeto
            Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        "Criar Projeto",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE57373),
                          fontFamily: "Karla",
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 249, 189, 85),
                          decorationStyle: TextDecorationStyle.wavy,
                          decorationThickness: 3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Container para imagem de capa
                      GestureDetector(
                        onTap: _pickCoverImage,
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 246, 166, 166),
                            borderRadius: BorderRadius.circular(16),
                            image: _fotoCapa != null
                                ? DecorationImage(
                                    image: MemoryImage(_fotoCapa!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _fotoCapa == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 50,
                                      color: Color(0xFFE57373),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Adicionar a foto de capa",
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Karla",
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Campo título
                      const Text(
                        "Digite o Título...",
                        style: TextStyle(
                          color: Color(0xFFE57373),
                          fontFamily: "Karla",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.edit,
                            color: Color(0xFFE57373),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE57373),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE57373),
                              width: 1.5,
                            ),
                          ),
                          hintText: "Título do projeto...",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 255, 237, 237),
                            fontFamily: "Karla",
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Campo valor
                      Row(
                        children: [
                          const Text(
                            "Valor R\$ ",
                            style: TextStyle(
                              color: Color(0xFFE57373),
                              fontFamily: "Karla",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: valorController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                hintText: "0,00",
                                hintStyle: TextStyle(color: Color(0xFFE57373)),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE57373),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Campo passo a passo
                      const Text(
                        "Escreva o passo a passo...",
                        style: TextStyle(
                          color: Color(0xFFE57373),
                          fontFamily: "Karla",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: descricaoController,
                        maxLines: 8,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Descreva o projeto detalhadamente...",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontFamily: "Karla",
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                //BOTÃO DE ENVIAR
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                   onPressed: () {
  final titulo = tituloController.text.trim();
  final valor = valorController.text.trim();
  final descricao = descricaoController.text.trim();
  final temCapa = _fotoCapa != null;

  // validação simples: todos obrigatórios
  if (!temCapa || titulo.isEmpty || valor.isEmpty || descricao.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Campos obrigatórios",
            style: TextStyle(fontFamily: "Karla", fontWeight: FontWeight.bold),
          ),
          content: Text(
            // mensagem personalizada conforme o que falta
            !temCapa
                ? "Por favor, adicione uma foto de capa."
                : titulo.isEmpty
                    ? "Por favor, digite o título do projeto."
                    : valor.isEmpty
                        ? "Por favor, informe o valor."
                        : "Por favor, descreva o projeto.",
            style: const TextStyle(fontFamily: "Karla"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK", style: TextStyle(color: Color(0xFFE57373))),
            ),
          ],
        );
      },
    );
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Pronto", style: TextStyle(fontFamily: "Karla", fontWeight: FontWeight.bold)),
        content: const Text("Projeto enviado com sucesso.", style: TextStyle(fontFamily: "Karla")),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK", style: TextStyle(color: Color(0xFFE57373))),
          ),
        ],
      );
    },
  );

  
   tituloController.clear();
   valorController.clear();
   descricaoController.clear();
   setState(() { _fotoCapa = null; });
},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 247, 111, 111),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // bordas arredondadas
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 20,
                      ),
                      elevation: 6,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),

            // Tela - 1 Calculadora
            Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Calculadora de Preço",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE57373),
                    fontFamily: "Karla",
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 249, 189, 85),
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationThickness: 3,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 200, 190),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            "Linhas Utilizadas",
                            style: TextStyle(
                              fontFamily: "Karla",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE57373),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Linhas adicionadas dinamicamente
                          Column(
                            children: List.generate(linhas.length, (index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFFE57373),
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: const InputDecoration(
                                        labelText: "Preço da linha (R\$)",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          linhas[index]["preco"] = v,
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: const InputDecoration(
                                        labelText: "Gramas totais",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          linhas[index]["gramasTotal"] = v,
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      decoration: const InputDecoration(
                                        labelText: "Gramas usadas",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          linhas[index]["gramasUsadas"] = v,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),

                          // Botão para adicionar mais linhas
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                linhas.add({
                                  "preco": "",
                                  "gramasTotal": "",
                                  "gramasUsadas": "",
                                });
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Color(0xFFE57373),
                            ),
                            label: const Text(
                              "Adicionar Linha",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFE57373),
                                fontFamily: "Karla",
                              ),
                            ),
                          ),

                          const Divider(height: 10, color: Color(0xFFE57373)),

                          const Text(
                            "Trabalho",
                            style: TextStyle(
                              fontFamily: "Karla",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE57373),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Horas trabalhadas
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFE57373),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  decoration: const InputDecoration(
                                    labelText: "Horas trabalhadas",
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (v) => horasTrabalhadas = v,
                                ),
                                const SizedBox(height: 8),

                                // Valor por hora
                                TextField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  decoration: const InputDecoration(
                                    labelText: "Valor por hora (R\$)",
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (v) => valorHora = v,
                                ),
                                const SizedBox(height: 8),

                                // Lucro desejado
                                TextField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                  decoration: const InputDecoration(
                                    labelText: "Lucro desejado (%)",
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (v) => porcentagemLucro = v,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 7),

                          // Botão calcular
                          ElevatedButton(
                            onPressed: calcularPrecoFinal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE57373),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 14,
                              ),
                            ),
                            child: const Text(
                              "Calcular",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                                fontFamily: 'Karla',
                                fontWeight: FontWeight.w900,
                                decoration: TextDecoration.underline,
                                decorationColor: Color.fromARGB(
                                  255,
                                  249,
                                  189,
                                  85,
                                ),
                                decorationStyle: TextDecorationStyle.wavy,
                                decorationThickness: 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Resultado final
                          if (resultadoFinal > 0)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                "Preço final: R\$ ${resultadoFinal.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE57373),
                                  fontFamily: "Karla",
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Tela 2 - HOME
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.filter_alt_outlined, size: 20),
                          onPressed: () => _mostrarFiltros(context),
                        ),
                        suffixIcon: const Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Mais populares",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE57373),
                      fontFamily: "Karla",
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildSection("Crochê"),
                  buildGrid(),
                  buildSection("Costura"),
                  buildGrid(),
                  buildSection("Amigurumi"),
                  buildGrid(),
                ],
              ),
            ),

            // Tela 3 - BIBLIOTECA
            Container(
              color: const Color(0xFFFFC8C8),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Biblioteca",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE57373),
                      fontFamily: "Karla",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar...",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFE57373),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 200, 190),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            const TabBar(
                              labelColor: Color(0xFFE57373),
                              unselectedLabelColor: Color.fromARGB(
                                255,
                                255,
                                255,
                                255,
                              ),
                              indicatorColor: Color(0xFFE57373),
                              tabs: [
                                Tab(text: "Pastas"),
                                Tab(text: "Todos"),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: GridView.count(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.folder,
                                                size: 60,
                                                color: Color(0xFFE57373),
                                              ),
                                              const SizedBox(height: 4),

                                              // Nome da pasta com edição
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  _editando
                                                      ? SizedBox(
                                                          width: 100,
                                                          child: TextField(
                                                            controller:
                                                                _nomeController,
                                                            autofocus: true,
                                                            decoration:
                                                                const InputDecoration(
                                                                  isDense: true,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                            style:
                                                                const TextStyle(
                                                                  fontFamily:
                                                                      "Karla",
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                    0xFFE57373,
                                                                  ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                            onSubmitted:
                                                                (novoNome) {
                                                                  setState(() {
                                                                    nomePasta =
                                                                        novoNome;
                                                                    _editando =
                                                                        false;
                                                                  });
                                                                },
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _editando = true;
                                                              _nomeController
                                                                      .text =
                                                                  nomePasta;
                                                            });
                                                          },
                                                          child: Text(
                                                            nomePasta,
                                                            style:
                                                                const TextStyle(
                                                                  fontFamily:
                                                                      "Karla",
                                                                  fontSize: 14,
                                                                ),
                                                          ),
                                                        ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                      color: Color(0xFFE57373),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _editando = true;
                                                        _nomeController.text =
                                                            nomePasta;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.folder_open,
                                          size: 60,
                                          color: Color(0xFFE57373),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "Nenhum item encontrado",
                                          style: TextStyle(
                                            fontFamily: "Karla",
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),]))
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tela 4 - Conta
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    // Cabeçalho com avatar e email
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFFFFAFAF),
                            backgroundImage: _fotoPerfil != null
                                ? MemoryImage(_fotoPerfil!)
                                : null,
                            child: _fotoPerfil == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          nameController.text.isEmpty
                              ? userName
                              : nameController.text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Karla',
                          ),
                        ),
                        Text(
                          emailController.text.isEmpty
                              ? userEmail
                              : emailController.text,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Karla',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Seções
                    buildSectionConta("Dados Pessoais"),
                    buildItemConta("Alterar Nome", Icons.edit, () {
                      _mostrarDialogoEdicao(
                        context,
                        "Alterar Nome",
                        nameController,
                        (v) => setState(() => userName = v),
                      );
                    }),
                    buildItemConta("Alterar Email", Icons.email, () {
                      _mostrarDialogoEdicao(
                        context,
                        "Alterar Email",
                        emailController,
                        (v) => setState(() => userEmail = v),
                      );
                    }),
                    buildItemConta("Alterar Senha", Icons.lock, () {
                      final TextEditingController oldPasswordController =
                          TextEditingController();
                      final TextEditingController newPasswordController =
                          TextEditingController();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Alterar Senha",
                              style: TextStyle(fontFamily: 'Karla'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: oldPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Senha antiga",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: newPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: "Nova senha",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(color: Color(0xFFE57373)),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE57373),
                                ),
                                onPressed: () {
                                  if (oldPasswordController.text.isEmpty ||
                                      newPasswordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Preencha ambos os campos",
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Aqui você pode validar a senha antiga de verdade (Firebase, local etc.)
                                    setState(() {
                                      passwordController.text =
                                          newPasswordController.text;
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Senha alterada com sucesso",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Salvar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Karla',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),

                    buildItemConta(
                      "Alterar Foto de perfil",
                      Icons.camera_alt,
                      () {
                        _pickImageFromGallery();
                      },
                    ),

                    buildSectionConta("Compras"),
                    buildItemConta("Meus Cartões", Icons.credit_card, () {}),
                    buildItemConta(
                      "Compras Finalizadas",
                      Icons.check_circle,
                      () {},
                    ),
                    buildItemConta(
                      "Compras à Caminho",
                      Icons.local_shipping,
                      () {},
                    ),
                    buildItemConta("Favoritos", Icons.favorite, () {}),

                    buildSectionConta("Configurações"),
                    buildItemConta("Alterar tema", Icons.color_lens, () {}),
                    buildItemConta("Alterar fonte", Icons.font_download, () {}),
                    buildItemConta("Alterar Linguagem", Icons.language, () {}),
                    buildItemConta("Excluir conta", Icons.delete, () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 99,
        //NAVIGATION BAR
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFE57373),
          selectedItemColor: const Color.fromARGB(255, 226, 64, 64),
          unselectedItemColor: const Color.fromARGB(251, 249, 221, 222),
          iconSize: 26,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Novo"),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Calcular",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Biblioteca",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Conta"),
          ],
        ),
      ),
    );
  }
}
