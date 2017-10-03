-module(utils).
-export([createState/1,createState/2,removeCard/2,selectField/1]).

% utils modules
% card format { Id, [{ type, Type }, { color, Color }, { level, Level }, { cost, Cost  }, { trigger, Trigger  }, | Other ] }
% Type = character, climax, event


% Removes a card from a list of cards
removeCard(Id,ListOfCards) ->
    io:format("Removing ~s~n", [Id]),
    {value, SelectedCard, UpdatedList} = lists:keytake(Id, 1, ListOfCards),
    { SelectedCard, UpdatedList}.

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


% select the current field from the current turn
selectField([ _, _, { turn, CurrentPlayer }, { player1, Field1 }, { player2, Field2 } ]) ->
    if 
	CurrentPlayer == player1 ->
	    Field1;
	true ->
	    Field2
    end.
