--[[

	RSS Display Board Version 1.0 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131205

]]

-- Libs
os.loadAPI("functions")
os.loadAPI("xml")

-- Variables
local parser = xml.XL:new()
local remoteFile = "http://www.otegamers.com/index.php?app=core&module=global&section=rss&type=forums&id=24"
local xmlString

-- Functions
local function getXML()
	local data = http.get(remoteFile)
	if (data) then
    	functions.debug("XML file successfully retrieved.")
		xmlString = data.readAll()
		return true
	else
		functions.debug("Could not retrieve xml file.")
		return false
	end
end

local function init()
	local xmlSuccess = getXML()
	if (xmlSuccess) then
		parser:from_string(xmlString)
		local channel = parser:find(parser:root(), "channel")
		print(channel)
	end
end

init()