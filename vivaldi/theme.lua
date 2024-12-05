local vivaldi = require('vivaldi.colors').vivaldi()

local theme = {}
local underdouble = 'underdouble'
local underdot = 'underdotted'
local underdash = 'underdashed'
local config = require('vivaldi.config').options
local alt = vivaldi.bg_alt
local floating_bg = vivaldi.bg_alt
local darker = vivaldi.darker
if config.disable.background == true then
  vivaldi.bg = vivaldi.none
  vivaldi.bg_alt = vivaldi.none
  vivaldi.bg_darker = vivaldi.none
end

if config.disable.floating_bg == true then
  vivaldi.floating = vivaldi.none
  floating_bg = vivaldi.none
else
  vivaldi.floating = floating_bg
end
local s = require('vivaldi.functions').styler

theme.loadSyntax = function()
  -- Syntax highlight groups
  local syntax = {
    Type = { fg = vivaldi.type }, -- int, long, char, etc.
    StorageClass = { fg = vivaldi.class }, -- static, register, volatile, etc.
    Structure = { fg = vivaldi.structure }, -- struct, union, enum, etc.
    Struct = { link = 'Structure' }, -- struct, union, enum, etc.
    Constant = { fg = vivaldi.const }, -- any constant
    String = { fg = vivaldi.string }, -- Any string
    Character = { fg = vivaldi.orange }, -- any character constant: 'c', '\n'
    Number = { fg = vivaldi.number }, -- a number constant: 5
    Boolean = { fg = vivaldi.bool, style = s('italic') }, -- a boolean constant: TRUE, false
    Float = { fg = vivaldi.float }, -- a floating point constant: 2.3e10
    Statement = { fg = vivaldi.statement }, -- any statement
    Label = { fg = vivaldi.label }, -- case, default, etc.
    Operator = { fg = vivaldi.operator }, -- sizeof", "+", "*", etc.
    Exception = { fg = vivaldi.purple2 }, -- try, catch, throw
    PreProc = { fg = vivaldi.preproc or vivaldi.purple }, -- generic Preprocessor
    Include = { fg = vivaldi.include or vivaldi.blue }, -- preprocessor #include
    Define = { fg = vivaldi.pink }, -- preprocessor #define
    Macro = { fg = vivaldi.cyan }, -- same as Define
    Typedef = { fg = vivaldi.typedef }, -- A typedef
    PreCondit = { fg = vivaldi.precondit, style = s('bold') }, -- preprocessor #if, #else, #endif, etc.
    Special = { fg = vivaldi.red }, -- any special symbol
    SpecialChar = { link = 'Define' }, -- special character in a constant
    Tag = { fg = vivaldi.lime }, -- you can use CTRL-] on this
    Delimiter = { fg = vivaldi.blue1 }, -- character that needs attention like , or .
    Debug = { link = 'Special' }, -- debugging statements
    Underlined = { fg = vivaldi.link, style = s('undercurl'), sp = vivaldi.blue }, -- text that stands out, HTML links
    Ignore = { fg = vivaldi.disabled }, -- left blank, hidden
    Error = { fg = vivaldi.error, style = s('bold', 'undercurl'), sp = vivaldi.pink }, -- any erroneous construct
    Todo = { fg = vivaldi.yellow, bg = vivaldi.bg_alt, style = vivaldi.highlight_style }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    MsgArea = { fg = vivaldi.string }, -- Any string

    htmlLink = { fg = vivaldi.link, style = s('underline'), sp = vivaldi.blue },
    htmlH1 = { fg = vivaldi.cyan, style = s('bold', underdouble) },
    htmlH2 = { fg = vivaldi.red, style = s('bold') },
    htmlH3 = { fg = vivaldi.green, style = s('bold') },
    htmlH4 = { fg = vivaldi.yellow, style = s('bold') },
    htmlH5 = { fg = vivaldi.br_purple, style = s('bold') },
    markdownH1 = { link = 'htmlH1' },
    markdownH2 = { link = 'htmlH2' },
    markdownH3 = { link = 'htmlH3' },
    markdownH1Delimiter = { link = 'Macro' },
    markdownH2Delimiter = { link = 'Special' },
    markdownH3Delimiter = { link = 'Question' },
  }

  -- Options:
  local config = require('vivaldi.config').options
  -- Italic comments
  if config.italics.comments == true then
    syntax.Comment = { fg = vivaldi.comments, style = s('italic') } -- italic comments
  else
    syntax.Comment = { fg = vivaldi.comments } -- normal comments
  end

  -- Italic string
  if config.italics.string == true then
    syntax.String.style = s('italic')
  end

  -- Italic Keywords
  if config.italics.keywords == true then
    syntax.Conditional = {
      fg = vivaldi.condition,
      style = s('italic'),
    } -- italic if, then, else, endif, switch, etc.
    syntax.Keyword = {
      fg = vivaldi.keyword,
      style = s('italic'),
      bold = true,
    } -- italic for, do, while, etc.
    syntax.Repeat = {
      fg = vivaldi.condition,
      style = s('italic'),
    } -- italic any other keyword
  else
    syntax.Conditional = { fg = vivaldi.condition, style = s('bold') } -- normal if, then, else, endif, switch, etc.
    syntax.Keyword = { fg = vivaldi.keyword, style = s('bold') } -- normal for, do, while, etc.
    syntax.Repeat = { link = 'PreProc' } -- normal any other keyword
  end

  -- Italic Function names
  if config.italics.functions == true then
    syntax.Function = {
      fg = vivaldi.func,
      style = s('italic', 'bold'),
    } -- italic function names
  else
    syntax.Function = { fg = vivaldi.func, style = s('bold') } -- normal function names
  end
  syntax.Method = { link = 'Function' }

  if config.italics.variables == true then
    syntax.Identifier = { fg = vivaldi.variable, style = s('italic') } -- Variable names that are defined by the languages, like `this` or `self`.
  else
    syntax.Identifier = { fg = vivaldi.variable } -- Variable names that are defined by the languages, like `this` or `self`.
  end
  return syntax
