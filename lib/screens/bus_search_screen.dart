import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';


class BusSearchScreen extends StatefulWidget {
  const BusSearchScreen({super.key});

  @override
  State<BusSearchScreen> createState() => _BusSearchScreenState();
}


class _BusSearchScreenState extends State<BusSearchScreen> {
  // -------- LISTAS --------
  final tips = [
    "Recuerda hidratarte",
    "WiFi disponible hasta 50 MB",
    "Disfruta de tu viaje",
    "Descansa"
  ];
  

  final gifs = [
    "assets/gif/estethebus.gif",
    "assets/gif/edificios.gif",
    "assets/gif/tercero.gif",
  ];

  // -------- VARIABLES --------
  String currentTip = "";
  int currentGifIndex = 0;
  Timer? _gifTimer;

  @override
  void initState() {
    super.initState();
    currentTip = tips[0];
    _startTipTimer();
    _startGifTimer();
  }

  
  // -------- CAMBIO DE TIP --------
  void _startTipTimer() {
    Future.delayed(const Duration(seconds: 5), _changeTip);
  }

  void _changeTip() {
    setState(() {
      tips.shuffle();
      currentTip = tips.first;
    });
    _startTipTimer(); // reinicia el timer
  }

  // -------- CAMBIO DE GIF --------
  void _startGifTimer() {
    _gifTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currentGifIndex = (currentGifIndex + 1) % gifs.length;
      });
    });
  }

  @override
  void dispose() {
    _gifTimer?.cancel();
    super.dispose();
  }

  
  // -------- UI PRINCIPAL --------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // 👇 AQUÍ VA TU MENÚ HAMBURGUESA
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 9, 9)),
    ),

    drawer: Drawer(
  backgroundColor: AppColors.background,
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color(0xFFCECDD3),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Text(
          'Menú de opciones',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      // ---------- SOBRE EL BUS ----------
      ListTile(
        leading: const Icon(Icons.directions_bus, color: Colors.black),
        title: const Text("Sobre el bus", style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Modelo del bus 🚍",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2596be),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: ModelViewer(
                        src: 'https://cdn.jsdelivr.net/gh/cesarjk78/3d-models/car_model.glb',
                        autoRotateDelay: 0, // empieza a girar de inmediato
                        rotationPerSecond: "30deg", // velocidad de rotación
                        alt: 'Bus 3D',
                        autoRotate: true,
                        cameraControls: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "🛠️ Este bus está diseñado para ofrecer comodidad y resistencia.\n\n"
                      "🔥 Resistente a altas temperaturas.\n"
                      "🧳 Cuenta con compartimientos inferiores y superiores.\n"
                      "💺 Asientos reclinables con cargadores USB.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2596be),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cerrar"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // ---------- NORMAS DEL VIAJE ----------
      ListTile(
        leading: const Icon(Icons.rule, color: Colors.black),
        title: const Text("Normas del viaje", style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.directions_bus, size: 60, color: Color(0xFF2596be)),
                    SizedBox(height: 16),
                    Text(
                      "Normas del Viaje",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2596be),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "🧍‍♂️ Mantén siempre tu asiento asignado.\n\n"
                      "🔇 Evita hacer ruido excesivo o usar música sin audífonos.\n\n"
                      "🗑️ No arrojes basura dentro del bus.\n\n"
                      "🐶 Las mascotas deben ir en su transportín.\n\n"
                      "💺 Cede el asiento a personas mayores o embarazadas.\n\n"
                      "⏱️ Llega puntual a la hora de partida.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  ),
),
      body: CustomScrollView(
        slivers: [
          // ---------- GIF PRINCIPAL ----------
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: Image.asset(
                    gifs[currentGifIndex],
                    key: ValueKey(currentGifIndex),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          

          // ---------- CONTENIDO ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Bienvenido, pasajero",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Tu viaje empieza en breve — revisa novedades y servicios — disfruta su estancia en la app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ---- Novedades ----
                  buildTitleWithLines("Novedades de Hoy"),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _SimpleInfoItem(
                            icon: Icons.place,
                            color: Colors.blue,
                            title: "Próx. parada"),
                        _SimpleInfoItem(
                            icon: Icons.local_offer,
                            color: Colors.purple,
                            title: "10% Off"),
                        _SimpleInfoItem(
                            icon: Icons.wb_sunny,
                            color: Colors.orange,
                            title: "Clima"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ---- ¿Cómo te sientes hoy? ----
                  buildTitleWithLines("¿Cómo te sientes hoy?"),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _MoodItem(
                          icon: Icons.sentiment_very_satisfied,
                          color: Colors.green,
                          label: "Feliz"),
                      _MoodItem(
                          icon: Icons.sentiment_neutral,
                          color: Colors.amber,
                          label: "Normal"),
                      _MoodItem(
                          icon: Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                          label: "Cansado"),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ---- Estado del bus ----
                  _StateCard(),
                  const SizedBox(height: 16),

                  // ---- Progreso del viaje (línea con bus animado) ----
                  const BusProgressLine(),
                  const SizedBox(height: 32),

                  // ---- WiFi activo en bus ----
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.wifi, color: Colors.teal),
                        SizedBox(width: 8),
                        Text("WiFi activo en el bus",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ---- Actividades ----
                  buildTitleWithLines("Actividades del Bus"),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // SERVICIOS
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const ServicePopupCentered(),
                          );
                        },
                        child: const _ActivityCard(
                          icon: Icons.build_circle,
                          color: Colors.blueAccent,
                          title: "Servicios",
                        ),
                      ),
                      // NOTICIAS
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const NewsPopupCentered(),
                          );
                        },
                        child: const _ActivityCard(
                          icon: Icons.newspaper,
                          color: Colors.indigo,
                          title: "Noticias",
                        ),
                      ),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => const GamePopupCentered(),
                            );
                          },
                          child: const _ActivityCard(
                            icon: Icons.games,
                            color: Colors.pink,
                            title: "Juegos",
                          ),
                        ),

                      // Snacks con popup centrado
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const SnackPopupCentered(),
                          );
                        },
                        child: const _ActivityCard(
                          icon: Icons.local_dining,
                          color: Colors.orange,
                          title: "Snacks",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ---- Tips rápidos ----
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lightbulb, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            currentTip,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 400),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitleWithLines(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}

