%% Feel free to use, reuse and abuse the code in this file.

%% @doc GET echo handler.
-module(boa_proxy_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/2]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {ok, Client} = cowboy_client:init([]),
  {ok, Client2} = cowboy_client:request(<<"GET">>, <<"http://en.wikipedia.org/wiki/Main_Page">>, [], <<>>, Client),
  {ok, Status, Headers, Client3} = cowboy_client:response(Client2),
  {ok, Body, _} = cowboy_client:response_body(Client3),
  {ok, Req2} = cowboy_req:reply(Status, Headers, Body, Req),
  {ok, Req2, State}.

terminate(_Req, _State) ->
  ok.
