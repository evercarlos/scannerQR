import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScanPage extends StatefulWidget {
  @override
  State<StatefulWidget>createState(){
    return QrScanPageState();
  }
}
class QrScanPageState extends State<QrScanPage>{
  String _qrcode="";
  @override
  Widget build(BuildContext context){/* CONSTRUYENO*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector de QR para URL guiadas')
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/qrcode.png',
               height: 200,
            ),
            SizedBox(
            height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
              child: RaisedButton(
                color:Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: scan,
                child: const Text("Scanear el código QR"),
              ),
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              child: Text(
                _qrcode,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
      );
  }
  Future scan() async{
    try{
      String qrcode= await BarcodeScanner.scan();
      // AQUI VA EL SONIDO
        AudioCache cache = new AudioCache();
          cache.play('clap.mp3');
        if (await canLaunch(qrcode)) {
          await launch(qrcode);
        } else {
          throw 'La URL no existe $qrcode';
        }
      // END
      setState(
        () => this._qrcode = '' // qrcode
        );
    }on PlatformException catch(e){
      if (e.code == BarcodeScanner.CameraAccessDenied) {
           setState(() {
          this._qrcode = 'El usuario no dio permiso para el uso de la cámara!';
        });
      }else{
         setState(() => this._qrcode = 'Error desconocido $e');
      }
    } on FormatException{
            setState(() => this._qrcode =
          'sin resultados, el usuario presionó el botón de volver antes de escanear algo)');
    } catch (e) {
      setState(() => this._qrcode = 'Error desconocido : $e');
    }
  }
}