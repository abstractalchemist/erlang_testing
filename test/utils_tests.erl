-module(utils_tests).
-include_lib("eunit/include/eunit.hrl").

basic_test() ->
    utils:createstate([{module,hard_coded_deck},{id,0}]).
