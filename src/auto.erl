-module(auto).
-export([drawcard/1,promptforcard/1]).

% Module to implement auto mode callback functions when the game is in auto mode.
% Auto mode is when the program is in full control of the game, which implies it has full visibility of the game.
% The program knows where every card is, and is keeping track of where every card is, including deck and stock

% removes the top card from the deck ( does not actually alter the input deck )
drawcard(Deck)->
    [SelectedCard|_] = Deck,
    SelectedCard.

promptforcard(Hand) ->
    %io:format("Removing from < ~s >~n",[Hand]),
    ReadResult = io:fread("Select A Card From Hand " ++ io_lib:format("~s~n", [lists:map(fun (obj) ->
												 lists:element(1,obj)
											 end,
											 Hand)]), "~d"),
    case ReadResult of 
	{ok,Result} ->
	    lists:keyfind(Result,1,Hand);
	{error,_} ->
	    error
    end.


