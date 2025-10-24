import 'package:flutter/material.dart';
import 'package:pastor_lili/core/common/styles/global_text_style.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payments",
          style: getTextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Image.asset('assets/images/visa.svg.png', width: 40, height: 30),

            SizedBox(width: 12),
            Image.asset(
              'assets/images/american_express.png',
              width: 40,
              height: 30,
            ),
            SizedBox(width: 12),
            Image.asset('assets/images/master_card.png', width: 40, height: 30),
          ],
        ),
      ],
    );
  }
}
