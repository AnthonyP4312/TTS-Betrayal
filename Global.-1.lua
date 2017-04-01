--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]
--[[Written for Tabletop Simulator v6.9]]--
--[[Author: Tanners // http://steamcommunity.com/id/TOSHINOUKYOUKO/ ]]--
--[[Workshop URL: http://steamcommunity.com/sharedfiles/filedetails/?id=651014044 ]]--

lastOmen = ""
lastOmenNum = 0
lockme = {}
deadObjects = {}
TurnColor = ""
lastTurnColor = ""
TurnOrder = {}


--Tablet GUIDs--
heroTabletGUID = "93d26e"
traitorTabletGUID = "a7c7d0"

--Other GUIDs
omenGUID = "abceb4"  --Deck of omen Cards

----Haunt Tables----
haunts = {
	Abandoned_Room = {17, 7, 12, 38, 1, 9, 45, 42, 49, 28, 50, 31, 48},
	Balcony = {24, 7, 32, 5, 16, 6, 11, 25, 49, 20, 47, 39, 2},
	Catacombs = {4, 7, 23, 46, 1, 13, 10, 25, 49, 41, 37, 19, 48},
	Charred_Room = {24, 18, 23, 38, 30, 13, 34, 48, 44, 20, 47, 15, 8},
	Dining_Room = {24, 3, 27, 5, 16, 6, 45, 42, 21, 20, 37, 39, 40},
	Furnace_Room = {4, 18, 32, 38, 30, 13, 10, 42, 36, 28, 50, 15, 2},
	Gallery = {17, 3, 12, 38, 33, 22, 10, 25, 36, 41 ,37, 15, 8},
	Gymnasium = {35, 29, 12, 46, 33, 22, 11, 22, 21, 41, 47, 19, 48},
	Junk_Room = {4, 18, 27, 46, 1, 9, 11, 25, 44, 28, 50, 31, 40},
	Kitchen = {17, 3, 23, 46, 33, 22, 34, 32, 36, 41, 37, 39, 2},
	Master_Bedroom = {35, 29, 27, 5, 16, 6, 10, 35, 44, 20, 47, 19, 2},
	Pentagram_Chamber = {26, 43, 32, 43, 26, 26, 45, 14, 14, 26, 14, 43, 40},
	Servants_Quarters = {35, 29, 12, 5, 30, 9, 34, 42, 21, 28, 50, 31, 8}
}

haunts50 = {
	Abandoned_Room = {17, 7, 12, 38, 1, 9, 45, 42, 49, 28, 50, 31, 48},
	Balcony = {24, 7, 32, 5, 16, 6, 11, 25, 49, 20, 47, 39, 2},
	Catacombs = {4, 7, 23, 46, 1, 13, 10, 25, 49, 41, 37, 19, 48},
	Charred_Room = {24, 18, 23, 38, 30, 13, 34, 48, 44, 20, 47, 15, 8},
	Dining_Room = {24, 3, 27, 5, 16, 6, 45, 42, 21, 20, 37, 39, 40},
	Furnace_Room = {4, 18, 32, 38, 30, 13, 10, 42, 36, 28, 50, 15, 2},
	Gallery = {17, 3, 12, 38, 33, 22, 10, 25, 36, 41 ,37, 15, 8},
	Gymnasium = {35, 29, 12, 46, 33, 22, 11, 22, 21, 41, 47, 19, 48},
	Junk_Room = {4, 18, 27, 46, 1, 9, 11, 25, 44, 28, 50, 31, 40},
	Kitchen = {17, 3, 23, 46, 33, 22, 34, 32, 36, 41, 37, 39, 2},
	Master_Bedroom = {35, 29, 27, 5, 16, 6, 10, 35, 44, 20, 47, 19, 2},
	Pentagram_Chamber = {26, 43, 32, 43, 26, 26, 45, 14, 14, 26, 14, 43, 40},
	Servants_Quarters = {35, 29, 12, 5, 30, 9, 34, 42, 21, 28, 50, 31, 8}
}

haunts70 = {
	Abandoned_Room = {70, 7, 12, 53, 64, 9, 45, 67, 49, 52, 69, 61, 48},
	Balcony = {24, 7, 32, 5, 16, 6, 11, 25, 49, 20, 47, 58, 60},
	Catacombs = {4, 60, 68, 46, 1, 68, 10, 25, 49, 52, 37, 19, 63},
	Charred_Room = {70, 18, 23, 38, 64, 13, 34, 55, 44, 20, 58, 15, 8},
	Dining_Room = {24, 51, 27, 5, 16, 6, 45, 55, 59, 67, 37, 39, 40},
	Furnace_Room = {70, 18, 32, 38, 30, 13, 62, 42, 36, 28, 50, 61, 2},
	Gallery = {17, 3, 57, 38, 33, 22, 57, 55, 36, 41 ,54, 15, 57},
	Gymnasium = {60, 29, 12, 46, 33, 66, 11, 56, 21, 41, 47, 61, 48},
	Junk_Room = {4, 65, 65, 53, 1, 9, 62, 65, 59, 28, 50, 31, 63},
	Kitchen = {17, 3, 23, 46, 64, 22, 34, 56, 59, 69, 67, 39, 63},
	Master_Bedroom = {35, 51, 27, 5, 16, 66, 10, 56, 44, 52, 54, 19, 2},
	Pentagram_Chamber = {26, 43, 69, 43, 60, 26, 45, 14, 14, 26, 14, 43, 40},
	Servants_Quarters = {35, 29, 12, 53, 30, 66, 62, 42, 21, 58, 54, 31, 8}
}

--Haunt Information--
--Traitor, hero url, traitor url--
--hero gallery = http://imgur.com/a/dx4RQ --
--traitor gallery = http://imgur.com/a/ZYFQd --
hauntInfo = {
	{"Haunt_Revealer", "http://i.imgur.com/YhTDFSl.png", "http://i.imgur.com/tqPUJhu.png"},
	{"Haunt_Revealer", "http://i.imgur.com/vaJTWhD.png", "http://i.imgur.com/kCVGwOo.png"},
	{"Lowest Knowledge (except for haunt revealer", "http://i.imgur.com/IHrcUco.png", "http://i.imgur.com/jI4NJy6.png"},
	{"Highest Might (except for haunt revealer", "http://i.imgur.com/4DenDQP.png", "http://i.imgur.com/EryE5mi.png"},
	{"Haunt_Revealer", "http://i.imgur.com/vCVUBfQ.png", "http://i.imgur.com/stLiknS.png"},
	{"Lowest Sanity", "http://i.imgur.com/9FQPtXd.png", "http://i.imgur.com/76duL0Y.png"},
	{"Father Rhinehardt or highest Sanity", "http://i.imgur.com/LQ7E7Vs.png", "http://i.imgur.com/Nww2td1.png"},
	{"Haunt_Revealer", "http://i.imgur.com/4TXFziZ.png", "http://i.imgur.com/KueDgTS.png"},
	{"Nobody (at first)", "http://i.imgur.com/3F7zliB.png", "http://i.imgur.com/JJJAjih.png"},
	{"Haunt_Revealer", "http://i.imgur.com/lORPiv0.png", "http://i.imgur.com/TXJ7KvG.png"},
	{"Haunt_Revealer", "http://i.imgur.com/GNOk0zN.png", "http://i.imgur.com/10ilsLi.png"},
	{"Nobody", "http://i.imgur.com/54iJB0o.png", "http://i.imgur.com/JK5h49g.png"},
	{"Lowest Sanity (except for haunt revealer)", "http://i.imgur.com/I684wBz.png", "http://i.imgur.com/XfSHcAq.png"},
	{"Haunt_Revealer", "http://i.imgur.com/MyNI138.png", "http://i.imgur.com/fRotn9C.png"},
	{"Lowest Speed (except for haunt revealer)", "http://i.imgur.com/1y038Je.png", "http://i.imgur.com/zZ8CqTE.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/cNcATND.png", "http://i.imgur.com/9uKxEUo.png"},
	{"Peter Akimoto or highest Knowledge", "http://i.imgur.com/iMkycVv.png", "http://i.imgur.com/4Yba85m.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/BsHRn87.png", "http://i.imgur.com/cHjwjp3.png"},
	{"Haunt_Revealer", "http://i.imgur.com/X8d0XHu.png", "http://i.imgur.com/zOlXeIP.png"},
	{"Vivian Lopez or highest Knowledge", "http://i.imgur.com/1p9lBT9.png", "http://i.imgur.com/yeE0yjX.png"},
	{"Oldest explorer (except for haunt revealer)", "http://i.imgur.com/G009INK.png", "http://i.imgur.com/x5e2JOV.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/sjs0Lem.png", "http://i.imgur.com/pihOSlP.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/GywCqGf.png", "http://i.imgur.com/uOExPpc.png"},
	{"Brandon Jaspers or lowest Speed", "http://i.imgur.com/A0wtR4E.png", "http://i.imgur.com/H6KNVLQ.png"},
	{"Zoe Ingstrom", "http://i.imgur.com/ZuakLsu.png", "http://i.imgur.com/7g4jtc9.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/XX7i3Gt.png", "http://i.imgur.com/KkIAsIU.png"},
	{"Highest Knowledge (except for haunt revealer)", "http://i.imgur.com/L6BdxIc.png", "http://i.imgur.com/PGCh7EW.png"},
	{"Highest Knowledge (except for haunt revealer)", "http://i.imgur.com/zR2HG21.png", "http://i.imgur.com/QL2d02Y.png"},
	{"Haunt_Revealer", "http://i.imgur.com/UiwzWFa.png", "http://i.imgur.com/fcf1Toc.png"},
	{"Haunt_Revealer", "http://i.imgur.com/VAQPucg.png", "http://i.imgur.com/EwBcRmm.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/HeIBWxx.png", "http://i.imgur.com/eaVdIja.png"},
	{"Highest Sanity", "http://i.imgur.com/B8y5d7T.png", "http://i.imgur.com/Qt3Xmp7.png"},
	{"Highest Speed (except for the haunt revealer)", "http://i.imgur.com/X2mPOU9.png", "http://i.imgur.com/sAmcrn7.png"},
	{"Professor Longfellow or highest Speed", "http://i.imgur.com/wVaxFyN.png", "http://i.imgur.com/sOKkxed.png"},
	{"Highest Knowledge", "http://i.imgur.com/IBC6Qxd.png", "http://i.imgur.com/ra8CBjs.png"},
	{"Missy Dubourde or highest Speed", "http://i.imgur.com/tpK2TVy.png", "http://i.imgur.com/xATvufz.png"},
	{"Lowest Might", "http://i.imgur.com/H83M9jk.png", "http://i.imgur.com/20Go03C.png"},
	{"Lowest Knowledge (except for the haunt revealer", "http://i.imgur.com/YzCKYco.png", "http://i.imgur.com/1lmF7Bt.png"},
	{"Highest Speed (except for the haunt revealer", "http://i.imgur.com/NyxHO2q.png", "http://i.imgur.com/7olUnLI.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/UF0OsOD.png", "http://i.imgur.com/m5iIx1M.png"},
	{"Haunt_Revealer", "http://i.imgur.com/gnyaMOF.png", "http://i.imgur.com/oxF0CEo.png"},
	{"Highest Might", "http://i.imgur.com/tjQnB5W.png", "http://i.imgur.com/DTJET4w.png"},
	{"Haunt_Revealer", "http://i.imgur.com/tLem9sO.png", "http://i.imgur.com/6etXc9M.png"},
	{"Youngest explorer (except for the haunt revealer)", "http://i.imgur.com/NDfW8jW.png", "http://i.imgur.com/iLOfwrg.png"},
	{"Highest Knowledge", "http://i.imgur.com/n5IDYRw.png", "http://i.imgur.com/rYQkJSI.png"},
	{"Madame Zostra or lowest Speed", "http://i.imgur.com/48drGrf.png", "http://i.imgur.com/IBUYd2X.png"},
	{"Haunt_Revealer", "http://i.imgur.com/E2FZnjY.png", "http://i.imgur.com/pEaqujQ.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/8r60mFy.png", "http://i.imgur.com/G6UfKqN.png"},
	{"Heather Granville or highest Knowledge", "http://i.imgur.com/SnaLFcG.png", "http://i.imgur.com/Pz0Wiqj.png"},
	{"Haunt_Revealer", "http://i.imgur.com/uJ0qE6o.png", "http://i.imgur.com/ZJUHNxT"},
	{"Haunt_Revealer", "http://i.imgur.com/lirdLQk.png","http://i.imgur.com/8x0aWo9.png"},
	{"Haunt_Revealer", "http://i.imgur.com/977WbEu.png","http://i.imgur.com/ZdXKWKM.png"},
	{"Haunt_Revealer", "http://i.imgur.com/OgVNUMb.png","http://i.imgur.com/t7byt6T.png"},
	{"Lowest Sanity (except for haunt revealer)", "http://i.imgur.com/rQ0Bqaw.png","http://i.imgur.com/UczFsRA.png"},
	{"Nobody (at first)", "http://i.imgur.com/MjWtghc.png","http://i.imgur.com/hJmAn2E.png"},
	{"Haunt_Revealer", "http://i.imgur.com/3YJTQJG.png","http://i.imgur.com/LzFSCmn.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/ZYH0ODU.png","http://i.imgur.com/WlU1Q0g.png"},
	{"Lowest Might", "http://i.imgur.com/oM4cLzS.png","http://i.imgur.com/jcuYEFF.png"},
	{"Lowest Knowledge (except for haunt revealer)", "http://i.imgur.com/B1c50rh.png","http://i.imgur.com/cLXGxtX.png"},
	{"Highest Knowledge (except for haunt revealer)", "http://i.imgur.com/6tF5zjd.png","http://i.imgur.com/7qOKakr.png"},
	{"Highest Sanity (except for haunt revealer)", "http://i.imgur.com/cxFC5oT.png","http://i.imgur.com/mbqrJjZ.png"},
	{"Haunt_Revealer", "http://i.imgur.com/QOFAek2.png","http://i.imgur.com/OoXsEIX.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/eEWI4OI.png","http://i.imgur.com/7pOW5sy.png"},
	{"Highest Might (except for haunt revealer)", "http://i.imgur.com/wNQu20X.png","http://i.imgur.com/8rdT7ib.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/yrHw84R.png","http://i.imgur.com/EBLaOyN.png"},
	{"Left_Haunt_Revealer", "http://i.imgur.com/TYvMpok.png","http://i.imgur.com/Gg3OLJe.png"},
	{"Jenny LeClerc or highest Knowledge", "http://i.imgur.com/UcQudef.png","http://i.imgur.com/ebJHGlJ.png"},
	{"Haunt_Revealer", "http://i.imgur.com/BYTdsvp.png","http://i.imgur.com/I7jdZO5.png"},
	{"Lowest Speed", "http://i.imgur.com/yIyY2y4.png","http://i.imgur.com/pQWBn5f.png"},
	{"Haunt_Revealer", "http://i.imgur.com/jB5hOox.png","http://i.imgur.com/okAlxqF"}

}

--Room Tile Table--
--Name   /   GUID--
RoomCards = {
	Abandoned_Room = "ac6aef",
	Attic = "783e08",
	Balcony = "e5b7bd",
	Ballroom = "02eb68",
	Basement_Landing = "6a1247",
	Bedroom = "e06ec8",
	Bloody_Room = "11f8e1",
	Catacombs = "7ed085",
	Chapel = "4b767e",
	Charred_Room = "78c75a",
	Chasm = "a3c4f1",
	Coal_Chute = "3842ac",
	Collapsed_Room = "772d75",
	Conservatory = "feea40",
	Creaky_Hallway = "4232e1",
	Crypt = "eb10fa",
	Dining_Room = "9e0362",
	Dusty_Hallway = "ba1331",
	Entrance_Hall = "2c8802",
	Foyer = "77d944",
	Furnace_Room = "a59695",
	Gallery = "b7cb71",
	Game_Room = "a4e582",
	Gardens = "58d06d",
	Grand_Staircase = "c6d0b3",
	Graveyard = "b8d6bd",
	Gymnasium = "9aa335",
	Junk_Room = "ee7c25",
	Kitchen = "ec0e06",
	Larder = "def339",
	Library = "2fe228",
	Master_Bedroom = "e65446",
	Mystic_Elevator = nil, --Do not lock this card
	Operating_Laboratory = "6b309d",
	Organ_Room = "b19116",
	Patio = "f6926a",
	Pentagram_Chamber = "b30000",
	Research_Laboratory = "bb23f6",
	Servants_Quarters = "4d4768",
	Stairs_From_Basement = "77c74b",
	Statuary_Corridor = "c0e140",
	Storeroom = "a435d5",
	Tower = "1197df",
	Underground_Lake = "91b502",
	Upper_Landing = "5ed401",
	Vault = "3e05bc",
	Wine_Cellar = "9667e5"
}

omenNames = {
	"Bite",
	"Book",
	"Crystal Ball",
	"Dog",
	"Girl",
	"Holy Symbol",
	"Madman",
	"Mask",
	"Medallion",
	"Ring",
	"Skull",
	"Spear",
	"Spirit Board"
}

function onload()

	onloadNotes = [[
	[u]Welcome to Betrayal at House on the Hill![/u]

	If this is your first time playing with this mod
	please read the [b]README[/b] in the [b]NOTEBOOK[/b].

	]]


	setNotes(onloadNotes)

	--Player Token Objects--
	Blue_Pawn = getObjectFromGUID("726743")
	Red_Pawn = getObjectFromGUID("b6db05")
	Green_Pawn = getObjectFromGUID("5fc681")
	Purple_Pawn = getObjectFromGUID("ec0fd1")
	Orange_Pawn = getObjectFromGUID("e12b22")
	White_Pawn = getObjectFromGUID("b12614")

	omenTracker = getObjectFromGUID("635914")
	omensLeft = getObjectFromGUID(omenGUID).getObjects()

	omenTracker.createButton({click_function='haunt_clicked', label='Begin Haunt', function_owner=self, position={0, 0.24, 0.225}, rotation={0, 180, 0}, width=225, height=60, font_size=30})
	getObjectFromGUID("d06ff2").createButton({click_function='haunt50_clicked', label='Haunts 1-50', function_owner=self, position={0, -0.08, -0.25}, rotation={180, 0, 0}, width=300, height=150, font_size=50})
	getObjectFromGUID("d06ff2").createButton({click_function='haunt70_clicked', label='Haunts 1-70', function_owner=self, position={0, -0.08, 0.25}, rotation={180, 0, 0}, width=300, height=150, font_size=50})
end

function onObjectDestroyed(object)
	name = object.getName()
	table.insert(deadObjects, name)
end

function onPlayerTurnStart(color) --Called at the start of every turn
	TurnColor = color
	table.insert(TurnOrder, TurnColor)
	if #TurnOrder > #getSeatedPlayers() then
		table.remove(TurnOrder, 1)
		if #TurnOrder > #getSeatedPlayers() then
			table.remove(TurnOrder, 1)
		end
	end
end

function onPlayerTurnEnd(color) --Called on the end of every turn
	lastTurnColor = color

	if next(lockme) ~= nil then --locks any new room tiles
		for i=1, #lockme, 1 do
			lockme[i].lock()
		end
	end
	lockme = {} --clears lockme table
end

function onObjectEnterScriptingZone(zone, object) --Objects entering scripting zones
	if zone.getGUID() == "7dd6b1" then --Play Area
		local checkGUID = object.getGUID()
		if isRoomTile(checkGUID) == true then --if object is a room tile, add to lockme table.
			table.insert(lockme, object)
		end
	end
end

function onObjectLeaveScriptingZone(zone, object) --Objects leaving Scripting Zones
	if zone == getObjectFromGUID("92389e") then -- Omen Deck Area
		desc = object.getDescription()
		for k,v in pairs(omenNames) do
			if v == desc then
				lastOmen = desc
				lastOmenNum = k
				omenNames[k] = nil
				omenTracker.Counter.increment()
			end
		end
	end;
end

function isRoomTile(GUID) --check if an object's GUID exists in the room table
	for k, v in pairs( RoomCards ) do
		if GUID == v then
			return true
		end
	end
	return false
end

function popup(object) --slightly raises an object so smooth movement actually works.
	local table = object.getPosition()
	table.y = table.y + 1
	object.setPosition({table.x, table.y, table.z})
end

function checkPlayerPos(color) --returns the name of the card the player is on or nil if no card
	local pawnPos = {}
	local zoneObjects = getObjectFromGUID("7dd6b1").getObjects()

	if color == "Blue" then
		myPawn = Blue_Pawn
	elseif color == "Red" then
		myPawn = Red_Pawn
	elseif color == "Green" then
		myPawn = Green_Pawn
	elseif color == "Purple" then
		myPawn = Purple_Pawn
	elseif color == "Orange" then
		myPawn = Orange_Pawn
	elseif color == "White" then
		myPawn = White_Pawn
	end

		pawnPos = myPawn.getPosition()

	for k, v in pairs( RoomCards ) do
		for i,j in pairs(zoneObjects) do
			if v == j.getGUID() then
				local cardPosTable = {}
				cardPosTable = getObjectFromGUID(v).getPosition()

				local xdiff = cardPosTable.x - pawnPos.x
				local zdiff = cardPosTable.z - pawnPos.z

				if (math.abs(xdiff) < 1.4) and (math.abs(zdiff) < 1.4) then
					return k, myPawn
				end
			end
		end
	end
	return nil, myPawn -- returns nil if piece isn't on a card
end

function haunt_clicked()
	--print("HAUNT TIME")
	local colorTable = {}
	colorTable = stringColorToRGB(TurnColor)
	printToAll(getPlayer(TurnColor).steam_name .. " has started the haunt!", {colorTable.r, colorTable.g, colorTable.b})
	--[[
	print("Room: " .. checkPlayerPos(TurnColor))
	print("Omen: " .. lastOmen)
	print("Omen Index: " .. lastOmenNum)
	print("Haunt# " .. getHaunt(lastOmenNum, checkPlayerPos(TurnColor)) .. " has begun.")
	--]]
	local name, thisPawn = checkPlayerPos(TurnColor)
	getTraitor(getHaunt(lastOmenNum, name))
end

function getHaunt(omen, room) --determines haunt based on omen number and room string
	return haunts[room][omen]
end

function getTraitor(haunt) --determines traitor based on haunt number
	printToAll("The Traitor is...", {1,0,0})
	local infoTable = hauntInfo[haunt]
	getObjectFromGUID(heroTabletGUID).setValue(infoTable[2])
	getObjectFromGUID(traitorTabletGUID).setValue(infoTable[3])
	local traitorString = infoTable[1]
	local isNil = string.match(traitorString, " or ")
	local colorTable = {}

	if traitorString == "Haunt_Revealer" then
		colorTable = stringColorToRGB(TurnColor)
		printToAll(getPlayer(TurnColor).steam_name .. "!", {colorTable.r, colorTable.g, colorTable.b})
		return 0
	elseif traitorString == "Left_Haunt_Revealer" then
		colorTable = stringColorToRGB(TurnOrder[1])
		printToAll(getPlayer(TurnOrder[1]).steam_name .. "!", {colorTable.r, colorTable.g, colorTable.b})
		return 0
	elseif isNil ~= nil then
		local i,j = string.find(traitorString, " or ")
		if isDeadByName(string.sub(traitorString, 1, i-1)) then
			--print 2nd half
			traitorString = string.sub(traitorString, j+1)
			printToAll("The explorer with the " .. traitorString .. "!", {1,0,0})
		else
			--print first half
			traitorString = string.sub(traitorString, 1, i-1)
			if traitorString == "Peter Akimoto" or traitorString == "Brandon Jaspers" then
				colorTable = stringColorToRGB("Green")
			elseif traitorString == "Father Rhinehardt" or traitorString == "Professor Longfellow" then
				colorTable = stringColorToRGB("White")
			elseif traitorString == "Madame Zostra" or traitorString == "Vivian Lopez" then
				colorTable = stringColorToRGB("Blue")
			elseif traitorString == "Heather Granville" or traitorString == "Jenny LeClerc"then
				colorTable = stringColorToRGB("Purple")
			elseif traitorString == "Missy Dubourde" or traitorString == "Zoe Ingstrom" then
				colorTable = stringColorToRGB("Orange")
			end
		end

			printToAll(traitorString .. "!", {colorTable.r, colorTable.g, colorTable.b})
	elseif haunt == 21 or haunt == 44 then
		printToAll("The " .. traitorString .. "!", {1,0,0})
	elseif haunt == 9 or haunt == 12 or haunt == 55 then
		printToAll(traitorString .. "!", {1,0,0})
	else
		printToAll("The explorer with the " .. traitorString .. "!", {1,0,0})
	end
end

function isDeadByName(nameString) --checks deadObjects list, returns true if found
	for k,v in pairs(deadObjects) do
		if nameString == v then
			return true
		end
	end
	return false
end

function haunt50_clicked()
haunts = haunts50
end

function haunt70_clicked()
haunts = haunts70
end

function spawnZone(args)

    local params = {}
    params.type = "ScriptingTrigger"
    params.position = args[1]
    scriptZone = spawnObject(params)
    scriptZone.setScale({args[2], 2, args[3]})    -- set the dimensions you want

    return scriptZone
end