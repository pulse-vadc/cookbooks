stingray_pool "#{node["stingray"]["path"]}/zxtm/conf/pools/#{node["stingray"]["pool"]["name"]}" do

   nodes       node["stingray"]["pool"]["nodes"]
   draining    node["stingray"]["pool"]["draining"]
   disabled    node["stingray"]["pool"]["disabled"]
   monitors    node["stingray"]["pool"]["monitors"]
   persistence node["stingray"]["pool"]["persistence"]
   weightings  node["stingray"]["pool"]["weightings"]
   algorithm   node["stingray"]["pool"]["algorithm"]
   priority    node["stingray"]["pool"]["priority"]

   action :configure

end
