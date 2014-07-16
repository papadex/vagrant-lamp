(add-to-list 'load-path (concat vendor-dir "jedi/"))
(require 'jedi)

(setq jedi:server-command
'("/usr/local/bin/ipython" "/home/vagrant/.emacs.d/vendor/jedi/jediepcserver.py"))

(add-hook 'python-mode-hook
(lambda()
(jedi:setup)
(jedi:ac-setup)
(local-set-key "\C-cd" 'jedi:show-doc)
(local-set-key (kbd "M-SPC") 'jedi:complete)
(local-set-key (kbd "M-.") 'jedi:goto-definition)
)
)

(add-hook 'python-mode-hook 'auto-complete-mode)

(setq jedi:setup-keys t)
