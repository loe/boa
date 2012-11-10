-module(boa_proxy_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/2]).

init(_Transport, Req, []) ->
  {ok, State} = cowboy_client:init([]),
  {ok, Req, State}.

handle(Req, State) ->
  %% Break apart the request.
  {ReqMethod, Req2} = cowboy_req:method(Req),
  {ReqHeaders, Req3} = cowboy_req:headers(Req2),
  {ReqURL, Req4} = cowboy_req:url(Req3),
  {ok, ReqBody, Req5} = cowboy_req:body(Req4),

  %% Issue proxy request.
  {ok, Client2} = cowboy_client:request(ReqMethod, ReqURL, ReqHeaders, ReqBody, State),
  {ok, ResStatus, ResHeaders, Client3} = cowboy_client:response(Client2),
  {ok, ResBody, _Client4} = cowboy_client:response_body(Client3),

  %% Reply to initial request.
  {ok, Res} = cowboy_req:reply(ResStatus, ResHeaders, ResBody, Req5),
  {ok, Res, State}.

terminate(_Req, _State) ->
  ok.
