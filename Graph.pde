import java.util.Collections;
import java.util.Comparator;

class Node {
  float x;
  float y;
  int id;
  Node(int id, float x, float y) {
    this.id = id;
    this.x = x;
    this.y = y;
  }

  public void display() {
    circle(x, y, 3);
  }

  public int getId() {
    return id;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public boolean equals(Object obj) {
    if (!(obj instanceof Node)) 
      return false;
    Node b = (Node) obj;
    return x == b.x && y == b.y;
  }
}

class Edge {
  Node a;
  Node b;
  Edge(Node a, Node b) {
    this.a = a;
    this.b = b;
  }

  public void display() {
    line(a.getX(), a.getY(), b.getX(), b.getY());
  }

  public float weight() {
    return dist(a.getX(), a.getY(), b.getX(), b.getY());
  }

  public boolean equals(Object obj) {
    if (!(obj instanceof Edge)) 
      return false;
    Edge edge = (Edge) obj;
    if (a.equals(edge.a) && b.equals(edge.b))
      return true;
    // Consider case where edges are flipped
    return b.equals(edge.a) && a.equals(edge.b);
  }
}

class Graph {
  Node[] nodes;
  Edge[] distances;
  ArrayList<Edge> edges;
  public Graph(Node[] nodes) {
    this.nodes = nodes;
    edges = new ArrayList<Edge>();
  }

  public void display() {
    for (Node v : nodes)
      v.display();
    for (Edge e : edges)
      e.display();
  }

  // Sorts potential edge distances from smallest to largest
  Edge[] getSortedDistances() {
    if (distances != null) 
      return distances;
    ArrayList<Edge> totalEdges = new ArrayList<Edge>();

    for (int i = 0; i < nodes.length - 1; i++) {
      for (int j = i+1; j<nodes.length; j++) {
        Edge e = new Edge(nodes[i], nodes[j]);
        totalEdges.add(e);
      }
    }
    Collections.sort(totalEdges, new EdgesCompare());
    return (Edge[]) totalEdges.toArray();
  }

  public void addEdge(Node a, Node b) {
    addEdge(new Edge(a, b));
  }
  public void addEdge(Edge e) {
    if (!edges.contains(e))
      edges.add(e);
  }

  public int size() {
    return nodes.length;
  }
}


class EdgesCompare implements Comparator<Edge> {
    @Override
    public int compare(Edge o1, Edge o2) {
        Float f1 = o1.weight();
        return f1.compareTo(o2.weight());
    }
}
