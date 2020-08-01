(defmoule rebar3_lfe_ltest
  (export
    (init 1)))

(defun init (state)
  (rebar_api:debug "Initializing rebar3_lfe_ltest plugin (top-level)...")
  (rebar3_lfe_prv_ltest:init state))
