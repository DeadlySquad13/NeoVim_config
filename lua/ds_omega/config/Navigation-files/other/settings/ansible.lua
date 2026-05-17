local tasks = {
    target = "/roles/%1/tasks/%2.yml",
    context = "tasks",
}
local handlers = {
    target = "/roles/%1/handlers/%2.yml",
    context = "handlers",
}
local defaults = {
    target = "/roles/%1/defaults/%2.yml",
    context = "defaults",
}
local vars = {
    target = "/roles/%1/vars/%2.yml",
    context = "vars",
}
-- - Usually will have differn files, not yml...
local files = {
    target = "/roles/%1/files/%2.yml",
    context = "files",
}
local templates = {
    target = "/roles/%1/templates/%2.yml",
    context = "templates",
}
local meta = {
    target = "/roles/%1/meta/%2.yml",
    context = "meta",
}

return {
    {
        -- %1 - role name
        -- %2 - feature inside role (usually just 'main')
        pattern = "/roles/(.*)/.*/(.*).yml$",
        target = {
            tasks,
            handlers,
            defaults,
            vars,
            files,
            templates,
            meta,
        },
    },
}
