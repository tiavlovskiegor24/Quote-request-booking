## 1. Market Requests as a Total Order

We begin with the set of all market quote requests:

$$
Q_{\\text{market}} = \\{q_{(1)}, q_{(2)}, \\dots, q_{(N)}\\}.
$$

We assume that **these requests can be totally ordered**:

$$
q_{(1)} \\le q_{(2)} \\le \\dots \\le q_{(N)}.
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
