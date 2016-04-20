(defmodule lr3-tst-validate
  (export all))

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

(defun validate-option
  ""
  ((`#(,key ,val) pred)
    'noop))

(defun validate-test-type
  ""
  ((`#(type-test ,test-type))
    'noop))
