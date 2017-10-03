-module(clock).
-export([init/0, clockCard/1]).

init() ->
    {ok}.

selectCard(Mode,Field) ->
    Hand = lists:keyfind(hand, 1, Field),
    Clock = lists:keyfind(clock, 1, Field),
    SelectedCardId = Mode:promptForCard(Hand),
    {SelectedCard,Hand0} = utils:removeCard(SelectedCardId, Hand),

    Field1 = lists:keyreplace(hand, 1, Field, { hand, Hand0 }),
    Field2 = lists:keyreplace(clock, 1, Field1, { clock, [SelectedCard|Clock] }),
    {ok, Field2}.

clockCard(State) ->
    {_, Mode} = lists:keyfind(mode,1,State),
    { _, CurrentPlayer } = lists:keyfind(turn,1,State),
    Field = utils:selectField(State),

    % select card from hand
    { _, Field1 } = selectCard(Mode,Field),
    {ok, lists:keyreplace(CurrentPlayer,
			  1,
			  State,
			  {CurrentPlayer,
			   Field1})}.
			   
