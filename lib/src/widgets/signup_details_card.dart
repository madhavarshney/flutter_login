import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'animated_button.dart';
import 'animated_text_form_field.dart';
import '../providers/auth.dart';
import '../providers/login_messages.dart';
import '../widget_helper.dart';
// import '../paddings.dart';

class SignupDetailsCard extends StatefulWidget {
  SignupDetailsCard({
    Key key,
    @required this.onBack,
    @required this.onSubmitCompleted,
  }) : super(key: key);

  final Function onBack;
  final Function onSubmitCompleted;

  @override
  SignupDetailsCardState createState() => SignupDetailsCardState();
}

class SignupDetailsCardState extends State<SignupDetailsCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formRecoverKey = GlobalKey();

  var _isSubmitting = false;
  var _gender = '';

  AnimationController _submitController;

  @override
  void initState() {
    super.initState();

    _submitController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _submitController.dispose();
  }

  Future<bool> _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (!_formRecoverKey.currentState.validate()) {
      return false;
    }
    // final auth = Provider.of<Auth>(context, listen: false);
    final messages = Provider.of<LoginMessages>(context, listen: false);

    _formRecoverKey.currentState.save();
    _submitController.forward();
    setState(() => _isSubmitting = true);
    // todo: integrate with shared auth loginData for 2nd param
    final error = null;
    // final error = await auth.onConfirmSignup(_code, null);

    if (error != null) {
      showErrorToast(context, error);
      setState(() => _isSubmitting = false);
      _submitController.reverse();
      return false;
    }

    showSuccessToast(context, messages.confirmSignupSuccess);
    setState(() => _isSubmitting = false);
    _submitController.reverse();
    widget?.onSubmitCompleted();
    return true;
  }

  // Future<bool> _resendCode() async {
  //   FocusScope.of(context).requestFocus(FocusNode());

  //   // final auth = Provider.of<Auth>(context, listen: false);
  //   final messages = Provider.of<LoginMessages>(context, listen: false);

  //   _submitController.forward();
  //   setState(() => _isSubmitting = true);
  //   // todo: integrate with shared auth loginData to pass name/email
  //   final error = null;
  //   // final error = await auth.onResendCode(null);

  //   if (error != null) {
  //     showErrorToast(context, error);
  //     setState(() => _isSubmitting = false);
  //     _submitController.reverse();
  //     return false;
  //   }

  //   showSuccessToast(context, messages.resendCodeSuccess);
  //   setState(() => _isSubmitting = false);
  //   _submitController.reverse();
  //   return true;
  // }

  // Widget _buildConfirmationCodeField(double width, LoginMessages messages) {
  //   return AnimatedTextFormField(
  //     width: width,
  //     labelText: messages.confirmationCodeHint,
  //     prefixIcon: Icon(FontAwesomeIcons.solidCheckCircle),
  //     textInputAction: TextInputAction.done,
  //     onFieldSubmitted: (value) => _submit(),
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return messages.confirmationCodeValidationError;
  //       }
  //       return null;
  //     },
  //     onSaved: (value) => _code = value,
  //   );
  // }

  Widget _buildDisplayNameField(double width, LoginMessages messages) {
    // final auth = Provider.of<Auth>(context);

    return AnimatedTextFormField(
      width: width,
      // enabled: auth.isSignup,
      textCapitalization: TextCapitalization.words,
      // loadingController: _loadingController,
      // inertiaController: _postSwitchAuthController,
      // inertiaDirection: TextFieldInertiaDirection.right,
      labelText: messages.displayNameHint,
      prefixIcon: Icon(FontAwesomeIcons.solidUserCircle),
      textInputAction: TextInputAction.next,
      // focusNode: _confirmPasswordFocusNode,
      onFieldSubmitted: (value) {
        // FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please provide your display name.';
        }
        return null;
      },
      // onSaved: (value) => _authData['name'] = value,
    );
  }

  Widget _buildPhoneNumberField(double width, LoginMessages messages) {
    // final auth = Provider.of<Auth>(context);

    return AnimatedTextFormField(
      width: width,
      // enabled: auth.isSignup,
      textCapitalization: TextCapitalization.words,
      // loadingController: _loadingController,
      // inertiaController: _postSwitchAuthController,
      // inertiaDirection: TextFieldInertiaDirection.right,
      // labelText: messages.displayNameHint,
      labelText: 'Phone Number',
      prefixIcon: Icon(FontAwesomeIcons.phoneSquareAlt),
      textInputAction: TextInputAction.next,
      // focusNode: _confirmPasswordFocusNode,
      keyboardType: TextInputType.phone,
      onFieldSubmitted: (value) {
        // FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please provide your phone number.';
        }
        return null;
      },
      // onSaved: (value) => _authData['name'] = value,
    );
  }

  Widget _buildGenderField(double width, LoginMessages messages) {
    // final auth = Provider.of<Auth>(context);

    return Container(
      width: width,
      padding: EdgeInsets.only(right: 16),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Radio(
                value: 'm',
                groupValue: _gender,
                onChanged: (String newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
              ),
              Text('Male'),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Radio(
                value: 'f',
                groupValue: _gender,
                onChanged: (String newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
              ),
              Text('Female'),
            ],
          ),
          // Wrap(
          //   crossAxisAlignment: WrapCrossAlignment.center,
          //   children: [
          //     Radio(
          //       value: 'o',
          //       groupValue: _gender,
          //       onChanged: (String newValue) {
          //         setState(() {
          //           _gender = newValue;
          //         });
          //       },
          //     ),
          //     Text('Other'),
          //   ],
          // ),
          // Expanded(
          //   child: RadioListTile(
          //     title: Text('Male'),
          //     value: 'm',
          //   ),
          // ),
          // Expanded(
          //   child: RadioListTile(
          //     title: Text('Female'),
          //     value: 'f',
          //   ),
          // ),
          // Expanded(
          //   child: RadioListTile(
          //     title: Text('Other'),
          //     value: 'o',
          //   ),
          // ),
        ],
      ),
    );
    // return AnimatedTextFormField(
    //   width: width,
    //   // enabled: auth.isSignup,
    //   textCapitalization: TextCapitalization.words,
    //   // loadingController: _loadingController,
    //   // inertiaController: _postSwitchAuthController,
    //   // inertiaDirection: TextFieldInertiaDirection.right,
    //   // labelText: messages.displayNameHint,
    //   labelText: 'Phone Number',
    //   prefixIcon: Icon(FontAwesomeIcons.phoneSquareAlt),
    //   textInputAction: TextInputAction.next,
    //   // focusNode: _confirmPasswordFocusNode,
    //   keyboardType: TextInputType.phone,
    //   onFieldSubmitted: (value) {
    //     // FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
    //   },
    //   validator: (value) {
    //     if (value.isEmpty) {
    //       return 'Please provide your phone number.';
    //     }
    //     return null;
    //   },
    //   // onSaved: (value) => _authData['name'] = value,
    // );
  }

  // Widget _buildResendCode(ThemeData theme, LoginMessages messages, Auth auth) {
  //   return FlatButton(
  //     child: Text(
  //       messages.resendCodeButton,
  //       style: theme.textTheme.body1,
  //       textAlign: TextAlign.left,
  //     ),
  //     onPressed: !_isSubmitting ? _resendCode : null,
  //   );
  // }

  Widget _buildSignupButton(ThemeData theme, LoginMessages messages) {
    return AnimatedButton(
      controller: _submitController,
      text: messages.confirmSignupButton,
      onPressed: !_isSubmitting ? _submit : null,
    );
  }

  Widget _buildBackButton(ThemeData theme, LoginMessages messages) {
    return FlatButton(
      child: Text(messages.goBackButton),
      onPressed: !_isSubmitting ? widget.onBack : null,
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textColor: theme.primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final messages = Provider.of<LoginMessages>(context, listen: false);
    // final auth = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery
        .of(context)
        .size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return FittedBox(
      child: Card(
        child: Container(
          padding: const EdgeInsets.only(
            left: cardPadding,
            top: cardPadding + 10.0,
            right: cardPadding,
            bottom: cardPadding,
          ),
          width: cardWidth,
          alignment: Alignment.center,
          child: Form(
            key: _formRecoverKey,
            child: Column(
              children: <Widget>[
                // Text(
                //   messages.confirmSignupIntro,
                //   textAlign: TextAlign.center,
                //   style: theme.textTheme.body1,
                // ),
                // SizedBox(height: 20),
                // _buildConfirmationCodeField(textFieldWidth, messages),
                _buildDisplayNameField(textFieldWidth, messages),
                SizedBox(height: 20),
                _buildPhoneNumberField(textFieldWidth, messages),
                SizedBox(height: 20),
                _buildGenderField(textFieldWidth, messages),
                SizedBox(height: 20),
                // _buildResendCode(theme, messages, auth),
                _buildSignupButton(theme, messages),
                _buildBackButton(theme, messages),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
