-module(shuffle_test).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    State = utils:createstate([{module,hard_coded_deck},{id,0}]),
    shuffle:it(State).
