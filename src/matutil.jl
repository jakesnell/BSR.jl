function mstatementquiet(ex::Expr)
    # add ; to the end of statements to suppress output
    ss = IOBuffer()
    MATLAB.write_mstatement(ss, ex)
    print(ss, ";")
    bytestring(ss)
end

macro mquiet(ex)
    # convenience macro to call MATLAB code with mstatementquiet
    :( MATLAB.eval_string($(mstatementquiet(ex))) )
end
