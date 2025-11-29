## 7. A Carrier’s Customer Subset as a Restricted Nucleus

So far we have described the market as a single feasibility profunctor

$$
F : [0,1]_R^{op} \times [0,1]_Q \to \mathbf{Bool}
$$

with nucleus $\mathrm{Nuc}(F)$ and extremal scalar maps

$$
r^* : [0,1]_Q \to [0,1]_R,
\qquad
q^* : [0,1]_R \to [0,1]_Q,
$$

encoding structural willingness‑to‑pay and the market rejection map. The corresponding pointwise nucleus records these maps at the level of extremal pairs:

$$
\mathrm{Nuc}(F)_{\mathrm{ext}}
= \{(r,q) \in [0,1]_R \times [0,1]_Q : r = r^*(q),\; q = q^*(r)\}.
$$

In practice, however, an individual carrier only sees a subset of the market’s quote requests.

### Restricting the request side

Let $Q_{\text{carrier}}\subseteq Q_{\text{market}}$ be the subset of market requests that actually appear in the carrier’s portfolio. Applying the same quantile construction as in section 4 to $Q_{\text{carrier}}$ produces a carrier request‑quantile subset

$$
[0,1]_{Q_{\text{carrier}}} \subseteq [0,1]
$$

as the image of the carrier quantile embedding

$$
\phi_{Q_{\text{carrier}}} : Q_{\text{carrier}} \to [0,1],
\qquad
\phi_{Q_{\text{carrier}}}(q)
=
\frac{
|\{q' \in Q_{\text{carrier}} : q' \le q\}|-1
}{
|Q_{\text{carrier}}|-1
},
$$

and recalling that the market embedding $\phi_Q : Q_{\text{market}} \to [0,1]$ has image $[0,1]_Q\subseteq[0,1]$, the inclusion $Q_{\text{carrier}}\hookrightarrow Q_{\text{market}}$ induces a monotone embedding between the corresponding request‑quantile images

$$
j : [0,1]_{Q_{\text{carrier}}} \hookrightarrow [0,1]_Q,
$$

which we read as “carrier request quantiles included into market request quantiles”. 
Because these are totally ordered sets, this inclusion sits in a Galois pair of adjoints. The **left adjoint**

$$
j_! : [0,1]_Q \to [0,1]_{Q_{\text{carrier}}},
$$

is characterized by

$$
j_!(q) \le q_c
\;\Longleftrightarrow\;
q \le j(q_c)
\quad
\text{for all } q \in [0,1]_Q,\; q_c \in [0,1]_{Q_{\text{carrier}}}.
$$

On the chain $[0,1]_{Q_{\text{carrier}}}$ this becomes the **least** carrier quantile whose image lies above $q$:

$$
j_!(q)
=
\min \{ q_c \in [0,1]_{Q_{\text{carrier}}} : q \le j(q_c)\}
=
1-
\frac{
|\{ q_c \in [0,1]_{Q_{\text{carrier}}} : q \le j(q_c)\}|-1
}{
|Q_{\text{carrier}}|-1
},
$$

whenever such a minimum exists. In a more familiar numerical setting, this plays the role of a “ceiling” operation: given an embedded value $q$, $j_!(q)$ picks the smallest carrier quantile that does not lie below it. Because $j$ is an order-embedding, the composite acts as the identity on carrier quantiles:

$$
j_!\bigl(j(q_c)\bigr) = q_c
\quad
\text{for all } q_c \in [0,1]_{Q_{\text{carrier}}}.
$$

![Left adjoint sending market quantiles down to carrier quantiles](figures/left_adjoint.jpg)
- The inclusion $j$ is drawn in green and sends carrier quantiles $q_c$ into the market quantile set $[0,1]_Q$.
- The left adjoint $j_!$ is drawn in red and sends each market quantile $q$ **down** to the least carrier quantile $q_c$ whose image lies at or above $q$.
- In terms of order, $j_!(q)$ is the best carrier-side approximation *from below* to $q$ that respects the inclusion $j$.

Symmetrically, the **right adjoint**

$$
\overline{j} : [0,1]_Q \to [0,1]_{Q_{\text{carrier}}},
$$

is characterized by

$$
j(q_c) \le q
\;\Longleftrightarrow\;
q_c \le \overline{j}(q)
\quad
\text{for all } q \in [0,1]_Q,\; q_c \in [0,1]_{Q_{\text{carrier}}}.
$$

Concretely, $\overline{j}(q)$ is the largest carrier quantile that still maps below (or equal to) the market quantile $q$; in our finite setting

$$
\overline{j}(q)
=
\max \{ q_c \in [0,1]_{Q_{\text{carrier}}} : j(q_c) \le q\}
=
\frac{
|\{q_c \in [0,1]_{Q_{\text{carrier}}} : j(q_c) \le q\}|
}{
|Q_{\text{carrier}}|
}.
$$

