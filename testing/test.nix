{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) prefixKeys sourceAttrs;
  inherit (lib) baseNameOf;
in
{
  options.programs.opencode.skillPaths = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [ ];
    description = "List of skill paths to enable";
  };

  config = lib.mkIf (config.programs.opencode.skillPaths != [ ]) {
    programs.opencode.skills = lib.pipe null [
      (_: lib.genAttrs' config.programs.opencode.skillPaths (sp: lib.nameValuePair (baseNameOf sp) (sp)))
    ];
  };
}
