# An Order-Theoretic View of Quote Rejection in Container Shipping

Container-shipping rate setting often looks reactive and chaotic: market swings, inconsistent customer behavior, and noisy acceptance/rejection outcomes. But once we assume quote requests can be **totally ordered** and that feasible rates respect the same order, everything suddenly becomes simple and structured.

Once we embed both requests and rates into quantiles, the entire accept/reject logic becomes a simple comparison of numbers in $[0,1]$. From that starting point, willingness-to-pay, rejection (and booking) curves, and suggested selling rates all emerge naturally.

This post explains that structure step by step, building toward one key object:

> **The carrier-specific rejection probability curve** (the complement of the booking curve),  
> which is foundational for computing the **Suggested Selling Rate (SSR)**.

---

## 1. Market Requests as a Total Order

We begin with the set of all market quote requests:

$$
Q_{\text{market}} = \{q_{(1)}, q_{(2)}, \dots, q_{(N)}\}.
$$

We assume that **these requests can be totally ordered**:

$$
q_{(1)} \le q_{(2)} \le \dots \le q_{(N)}.
$$

### What does this order represent?

Many things in pricing behave monotonically:

- shipment volume  
- service urgency/flexibility  
- customer segment  
- historical behavior  
- any internal “flexibility” or “value” score

As long as *higher* in the order means *more willing to pay*, the model works.

---

## 2. Market Rates Respect the Same Ordering

We similarly assume the market has an ordered set of rates:

$$
R_{\text{market}}.
$$

There is a **monotone map**:

$$
m : Q_{\text{market}} \to R_{\text{market}}
$$

assigning each request the “market-clearing” rate.

### Meaning of monotonicity

If one request is less sensitive and sits higher in the order, the rate assigned to it must not be lower than that of a more sensitive request.

---

## 3. Quantile Embeddings: Putting Everything on $[0,1]$

To compare requests and rates cleanly, start with a generic quantile embedding on any finite total order $P$. The same averaging reappears in section 9 when we integrate the feasibility relation. The feasibility relation $\mathrm{hom}_P : P^{op}\times P \to \mathbf{Bool}$ is just the order relation itself, obtained from the unit monotone map $P \to \mathbf{Bool}^P$ that sends each $p$ to its principal downset; it returns $\mathbf{true}$ exactly when $p' \le p$.

$$
\phi_P(p)
= \frac{1}{|P|}
\sum_{p' \in P} \mathrm{hom}_P(p', p)
= \frac{|\{p' \in P : p' \le p\}|}{|P|}.
$$
### Request quantiles
Applied to market requests (take $P = Q_{\text{market}}$):

$$
\phi_Q(q) = \frac{|\{q' \in Q_{\text{market}} : q' \le q\}|}{|Q_{\text{market}}|}
= \frac{k}{N} \text{ for } q = q_{(k)}.
$$

Every request gets a rank between 0 and 1.

### Rate quantiles

$$
\phi_R : R_{\text{market}} \to [0,1].
$$

For rates, the same construction with $P = R_{\text{market}}$ gives:

$$
\phi_R(r) = \frac{|\{r' \in R_{\text{market}} : r' \le r\}|}{|R_{\text{market}}|}.
$$

Because $m$ is monotone and preserves ranks, $\phi_R \circ m$ and $\phi_Q$ coincide, so $Q_{\text{market}}$ and $R_{\text{market}}$ are isomorphic as total orders via the shared quantile axis.

$$
\phi_R(m(q_{(k)})) = \phi_Q(q_{(k)}).
$$

### Intuition

- Now every request and every rate corresponds to a *single number* in $[0,1]$.  
- They live on the same axis.  
- Higher quantile = higher willingness to pay / higher offered rate.

---

## 4. Acceptance/Rejection as a Boolean Feasibility Relation

Acceptance occurs when the rate quantile does not exceed the request quantile. Denote the rate quantile by $r \in [0,1]$ (formerly $\phi_R(\cdot)$) and the request quantile by $q \in [0,1]$ (formerly $\phi_Q(\cdot)$); then
$$
r \le q.
$$

