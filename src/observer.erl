-module(observer).
-export([drawCardImpl/1]).

drawCardImpl(Deck) ->
    Result = io:fread("Input Card Id:", "~d"),
    [card_lookup:get(Result)|Deck].
