#import "@local/dobbikov:1.0.0":*
#import "@preview/cetz:0.4.2"

#let arrow-style = (
  mark: (end: "stealth", fill: black, scale: 0.5),
  stroke: 0.5pt,
)

#show: dobbikov.with(
  title: [Unitary and Orthogonal matrices],
  subtitle: none,
  author: "Yehor KORORTENKO",
  date: datetime.today(),
  report-style: true
)

// #toc
= Introduction
Linear algebra contains a lot of particular objects with properties that make
life easier. Such an example are *orthogonal matrices* or *unitary
matrices*(for comlpex $CC$ case). Such matrices are defined in the following way:
#defn(info: "Unitary Matrix")[
  A matrix $O$ is called unitary if and only if
   $
  O^(-1) = O^*
  $ 
  where $O^*$ is an adjoint matrix.
]

Even though, the definition may seem abstract, it has concrete geometric interpretation.

= Intuition and Interpretation
The interpretation will be given trough and example in $RR^2$. Let's introduce an orthogonal matrix 
#grid(columns: (50%, 50%), align: center, [
 $
O = mat(-1/sqrt(2), 1/sqrt(2); 1/sqrt(2), 1/sqrt(2)) = mat(v_1, v_2)
$ 
The column vectors of the matrix $O$ are drawn on the right
],[


#cetz.canvas({
  import cetz.draw: *
let x-range =1 
let y-range =1 
  line((-x-range - 1, 0), (x-range + 1, 0), ..arrow-style, name: "x-axis")
  content("x-axis.end", $x$, anchor: "south-east", padding: 2pt)

  line((0, -y-range - 0.7), (0, y-range + 0.7), ..arrow-style, name: "y-axis")
  content((rel: (-0.2, 0), to: "y-axis.95%"), $y$, name: "y-label", anchor: "south-east", padding: 1pt)

  // vectors
  line((0, 0), (-1/1.4142, 1/1.4142), ..arrow-style, fill: red, name: "v1")
  content((rel: (-0.7, 0), to: "v1"), $v_1$, anchor: "south-west", padding: 0pt)
  line((0, 0), (1/1.4142, 1/1.4142), ..arrow-style, fill: red, name: "v2")
  content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south-west", padding: 11pt)
})
])

Let's remind that given vector $u = mat(x; y)$,  matrix multiplication $O dot u
= x dot v_1 + y dot v_2$. For instance, if  $u = mat(1; 2)$, then  $O dot u = 1
dot v_1 + 2 dot v_2$ graphically presented below:

#grid(columns: (50%, 50%), align: (center, auto),[
#cetz.canvas({
  import cetz.draw: *
let x-range =2 
let y-range =2 
  line((-x-range - 1, 0), (x-range + 1, 0), ..arrow-style, name: "x-axis")
  content("x-axis.end", $x$, anchor: "south-east", padding: 2pt)

  line((0, -0.7), (0, y-range + 0.7), ..arrow-style, name: "y-axis")
  content((rel: (-0.2, 0), to: "y-axis.95%"), $y$, name: "y-label", anchor: "south-east", padding: 1pt)

  // vectors
  let v_1_x = -1/1.4142 
  let v_1_y = 1/1.4142

  let v_2_x = 1/1.4142 
  let v_2_y = 1/1.4142
  line((0, 0), (v_1_x, v_1_y), ..arrow-style, fill: red, name: "v1")
  content((rel: (-0.7, 0), to: "v1"), $v_1$, anchor: "south-west", padding: 0pt)
  line((0, 0), (v_2_x, v_2_y), ..arrow-style, fill: red, name: "v2")
  content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south-west", padding: 11pt)

  line((v_1_x, v_1_y), (v_1_x + v_2_x, v_1_y + v_2_y), ..arrow-style, fill: red, name: "v2")
  content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south", padding: 7pt)
  line((v_1_x + v_2_x, v_1_y + v_2_y), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), ..arrow-style, fill: red, name: "v2")
  content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south", padding: 7pt)


  // vector O u
  line((0, 0), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), ..arrow-style, fill: red, name: "ou")
  content((rel: (0, 0), to: "ou"), $O u$, anchor: "south-west", padding: 7pt)
})
],
[
As shown on the picture, vector $O u =: k$ is taking  $v_1$ once,  $v_2$ twice and gets their sum.
])

