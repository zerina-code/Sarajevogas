codeunit 50050 "Library Assert"
{
    procedure IsTrue(Value: Boolean; Message: Text[250])
    begin
        if not Value then
            Error(Message);
    end;

    procedure IsFalse(Value: Boolean; Message: Text[250])
    begin
        if Value then
            Error(Message);
    end;

    procedure AreEqual(Expected: Integer; Actual: Integer; Message: Text[250])
    begin
        if Expected <> Actual then
            Error(Message + '\nExpected: ' + Format(Expected) + ' Actual: ' + Format(Actual));
    end;

    procedure AreEqual(Expected: Text; Actual: Text; Message: Text[250])
    begin
        if Expected <> Actual then
            Error(Message + '\nExpected: ' + Expected + ' Actual: ' + Actual);
    end;

    procedure AreEqual(Expected: DateTime; Actual: DateTime; Message: Text[250])
    begin
        if Expected <> Actual then
            Error(Message + '\nExpected: ' + Format(Expected) + ' Actual: ' + Format(Actual));
    end;
}
