#require 'elasticsearch'
#client = Elasticsearch::Client.new( url: "http://elastic:jarvis123@localhost:9200")
def register(params)
        @intStatus = params["OperStat"]
        @intName = params["name"]
        @intIn = params["octIn"]
        @intOut = params["octOut"]
	@hostInt = params["host"]
	@intSp = params["speed"]
	@intAlias = params["alias"]
end

def filter(event)
	require 'elasticsearch'
        status = event.get(@intStatus)
        name = event.get(@intName)
        iin = event.get(@intIn)
        out = event.get(@intOut)
	speed = event.get(@intSp)
	hostname = event.get(@hostInt)
	desc = event.get(@intAlias)
	tags = event.get("tags")
	tags[3] = "interface"
	time = event.get("@timestamp")
	ep_timestamp = event.get('@timestamp').to_i
	index = "snmp-#{tags[0]}"
        
	#client = Elasticsearch::Client.new
	client = Elasticsearch::Client.new( url: "http://elastic:jarvis123@localhost:9200")

#	interfaceAll = {}
        
	status.each_with_index do |i, x|
		interface = {}
                        if i["ifOperStatus"] == 1
				interface.store("hostname",hostname)
				interface.store("tags",tags)
				interface.store("@timestamp",time)
                                interface.store("epoc_timestamp",ep_timestamp)
				interface.store("nameInt",name[x]["ifName"])
				interface.store("statusInt",status[x]["ifOperStatus"])
				interface.store("inInt",iin[x]["ifHCInOctets"])
				interface.store("outInt",out[x]["ifHCOutOctets"])
				interface.store("speedInt",speed[x]["ifSpeed"])
				interface.store("descInt",desc[x]["ifAlias"])
				client.index(index: index, body: interface)
                        end
        end
        return [event]
end
