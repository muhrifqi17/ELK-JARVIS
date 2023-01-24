def register(params)
        @memName = params["name"]
        @memFree = params["free"]
	@memUse = params["use"]
end

def filter(event)
        require 'elasticsearch'
        nameMem = event.get(@memName)
        freeMem = event.get(@memFree)
        useMem = event.get(@memUse)
	hostname = event.get("hostname")
        tags = event.get("tags")
        tags[3] = "memmory"
        time = event.get("@timestamp")
        indeex = "snmp-#{tags[0]}"

        client = Elasticsearch::Client.new( url: "http://elastic:jarvis123@localhost:9200")

#        interfaceAll = {}

        nameMem.each_with_index do |i, x|
		data = {}
		data.store("nameMem",nameMem[x]["ciscoMemoryPoolName"])
                data.store("freeMem",freeMem[x]["ciscoMemoryPoolFree"])
		data.store("useMem",useMem[x]["ciscoMemoryPoolUsed"])

		totalMem = freeMem[x]["ciscoMemoryPoolFree"] + useMem[x]["ciscoMemoryPoolUsed"]
		avaMem = useMem[x]["ciscoMemoryPoolUsed"].to_f / totalMem.to_f
		data.store("totalMem", totalMem)
		data.store("avaMem",avaMem)

		data.store("hostname",hostname)
                data.store("tags",tags)
                data.store("@timestamp",time)
#		event.set("tes",data)
		
                client.index(index: indeex, body: data)
        end
        return [event]
end

