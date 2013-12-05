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

local function displayHeader()
	local xPos = 2
	local yPos = 2
	local lastUpdatedString = "Last Updated: "
	
	monitor.setCursorPos(xPos, yPos)
	monitor.write("OTE-Gaming RSS Feed")
	monitor.setCursorPos(xPos, yPos + 1)
	monitor.write("Powered by Helkarakse")
	monitor.setCursorPos(xPos, yPos + 3)
	monitor.write(lastUpdatedString)
	monitor.setCursorPos(xPos + #lastUpdatedString, yPos + 3)
	monitor.write(parser.getPubDate())
end

local function displayItems()
	local xPos = 2
	local yPos = 5
	
	local items = parser.getItems()
	for key, value in pairs(items) do
		functions.debug(key, " ", value)
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
		
		displayHeader()
		displayItems()
	else
		functions.debug("No xml file. Terminating.")
		return
	end
end

init()