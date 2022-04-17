DisjointUnionSets sets;
Graph graph; 
// Edge weights
Edge[] distances;
// Amount of vertices in the graph
int amount = 50;
// Shade of the background
int shade = 200;
// Whether to animate Kruskal's Algorithim
boolean animate = true;

void setup() {
  background(shade);
  size(750, 750);
  Node[] nodes = generateNodes(amount);
  graph = new Graph(nodes);
  distances = graph.getSortedDistances();
  sets = new DisjointUnionSets(graph.size());

  if (!animate) {
    for (int distInd = 0; distInd < distances.length; distInd++) {
      kruskal(distInd);
    }
  }
  graph.display();
}

// Generates Nodes to randomly place on the screen
Node[] generateNodes(int length) {
  Node[] toReturn = new Node[length];
  for (int i = 0; i < length; i++) {
    toReturn[i]= new Node(i, random(0, width), random(0, height));
  }
  return toReturn;
}

// Uses draw as a for loop for animation
int distInd = 0;
void draw() {
  background(shade);
  graph.display();
  kruskal(distInd);
  if (sets.partitions() == 1) // No further unioning to be done
    kill();
  if (distInd >= distances.length) // Absolute worst case, near impossible
    kill();
  distInd++;
}

// Kruskal's Algorithim
void kruskal(int distInd) {
  Edge e = distances[distInd];
  Node u = e.getNodeOne(), v = e.getNodeTwo();
  if (animate) {
    stroke(255, 0, 0);
    line(u.getX(), u.getY(), v.getX(), v.getY());
    stroke(0, 0, 0);
  }
  int uId = u.getId(), vId = v.getId();
  if (sets.find(uId) != sets.find(vId)) {
    graph.addEdge(u, v);
    sets.union(uId, vId);
  }
}

// Program is finished
void kill() {
  println("Done");
  background(shade);
  graph.display();
  // saveFrame("graph"+amount+".jpg");
  stop();
}

void printDistances() {
  for (Edge e : distances) {
    Node a = e.getNodeOne();
    Node b = e.getNodeTwo();
    print("[" + a.getId() + "," + b.getId() + "]=" + e.weight()+ "\t");
  }
  println();
}
