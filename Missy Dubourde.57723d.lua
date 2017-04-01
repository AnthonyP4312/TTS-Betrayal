alt_GUID = "fa17ca" --GUID of the other Character choice
NP_GUID = "a205a0" --GUID of the No Player Button
player_Color = "Orange" --Player's own color
rgb = stringColorToRGB(player_Color) --table of rbg values
pawn_GUID = "e12b22"
startPos = { 2.25, 2, 0.1}

function popup(object) --slightly raises an object so smooth movement actually works.

	local table = object.getPosition()
	table.y = 2
	object.setPosition({table.x, table.y, table.z})

end

function onload()
	self.createButton({click_function='tile_clicked', label='Select', function_owner=self, position={0.075, 0, 0}, rotation={0, 0, 0}, width=700, height=700, font_size=70})
	self.createButton({click_function='name_clicked', label='Bio', function_owner=self, position={0, 0, 1.2}, rotation={0, 0, 0}, width=800, height=175, font_size=70})
end

function tile_clicked(ob, color)
	if color == player_Color then
		pawn = getObjectFromGUID(pawn_GUID)
		pawn.clearButtons()
		pawn.setName(getPlayer(player_Color).steam_name)
		self.removeButton(0)
		getObjectFromGUID(alt_GUID).destruct() --kills other tile
		getObjectFromGUID(NP_GUID).destruct() --kills No Player button
		printToColor("You have chosen " .. self.getName() .. ".", player_Color, {rgb["r"], rgb["g"], rgb["b"]})

		popup(pawn)
		pawn.setPositionSmooth(startPos)

		tokenBag = getObjectFromGUID("e67a84")
		tokenBag.takeObject({position = {-47.46,3,1.88}})
		tokenBag.takeObject({position = {-47.682,3,-2.105}})
		tokenBag.takeObject({position = {-50.68,3,-2.99}})
		tokenBag.takeObject({position = {-51.25,3,2.763}})
	else
		printToColor("You may only select the color you are seated at.", color, {rgb["r"], rgb["g"], rgb["b"]})
	end
end

function name_clicked(ob, color)
	biostring = [[Missy Dubourde:
		Age: 9
		Height: 4'2"
		Weight: 62 lbs.
		Hobbies: Swimming, Medicine
		Birthday: February 14th]]

    printToColor(biostring, color, {rgb["r"], rgb["g"], rgb["b"]})
end