--[[

	RSS Display Board Version 1.0 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131205

]]

-- Libs
os.loadAPI("functions")
os.loadAPI("parser")

-- Variables
local remoteFile = "http://www.otegamers.com/index.php?app=core&module=global&section=rss&type=forums&id=24"

-- Functions
local function getXML()
	local xmlString
	local data = http.get(remoteFile)
	if (data) then
    	functions.debug("XML file successfully retrieved.")
		xmlString = data.readAll()
		parser.parseData(xmlString)
		return true
	else
		functions.debug("Could not retrieve xml file.")
		return false
	end
end

local function init()
	local xmlSuccess = getXML()
	if (xmlSuccess) then
		-- find the monitor and init vars
		local monFound, monDir = functions.locatePeripheral("monitor");
		if (monFound == true) then
			monitor = peripheral.wrap(monDir)
			local screenW, screenH = monitor.getSize()
			functions.debug("Monitor size is: ", screenW, "x", screenH)
		else
			-- no monitor found
			functions.debug("A monitor is required to use this program.")
			return
		end
		
		functions.debug(parser.getTitle())
		functions.debug(parser.getLink())
		functions.debug(parser.getPubDate())
		functions.debug(#parser.getItems())
	else
		functions.debug("No xml file. Terminating.")
		return
	end
end

init()