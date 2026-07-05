local fs = require("@std/fs")
local json = require("@std/json")
local path = require("@std/path")

local function sync(pesdePath: path.Pathlike, projectPath: path.Pathlike)
	local project = json.deserialize(fs.readFileToString(projectPath))
	local version: string = assert(project.version, "Failed to get project version")

	local packageContents = fs.readFileToString(pesdePath)
	local newPackageContents = string.gsub(packageContents, 'version = "(.-)"', `version = "{version}"`, 1)

	fs.writeStringToFile(pesdePath, newPackageContents)
end

-- TODO: search for these files
sync("./pesde.toml", "./project.json")
