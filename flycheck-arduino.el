;;; flycheck-arduino.el --- flycheck: Arduino support -*- lexical-binding: t; -*-

;; Copyright (C) 2015 by Yuta Yamada

;; Author: Yuta Yamada <cokesboy"at"gmail.com>
;; URL: https://github.com/yuutayamada/flycheck-arduino
;; Version: 0.0.1
;; Package-Requires: ((flycheck "0.22") (emacs "24") (arduino-mode "1.0"))
;; Keywords: Arduino

;;; License:
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;; Commentary:

;; NOTE: This project is still work in progress...

;; Usage:
;;   (add-hook 'arduino-mode-hook 'flycheck-arduino-setup)

;;; Code:
(require 'flycheck)
(require 'arduino-mode)

(flycheck-define-checker arduino
  ;; https://github.com/arduino/Arduino/blob/master/build/shared/manpage.adoc
  "Arduino checker using Arduino IDE. (This requires higher than version 1.5+)"
  ;; source, source-inplace, source-original
  :command ("arduino" "--verify" source-original)
  :error-patterns
  (;; I don't make sure about this warning... How to emit a warning?
   (warning line-start (file-name) ":" line ":" column ": warning: " (message) line-end)
   (error   line-start (file-name) ":" line ":" column ": " (0+ "fatal ") "error: " (message) line-end))
  :modes (arduino-mode))

;;;###autoload
(defun flycheck-arduino-setup ()
  "Setup Flycheck Arduino.

Add `arduino' to `flycheck-checkers'."
  (interactive)
  (add-to-list 'flycheck-checkers 'arduino))

(provide 'flycheck-arduino)
;;; flycheck-arduino.el ends here
