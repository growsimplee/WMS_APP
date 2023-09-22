class Picklist {
  static String getpickliststatus(String status) {
    if (status == 'PENDING') {
      return 'Not Started';
    } else {
      return 'On Going';
    }
  }

  static List<String> getItemListstatus(
      int pendingQty, int totalQty, bool available) {
    if (!available) {
      return ["Not Available", "0xffFF756C", "0xffFFFFFF"];
    } else {
      if (pendingQty == totalQty) {
        return ["Picked ", "0XFF38B58B", "0xffFFFFFF"];
      } else if (pendingQty == 0) {
        return ["Not Picked", "0XFFF1F1F2", "0xff6E6E7A"];
      } else{
        return ["Partially Picked", "0xffE09F3E", "0xffFFFFFF"];
      }
    }
  }

  static List<String> getproductListinBinstatus(int pendingQty, int totalQty) {
    if (pendingQty == 0) {
      return ["Not Picked", "0xff6E6E7A"];
    } else {
      return ["Partially Picked", "0XFFE09F3E"];
    }
  }

  static List<String> getmultiplebinstatus(int pendingQty, int totalQty) {
    if (pendingQty == 0) {
      return ["Not Started", "0xffFFF1F0", "0xffFF756C"];
    } else if (pendingQty < totalQty) {
      return ["On Going", "0xffFCF5EC", "0xffE09F3E"];
    } else {
      return ["Completed", "0XFFEBF8F3", "0xff38B58B"];
    }
  }
}
