codeunit 50057 "Student Map Mgt."
{
    //SD-SB-12-JAN-21 +
    [EventSubscriber(ObjectType::Codeunit, 802, 'OnBeforeValidAddress', '', false, false)]
    procedure ValidateAddressforMap(TableID: Integer; var IsValid: Boolean)
    begin
        IsValid := true;
        TableID := Database::"Student Master-CS";
    end;

    [EventSubscriber(ObjectType::Codeunit, 802, 'OnBeforeGetAddress', '', false, false)]
    procedure GetAddress(RecPosition: Text; TableID: Integer; var IsHandled: Boolean; var Parameters: array[12] of Text[100])
    var
        recordref: RecordRef;
        student_rec: Record "Student Master-CS";
        text001: Label 'The specified record could not be found.';
    begin
        if TableID = Database::"Student Master-CS" then begin
            RecordRef.OPEN(TableID);
            RecordRef.SETPOSITION(Format(RecPosition));
            IF NOT RecordRef.FIND('=') THEN
                ERROR(text001);

            RecordRef.SETTABLE(student_rec);
            Parameters[1] := Format(student_rec.Addressee) + ' ' + Format(student_rec.Address1) + ' ' + Format(student_rec.Address2);
            Parameters[2] := Format(student_rec.City);
            Parameters[3] := Format(student_rec.state);
            Parameters[4] := Format(student_rec."Post Code");
            Parameters[5] := Format(student_rec."Country Code");
        end;
    end;
    //SD-SB-12-JAN-21 -
}