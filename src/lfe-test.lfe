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
                           ,(++ "Type of test to run. Valid types are: "
                                (lr3-tst-validate:format-test-types)
                                ". If no type is provided, '"
                                (lr3-tst-validate:format-default-type)
                                "' is assumed."))))
                 #(deps ,(deps))
                 #(example "rebar3 lfe test")
                 #(short_desc ,(short-desc))
                 #(desc ,(info (short-desc)))
                 #(bare true)))
         (provider (providers:create opts)))
    `#(ok ,(rebar_state:add_provider state provider))))

(defun do (state)
  (rebar_api:info "Running tests ...\n" '())
  (case (rebar_state:command_parsed_args state)
    ;; empty opts & args -- use default
    (#(() ())
      (call 'ltest-runner (lr3-tst-validate:default-type)))
    ;; With no additional args
    (`#((#(test-type all)) ,_)
      (ltest-runner:all))
    (`#((#(test-type unit)) ,_)
      (ltest-runner:unit))
    (`#((#(test-type system)) ,_)
      (ltest-runner:system))
    (`#((#(test-type integration)) ,_)
      (ltest-runner:integration))
    ;; With additional args
    (`#((#(test-type all) ,_) ,_)
      (ltest-runner:all))
    (`#((#(test-type unit) ,_) ,_)
      (ltest-runner:unit))
    (`#((#(test-type system) ,_) ,_)
      (ltest-runner:system))
    (`#((#(test-type integration) ,_) ,_)
      (ltest-runner:integration))
    (_ (rebar_api:error "Unknown test-type value.")))
  `#(ok ,state))

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
