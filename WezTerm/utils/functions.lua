---Various utility functions
---
---@module "utils.functions"

---User defined utility functions
---@class Utils.Fn
---@field fs    Utils.Fn.FileSystem
local M = {}

---Merges two tables
---@param t1 table
---@param ... table[] one or more tables to merge
---@return table t1 modified t1 table
M.tbl_merge = function(t1, ...)
    local tables = { ... }

    for i = 1, #tables do
        local t2 = tables[i]
        for k, v in pairs(t2) do
            if type(v) == "table" then
                if type(t1[k] or false) == "table" then
                    M.tbl_merge(t1[k] or {}, t2[k] or {})
                else
                    t1[k] = v
                end
            else
                t1[k] = v
            end
        end
    end

    return t1
end

-- {{{1 Utils.Fn.FileSystem

---@class Utils.Fn.FileSystem
M.fs = {}

---Path separator based on the platform.
---
---This variable holds the appropriate path separator character for the current platform.

---Equivalent to POSIX `basename(3)`.
---
---This function extracts the base name (the final component) from a given path.
---
---@param path string Any string representing a path.
---@return string str The base name of the path.
M.fs.basename = function(path)
    local trimmed_path = path:gsub("[/\\]*$", "")
    local index = trimmed_path:find("[^/\\]*$")
    return index and trimmed_path:sub(index) or trimmed_path
end

---Searches for the git project root directory of the given directory path.
---
---This function traverses up the directory tree to find the `.git` directory, indicating
---the root of a git project.
---
---@param directory string The directory path to start searching from.
---@return string|nil git_root If found, the `git_root`, else `nil`.
M.fs.find_git_dir = function(directory)
    directory = directory:gsub("~", M.fs.home())

    while directory do
        local handle = io.open(directory .. "/.git/HEAD", "r")
        if handle then
            handle:close()
            directory = directory:gsub(M.fs.home(), "~")
            return directory
        elseif directory == "/" or directory == "" then
            break
        else
            directory = directory:match("(.+)/[^/]*")
        end
    end

    return nil
end

-- }}}

-- Lua implementation of PHP scandir function
---@param directory string The directory in which we are operating. It must be absolute
---@return table files Table of all files found
M.scandir = function(directory)
    if not directory then
        return {}
    end

    local i, files, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')
    if not pfile then
        return {}
    end

    for filename in pfile:lines() do
        i = i + 1
        files[i] = filename
    end
    pfile:close()
    return files
end

return M
