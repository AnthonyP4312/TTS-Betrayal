function onload()
    self.createButton({click_function='tile_clicked', label='No Player', function_owner=self, position={0, 0.1, 0}, rotation={0, 0, 0}, width=2500, height=1500, font_size=500})
end

function tile_clicked()
    delZone = Global.Call("spawnZone", {self.getPosition(), 20, 10})
    startLuaCoroutine(self, "kill")
end

function kill(args)
    coroutine.yield(0)
    obTable = delZone.getObjects()
    for k,v in pairs(obTable) do
        v.destruct()
    end
    delZone.destruct()

    return 1
end