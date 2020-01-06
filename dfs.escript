#!/usr/bin/env escript

main(_) ->
    %% Vertices.
    Vertices = [a, b, c, d, e],

    %% Build edges.
    Edges = [
        {a, c},
        {b, c},
        {e, d}
    ],

    %% Create the graph -- undirected graph.
    Graph = {Vertices, Edges},

    %% Perform the depth first search.
    dfs(Graph),

    ok.

dfs({Vertices, Edges}) ->
    %% Iterate all of the edges.
    lists:foldl(fun(Vertex, Visited) ->
        io:format("Vertex: ~p~n", [Vertex]),
        dfs_(Vertex, Edges, Visited)
    end, [], Vertices),

    ok.

dfs_(Vertex, Edges, Visited) ->
    case lists:member(Vertex, Visited) of 
        false ->
            io:format("-> Visiting vertex: ~p~n", [Vertex]),

            lists:foldl(fun({From, To}, Visited1) ->
                %% From -> To
                Visited2 = case From of 
                    Vertex ->
                        dfs_(To, Edges, Visited1);
                    _ ->
                        Visited1
                end,

                %% To -> From
                case To of 
                    Vertex ->
                        dfs_(From, Edges, Visited2);
                    _ ->
                        Visited2
                end
            end, Visited ++ [Vertex], Edges);
        true ->
            Visited
    end.