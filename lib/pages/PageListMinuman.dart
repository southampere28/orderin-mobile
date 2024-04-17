import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orderez/configuration/Constant.dart';
import 'package:orderez/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:orderez/view/EditMenu.dart';

class PageMinuman extends StatefulWidget {
  const PageMinuman({super.key});

  @override
  State<PageMinuman> createState() => _PageMinumanState();
}

class _PageMinumanState extends State<PageMinuman> {
  late List<Product> listProd = [];

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (timeStamp) async {
  //       try {
  //         await getDataProduct(context);
  //       } catch (ex) {
  //         Fluttertoast.showToast(msg: "ERROR : ${ex.toString()}");
  //       }
  //     },
  //   );
  // }

  Future<void> getDataProduct(BuildContext context) async {
    final String apiUrl = '${OrderinAppConstant.baseURL}/dataproduct';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {

          // tampilkan data
          List<dynamic> data = responseData['data'];

          listProd = data.map((item) => Product.fromJson(item)).toList();
       
        } else {
          // tampilkan error nya
          print('data gagal di dapat');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed Get Data'),
            content: Text('error 02'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<Product>> products(BuildContext context) async {
    await getDataProduct(context);
    return listProd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>?>(
        future: products(context),
        builder: (context, snapshot) {
          // dalam loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }

          // jika error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          // jika data didapatkan
          if (snapshot.hasData) {
            return GridView.count(
              padding: const EdgeInsets.all(5),
              crossAxisCount: 2,
              children: listProd.map(
                (drink) {
                  return _buildCard(
                      drink.kodeProduct.toString(),
                      drink.namaProduct ?? '',
                      drink.hargaProduct.toString(),
                      drink.gambarProduct ?? '',
                      drink.stockProduct ?? '',
                      );
                },
              ).toList(),
            );
          }

          return const Center(
            child: Text(
              'Something Wrong',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String IDproduct, String name, String price, String image, String stock) {
    String isOutOfStock = stock;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        margin: const EdgeInsets.all(3),
        child: InkWell(
          onTap: () {
                  print('u clicked this2');
                  Fluttertoast.showToast(msg: "STATUS : Inkwell Clicked ID ${IDproduct}");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditMenu(idprod: IDproduct, name: name, jenis: "Minuman")));
                },
          splashColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'lib/images/${image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Text(
                  isOutOfStock == 'habis' ? 'Stok Habis' : price,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: isOutOfStock == 'habis'
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isOutOfStock == 'habis' ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> dataList = [
  {
    'name': 'Tahu Goreng',
    'description': 'Ini makanan terbuat dari tahu',
    'price': 'Rp. 5000',
    'image': 'tahugoreng.jpg',
    'stock': '1',
  },
  {
    'name': 'Pisang Goreng',
    'description': 'Ini makanan terbuat dari pisang',
    'price': 'Rp. 4000',
    'image': 'tahugoreng.jpg',
    'stock': '0',
  },
];



// class PageMinuman extends StatefulWidget {
//   const PageMinuman({super.key});

//   @override
//   State<PageMinuman> createState() => _PageMinumanState();
// }

// class _PageMinumanState extends State<PageMinuman> {
//   late List<Product> listProd = [];

//   Future<void> getDataProduct() async {
//     final String apiUrl = '${OrderinAppConstant.baseURL}/dataproduct';

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       List<Product> dataobj = [];

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         if (responseData['status'] == 'success') {
//           // tampilkan data
//           List<dynamic> data = responseData['data'];

//           listProd = data.map((item) => Product.fromJson(item)).toList();
//           // });
//           print(listProd);
//           print(data);
//           Logger().i('its works');
//         } else {
//           // tampilkan error nya
//           print('data gagal di dapat');
//         }
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Failed Get Data'),
//             content: Text('error 02'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//     //   try {
//     getDataProduct();
//       // } catch (ex) {
//         // Fluttertoast.showToast(msg: "ERROR : ${ex.toString()}");
//         // print("error => ${ex}");
//     //   }
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         padding: const EdgeInsets.all(5),
//         crossAxisCount: 2,
//         children: listProd.map((drink) {
//           return _buildCard(
//               drink.namaProduct ?? '',
//               drink.hargaProduct.toString(),
//               drink.gambarProduct ?? '',
//               drink.stockProduct);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCard(String name, String price, String image, String stock) {
//     String isOutOfStock = stock;

//     return Padding(
//       padding: const EdgeInsets.all(6),
//       child: Card(
//         margin: const EdgeInsets.all(3),
//         child: InkWell(
//           onTap: isOutOfStock == "habis" ? () {} : () {},
//           splashColor: Colors.white,
//           child: Padding(
//             padding: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.asset(
//                       // 'lib/images/${image}',
//                       'lib/images/tahugoreng.jpg',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   isOutOfStock== "habis" ? 'Stok Habis' : price,
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: isOutOfStock== "habis" ? FontWeight.bold : FontWeight.normal,
//                     color: isOutOfStock== "habis" ? Colors.red : null,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// final List<Map<String, String>> dataList = [
//   {
//     'name': 'Tahu Goreng',
//     'description': 'Ini makanan terbuat dari tahu',
//     'price': 'Rp. 5000',
//     'image': 'tahugoreng.jpg',
//     'stock': '1',
//   },
//   {
//     'name': 'Pisang Goreng',
//     'description': 'Ini makanan terbuat dari pisang',
//     'price': 'Rp. 4000',
//     'image': 'tahugoreng.jpg',
//     'stock': '0',
//   },
// ];
