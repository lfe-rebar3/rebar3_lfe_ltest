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
  (let* ((opts `(#(name ,(provider-name))
                 #(module ,(MODULE))
                 #(namespace ,(namespace))
                 #(opts (#(test-type #\t "test-type" atom
                           ,(++ "Type of test to run. Valid types are "
                                "'unit', 'system', 'integration', and "
                                "'all'. If no type is provided, 'all' "
                                "is assumed.")))
                 #(deps ,(deps))
                 #(example "rebar3 lfe test")
                 #(short_desc ,(short-desc))
                 #(desc ,(info (short-desc)))
                 #(bare true)))
         (provider (providers:create opts)))
    `#(ok ,(rebar_state:add_provider state provider))))

(defun do (state)
  (rebar_api:info "Running tests ..." '())
  (let ((raw-args (rebar_state:command_args state))
        (args (rebar_state:command_parsed_args state)))
    (rebar_api:info "Got raw args: ~p" `(,raw-args))
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

(defun help (x)
  (io:format "~nGot help stuff: ~p~n" `(,x)))

(defun format_help (x)
  (io:format "~nGot format_help stuff: ~p~n" `(,x)))

(defun display_help (x)
  (io:format "~nGot display_help stuff: ~p~n" `(,x)))
