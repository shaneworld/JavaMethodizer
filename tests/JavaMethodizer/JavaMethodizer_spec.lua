-- tests/JavaMethodizer/JavaMethodizer_spec.lua
local plugin = require('JavaMethodizer')

describe('JavaMethodizer', function()
  it('should parse Java class correctly', function()
    -- 设置测试环境
    local lines = {
      'public class TestClass {',
      '    private int number;',
      '    private String name;',
      '}'
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    
    -- 调用函数并检查结果
    local fields = plugin.parse_java_class()
    assert.are.same(#fields, 2)
    assert.are.same(fields[1], {type = 'int', name = 'number'})
    assert.are.same(fields[2], {type = 'String', name = 'name'})
  end)

  -- 添加更多测试...
end)
