import 'dart:convert';

import 'package:http/http.dart' as http;

class cashFreeToken{
  getToken(String orderId,int amount) async{
    var url="https://api.cashfree.com/api/v2/cftoken/order";
    var headers={
      'Content-Type': 'application/json',
      'x-client-id': '696534d12c6f32ccdcdcd0e4d35696',
      'x-client-secret': 'aad76417765f942fa81fd8621e2cd43b4137bad6'
    };
    var body=jsonEncode({
      "orderId": orderId,
      "orderAmount":amount,
      "orderCurrency": "INR"
    });
    var tokenData=await http.post(url,headers: headers,body: body);
    var response=jsonDecode(tokenData.body);
    print(response);
    return response['cftoken'];
}
}