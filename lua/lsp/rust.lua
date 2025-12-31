-- rustaceanvim plugin contains such code, which leads to crates in /vendor/ mapped to another crate dir.
-- Remap it into the project root when cargo files are resolved under vendor.
local find_orig = vim.fs.find
vim.fs.find = function(what, where)
  local path = where and where.path
  if type(what) == "table" and what[1] == "Cargo.toml" and type(path) == "string" then
    if string.find(path, "/vendor/", 1, true) then
      local vendor = find_orig({ "vendor" }, where)[1]
      if vendor then
        vim.notify(string.format("vim.fs.find(`%s`) in `%s` was remapped into `%s`", what[1], path, vendor))
        return find_orig(what, { upward = where.upward, path = vendor })
      end
    end
  end

  return find_orig(what, where)
end

vim.g.rustaceanvim = {
  tools = {
    reload_workspace_from_cargo_toml = false,
  },
  server = {
    settings = function(project_root)
      return {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy"
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true
          },
        }
      }
    end,
  },
  dap = {},
}
