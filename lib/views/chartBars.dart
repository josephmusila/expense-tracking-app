import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfSpendAmount;

  ChartBar(this.label, this.spendingAmount, this.percentageOfSpendAmount);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: Text('\$ ${spendingAmount.toStringAsFixed(0)}')),
            SizedBox(
              height: 4,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOfSpendAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text(label))),
          ],
        );
      }),
    );
  }
}
