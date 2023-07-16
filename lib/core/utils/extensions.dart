extension StringExt on String{
  String capitalizeEachWord() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

  String capitalizeFirst() {
    var result = this[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " " && cap == true) {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
        cap = false;
      }
    }
    return result;
  }


}

extension StringNullExt on String?{
  bool get isNullOrEmpty{
    if(this == null){
      return true;
    }else{
      if(this!.isEmpty){
        return true;
      }else{
        return false;
      }
    }
  }

  bool get isAcceptAnswer{
    if(this == null){
      return false;
    }else{
      if(this!.isEmpty){
        return false;
      }else{
        if(this == "A" || this == "B" || this == "C" || this == "D" || this == "E"){
          return true;
        }else{
          return false;
        }
      }
    }
  }
}

extension ListNullExt on List?{
  bool get isNullOrEmpty{
    if(this == null){
      return true;
    }else{
      if(this!.isEmpty){
        return true;
      }else{
        return false;
      }
    }
  }
}
