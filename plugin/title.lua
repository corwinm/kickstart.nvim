local function path_relative_to(root, path)
  local normalized_root = vim.fs.normalize(root):gsub('/+$', '')
  local normalized_path = vim.fs.normalize(path):gsub('/+$', '')

  if normalized_path == normalized_root then
    return ''
  end

  local prefix = normalized_root .. '/'
  if normalized_path:sub(1, #prefix) == prefix then
    return normalized_path:sub(#prefix + 1)
  end
end

local function get_project_root(path)
  local absolute_path = vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
  local path_for_root = vim.fn.isdirectory(absolute_path) == 1 and absolute_path or vim.fs.dirname(absolute_path)

  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    local roots = {}

    if client.config.root_dir then
      table.insert(roots, client.config.root_dir)
    end

    for _, workspace in ipairs(client.workspace_folders or {}) do
      table.insert(roots, vim.uri_to_fname(workspace.uri))
    end

    for _, root in ipairs(roots) do
      if path_relative_to(root, absolute_path) ~= nil then
        return root
      end
    end
  end

  return vim.fs.root(path_for_root, { '.git' }) or vim.uv.cwd()
end

local function format_oil_title_path(path)
  if path == '' then
    return '[No Name]'
  end

  local project_root = get_project_root(path)
  local relative_path = project_root and path_relative_to(project_root, path)

  if project_root and relative_path ~= nil then
    if relative_path == '' then
      return vim.fs.basename(project_root)
    end

    return relative_path
  end

  return vim.fn.fnamemodify(path, ':~:.')
end

local function format_buffer_title(path)
  if path == '' then
    return '[No Name]'
  end

  return vim.fn.fnamemodify(path, ':t')
end

function _G.custom_titlestring()
  local modified = vim.bo.modified and '+ ' or ''
  local buf_name = vim.api.nvim_buf_get_name(0)

  if vim.bo.filetype == 'oil' then
    local oil_dir = buf_name:gsub('^oil://', ''):gsub('/+$', '')

    if oil_dir == '' then
      return modified .. 'oil:// | nvim'
    end

    return string.format('%soil://%s | nvim', modified, format_oil_title_path(oil_dir))
  end

  return string.format('%s%s | nvim', modified, format_buffer_title(buf_name))
end

vim.o.title = true
vim.o.titlestring = '%{v:lua.custom_titlestring()}'
