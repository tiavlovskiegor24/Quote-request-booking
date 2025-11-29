## 4. Quantile Embeddings: Putting Everything on $[0,1]$

To compare requests and rates cleanly, embed any finite total order $Q$ into $[0,1]$ by turning each element into its cumulative rank: count how many elements are at or below it, then divide by $|Q|$.

Define the quantile embedding

$$
\phi_Q : Q \to [0,1],
\qquad
\phi_Q(q)
= \frac{|\{q' \in Q : q' \le q\}|-1}{|Q|-1}.
$$

![Quantile embedding of a finite totally ordered set $Q$ into $[0,1]$](figures/quantile_embedding.jpg)

A more explicit form of that embedding:
Begin with the canonical feasibility relation $\mathrm{hom}_Q : Q^{op}\times Q \to \mathbf{Bool}$, which just records the order: $\mathrm{hom}_Q(q',q) = \mathbf{true}$ exactly when $q'\le q$.

Curry it in the first argument: fix $q$ and read $\mathrm{hom}_Q(-,q) : Q \to \mathbf{Bool}$ as an ordinary function. This is the indicator (1 if an element is in a set, 0 otherwise) of the principal down-set $\downarrow q$ (all elements $\le q$), written $\chi_{\downarrow q} : Q \to \mathbf{Bool}$ with

$$
\chi_{\downarrow q}(q') = \mathrm{hom}_Q(q',q).
$$

Average those indicators uniformly over all $q' \in Q$: sum the Boolean values (1 when $q' \le q$, 0 otherwise) and divide by $|Q|$. This produces a cumulative rank; we then rescale it so that the minimum of $Q$ maps to $0$ and the maximum to $1$, with equal steps in between. This is the same averaging/rescaling used later when integrating feasibility relations in section 9.2. In terms of the embedding $\phi_Q$ defined above, this is

$$
\phi_Q(q)
= \frac{1}{|Q|-1}
\sum_{q' \in Q} \chi_{\downarrow q}(q') - \frac{1}{|Q|-1}
= \frac{1}{|Q|-1}
\sum_{q' \in Q} \mathrm{hom}_Q(q',q) - \frac{1}{|Q|-1}.
$$

Here the sum counts how many elements lie in $\downarrow q$: each indicator contributes 1 when $q'$ is below $q$ and 0 otherwise. Subtracting $1$ and dividing by $|Q|-1$ linearly rescales this cumulative rank so that the minimum element of $Q$ gets value $0$ and the maximum gets value $1$.

### Request quantiles
Applied to market requests (take $Q = Q_{\text{market}}$):

$$
\phi_Q : Q_{\text{market}} \to [0,1],
\qquad
\phi_Q(q) = \frac{|\{q' \in Q_{\text{market}} : q' \le q\}|-1}{|Q_{\text{market}}|-1}
= \frac{k-1}{N-1} \text{ for } q = q_{(k)}.
$$

Every request gets a rank between 0 and 1. We write

$$
[0,1]_Q := \mathrm{im}(\phi_Q) \subseteq [0,1]
$$

for the resulting request‑quantile axis inside the unit interval.

### Rate quantiles

$$
\phi_R : R_{\text{market}} \to [0,1].
$$

For rates, the same construction with $P = R_{\text{market}}$ gives:

$$
\phi_R(r) = \frac{|\{r' \in R_{\text{market}} : r' \le r\}|-1}{|R_{\text{market}}|-1}.
$$

We similarly denote the image of $\phi_R$ by

$$
[0,1]_R := \mathrm{im}(\phi_R) \subseteq [0,1],
$$

the rate‑quantile axis inside the unit interval.

Because $m$ is monotone and preserves ranks, $\phi_R \circ m$ and $\phi_Q$ coincide, so $Q_{\text{market}}$ and $R_{\text{market}}$ are isomorphic as total orders via their quantile images $[0,1]_Q$ and $[0,1]_R$ (both sitting inside the same unit interval).

$$
\phi_R(m(q_{(k)})) = \phi_Q(q_{(k)}).
$$

### Intuition

- Now every request and every rate corresponds to a *single number* in $[0,1]$.  
- They live on the same axis; we use subscripts such as $[0,1]_Q$ and $[0,1]_R$ only when we want to remember whether a quantile came from requests or from rates.  
- Higher quantile = higher willingness to pay / higher offered rate.

From here on we work entirely in quantile coordinates on $[0,1]$, reusing $r$ and $q$ to denote rate and request quantiles. To recover physical values, apply the inverses

$$
\phi_R^{-1} : [0,1]_R \to R_{\text{market}},
\qquad
\phi_Q^{-1} : [0,1]_Q \to Q_{\text{market}},
$$

when needed.

---
