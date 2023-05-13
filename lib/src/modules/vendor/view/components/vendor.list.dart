import 'package:flutter/material.dart';
import '../../../../utils/extensions/extensions.dart';

import '../../../../constants/constants.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';

class VendorList extends StatelessWidget {
  const VendorList({super.key});

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
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/gifs/loading.gif'),
                        image: NetworkImage(
                            'https://picsum.photos/250?image=$index'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text('Vendor Name: $index'),
                  subtitle: Text('Vendor Email: $index'),
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
