local M = {}

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		return ya.preview_widget(job, err)
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek() end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local cmd_unzip = Command("unzip"):arg({ "-jp", tostring(job.file.url), "preview.png" })
	local cmd_7z = Command("7z"):arg({ "e", "-so", tostring(job.file.url), "preview.png" })

	local output = cmd_unzip:output()
	if not output then
		-- Try with `7z` instead
		output = cmd_7z:output()
		if not output then
			return nil, Err("Failed to start `unzip` or `7z`")
		elseif not output.status.success then
			return nil, Err("`7z` exited with error code: %s", output.status.code)
		end
	elseif not output.status.success then
		return nil, Err("`unzip` exited with error code: %s", output.status.code)
	end

	local ok, err = fs.write(cache, output.stdout)
	if not ok then
		return false, Err("Failed to write preview image to cache, error: %s", err)
	else
		return true
	end
end

function M:spot(job)
	require("file"):spot(job)
end

return M
