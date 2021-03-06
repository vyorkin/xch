open Core_kernel

type t =
  { bids: Order.t list;
    asks: Order.t list;
  }

let create ~asks ~bids = { asks; bids }

let empty = create ~asks:[] ~bids:[]

let rec insert_order ~compare l o =
  match l with
  | [] -> o :: []
  | o' :: tl ->
     if compare o' o
     then o :: l
     else o' :: (insert_order ~compare tl o)

let place_ask order_book order =
  { order_book with
    asks = insert_order ~compare:Order.asc order_book.asks order
  }

let place_bid order_book order =
  { order_book with
    bids = insert_order ~compare:Order.desc order_book.bids order
  }

let place order_book (order: Order.t) =
  match order.direction with
  | Ask -> place_ask order_book order
  | Bid -> place_bid order_book order

let best_ask order_book =
  List.hd order_book.asks

let best_bid order_book =
  List.hd order_book.bids

let rec trade_acc order_book trades =
  match order_book.bids, order_book.asks with
  | [], _ -> (order_book, trades)
  | _, [] -> (order_book, trades)
  | bid :: bids, ask :: asks ->
      if Bignum.(bid.price >= ask.price)
      then
      begin
          let deal = Deal.create ~bid ~ask in
          match Deal.filled_orders deal with
          | (None, None) ->
              trade_acc order_book trades
          | (Some bid, None) ->
              let buy = Trade.buy (bid, deal) in
              trade_acc { bids; asks = deal.ask :: asks } (buy :: trades)
          | (None, Some ask) ->
              let sell = Trade.sell (ask, deal) in
              trade_acc { bids = deal.bid :: bids; asks } (sell :: trades)
          | (Some bid, Some ask) ->
              let sell = Trade.sell (ask, deal) in
              let buy = Trade.buy (bid, deal) in
              trade_acc { bids; asks } (sell :: buy :: trades)
      end
      else
      (order_book, trades)

let trade order_book = trade_acc order_book []
