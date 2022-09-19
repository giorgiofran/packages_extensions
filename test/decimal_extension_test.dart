import 'package:decimal/decimal.dart';
import 'package:packages_extensions/packages_extensions.dart';
import 'package:test/test.dart';

import '../performance/decimal_classes/scale.dart';
import '../performance/decimal_classes/significand_string_original.dart';

void main() {
  Decimal dec1 = Decimal.fromInt(5);
  Decimal dec2 = Decimal.parse('120');
  Decimal dec3 = Decimal.parse('0.120');
  Decimal dec4 = Decimal.parse('10.012');
  Decimal dec5 = Decimal.parse('010.0120');
  Decimal dec6 = Decimal.parse('9.999999999999999999999999999999999E-6144');
  Decimal dec7 = Decimal.parse('9.999999999999999999999999999999999E+6144');
  Decimal dec8 = Decimal.parse('9999999999999999999999999999999999E+6144');
  Decimal dec9 = Decimal.parse('-9.999999999999999999999999999999999E-6144');
  Decimal dec10 = Decimal.parse('-50');
  Decimal dec11 = Decimal.parse('-5');
  Decimal dec12 = Decimal.parse('0');
  Decimal dec13 = Decimal.parse('-1');
  Decimal dec14 = Decimal.parse('-010.0120');

  group('Significand String', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Simple integer', () {
      expect(dec1.significandString, '5');
      expect(dec1.significandString, significandStringOriginal(dec1));
    });
    test('Integer that can be divided by ten', () {
      expect(dec2.significandString, '12');
      expect(dec2.significandString, significandStringOriginal(dec2));
    });
    test('Decimal < 1', () {
      expect(dec3.significandString, '12');
      expect(dec3.significandString, significandStringOriginal(dec3));
    });
    test('Decimal > 1', () {
      expect(dec4.significandString, '10012');
      expect(dec4.significandString, significandStringOriginal(dec4));
    });
    test('Decimal > 1 with leading and trailing zeros', () {
      expect(dec5.significandString, '10012');
      expect(dec5.significandString, significandStringOriginal(dec5));
    });
    test('Very Small Number', () {
      expect(dec6.significandString, '9999999999999999999999999999999999');
      expect(dec6.significandString, significandStringOriginal(dec6));
    });
    test('Very High Number with decimal mantissa', () {
      expect(dec7.significandString, '9999999999999999999999999999999999');
      expect(dec7.significandString, significandStringOriginal(dec7));
    });

    test('Very High Number with integer mantissa', () {
      expect(dec8.significandString, '9999999999999999999999999999999999');
      expect(dec8.significandString, significandStringOriginal(dec8));
    });
    test('Very small negative Number', () {
      expect(dec9.significandString, '9999999999999999999999999999999999');
      expect(dec9.significandString, significandStringOriginal(dec9));
    });

    test('Negative Integer that can be divided by ten', () {
      expect(dec10.significandString, '5');
      expect(dec10.significandString, significandStringOriginal(dec10));
    });
    test('Negative Integer less than ten', () {
      expect(dec11.significandString, '5');
      expect(dec11.significandString, significandStringOriginal(dec11));
    });
    test('Zero', () {
      expect(dec12.significandString, '0');
      expect(dec12.significandString, significandStringOriginal(dec12));
    });
    test('-1', () {
      expect(dec13.significandString, '1');
      expect(dec13.significandString, significandStringOriginal(dec13));
    });
    test('negative Decimal > 1 with leading and trailing zeros', () {
      expect(dec14.significandString, '10012');
      expect(dec14.significandString, significandStringOriginal(dec14));
    });
  });

  group('Significand', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Simple integer', () {
      expect(dec1.significand, BigInt.parse('5'));
    });
    test('Integer that can be divided by ten', () {
      expect(dec2.significand, BigInt.parse('12'));
    });
    test('Decimal < 1', () {
      expect(dec3.significand, BigInt.parse('12'));
    });
    test('Decimal > 1', () {
      expect(dec4.significand, BigInt.parse('10012'));
    });
    test('Decimal > 1 with leading and trailing zeros', () {
      expect(dec5.significand, BigInt.parse('10012'));
    });
    test('Very Small Number', () {
      expect(
          dec6.significand, BigInt.parse('9999999999999999999999999999999999'));
    });
    test('Very High Number with decimal mantissa', () {
      expect(
          dec7.significand, BigInt.parse('9999999999999999999999999999999999'));
    });

    test('Very High Number with integer mantissa', () {
      expect(
          dec8.significand, BigInt.parse('9999999999999999999999999999999999'));
    });
    test('Very small negative Number', () {
      expect(
          dec9.significand, BigInt.parse('9999999999999999999999999999999999'));
    });

    test('Negative Integer that can be divided by ten', () {
      expect(dec10.significand, BigInt.parse('5'));
    });
    test('Negative Integer less than ten', () {
      expect(dec11.significand, BigInt.parse('5'));
    });
    test('Zero', () {
      expect(dec12.significand, BigInt.parse('0'));
    });
    test('-1', () {
      expect(dec13.significand, BigInt.parse('1'));
    });
    test('negative Decimal > 1 with leading and trailing zeros', () {
      expect(dec14.significand, BigInt.parse('10012'));
    });
  });

  group('Significand length', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Simple integer', () {
      expect(dec1.significandLength, 1);
    });
    test('Integer that can be divided by ten', () {
      expect(dec2.significandLength, 2);
    });
    test('Decimal < 1', () {
      expect(dec3.significandLength, 2);
    });
    test('Decimal > 1', () {
      expect(dec4.significandLength, 5);
    });
    test('Decimal > 1 with leading and trailing zeros', () {
      expect(dec5.significandLength, 5);
    });
    test('Very Small Number', () {
      expect(dec6.significandLength, 34);
    });
    test('Very High Number with decimal mantissa', () {
      expect(dec7.significandLength, 34);
    });

    test('Very High Number with integer mantissa', () {
      expect(dec8.significandLength, 34);
    });
    test('Very small negative Number', () {
      expect(dec9.significandLength, 34);
    });

    test('Negative Integer that can be divided by ten', () {
      expect(dec10.significandLength, 1);
    });
    test('Negative Integer less than ten', () {
      expect(dec11.significandLength, 1);
    });
    test('Zero', () {
      expect(dec12.significandLength, 1);
    });
    test('-1', () {
      expect(dec13.significandLength, 1);
    });
    test('negative Decimal > 1 with leading and trailing zeros', () {
      expect(dec14.significandLength, 5);
    });
  });

  group('Scale', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Simple integer', () {
      expect(dec1.scaleAdv, 0);
      expect(dec1.scaleFast, 0);
      expect(dec1.scale, 0);
    });
    test('Integer that can be divided by ten', () {
      expect(dec2.scaleAdv, -1);
      expect(dec2.scaleFast, 0);
      expect(dec2.scale, 0);
    });
    test('Decimal < 1', () {
      expect(dec3.scaleAdv, 2);
      expect(dec3.scaleFast, 2);
      expect(dec3.scale, 2);
    });
    test('Decimal > 1', () {
      expect(dec4.scaleAdv, 3);
      expect(dec4.scaleFast, 3);
      expect(dec4.scale, 3);
    });
    test('Decimal > 1 with leading and trailing zeros', () {
      expect(dec5.scaleAdv, 3);
      expect(dec5.scaleFast, 3);
      expect(dec5.scale, 3);
    });
    test('Very Small Number', () {
      expect(dec6.scaleAdv, 6177);
      expect(dec6.scaleFast, 6177);
      expect(dec6.scale, 6177);
    });
    test('Very High Number with decimal mantissa', () {
      expect(dec7.scaleAdv, -6111);
      expect(dec7.scaleFast, 0);
      expect(dec7.scale, 0);
    });

    test('Very High Number with integer mantissa', () {
      expect(dec8.scaleAdv, -6144);
      expect(dec8.scaleFast, 0);
      expect(dec8.scale, 0);
    });
    test('Very small negative Number', () {
      expect(dec9.scaleAdv, 6177);
      expect(dec9.scaleFast, 6177);
      expect(dec9.scale, 6177);
    });

    test('Negative Integer that can be divided by ten', () {
      expect(dec10.scaleAdv, -1);
      expect(dec10.scaleFast, 0);
      expect(dec10.scale, 0);
    });
    test('Negative Integer less than ten', () {
      expect(dec11.scaleAdv, 0);
      expect(dec11.scaleFast, 0);
      expect(dec11.scale, 0);
    });
    test('Zero', () {
      expect(dec12.scaleAdv, 0);
      expect(dec12.scaleFast, 0);
      expect(dec12.scale, 0);
    });
    test('-1', () {
      expect(dec13.scaleAdv, 0);
      expect(dec13.scaleFast, 0);
      expect(dec13.scale, 0);
    });
    test('negative Decimal > 1 with leading and trailing zeros', () {
      expect(dec14.scaleAdv, 3);
      expect(dec14.scaleFast, 3);
      expect(dec14.scale, 3);
    });
  });

  group('Precision', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Simple integer', () {
      expect(dec1.precisionFast, 1);
      expect(dec1.precision, 1);
    });
    test('Integer that can be divided by ten', () {
      expect(dec2.precisionFast, 3);
      expect(dec2.precision, 3);
    });
    test('Decimal < 1', () {
      expect(dec3.precisionFast, 3);
      expect(dec3.precision, 3);
    });
    test('Decimal > 1', () {
      expect(dec4.precisionFast, 5);
      expect(dec4.precision, 5);
    });
    test('Decimal > 1 with leading and trailing zeros', () {
      expect(dec5.precisionFast, 5);
      expect(dec5.precision, 5);
    });
    test('Very Small Number', () {
      expect(dec6.precisionFast, 6178);
      expect(dec6.precision, 6178);
    });
    test('Very High Number with decimal mantissa', () {
      expect(dec7.precisionFast, 6145);
      expect(dec7.precision, 6145);
    });

    test('Very High Number with integer mantissa', () {
      expect(dec8.precisionFast, 6178);
      expect(dec8.precision, 6178);
    });
    test('Very small negative Number', () {
      expect(dec9.precisionFast, 6178);
      expect(dec9.precision, 6178);
    });

    test('Negative Integer that can be divided by ten', () {
      expect(dec10.precisionFast, 2);
      expect(dec10.precision, 2);
    });
    test('Negative Integer less than ten', () {
      expect(dec11.precisionFast, 1);
      expect(dec11.precision, 1);
    });
    test('Zero', () {
      expect(dec12.precisionFast, 1);
      expect(dec12.precision, 1);
    });
    test('-1', () {
      expect(dec13.precisionFast, 1);
      expect(dec13.precision, 1);
    });
    test('negative Decimal > 1 with leading and trailing zeros', () {
      expect(dec14.precisionFast, 5);
      expect(dec14.precision, 5);
    });
  });
}
