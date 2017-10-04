-module(shuffle).
-export([it/1,it/2]).

% Module to implement a card shuffle

removecard([C]) ->
    {C, []};
removecard(Src) ->
    Nth = rand:uniform(length(Src)),
    { S0, S1 } = lists:split(Nth, Src),
    if
	length(S1) == 0 ->
	    [C | S2] = S0,
	    { C, S2 };
	true ->
	    [ C | S2 ] = S1,
	    { C, S0 ++ S2 }
    end.

shuffleimpl([], Dst) ->
    Dst;
shuffleimpl(Src, Dst) ->
    { C, Src0 } = removecard(Src),
    shuffleimpl(Src0, [C | Dst]).


it(State) ->
    { _, CurrentPlayer } = lists:keyfind(turn, 1, State),
    it(CurrentPlayer, State).

it(Player, State) ->
    { _, Field } = lists:keyfind(Player, 1, State),
    { _, Deck } = lists:keyfind(deck, 1, Field),
    Deck1 = shuffleimpl(Deck, []),
    Field0 = lists:keyreplace(deck, 1, Field, { deck, Deck1 }),
    lists:keyreplace(Player, 1, State, { Player, Field0 }).
