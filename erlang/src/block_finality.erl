%Blocks only get appended to this once we are sure that block will be part of the blockchain.
%gives O(1) lookup time for blocks. Adding more blocks doesn't slow it down.
%this is made up of 2 files. the block_pointers.db file uses 8 bytes for each block. The 8 bytes encodes the position and size of the block in blocks.db file.
-module(block_finality).
-behaviour(gen_server).
-export([start_link/0,code_change/3,handle_call/3,handle_cast/2,handle_info/2,init/1,terminate/2, read/1,append/1,top/0,test/0]).
-define(word, 8).
init(ok) -> {ok, []}.
start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, ok, []).
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_, _) -> io:format("died!"), ok.
handle_info(_, X) -> {noreply, X}.
handle_call(_, _From, X) -> {reply, 0, X}.
handle_cast({append, X}, D) -> 
    {A, B} = block_dump:write(X),
    N = <<A:38, B:26>>,%2**26 ~60 mb is how long blocks can be, 2**38 ~250 GB is how big the blockchain can be. 38+26=64 bits is 8 bytes, so I defined word as 8.
    block_pointers:append(N, ?word),
    {noreply, D}.
append(Block) -> gen_server:cast(?MODULE, {append, packer:pack(Block)}).
top() -> block_pointers:height(?word).
read(N) -> 
    C = top(),
    true = N < C,
    <<A:38, B:26>> = block_pointers:get(N, 1, ?word),
    X = block_dump:read(A, B),
    packer:unpack(X).
test() ->
    append([25]),
    timer:sleep(5),
    read(top() - 1).
%read(0).
