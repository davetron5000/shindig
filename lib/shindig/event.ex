defrecord Shindig.Event, name: nil, count: nil, timestamp: nil do
  record_type name: String.t, 
             count: non_neg_integer, 
         timestamp: { non_neg_integer, non_neg_integer, non_neg_integer }
  @moduledoc "An event - something that happened.  It has an arbitrary name, a count of how many times it happened or some other meaning, and a timestampe"
end
