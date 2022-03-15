{ pkgs, lib, config, ... }:

with lib;
with builtins;

let

  cfg = config.vim.markdown;

in

{
  options.vim.markdown = {
    enable = mkEnableOption "Enable markdown support";
  };

  config = mkIf cfg.enable {
    vim.configRC = ''

      "
      " MARKDOWN
      "

      " Treat all .md files as markdown
      autocmd BufNewFile,BufRead *.md set filetype=markdown

      " Set text width
      autocmd FileType markdown setlocal textwidth=100

      " Treat fenced languages as such
      let g:markdown_fenced_languages = ['bash=sh', 'sh', 'html', 'groovy', 'java', 'js=javascript', 'python', 'rust', 'vim']
    '';
  };
}
