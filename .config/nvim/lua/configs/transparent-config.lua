require("transparent").setup({
extra_groups = { -- table/string: additional groups that should be cleared
  -- In particular, when you set it to 'all', that means all available groups

  'all',
},
exclude_groups = {}, -- table: groups you don't want to clear
})
