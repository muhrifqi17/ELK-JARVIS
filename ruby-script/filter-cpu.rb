def register(params)
        @indexCpu = params["index"]
        @nameCpu = params["name"]
        @availCpu = params["avail"]
end

def filter(event)
        require 'elasticsearch'
        index = event.get(@indexCpu)
        naaame = event.get(@nameCpu)
        avail = event.get(@availCpu)
	hostname = event.get("hostname")
        tags = event.get("tags")
        tags[3] = "cpu"
        time = event.get("@timestamp")
        indeex = "snmp-#{tags[0]}"

        client = Elasticsearch::Client.new( url: "http://elastic:jarvis123@localhost:9200")

        interfaceAll = {}

        index.each_with_index do |i, x|
                i = i.merge(avail[x])
		nameHardware = cekHardware(naaame, i["cpmCPUTotalPhysicalIndex"])
		i.delete("cpmCPUTotalPhysicalIndex")
		i[:availCpu] = i.delete("cpmCPUTotal5min")
                i.store("nameCpu",nameHardware)
		i.store("hostname",hostname)
                i.store("tags",tags)
                i.store("@timestamp",time)
#		event.set("tes",i)
		
                client.index(index: indeex, body: i)
        end
        return [event]
end

def cekHardware(name, physicalIndex)
	name.each_with_index do |i, x|
		if i["index"].to_i == physicalIndex
			return i["entPhysicalName"]
		end
	end
end

