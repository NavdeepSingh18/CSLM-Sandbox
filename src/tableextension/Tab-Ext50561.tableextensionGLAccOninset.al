tableextension 50561 "tableextensionGLAccOninset" extends "G/L Account"
{
    trigger OnInsert()
    begin
        Blocked := true;
    end;

}

