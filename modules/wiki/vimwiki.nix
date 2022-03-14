{ pkgs, config, lib, ...}:

with lib;
with builtins;

let

  cfg = config.vim.wiki;

in

{
  options.vim.wiki = {
    enable = mkEnableOption "Enable vimwiki";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ calendar vimwiki ];

    vim.configRC = ''
      set nocompatible

      filetype plugin on
      let g:vimwiki_global_ext = 0
      syntax on

      let nextcloud_notes = {}
      let nextcloud_notes.path = '~/Nextcloud/Notes/'
      let nextcloud_notes.syntax = 'markdown'
      let nextcloud_notes.ext = 'txt'
      let nextcloud_notes.list_margin = 0
      let g:vimwiki_list = [nextcloud_notes]
      let g:vimwiki_dir_link = 'index'

      autocmd FileType vimwiki setlocal spell spelllang=de_ch

      function! VimwikiFindIncompleteTasks()
        lvimgrep /- \[ \]/ %:p
        lopen
      endfunction

      function! VimwikiFindAllIncompleteTasks()
        VimwikiSearch /- \[ \]/
        lopen
      endfunction

      :autocmd FileType vimwiki map wa :call VimwikiFindAllIncompleteTasks()<CR>
      :autocmd FileType vimwiki map wx :call VimwikiFindIncompleteTasks()<CR>

      function! ToggleCalendar()
        execute ":Calendar"
        if exists("g:calendar_open")
          if g:calendar_open == 1
            execute "q"
            unlet g:calendar_open
          else
            g:calendar_open = 1
          end
        else
          let g:calendar_open = 1
        end
      endfunction
      :autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>

      au BufNewFile ~/Nextcloud/Notes/diary/*.txt
        \ call append(0,[
        \ "# " . split(expand('%:r'),'/')[-1], "",
        \ "## Todo",  "",
        \ "## Notes", "" ])
    '';
  };
}
