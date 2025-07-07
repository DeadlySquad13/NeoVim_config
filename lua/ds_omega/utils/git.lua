--- Utils related to git.
local git = {}

function git.get_current_branch_name()
    local res = vim
        .system({ 'git', 'branch', '--show-current' }, { capture_output = true })
        :wait()

    -- Stdout has \n at the end.
    return string.sub(res.stdout, 1, -2)
end

-- TODO: I think there was special command for that in git.
-- Just `origin/HEAD`?
--- Get default branch or the current repository.
---@return 'master' | 'main'
function git.get_default_branch_name()
    local res = vim
        .system({ 'git', 'rev-parse', '--verify', 'main' }, { capture_output = true })
        :wait()
    return res.code == 0 and 'main' or 'master'
end

-- REFACTOR: 100% we already have this function implemented in other modules.
-- For instance, in lsp.
--- Get current working directory of the current git repository.
---@return string
function git.get_git_cwd()
    local res = vim
        .system({ 'git', 'rev-parse', '--show-toplevel' }, { capture_output = true })
        :wait()

    -- Stdout has \n at the end.
    local current_git_cwd = string.sub(res.stdout, 1, -2)

    return current_git_cwd
end

--- Utils special to gitflow in our projects.
git.flow = {}

--- Get feature branch that corresponds to the current branch.
---@return string
function git.flow.get_feature_branch_name()
    return 'feature/' .. git.get_current_branch_name()
end

--- Get epic branch that corresponds to the current branch.
-- Assumes that we work in a worktree flow with epic branch selected in 'Epic' worktree.
---@return string
function git.flow.get_epic_branch_name()
    local current_worktree_path = git.get_git_cwd()

    local epic_worktree_path = vim.fs.joinpath(current_worktree_path, '../Epic')

    local res = vim
        .system({ 'git', '-C', epic_worktree_path, 'rev-parse', '--abbrev-ref', 'HEAD' }, { capture_output = true })
        :wait()
    --    git -C /path/to/worktree rev-parse --abbrev-ref HEAD

    -- Stdout has \n at the end.
    local current_epic_branch_name = string.sub(res.stdout, 1, -2)

    return current_epic_branch_name
end

return git
