import 'package:flutter/material.dart';

import '../component.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const box =  SizedBox(height: 32);
    const errorColor = Colors.white;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          box,
          Text(
            error!,
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          box,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              // color: Colors.white,
              child: Text(
                'إعادة المحاولة',
                style: TextStyle(
                  color: co,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (callback != null) callback!();
              },
            ),
          )
        ],
      ),
    );
  }
}
