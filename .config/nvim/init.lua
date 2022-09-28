require('lex-unix.base')
require('lex-unix.highlights')
require('lex-unix.maps')
require('lex-unix.plugins')

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('lex-unix.macos')
end
if is_win then
  require('windows')
end
