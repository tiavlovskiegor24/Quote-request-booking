## 9.1 Approach A — Via Carrier Willingness-to-Pay

The market WTP function in quantile space is simply:

$$
\\hat r(q)=q.
$$

Restrict to the carrier:

$$
\\hat r_{\\text{carrier}}(q) = \\hat r(j(q)) = \\text{market quantile of } j(q).
$$

This yields each carrier customer's **maximum feasible rate**; to recover the physical rate, apply $\\phi_R^{-1}(\\hat r_{\\text{carrier}}(q))$.

### Constructing the carrier rejection curve

$$
\\rho_{\\text{carrier}}(r)
=
\\frac{
|\\{ q \\in Q_{\\text{carrier}} : r > \\hat r_{\\text{carrier}}(q) \\}|
}{
|Q_{\\text{carrier}}|
}.
$$

### Quantile expression

$$
\\rho_{\\text{carrier}}(r)=\\phi_{\\text{carrier}}(q_r),
$$

where $q_r$ is the market request at quantile $r$ (equivalently, the point on the diagonal with request quantile $q=r$).

---
