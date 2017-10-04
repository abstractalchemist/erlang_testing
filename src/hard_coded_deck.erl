-module(hard_coded_deck).
-export([get/1]).

% Implements a lookup module which gets the hard coded decks from source

% get the deck based the input id
get(_) ->
    [{ 0, { info, [] }, { active, [] } },
     { 1, { info, [] }, { active, [] } },
     { 2, { info, [] }, { active, [] } }].
