import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';
class ChartScreen extends StatefulWidget {
  ChartScreen( this.toBeChart,) ;
  final Map<dynamic,int> toBeChart ;
  
  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    widget.toBeChart.forEach((key, value) {
      if(key!=0){
        chartData.add(
        ChartData(
          noOfPeople: value,
          totalScore: key,
        )
      );
      }else{
        chartData.add(
          ChartData(noOfPeople: 0, totalScore: 0)
        );
      }
      
      
     });
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
           
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 18,),
          ),
        centerTitle: true,
        title: Text('Graph', style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(right: 30),
            child: SfCartesianChart(
              title: ChartTitle(text: 'Leaderboard'),
              series: <ChartSeries> [
                 
              
              BarSeries<ChartData,int>(
                   color: Color(0xfff2bf42),
                dataSource: chartData,
                xValueMapper: (ChartData cd, _) => cd.totalScore,
                yValueMapper: (ChartData cd, _) => cd.noOfPeople, 
                dataLabelSettings: DataLabelSettings(isVisible: true)
              ),
              ],
              primaryXAxis: NumericAxis(anchorRangeToVisiblePoints: true , decimalPlaces: 0,minimum: 1,title: AxisTitle(text: 'total score')),
              primaryYAxis: NumericAxis(anchorRangeToVisiblePoints: true,decimalPlaces: 0 ,title: AxisTitle(text: 'no of Students'),) ,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData{
  final int noOfPeople;
  final int totalScore;
  ChartData({required this.noOfPeople, required this.totalScore});
}