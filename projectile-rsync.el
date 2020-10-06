;;; projectile-rsync.el --- rsync local project to remote directory  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Anish Moorthy

;; Author: Anish Moorthy <anlsh@protonmail.com>
;; Based heavily off of Xingchen Ma's project-rsync (https://github.com/maxc01/project-rsync),
;; thought at this point not much of their code remains.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package is used to rsync a local project to a remote directory

;;; Code:

(require 'projectile)

(defgroup rsync nil
  "Run rsync as inferior of Emacs."
  :group 'tool
  :group 'processes)

(defcustom rsync-command-base "rsync -CavP"
  "Base rsync command."
  :type 'hook
  :group 'rsync)

(defvar-local rsync-remote-base-dir nil
  "Remote directory.")

;;;###autoload
(defun rsync-project ()
  "Rsyncs the current project to the specified remote directory."
  (interactive)
  (unless (projectile-project-root)
      (error "local-project-dir is nil"))
  (if (null rsync-remote-base-dir)
      (error "remote-project-dir is nil"))
  (let* ((buffer-name (format "*rsync-%s*" (projectile-project-name)))
         (command (format "%s %s %s"
                          rsync-command-base (projectile-project-root) rsync-remote-base-dir))
         (process-name (format "rsync-process-%s" (projectile-project-name))))
    (with-current-buffer buffer-name
      ;; TODO This doesn't seem to do what I want it to, projectile ibuffer still shows the
      ;; process as not being part of any project
      (setq default-directory (projectile-project-root))
      (setq major-mode 'help-mode)
      (if (get-buffer-process buffer-name)
          (message "rsync currently in progress for %s, bringing that up instead"
                   (projectile-project-name))
        (progn
          (let ((inhibit-read-only t))
            (erase-buffer))
          (start-process-shell-command process-name buffer-name command)))
      (pop-to-buffer-same-window buffer-name)
      (goto-char (point-min)))))

(provide 'projectile-rsync)
;;; project-rsync.el ends here
