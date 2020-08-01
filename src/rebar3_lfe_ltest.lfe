(defmoule rebar3_lfe_ltest
  (export
    (init 1)))

(defun init (state)
  (lists:foldl
    (lambda
      ((fun `#(ok, state))
        (funcall fun state))
    (list #'rebar3_lfe_prv_ltest:init/1))))
