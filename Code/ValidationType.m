classdef ValidationType < Simulink.IntEnumType
    %VALIDATIONTEST Defines enumerated types representing which
    %reduced-order model validation test to run
    %
    %Copyright 2021 The MathWorks, Inc.
    
    enumeration
        BENDING (0)
        TENSION (1)
        TORSION (2)
    end
end

