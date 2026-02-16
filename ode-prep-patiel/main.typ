= Prep partiel

#let Spec = "Spec"
#let Ker = "Ker"
#let det = "det"
#let Id = "Id"
#let Vect = "Vect"
#let dim = "dim"


== Partiel 2025, Exercice P.3

1.
$
A = mat(-6, 16, -16, 5; 0, 2, 0, 0; 1, -2, 4, -1; -6, 12, -12, 5)
$ 

$
A - lambda"Id" = mat(
  -6-lambda, 16, -16, 5; 
  0, 2-lambda, 0, 0; 
  1, -2, 4-lambda, -1; 
  -6, 12, -12, 5-lambda
)
$ 
$
det |A - lambda Id| \ &= (2-lambda)
mat(
  -6-lambda, -16, 5; 
  1, 4-lambda, -1; 
  -6, -12, 5-lambda
) \ 
&= (2-lambda) 
mat(
  -lambda, -4, lambda; 
  1, 4-lambda, -1; 
  -6, -12, 5-lambda
) \ 
&= (2-lambda)  
mat(
  -lambda, -4, 0; 
  1, 4-lambda, 0; 
  -6, -12, -1-lambda
) \
&= (2 -lambda)(-1 - lambda) mat(
  -lambda, -4; 
  1, 4-lambda; 
) \
&= (2 - lambda)(-1 -lambda) mat(-lambda, -4; 1 - lambda, -lambda) \
&= (2 - lambda)(-1 -lambda) (lambda^2 + (4 - 4lambda)) \ 
&= (2 - lambda)^2 (-1 -lambda)
$ 

donc $Spec(A) = {2, -1}$. De plus $lambda_1 = -1$ car c'est une valeur propre de multiplicité 1.

2. Espace propre de $lambda_1$

 $
&Ker(A - lambda_1 Id) = Ker(A + Id) = mat(
  -6--1, 16, -16, 5; 
  0, 2--1, 0, 0; 
  1, -2, 4--1, -1; 
  -6, 12, -12, 5--1
) = mat(
  -5, 16, -16, 5; 
  0, 3, 0, 0; 
  1, -2, 5, -1; 
  -6, 12, -12, 6 
)\
<=>& cases(
  &-5x + &16y - &16z + &5t &= 0,
&        &3y   &      &   &= 0,
&x - &2y + &5z  - &t &= 0,
-&6x + &12y -&12z + &6t &= 0

)\ 
<=>& cases(
  &-5x + & - &16z + &5t &= 0,
&        &   &      &y   &= 0,
&x  & + &5z  - &t &= 0,
-&6x + & -&12z + &6t &= 0
) \
<=>& cases(
  &-5x + & - &16z + &5t &= 0,
&        &   &      &y   &= 0,
&x  & + &5z  - &t &= 0,
&  & &18z  & &= 0
) \

<=>& cases(
  &-5x + & & + &5t &= 0,
&x  &  &  - &t &= 0,
&        &   &      &y   &= 0,
&  & &  & z&= 0
) \ 
<=>& cases(
  & & & &x &= t,
&        &   &      &y   &= 0,
&  & &  & z&= 0
) \ 
$ 
Donc $Ker(A + Id) = mat(x; 0; 0; x)$ avec $x in RR$, d'où  $u_1 = mat(1; 0; 0; 1)$

3. Sous-espace propre pour  $lambda_2 = 2$

 $
&Ker(A - lambda_2 Id) = Ker(A - 2 Id) = mat(
  -8, 16, -16, 5; 
  0, 0, 0, 0; 
  1, -2, 2, -1; 
  -6, 12, -12, 3
)\
<=>& cases(
  -&8x + &16y - &16z + &5t &= 0,
  &x  -&2y + &2z - &t &= 0,
  -&6x + &12y - &12z + &3t &= 0,
)\
<=>& cases(
  &  &  &  &-3t &= 0,
  &x  -&2y + &2z - &t &= 0,
  -&6x + &12y - &12z + &3t &= 0,
)\
<=>& cases(
  &  &  &  &t &= 0,
  &x  -&2y + &2z  & &= 0,
  -&6x + &12y - &12z & &= 0,
)\
<=>& cases(
  &  &  &  &t &= 0,
  &  & &  &x &= 2y - 2z,
)\
<=>& Ker(A - lambda_2 Id) = mat(2y -2z; y; z; 0) =y mat(2; 1; 0; 0) + z mat( -2; 0; 1; 0) \
<=>& Ker(A - lambda_2 Id) = Vect(mat(2; 1; 0; 0), mat( -2; 0; 1; 0))
$ 
Donc $dim(Ker(A - lambda_2 Id)) = 2$ et  $dim(Ker(A - lambda_1 id)) = 1$ et  $2
+ 1 != 4 = "qqch avec A"$, d'où la matrice  $A$ n'est pas diagonalisable. On
note  $u_2 = mat(2; 1; 0; 0)$ et  $v_2 = mat(-2; 0; 1; 0)$ 

4. Trouver vecteur $w$ pour trigonalisation

 $
