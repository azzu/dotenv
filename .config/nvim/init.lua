-- 줄 번호 표시
vim.opt.number = true
vim.opt.relativenumber = true

-- 들여쓰기 설정
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 검색 설정
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- 시스템 클립보드 연동
vim.opt.clipboard = "unnamedplus"

-- 커서 라인 강조
vim.opt.cursorline = true

-- 스크롤할 때 위아래 여백 유지
vim.opt.scrolloff = 8

-- Leader 키를 스페이스바로 설정
vim.g.mapleader = " "

-- 파일 저장
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- 창 이동을 좀 더 편하게
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- 줄 이동
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 검색 후 하이라이트 끄기
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- 파일을 읽을 때 시도할 인코딩 순서
vim.opt.fileencodings = "utf-8,euc-kr,cp949,latin1"
-- Neovim 내부에서 사용하는 인코딩
vim.opt.encoding = "utf-8"
-- 파일 저장 시 기본 인코딩
vim.opt.fileencoding = "utf-8"

-- Tab 이동: Alt + 숫자 또는 gt, gT 대신 편한 키로 설정
vim.keymap.set("n", "<Tab>", "gt")   -- 다음 탭
vim.keymap.set("n", "<S-Tab>", "gT") -- 이전 탭

-- 0: 탭 라인 절대 안 보임
-- 1: 탭이 2개 이상일 때만 보임 (기본값)
-- 2: 항상 보임
vim.opt.showtabline = 2
vim.opt.tabpagemax = 15 -- 최대 열 수 있는 탭 수

-- Shift + l(L) : 오른쪽 탭(버퍼)으로 이동
-- Shift + h(H) : 왼쪽 탭(버퍼)으로 이동
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })

-- 현재 버퍼(탭) 닫기 (Leader + x)
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { silent = true })

-- lazy.nvim 부트스트랩
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 설정
require("lazy").setup({
  -- 컬러 스킴
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- 파일 탐색기
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
          view = {
              width = '25%'
          },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
  },
  -- 퍼지 파인더
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- 탭 모드로 설정
          always_show_bufferline = true,
          offsets = {
              {
                  filetype = "NvimTree",
                  text = "File Explorer",
                  text_align = "left",
                  separator = true
              }
          }
        }
      })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    opts = {
      provider = "cursor",
      mode = "agentic",
      acp_providers = {
        cursor = {
          command = os.getenv("HOME") .. "/.local/bin/agent",
          args = { "acp" },
          auth_method = "cursor_login",
          env = {
            HOME = os.getenv("HOME"),
            PATH = os.getenv("PATH"),
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
})