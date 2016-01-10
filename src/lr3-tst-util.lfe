(defmodule lr3-tst-util
  (export all))

(defun get-app-version
  ((name) (when (is_atom name))
    (get-app-src-version
      (code:where_is_file (++ (atom_to_list name) ".app"))))
  ((name) (error "App name must be an atom.")))

(defun get-app-src-version (filename)
  (let ((`#(ok (,app)) (file:consult filename)))
    (proplists:get_value 'vsn (element 3 app))))

(defun get-lfe-version ()
  (get-app-version 'lfe))

(defun get-version ()
  (get-app-version 'rebar))

(defun get-versions ()
  (let ((`#(ok ,rebar-version) (application:get_key 'rebar 'vsn)))
    `(#(erlang ,(erlang:system_info 'otp_release))
      #(emulator ,(erlang:system_info 'version))
      #(driver-version ,(erlang:system_info 'driver_version))
      #(lfe ,(get-lfe-version))
      #(rebar ,rebar-version))))