Formally:

$$
F : R_{\text{market}}^{op} \times Q_{\text{market}}
\to \mathbf{Bool},
\qquad
F(r,q) = (r\le q).
$$

This is the fundamental decision rule; rejection happens exactly when $F(r,q)$ is false. From here on we work entirely in quantile coordinates on $[0,1]$, reusing $r$ and $q$ to denote rate and request quantiles. To recover physical values, apply the inverses $\phi_R^{-1}$ or $\phi_Q^{-1}$ when needed.

---

## 5. The Market Rejection Curve

Let $r \in [0,1]$ be the rate quantile. Then:

$$
\rho_{\text{market}}(r)
= \Pr(q < r)
= r.
$$

![Market feasibility relation in quantile space; rejections lie below the diagonal, acceptances above](figures/market_feasibility_relation.jpg)

### Interpretation

- If a rate sits at quantile 0.3, then 30% of requests sit below it → they reject.  
- The market rejection curve is a straight line with slope 1 (the booking curve is its complement, $1-r$).  
- In the figure, the diagonal $x=y$ splits the unit square: points below it (blue-to-red side) are rejections ($q<r$), points above it are acceptances.

---

## 6. Closures, the Nucleus, and Structural WTP

The feasibility relation induces closure operators:

### Upper closure

$$
F^\sharp(q)=\{ r \in [0,1] : r \le q \}.
$$

### Lower closure

$$
F_\flat(r)=\{ q \in [0,1] : r \le q \}.
$$

### The nucleus

$$
\mathrm{Nuc}(F)=\{(A,B): A=F^\sharp(B),\, B=F_\flat(A)\}.
$$

In total orders, each downward-closed set has a maximum, giving the **structural willingness-to-pay**:

In quantile coordinates, $F^\sharp(q)$ is the interval $[0,q]$, so the willingness-to-pay quantile is just
$$
r^*(q)=\max F^\sharp(q)=q.
$$
To recover the physical rate, apply $\phi_R^{-1}(q)$; on the unit square this is the identity along the diagonal.

### Geometric meaning of WTP

In the $(\phi_R, \phi_Q)$ unit square:
![WTP for a given request quantile](figures/wtp_for_q.jpg)
- Each request corresponds to a horizontal line at its quantile $q$.
- Feasible rates sit on or below that line (to the left of the intersection).
- The WTP is the intersection with the diagonal $x=y$; projecting down gives $r^*(q)$.
- Moving the horizontal line upward (higher $q$) shifts the WTP rightward (higher rate quantile).

---

## 7. A Carrier’s Customer Subset

Let:

$$
j : Q_{\text{carrier}} \hookrightarrow Q_{\text{market}}
$$

be inclusion.

Carrier-induced rate map:

$$
m\circ j : Q_{\text{carrier}} \to R_{\text{market}}.
$$

Carrier quantile embedding:

$$
\phi_{\text{carrier}}(q)
=
\frac{
|\{q' \in Q_{\text{carrier}} : q' \le q\}|
}{
|Q_{\text{carrier}}|
}.
$$

This expresses the carrier’s internal demand distribution on the same $[0,1]$ quantile axis.

![Carrier subset pulled back into market quantiles](figures/subset_precomposition.jpg)
- The inclusion $j$ pulls carrier requests into market order; composing with $m$ places them on the shared quantile line.
- The carrier distribution typically sits at different quantiles than the market, reflecting its mix.
- With $\phi_{\text{carrier}}$ we compare carrier demand and market rates on the same $[0,1]$ axis.

![Carrier feasibility relation in quantile space](figures/carrier_feasibility_relation.jpg)
- Pulling back the market feasibility along $j$ and $m$ smooths the sharp diagonal into the carrier’s own contour.
- The boundary shifts off $x=y$ because the carrier sees a different mix; acceptance at a given rate quantile can be above or below market.
- The band still monotone-separates accept/reject regions, defining the carrier’s feasibility frontier.
---

