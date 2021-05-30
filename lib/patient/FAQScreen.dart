//FAQScreen
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  var questions = [
    "What is an online doctor visit ?",
    "How do I get a prescription? will my pharmacy accept it ?",
    "Is HealOnline safe to use ?",
    "How long a typical online doctor visit on HealOnline ?",
    "What if I don't have health insurance ?",
    "How is payment taken ?",
    "Who are the doctors ?"

  ];

  var answers = [
    "HealOnline is an affordable way to resolve routine medical conditions. Our unique secure technology makes it possible to see a doctor, face to face, without you have to leave your home on your smartphone, desktop and telephone over video call.",
    "Our Licenced doctors issue prescriptions at the end of appointment as needed. Their prescriptions are legitimate and are accepted by pharmacies",
    "Yes HealOnline is a platform connecting you with a Canadian physician. Same as-in person visit the doctor is responsible on analysing your case, medical history and determining the appropriate treatment.",
    "A typical doctor visit on HealOnline is 10 minutes - the amount of time is needed to handle most medical issues Of course",
    "All of HealOnline services are available without insurance. You can make payment directly by using card.",
    "We accept VISA, MasterCard, Stripe and other online payment enabled cards. ",
    "The doctors on HealOnline are certified canadian doctors who have years of experience. Doctors are both single- and multi- province licenced and credentialed to work in your province of residence, 24 hours a day, 365 days a year."
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();

  }


  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      if(savedCode == "ar"){
        doMakeLangChanges();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 8,
          backgroundColor: Constants.hexToColor(Constants.whiteColor),
          leading: Padding(
              padding: EdgeInsets.only(left: 14),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios,
                    color: Constants.hexToColor(Constants.blackColor)),
              )),
          title: Text(Languages.of(context).faq,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "ProductSans",
                  color: Constants.hexToColor(Constants.primaryDarkColor))),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child:  Material(
                elevation:6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 16.0, right: 16, top: 4),
                  childrenPadding: EdgeInsets.all(8),
                  title: Text(
                    questions[index],
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,

                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        answers[index],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "ProductSans",
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }

  void doMakeLangChanges() {

    setState(() {

      questions = [
        "ما هي زيارة الطبيب عبر الإنترنت؟",
        "كيف أحصل على وصفة طبية؟ هل ستقبله صيدليتي؟",
        "هل HealOnline آمن للاستخدام؟",
        "ما هي مدة زيارة الطبيب النموذجي عبر الإنترنت على HealOnline؟",
        "ماذا لو لم يكن لدي تأمين صحي؟",
        "كيف يتم الدفع؟",
        "من هم الاطباء؟"

      ];

      answers = [
        "HealOnline هو وسيلة ميسورة التكلفة لحل الحالات الطبية الروتينية. تتيح تقنيتنا الآمنة الفريدة من نوعها زيارة الطبيب وجهاً لوجه دون الحاجة إلى مغادرة منزلك على هاتفك الذكي وسطح المكتب والهاتف عبر مكالمة فيديو.",
        "يقوم أطباؤنا المرخصون بإصدار الوصفات الطبية في نهاية الموعد حسب الحاجة. وصفاتهم الطبية مشروعة ومقبولة من قبل الصيدليات",
        "نعم HealOnline هي عبارة عن منصة تربطك بطبيب كندي. زيارة الطبيب هي المسؤولة عن تحليل حالتك وتاريخك الطبي وتحديد العلاج المناسب.",
        "تستغرق زيارة الطبيب النموذجية على HealOnline 10 دقائق - وهو مقدار الوقت اللازم للتعامل مع معظم المشكلات الطبية بالطبع",
        "جميع خدمات HealOnline متاحة بدون تأمين. يمكنك إجراء الدفع مباشرة باستخدام البطاقة.",
        "نحن نقبل بطاقات VISA و MasterCard و Stripe وغيرها من البطاقات الممكّنة للدفع عبر الإنترنت.",
        "الأطباء في HealOnline هم أطباء كنديون معتمدون ولديهم سنوات من الخبرة. الأطباء حاصلون على ترخيص من مقاطعة واحدة ومتعددة المقاطعات ومعتمدين للعمل في مقاطعة إقامتك ، 24 ساعة في اليوم ، 365 يومًا في السنة."
      ];

    });
  }


}

/*

Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Material(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text('data'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
 */
