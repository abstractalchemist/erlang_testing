-module(main_play).
-export([playcard/1]).


playcard(State) ->
    Field = utils:selectfield(State),
    
    {_, Mode } = lists:keyfind(mode,1,Field),
    {_, Hand } = lists:keyfind(hand,1,Field),

    {Id, { info, Info } } = Mode:promptforcard(Hand),
    {_, Type } = lists:keyfind(type, 1, Info),
    
    if 
	Type == character ->
	    Stageposition = Mode:promptforstageposition(utils:getopenstagepositions(Field)),
	    utils:movecard(Id, Hand, Stageposition, State)
    end.
	   
