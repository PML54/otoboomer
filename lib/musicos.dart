class Musicos {
// 11 Gammes de 12 notes soit 132 frequences
  get freqNotes => [16,17,18,19,21,22,23,24,26,28,30,32,
    33,35,37,39,41,43,46,49,52,55,58,61,
    65,69,73,77,82,87,92,97,103,110,117,124,
    131,139,147,156,165,175,185,196,208,220,233,247,
    262,278,295,313,332,352,373,395,418,440,466,494,
    523,554,587,622,659,698,740,784,831,880,932,987,
    1046,1108,1174,1244,1318,1396,1479,1567,1660,1760,1865,1976,
    2093,2217,2349,2489,2637,2794,2960,3136,3322,3520,3729,3951,
    4186,4435,4699,4978,5274,5588,5920,6272,6645,7040,7459,7903,
    8373,8871,9398,9957,10549,11176,11841,12545,13291,14080,14917,15804];

  final nameNotes =  ["Do","Do#","Ré#","Ré","Mi","Fa","Fa#","Sol","Sol#","La#","La","Si"];

  int frequence (int which)  {

    return freqNotes   [which-1];
  }
}

  class User {
  String avatar;
  String hz;
  String lvl;
  String namoto;
  String otofrek;
  String otolevel;

  User();

  User.fromJson(Map<String, dynamic> json)
      : avatar = json['avatar'],
        hz = json['hz'],
        lvl = json['lvl'];

  Map<String, dynamic> toJson() => {
    'avatar': namoto,
    'hz': otofrek,
    'lvl': otolevel,
  };
}