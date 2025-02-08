return {
	"frankroeder/parrot.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "ld", "<Cmd>'<,'>PrtDebug<CR>", mode = "v" },
		{ "le", "<Cmd>'<,'>PrtExplain<CR>", mode = "v" },
		{ "lc", "<Cmd>PrtChatNew tabnew<CR>" },
		{
			"ldr",
			function()
				require("leap.treesitter").select()

				local line1 = vim.fn.getpos(".")[2]
				local line2 = vim.fn.getpos("v")[2]
				require("parrot.config").call_hook("Debug", { range = 2, line1 = line1, line2 = line2 })
			end,
		},
		{
			"ler",
			function()
				require("leap.treesitter").select()

				local line1 = vim.fn.getpos(".")[2]
				local line2 = vim.fn.getpos("v")[2]
				require("parrot.config").call_hook("Explain", { range = 2, line1 = line1, line2 = line2 })
			end,
		},
	},
	config = function()
		vim.api.nvim_set_hl(0, "CursorLine", {})

		require("parrot").setup({
			providers = {
				gemini = {
					api_key = os.getenv("GEMINI_API_KEY"),
				},
			},

			chat_free_cursor = true,
			chat_prompt_buf_type = true,
			command_auto_select_response = false,
			style_popup_border = "rounded",

			-- Just defaults that I have to eventually overwrite
			chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
			chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
			chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
			chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },

			hooks = {
				Debug = function(prt, params)
					local template = [[
I want you to act as {{filetype}} expert.
Review the following code, carefully examine it, and report potential
bugs and edge cases alongside solutions to resolve them.
Keep your explanation short and to the point:
Use the markdown format with codeblocks and inline code.

```{{filetype}}
{{selection}}
```]]
					local model_obj = prt.get_model("command")
					prt.Prompt(params, prt.ui.Target.tabnew, model_obj, nil, template)
				end,
				Explain = function(prt, params)
					local template =
						[[You are a precise logical analyzer specializing in finding subtle bugs and edge cases in {{filetype}} code. Use systematic reasoning to examine code through multiple analytical layers.

ANALYSIS METHODOLOGY:

### Layer 1: Logical Flow Analysis
Examine each logical path:
PATH: [Description]
PRECONDITIONS: [Required states]
STEPS:
1. [Operation 1]
   - Assumptions: [List]
   - Possible Issues: [List]
2. [Operation 2]
POSTCONDITIONS: [Expected states]
INVARIANTS: [Must maintain]

### Layer 2: State Management
For each state-modifying operation:
OPERATION: [Name]
CURRENT_STATE: [Before]
MODIFICATIONS:
- Change 1: [What/Why]
- Change 2: [What/Why]
EXPECTED_STATE: [After]
VALIDATION:
- Check 1: [What to verify]
- Check 2: [What to verify]

### Layer 3: Edge Case Analysis
For each component:
COMPONENT: [Name]
EDGE_CASES:
1. [Scenario 1]
   - Input: [Example]
   - Current Behavior: [What happens]
   - Correct Behavior: [What should happen]
   - Fix: [Implementation]

2. [Scenario 2]
   ...

### Layer 4: Error Propagation
Trace each error path:
ERROR_SCENARIO: [Description]
PROPAGATION:
1. [Origin point]
2. [Intermediate handling]
3. [Final resolution]
CURRENT_HANDLING: [Code]
IMPROVED_HANDLING: [Code]

OUTPUT FORMAT:

1. Logical Issues:
ISSUE #[n]:
TYPE: [Category]
SEVERITY: [Critical/High/Medium]
DESCRIPTION: [Clear explanation]
PROOF:
- Precondition: [State]
- Operation: [What happens]
- Result: [Why incorrect]
SOLUTION:
- Fix: [Code]
- Verification: [How to test]

2. State Management Issues:
STATE_ISSUE #[n]:
COMPONENT: [Name]
SCENARIO: [When it occurs]
CURRENT_BEHAVIOR:
- State Changes: [List]
- Problems: [What breaks]
CORRECTION:
- Required Changes: [List]
- Implementation: [Code]

3. Implementation Gaps:
GAP #[n]:
MISSING: [What's needed]
IMPACT: [Why important]
IMPLEMENTATION:
- Requirements: [List]
- Solution: [Code]
- Tests: [Verification]

ITERATION REQUIREMENTS:
1. First Pass: Identify logical flows
2. Second Pass: Find state issues
3. Third Pass: Discover edge cases
4. Fourth Pass: Trace error handling
5. Final Pass: Verify solutions

Remember to:
- Show reasoning chain
- Provide counterexamples
- Include test cases
- Consider side effects
- Document assumptions


# Code to be analyzed
```{{filetype}}
{{selection}}
```]]
					local model = prt.get_model("command")
					prt.Prompt(params, prt.ui.Target.tabnew, model, nil, template)
				end,
			},
		})
	end,
}
