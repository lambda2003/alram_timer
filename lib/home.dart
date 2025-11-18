import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String currentDateTime;
  DateTime? chosenDateTime;
  late bool _isRunning;
  late Timer _timer;
  bool _isAlarm = false;
  bool _isStart = false;
  bool _isBlank = false;
  @override
  void initState() {
    super.initState();
    currentDateTime = '';
    chosenDateTime = DateTime.now();
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      if(!_isRunning){
        print('Timer cancelled =====');
        timer.cancel();
      }
      _addItem(); 
    });
  }

  _addItem(){
    // 현재 시간
    DateTime now = DateTime.now();
    currentDateTime = 
      '${now.year}-${now.month.toString().padLeft(2,'0')}' 
      +'-${now.day.toString().padLeft(2,'0')}' 
      +' ${_weekDayToString(now.weekday)}'
      +' ${now.hour.toString().padLeft(2,'0')}'
      +':${now.minute.toString().padLeft(2,'0')}'
      +':${now.second.toString().padLeft(2,'0')}'
      ;
    
        if(!_isStart &&_isAlarm && chosenDateTime!.millisecondsSinceEpoch <= now.millisecondsSinceEpoch){
           _isStart = true;
        
          
        }
      
        if( now.millisecondsSinceEpoch < chosenDateTime!.add(const Duration(minutes: 1)).millisecondsSinceEpoch){
          

          _isBlank = !_isBlank; 
        }else{
           _isBlank = false;
          _isAlarm = false;
          _isStart = false;
          
        }
       
      setState(() {});
  }

  String _weekDayToString(int weekday){
    switch(weekday){
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      default:
        return '일';    
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isStart ? _isBlank? Colors.red : Colors.white : Colors.white,
      appBar: AppBar(
        title: Text('date picker 2'),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 시간: ${currentDateTime}'),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                use24hFormat: true,
                // showTimeSeparator: true,
                onDateTimeChanged: (value) {
                 
                  chosenDateTime = value;
                  _isAlarm = true;
                  setState(() {});
                },

              ),
            ),
            Text(
              '선택시간 :  ${
                chosenDateTime!=null? _chosenItem(chosenDateTime!) : '시간을 선택하세요.'
                
                }',
                style: TextStyle(
                 
                ),//${chosenDateTime.toString()}'
            ),
            // ElevatedButton(onPressed: ()=>changeStart(), child: Text(_isRunning? 'Start':'Stop'))
          ],
        ),
      )
    );
  }

  // == functions
  String _chosenItem(DateTime now){
    String xx= '${now.year}-${now.month.toString().padLeft(2,'0')}' 
      +'-${now.day.toString().padLeft(2,'0')}' 
      +' ${_weekDayToString(now.weekday)}'
      +' ${now.hour.toString().padLeft(2,'0')}'
      +':${now.minute.toString().padLeft(2,'0')}';
   
       return xx;
  }

  // changeStart() {
  //   _isRunning = !_isRunning;
  //   setState(() {
      
  //   });
  // }

}