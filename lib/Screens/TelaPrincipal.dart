import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variáveis dos filtros
  bool croche = false;
  bool costura = false;
  bool amigurumi = false;

  // chips selecionáveis
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

                    // categorias rápidas (chips selecionáveis)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categorias.map((categoria) {
                        final selecionado =
                            categoriasSelecionadas.contains(categoria);

                        return FilterChip(
                          label: Text(
                            categoria,
                            style: TextStyle(
                              color: selecionado ? Colors.white : Colors.black,
                            ),
                          ),
                          selected: selecionado,
                          selectedColor: Colors.redAccent,
                          backgroundColor: Colors.grey.shade200,
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
                      title: const Text("Crochê"),
                      value: croche,
                      onChanged: (value) =>
                          setStateSB(() => croche = value!),
                    ),
                    CheckboxListTile(
                      title: const Text("Costura"),
                      value: costura,
                      onChanged: (value) =>
                          setStateSB(() => costura = value!),
                    ),
                    CheckboxListTile(
                      title: const Text("Amigurumi"),
                      value: amigurumi,
                      onChanged: (value) =>
                          setStateSB(() => amigurumi = value!),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => overlayEntry?.remove(),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // aqui você aplica os filtros escolhidos
                            print("Categorias: $categoriasSelecionadas");
                            print("Crochê: $croche, Costura: $costura, Amigurumi: $amigurumi");
                            overlayEntry?.remove();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE57373),
                          ),
                          child: const Text("Aplicar",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAFAF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo de busca com botão de filtro
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
            ],
          ),
        ),
      ),
    );
  }
}
