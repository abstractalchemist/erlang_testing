-module(draw).
-export([init/0, drawCard/1]).

init() ->
    {ok}.

% Takes the top card of the deck, adds it to hand
drawCard(State) ->
    {_,Mode} = lists:keyfind(mode,1,State),
    {_, CurrentPlayer} = lists:keyfind(turn,1,State),
    Field = utils:selectField(State),
    {_,Deck0} = lists:keyfind(deck,1,Field),
    [Card|Deck] = Mode:drawCardImpl(Deck0),
    {_, Hand} = lists:keyfind(hand,1,Field),
    {ok, lists:keyreplace(CurrentPlayer, 
		     1, 
		     State, 
			  {CurrentPlayer,
			   lists:keyreplace(deck, 
					    1, 
					    lists:keyreplace(hand,
							     1,
							     Field,
							     {hand, [Card|Hand]}),
					    {deck, Deck})})}.
			