end

theme.loadEditor = function()
  -- Editor highlight groups
  local lineNrStyle = s('bold')
  if vim.wo.relativenumber == true or vim.o.relativenumber == true then
    lineNrstyle = s('bold', underdot)
  end

  local editor = {
    FloatShadow = { bg = vivaldi.darker, blend = 36 },
    FloatShadowThrough = { bg = vivaldi.darker, blend = 66 },
    ColorColumn = { bg = vivaldi.active }, --  used for the columns set with 'colorcolumn'
    Conceal = { link = 'Ignore' }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = vivaldi.cursor, style = s('reverse') }, -- the character under the cursor
    CursorIM = { fg = vivaldi.cursor, style = s('reverse') }, -- like Cursor, but used when in IME mode
    Directory = { fg = vivaldi.directory }, -- directory names (and other special names in listings)
    DiffAdd = { bg = vivaldi.less_active, style = s('bold', underdash) }, -- diff mode: Added line
    DiffChange = {
      bg = vivaldi.active,
    }, --  diff mode: Changed line
    DiffDelete = { bg = vivaldi.less_active, fg = vivaldi.comments, style = s('strikethrough') }, -- diff mode: Deleted line
    DiffText = { bg = vivaldi.darkgreen2, style = s('bold,reverse') }, -- diff mode: Changed text within a changed line
    TermCursor = { link = 'Cursor' },
    TermCursorNC = { link = 'Cursor' },
    EndOfBuffer = { link = 'Ignore' }, -- ~ lines at the end of a buffer
    ErrorMsg = { link = 'DiagnosticError' }, -- error messages
    Folded = { fg = vivaldi.link, style = s('bold') },
    FoldColumn = { link = 'Ignore' },
    IncSearch = { fg = vivaldi.inc_search, style = s('bold', 'reverse') },
    CurSearch = { fg = vivaldi.search_fg, style = s('bold', 'reverse') },
    LineNr = { fg = vivaldi.line_numbers, style = lineNrStyle },
    LineNrAbove = { fg = vivaldi.disabled },
    LineNrBelow = { link = 'LineNrAbove' },
    CursorLineNr = { link = 'ModeMsg', style = lineNrStyle },
    MatchParen = {
      fg = vivaldi.yellow,
      bg = vivaldi.active,
      style = s('bold', 'underline'),
    },
    ModeMsg = { fg = vivaldi.accent },
    MoreMsg = { link = 'ModeMsg' },
    NonText = { link = 'Ignore' },
    Pmenu = { fg = vivaldi.text, bg = vivaldi.contrast },
    PmenuKind = { fg = vivaldi.green, bg = vivaldi.contrast },
    PmenuExtra = { fg = vivaldi.paleblue, bg = vivaldi.contrast },
    PmenuSel = {
      fg = vivaldi.accent,
      bg = vivaldi.more_active,
      style = vivaldi.highlight_style,
    },
    PmenuSbar = { fg = vivaldi.text, bg = vivaldi.contrast },
    PmenuThumb = { bg = vivaldi.accent },
    Question = { fg = vivaldi.green },
    QuickFixLine = { fg = vivaldi.highlight, bg = vivaldi.white, style = s('reverse') },
    qfLineNr = { fg = vivaldi.highlight, bg = vivaldi.white, style = s('reverse') },
    Search = {
      fg = vivaldi.search_fg,
      bg = vivaldi.search_bg,
      style = vivaldi.search_style,
    },
    SpecialKey = { link = 'PreProc' },
    SpellBad = { fg = vivaldi.orange, style = s('undercurl'), sp = vivaldi.red },
    SpellCap = { fg = vivaldi.blue, style = s('undercurl'), sp = vivaldi.violet },
    SpellLocal = { fg = vivaldi.cyan, style = underdot },
    SpellRare = {
      fg = vivaldi.purple,
      style = underdot,
      sp = vivaldi.darkred,
    },
    Rare = { link = 'SpellRare' },
    StatusLine = { fg = vivaldi.accent, bg = vivaldi.active },
    StatusLineNC = { fg = vivaldi.text, bg = vivaldi.less_active },
    StatusLineTerm = { fg = vivaldi.fg, bg = vivaldi.active },
    StatusLineTermNC = { fg = vivaldi.text, bg = vivaldi.less_active },
    TabLineFill = { fg = vivaldi.fg },
    TablineSel = { bg = vivaldi.accent, fg = vivaldi.dark },
    Tabline = { fg = vivaldi.fg },
    Title = { fg = vivaldi.title, style = s('bold') },
    Visual = { bg = vivaldi.selection },
    VisualNOS = { link = 'Visual' },
    VisualNC = { link = 'Visual' },
    NormalNC = { link = 'Normal' }, -- normal text and background color
    WarningMsg = { fg = vivaldi.yellow },
    WildMenu = { fg = vivaldi.orange, style = s('bold') },
    CursorColumn = { bg = vivaldi.active },
    CursorLine = { bg = vivaldi.less_active },
    ToolbarLine = { fg = vivaldi.fg, bg = vivaldi.bg_alt },
    ToolbarButton = { fg = vivaldi.fg, style = s('bold') },
    NormalMode = { fg = vivaldi.accent, bg = vivaldi.bg, style = s('reverse') },
    InsertMode = { fg = vivaldi.green, style = s('reverse') },
    ReplacelMode = { fg = vivaldi.red, style = s('reverse') },
    VisualMode = { fg = vivaldi.purple, style = s('reverse') },
    CommandMode = { fg = vivaldi.gray, style = s('reverse') },
    Warnings = { link = 'WarningMsg' },

    healthError = { link = 'DiagnosticError' },
    healthSuccess = { link = 'Question' },
    healthWarning = { link = 'WarningMsg' },

    -- Notify
    NotifyBackground = { link = 'Normal' },
    -- Dashboard
    DashboardShortCut = { link = 'Special' },
    DashboardHeader = { link = 'Comment' },
    DashboardCenter = { fg = vivaldi.accent },
    DashboardFooter = { fg = vivaldi.green, style = s('italic') },
  }

  -- Options:
  if config.style.darker_contrast == true and vivaldi.bg_darker then
    editor.Normal = { fg = vivaldi.fg, bg = vivaldi.bg_darker } -- normal text and background color
    editor.SignColumn = { fg = vivaldi.fg, bg = vivaldi.bg_darker }
    floating_bg = darker
  else
    editor.Normal = { fg = vivaldi.fg, bg = vivaldi.bg } -- normal text and background color
    editor.SignColumn = { fg = vivaldi.fg, bg = vivaldi.bg }
  end

  if config.disable.floating_bg == true then
    floating_bg = vivaldi.none
  end

  editor.FloatBorder = { fg = vivaldi.comments, bg = floating_bg }
  editor.NormalFloat = { fg = vivaldi.text, bg = floating_bg }
  -- Remove window split borders
  if config.borders == true then
    editor.VertSplit = { fg = vivaldi.border }
  else
    editor.VertSplit = { fg = vivaldi.bg }
  end

  editor.WinSeparator = { link = 'VertSplit' }
  -- Set End of Buffer lines (~)
  if config.hide_eob == true then
    editor.EndOfBuffer = { fg = vivaldi.bg } -- ~ lines at the end of a buffer
  else
    editor.EndOfBuffer = { link = 'Ignore' } -- ~ lines at the end of a buffer
  end
  return editor
