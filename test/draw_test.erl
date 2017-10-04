-module(draw_test).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    State0 = utils:createstate([{module,hard_coded_deck},{id,0}]),
    {Status, State} = draw:drawcard(State0),
    {_ , Field} = lists:keyfind(player1,1,State),
    {_, Deck} = lists:keyfind(deck,1,Field),
    {_ ,Hand} = lists:keyfind(hand,1,Field),
    Status = ok,
    1 = length(Hand),
    2 = length(Deck).
    
