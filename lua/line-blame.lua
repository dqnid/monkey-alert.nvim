local lineBlame = function()
    // TODO: everything
    local mail_blame = os.execute("git blame -e  .githooks/pre-commit")
    local mail_blame_awk = os.execute("git blame -e .githooks/pre-commit | awk '{ print $2 $6}'");
    local test_str = "24a332e7 (<dani.heras@hotmail.com> 2025-09-08 19:42:51 +0200 39) email=$(git config user.email)"
    local results = test_str:match(".*<(.*)>.* ([0-9]+)\)")
    local results = test_str:match(".*<(.*)>.* ([0-9]+)\)")
end

return {
    lineBlame = lineBlame,
}
