(defmodule lfe-test
  (behaviour provider)
  (export all))

(defun namespace () 'lfe)
(defun provider-name () 'test)
(defun short-desc () "The LFE rebar3 test plugin.")
(defun deps () '(#(default app_discovery)
                 #(default compile)
                 #(default lock)))

;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;;; Public API
;;;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

(defun init (state)
  (let* ((opts `(#(name ,(provider-name))
                 #(module ,(MODULE))
                 #(namespace ,(namespace))
                 #(opts (#(test-type #\t "test-type" atom
                           ,(++ "Type of test to run. Valid types are: "
                                (format-test-types)
                                ". If no type is provided, '"
                                (format-default-type)
                                "' is assumed."))))
                 #(deps ,(deps))
                 #(example "rebar3 lfe test")
                 #(short_desc ,(short-desc))
                 #(desc ,(info (short-desc)))
                 #(bare true)))
         (provider (providers:create opts)))
    `#(ok ,(rebar_state:add_provider state provider))))

(defun do (state)
  (rebar_api:debug "Paths: ~n~p" `(,(code:get_path)))
  (rebar_api:info "Running test framework ...\n" '())
  (case (rebar_state:command_parsed_args state)
    ;; empty opts & args -- use default
    (#(() ())
      (call 'ltest-runner (default-type)))
    ;; With no additional args
    (`#((#(test-type all)) ,_)
      (ltest-runner:all))
    (`#((#(test-type unit)) ,_)
      (ltest-runner:unit))
    (`#((#(test-type system)) ,_)
      (ltest-runner:system))
    (`#((#(test-type integration)) ,_)
      (ltest-runner:integration))
    (`#((#(test-type ,type)) ,_)
      (rebar_api:error "Unknown test-type value: ~p" `(,type)))
    ;; With additional args
    (`#((#(test-type all) ,_) ,_)
      (ltest-runner:all))
    (`#((#(test-type unit) ,_) ,_)
      (ltest-runner:unit))
    (`#((#(test-type system) ,_) ,_)
      (ltest-runner:system))
    (`#((#(test-type integration) ,_) ,_)
      (ltest-runner:integration))
    (`#((#(test-type ,type) ,_) ,_)
      (rebar_api:error "Unknown test-type value: ~p" `(,type)))
    (_ (rebar_api:error "Unknown option(s) or argument(s)." '())))
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

(defun default-type () 'all)

(defun format-default-type ()
  (atom_to_list (default-type)))

(defun legal-test-types ()
  "Get the list of allowed test types."
  `(unit system integration ,(default-type)))

(defun format-test-types ()
  "Format the list of allowed types in a manner suitable for inclusion in help
  text."
  (string:join (lists:map #'atom_to_list/1 (legal-test-types)) ", "))
