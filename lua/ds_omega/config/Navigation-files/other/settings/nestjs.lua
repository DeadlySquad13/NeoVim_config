-- TODO: types and constants can be generalized.

local module = {
    target = "/modules/%1/%1.module.ts",
    context = "module",
}
local controller = {
    target = "/modules/%1/%1.controller.ts",
    context = "controller",
}
local mapper = {
    target = "/modules/%1/%1.mapper.ts",
    context = "mapper",
}
local service = {
    target = "/modules/%1/%1.service.ts",
    context = "service",
}
local services = {
    target = "/modules/%1/services/index.ts",
    context = "services",
}
local entity = {
    target = "/modules/%1/%1.entity.ts",
    context = "entity",
}
local entities = {
    target = "/modules/%1/entities/index.ts",
    context = "entities",
}
local dto = {
    target = "/modules/%1/%1.dto.ts",
    context = "dto",
}
local dtos = {
    target = "/modules/%1/dto/index.ts",
    context = "dtos",
}
local guard = {
    target = "/modules/%1/%1.guard.ts",
    context = "guard",
}
local guards = {
    target = "/modules/%1/guards/index.ts",
    context = "guards",
}
local constant = {
    target = "/modules/%1/%1.guard.ts",
    context = "constant",
}
local constants = {
    target = "/modules/%1/guards/index.ts",
    context = "constants",
}
local type = {
    target = "/modules/%1/%1.type.ts",
    context = "type",
}
local types = {
    target = "/modules/%1/types/index.ts",
    context = "types",
}
local decorator = {
    target = "/modules/%1/%1.decorator.ts",
    context = "decorator",
}
local decorators = {
    target = "/modules/%1/decorators/index.ts",
    context = "decorators",
}

return {
    {
        pattern = "/modules/(.*)/.*.ts$",
        target = {
            module,
            controller,
            mapper,
            service,
            services,
            entity,
            entities,
            dto,
            dtos,
            guard,
            guards,
            constant,
            constants,
            type,
            types,
            decorator,
            decorators,
        },
    },
}
