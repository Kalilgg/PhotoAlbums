class StringComparator {
    static int compare(String s, String t) {
      return levenshtein(s, t);
    }
}
int levenshtein(String s, String t) {
  if (s == t) return 0;
  if (s.isEmpty) return t.length;
  if (t.isEmpty) return s.length;

  List<int> v0 = List<int>.filled(t.length + 1, 0);
  List<int> v1 = List<int>.filled(t.length + 1, 0);

  for (int i = 0; i < t.length + 1; i++) {
    v0[i] = i;
  }

  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;

    for (int j = 0; j < t.length; j++) {
      int cost = (s.codeUnitAt(i) == t.codeUnitAt(j)) ? 0 : 1;
      v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost].reduce((curr, next) => curr < next ? curr : next);
    }

    for (int j = 0; j < t.length + 1; j++) {
      v0[j] = v1[j];
    }
  }

  return v1[t.length];
}
//Algoritmo de Levenshtein para comparar strings e calcular a distância entre elas. 
//Quanto menor a distância, mais semelhantes são as strings.