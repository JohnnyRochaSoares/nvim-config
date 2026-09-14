vim.g.colors_name = "mytheme"
vim.o.background = "dark"

local set = vim.api.nvim_set_hl

vim.opt.guicursor = table.concat({
    "n-v-c:block-Cursor",
    "i-ci-ve:ver25-Cursor",
    "r-cr-o:hor20-Cursor",
    "t:block-TermCursor",
    "a:blinkon0",
}, ",")

-- Palette
local c = {
    kw      = "#fb7609",
    dc      = "#ff0000",
    str     = "#00c200",
    tp      = "#00c5c7",
    plain   = "#f2f2f2",
    cm      = "#c7c7c7",
    sl      = "#6e6e6e",
    slr     = "#6e6e6e",
    bg      = "NONE",
    bg2     = "#000000",
    gutter  = "#333333",
    sel     = "#2a2a2a",
    err     = "#ff0000",
    warn    = "#e0af68",
    hint    = "#0017c7",
    info    = "#7dcfff",
}

-- Base
set(0, "Cursor",       { fg = "#000000", bg = "#ededed" })
set(0, "TermCursor",   { fg = "#000000", bg = "#ededed" })
set(0, "Normal",       { fg = c.plain, bg = c.bg })
set(0, "NormalFloat",  { fg = c.plain, bg = c.bg2 })
set(0, "FloatBorder",  { fg = c.gutter })
set(0, "CursorLine",   { bg = c.bg2 })
set(0, "CursorLineNr", { fg = c.sl })
set(0, "LineNr",       { fg = c.gutter })
set(0, "IblIndent", {
    fg = "#949494",
})
set(0, "IblScope", { fg = "#b0b0b0", bold = true })
set(0, "Visual",       { bg = c.sl })
set(0, "VisualNOS",    { bg = c.sl })
set(0, "Search",       { fg = "#000000", bg = c.warn })
set(0, "IncSearch",    { fg = "#000000", bg = c.str })
set(0, "VertSplit",    { fg = c.gutter })
set(0, "WinSeparator", { fg = c.gutter })
set(0, "Pmenu",        { fg = c.plain, bg = c.bg2 })
set(0, "PmenuSel",     { fg = "#000000", bg = c.tp })
set(0, "PmenuSbar",    { bg = c.bg2 })
set(0, "PmenuThumb",   { bg = c.gutter })
set(0, "StatusLine",   { fg = c.sl,  bg = "#000000" })
set(0, "StatusLineNC", { fg = c.gutter, bg = "#000000" })
set(0, "TabLine",      { fg = c.gutter, bg = "#000000" })
set(0, "TabLineSel",   { fg = c.plain,  bg = "#000000", bold = true })
set(0, "TabLineFill",  { bg = "#000000" })
set(0, "SignColumn",   { bg = c.bg })
set(0, "FoldColumn",   { fg = c.gutter, bg = c.bg })
set(0, "Folded",       { fg = c.cm, bg = c.bg2 })
set(0, "MatchParen",   { fg = c.str, bold = true, underline = true })
set(0, "NonText",      { fg = c.gutter })
set(0, "SpecialKey",   { fg = c.gutter })
set(0, "Title",        { fg = c.kw, bold = true })
set(0, "Directory",    { fg = c.tp })

-- Traditional syntax groups
set(0, "Comment",        { fg = c.cm })
set(0, "Constant",       { fg = c.str })
set(0, "String",         { fg = c.str })
set(0, "Character",      { fg = c.str })
set(0, "Number",         { fg = c.str })
set(0, "Boolean",        { fg = c.kw })
set(0, "Float",          { fg = c.str })
set(0, "Identifier",     { fg = c.plain })
set(0, "Function",       { fg = c.plain })
set(0, "Statement",      { fg = c.kw })
set(0, "Conditional",    { fg = c.kw })
set(0, "Repeat",         { fg = c.kw })
set(0, "Label",          { fg = c.kw })
set(0, "Operator",       { fg = c.plain })
set(0, "Keyword",        { fg = c.kw })
set(0, "Exception",      { fg = c.kw })
set(0, "PreProc",        { fg = c.dc })
set(0, "Include",        { fg = c.kw })
set(0, "Define",         { fg = c.kw })
set(0, "Macro",          { fg = c.dc })
set(0, "PreCondit",      { fg = c.kw })
set(0, "Type",           { fg = c.tp })
set(0, "StorageClass",   { fg = c.kw })
set(0, "Structure",      { fg = c.tp })
set(0, "Typedef",        { fg = c.tp })
set(0, "Special",        { fg = c.dc })
set(0, "SpecialChar",    { fg = c.str })
set(0, "Tag",            { fg = c.kw })
set(0, "Delimiter",      { fg = c.plain })
set(0, "SpecialComment", { fg = c.cm, italic = true })
set(0, "Debug",          { fg = c.err })
set(0, "Underlined",     { underline = true })
set(0, "Error",          { fg = c.err })
set(0, "Todo",           { fg = "#000000", bg = c.warn, bold = true })

