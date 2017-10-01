-module(draw).
-export([init/0, drawCard/1]).

init() ->
    {ok}.

drawCard(State = [ _, _, { turn, CurrentPlayer }, { player1, Field1 }, { player2, Field2 } ]) ->
    Field = if 
		CurrentPlayer == player1 ->
		    Field1;
		true ->
		    Field2
	    end,
    	
    {_,Deck0} = lists:keyfind(deck,1,Field),
    [Card|Deck] = Deck0,
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
			

