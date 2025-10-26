local rayfieldPath = "Rayfield"
local keySystemPath = rayfieldPath .. "/Key System"
local keyFilePath = keySystemPath .. "/B0bbyKey.rfld"

-- Check if Rayfield folder exists, create if not
if not isfolder(rayfieldPath) then
    makefolder(rayfieldPath)
end

-- Check if Key System folder exists, create if not
if not isfolder(keySystemPath) then
    makefolder(keySystemPath)
end

-- Check if B0bbyKey.rfld file exists, create with "Yes" if not
if not isfile(keyFilePath) then
    writefile(keyFilePath, "Yes")
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/BobJunior1/B0bby1Hub/refs/heads/main/iLoveSoup"))()
