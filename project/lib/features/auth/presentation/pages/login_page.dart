import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/theme/welcome_page_styles.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginPage({super.key, required this.toggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool hasUppercase = false;
  bool hasLetter = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool isEmailValid = false;

  // 焦點控制
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode loginButtonFocus = FocusNode();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isLoggingIn = false;

  // 動畫控制
  final double _initialButtonScale = 1.0;
  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePassword);
    emailController.addListener(_validateEmail);

    // 設置焦點監聽
    emailFocus.addListener(() {
      setState(() {
        isEmailFocused = emailFocus.hasFocus;
      });
    });

    passwordFocus.addListener(() {
      setState(() {
        isPasswordFocused = passwordFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    loginButtonFocus.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = emailController.text;
    setState(() {
      // 更完整的電子郵件格式驗證
      isEmailValid = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(email);
    });
  }

  void _validatePassword() {
    final password = passwordController.text;
    setState(() {
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasMinLength = password.length >= 8 && password.length <= 20;
    });
  }

  // 檢查密碼是否有效
  bool get isPasswordValid =>
      hasUppercase && hasLetter && hasNumber && hasMinLength;

  // 檢查表單是否可以提交
  bool get canSubmit => isEmailValid && isPasswordValid && !isLoggingIn;

  void _handleLogin() {
    if (!canSubmit) return;

    setState(() {
      isLoggingIn = true;
    });

    // 模擬登錄過程
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoggingIn = false;
        });
        // TODO: 實際登錄實現
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // 響應式間距 - 使用8pt網格系統
    final gridUnit = screenHeight * 0.01; // 基礎間距單位 (1% 約8pt)

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          // 點擊空白處時取消鍵盤焦點
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              // 主內容區
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 頂部工具列 - 保持簡潔
                    SizedBox(
                      height: gridUnit * 6, // 48pt
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 返回按鈕 - 保持最小 44x44pt 的觸碰區域
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(
                                height: gridUnit * 6, // 48pt
                                width: gridUnit * 6, // 48pt
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),

                          // 幫助按鈕
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                // TODO: 顯示幫助信息
                              },
                              child: SizedBox(
                                height: gridUnit * 6, // 48pt
                                width: gridUnit * 6, // 48pt
                                child: const Icon(
                                  Icons.help_outline,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 標題區塊 - 使用更大的字體和視覺重量
                    Padding(
                      padding: EdgeInsets.only(
                        top: gridUnit * 2, // 16pt
                        bottom: gridUnit * 4, // 32pt
                      ),
                      child: Text(
                        'Welcome back!',
                        style: GoogleFonts.poppins(
                          fontSize: gridUnit * 4, // 32pt (H2)
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                    ),

                    // 表單區域 - 使用彈性佈局
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(), // iOS風格彈性效果
                        padding: EdgeInsets.only(
                          bottom: gridUnit * 24,
                        ), // 添加底部間距以避免內容被按鈕遮擋
                        children: [
                          // 表單區塊
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email 輸入框 - 標籤和輸入框在同一行
                                _buildTextField(
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  hintText: 'yourname@example.com',
                                  labelText: 'Email',
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  isValid: isEmailValid,
                                  isFocused: isEmailFocused,
                                  errorText:
                                      emailController.text.isNotEmpty &&
                                              !isEmailValid
                                          ? 'Please enter a valid email'
                                          : null,
                                  onSubmitted: (_) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(passwordFocus);
                                  },
                                ),

                                SizedBox(height: gridUnit * 3), // 24pt
                                // 密碼輸入框 - 標籤和輸入框在同一行
                                _buildTextField(
                                  controller: passwordController,
                                  focusNode: passwordFocus,
                                  hintText: '••••••••',
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: obscureText,
                                  isValid: isPasswordValid,
                                  isFocused: isPasswordFocused,
                                  suffixIcon: GestureDetector(
                                    onTapDown: (_) {
                                      setState(() {
                                        obscureText = false;
                                      });
                                    },
                                    onTapUp: (_) {
                                      setState(() {
                                        obscureText = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        obscureText = true;
                                      });
                                    },
                                    excludeFromSemantics: true,
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.all(gridUnit * 1.5),
                                      child: Icon(
                                        obscureText
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: gridUnit * 2.2, // 18pt
                                      ),
                                    ),
                                  ),
                                  errorText:
                                      passwordController.text.isNotEmpty &&
                                              !isPasswordValid
                                          ? 'Please meet all password requirements'
                                          : null,
                                  onSubmitted: (_) => _handleLogin(),
                                ),

                                SizedBox(height: gridUnit * 1.5), // 12pt
                                // 密碼要求提示 - 自動適應螢幕寬度
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Flexible(
                                        child: _PasswordHint(
                                          text: 'uppercase',
                                          isValid: hasUppercase,
                                          fontSize: screenWidth * 0.033,
                                        ),
                                      ),
                                      Flexible(
                                        child: _PasswordHint(
                                          text: 'letter',
                                          isValid: hasLetter,
                                          fontSize: screenWidth * 0.033,
                                        ),
                                      ),
                                      Flexible(
                                        child: _PasswordHint(
                                          text: 'number',
                                          isValid: hasNumber,
                                          fontSize: screenWidth * 0.033,
                                        ),
                                      ),
                                      Flexible(
                                        child: _PasswordHint(
                                          text: '8~20 words',
                                          isValid: hasMinLength,
                                          fontSize: screenWidth * 0.033,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: gridUnit * 2), // 16pt
                                // 忘記密碼按鈕 - 明確的視覺提示
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: 實現忘記密碼功能
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          WelcomePageStyles.brandColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: gridUnit, // 8pt
                                        vertical: gridUnit * 0.5, // 4pt
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Forgot Password?',
                                      style: GoogleFonts.poppins(
                                        fontSize: gridUnit * 1.5, // 14pt (H6)
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                                // 留出空間以確保表單可滾動
                                SizedBox(height: gridUnit * 3), // 24pt
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 底部按鈕區域 - 固定在底部
              Positioned(
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
                bottom: screenHeight * 0.02,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 登錄按鈕 - 使用強調色和觸覺反饋
                    GestureDetector(
                      onTapDown: (_) {
                        if (canSubmit) {
                          setState(() => _buttonScale = 0.96); // 按下縮放效果
                        }
                      },
                      onTapUp: (_) {
                        setState(() => _buttonScale = _initialButtonScale);
                        _handleLogin();
                      },
                      onTapCancel: () {
                        setState(() => _buttonScale = _initialButtonScale);
                      },
                      child: AnimatedScale(
                        scale: _buttonScale,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          width: double.infinity,
                          height: gridUnit * 6, // 48pt
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              gridUnit * 1.6,
                            ), // 12pt
                            boxShadow: [
                              BoxShadow(
                                color: WelcomePageStyles.brandColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: canSubmit ? _handleLogin : null,
                            focusNode: loginButtonFocus,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: WelcomePageStyles.brandColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: WelcomePageStyles
                                  .brandColor
                                  .withValues(alpha: 0.6),
                              disabledForegroundColor: Colors.white.withValues(
                                alpha: 0.8,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  gridUnit * 1.6,
                                ), // 12pt
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child:
                                isLoggingIn
                                    ? SizedBox(
                                      width: gridUnit * 2.4, // 19pt
                                      height: gridUnit * 2.4, // 19pt
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                    : Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                        fontSize: gridUnit * 2, // 16pt
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: gridUnit * 2), // 16pt
                    // 替代登錄方式
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withValues(alpha: 0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: gridUnit * 2,
                          ), // 16pt
                          child: Text(
                            'Or Login with',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: gridUnit * 1.6, // 13pt
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withValues(alpha: 0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: gridUnit * 2), // 16pt
                    // 社交登錄按鈕 - 保持視覺一致性
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _SocialButton(
                          icon: Icons.facebook,
                          backgroundColor: const Color(0xFF3b5998),
                          iconColor: Colors.white,
                          onPressed: () {},
                          size: gridUnit * 5.5, // 44pt (最小觸碰目標)
                        ),
                        SizedBox(width: gridUnit * 3), // 24pt
                        _SocialButton(
                          icon: Icons.g_mobiledata,
                          iconColor: Colors.white,
                          backgroundColor: const Color(0xFFDB4437),
                          onPressed: () {},
                          size: gridUnit * 5.5, // 44pt
                        ),
                        SizedBox(width: gridUnit * 3), // 24pt
                        _SocialButton(
                          icon: Icons.apple,
                          backgroundColor: Colors.black,
                          iconColor: Colors.white,
                          onPressed: () {},
                          size: gridUnit * 5.5, // 44pt
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 構建輸入框的通用方法
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData prefixIcon,
    String? labelText,
    bool obscureText = false,
    bool isValid = true,
    bool isFocused = false,
    String? errorText,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String)? onSubmitted,
  }) {
    final gridUnit = MediaQuery.of(context).size.height * 0.01; // 8pt基礎單位

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(gridUnit * 1.5), // 12pt
            border: Border.all(
              color:
                  errorText != null
                      ? Colors.red
                      : (isFocused && controller.text.isNotEmpty)
                      ? (isValid ? Colors.green : Colors.red)
                      : isFocused
                      ? WelcomePageStyles.brandColor.withValues(alpha: 0.5)
                      : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    errorText != null
                        ? Colors.red.withValues(alpha: 0.05)
                        : isValid && controller.text.isNotEmpty
                        ? Colors.green.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: GoogleFonts.poppins(
              fontSize: gridUnit * 1.8, // 14pt (H6)
              color: Colors.black87,
            ),
            cursorColor:
                isValid && controller.text.isNotEmpty
                    ? Colors.green
                    : WelcomePageStyles.brandColor,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: GoogleFonts.poppins(
                fontSize: gridUnit * 2, // 16pt
                fontWeight: FontWeight.w500,
                color: WelcomePageStyles.brandColor,
              ),
              hintStyle: GoogleFonts.poppins(
                fontSize: gridUnit * 1.8, // 14pt
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: gridUnit * 2, // 16pt
                horizontal: gridUnit, // 8pt
              ),
              prefixIcon: Icon(
                prefixIcon,
                size: gridUnit * 2.5, // 20pt
                color:
                    isValid && controller.text.isNotEmpty
                        ? Colors.green
                        : isFocused
                        ? WelcomePageStyles.brandColor
                        : Colors.grey[400],
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(
              top: gridUnit * 0.8, // 6pt
              left: gridUnit * 1.5, // 12pt
            ),
            child: Text(
              errorText,
              style: GoogleFonts.poppins(
                fontSize: gridUnit * 1.5, // 12pt (Caption)
                color: Colors.red[700],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}

class _PasswordHint extends StatelessWidget {
  const _PasswordHint({
    required this.text,
    required this.isValid,
    required this.fontSize,
  });

  final String text;
  final bool isValid;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.7,
        vertical: fontSize * 0.4,
      ),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isValid ? Colors.green[50] : Colors.grey[200],
        borderRadius: BorderRadius.circular(fontSize * 1.8),
        border: Border.all(
          color: isValid ? Colors.green[400]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: isValid ? FontWeight.w500 : FontWeight.w400,
            color: isValid ? Colors.green[700] : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.onPressed,
    required this.size,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black87,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Center(child: Icon(icon, size: size * 0.5, color: iconColor)),
        ),
      ),
    );
  }
}
