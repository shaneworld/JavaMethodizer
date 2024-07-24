local M = {}

-- 解析 Java 类并提取字段
local function parse_java_class()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fields = {}
  for _, line in ipairs(lines) do
    local field = line:match("^%s*private%s+(%w+)%s+(%w+);")
    if field then
      table.insert(fields, {type = field:match("^(%w+)"), name = field:match("(%w+)$")})
    end
  end
  return fields
end

-- 生成 getter 方法
local function generate_getter(field)
  local cap_name = field.name:sub(1, 1):upper() .. field.name:sub(2)
  return string.format([[
    public %s get%s() {
        return this.%s;
    }
  ]], field.type, cap_name, field.name)
end

-- 生成 setter 方法
local function generate_setter(field)
  local cap_name = field.name:sub(1, 1):upper() .. field.name:sub(2)
  return string.format([[
    public void set%s(%s %s) {
        this.%s = %s;
    }
  ]], cap_name, field.type, field.name, field.name, field.name)
end

-- 生成 toString 方法
local function generate_to_string(fields)
  local parts = {}
  for _, field in ipairs(fields) do
    table.insert(parts, string.format("%s=' + %s + '", field.name, field.name))
  end
  local content = table.concat(parts, ", ")
  return string.format([[
    @Override
    public String toString() {
        return "%s{" + "%s" + "}";
    }
  ]], vim.fn.expand("%:t"):gsub("%.java$", ""), content)
end

-- 生成所有方法
function M.generate_methods()
  local fields = parse_java_class()
  local methods = {}
  
  for _, field in ipairs(fields) do
    table.insert(methods, generate_getter(field))
    table.insert(methods, generate_setter(field))
  end
  
  table.insert(methods, generate_to_string(fields))
  
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], false, methods)
end

return M
