# Neovim IDE config

Конфиг Neovim **0.12.5** под веб-разработку: в первую очередь **Angular**, плюс
**Vue 3**, **Go**, **Rust**, **Lua**.

Особенности сетапа:

- **Без `lazy.nvim`** — плагины ставятся нативным менеджером `vim.pack`
  (lockfile `nvim-pack-lock.json`).
- **Без `nvim-lspconfig`** — серверы включаются нативным `vim.lsp.enable`,
  конфиг каждого сервера лежит в `lsp/<имя>.lua` (имя файла = имя сервера).
- Структура «один плагин — один файл» в `lua/plugins/`, автозагрузчик
  [`lua/plugins/init.lua`](lua/plugins/init.lua) подхватывает все файлы.

Leader — `<Space>`.

---

## Что умеет

### LSP (языковые серверы)

Включаются в [`lua/lsp.lua`](lua/lsp.lua), настройки — в `lsp/`:

| Язык | Сервер | Файл |
|------|--------|------|
| TypeScript / JS | `vtsls` | [`lsp/vtsls.lua`](lsp/vtsls.lua) |
| Angular templates | `angular-language-server` (ngserver) | [`lsp/angular-language-server.lua`](lsp/angular-language-server.lua) |
| ESLint | `vscode-eslint-language-server` | [`lsp/eslint.lua`](lsp/eslint.lua) |
| Tailwind CSS | `tailwindcss-language-server` | [`lsp/tailwindcss.lua`](lsp/tailwindcss.lua) |
| Vue 3 (SFC) | `vue_ls` (Volar) + vtsls hybrid | [`lsp/vue_ls.lua`](lsp/vue_ls.lua) |
| JSON (+SchemaStore) | `jsonls` | [`lsp/jsonls.lua`](lsp/jsonls.lua) |
| Go | `gopls` | [`lsp/gopls.lua`](lsp/gopls.lua) |
| Rust | `rust-analyzer` (через rustaceanvim) | [`lua/plugins/rustaceanvim.lua`](lua/plugins/rustaceanvim.lua) |
| Lua | `lua_ls` | [`lsp/lua_ls.lua`](lsp/lua_ls.lua) |

Фишки:
- **Vue hybrid mode** — Volar разбирает `.vue`, а TypeScript внутри делегируется
  в vtsls через `@vue/typescript-plugin`.
- **Tailwind в Angular** — подсказки классов работают и в `.html`, и внутри
  `.ts` (`host: { class: '...' }`, `cva`, `ngClass`). Для Tailwind v4-проектов
  с непрямым импортом конфиг указывается вручную в `before_init`
  (см. [`lsp/tailwindcss.lua`](lsp/tailwindcss.lua)).
- **Inlay hints** — типы/параметры инлайн (vtsls, gopls, rust-analyzer),
  тумблер `<leader>ih`.
- `:LspRestart` — перезапуск серверов текущего буфера (полезно, когда gopls/vtsls
  не видят только что созданный файл).

### Автодополнение и сниппеты

- **blink.cmp** — `<C-space>` показать меню, `<CR>` принять, `<C-n>` принять
  выбранное, `<C-j>/<C-k>` навигация. Источники: LSP, сниппеты, пути.
  ([`lua/plugins/blink_cmp.lua`](lua/plugins/blink_cmp.lua))
- **GitHub Copilot** — inline-подсказки ([`lua/plugins/copilot.lua`](lua/plugins/copilot.lua)),
  нужен `:Copilot auth` и активная подписка.
- **friendly-snippets** — готовые сниппеты.

### Форматирование и линтинг

- **conform.nvim** ([`lua/plugins/conform.lua`](lua/plugins/conform.lua)) —
  формат на сохранении. Prettier для ts/js/html/vue/css/json/yaml/md (берётся из
  `node_modules/.bin` проекта, уважается `.prettierrc`), `stylua` для Lua,
  `goimports`+`gofmt` для Go, LSP-formatter как fallback (например Rust).
  Ручной формат — `<leader>fo`.
- **ESLint** — автофиксы `<leader>fx` (`:EslintFixAll`).

### Навигация и поиск

- **fzf-lua** — `<leader><leader>` файлы, `<leader>/` поиск по содержимому.
  Исключены `node_modules`, `dist`, `.angular` и т.п.
  ([`lua/plugins/fzf-lua.lua`](lua/plugins/fzf-lua.lua))
- **snacks explorer** — `<leader>e` (файловое дерево).
- **flash.nvim** — прыжки по экрану: `s` (по буквам), `S` (по treesitter).
- **grug-far** — поиск и замена по проекту: `<leader>sr`.
- LSP: `gd` определение, `gr` ссылки/использования (в Trouble), `K` документация,
  `<leader>rn` переименование с превью, `<leader>ca` code action.
- `<C-d>/<C-u>`, `n/N`, `{/}` — с автоцентрированием (`zz`).
- `<C-h/j/k/l>` — переход между окнами **и панелями tmux** (vim-tmux-navigator).

### Тесты (vim-test + vimux)

Запуск в tmux-панели, раннер выбирается автоматически по проекту (Playwright /
Vitest / Jest / cargo test / go test). ([`lua/plugins/vim-test.lua`](lua/plugins/vim-test.lua))

- `<leader>tn` ближайший, `<leader>tf` файл, `<leader>ts` сьют,
  `<leader>tl` последний, `<leader>tv` к последнему тест-файлу.

### Отладка (Rust)

