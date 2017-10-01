-module(utils).
-export([createState/1,createState/2]).

createSide([{module,DeckModule},{id,Id}]) ->
       [
	{ clock, [] },
	{ level, [] },
	{ deck, DeckModule:get(Id) },
	{ stock, [] },
	{ hand, [] },
	{ memory, [] },
	{ stage, [
		  { front, [] },
		  { back, [] }]}
       ].

createStateImpl(DeckSpec) ->
    [ { phase, start },
      { turn, player1 },
      { player1,
	createSide(DeckSpec) },
      { player2, 
	createSide(DeckSpec) }].

createState(observer, DeckSpec) ->
    [{mode,observer}|createStateImpl(DeckSpec)];
    
createState(auto, DeckSpec) ->
    [{mode,auto}|createStateImpl(DeckSpec)].

createState(DeckSpec) ->
    createState(auto,DeckSpec).
