;;; project-rsync.el --- rsync local project to remote directory  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Xingchen Ma

;; Author: Xingchen Ma <maxc01@yahoo.com>
;; Keywords: tools, processes

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

(defgroup rsync nil
  "Run rsync as inferior of Emacs."
  :group 'tool
  :group 'processes)

;;;###autoload
(defcustom rsync-mode-hook nil
  "Lost of hook functions run by  `rsync-mode'."
  :type 'hook
  :group 'rsync)

;;;###autoload
(defcustom rsync-remote-base-dir nil
  "Remote directory.")

;;;###autoload
(defcustom rsync-local-project-dir (dir-without-slash (string-remove-suffix "/" (cdr (project-current))))
  "Local project directory.")

;;;###autoload
(defcustom rsync-local-project-name (file-name-nondirectory rsync-local-project-name)
  "Local project name.")

;;;###autoload
(defcustom rsync-buffer-name (concat "*rsync*-" rsync-local-project-name)
  "Buffer name of rsync mode.")

;;;###autoload
(defcustom rsync-command (format "rsync -avP %s %s" rsync-local-project-dir rsync-remote-base-dir)
  "Shell command for rsync.")

;;;###autoload
(defun rsync-project ()
  "Run `rsync-command', show the message in `rsync-buffer-name'."
  (shell-command rsync-command rsync-buffer-name))

;;;###autoload
(define-minor-mode rsync-minor-mode
  "Toggle rsync mode."
  nil " rsync"
  :group 'rsync)

(defvar rsync-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map special-mode-map)
    (define-key-map map "g" 'rsync-project)
    map)
  "Keymap for `rsync-minor-mode.'")


(provide 'project-rsync)
;;; project-rsync.el ends here
