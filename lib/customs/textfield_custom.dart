import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/utils/validations.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatefulWidget {
  final String hintText;
  bool obscureText, enabled;
  bool enabledTextField = true;
  TextInputType textInputType;
  int maxLength;
  int maxLines;
  TextInputAction textInputAction;
  String error;
  final TextEditingController controller;
  ValidateTypes validateTypes;
  ValidateState validateState;
  Widget suffixIcon;
  String suffixText;
  bool isVerifyButton;
  bool isVerify;
  String preValue;
  bool isName = false;
  List<TextInputFormatter> inputFormat;
  final void Function() onVerifyPressed;
  final Function() onCrossPressed;
  final Function() onNextPressed;
  bool isCrossIcon;
  Color hintTextColor;
  Color backgroundColor;
  Color inputBorderColor;
  TextStyle inputBoxTextStyle;
  TextStyle errorTextStyle;
  Widget prefixIcon;
  
  TextFieldCustom({
    Key key,
    this.maxLength,
    this.error,
    this.textInputAction,
    this.maxLines,
    @required this.hintText,
    this.obscureText,
    this.enabled,
    this.textInputType,
    @required this.controller,
    this.validateTypes,
    this.validateState,
    this.suffixIcon,
    this.suffixText,
    this.enabledTextField,
    this.isVerifyButton,
    this.isVerify,
    this.preValue,
    this.onVerifyPressed,
    this.inputFormat,
    this.isCrossIcon,
    this.onCrossPressed,
    this.hintTextColor,
    this.backgroundColor,
    this.inputBorderColor,
    this.inputBoxTextStyle,
    this.errorTextStyle,
    this.prefixIcon,
    this.onNextPressed,
    this.isName = false,
  }) : super(key: key);

  @override
  TextFieldCustomState createState() => TextFieldCustomState();
}

class TextFieldCustomState extends State<TextFieldCustom> {
  final _focusNode = FocusNode();
  bool isFocus = false;

