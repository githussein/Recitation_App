import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قصة اليوم"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.60),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ListView(
            children: <Widget>[
              Text(
                'سعد بن أبي وقاص، خال رسول الله صلى الله عليه وسلم',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'نشأ سعد في قريش، واشتغل في بري السهام وصناعة القِسِيّ، وهذا عمل يؤهِّل صاحبه للائتلاف مع الرمي، وحياة الصيد والغزو، وكان يمضي وقته وهو يخالط شباب قريش وساداتهم، ويتعرف على الدنيا عن طريق الحجيج الوافد إلى مكة المكرمة في أيام الحج ومواسمها',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'كان ممن دعاهم أبو بكر للإسلام، فأسلم مبكرًا، وهو ابن سبع عشرة سنة. وبعد إسلامه تركت أمه الطعام ليعود إلى الكفر، فقال لها: تعلمين والله يا أماه، لو كانت لك مائة نفس فخرجت نفسًا نفسًا، ما تركت ديني هذا لشيء؛ فإن شئت فكلي، وإن شئت لا تأكلي. فحلفتْ ألا تكلمه أبدًا حتى يكفر بدينه، ولا تأكل ولا تشرب؛ فأنزل الله : {وَوَصَّيْنَا الإِنْسَانَ بِوَالِدَيْهِ حُسْنًا وَإِنْ جَاهَدَاكَ لِتُشْرِكَ بِي مَا لَيْسَ لَكَ بِهِ عِلْمٌ فَلاَ تُطِعْهُمَا إِلَيَّ مَرْجِعُكُمْ فَأُنَبِّئُكُمْ بِمَا كُنْتُمْ تَعْمَلُونَ} [العنكبوت: 8]',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'وكان سعد بن أبي وقاص أحد الفرسان، وهو أول من رمى بسهمٍ في سبيل الله، وهو أحد الستة أصحاب الشورى',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'لم تعد حياة سعد ضياعًا في أحاديث التجارة أو اللغو، ولم يعد عمله في صنع السهام والقِسِيّ من أجل الربح، بل أصبح عمله جميعه موجَّهًا لهدف واحد، هو نصرة الدين، وإعلاء كلمة الله، والجهاد في سبيله بالمال والنفس والأهل والعشيرة؛ فقد شهد مع النبي غزوة بُواط وكان يحمل لواءها، وغزوة أُحد، وكان الرسول يعتمده في بعض الأعمال الخاصة، مثل إرساله مع علي بن أبي طالب والزبير بن العوام رضي الله عنهما بمهمة استطلاعية عند ماء بدر، وعندما عقد صلح الحديبية كان سعد بن أبي وقاص أحد شهود الصلح',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'تولى سعد بن أبي وقاص مهمة قيادة جيش المسلمين في أصعب مرحلة من مراحل الحرب في بلاد فارس والعراق، فاستطاع بفضل الله أولاً، ثم بكفاءته وقدرته القيادية وتوجيهات أمير المؤمنين وجيشٍ يملؤه الإيمان أن يهزم الفرس هزيمة ساحقة في القادسية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