end

theme.loadTerminal = function()
  vim.g.terminal_color_0 = vivaldi.black
  vim.g.terminal_color_1 = vivaldi.red
  vim.g.terminal_color_2 = vivaldi.green
  vim.g.terminal_color_3 = vivaldi.yellow
  vim.g.terminal_color_4 = vivaldi.blue
  vim.g.terminal_color_5 = vivaldi.purple
  vim.g.terminal_color_6 = vivaldi.cyan
  vim.g.terminal_color_7 = vivaldi.white
  vim.g.terminal_color_8 = vivaldi.gray
  vim.g.terminal_color_9 = vivaldi.br_red
  vim.g.terminal_color_10 = vivaldi.br_green
  vim.g.terminal_color_11 = vivaldi.br_yellow
  vim.g.terminal_color_12 = vivaldi.br_blue
  vim.g.terminal_color_13 = vivaldi.br_purple
  vim.g.terminal_color_14 = vivaldi.br_cyan
  vim.g.terminal_color_15 = vivaldi.br_white

  vim.g.terminal_color_foreground = vivaldi.fg
  vim.g.terminal_color_background = vivaldi.bg
end

theme.loadLSP = function()
  -- Lsp highlight groups
  return {
    DiagnosticHint = { fg = vivaldi.darkblue },
    DiagnosticTruncateLine = { fg = vivaldi.fg },
    DiagnosticError = { link = 'Special', style = s('bold') }, -- used for "Error" diagnostic virtual text
    DiagnosticSignError = { link = 'DiagnosticError' }, -- used for "Error" diagnostic signs in sign column
    DiagnosticFloatingError = { link = 'DiagnosticError' }, -- used for "Error" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextError = { link = 'DiagnosticError' }, -- Virtual text "Error"
    DiagnosticUnderlineError = { style = s('bold', 'undercurl'), sp = vivaldi.error }, -- used to underline "Error" diagnostics.
    DiagnosticWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic signs in sign column
    DiagnosticSignWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic signs in sign column
    DiagnosticFloatingWarn = { link = 'WarningMsg' }, -- used for "Warning" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextWarn = { fg = vivaldi.darkcyan }, -- Virtual text "Warning"
    DiagnosticUnderlineWarn = { style = s('underline'), sp = vivaldi.yellow }, -- used to underline "Warning" diagnostics.
    DiagnosticInfo = { link = 'ModeMsg' }, -- used for "Information" diagnostic virtual text
    DiagnosticSignInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic signs in sign column
    DiagnosticFloatingInfo = { link = 'DiagnosticInfo' }, -- used for "Information" diagnostic messages in the diagnostics float
    DiagnosticVirtualTextInfo = { fg = vivaldi.gray5 }, -- Virtual text "Information"
    DiagnosticUnderlineInfo = { style = underdash, sp = vivaldi.darkblue }, -- used to underline "Information" diagnostics.
    DiagnosticDefaultHint = { fg = vivaldi.link }, -- used for "Hint" diagnostic virtual text
    DiagnosticSignHint = { link = 'DiagnosticDefaultHint' }, -- used for "Hint" diagnostic signs in sign column
    DiagnosticVirtualTextHint = { fg = vivaldi.disabled }, -- Virtual text "Hint"
    DiagnosticUnderlineHint = { style = underdot, sp = vivaldi.darkblue }, -- used to underline "Hint" diagnostics.

    LspReferenceText = { style = s('bold', 'undercurl'), bg = vivaldi.less_active, sp = 'green' }, -- used for highlighting "text" references
    LspReferenceRead = {
      bg = vivaldi.less_active,
      style = s('bold', 'undercurl'),
      sp = 'green',
    }, -- used for highlighting "read" references
    LspReferenceWrite = {
      bg = vivaldi.less_active,
      style = s('bold', underdouble),
      sp = 'yellow',
    }, -- used for highlighting "write" references
    LspSignatureActiveParameter = {
      fg = vivaldi.search_fg,
      bg = vivaldi.darkblue,
      style = s('bold', underdouble),
      sp = 'violet',
    },
    LspCodeLens = { link = 'DiagnosticHint' },
    LspInlayHint = { fg = vivaldi.gray7 },
  }
