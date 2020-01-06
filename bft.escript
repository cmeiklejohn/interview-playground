#!/usr/bin/env escript

main(_) ->
    %% Vertices.
    Vertices = [a, b, c, d, e],

    %% Build edges.
    Edges = [
        {a, c},
        {a, b},
        {c, d},
        {d, e}
    ],

    %% Create the graph -- directed graph.
    Graph = {Vertices, Edges},

    %% Perform the breadth first traversal.
    bft(Graph, [{a, 1}], 1),

    ok.

bft({_, Edges} = Graph, [{Node, Level}|Rest], CurrentLevel0) ->
    CurrentLevel = case Level of 
        CurrentLevel0 ->
            CurrentLevel0;
        _ ->
            io:format("~n", []),
            CurrentLevel0 + 1
    end,

    io:format("~p ", [Node]),

    Rest2 = lists:foldl(fun({From, To}, Rest1) ->
        case From of 
            Node ->
                Rest1 ++ [{To, CurrentLevel + 1}];
            _ ->
                Rest1
        end
    end, Rest, Edges),

    bft(Graph, Rest2, CurrentLevel);
bft(_, [], _) ->
    io:format("~n", []),
    ok.