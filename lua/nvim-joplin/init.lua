local Job = require("plenary.job")
local Curl = require("plenary.curl")

local njoplin = {}

-- Start Joplin API server
function njoplin.start_joplin_server()
	local results = {}
	local job = Job:new({
		command = "joplin",
		args = { "server", "start" },
		on_stdout = function(_, data)
			table.insert(results, data)
		end,
	})
	job:start()
	vim.wait(3000)

	for k, v in pairs(results) do
		print(v)
	end
end

-- Stop Joplin API server
function njoplin.stop_joplin_server()
	local results = {}
	local job = Job:new({
		command = "joplin",
		args = { "server", "stop" },
		on_stdout = function(_, data)
			table.insert(results, data)
		end,
	})
	job:start()
	vim.wait(3000)

	for k, v in pairs(results) do
		print(v)
	end
end

function njoplin.setup(params)
	njoplin.config = {}
	for k, v in pairs(params) do
		njoplin.config[k] = v
	end
end

-- Retrieve all notebooks
function njoplin.get_notebooks()
  -- check if the API token is set
  if not(njoplin.config.token) then
    error("Joplin token must be provided by setup. See - h: njoplin.setup")
    return
  end
	local notebooks = Curl.get({
		url = "http://localhost:41184/folders?token=" .. njoplin.config.token,
		accept = "application/json",
    timeout = 3000,
	})
	print(notebooks.status)
end

function njoplin.get_notes() end

function njoplin.get_note() end

return njoplin
