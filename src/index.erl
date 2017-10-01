-module(index).
-export([init/2]).


drawPhase(State) ->
    {Status, NewState} = draw:drawCard(State),
    if 
	Status == ok ->
	    NewState;
	true ->
	    {error}
    end.
		      
loop(State = [{phase,Phase}]) ->
    case Phase of
	start ->
	    loop(drawPhase(State));
	finish ->
	    {ok,finish}
    end.

init(Mode, DeckModule) ->
    loop(utils:createState(Mode, DeckModule)).
