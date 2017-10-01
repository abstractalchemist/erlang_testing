-module(auto).
-export([drawCardImpl/1]).

% Module to implement auto mode callback functions when the game is in auto mode.
% Auto mode is when the program is in full control of the game, which implies it has full visibility of the game.
% The program knows where every card is, and is keeping track of where every card is, including deck and stock

drawCardImpl(Deck) ->
    Deck.