-- Treesitter groups
set(0, "@comment",               { fg = c.cm })
set(0, "@comment.documentation", { fg = c.cm })
set(0, "@keyword",               { fg = c.kw })
set(0, "@keyword.import",        { fg = c.kw })
set(0, "@keyword.function",      { fg = c.kw })
set(0, "@keyword.return",        { fg = c.kw })
set(0, "@keyword.operator",      { fg = c.kw })
set(0, "@keyword.conditional",   { fg = c.kw })
set(0, "@keyword.repeat",        { fg = c.kw })
set(0, "@keyword.exception",     { fg = c.kw })
set(0, "@keyword.coroutine",     { fg = c.kw })
set(0, "@string",                { fg = c.str })
set(0, "@string.documentation",  { fg = c.str })
set(0, "@string.escape",         { fg = c.dc })
set(0, "@string.special",        { fg = c.dc })
set(0, "@number",                { fg = c.str })
set(0, "@number.float",          { fg = c.str })
set(0, "@boolean",               { fg = c.kw })
set(0, "@constant",              { fg = c.plain })
set(0, "@constant.builtin",      { fg = c.kw })
set(0, "@type",                  { fg = c.tp })
set(0, "@type.builtin",          { fg = c.tp })
set(0, "@type.definition",       { fg = c.tp })
set(0, "@function",              { fg = c.plain })
set(0, "@function.call",         { fg = c.plain })
set(0, "@function.builtin",      { fg = c.tp })
set(0, "@function.method",       { fg = c.plain })
set(0, "@function.method.call",  { fg = c.plain })
set(0, "@attribute",             { fg = c.dc })
set(0, "@attribute.builtin",     { fg = c.dc })
set(0, "@variable",              { fg = c.plain })
set(0, "@variable.builtin",      { fg = c.kw })
set(0, "@variable.parameter",    { fg = c.plain })
set(0, "@variable.member",       { fg = c.plain })
set(0, "@module",                { fg = c.plain })
set(0, "@namespace",             { fg = c.plain })
set(0, "@operator",              { fg = c.plain })
set(0, "@punctuation.bracket",   { fg = c.plain })
set(0, "@punctuation.delimiter", { fg = c.plain })
set(0, "@punctuation.special",   { fg = c.dc })
set(0, "@tag",                   { fg = c.kw })
set(0, "@tag.attribute",         { fg = c.tp })
set(0, "@tag.delimiter",         { fg = c.plain })
set(0, "@markup.heading",        { fg = c.kw, bold = true })
set(0, "@markup.raw",            { fg = c.str })
set(0, "@markup.link",           { fg = c.tp })
set(0, "@markup.link.label",     { fg = c.kw })
set(0, "@markup.italic",         { italic = true })
set(0, "@markup.strong",         { bold = true })

-- Diagnostics
set(0, "DiagnosticError",            { fg = c.err })
set(0, "DiagnosticWarn",             { fg = c.warn })
set(0, "DiagnosticInfo",             { fg = c.info })
set(0, "DiagnosticHint",             { fg = c.hint })
set(0, "DiagnosticUnderlineError",   { undercurl = true, sp = c.err })
set(0, "DiagnosticUnderlineWarn",    { undercurl = true, sp = c.warn })
set(0, "DiagnosticUnderlineInfo",    { undercurl = true, sp = c.info })
set(0, "DiagnosticUnderlineHint",    { undercurl = true, sp = c.hint })
set(0, "DiagnosticVirtualTextError", { fg = c.err })
set(0, "DiagnosticVirtualTextWarn",  { fg = c.warn })
set(0, "DiagnosticVirtualTextInfo",  { fg = c.info })
set(0, "DiagnosticVirtualTextHint",  { fg = c.hint })
set(0, "DiagnosticSignError",        { fg = c.err })
set(0, "DiagnosticSignWarn",         { fg = c.warn })
set(0, "DiagnosticSignInfo",         { fg = c.info })
set(0, "DiagnosticSignHint",         { fg = c.hint })
set(0, "LspReferenceText",           { bg = c.sel })
set(0, "LspReferenceRead",           { bg = c.sel })
set(0, "LspReferenceWrite",          { bg = c.sel, underline = true })

-- Trouble.nvim
set(0, "TroubleNormal",   { fg = c.plain, bg = c.bg })
set(0, "TroubleText",     { fg = c.plain })
set(0, "TroubleCount",    { fg = c.kw })
set(0, "TroubleSource",   { fg = c.cm })
set(0, "TroubleLocation", { fg = c.cm })

-- nvim-cmp
set(0, "CmpItemAbbr",           { fg = c.plain })
set(0, "CmpItemAbbrMatch",      { fg = c.kw, bold = true })
set(0, "CmpItemAbbrMatchFuzzy", { fg = c.kw })
set(0, "CmpItemKindText",       { fg = c.plain })
set(0, "CmpItemKindFunction",   { fg = c.plain })
set(0, "CmpItemKindMethod",     { fg = c.plain })
set(0, "CmpItemKindVariable",   { fg = c.plain })
set(0, "CmpItemKindKeyword",    { fg = c.kw })
set(0, "CmpItemKindClass",      { fg = c.tp })
set(0, "CmpItemKindModule",     { fg = c.tp })
set(0, "CmpItemKindSnippet",    { fg = c.dc })
set(0, "CmpItemMenu",           { fg = c.cm })

set(0, "pythonBuiltin", { fg = c.tp })
set(0, "@function.builtin.python", { fg = c.tp })
