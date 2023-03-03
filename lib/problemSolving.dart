void main() {
  displayNum(1);
}

displayNum(int n) {
  try {
    if (n == 21)
      throw FormatException;
    else {
      print(n);
      displayNum(n + 1);
    }
  } catch (e) {
    print('stoppedat 20');
  }
}
