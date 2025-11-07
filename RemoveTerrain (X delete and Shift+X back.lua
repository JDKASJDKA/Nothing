-- LocalScript en StarterPlayerScripts

local UserInputService = game:GetService("UserInputService")
local Terrain = workspace:WaitForChild("Terrain")

local terrainBackup = nil
local terrainDestroyed = false

-- Regiￃﾳn donde estￃﾡ el terreno (ajￃﾺstala si tu mapa es mￃﾡs grande o mￃﾡs chico)
local MIN = Vector3int16.new(-512, -128, -512)
local MAX = Vector3int16.new(512, 512, 512)

-- Guarda el terreno actual
local function backupTerrain()
	local region = Region3int16.new(MIN, MAX)
	terrainBackup = Terrain:CopyRegion(region)
	print("￰ﾟﾓﾦ Terreno guardado en memoria")
end

-- Desintegra el terreno
local function destroyTerrain()
	if not terrainDestroyed then
		if not terrainBackup then
			backupTerrain()
		end
		Terrain:Clear()
		terrainDestroyed = true
		print("￰ﾟﾒﾥ Terreno desintegrado")
	end
end

-- Restaura el terreno
local function restoreTerrain()
	if terrainDestroyed and terrainBackup then
		local region = Region3int16.new(MIN, MAX)
		Terrain:PasteRegion(terrainBackup, MIN, true)
		terrainDestroyed = false
		print("￢ﾜﾅ Terreno restaurado")
	else
		print("￢ﾚﾠ￯ﾸﾏ No hay copia del terreno para restaurar")
	end
end

-- Detectar teclas
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.X then
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
			restoreTerrain()
		else
			destroyTerrain()
		end
	end
end)
