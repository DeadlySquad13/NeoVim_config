-- Default leader key used by tinykeymap.
vim.g['tinykeymap#mapleader'] = ',';
-- Enable transitive mode after pressing leader map of the mode.
local tinykeymap_map_transitive_catalizator = '.';

-- * Windows.
-- Path: /home/dubuntus/.vim/plugged/tinykeymap_vim/autoload/tinykeymap/map/windows.vim
-- vim.g['tinykeymap#map#windows#map'] = '<c-w>' .. tinykeymap_map_transitive_catalizator;
local tinykeymap_map = vim.fn['tinykeymap#Map'];
local tinykeymap_enter_map = vim.fn['tinykeymap#EnterMap'];
-- local tinykeymap_load = vim.fn['tinykeymap#Load'];
-- tinykeymap_load('windows')

-- * HorizontalScroll.
local tinykeymap_map_horizontal_scroll_map = '<leader>zh' .. tinykeymap_map_transitive_catalizator;

tinykeymap_enter_map('HorizontalScroll', tinykeymap_map_horizontal_scroll_map, {
      name = 'horizontal scroll mode'
    });

-- - Mappings.
tinykeymap_map(
      'HorizontalScroll', 'h',
      'execute  "normal! zh"',
      { desc = 'Left' });
tinykeymap_map(
      'HorizontalScroll', 'l',
      'execute  "normal zl"',
      { desc = 'Right' });
tinykeymap_map(
      'HorizontalScroll', 'H',
      'execute  "normal zH"',
      { desc = 'Left half screen width' });
tinykeymap_map(
      'HorizontalScroll', 'L',
      'execute  "normal zL"',
      { desc = 'Right half screen width' });

-- * ExpandRegion (without catalizator yet, should be enhanced with treesitter).
tinykeymap_enter_map(
  'ExpandRegion', '<a-v>',
  { name = 'expand region mode' }
);

-- - Mappings.
tinykeymap_map('ExpandRegion',
  'v',
  'execute "normal \\<Plug(expand_region_expand)"',
  { desc = 'Expand selection' }
);

tinykeymap_map(
  'ExpandRegion',
  'V', 
  'execute "normal \\<Plug>(expand_region_shrink)"',
  { desc = 'Shrink selection' }
);