The important property here is the orthogonality of $v_1$ and  $v_2$. To be
more precise, in order to get the coordinates of a vector in an orthogonal
bases it is sufficient to get dot product of the vector with each basis vector.

In our case,  $O^* = O^T$, i.e. if $O = mat(v_1, v_2)$ then  
$
O^T = mat(v_1^T; v_2^T) = mat(-1/sqrt(2), 1/sqrt(2); 1/sqrt(2), 1/sqrt(2))
$

Then, 
#grid(
columns: (50%, 50%), align: center, [

#cetz.canvas({
  import cetz.draw: *
let x-range =2 
let y-range =2 
  line((-x-range - 1, 0), (x-range + 1, 0), ..arrow-style, name: "x-axis")
  content("x-axis.end", $x$, anchor: "south-east", padding: 2pt)

  line((0, -0.7), (0, y-range + 0.7), ..arrow-style, name: "y-axis")
  content((rel: (-0.2, 0), to: "y-axis.95%"), $y$, name: "y-label", anchor: "south-east", padding: 1pt)

  // vectors
  let v_1_x = -1/1.4142 
  let v_1_y = 1/1.4142

  let v_2_x = 1/1.4142 
  let v_2_y = 1/1.4142
  line((0, 0), (v_1_x, v_1_y), ..arrow-style, stroke: (thickness: 1pt, paint: red), name: "v1")
  content((rel: (-0.7, 0), to: "v1"), $angle.l O u, v_1 angle.r v_1 = v_1$, anchor: "south-east", padding: 0pt)

  line((0, 0), (v_1_x, v_1_y), ..arrow-style, fill: red, name: "v1")


  line((0, 0), (v_2_x, v_2_y), ..arrow-style, fill: red, name: "v2")
  content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south-west", padding: 11pt)

  line((0, 0), (2*v_2_x, 2*v_2_y), ..arrow-style, stroke: (thickness: 0.7pt, paint: red),  name: "v2")
  content((rel: (0, 0), to: "v2"), $angle.l O u, v_2 angle.r v_2$, anchor: "south-west", padding: 20pt)

  // line((v_1_x, v_1_y), (v_1_x + v_2_x, v_1_y + v_2_y), ..arrow-style, fill: red, name: "v2")
  // content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south", padding: 7pt)
  // line((v_1_x + v_2_x, v_1_y + v_2_y), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), ..arrow-style, fill: red, name: "v2")
  // content((rel: (0, 0), to: "v2"), $v_2$, anchor: "south", padding: 7pt)


  // vector O u
  line((0, 0), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), ..arrow-style, fill: red, name: "ou")
  content((rel: (0, 0), to: "ou"), $O u$, anchor: "south-west", padding: 7pt)

  // dashed proj
  line((v_1_x, v_1_y), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), stroke: (thickness: 0.5pt, dash: "dashed"), fill: red, name: "ou")
  line((2*v_2_x, 2*v_2_y), (v_1_x + 2*v_2_x, v_1_y + 2*v_2_y), stroke: (thickness: 0.5pt, dash: "dashed"), fill: red, name: "ou")
})
],
[
$
O^T dot k = mat(v_1^T dot k; v_2^T dot k)
$
Again, as $(v_1, v_2)$ is an orthogonal basis, dot product of  $k$ with each
basis vector gives the coordinates in the basis, i.e. how much of each basis
vector we have take and then sum them up. As we did previously,  $ k = O dot u
= 1 dot v_1 + 2 dot v_2 $ Thus,  $O^T k = mat(1; 2) = u$. It is inverse operation.
]
)

Concequently, $O^(-1) = O^*$
