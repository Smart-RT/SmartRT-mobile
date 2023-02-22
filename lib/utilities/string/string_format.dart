class StringFormat {
  static String convertMax2Words(String name) {
    if (name == '') {
      return '';
    } else if (name.contains(' ')) {
      List<String> tempName = name.toUpperCase().split(' ');
      if (tempName.length > 2) {
        return '${tempName[0]} ${tempName[1]} ${tempName[2][0]}.';
      } else {
        return name;
      }
    } else {
      return name;
    }
  }

  static String convert1Line1Word(String word) {
    if (word == '') {
      return '';
    } else if (word.contains(' ')) {
      List<String> listWord = word.split(' ');
      String tempWord = '';
      for (var i = 0; i < listWord.length; i++) {
        if (i == 0) {
          tempWord += '${listWord[i]}';
        } else {
          tempWord += '\n${listWord[i]}';
        }
      }
      return tempWord;
    } else {
      return word;
    }
  }

  static String initialName(String name) {
    if (name == '') {
      return '';
    } else if (name.contains(' ')) {
      List<String> nama = name.toUpperCase().split(' ');
      return '${nama[0][0]}${nama[1][0]}';
    } else if (name.length < 2) {
      return name.toUpperCase();
    } else {
      return '${name[0]}${name[1]}'.toUpperCase();
    }
  }
}