## 8. Why We First Need the Carrier Rejection Curve to Define SSR

The carrier-specific rejection curve is:

$$
\rho_{\text{carrier}}(r)
=
\Pr(\text{rejection at rate } r \mid q\in Q_{\text{carrier}})
= 1 - \Pr(\text{booking at rate } r \mid q\in Q_{\text{carrier}}).
$$

Each carrier sees a **non-uniform slice** of the market →  
each has its **own** rejection curve (and thus its own booking curve by complement).

### SSR is chosen *from* this curve

Examples:

- volume-oriented carriers → target small $\rho_{\text{carrier}}(r)$ (high acceptance),  
- yield-oriented carriers → maximize $r \cdot (1-\rho_{\text{carrier}}(r))$,  
- balanced strategies → choose quantile-based rejection levels.

Thus:

> **To define SSR, we must first derive $\rho_{\text{carrier}}(r)$.**

---

## 9. Structural Derivation of the Carrier Rejection Curve

Two structural paths:

- **Approach A:** via willingness-to-pay  
- **Approach B:** via pullback → curry → average  

Both produce the same $\rho_{\text{carrier}}(r)$.

---

## 9.1 Approach A — Via Carrier Willingness-to-Pay

The market WTP function in quantile space is simply:

$$
r^*(q)=q.
$$

Restrict to the carrier:

$$
r^*_{\text{carrier}}(q) = r^*(j(q)) = \text{market quantile of } j(q).
$$

This yields each carrier customer's **maximum feasible rate**; to recover the physical rate, apply $\phi_R^{-1}(r^*_{\text{carrier}}(q))$.

### Constructing the carrier rejection curve

$$
\rho_{\text{carrier}}(r)
=
\frac{
|\{ q \in Q_{\text{carrier}} : r > r^*_{\text{carrier}}(q) \}|
}{
|Q_{\text{carrier}}|
}.
$$

### Quantile expression

$$
\rho_{\text{carrier}}(r)=\phi_{\text{carrier}}(q_r),
$$
where $q_r$ is the market request at quantile $r$ (equivalently, the point on the diagonal with request quantile $q=r$).

---

## 9.2 Approach B — Pullback → Curry → Average

### Step 1 — Pullback

$$
F_{\text{carrier}}(r,q)=F(r,j(q)).
$$

### Step 2 — Curry

$$
\chi_r(q)=F_{\text{carrier}}(r,q).
$$

### Step 3 — Average

$$
\rho_{\text{carrier}}(r)
=
\frac{1}{|Q_{\text{carrier}}|}
\sum_{q\in Q_{\text{carrier}}} (1-\chi_r(q)).
$$

### Why this matters

- Works directly with the feasibility relation (booking = $\chi_r$, rejection = $1-\chi_r$)  
- Natural for estimation  
- Equivalent to WTP approach in total orders

---

## 10. Estimation Regimes

Observed data:

$$
(r_i, q_i, y_i),\qquad y_i\in\{0,1\}.
$$

Here $y_i=1$ means a booking (so $1-y_i$ is a rejection indicator). Two behavioral assumptions:

### Targeted (WTP-aligned) pricing

$r_i \approx r^*(q_i)$.

### Random-rate pricing

$$
y_i\sim \mathrm{Bernoulli}(q_i \ge r_i).
$$

Each produces a different estimator $\widehat{\rho}_{\text{carrier}}(r)=1-\widehat{\beta}_{\text{carrier}}(r)$.

---

## 11. Closing Thoughts

Under the total-order assumption:

- accept/reject = comparing quantiles  
- WTP = maximum feasible rate  
- carrier demand = market subset  
- carrier rejection curve = head probability (booking is its complement)  
- **SSR = a chosen point balancing rate and rejection**

This framework generalizes to multidimensional request spaces and non-total orders.

---
