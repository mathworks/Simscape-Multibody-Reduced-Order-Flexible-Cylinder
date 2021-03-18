function show_SDI_view(TestRan)
% Copyright 2021 The MathWorks, Inc.
%SHOW_SDI_VIEW Displays the appropriate view in SDI based on the input

arguments
    TestRan (1,1) ValidationType
end

switch TestRan
    case ValidationType.BENDING
        Simulink.sdi.loadView("Misc\Bending_Test_View.mldatx")
    case ValidationType.TENSION
        Simulink.sdi.loadView("Misc\Tension_Test_View.mldatx")
    case ValidationType.TORSION
        Simulink.sdi.loadView("Misc\Torsion_Test_View.mldatx")
    otherwise
        error("Invalid input.")
end

%bring SDI into view
Simulink.sdi.view
end

