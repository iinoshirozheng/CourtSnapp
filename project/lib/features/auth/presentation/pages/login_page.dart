import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/theme/welcome_page_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const LoginPage({super.key, required this.toggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool hasUppercase = false;
  bool hasLetter = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool isEmailValid = false;
  bool showPasswordHints = false;

  // 焦點控制
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode loginButtonFocus = FocusNode();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isLoggingIn = false;
  bool showLoginError = false;

  // 動畫控制
  final double _initialButtonScale = 1.0;
  double _buttonScale = 1.0;

  // 按鈕搖動動畫控制器
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

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
        // 只在獲得焦點時顯示密碼提示
        showPasswordHints = isPasswordFocused;
      });
    });

    // 初始化搖動動畫
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeAnimation = Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0.05, 0),
      ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shakeController.reverse();
        }
      });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    loginButtonFocus.dispose();
    _shakeController.dispose();
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
    if (!canSubmit) {
      // 播放搖動動畫提示錯誤
      _shakeController.forward();
      HapticFeedback.mediumImpact(); // 觸覺反饋
      setState(() {
        showLoginError = true;
      });
      return;
    }

    setState(() {
      isLoggingIn = true;
      showLoginError = false;
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

    // 使用固定間距（8pt網格系統）
    const double grid = 8.0;

    // 主要間距值
    const double spacing2 = grid * 1; // 8pt
    const double spacing3 = grid * 1.5; // 12pt
    const double spacing4 = grid * 2; // 16pt
    const double spacing5 = grid * 3; // 24pt
    const double spacing6 = grid * 4; // 32pt
    const double spacing7 = grid * 6; // 48pt

    // 按鈕尺寸
    const double buttonHeight = grid * 6; // 48pt
    const double horizontalMargin = grid * 3; // 24pt

    // 主品牌色
    final Color brandColor = WelcomePageStyles.brandColor;
    final Color errorColor = Colors.red.shade700;

    // 輸入欄顏色
    final Color inputBgColor = Colors.grey.shade100; // #F5F5F5
    final Color inputBorderColor = Colors.grey.shade300;
    final Color inputFocusBorderColor = brandColor;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin, // 24pt左右邊距
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 頂部工具列 - 保持簡潔
                    SizedBox(
                      height: spacing7, // 48pt
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 返回按鈕 - 保持最小 44×44pt 的觸碰區域
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const SizedBox(
                                height: 44, // 最小觸碰目標
                                width: 44, // 最小觸碰目標
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black87,
                                  size: 32,
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
                              child: const SizedBox(
                                height: 44, // 最小觸碰目標
                                width: 44, // 最小觸碰目標
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.black45,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 標題區塊 - 間距調整為24pt
                    Padding(
                      padding: const EdgeInsets.only(
                        top: spacing5, // 24pt
                        bottom: spacing6, // 32pt
                      ),
                      child: Text(
                        'Welcome back!',
                        style: GoogleFonts.poppins(
                          fontSize: 32, // H2
                          fontWeight: FontWeight.w600, // SemiBold
                          color: Colors.black87,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                    ),

                    // 表單區域 - 彈性佈局
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(), // iOS風格彈性效果
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // === 表單區塊 ===
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Email 輸入框
                                  _buildInputLabel('Email'),
                                  const SizedBox(height: spacing2), // 8pt

                                  _buildTextField(
                                    controller: emailController,
                                    focusNode: emailFocus,
                                    hintText: 'yourname@example.com',
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    isValid: isEmailValid,
                                    isFocused: isEmailFocused,
                                    showError:
                                        emailController.text.isNotEmpty &&
                                        !isEmailValid,
                                    errorText: 'Please enter a valid email',
                                    inputBgColor: inputBgColor,
                                    inputBorderColor: inputBorderColor,
                                    inputFocusBorderColor:
                                        inputFocusBorderColor,
                                    brandColor: brandColor,
                                    errorColor: errorColor,
                                    onSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(passwordFocus);
                                    },
                                  ),

                                  const SizedBox(height: spacing4), // 16pt
                                  // Password 輸入框
                                  _buildInputLabel('Password'),
                                  const SizedBox(height: spacing2), // 8pt

                                  _buildTextField(
                                    controller: passwordController,
                                    focusNode: passwordFocus,
                                    hintText: '••••••••',
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: obscureText,
                                    isValid: isPasswordValid,
                                    isFocused: isPasswordFocused,
                                    showError:
                                        passwordController.text.isNotEmpty &&
                                        !isPasswordValid,
                                    errorText:
                                        'Please meet all password requirements',
                                    inputBgColor: inputBgColor,
                                    inputBorderColor: inputBorderColor,
                                    inputFocusBorderColor:
                                        inputFocusBorderColor,
                                    brandColor: brandColor,
                                    errorColor: errorColor,
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
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          obscureText
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    onSubmitted: (_) => _handleLogin(),
                                  ),

                                  // 密碼要求提示 - 只在聚焦時顯示
                                  if (showPasswordHints)
                                    AnimatedOpacity(
                                      opacity: showPasswordHints ? 1.0 : 0.0,
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: spacing3,
                                        ), // 12pt
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              _PasswordHint(
                                                text: 'uppercase',
                                                isValid: hasUppercase,
                                                fontSize: 12,
                                              ),
                                              const SizedBox(width: 4),
                                              _PasswordHint(
                                                text: 'letter',
                                                isValid: hasLetter,
                                                fontSize: 12,
                                              ),
                                              const SizedBox(width: 4),
                                              _PasswordHint(
                                                text: 'number',
                                                isValid: hasNumber,
                                                fontSize: 12,
                                              ),
                                              const SizedBox(width: 4),
                                              _PasswordHint(
                                                text: '8~20 words',
                                                isValid: hasMinLength,
                                                fontSize: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  // 忘記密碼按鈕 - 靠右對齊
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: spacing4,
                                      ), // 8pt
                                      child: TextButton(
                                        onPressed: () {
                                          // TODO: 實現忘記密碼功能
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: brandColor,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 間距(Forgot Password → Login 按鈕)
                            const SizedBox(height: spacing5), // 24pt
                            // === 主要CTA區 ===
                            // Login按鈕 - 使用動畫和觸覺反饋
                            AnimatedBuilder(
                              animation: _shakeAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset:
                                      showLoginError
                                          ? _shakeAnimation.value
                                          : Offset.zero,
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTapDown: (_) {
                                  if (canSubmit) {
                                    setState(
                                      () => _buttonScale = 0.95,
                                    ); // 按下縮放效果
                                  }
                                },
                                onTapUp: (_) {
                                  setState(
                                    () => _buttonScale = _initialButtonScale,
                                  );
                                  _handleLogin();
                                },
                                onTapCancel: () {
                                  setState(
                                    () => _buttonScale = _initialButtonScale,
                                  );
                                },
                                child: AnimatedScale(
                                  scale: _buttonScale,
                                  duration: const Duration(milliseconds: 150),
                                  child: Container(
                                    width: double.infinity,
                                    height: buttonHeight, // 48pt
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: brandColor.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                          spreadRadius: -2,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed:
                                          canSubmit ? _handleLogin : null,
                                      focusNode: loginButtonFocus,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: brandColor,
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor: brandColor
                                            .withOpacity(0.6),
                                        disabledForegroundColor: Colors.white
                                            .withOpacity(0.8),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                      child:
                                          isLoggingIn
                                              ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                              )
                                              : Text(
                                                'Login',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 登入錯誤提示
                            if (showLoginError)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: spacing3,
                                ), // 12pt
                                child: Text(
                                  'Please check your email and password',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: errorColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                            // 間距(Login → Divider) - 增加間距使社交登入區向下移動
                            const SizedBox(
                              height: spacing6,
                            ), // 原本是 spacing6 (32pt)，改為 spacing7 (48pt)
                            // === 分隔線區 ===
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.3),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: spacing4,
                                  ), // 16pt
                                  child: Text(
                                    'Or continue with',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.3),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            // 間距(Divider → Social)
                            const SizedBox(height: spacing5), // 24pt
                            // === 社交登入區 ===
                            // 使用統一樣式的按鈕
                            Column(
                              children: [
                                // Facebook 登入按鈕
                                _SocialLoginButton(
                                  text: 'Continue with Facebook',
                                  customIcon: const _FacebookLogo(),
                                  onPressed: () {
                                    // TODO: Facebook login implementation
                                  },
                                ),

                                const SizedBox(height: spacing3), // 12pt
                                // Google 登入按鈕
                                _SocialLoginButton(
                                  text: 'Continue with Google',
                                  customIcon: const _GoogleLogo(),
                                  onPressed: () {
                                    // TODO: Google login implementation
                                  },
                                ),

                                const SizedBox(height: spacing3), // 12pt
                                // Apple 登入按鈕
                                _SocialLoginButton(
                                  text: 'Continue with Apple',
                                  customIcon: const _AppleLogo(),
                                  onPressed: () {
                                    // TODO: Apple login implementation
                                  },
                                ),
                              ],
                            ),

                            // 底部留白
                            const SizedBox(height: spacing5), // 24pt
                          ],
                        ),
                      ),
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

  // 創建輸入標籤
  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  // 構建輸入框的通用方法
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData prefixIcon,
    required Color inputBgColor,
    required Color inputBorderColor,
    required Color inputFocusBorderColor,
    required Color brandColor,
    required Color errorColor,
    bool obscureText = false,
    bool isValid = true,
    bool isFocused = false,
    bool showError = false,
    String? errorText,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String)? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: inputBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  showError
                      ? errorColor
                      : isFocused
                      ? inputFocusBorderColor
                      : inputBorderColor,
              width: isFocused || showError ? 1.5 : 1.0,
            ),
            boxShadow:
                isFocused
                    ? [
                      BoxShadow(
                        color: (showError ? errorColor : brandColor).withValues(
                          alpha: 0.1,
                        ),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            cursorColor: showError ? errorColor : brandColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                size: 18,
                color:
                    showError
                        ? errorColor
                        : isFocused
                        ? brandColor
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
        if (showError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              errorText,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}

// 社交登入按鈕
class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.customIcon,
  });

  final String text;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child:
                      customIcon ??
                      Icon(icon, size: 20, color: _getIconColor(icon)),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconColor(IconData? icon) {
    if (icon == Icons.facebook) return const Color(0xFF1877F2);
    if (icon == Icons.apple) return Colors.black;
    return Colors.black87;
  }
}

// Google Logo 定制組件
class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo({this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/google-logo.svg',
        width: size,
        height: size,
      ),
    );
  }
}

// 密碼提示標籤組件
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
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isValid ? Colors.green[50] : Colors.grey[200],
        borderRadius: BorderRadius.circular(fontSize * 1.8),
        border: Border.all(
          color: isValid ? Colors.green[400]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: isValid ? FontWeight.w500 : FontWeight.w400,
          color: isValid ? Colors.green[700] : Colors.grey[700],
          height: 1.1,
        ),
      ),
    );
  }
}

// Apple Logo SVG widget
class _AppleLogo extends StatelessWidget {
  const _AppleLogo({this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/apple-logo.svg',
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
    );
  }
}

// Facebook Logo SVG widget
class _FacebookLogo extends StatelessWidget {
  const _FacebookLogo({this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/facebook-logo.svg',
        width: size,
        height: size,
      ),
    );
  }
}
