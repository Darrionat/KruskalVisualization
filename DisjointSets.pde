class DisjointSets {
  private int[] parent;

  public DisjointSets(int size) {
    parent = new int[size];
  }

  // Naive implementation of find
  int find(int i) {
    if (parent[i] == -1)
      return i;
    return find(parent[i]);
  }

  // Naive implementation of union()
  void Union(int x, int y) {
    int xset = find(x);
    int yset = find(y);
    parent[xset] = yset;
  }
}