  String hintText;
  bool obscureText, enabled;
  TextInputType textInputType;
  int maxLength;
  int maxLines;
  TextInputAction textInputAction;
  String error;
  TextEditingController controller;
  ValidateTypes validateTypes;
  ValidateState validateState;
  bool isVerifyButton;
  bool isVerify;
  bool iscrossIcon;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
      if (!_focusNode.hasFocus) {
        checkValidation(_focusNode.hasFocus);
      }
    });

    if (widget.controller != null) {
      widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length));
    }
    if (widget.obscureText == null) widget.obscureText = false;
    if (widget.enabled == null) widget.enabled = true;
    if (widget.textInputType == null) widget.textInputType = TextInputType.text;
    if (widget.maxLength == null) widget.maxLength = 50;
    if (widget.maxLines == null) widget.maxLines = 1;
    if (widget.textInputAction == null)
      widget.textInputAction = TextInputAction.next;
    if (widget.error == null) widget.error = "";
    if (widget.validateTypes == null)
      widget.validateTypes = ValidateTypes.empty;
    if (widget.validateState == null)
      widget.validateState = ValidateState.initial;
    if (widget.isVerifyButton == null) widget.isVerifyButton = false;
    if (widget.isCrossIcon == null) widget.isCrossIcon = false;
    if (widget.isVerify == null) widget.isVerify = false;

    hintText = widget.hintText;
    obscureText = widget.obscureText;
    enabled = widget.enabled;
    textInputType = widget.textInputType;
    maxLength = widget.maxLength;
    maxLines = widget.maxLines;
    textInputAction = widget.textInputAction;
    error = widget.error;
    controller = widget.controller;
    validateTypes = widget.validateTypes;
    validateState = widget.validateState;
    isVerifyButton = widget.isVerifyButton;
    iscrossIcon = widget.isCrossIcon;

    isVerify = widget.isVerify;
    if (controller.text.isNotEmpty) {
      checkValidation(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: widget.backgroundColor == null
                  ? Colors.transparent
                  : widget.backgroundColor,
              border: Border.all(
                color: widget.inputBorderColor == null
                    ? colorPrimary
                    : widget.inputBorderColor,
              ),
              borderRadius: BorderRadius.circular(2.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: TextField(
                  inputFormatters: widget.inputFormat,
                  onSubmitted: (text) {
                    if (textInputAction == TextInputAction.next)
                      FocusScope.of(context).nextFocus();
                  },
                  enabled: widget.enabledTextField,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  textInputAction: textInputAction,
                  obscureText: obscureText,
                  onChanged: (text) {
                    checkValidation(isFocus);
                    if (widget.preValue != "") {
                      setState(() {
                        if (text != widget.preValue) {
                          isVerify = false;
                        } else {
                          isVerify = true;
                        }
                      });
                    }
                  },
                  focusNode: _focusNode,
                  keyboardType: textInputType,
                  controller: controller,
                  cursorColor: colorBackground,
                  decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: widget.suffixIcon,
                      prefixIcon: widget.prefixIcon,
                      suffixText: widget.suffixText,
                      suffixStyle: commontextStyle(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: paddingSmall),
                      hintText: hintText,
                      hintStyle: inputBoxHintStyle(fontSize: textSmall + 2)),
                  style: widget.inputBoxTextStyle == null
                      ? commontextStyle(
                          fontSize: textSmall + 2, color: colorPrimary)
                      : widget.inputBoxTextStyle,
                ),
              ),
              validateState == ValidateState.inValidate && error.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: paddingSmall / 2),
                      child: Icon(
                        Icons.error,
                        color: colorError,
                        size: iconSize / 1.5,
                      ),
                    )
                  : validateTypes == ValidateTypes.password &&
                          controller.text.length > 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, right: paddingVerySmall),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: SvgPicture.asset(
                              obscureText
                                  ? SvgImages.visibilityOff
                                  : SvgImages.visibility,
                            ),
                          ),
                        )
                      : widget.isName
                          ? InkWell(
                              onTap:(){
                                  widget.onNextPressed();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: paddingVerySmall),
                                child: Icon(
                                  Icons.chevron_right,
                                  size: smallIconSize * 2,
                                  color: colorBackground,
                                ),
                              ),
                            )
                          : Container()
            ],
          ),
        ),
        validateState == ValidateState.inValidate && error.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    error,
                    style: widget.errorTextStyle == null
                        ? primaryRegular()
                        : widget.errorTextStyle,
                  ),
                ],
              )
            : Container()
      ],
    );
  }

  String getText() {
    return controller.text.trim();
  }

  bool checkValidation(bool isFocus) {
    String errorText = "";

    switch (validateTypes) {
      case ValidateTypes.name:
        {
          errorText = Validations.validateName(controller.text, hintText);
          break;
        }
      case ValidateTypes.empty:
        {
          errorText = Validations.validateEmpty(controller.text.trim(), hintText);
          break;
        }
      case ValidateTypes.email:
        {
          errorText = Validations.validateEmail(controller.text, hintText);
          break;
        }
      case ValidateTypes.mobile:
        {
          errorText = Validations.validateMobile(controller.text, hintText);
          break;
        }
      case ValidateTypes.userName:
        {
          errorText = Validations.validateUserName(controller.text, hintText);
          break;
        }
      case ValidateTypes.password:
        {
          errorText = Validations.validatePassword(controller.text, hintText);
          break;
        }
      case ValidateTypes.cvv:
        {
          errorText = Validations.validateCVV(controller.text, hintText);
          break;
        }
      case ValidateTypes.cardExpiryDate:
        {
          errorText = Validations.cardExpiryDate(controller.text, hintText);
          break;
        }
      case ValidateTypes.validatecardNumber:
        {
          errorText = Validations.validatecardNumber(controller.text, hintText);
        }
    }

    if (errorText.isNotEmpty) {
      if (validateState != ValidateState.inValidate) {
        setState(() {
          validateState = ValidateState.inValidate;
        });
      }
      if (!isFocus) {
        setState(() {
          error = errorText;
        });
      } else if (error.isNotEmpty) {
        setState(() {
          error = "";
        });
      }
      return true;
    } else {
      if (validateState != ValidateState.validate) {
        setState(() {
          error = "";
          validateState = ValidateState.validate;
        });
      }
      return false;
    }
  }

  void setError(String errorText) {
    if (validateState != ValidateState.inValidate) {
      setState(() {
        validateState = ValidateState.inValidate;
      });
    }
    setState(() {
      error = errorText;
    });
  }
}
