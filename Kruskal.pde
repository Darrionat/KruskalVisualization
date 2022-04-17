DisjointSets sets;
Graph graph; 
int amount = 10;
void setup() {
  size(750, 750);
  Node[] nodes = generateNodes(amount);
  graph = new Graph(nodes);
  sets = new DisjointSets(graph.size());
}

Node[] generateNodes(int length) {
  Node[] toReturn = new Node[length];
  for (int i = 0; i < length; i++) {
    toReturn[i]= new Node(i, random(0, width), random(0, height));
  }
  return toReturn;
}

void draw(){
 graph.display(); 
}

/*
algorithm Kruskal(G) is
    F:= empty 
    for each v in G.V do
        MAKE-SET(v)
    for each (u, v) in G.E ordered by weight(u, v), increasing do
        if FIND-SET(u) ≠ FIND-SET(v) then
            edges = edges union {(u, v)} union {(v, u)}
            UNION(FIND-SET(u), FIND-SET(v))
    return F
*/
