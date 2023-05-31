import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: ((context, index) {
              return Card(
                child: KListTile(
                  leading: Container(
                    height: 45.0,
                    width: 45.0,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: context.theme.primaryColor, width: 1.3),
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius45,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                          'assets/svgs/order.svg',
                          fit: BoxFit.cover,
                          colorFilter: context.theme.primaryColor.toColorFilter,
                        ),
                      ),
                    ),
                  ),
                  title: Text('Order Name: $index'),
                  subtitle: Text('Order Email: $index'),
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
