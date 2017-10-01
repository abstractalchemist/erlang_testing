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
    [{ player1,
       createSide(auto) },
     { player2, 
       createSide(auto) }];
createState(observer) ->
    [{ player1,
       createSide(observer) },
     { player2,
       createSide(observer) } ].

init() ->
    io:format("~s~n", ["Hello"]).