&(A -lambda_2 Id)w = v_2 = (A -2 id)w = v_2 \
<=>& cases(
  -&8w_1 + &16w_2 - &16w_3 + &5w_4 &= -2,
  &0 + &0 + &0 + &0  &= 0,
  &w_1  -&2w_2 + &2w_3 - &w_4 &= 1,
  -&6w_1 + &12w_2 - &12w_3 + &3w_4 &= 0
)\
<=>& cases(
  -&8w_1 + &16w_2 - &16w_3 + &5w_4 &= -2,
  &0 + &0 + &0 + &0  &= 0,
  &w_1  -&2w_2 + &2w_3 - &w_4 &= 1,
  &0 + &0 + &0 + &-3w_4 &= 6 
)\
<=>& cases(
  -&8w_1 + &16w_2 - &16w_3 + &5w_4 &= -2,
  &0 + &0 + &0 + &0  &= 0,
  &w_1  -&2w_2 + &2w_3 - &w_4 &= 1,
  &  &  &  &w_4 &= -2 
)\
<=>& cases(
  -&8w_1 + &16w_2 - &16w_3 & &= -2 - 5(-2) = 8,
  &w_1  -&2w_2 + &2w_3  & &= 1 + (-2) = -1,
  &  &  &  &w_4 &= -2 
)\
<=>& cases(
  &w_1  -&2w_2 + &2w_3  & &= -1,
  &  &  &  &w_4 &= -2 
)\
$ 
Si on choisit $w = mat(w_1; w_2; w_3; w_4) = mat(-1; 0; 0; -2)$, ce vecteur vérifie le système.

5 $B = (u_1, u_2, v_2, w)$ est une base de  $RR^4$. 
Donc  $P$ est la base des vecteurs trouvé  $(u_1, u_2, v_2, w)$, d'où
$
P = mat(
  1, 2, -2, -1; 
  0, 1, 0, 0;
  0, 0, 1, 0;
  1, 0, 0, -2
)
$ 

$P$ est une matrice de passage donc elle est inversible (ses colonnes forment une base de $RR^4$ donc elles sont linéarement indépendantes)

6. Calcule de $P^(-1)$ 


$
P^(-1) &= mat(
  1, 2, -2, -1, |, 1, 0, 0, 0; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  1, 0, 0, -2, |, 0, 0, 0, 1
)\
&= mat(
  1, 2, -2, -1, |, 1, 0, 0, 0; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, -2, 2, -1, |, -1, 0, 0, 1
)\
&= mat(
  1, 0, 0, -2, |, 0, 0, 0, 1; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, -2, 2, -1, |, -1, 0, 0, 1
)\
&= mat(
  1, 0, 0, -2, |, 0, 0, 0, 1; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, 0, 2, -1, |, -1, 2, 0, 1
)\
&= mat(
  1, 0, 0, -2, |, 0, 0, 0, 1; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, 0, 0, -1, |, -1, 2, -2, 1
)\
&= mat(
  1, 0, 0, -2, |, 0, 0, 0, 1; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, 0, 0, 1, |, 1, -2, 2, -1
)\
&= mat(
  1, 0, 0, 0, |, 2, -4, 4, -1; 
  0, 1, 0, 0, |, 0, 1, 0, 0;
  0, 0, 1, 0, |, 0, 0, 1, 0;
  0, 0, 0, 1, |, 1, -2, 2, -1
)\
=>& P^(-1) = mat(
   2, -4, 4, -1; 
   0, 1, 0, 0;
   0, 0, 1, 0;
   1, -2, 2, -1
)\
$ 

7. Résolution du système

$
cases(
  Y' = A Y,
  Y(0) = X_0
) <=> cases(
  (P^(-1)Y)' = P^(-1) A P P^(-1) Y,
  (P^(-1) Y)(0) = P^(-1) X_0
) <=> cases(
  Z' = T Z,
  Z(0) = P^(-1) X_0 "et" Z = P^(-1) Y
)
$ 
$
Z(0) = mat(
   2, -4, 4, -1; 
   0, 1, 0, 0;
   0, 0, 1, 0;
   1, -2, 2, -1
)mat(-1; -3; 0; 8) = mat(18; -3; 0; 13)
$ 

$T = D + N$ avec 
 $
D = mat(
  lambda_1, 0, 0, 0; 
  0, lambda_2, 0, 0; 
  0, 0, lambda_2, 0;
  0, 0, 0, lambda_2
) "et" N = mat(
0, 0, 0, 0; 
0, 0, 0, 0; 
0, 0, 0, 1; 
0, 0, 0, 0
)
$ 

$
M arrow.hook e^M = sum_(k >= 0) M^k/k!
$ 
$
D = "diag"(d_1, ..., d_n) \
e^D = "diag"(e^(d_1), ..., e^(d_n))
$ 
$N$ nilpotente,  $exists p in NN$ tq  $N^p = 0$,
 $
e^N = sum_(k=0)^(p-1) N^k/k!
$ 
$D$ et  $N$ commutent et  $N^2 = 0$ donc  $e^(t T) = e^(t D) times e^(t N)$,  $t in RR$

$
e^(t D) &= "diag"(e^(-t), e^(2t), e^(2t), e^(2t)) (I + t N) \
        &= mat(
          e^(-t), 0, 0, 0;
          0, e^(2t), 0, 0;
          0, 0, e^(2t), 0;
          0, 0, 0, e^(2t);
      ) mat(
        1, 0, 0, 0;
        0, 1, 0, 0;
        0, 0, 1, t;
        0, 0, 0, 1
      ) \
&= mat(
          e^(-t), 0, 0, 0;
          0, e^(2t), 0, 0;
          0, 0, e^(2t), t e^(2t);
          0, 0, 0, e^(2t);
      )
$ 
L'unique solution du problème de Cauchy est pour $t in RR$,  $Z(t) = e^(t T) Z(0)$. Ainsi, l'unique solution globale du système est
$
Y(t) = P Z(t)
$ 

