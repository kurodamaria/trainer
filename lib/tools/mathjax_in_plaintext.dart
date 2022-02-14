String mathjaxInPlainText(String mathjax) {
  return mathjax
      .replaceAll(RegExp(r'\${1,}'), '\n')
      .replaceAll(r'\\', '\n')
      .replaceAll(r'\begin{cases}', '\n \n')
      .replaceAll(r'\end{cases}', '\n \n');
}
