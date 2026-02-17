import 'package:packages_extensions/src/rational_extension_base.dart';
import 'package:power_extensions/big_int_extension.dart';
import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

extension DecimalExtension on Decimal {
  /// HasFinitePrecision
  ///
  /// Returns `true` if this [Decimal] has a finite precision.
  /// Having a finite precision means that the number can be exactly represented
  /// as decimal with a finite number of fractional digits.
  @Deprecated('Last release of Decimal only manages finite precision')
  bool get hasFinitePrecision => true;

  /// IsNegative
  ///
  /// Returns `true` if this [Decimal] is lesser than zero.
  bool get isNegative => sign < 0;

  /// IsZero
  ///
  /// Returns `true` if this [Decimal] is = zero.
  bool get isZero => this == Decimal.zero;

  static final _rTen = Rational.fromInt(10);

  /// Significand
  ///
  /// It is the significand of this number,
  /// (The number without the trailing zeros).
  BigInt get significand => BigInt.parse(significandString);

  /// Significand Length
  ///
  /// It is the number of digits of the significand of this number,
  /// (The number without the trailing zeros).
  /// When zero the method returns 1
  int get significandLength => significandString.length;

  /// Significand Length
  ///
  /// Returns a string representing the significand
  /// (The number without the trailing zeros).
  String get significandString {
    if (toRational().denominator == BigInt.one ||
        toRational().denominator.isPowerOfTen) {
      return toRational().numerator.significandString;
    }
    int locScale = scale;
    if (locScale == 0) {
      return toBigInt.toString();
    }
    return (toRational() * Decimal.ten.pow(locScale))
        .toBigInt()
        .significandString;
  }

  /// The scale of this [Decimal].
  ///
  /// The scale is the number of digits after the decimal point.
  /// This method works like the scale one, but it is faster.
  ///
  /// ```dart
  /// Decimal.parse('1.5').scaleFast; // => 1
  /// Decimal.parse('1').scaleFast; // => 0
  /// Decimal.parse('120').scaleFast; // => 0
  /// ```
  /// Please note that his is the effective scale, i.e. 1.010 return 2
  /// Also, this method does not consider negative scales
  int get scaleFast {
    var i = 0;
    var x = toRational();
    var denominator = x.denominator.abs();
    if (denominator.isPowerOfTen) {
      var originalDenLength = denominator.toString().length;
      x = Rational(x.numerator,
          BigIntExtensionBase.ten.pow(x.numerator.abs().toString().length));
      i = originalDenLength - x.denominator.abs().toString().length;
    }
    while (!x.isInteger) {
      i++;
      x *= _rTen;
    }
    return i;
  }

  /// The scale of this [Decimal].
  ///
  /// The scale is the number of digits after the decimal point or the exponent
  /// (in negative form) of ten that multiplied for the significand returns the
  /// originl number.
  ///
  /// The number can be represented as: significand * 10^(-scaleAdv)
  ///
  /// ```dart
  /// Decimal.parse('1.5').scaleAdv; // => 1
  /// Decimal.parse('1').scaleAdv; // => 0
  /// Decimal.parse('120').scaleAdv; // => -1
  /// ```
  /// Please note that this is the effective scale, i.e. 1.010 return 2
  /// Also, this method calculate also negative scales
  int get scaleAdv => isInteger ? toRational().numerator.scale : scaleFast;

  /// The precision of this [Decimal].
  ///
  /// The precision is the number of digits in the unscaled value.
  ///
  /// ```dart
  /// Decimal.parse('0').precision; // => 1
  /// Decimal.parse('1').precision; // => 1
  /// Decimal.parse('1.5').precision; // => 2
  /// Decimal.parse('0.5').precision; // => 2
  /// ```
  /// Please note that this is the effective precision, i.e. 1.010 returns 3
  /// because the last zero is not considered
  int get precisionFast => scaleFast + toBigInt().precision;

  /// Format a String to a certain position
  ///
  /// Provides a faster approach than the orginal method
  /// **Please note** that in some cases the result is different from
  /// base calss method `toStringAsPrecision()`
  String toStringAsPrecisionFast(int requiredPrecision) {
    if (requiredPrecision <= 0) {
      throw ArgumentError.value(requiredPrecision);
    }

    var locPrecision = precisionFast;
    var locScale = scaleFast;
    var shiftExponent = requiredPrecision - locPrecision + locScale;

    if (locPrecision <= requiredPrecision) {
      return toStringAsFixed(shiftExponent);
    }

    Decimal value;
    if (shiftExponent == 0) {
      /// No shifting needed
      value = this;
    } else {
      /// given the exponent, we calculate the value to be used in order
      /// to shift our number
      var coefficient = Decimal.ten.pow(shiftExponent);

      /// here we shift the number and round, so that we loose the non required
      /// precision digits (if any), and then we move back the digits in the
      /// opposite direction.
      value = ((toRational() * coefficient).round().toRational() / coefficient)
          .roundToDecimal();
    }

    return shiftExponent <= 0
        ? value.round().toString()
        : value.toStringAsFixed(shiftExponent);
  }
}
