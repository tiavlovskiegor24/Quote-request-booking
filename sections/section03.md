## 3. Acceptance/Rejection as a Boolean Feasibility Relation
Because requests and rates share the same ordering, any quote request can be paired with any candidate market rate and classified: either the offered rate sits below that request’s clearing level and is accepted, or it exceeds it and is rejected.
Acceptance occurs when the offered rate does not exceed the clearing rate of the request. 

$$
r \le m(q).
$$

Formally, treat this as a feasibility relation: it is antitone in the rate (higher rates are harder to accept) and monotone in the request (less-sensitive customers accept more). Using the opposite order on rates makes the relation monotone in both arguments:

$$
F : R_{\text{market}}^{op} \times Q_{\text{market}}
\to \mathbf{Bool},
\qquad
F(r,q) = (r\le m(q)).
$$

This is the fundamental decision rule; rejection happens exactly when $F(r,q)$ is false. 

---
