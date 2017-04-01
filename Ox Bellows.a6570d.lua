alt_GUID = "233fc8" --GUID of the other Character choice
NP_GUID = "ce1e36" --GUID of the No Player Button
player_Color = "Red" --Player's own color
rgb = stringColorToRGB(player_Color) --table of rbg values
pawn_GUID = "b6db05"
startPos = {2.25, 2 , -0.8}

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
		tokenBag.takeObject({position = {-39.891,3,-30.026}})
		tokenBag.takeObject({position = {-40.799,3,-32.54}})
		tokenBag.takeObject({position = {-35.66,3,-29.92}})
		tokenBag.takeObject({position = {-34.989,3,-33.32}})
	else
		printToColor("You may only select the color you are seated at.", color, {rgb["r"], rgb["g"], rgb["b"]})
	end
end

function name_clicked(ob, color)
	biostring = [[Ox Bellows:
Age: 23
Height: 6'4"
Weight: 288 lbs.
Hobbies: Football, Shiny
 Objects
Birthday: October 18th]]

    printToColor(biostring, color, {rgb["r"], rgb["g"], rgb["b"]})
end