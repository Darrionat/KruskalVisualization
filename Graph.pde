import java.util.Collections;
import java.util.Comparator;

class Node {
  private float x;
  private float y;
  private int id;
  Node(int id, float x, float y) {
    this.id = id;
    this.x = x;
    this.y = y;
  }

  public void display() {
    fill(0);
    circle(x, y, 5);
    // fill(255,0,0);
    // text(id,x+5, y);
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
  private Node a;
  private Node b;
  Edge(Node a, Node b) {
    this.a = a;
    this.b = b;
  }

  public void display() {
    display(color(0));
  }

  public void display(color c) {
    fill(c);
    line(a.getX(), a.getY(), b.getX(), b.getY());
  }


  public Node getNodeOne() {
    return a;
  }

  public Node getNodeTwo() {
    return b;
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
  private Node[] nodes;
  private ArrayList<Edge> edges;
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
  // Does not save to memory
  Edge[] getSortedDistances() {
    ArrayList<Edge> totalEdges = new ArrayList<Edge>();

    for (int i = 0; i < nodes.length - 1; i++) {
      for (int j = i+1; j<nodes.length; j++) {
        Edge e = new Edge(nodes[i], nodes[j]);
        totalEdges.add(e);
      }
    }
    Collections.sort(totalEdges, new EdgesCompare());
    Edge[] toReturn = new Edge[totalEdges.size()];
    for (int i = 0; i < toReturn.length; i++) {
      toReturn[i] = totalEdges.get(i);
    }
    return toReturn;
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
