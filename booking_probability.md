# An Order-Theoretic View of Quote Booking in Container Shipping

Container-shipping rate setting often looks reactive and chaotic: market swings, inconsistent customer behavior, and noisy booking outcomes. But once we assume quote requests can be **totally ordered** and that feasible rates respect the same order, everything suddenly becomes simple and structured.

Once we embed both requests and rates into quantiles, the entire booking logic becomes a simple comparison of numbers in $[0,1]$. From that starting point, willingness-to-pay, booking curves, and suggested selling rates all emerge naturally.

This post explains that structure step by step, building toward one key object:

> **The carrier-specific booking probability curve**,  
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

To compare requests and rates cleanly, we embed them into quantiles.

### Request quantiles

$$
\phi_Q(q_{(k)}) = \frac{k}{N}.
$$

Every request gets a rank between 0 and 1.

### Rate quantiles

$$
\phi_R : R_{\text{market}} \to [0,1].
$$

Because $m$ is monotone:

$$
\phi_R(m(q_{(k)})) = \phi_Q(q_{(k)}).
$$

### Intuition

- Now every request and every rate corresponds to a *single number* in $[0,1]$.  
- They live on the same axis.  
- Higher quantile = higher willingness to pay / higher offered rate.

---

## 4. Booking as a Boolean Feasibility Relation

Booking occurs when:

$$
\phi_R(r) \le \phi_Q(q).
$$

Formally:

$$
F : R_{\text{market}}^{op} \times Q_{\text{market}}
\to \mathbf{Bool},
\qquad
F(r,q) = (\phi_R(r)\le\phi_Q(q)).
$$

This is the fundamental decision rule.

---

## 5. The Market Booking Curve

Let:

$$
x = \phi_R(r).
$$

Then:

$$
\beta_{\text{market}}(r)
= \Pr(\phi_Q(q) \ge x)
= 1 - x
= 1 - \phi_R(r).
$$

### Interpretation

- If rate $r$ sits at quantile 0.3,  
  then 70% of requests sit above it → they book.  
- The market booking curve is a straight line.

---

## 6. Closures, the Nucleus, and Structural WTP

The feasibility relation induces closure operators:

### Upper closure

$$
F^\sharp(q)=\{ r : F(r,q)=\mathbf{true} \}.
$$

### Lower closure

$$
F_\flat(r)=\{ q : F(r,q)=\mathbf{true} \}.
$$

### The nucleus

$$
\mathrm{Nuc}(F)=\{(A,B): A=F^\sharp(B),\, B=F_\flat(A)\}.
$$

In total orders, each downward-closed set has a maximum, giving the **structural willingness-to-pay**:

$$
r^*(q)=\max F^\sharp(q)
      = \sup\{r : \phi_R(r) \le \phi_Q(q)\}.
$$

### Geometric meaning of WTP

In the $(\phi_R, \phi_Q)$ unit square:

- Each request is a **horizontal line** at height $\phi_Q(q)$.  
- Feasible rates are all rate quantiles **to the left** of that height.  
- The WTP is the point where the horizontal line meets the diagonal $x = y$.  
- Project that point down to the rate axis → that is $r^*(q)$.

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
|\{q' \in Q_{\text{carrier}} : m(j(q')) \le m(j(q))\}|
}{
|Q_{\text{carrier}}|
}.
$$

This expresses the carrier’s internal demand distribution on the same $[0,1]$ quantile axis.

---

## 8. Why We First Need the Carrier Booking Curve to Define SSR

The carrier-specific booking curve is:

$$
\beta_{\text{carrier}}(r)
=
\Pr(\text{booking at rate } r \mid q\in Q_{\text{carrier}}).
$$

Each carrier sees a **non-uniform slice** of the market →  
each has its **own** booking curve.

### SSR is chosen *from* this curve

Examples:

- volume-oriented carriers → choose large $\beta_{\text{carrier}}(r)$,  
- yield-oriented carriers → maximize $r \cdot \beta_{\text{carrier}}(r)$,  
- balanced strategies → choose quantile-based levels.

Thus:

> **To define SSR, we must first derive $\beta_{\text{carrier}}(r)$.**

---

## 9. Structural Derivation of the Carrier Booking Curve

Two structural paths:

- **Approach A:** via willingness-to-pay  
- **Approach B:** via pullback → curry → average  

Both produce the same $\beta_{\text{carrier}}(r)$.

---

## 9.1 Approach A — Via Carrier Willingness-to-Pay

The market WTP function is:

$$
r^*(q)=\max\{r : \phi_R(r) \le \phi_Q(q)\}.
$$

Restrict to the carrier:

$$
r^*_{\text{carrier}} = r^* \circ j.
$$

This yields each carrier customer's **maximum feasible rate**.

### Constructing the carrier booking curve

$$
\beta_{\text{carrier}}(r)
=
\frac{
|\{ q \in Q_{\text{carrier}} : r \le r^*_{\text{carrier}}(q) \}|
}{
|Q_{\text{carrier}}|
}.
$$

### Quantile expression

$$
\beta_{\text{carrier}}(r)=1-\phi_{\text{carrier}}(q_r),
\qquad
\phi_R(r)=\phi_Q(q_r).
$$

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
\beta_{\text{carrier}}(r)
=
\frac{1}{|Q_{\text{carrier}}|}
\sum_{q\in Q_{\text{carrier}}} \chi_r(q).
$$

### Why this matters

- Works directly with the feasibility relation  
- Natural for estimation  
- Equivalent to WTP approach in total orders

---

## 10. Estimation Regimes

Observed data:

$$
(r_i, q_i, y_i),\qquad y_i\in\{0,1\}.
$$

Two behavioral assumptions:

### Targeted (WTP-aligned) pricing

$r_i \approx r^*(q_i)$.

### Random-rate pricing

$$
y_i\sim \mathrm{Bernoulli}(F(r_i,q_i)).
$$

Each produces a different estimator $\widehat{\beta}_{\text{carrier}}(r)$.

---

## 11. Closing Thoughts

Under the total-order assumption:

- booking = comparing quantiles  
- WTP = maximum feasible rate  
- carrier demand = market subset  
- carrier booking curve = tail probability  
- **SSR = a chosen point on that curve**

This framework generalizes to multidimensional request spaces and non-total orders.

---
