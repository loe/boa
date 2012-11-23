-module(boa).

%% API.
-export([start/0]).

%% API.

start() ->
  ok = lager:start(),
  ok = application:start(crypto),
  ok = application:start(ranch),
  ok = application:start(cowboy),
  ok = application:start(boa).
