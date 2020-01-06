#!/usr/bin/env escript

main(_) ->
    case is_overlapping(Rect1, Rect2) of
        true ->
            overlapping_area(Rect1, Rect2); 
        false ->
            io:format("not overlapping, area: ~p~n", [0])
    end,

    ok.

is_overlapping({{Rect1LowerLeftX, Rect1LowerLeftY}, {Rect1UpperRightX, Rect1UpperRightY}}, 
               {{Rect2LowerLeftX, Rect2LowerLeftY}, {Rect2UpperRightX, Rect2UpperRightY}}) ->
                    not(Rect1LowerLeftX > Rect2UpperRightX orelse
                        Rect1LowerLeftY > Rect2UpperRightY orelse
                        Rect1UpperRightX < Rect2LowerLeftX orelse 
                        Rect1UpperRightY < Rect2LowerLeftY).
                  


overlapping_area({BottomLeft1, UpperRight1}, {BottomLeft2, UpperRight2}) ->
    BottomLeft = glb(BottomLeft1, BottomLeft2),
    UpperRight = lub(UpperRight1, UpperRight2),
    io:format("overlapping rectangle: ~p ~p~n", [BottomLeft, UpperRight]),
    Area = area(BottomLeft, UpperRight),
    io:format("area: ~p~n", [Area]),
    ok.

glb({X1, Y1}, {X2, Y2}) ->
    {max(X1, X2), max(Y1, Y2)}.

lub({X1, Y1}, {X2, Y2}) ->
    {min(X1, X2), min(Y1, Y2)}.

area({X1, Y1}, {X2, Y2}) ->
    X = X2 - X1,
    Y = Y2 - Y1,
    X * Y.