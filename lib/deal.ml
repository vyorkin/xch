type t =
  { bid: Order.t;
    ask: Order.t;
    qty: int;
    price: Bignum.t;
  }

let create ~bid ~ask =
  let price = Order.trade_price ~bid ~ask in
  let qty = min bid.qty ask.qty in
  let partial = Order.Partial.create ~qty ~price in
  let bid' =
    { bid with
      qty = bid.qty - qty;
      partials = partial :: bid.partials;
    } in
  let ask' =
    { ask with
      qty = ask.qty - qty;
      partials = partial :: ask.partials;
    } in
  { bid = bid';
    ask = ask';
    price;
    qty;
  }

let filled deal =
  (Order.filled deal.bid, Order.filled deal.ask)
