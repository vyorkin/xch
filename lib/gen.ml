module RS = Random.State

module Syntax = struct
  open QCheck.Gen

  let (let*) = (>>=)
end

module Char = struct
  let alpha st = Char.(chr (code 'a' + RS.int st (code 'z' - code 'a')))
end
