import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAFAF), // fundo amarelo clarinho
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Topo com busca
              Container(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [
                    // Campo de busca
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Buscar...",
                          filled: true,
                          fillColor: Colors.white,                   
                          prefixIcon: IconButton(
                            icon: Icon(Icons.filter_alt_outlined, size: 20),
                            onPressed: () {
                            
                            },
                          ),
                          suffixIcon: const Icon(Icons.search, size: 20),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Título
              const Text(
                "Mais populares",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE57373), // vermelho suave
                  fontFamily: "Karla",
                ),
              ),

              const SizedBox(height: 10),

              // Seções
              buildSection("Crochê"),
              buildGrid(  ),

              buildSection("Costura"),
              buildGrid(),

              buildSection("Amigurumi"),
              buildGrid(),
            ],
          ),
        ),
      ),

      // Barra inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFFAFAF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // Widget de seção (título)
  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE57373),
            fontFamily: "Karla",
          ),
        ),
      ),
    );
  }

  // Grid de cards
  Widget buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 colunas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: 3, // quantidade por seção
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Center(
              child: Text(
                "Tutorial",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
