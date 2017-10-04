-module(main_play).
-export([playcard/1]).


playcard(State) ->
    Field = utils:selectfield(State),
%    {_, CurrentPlayer } = lists:keyfind(turn,1,State),
    {_, Mode } = lists:keyfind(mode,1,Field),
    {_, Hand } = lists:keyfind(hand,1,Field),
    Card = Mode:promptforcard(Hand),
    {Id, { info, Info } } = Card,
    {_, Type } = lists:keyfind(type, 1, Info),
    
    if 
	Type == character ->
	    Stageposition = Mode:promptforstageposition(utils:getopenstagepositions(Field)),
	    utils:movecard(Id, Hand, Stageposition, State);
	Type == event ->
	    % apply card to Field
	    { _, Cardfun } = lists:keyfind(function, 1, Card),
	    Cardfun(State),
	
	    % move card to waiting room
	    utils:movecard(Id, Hand, waiting_room, State)
    end.
	   
