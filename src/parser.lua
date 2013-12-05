--[[

	RSS Data Parser Version 1.0 Dev
	Do not modify, copy or distribute without permission of author
	Helkarakse, 20131128
]]

-- Libraries
os.loadAPI("xml")
os.loadAPI("functions")

-- Vars
local tagChannel
local parser = xml.XL:new()

-- Main Functions
-- Parses the xml string and outputs the table data
function parseData(xmlString)
	parser:from_string(xmlString)
	tagChannel = parser:find(parser:root(), "channel")
end