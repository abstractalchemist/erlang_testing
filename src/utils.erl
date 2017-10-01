-module(utils).
-export([createState/1,createState/2]).

% utils modules
% 

% Creates the player stage.  DeckModule is a callback module to find the playing deck, Id is the id of the deck to retrieve
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

% Creates the playing field
% phase - current phase in the game
% turn - whose turn, it's either player1 or player2
% { player1, Field } is the tuple containing player1 field
% { player2, Field } is the tuple containing player2 field
createStateImpl(DeckSpec) ->
    [ { phase, start },
      { turn, player1 },
      { player1,
	createSide(DeckSpec) },
      { player2, 
	createSide(DeckSpec) }].

% Adds the program mode, either observer or auto
% mode corresponds to the specified module callback, either observer, or auto
createState(observer, DeckSpec) ->
    [{mode,observer}|createStateImpl(DeckSpec)];
    
createState(auto, DeckSpec) ->
    [{mode,auto}|createStateImpl(DeckSpec)].


% Creates a default program, where auto is the default
createState(DeckSpec) ->
    createState(auto,DeckSpec).
