import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'dart:io';
import 'package:udp/udp.dart';


main() async {
    var address = "239.1.2.3";//this is sameple address you have to add your own server address
    var port = 54321;
    var multicastEndpoint =
        Endpoint.multicast(InternetAddress(address), port: Port(port));
  
    var sender = await UDP.bind(Endpoint.any());
  
    sender.asStream().listen((datagram) {
      if (datagram != null) {
        var str = String.fromCharCodes(datagram.data).trim();
  
        stdout.write(str);
      }
    });
  
    await sender.send("Hello".codeUnits, multicastEndpoint);
  
    await Future.delayed(Duration(seconds:5));
  
    sender.close();
}
