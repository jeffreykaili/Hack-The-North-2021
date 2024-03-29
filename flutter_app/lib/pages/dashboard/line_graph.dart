import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class LineChartSample2 extends StatefulWidget {
  final data;
  LineChartSample2(this.data);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    red,
    yellow,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.40,
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.03,
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: SizedBox(
                width: 60,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    'AVG',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: showAvg
                          ? Colors.black.withOpacity(0.5)
                          : Color(0XFFF02A54),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Text(
                showAvg ? 'Average Steps' : 'Steps History',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: purple,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    print(widget.data);
    final info = widget.data;
    var spot_data = <FlSpot>[];
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    for (var i = 0; i < days.length; i++) {
      info.keys.forEach((key) {
        if (key == days[i]) {
          spot_data
              .add(FlSpot(i * 2, min(20000, (info[key] as int)) / 20000 * 8));
        }
      });
    }
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0XFF4E47C6),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'Mo';
              case 2:
                return 'Tu';
              case 4:
                return 'We';
              case 6:
                return 'Th';
              case 8:
                return 'Fr';
              case 10:
                return 'Sa';
              case 12:
                return 'Su';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0XFF4E47C6),
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2.5k';
              case 3:
                return '7.5k';
              case 5:
                return '12.5k';
              case 7:
                return '17.5k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: spot_data,
          isCurved: false,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.5)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    final info = widget.data;
    var sum = 0, cnt = 0;
    final day_of_week = DateFormat('EEEE').format(DateTime.now());
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    info.keys.forEach((key) {
      if (days.indexOf(key) <= days.indexOf(day_of_week)) {
        sum += int.parse(info[key].toString());
        cnt++;
      }
    });

    print("CNT " + cnt.toString() + " SUM: " + sum.toString());
    final average = (cnt == 0 ? 0 : (sum / cnt) / 20000 * 8).toDouble();
    print("AVERAGE: " + average.toString());
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0XFF4E47C6),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'Mo';
              case 2:
                return 'Tu';
              case 4:
                return 'We';
              case 6:
                return 'Th';
              case 8:
                return 'Fr';
              case 10:
                return 'Sa';
              case 12:
                return 'Su';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0XFF4E47C6),
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '2.5k';
              case 3:
                return '7.5k';
              case 5:
                return '12.5k';
              case 7:
                return '17.5k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, average),
            FlSpot(2, average),
            FlSpot(4, average),
            FlSpot(6, average),
            FlSpot(8, average),
            FlSpot(10, average),
            FlSpot(12, average),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.4),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.4),
          ]),
        ),
      ],
    );
  }
}
