import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/ui/widgets/item_forecast_widget.dart';
import 'package:http/http.dart'as http;


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool estacargando = true;

  String nombreCiudad = "";

  String pais = "";

  double temp = 0;

  TextEditingController buscarcontrolador = TextEditingController();


  @override
  initState(){
    super.initState();
    getDataLocation();
  }

  getData( String Ciudad) async{
    estacargando = true;
    setState(() {

    });
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$Ciudad&appid=86e9b72f7c040b8ead28275f79fb5d7b");
    http.Response response = await  http.get(url);
    if(response.statusCode==200) {

      Map myMap = json.decode(response.body);
      temp = myMap["main"]["temp"] - 273;
      nombreCiudad = myMap["name"];
      pais = myMap["sys"]["country"];
      estacargando = false;
      setState(() {

      });
    }


    //nombre ciudad
    //print(myMap["name"]);

    //nombre pais
   // print(myMap["sys"]["country"]);

    // temp


    //weather
   // print(myMap["weather"][0]["description"]);

  }

  getDataLocation()async{
    estacargando = true;
    setState(() {

    });
    Position position = await Geolocator.getCurrentPosition();
     Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=86e9b72f7c040b8ead28275f79fb5d7b");
      http.Response response = await  http.get(url);
    if(response.statusCode==200) {

      Map myMap = json.decode(response.body);
      temp = myMap["main"]["temp"] - 273;
      nombreCiudad = myMap["name"];
      pais = myMap["sys"]["country"];
      estacargando = false;
      setState(() {

      });
    }
    //print(position);

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("WeatherApp"),
        actions: [
          IconButton(onPressed: () {
           getDataLocation();

          }, icon: Icon(Icons.location_on)),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/nuboso.png",
                    height: 56,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Text((temp).toStringAsFixed(1),
                          style: TextStyle(fontSize: 60, color: Colors.white)),
                      SizedBox(
                        width: 4,
                      ),
                      Text("C°",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children:  [
                    Text(
                      "${nombreCiudad}, ${pais.toString()}",
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: buscarcontrolador,
                    decoration: InputDecoration(
                        hintText: "Ingresa una ciudad",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.12),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        onPressed: () {
                          String City = buscarcontrolador.text;
                          getData(City);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                        child: const Text(
                          "Buscar",
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                        ItemForecastWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "14 minuts ago",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "fasdfasfasfafafasfasfasf asdsfdsfdsfds asdasdsadsad",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Positioned(
                            top: -55,
                            right: -20,
                            child: Image.asset(
                              "assets/images/sol.png",
                              height: 70,
                              color: Colors.yellowAccent,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
         estacargando ? Container(
            color: Colors.grey.withOpacity(0.80),
            child: Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 5,
                  )

              ),
            ),
          ): SizedBox(),
        ],
      )
    );
  }
}
