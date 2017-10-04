-module(main_play).
-export([playcard/1]).


playcard(State) ->
    Field = utils:selectfield(State),
    {_, CurrentPlayer } = lists:keyfind(turn,1,State),
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
	    Field0 = lists:map(fun({ Position, Slot }) ->
				       case Position of
					   stage_front_left ->
					       { Position, Cardfun(Slot) };
					   stage_front_center ->
					       { Position, Cardfun(Slot) };
					   stage_front_right ->
					       { Position, Cardfun(Slot) };
					   stage_back_left ->
					       { Position, Cardfun(Slot) };
					   stage_back_right ->
					       { Position, Cardfun(Slot) };
					   clock ->
					       { Position, Cardfun(Slot) };
					   waiting_room ->
					       { Position, Cardfun(Slot) };
					   deck ->
					       { Position, Cardfun(Slot) };
					   hand ->
					       { Position, Cardfun(Slot) };
					   level ->
					       { Position, Cardfun(Slot) }
					   end
			       end,
			       Field),
	    State0 = lists:keyreplace(CurrentPlayer,1,Field0),
	    
		      

	    % move card to waiting room
	    utils:movecard(Id, Hand, waiting_room, State0)
    end.
	   
