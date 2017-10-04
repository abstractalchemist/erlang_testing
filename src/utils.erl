-module(utils).
-export([createstate/1,createstate/2,removecard/2,selectfield/1,checkvalidfieldsymbol/1,movecard/4,getopenstagepositions/1]).

% utils modules
% card format { Id, {info, [{ type, Type }, { color, Color }, { level, Level }, { cost, Cost  }, { trigger, Trigger  }, | Other ] }, {active, []}}
% Type = character, climax, event

checkvalidfieldsymbol(hand)->
    {ok};
checkvalidfieldsymbol(clock) ->
    {ok};
checkvalidfieldsymbol(stage_front_left) ->
    {ok};
checkvalidfieldsymbol(stage_front_center) ->
    {ok};
checkvalidfieldsymbol(stage_front_right) ->
    {ok};
checkvalidfieldsymbol(stage_back_left) ->
    {ok};
checkvalidfieldsymbol(stage_back_right) ->
    {ok};
checkvalidfieldsymbol(level) ->
    {ok};
checkvalidfieldsymbol(memory) ->
    {ok};
checkvalidfieldsymbol(stock) ->
    {ok};
checkvalidfieldsymbol(deck) ->
    {ok};
checkvalidfieldsymbol(_) ->
    {error, invalid_location}.

isemptyposition(Position, Field) ->
    {_, PositionSlot} = lists:keyfind(Position,1,Field),
    length(PositionSlot) == 0.

% returns a list of atoms in all open stage positions
getopenstagepositions(Field) ->
    lists:map(fun ( {Position, _} ) ->
		      Position
	      end,
	      lists:filter( fun ( {Position,_} ) ->
				    case Position of
					stage_front_left ->
					    isemptyposition(stage_front_left, Field);
					stage_front_center  ->
					    isemptyposition(stage_front_center, Field);
					stage_front_right ->
					    isemptyposition(stage_front_right, Field);
					stage_back_left ->
					    isemptyposition(stage_back_left, Field);
					stage_back_right ->
					    isemptyposition(stage_back_right, Field);
					_ ->
					    false
				    end
			    end,
			    Field)).
				    

% move a card from one place on the selected players turn;  updates the state; the id identified in the card must be in the source
movecard(CardId, Source, Destination, State)->
    {_, CurrentPlayer} = lists:keyfind(turn,1,State),
    movecard(CardId, CurrentPlayer, Source, Destination, State).

movecard(CardId, Player, Source, Destination, State)->
    checkvalidfieldsymbol(Source),
    checkvalidfieldsymbol(Destination),

    {_, Field} = lists:keyfind(Player,1,State),
    { _, SourceLocation } = lists:keyfind(Source,1,Field),
    { _, DestinationLocation } = lists:keyfind(Destination, 1, Field),

    % takes a card from the source
    { value, SelectedCard, SourceLocation0 } =  lists:keytake(CardId, 1, SourceLocation),
    DestinationLocation0 = [SelectedCard|DestinationLocation],
    Field0 = lists:keyreplace(Source,1,Field, { Source, SourceLocation0 }),
    Field1 = lists:keyreplace(Destination,1,Field0, { Destination, DestinationLocation0 }),
    lists:keyreplace(Player,1,State,{Player,Field1}).

% Removes a card from a list of cards
removecard(Id,ListOfCards) ->
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
	{ stage_front_left, [] },
	{ stage_front_center, [] },
	{ stage_front_right, [] },
	{ stage_back_left, [] },
	{ stage_back_right, [] }
       ].

% Creates the playing field
% phase - current phase in the game
% turn - whose turn, it's either player1 or player2
% { player1, Field } is the tuple containing player1 field
% { player2, Field } is the tuple containing player2 field
createstateImpl(DeckSpec) ->
    [ { phase, start },
      { turn, player1 },
      { player1,
	createSide(DeckSpec) },
      { player2, 
	createSide(DeckSpec) }].

% Adds the program mode, either observer or auto
% mode corresponds to the specified module callback, either observer, or auto
createstate(observer, DeckSpec) ->
    [{mode,observer}|createstateImpl(DeckSpec)];
    
createstate(auto, DeckSpec) ->
    [{mode,auto}|createstateImpl(DeckSpec)].


% Creates a default program, where auto is the default
createstate(DeckSpec) ->
    createstate(auto,DeckSpec).


% select the current field from the current turn
selectfield([ _, _, { turn, CurrentPlayer }, { player1, Field1 }, { player2, Field2 } ]) ->
    if 
	CurrentPlayer == player1 ->
	    Field1;
	true ->
	    Field2
    end.
