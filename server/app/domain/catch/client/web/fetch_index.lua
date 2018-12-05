local function strempty(s)
  return s == nil or s == ''
end

local prefix = 'catch:web:ember:build:index:'
local current = redis.call('get', prefix .. 'current')

if strempty(current) then
  error('unable to retrieve current index revision: ' .. prefix .. 'current')
end

local str = redis.call('get', prefix .. current)

if strempty(str) then
  error('unable to retrieve current index string: ' .. prefix .. current)
end

return str
