alt_GUID = "9fdfd2" --GUID of the other Character choice
NP_GUID = "da9619" --GUID of the No Player Button
player_Color = "White" --Player's own color
rgb = stringColorToRGB(player_Color) --table of rbg values
pawn_GUID = "b12614"
startPos = {4, 2, -0.8}

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
		getObjectFromGUID(NP_GUID).destruct() --kills other tile
		getObjectFromGUID(alt_GUID).destruct() --kills other tile
		printToColor("You have chosen " .. self.getName() .. ".", player_Color, {rgb["r"], rgb["g"], rgb["b"]})

		popup(pawn)
		pawn.setPositionSmooth(startPos)

		tokenBag = getObjectFromGUID("e67a84")
		tokenBag.takeObject({position = {33.72,3,-33.26}})
		tokenBag.takeObject({position = {34.34,3,-29.81}})
		tokenBag.takeObject({position = {37.886,3,-29.20}})
		tokenBag.takeObject({position = {39.485,3,-32.732}})
	else
		printToColor("You may only select the color you are seated at.", player_Color, {rgb["r"], rgb["g"], rgb["b"]})
	end
end

function name_clicked(ob, color)
	biostring = [[Father Rhinehardt:
		Age: 62
		Height: 5'9"
		Weight: 185 lbs.
		Hobbies: Fencing, 		Gardening
		Birthday: April 29th]]

    printToColor(biostring, color, {rgb["r"], rgb["g"], rgb["b"]})
end