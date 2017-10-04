-module(clock).
-export([init/0, clockcard/1]).

init() ->
    {ok}.

selectcard(Mode,Field) ->
    { _, Hand } = lists:keyfind(hand, 1, Field),
    { _, Clock } = lists:keyfind(clock, 1, Field),
    Result = Mode:promptforcard(Hand),
    case Result of
	{SelectedCardId,_,_}  ->
	    {SelectedCard,Hand0} = utils:removeCard(SelectedCardId, Hand),
	    
	    Field1 = lists:keyreplace(hand, 1, Field, { hand, Hand0 }),
	    Field2 = lists:keyreplace(clock, 1, Field1, { clock, [SelectedCard|Clock] }),
	    {ok, Field2};
	error  ->
	    {error,selection}
    end.

clockcard(State) ->
    {_, Mode} = lists:keyfind(mode,1,State),
    { _, CurrentPlayer } = lists:keyfind(turn,1,State),
    Field = utils:selectfield(State),

    % select card from hand
    { Status, Field1 } = selectcard(Mode,Field),
    if 
	Status == ok->
	    {ok, lists:keyreplace(CurrentPlayer,
				  1,
				  State,
				  {CurrentPlayer,
				   Field1})};
	Status == error ->
	    {error,clockCard}
    end.
			   
