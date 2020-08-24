import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //timer
  TabController tb;
  int hour=0;
  int min=0;
  int sec=0;
  bool started= true;
  bool stopped= true;
  bool paused=true;
  int timertimer=0;
  String timedisp="";
  bool checktimer=true;
  bool checktimer1=true;
  int x=0;
  int j=0;

  @override
  void initState(){
    tb=TabController(
      length:3,
      vsync: this,
    );
    super.initState();
  }

  void start(){
    setState(() {
      started=false;
      stopped=false;
      paused=false;
    });
    j=0;
    timertimer= ((hour*60*60)+ (min*60)+ sec);
    if(checktimer1== true && x!=0){
      timertimer=x;
      x=0;
    }
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t) {
      setState(() {
        if(timertimer<1|| checktimer==false){
          t.cancel();
          checktimer=true;
          timedisp="";
          started=false;
          stopped=false;
          j=1;
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
      }else if(timertimer<1|| checktimer1==false){
          t.cancel();
          checktimer1=true;
          started=true;
          stopped=false;
          x=timertimer;
        }
        else if (timertimer<60){
          timedisp=timertimer.toString();
          timertimer=timertimer-1;
        }else if(timertimer<3600){
          int a =timertimer~/60;
          int b= timertimer-(60*a);
          timedisp=a.toString()+":"+b.toString();
          timertimer=timertimer-1;
        }else{
          int a=timertimer~/3600;
          int b=timertimer-(3600*a);
          int c=b~/60;
          int d=b-(60*c);
          timedisp=a.toString()+":"+c.toString()+":"+d.toString();
          timertimer=timertimer-1;
        }
      });
    });
  }

  void stop(){
    setState(() {
      started=true;
      stopped=true;
      checktimer=false;
      if(j==1) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
        j = 0;
      }});
  }
  void pause(){
    setState(() {
      started=true;
      stopped=false;
      paused=true;
      checktimer1=false;
      j=1;
    });
  }


  Widget timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                          'HH',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged:(val){
                          setState(() {
                            hour=val;
                          });
                    },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                          'MM',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      onChanged:(val){
                        setState(() {
                          min=val;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                          'SS',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      onChanged:(val){
                        setState(() {
                          sec=val;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
                timedisp,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started ? start : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  color: Colors.green,
                  child: Text(
                    "START",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                RaisedButton(
                  onPressed: paused ? null : pause,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  color: Colors.blueGrey,
                  child: Text(
                    "PAUSE",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  color: Colors.redAccent,
                  child: Text(
                    "STOP",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
//stopwatch
  bool startpress=true;
  bool stoppress=true;
  bool resetpress=true;
  String timetodisp="00:00:00";
  var arr=["00:00:00","00:00:00","00:00:00","00:00:00","00:00:00","00:00:00"];
  int k=0;
  int q=1;
  int e=0;
  int f=1;
  int g=2;
  var watch= Stopwatch();
  final duration= const Duration(seconds: 1);

  void starttimer(){
    Timer(duration, runn);
  }
  void runn(){
    if(watch.isRunning){
      starttimer();
    }
    setState(() {
      timetodisp=watch.elapsed.inHours.toString().padLeft(2,'0')+':'+(watch.elapsed.inMinutes%60).toString().padLeft(2,'0')+':'+ (watch.elapsed.inSeconds%60).toString().padLeft(2,'0');
    });
  }

  void startstopwatch(){
    setState(() {
      stoppress=false;
      startpress=false;
    });
    watch.start();
    starttimer();
  }
  void stopstopwatch() {
    setState(() {
      stoppress = true;
      resetpress = false;
      startpress = true;
    });
    watch.stop();
    arr[k] = timetodisp;
    k=k+1;
  }
  void resetstopwatch() {
    setState(() {
      startpress = true;
      resetpress = true;
    });
    watch.reset();
    timetodisp = "00:00:00";
    arr=["00:00:00","00:00:00","00:00:00","00:00:00","00:00:00","00:00:00"];
    k=0;
  }


  Widget stopwatch(){
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
              child:  Container(
                alignment: Alignment.center,
                child: Text(
                  timetodisp,
                  style: TextStyle(
                    fontSize:50.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ),
          Expanded(
            flex: 1,
            child: Text('lap 3:   '+
              arr[g],
              style: TextStyle(
                fontSize: 20.0,
              ),
          ),
          ),
            Expanded(
              flex:1,
            child: Text('lap 2:   '+
              arr[f],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: Text('lap 1:   '+
              arr[e],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: stoppress ? null:stopstopwatch,
                          color: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                      child: Text(
                        "STOP",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: resetpress ? null :resetstopwatch,
                      color: Colors.indigo,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 15.0,
                      ),
                      child: Text(
                        "RESET",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    ],),
                    RaisedButton(
                      onPressed: startpress ? startstopwatch : null,
                      color: Colors.lightGreen,
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 15.0,
                      ),
                      child: Text(
                        "START\nRESUME",
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black45,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
//ALARM
  bool add=true;
  bool rem=true;
  bool check=true;
  int times=0;
  String timetodis="00:00:00";
  int m=0;
  int h=0;
  int mi=0;
  int s=0;
  int z=0;
  int i=0;

  void adds(){
    setState(() {
      add=false;
      rem=false;
    });
    times= ((h*60*60)+ (mi*60)+ s);
    z= DateTime.now().hour*60*60+ DateTime.now().minute*60+ DateTime.now().second;
    if (times>z) {
      m = times - z;
    }else {
      m = times - z + 86400;
    }
      Timer.periodic(Duration(
        seconds: 1,
      ), (Timer t) {
        setState(() {
          if(i==1 && m==0)
            {
              FlutterRingtonePlayer.playRingtone();
            }
          if(m<1|| check==false){
            t.cancel();
            check=true;
            timetodis="00:00:00";
          } else if (m<60){
            timetodis=m.toString();
            m=m-1;
            i=1;
          }else if(m<3600){
            int a =m~/60;
            int b= m-(60*a);
            timetodis=a.toString()+":"+b.toString();
            m=m-1;
            i=1;
          }else{
            int a=m~/3600;
            int b=m-(3600*a);
            int c=b~/60;
            int d=b-(60*c);
            timetodis=a.toString()+":"+c.toString()+":"+d.toString();
            m=m-1;
            i=1;
          }
        });
      });
  }
  void remov(){
    setState(() {
      add=true;
      rem=true;
      check=false;
      if(i==1 && m==0)
        {
          add=true;
          rem=true;
          i=0;
          FlutterRingtonePlayer.stop();
        }
    });
  }

  Widget alarm(){
    return Container(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Text(
                      'HH',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  NumberPicker.integer(
                    initialValue: h,
                    minValue: 0,
                    maxValue: 23,
                    listViewWidth: 60.0,
                    onChanged:(val){
                      setState(() {
                        h=val;
                      });
                    },
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Text(
                      'MM',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  NumberPicker.integer(
                    initialValue: mi,
                    minValue: 0,
                    maxValue: 59,
                    listViewWidth: 60.0,
                    onChanged:(val){
                      setState(() {
                        mi=val;
                      });
                    },
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Text(
                      'SS',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  NumberPicker.integer(
                    initialValue: s,
                    minValue: 0,
                    maxValue: 59,
                    listViewWidth: 60.0,
                    onChanged:(val){
                      setState(() {
                        s=val;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(timetodis,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),

        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: add? adds: null,
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
                color: Colors.green,
                child: Text(
                  "+",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black45,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                ),
              ),
              RaisedButton(
                onPressed: rem ? null: remov,
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 10.0,
                ),
                color: Colors.red,
                child: Text(
                  "-",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black45,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                ),
              ),
            ],
          ),
        ),
      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('R-CLOCK',
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text('TIMER'),
            Text('STOPWATCH'),
            Text('ALARM'),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(
            fontSize: 20.0,
          ),
          unselectedLabelColor: Colors.blueGrey,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: [
          timer(),
          stopwatch(),
          alarm(),
        ],
        controller: tb,
      ),
    );
  }
}
