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
