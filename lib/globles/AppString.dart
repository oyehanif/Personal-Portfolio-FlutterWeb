

import 'package:oyehanif/globles/app_images.dart';

/// [Main Dashboard]
const portfolio = "OyeHanif";
final menuItems = ['Home', 'About', 'Service', 'Portfolio', 'Contact'];

///Home Page
const helloHome = 'Hello, it\'s Me';
const nameHome = 'Mohammad Hanif Shaikh';
const iamHome = 'And I\'m a ';
const skillList = [
  'Android Developer',
  'Flutter Developer',
  'Open Source Contributor',
  'Speaker',
  'Freelancer',
  'Youtuber',
];


class SocialModel{
  String imagePath;
  String link;

  SocialModel({required this.imagePath, required this.link});
}

final socialButtons = <SocialModel>[
  SocialModel(imagePath: AppImages.so, link: 'https://stackoverflow.com/users/19493508/hanif-shaikh'),
  SocialModel(imagePath: AppImages.github, link: 'https://github.com/oyehanif'),
  SocialModel(imagePath: AppImages.linkedIn, link: 'https://in.linkedin.com/in/hanif-shaikh'),
  SocialModel(imagePath: AppImages.twitter, link: 'https://twitter.com/ChotaCoder'),
  // SocialModel(imagePath: AppImages.facebook, link: link),
  SocialModel(imagePath: AppImages.insta, link: 'https://www.instagram.com/oyehanif/'),
];

const resume = "https://drive.google.com/file/d/1gvPAF4EXsc5diYRNyHGoixme1828zs8d/view?usp=sharing";


const descHome =
    'passionate mobile developer with 2+ years of experience in creating dynamic and user-friendly mobile applications. I specialize in mobile application development, bringing a comprehensive approach to mobile development. My journey in tech started with a fascination for how mobile apps can transform daily life, and I have since honed my skills to turn innovative ideas into reality.';

///about-us Page
const about = 'About';
const me = 'Me';
const skillTitle = 'Mobile Application Developer';
const descAbout =
    'Welcome to my portfolio! I’m Hanif Shaikh, a dedicated mobile developer with over 2 years of experience in building engaging and user-friendly applications for both Android and iOS platforms. My work is driven by a passion for transforming innovative ideas into functional and seamless mobile experiences.Throughout my career, I have had the opportunity to work on a diverse range of projects, each presenting unique challenges and learning experiences. Whether it’s designing sleek user interfaces, optimizing app performance, or integrating cutting-edge technologies, I approach every project with a blend of creativity and technical expertise. \nThank you for visiting my portfolio. I invite you to explore my work and reach out if you have any questions or opportunities for collaboration. I look forward to connecting with you!.';

///service
class service {
  String title;
  String decs;
  String? imageUrl;

  service({required this.title, required this.decs, this.imageUrl});
}

var serviceList = [
  service(title: 'Mobile Application Development', decs: 'Creating native android and cross platform application using flutter. ensuring high quality performance and user experience.',imageUrl: AppImages.app),
  service(title: 'Web Application Development', decs: 'Building responsive and scalable web application using modern framework and technologies, tailored to meet your business needs.',imageUrl: AppImages.web),
  service(title: 'Api Integration', decs: 'Seamlessly integration third-part Apis to enhance your application functionality, providing a richer user experience.',imageUrl: AppImages.code)
];

///My Work/Portfolio
class work {
  String imagePath;
  String title;
  String desc;
  String link;
  work({required this.imagePath,required this.title,required this.desc,required this.link});
}

var workList = [
work(imagePath: AppImages.work, title: 'Portfolio-Web', desc: 'This personal portfolio is made with Flutter. This is one template everyone can create in just 5 minutes.', link: 'https://github.com/oyehanif/oyehanif.github.io'),
work(imagePath: AppImages.work1, title: 'Nekiyaan', desc: 'Nekiyaan is an Islamic app that helps people increase productivity and perform good deeds on a daily basis.', link: 'https://github.com/oyehanif/Naikya-Dua-App'),
work(imagePath: AppImages.work2, title: 'Medicare', desc: 'Medicare is an online doctor appointment/consultation app that helps people get doctor advice anywhere.', link: 'https://github.com/oyehanif/Medical'),
];

///Thank-you Page
const String connectingText = "Thank You For Contacting Us";
const String connectingText1 = "You will receive an email from us within next 24 hours, requesting your availability for a meeting to take things forward.";


/// App Setting
const String AppName = 'oyehanif';