nvim-dap + dap-ui + codelldb ([`lua/plugins/dap.lua`](lua/plugins/dap.lua),
[`lua/plugins/rustaceanvim.lua`](lua/plugins/rustaceanvim.lua)):

- `<leader>db` breakpoint, `<leader>dc` continue, `<leader>di/do/dO` step,
  `<leader>dr` repl, `<leader>du` UI, `<leader>dt` terminate.
- Rust: `<leader>rr` runnables, `<leader>rd` debuggables, `<leader>rm` expand macro,
  `<leader>rc` открыть Cargo.toml, `<leader>ca` RustLsp code action.

### Диагностика / UI

- **trouble.nvim** — `<leader>xx` все диагностики, `<leader>xX` по буферу.
- **noice.nvim** — командная строка и сообщения в плавающих окнах.
- **which-key** — подсказки по клавишам.
- **gitsigns** — git-знаки в gutter + blame по строке.
- **fidget** — прогресс LSP (загрузка серверов и т.п.).
- **alpha-nvim** — стартовый экран с недавними файлами **по текущему проекту**.
- **todo-comments**, **trouble**, **scrollbar**, **lualine**, **mini.pairs/surround**,
  **ts-autotag**, **ts-comments**, **inc-rename**, **tokyonight** (тема).
- **cord.nvim** — Discord Rich Presence (тема atom; скрыты имя файла, проекта и
  dashboard). ([`lua/plugins/cord.lua`](lua/plugins/cord.lua))

---

## Исправленные баги Neovim 0.12

Эти правки — обходы багов самого Neovim/серверов, не косметика. Помечены
комментариями в коде; когда апстрим починит — можно удалять.

1. **Inlay hints: `Invalid 'col': out of range`** — [`lua/lsp.lua`](lua/lsp.lua)
   Когда к буферу подключено несколько LSP-клиентов (vtsls +
   angular-language-server), hints одного клиента могут остаться от старой версии
   буфера, пока другой клиент обновляет общую версию. Колонка устаревшей подсказки
   указывает за конец укоротившейся строки → decoration provider падает на каждой
   перерисовке (спам ошибок). **Фикс:** обёртка над `nvim_buf_set_extmark`
   подрезает `col` к длине строки, но только для namespace inlay hints — другие
   плагины не затронуты.

2. **treesitter: `attempt to call method 'range' (a nil value)`** —
   [`lua/plugins/treesitter.lua`](lua/plugins/treesitter.lua)
   Ветка `master` nvim-treesitter несовместима с Neovim 0.12. **Фикс:** используем
   ветку `main` (новый API) + tree-sitter CLI для компиляции парсеров.

3. **ESLint: `-32603 ... "path" argument must be of type string`** —
   [`lsp/eslint.lua`](lsp/eslint.lua)
   Pull-диагностика ESLint падала без полных дефолтных настроек. **Фикс:** заданы
   все дефолтные `settings`, критично `nodePath = ''`.

---

## Что нужно поставить отдельно

Конфиг ставит **плагины** сам (`vim.pack`) и **LSP/инструменты** через Mason
(`:Mason`). Но системные зависимости нужно поставить руками.

### Обязательно (Homebrew)

```bash
brew install neovim        # 0.12.5+
brew install git tmux lazygit
brew install fd ripgrep fzf   # для fzf-lua (поиск файлов/по содержимому)
```

**Node.js** — через `nvm` (нужен для vtsls, Volar, eslint, prettier, Copilot):

```bash
nvm install 22 && nvm use 22
```

**Nerd Font** — иначе иконки будут «квадратиками». Поставь любой Nerd Font
(например из `brew install --cask font-jetbrains-mono-nerd-font`) и выбери его
шрифтом терминала.

### Желательно

```bash
brew install fswatch   # надёжное отслеживание файлов LSP на macOS
```

> Без `fswatch` gopls/vtsls иногда не видят только что созданный файл (FSEvents на
> macOS ненадёжен). Пока его нет — помогает `:LspRestart`. С `fswatch` проблема
> уходит.

### Инструменты Mason (ставятся командой `:Mason` или уже стоят)

LSP-серверы и утилиты: `vtsls`, `angular-language-server`, `eslint-lsp`,
`tailwindcss-language-server`, `vue-language-server`, `json-lsp`, `gopls`,
`goimports`, `rust-analyzer`, `codelldb`, `lua-language-server`, `stylua`,
`tree-sitter-cli`.

> Prettier и ESLint **не** ставятся глобально — берутся из `node_modules` каждого
> проекта (уважается версия и конфиг проекта). Поэтому в проекте нужен
> `npm install` / `pnpm install`.

### Для своих сервисов (опционально)

- **GitHub Copilot** — `:Copilot auth`, нужна активная подписка.
- **Discord presence** (cord.nvim) — нужен запущенный десктопный Discord.
- **tmux-плагины** — vim-tmux-navigator, tmux-neolazygit и tpm настраиваются в
  `~/.tmux.conf` (переходы между панелями Vim↔tmux, lazygit→nvim).

---

## Структура

```
init.lua                 — точка входа
lua/
  config.lua             — опции редактора
  autocmd.lua            — автокоманды
  keymap.lua             — клавиши
  lsp.lua                — включение LSP + фиксы багов
  plugins/               — по файлу на плагин (+ init.lua автозагрузчик)
lsp/                     — конфиг каждого LSP-сервера (имя файла = имя сервера)
nvim-pack-lock.json      — lockfile vim.pack
```
