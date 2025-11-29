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
