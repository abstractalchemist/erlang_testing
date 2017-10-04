-module(clock_test).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    State0 = utils:createstate([{module,hard_coded_deck},{id,0}]),
    {_, NewState } = clock:clockcard(State0),
    Field = utils:selectfield(NewState),
    {_, Clock } = lists:keyfind(clock,1,Field),
    {_, Hand } = lists:keyfind(hand,1,Field).
