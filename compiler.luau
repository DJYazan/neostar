--// Simple Compiler for Neostar bruh this is way to large
local OP = {}
OP.loads = {dec = 'string', args = 2, op = "LOADS"} --// we load string s using string Name = "John". If we want to include variables, which we can diff using ${} we will use loads_ill
OP.loads_ill = {dec = 'string_ill', args = 0, op = "LOADS_IL"} -- // We don't know how many args are there, 0 means either 0 or unknown
OP.comment = {dec = '//', args = 0, op = "COM"}
OP.call = {dec = 'call', args = 1, op = "CALL"}

function OP.compile(code, ret_code)
	local tabled = string.split(code, "\n") -- // Ignore Semicolons
	local OutputCode = {}
	local varcount = 1
	for i, v in pairs(tabled) do
		for j, x in pairs(OP) do
			if type(x) ~= "function" then
				if v:find(x.dec) ~= nil then
					--// Getting arguments is long for no reason, have fun reading here
					if x.op == "LOADS" then
						local a = v:split("string ")[2]:split(" = ") --// Split the String so we get the args we will recieve arg1 and arg2
						local code = `local {a[1]} = {a[2]}`
						varcount += 1
						table.insert(OutputCode, code)
					elseif x.op == "CALL" then
						local a = v:split("call ")[2] --// Split the func
						local code = `{a}`
						varcount += 1
						table.insert(OutputCode, code)
					elseif x.op == "COM" then
						--//Comment
					end
				end
			end
		end
	end
	if ret_code == false then
		return loadstring(table.concat(OutputCode, "\n")) --// Return the code as an executable (Server only if you're on Studio)
	else
		return loadstring(table.concat(OutputCode, "\n")), table.concat(OutputCode, "\n") --// Return the code as an executable (Server only if you're on Studio)
	end
end

print(OP.compile([[
//Hello World!
call print("Hello World!")
]], true))
