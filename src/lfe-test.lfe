(defmodule lfe-test
  (behaviour provider)
  (export all))

(defun namespace () 'lfe)
(defun provider-name () 'test)
(defun short-desc () "The LFE rebar3 test plugin.")
(defun deps () '(#(default app_discovery)))

;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;; Public API
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

(defun init (state)
  (let* ((opts `(#(name ,(provider-name))        ; The 'user friendly' name
                 #(module ,(MODULE))             ; The module implementation
                 #(namespace ,(namespace))       ; Plugin namespace
                 #(opts (#(cmd undefined undefined atom all "Test type")))                      ; List of plugin options
                 #(deps ,(deps))                 ; The list of dependencies
                 #(example "rebar3 lfe test")    ; How to use the plugin
                 #(short_desc ,(short-desc))     ; A one-line description
                 #(desc ,(info (short-desc)))    ; A longer description
                 #(bare true)))                  ; The task can be run by user
         (provider (providers:create opts)))
    `#(ok ,(rebar_state:add_provider state provider))))

(defun do (state)
  (rebar_api:info "Running tests ..." '())
  (let ((args (rebar_state:command_args state)))
    (rebar_api:info "Got args: ~p" `(,args))
    `#(ok ,state)))

(defun format_error (reason)
  (io_lib:format "~p" `(,reason)))

;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;; Internal functions
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

(defun info (desc)
  (io_lib:format
    (++ "~n~s~n~n"
        "Run the unit, system, and integration tests "
        "for the project.~n"
        "~n")
    `(,desc)))
