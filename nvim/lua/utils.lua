local M = {}

function M.getTermTheme() return os.getenv('LEX_THEME') or 'dark' end

return M
