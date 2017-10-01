-module(observer).
-export([drawCardImpl/1]).

% Module to implement observer mode callback functions when the game is in observer mode
% Observer mode is when the program is simply "observering" games as opposed to fully running them
% Observing implies the program has no visibility into what is in the deck or stock, but can see the hand
% The users must input the card that is drawn from the deck, for example

drawCardImpl(Deck) ->
    Result = io:fread("Input Card Id:", "~d"),
    [card_lookup:get(Result)|Deck].
