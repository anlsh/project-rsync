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

(require 'project)

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
(defcustom rsync-command-base "rsync -avP"
  "Base rsync command."
  :type 'hook
  :group 'rsync)

;;;###autoload
(defcustom rsync-remote-base-dir nil
  "Remote directory."
  :type 'string
  :group 'rsync)

(defvar-local rsync-local-project-dir nil
  "Local project directory.")

(defvar-local rsync-local-project-name nil
  "Local project name.")

(defvar-local rsync-buffer-name nil
  "Buffer name of rsync mode.")

(defvar-local rsync-command nil
  "Shell command for rsync.")

;;;###autoload
(defun rsync-project ()
  "Run `rsync-command', show the message in `rsync-buffer-name'."
  (interactive)
  (rsync-setup)
  (if (and rsync-command rsync-buffer-name)
      (shell-command rsync-command rsync-buffer-name)
    (message "remote directory rsync-remote-base-dir must be set.")))

;;;###autoload
(define-minor-mode rsync-minor-mode
  "Toggle rsync mode."
  nil " rsync"
  :group 'rsync
  (if rsync-minor-mode
      (rsync-setup)))

(defvar rsync-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (set-keymap-parent map special-mode-map)
    (define-key map "g" 'rsync-project)
    map)
  "Keymap for `rsync-minor-mode.'")


(provide 'project-rsync)
;;; project-rsync.el ends here
