// 7rayer / حراير — Arabic UI strings
// Dart identifiers are kept unchanged for compatibility.
class TTexts {
  // -- GLOBAL Texts
  static const String and = "و";
  static const String skip = "تخطي";
  static const String done = "تم";
  static const String submit = "إرسال";
  static const String appName = "حراير | 7rayer";
  static const String tContinue = "متابعة";
  static const String viewAll = "عرض الكل";
  static const String account = "الحساب";

  // views
  static const String homeView = "الرئيسية";
  static const String cartView = "سلة التسوق";
  static const String profileView = "حسابي";
  static const String wishlistView = "المفضلة";
  static const String ordersView = "طلباتي";
  static const String settingsView = "الإعدادات";
  static const String storeView = "المتجر";

  // -- OnBoarding Texts
  static const String onBoardingTitle1 = "اكتشف منتجات المرأة الريفية";
  static const String onBoardingTitle2 = "تسوق بكل سهولة";
  static const String onBoardingTitle3 = "منتجات أصيلة تصلك إلى بيتك";

  static const String onBoardingSubTitle1 =
      "مرحباً بك في حراير، منصتك لاكتشاف المنتجات التقليدية والحرفية التي تبدعها المرأة الريفية التونسية.";
  static const String onBoardingSubTitle2 =
      "اختر ما يعجبك من منتجات طبيعية وصناعات يدوية أصيلة وساهم في دعم الحرفيات التونسيات.";
  static const String onBoardingSubTitle3 =
      "من أيادي المرأة الريفية إلى بيتك، اكتشف أصالة المنتجات التونسية وجودتها.";

  // -- Authentication Forms
  static const String firstName = "الاسم";
  static const String lastName = "اللقب";
  static const String email = "البريد الإلكتروني";
  static const String password = "كلمة المرور";
  static const String newPassword = "كلمة المرور الجديدة";
  static const String username = "اسم المستخدم";
  static const String phoneNo = "رقم الهاتف";
  static const String rememberMe = "تذكرني";
  static const String forgetPassword = "نسيت كلمة المرور؟";
  static const String signIn = "تسجيل الدخول";
  static const String createAccount = "إنشاء حساب";
  static const String loading = "جارٍ التحميل...";
  static const String orSignInWith = "أو سجل الدخول باستخدام";
  static const String orSignUpWith = "أو أنشئ حساباً باستخدام";
  static const String iAgreeTo = "أوافق على";
  static const String privacyPolicy = "سياسة الخصوصية";
  static const String termsOfUse = "شروط الاستخدام";
  static const String verificationCode = "رمز التحقق";
  static const String resendEmail = "إعادة إرسال البريد";
  static const String resendEmailIn = "إعادة إرسال البريد خلال";

  // -- Authentication Headings
  static const String loginTitle = "مرحباً بعودتك إلى حراير";
  static const String loginSubTitle =
      "اكتشف منتجات تونسية أصيلة من إبداع المرأة الريفية، وساهم في دعم الحرفيات المحليات.";
  static const String signUpTitle = "أنشئ حسابك في حراير";
  static const String forgetPasswordTitle = "نسيت كلمة المرور؟";
  static const String forgetPasswordSubTitle =
      "أدخل بريدك الإلكتروني وسنرسل إليك رابطاً لإعادة تعيين كلمة المرور.";
  static const String changeYourPasswordTitle = "تم إرسال رابط إعادة تعيين كلمة المرور";
  static const String changeYourPasswordSubTitle =
      "تحقق من بريدك الإلكتروني واتبع التعليمات لإنشاء كلمة مرور جديدة وآمنة.";
  static const String confirmEmailTitle = "تحقق من بريدك الإلكتروني";
  // TODO: Display the current user's real email in the verification view.
  static const String confirmEmail = "البريد الإلكتروني المسجل";
  static const String confirmEmailSubTitle =
      "لقد أرسلنا إليك رسالة للتحقق من بريدك الإلكتروني. افتح الرسالة واتبع التعليمات لتفعيل حسابك في حراير.";
  static const String emailNotReceivedMessage =
      "لم تصلك الرسالة؟ تحقق من مجلد البريد غير المرغوب فيه أو أعد إرسالها.";
  static const String yourAccountCreatedTitle =
      "تم إنشاء حسابك بنجاح!";
  static const String yourAccountCreatedSubTitle =
      "أهلاً بك في عائلة حراير! ابدأ رحلة اكتشاف المنتجات التونسية الأصيلة وادعم إبداعات المرأة الريفية.";

  // -- Product
  static const String popularProducts = "منتجات مميزة";

  // -- Home
  static const String homeAppbarTitle = "مرحباً بك في حراير";
  static const String homeAppbarSubTitle = "من أيادي المرأة الريفية التونسية";
  static const String searchContainer = "ابحث عن منتج...";
  static const String popularCategories = "تصفح التصنيفات";
// -- Categories
  static const String sport = "منتجات طبيعية";
  static const String cloth = "نسيج وتطريز";
  static const String shoes = "منتجات جلدية";
  static const String cosmetics = "أعشاب وزيوت";
  static const String animal = "منتجات النحل";
  static const String toy = "صناعات يدوية";
  static const String furniture = "ديكور تقليدي";
  static const String accessories = "إكسسوارات حرفية";
  static const String electronics = "مأكولات تقليدية";
  static const String jewellers = "حلي تقليدية";
// Arabic display categories; keep icons in image_strings.dart aligned.
  static const List<String> categories = [
    "منتجات النحل",
    "مأكولات تقليدية",
    "نسيج وتطريز",
    "أعشاب وزيوت",
    "صناعات يدوية",
  ];
  static const String applePay = 'Apple Pay';
  static const String googlePay = 'Google Pay';
  static const String creditCard = "البطاقة البنكية";
  static const String masterCard = 'MasterCard';
  static const String paypal = 'PayPal';
  static const String visa = 'Visa';
  static const String paystack = 'Paystack';
  static const String paytm = 'Paytm';

  static const List<String> paymentTitles = [
    applePay,
    googlePay,
    creditCard,
    masterCard,
    paypal,
    visa,
    paystack,
    paytm,
  ];
  // Legacy brand identifiers retained so existing screens keep compiling.
  // Replace static brand imagery/labels when converting the store view.
  static const String nikeTitle = "منتجات المرأة الريفية";
  static const String adidasTitle = "الحرف التقليدية";
  static const String appleTitle = "المنتجات الطبيعية";
  static const String jordanTitle = "حرفيات تونس";
  static const String pumaTitle = "النسيج التقليدي";
  static const String zaraTitle = "إبداعات يدوية";
  static const String kenwoodTitle = "المأكولات التونسية";
  static const String hermanMillerTitle = "الفخار التقليدي";
  static const String ikeaTitle = "الديكور الحرفي";
  static const String acerTitle = "الأعشاب والزيوت";

  static const List<String> brandTitles = [
    nikeTitle,
    adidasTitle,
    appleTitle,
    jordanTitle,
    pumaTitle,
    zaraTitle,
    kenwoodTitle,
    hermanMillerTitle,
    ikeaTitle,
    acerTitle,
  ];
}
