-module(draw).
-export([init/0, drawcard/1]).

init() ->
    {ok}.

% Takes the top card of the deck, adds it to hand
drawcard(State) ->
    {_,Mode} = lists:keyfind(mode,1,State),
    Field = utils:selectfield(State),
    {_, Deck} = lists:keyfind(deck,1,Field),
    {Id,_,_} = Mode:drawcard(Deck),
    { ok, utils:movecard(Id, deck, hand, State) }.
