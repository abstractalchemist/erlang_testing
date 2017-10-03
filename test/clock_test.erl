-module(clock_test).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    State0 = utils:createState([{module,hard_coded_deck},{id,0}]),
    {_, NewState } = clock:clockCard(State0),
    Field = utils:selectField(NewState),
    {_, Clock } = lists:keyfind(clock,1,Field),
    {_, Hand } = lists:keyfind(hand,1,Field).
