open Core_kernel

type t =
  { order_book: Order_book.t;
    last_trade_price: Bignum.t;
    last_price_change: float;
    orders: (int, Order.t list) Hashtbl.t;
  }

let create ?(order_book = Order_book.empty) () =
  { order_book;
    last_trade_price = Bignum.zero;
    last_price_change = 0.0;
    orders = Hashtbl.create (module Int) ~size:10;
  }

let trade xch =
  let (order_book, trades) = Order_book.trade xch.order_book in
  let last_trade = List.hd trades in
  let last_trade_price =
    match last_trade with
    | Some trade -> (Trade.unwrap trade).price
    | None -> xch.last_trade_price
  in
  let last_price_change = Bignum.(to_float xch.last_trade_price /. to_float last_trade_price) -. 1.0 in
  let xch' =
    { xch with
      last_trade_price;
      last_price_change;
      order_book
    }
  in (xch', trades)
