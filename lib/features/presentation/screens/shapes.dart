import 'package:flutter/material.dart';

class Shapes extends StatelessWidget {
  const Shapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: const Size(528, 347.75), // Puedes ajustar el tamaño aquí
          painter: InvertedTrianglePainter(),
        ),
      ),
    );
  }
}



class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.3); // Inicio en el punto inclinado izquierdo
    path.lineTo(size.width, 0); // Línea hasta la esquina superior derecha
    path.lineTo(size.width, size.height); // Línea hasta la esquina inferior derecha
    path.lineTo(0, size.height); // Línea hasta la esquina inferior izquierda
    path.close(); // Cierra el camino

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}