// Disjoint union sets, 
class DisjointUnionSets {
  private int[] rank, parent;
  private int n;
  private int sets;

  public DisjointUnionSets(int n) {
    rank = new int[n];
    parent = new int[n];
    this.n = n;
    this.sets = n;
    makeSet();
  }

  // Creates n sets with single item in each
  void makeSet() {
    for (int i = 0; i < n; i++) {
      // Initially, all elements are in their own set.
      parent[i] = i;
    }
  }

  // Returns representative of x's set
  int find(int x) {
    // Finds the representative of the set that x is an element of
    if (parent[x] != x) {
      // if x is not the parent of itself
      // Then x is not the representative of this set,
      parent[x] = find(parent[x]);
    }

    return parent[x];
  }

  // Unites the set that includes x and the set that includes y
  void union(int x, int y) {
    int xRep = find(x);
    int yRep = find(y);

    if (xRep == yRep)
      return;

    // If x's rank is less than y's rank, then move x under y  so that depth of tree remains less
    if (rank[xRep] < rank[yRep])
      // 
      parent[xRep] = yRep;
    else if (rank[yRep] < rank[xRep])
      parent[yRep] = xRep;
    else {
      // If ranks are same it doesn't matter which one goes where
      parent[yRep] = xRep;
      // increment the result tree's rank by 1
      rank[xRep] = rank[xRep] + 1;
    }
    sets--;
  }

  int partitions() {
    return sets;
  }
}
