import 'package:app/core/data/data_provider.dart';
import 'package:app/screen/tracking_screen/tracking_screen.dart';
import 'package:app/utility/app_color.dart';
import 'package:app/utility/extensions.dart';
import 'package:app/utility/utility_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:app/widget/order_tile.dart';


class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.dataProvider.getAllOrderByUser(context.userProvider.getLoginUsr());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.darkOrange),
        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: context.dataProvider.orders.length,
            itemBuilder: (context, index) {
              final order = context.dataProvider.orders[index];
              return OrderTile(
                paymentMethod: order.paymentMethod ?? '',
                items: '${(order.items.safeElementAt(0)?.productName ?? '')} & ${order.items!.length - 1} Items'  ,
                date: order.orderDate ?? '',
                status: order.orderStatus ?? 'pending',
                onTap: (){
                  if(order.orderStatus == 'shipped'){
                    Get.to(TrackingScreen(url: order.trackingUrl ?? ''));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