Both adjoints will be useful: in what follows we use the right adjoint $\overline{j}$ to define the carrier rejection map $q^*_{\text{carrier}}$ from the market rejection map $q^*$, and later constructions can equally be phrased in terms of the left adjoint $j_!$ when pushing carrier quantiles forward into market order.

![Carrier subset pulled back into market quantiles](figures/subset_precomposition.jpg)

Categorically, we restrict the market profunctor along the inclusion $j$ on the request side:

$$
F_{\text{carrier}}(r,q)
:=
F\bigl(r,\,j(q)\bigr),
\qquad
F_{\text{carrier}} : [0,1]_R^{op} \times [0,1]_{Q_{\text{carrier}}} \to \mathbf{Bool}.
$$

This is the carrier’s feasibility relation: it records booking behavior only for those requests that actually appear in the carrier’s portfolio.

![Carrier feasibility relation in quantile space](figures/carrier_feasibility_relation.jpg)
- Above is the smoothed version of this restriction, which is approximately how the curve would look if the market pool and the carrier subset were very large
- The band still monotone‑separates accept/reject regions, defining the carrier’s feasibility frontier.
- The feasibility boundary shifts off $x=y$ compared to the market because the carrier sees a different mix; acceptance at a given rate quantile can be above or below market.


### The carrier nucleus as a slice of the market nucleus

The restricted profunctor $F_{\text{carrier}}$ has its own nucleus

$$
\mathrm{Nuc}(F_{\text{carrier}})
\subseteq
\mathcal{P}([0,1]_R) \times \mathcal{P}([0,1]_{Q_{\text{carrier}}}),
$$

consisting of pairs $(A,B_{\text{c}})$ of rate‑ and carrier‑request sets satisfying

$$
A = F_{\text{carrier}}^\sharp(B_{\text{c}}),
\qquad
B_{\text{c}} = F_{\text{carrier}}^\flat(A).
$$

By construction, this nucleus is just the market nucleus seen through the inclusion $j$: a pair $(A,B_{\text{c}})$ belongs to $\mathrm{Nuc}(F_{\text{carrier}})$ exactly when

$$
\bigl(A,\, j(B_{\text{c}})\bigr) \in \mathrm{Nuc}(F).
$$

In other words, we obtain the carrier nucleus by restricting the market nucleus on the request side to those subsets that live entirely inside $Q_{\text{carrier}}$. All the structure we built for the market simply pulls back along $j$.

### Carrier extremal maps and the carrier rejection map

Just as the market nucleus admits scalar summaries $(r^*, q^*)$, the restricted nucleus induces carrier‑specific extremal maps

$$
r^*_{\text{carrier}} : [0,1]_{Q_{\text{carrier}}} \to [0,1]_R,
\qquad
q^*_{\text{carrier}} : [0,1]_R \to [0,1]_{Q_{\text{carrier}}},
$$

defined by

$$
r^*_{\text{carrier}}(q)
 :=
 \max F_{\text{carrier}}^\sharp(\{q\}),
\qquad
q^*_{\text{carrier}}(r)
 :=
 \min F_{\text{carrier}}^\flat(\{r\}).
$$

Unwinding the definitions, the carrier WTP map is simply the market one composed with the inclusion:

$$
r^*_{\text{carrier}}(q) = r^*\bigl(j(q)\bigr).
$$

For the rejection map, we simply compose the market rejection map with the left adjoint of the inclusion:

$$
q^*_{\text{carrier}}(r) = j_!\bigl(q^*(r)\bigr).
$$

Here $r^*_{\text{carrier}}(q)$ is the carrier’s structural WTP at carrier request quantile $q$, while $q^*_{\text{carrier}}(r)$ is the carrier’s rejection map: the carrier‑side quantile level at which the rate $r$ starts to be rejected.

The carrier’s pointwise nucleus mirrors the market one at the level of extremal points:

$$
\mathrm{Nuc}(F_{\text{carrier}})_{\mathrm{ext}}
= \{(r,q) \in [0,1]_R \times [0,1]_{Q_{\text{carrier}}} : r = r^*_{\text{carrier}}(q),\; q = q^*_{\text{carrier}}(r)\}.
$$

Given this construction, the carrier‑specific rejection probability curve described in section 8 is obtained by reading $q^*_{\text{carrier}}$ as a probability via the same “quantile = mass below” semantics used for the market:

$$
\rho_{\text{carrier}} : [0,1]_R \to [0,1],
\qquad
\rho_{\text{carrier}}(r)
=
\Pr\bigl(\text{rejection at rate } r \mid q \in Q_{\text{carrier}}\bigr)
=
q^*_{\text{carrier}}(r).
$$

Thus the carrier rejection curve is nothing new structurally—it is the rejection map of the restricted nucleus, evaluated numerically as a quantile in $[0,1]$.

<!--
