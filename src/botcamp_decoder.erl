-module(botcamp_decoder).
-compile(export_all).

-define(bc_byte(X), X:8/big-signed-integer).

%% Action defines
-define(MOVE, 1).
-define(ATTACK, 2).
-define(SPELL, 3).



decode_actions(<<Action:8/big-signed-integer, Rest/binary>>) ->
    case Action of
        ?MOVE ->
            <<?bc_byte(X), ?bc_byte(Y)>> = Rest,
            {move, X, Y};
        ?ATTACK ->
            <<?bc_byte(WeaponType), ?bc_byte(X), ?bc_byte(Y)>> = Rest,
            {attack, WeaponType, X, Y};
        ?SPELL ->
            <<?bc_byte(SpellType), ?bc_byte(X), ?bc_byte(Y)>> = Rest,
            {spell, SpellType, X, Y};
        _ ->
            throw(faulty_move)
    end.

encode_response() ->
    ok.