end

theme.loadTreesitter = function()
  return require('vivaldi.ts').link_v8(vivaldi, underdouble)
end

theme.loadLSPV9 = function()
  if vim.fn.has('nvim-0.9') then
    return require('vivaldi.lsp').link_v9(vivaldi, underdouble)
  end
end

theme.loadPlugins = function()
  -- Plugins highlight groups

  local plugins = {

    -- LspTrouble
    TroubleText = { fg = vivaldi.text, bg = vivaldi.sidebar },
    TroubleCount = { fg = vivaldi.purple, bg = vivaldi.sidebar },
    TroubleNormal = { fg = vivaldi.fg, bg = vivaldi.sidebar },
    TroubleSignError = { fg = vivaldi.error, bg = vivaldi.sidebar },
    TroubleSignWarning = { fg = vivaldi.yellow, bg = vivaldi.sidebar },
    TroubleSignInformation = { link = 'PreCondit', bg = vivaldi.sidebar },
    TroubleSignHint = { fg = vivaldi.purple, bg = vivaldi.sidebar },
    TroubleFoldIcon = { fg = vivaldi.accent, bg = vivaldi.sidebar },
    TroubleIndent = { fg = vivaldi.border, bg = vivaldi.sidebar },
    TroubleLocation = { fg = vivaldi.disabled, bg = vivaldi.sidebar },
    -- Nvim-Compe
    CompeDocumentation = { fg = vivaldi.text, bg = vivaldi.contrast },
    CmpDocumentation = { fg = vivaldi.text, bg = vivaldi.contrast },

    Hlargs = { link = 'WarningMsg' },

    -- Diff
    diffAdded = { bg = vivaldi.active },
    diffRemoved = { link = 'Special' },
    diffChanged = { bg = vivaldi.active },
    diffOldFile = { link = 'Text' },
    diffNewFile = { fg = vivaldi.title },
    diffFile = { fg = vivaldi.gray },
    diffLine = { link = 'Macro' },
    diffIndexLine = { link = 'PreProc' },

    -- Neogit
    NeogitBranch = { link = 'PreCondit' },
    NeogitRemote = { link = 'PreProc' },
    NeogitHunkHeader = { fg = vivaldi.fg, bg = vivaldi.highlight },
    NeogitHunkHeaderHighlight = { fg = vivaldi.blue, bg = vivaldi.contrast },
    NeogitDiffContextHighlight = { fg = vivaldi.text, bg = vivaldi.contrast },
    NeogitDiffDeleteHighlight = { link = 'DiffDelete' },
    NeogitDiffAddHighlight = { link = 'Question' },

    -- GitGutter
    GitGutterAdd = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|
    GitGutterChangeDelete = { link = 'GitGutterDelete' }, -- diff mode: Changed line |diff.txt|

    -- GitSigns
    GitSignsAdd = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsAddNr = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsAddLn = { link = 'Question' }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeNr = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeLn = { link = 'Include' }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteNr = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteLn = { link = 'Special' }, -- diff mode: Deleted line |diff.txt|

    GitSignsAddInline = { style = underdot, sp = vivaldi.green }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteInline = { style = s('strikethrough'), sp = vivaldi.error }, -- diff mode: Deleted line |diff.txt|
    GitSignsChangeInline = { style = underdot, sp = vivaldi.br_blue }, -- diff mode: Deleted line |diff.txt|
    -- Telescope
    TelescopeNormal = { fg = vivaldi.text, bg = floating_bg },
    TelescopePromptBorder = { fg = vivaldi.cyan, bg = floating_bg },
    TelescopeResultsBorder = { fg = vivaldi.preproc, bg = floating_bg },
    TelescopePreviewBorder = { fg = vivaldi.green, bg = floating_bg },
    TelescopeSelectionCaret = { link = 'PreProc' },
    TelescopeSelection = { bg = vivaldi.active, style = s('bold') },
    TelescopeMatching = { link = 'Macro' },

    -- NvimTree
    NvimTreeRootFolder = { fg = vivaldi.title, style = s('italic') },
    NvimTreeFolderName = { link = 'Identifier' },
    NvimTreeFolderIcon = { fg = vivaldi.accent },
    NvimTreeEmptyFolderName = { link = 'Ignore' },
    NvimTreeOpenedFolderName = { fg = vivaldi.accent, style = s('italic') },
    NvimTreeIndentMarker = { link = 'Ignore' },
    NvimTreeGitDirty = { link = 'Include' },
    NvimTreeGitNew = { link = 'Tag' },
    NvimTreeGitStaged = { link = 'Comment' },
    NvimTreeGitDeleted = { link = 'Special' },
    NvimTreeOpenedFile = { fg = vivaldi.accent },
    NvimTreeImageFile = { link = 'WarningMsg' },
    NvimTreeMarkdownFile = { link = 'Define' },
    NvimTreeExecFile = { link = 'Question' },
    NvimTreeSpecialFile = { fg = vivaldi.purple, style = s('underline') },
    LspDiagnosticsError = { link = 'DiagnosticError' },
    LspDiagnosticsWarning = { link = 'WarningMsg' }, -- LspDiagXXX deprecated
    DiagnosticsWarning = { link = 'WarningMsg' },
    LspDiagnosticsInformation = { link = 'PreCondit' },
    DiagnosticsInformation = { link = 'PreCondit' },
    LspDiagnosticsHint = { link = 'PreProc' },
    DiagnosticsHint = { link = 'PreProc' },

    -- WhichKey
    WhichKey = { fg = vivaldi.accent, style = s('bold') },
    WhichKeyGroup = { link = 'Identifier' },
    WhichKeyDesc = { fg = vivaldi.blue, style = s('italic') },
    WhichKeySeperator = { fg = vivaldi.fg },
    WhichKeyFloating = { bg = vivaldi.floating },
    WhichKeyFloat = { bg = vivaldi.floating },

    -- LspSaga
    LspFloatWinNormal = { bg = vivaldi.contrast },
    LspFloatWinBorder = { link = 'PreProc' },
    LspSagaBorderTitle = { link = 'Macro' },
    LspSagaHoverBorder = { link = 'PreCondit' },
    LspSagaRenameBorder = { link = 'Question' },
    LspSagaDefPreviewBorder = { link = 'Question' },
    LspSagaCodeActionBorder = { link = 'Include' },
    LspSagaFinderSelection = { link = 'Question' },
    LspSagaCodeActionTitle = { link = 'PreCondit' },
    LspSagaCodeActionContent = { link = 'PreProc' },
    LspSagaSignatureHelpBorder = { link = 'Define' },
    ReferencesCount = { link = 'PreProc' },
    DefinitionCount = { link = 'PreProc' },
    DefinitionIcon = { link = 'Include' },
    ReferencesIcon = { link = 'Include' },
    TargetWord = { link = 'Macro' },
    FocusedSymbol = { bg = vivaldi.selection },
    SymbolsOutlineConnector = { fg = vivaldi.border },
    -- BufferLine
    BufferLineFill = { bg = vivaldi.bg_alt },
    BufferLineBackground = { bg = vivaldi.bg },

    -- Sneak
    Sneak = { bg = vivaldi.accent, style = s('reverse') },
    SneakScope = { bg = vivaldi.selection },

    -- Indent Blankline
    IblIndent = { fg = vivaldi.purple },
    IblScope = { fg = vivaldi.purple, style = s('bold') },
    IndentBlanklineIndent1 = { fg = vivaldi.purple, style = s('nocombine') },
    IndentBlanklineIndent2 = { fg = vivaldi.blue, style = s('nocombine') },
    IndentBlanklineIndent3 = { fg = vivaldi.green, style = s('nocombine') },
    IndentBlanklineIndent4 = { fg = vivaldi.yellow, style = s('nocombine') },
    IndentBlanklineIndent5 = { fg = vivaldi.orange, style = s('nocombine') },
    IndentBlanklineIndent6 = { fg = vivaldi.red, style = s('nocombine') },

    -- Nvim dap
    DapBreakpoint = { link = 'Special' },
    DapStopped = { link = 'Question' },

    -- Hop
    HopNextKey = { fg = vivaldi.red, style = s('bold', 'undercurl') },
    HopNextKey1 = { fg = vivaldi.br_purple, style = s('bold', 'undercurl') },
    HopNextKey2 = { fg = vivaldi.blue, style = s('bold', 'undercurl') },
    HopUnmatched = { fg = vivaldi.comments },
    -- Flash
    FlashLabel = { link = 'HopNextKey' },
    FlashBackdrop = { link = 'HopUnmatched' },

    -- Leap
    LeapMatch = {
      fg = vivaldi.search_fg,
      bg = vivaldi.search_bg,
    },
    LeapLabelPrimary = { fg = vivaldi.purple, style = s('bold') },
    LeapLabelSecondary = { fg = vivaldi.blue, style = s('bold') },
    LeapBackdrop = { fg = vivaldi.comments },

    -- Cmp
    CmpItemAbbrDeprecated = { fg = vivaldi.lightgray, style = s('strikethrough') },
    CmpItemAbbrMatch = { fg = vivaldi.search_fg, bg = vivaldi.search_bg },
    CmpItemAbbrMatchFuzzy = { fg = vivaldi.search_fg, bg = vivaldi.search_bg },
    CmpItemKindVariable = { fg = vivaldi.variable },
    CmpItemKindInterface = { fg = vivaldi.br_blue },
    CmpItemKindText = { fg = vivaldi.fg },
    CmpItemKindFunction = { fg = vivaldi.func },
    CmpItemKindMethod = { fg = vivaldi.method },
    CmpItemKindKeyword = { fg = vivaldi.keyword },
    -- Fern
    FernBranchText = { link = 'Include' },
  }

  -- Options:

  -- Disable nvim-tree background
  if config.style.disable_background == true then
    plugins.NvimTreeNormal = { link = 'Normal' }
  else
    plugins.NvimTreeNormal = { fg = vivaldi.fg, bg = vivaldi.sidebar }
  end

  return plugins
end
return theme