// ---------- Widgets Auxiliares ----------
class _SimpleInfoItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const _SimpleInfoItem({
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          radius: 24,
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _MoodItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _MoodItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          radius: 26,
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const _ActivityCard({
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            radius: 30,
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estado del Bus",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.wifi, color: Colors.teal),
              ],
            ),
            Divider(height: 20, thickness: 1),
            Row(
              children: [
                Icon(Icons.directions_bus, color: Colors.green),
                SizedBox(width: 8),
                Text("En ruta", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.thermostat, color: Colors.orange),
                SizedBox(width: 8),
                Text("Temperatura: 22°C", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.place, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text("Próxima parada: Av. Central",
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Popup de Snacks ----------
class SnackPopupCentered extends StatelessWidget {
  const SnackPopupCentered({super.key});

  @override
  Widget build(BuildContext context) {
    return _GenericPopup( // Quitado 'const' de aquí
      title: "Snacks Disponibles",
      items: [ // Quitado 'const' de la lista, ya que ahora incluye un widget que no es const
        SnackCard(icon: Icons.local_pizza_outlined, title: "Papitas", description: "Bolsa de papas fritas crocantes", price: "S/. 9.00"),
        SnackCard(icon: Icons.local_drink_outlined, title: "Gaseosa", description: "Bebida refrescante en lata", price: "S/. 6.00"),
        SnackCard(icon: Icons.water_drop_outlined, title: "Agua Mineral", description: "Botella de agua fría", price: "S/. 4.00"),
        SnackCard(icon: Icons.icecream_outlined, title: "Chocolate", description: "Barra de chocolate dulce", price: "S/. 7.50"),

        // Aquí agregamos la imagen al final
        const SizedBox(height: 20), // Un espacio para separar la lista de la imagen
        Image.asset(
          'assets/image/bus_xd1.png', // <-- ¡IMPORTANTE! Reemplaza 'assets/coke_logo.png' con la ruta a tu imagen
          width: 100, // Ajusta el ancho según lo necesites
          height: 100, // Ajusta el alto según lo necesites
        ),
        const SizedBox(height: 10), // Un pequeño espacio al final si lo deseas
      ],
    );
  }
}

// ---------- Popup de Servicios ----------
class ServicePopupCentered extends StatelessWidget {
  const ServicePopupCentered({super.key});

  @override
  Widget build(BuildContext context) {
    return _GenericPopup(
      title: "Servicios del Bus",
      items: [
        SnackCard(icon: Icons.usb, title: "Enchufes USB", description: "Cargadores USB en cada asiento", price: "Gratis"),
        SnackCard(icon: Icons.wifi, title: "WiFi 1 hora", description: "Conexión gratuita por 1h", price: "Incluido"),
        SnackCard(icon: Icons.tv, title: "TV a bordo", description: "Películas y series en pantallas HD", price: "Gratis"),
        SnackCard(icon: Icons.chair, title: "Asientos reclinables", description: "Mayor comodidad durante el viaje", price: "Incluido"),

        const SizedBox(height: 20), // Un espacio para separar la lista de la imagen
        Image.asset(
          'assets/image/busfoco.png', // <-- ¡IMPORTANTE! Reemplaza 'assets/coke_logo.png' con la ruta a tu imagen
          width: 100, // Ajusta el ancho según lo necesites
          height: 100, // Ajusta el alto según lo necesites
        ),
        const SizedBox(height: 10), // Un pequeño espacio al final si lo deseas
      ],
    );
  }
}

// ---------- Popup de Noticias ----------
class NewsPopupCentered extends StatelessWidget {
  const NewsPopupCentered({super.key});

  @override
  Widget build(BuildContext context) {
    return _GenericPopup(
      title: "Noticias del Perú",
      items: [
        SnackCard(icon: Icons.new_releases, title: "Incidente en Lima", description: "Reporte de tráfico en la Vía Expresa", price: "Hace 10 min"),
        SnackCard(icon: Icons.new_releases, title: "Clima en Cusco", description: "Lluvias moderadas en la región", price: "Hoy"),
        SnackCard(icon: Icons.new_releases, title: "Economía", description: "Nuevo plan de reactivación presentado", price: "Última hora"),
        SnackCard(icon: Icons.new_releases, title: "Deportes", description: "Selección peruana lista para el amistoso", price: "Hace 1h"),

        const SizedBox(height: 20), // Un espacio para separar la lista de la imagen
        Image.asset(
          'assets/image/bustudy.png', // <-- ¡IMPORTANTE! Reemplaza 'assets/coke_logo.png' con la ruta a tu imagen
          width: 100, // Ajusta el ancho según lo necesites
          height: 100, // Ajusta el alto según lo necesites
        ),
        const SizedBox(height: 10), // Un pequeño espacio al final si lo deseas
      ],
    );
  }
}

// ---------- Popup de Juegos ----------
class GamePopupCentered extends StatelessWidget {
  const GamePopupCentered({super.key});

  @override
  Widget build(BuildContext context) {
    return _GenericPopup(
      title: "Nuevo Juego",
      items: [
        GestureDetector(
          onTap: () async {
            // Enlace random, cámbialo por el tuyo
            const url = "https://www.roblox.com/games/78854645177907/La-Perla-de-Altomayo-Aventura-en-bus"; 
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "¡Toca la imagen para jugar!",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/image/bus_roblox.png", // 🔹 Reemplaza con tu imagen
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// ---------- Popup Genérico ----------
class _GenericPopup extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _GenericPopup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.6,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(child: ListView(children: items)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Línea de progreso del bus con título ----------
class BusProgressLine extends StatefulWidget {
  const BusProgressLine({super.key});

  @override
  State<BusProgressLine> createState() => _BusProgressLineState();
}

class _BusProgressLineState extends State<BusProgressLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 150),
    )..repeat(); // Animación continua
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const lineWidth = 300.0;
    const iconSize = 36.0;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------- Línea y bus ----------
          SizedBox(
            width: lineWidth,
            height: 80,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Línea base
                Positioned(
                  left: 0,
                  right: 0,
                  top: 40,
                  child: Container(
                    height: 4,
                    color: Colors.grey.shade300,
                  ),
                ),

                // Inicio y fin
                const Positioned(
                  left: 0,
                  top: 32,
                  child: Icon(Icons.location_on, color: Colors.green),
                ),
                const Positioned(
                  right: 0,
                  top: 32,
                  child: Icon(Icons.flag, color: Colors.redAccent),
                ),

                // Bus animado
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double progress = _controller.value;
                    return Positioned(
                      left: (lineWidth - iconSize) * progress,
                      top: 22,
                      child: Transform.rotate(
                        angle: 0,
                        child: Icon(
                          Icons.directions_bus,
                          size: iconSize,
                          color: Colors.blueAccent,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ---------- Texto de tiempo de viaje ----------
          Text(
            "Siempre llegando a tu destino",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}


// ---------- Tarjeta Genérica (SnackCard reusada) ----------
class SnackCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String price;

  const SnackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: Colors.deepPurple),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
