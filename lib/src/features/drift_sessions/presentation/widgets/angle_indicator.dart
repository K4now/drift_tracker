import 'package:flutter/material.dart';

class AngleIndicator extends StatelessWidget {
  final double angle;

  const AngleIndicator({Key? key, required this.angle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50; // Ширина контейнера с учетом отступов
    double halfWidth = width / 2;
    double position = (angle / 180.0) * halfWidth + halfWidth;

    // Обеспечиваем, что индикатор не выходит за границы контейнера
    if (position < 5) position = 5; // Учитываем ширину индикатора
    if (position > width - 5) position = width - 5;

    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Красные зоны
          Positioned(
            left: 0,
            child: Container(
              width: width * 0.1,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: width * 0.1,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          // Разметка и угловые метки
          for (int i = -9; i <= 9; i++)
            Positioned(
              left: halfWidth + (i * halfWidth / 9) - 1,
              child: Container(
                width: 2,
                height: i % 3 == 0 ? 40 : 20,
                color: i % 3 == 0 ? Colors.black : Colors.grey,
              ),
            ),
          for (int i = -9; i <= 9; i += 3)
            Positioned(
              left: halfWidth + (i * halfWidth / 9) - 15,
              top: 50,
              child: Text(
                '${i * 20}°',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          // Индикатор угла
          Positioned(
            left: position - 5, // Сдвиг для центрирования индикатора по середине
            child: Container(
              width: 10,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          // Текущий угол
          Positioned(
            left: position - 25,
            top: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${angle.toStringAsFixed(1)}°',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
