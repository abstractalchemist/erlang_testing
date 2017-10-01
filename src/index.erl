-module(index).
-export([init/0,createState/1]).

createSide(auto) ->
       [
	{ clock, [] },
	{ level, [] },
	{ deck, [] },
	{ stock, [] },
	{ hand, [] },
	{ memory, [] },
	{ stage, [
		  { front, [] },
		  { back, [] }]}
       ]; 
createSide(observer) ->
   [
    { clock, [] },
    { level, [] },
    { hand, [] },
    { memory, [] },
    { stage, [
	      { front, [] },
	      { back, [] } ] },
    { other, [] }
   ].

createState(auto) ->
    [ { phase, start },
      { turn, player1 },
      { player1,
	createSide(auto) },
      { player2, 
	createSide(auto) }];
createState(observer) ->
    [ { phase, start },
      { player1,
	createSide(observer) },
      { player2,
	createSide(observer) } ].

alterState(State, Alter) ->
    lists:map(Alter,
	      State).

drawPhase(State = [ Phase, { turn, CurrentPlayer }, { player1, Field1 }, { player2, Field2 } ]) ->
    DrawCard = fun ({Key, Value}) ->
		       case Key of
			   deck ->
			       [DrawnCard | Deck ] = Value,
			       { DrawnCard, {deck, Deck} };
			   _ ->
			       {_, {Key, Value} }
		       end
	       end,
    FindPlayer = fun({Key, Value}) ->
			 case Key of 
			     CurrentPlayer ->
				 { Context, NewState } = alterState(Value, DrawCard),
				 { Context, {Key, NewState} };
			     _ -> 
				 {_, {Key, Value} }
			 end
		 end,
    alterHand(State, FindPlayer).
		       
					    
		      

loop(State = [{phase,Phase}, { player1, Field1 }, { player2, Field2 } ]) ->
    case Phase of
	start ->
	    loop(drawPhase(State));
	finish ->
	    {ok,finish}
    end.

init() ->
    loop(createState(observer)).
