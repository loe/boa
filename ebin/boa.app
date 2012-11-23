{application,boa,
             [{description,"API Constrictor"},
              {vsn,"1"},
              {registered,[]},
              {modules,[boa,boa_app,boa_proxy_handler,boa_sup]},
              {applications,[kernel,stdlib,cowboy,lager]},
              {mod,{boa_app,[]}},
              {env,[]}]}.
