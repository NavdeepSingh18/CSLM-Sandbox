tableextension 50567 "tableextension50567" extends "Sales Invoice Header"
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621-CS

    fields
    {
        field(50000; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque No."; Code[20])
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
        }
        field(50002; "Cheque Date"; Date)
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
        }
        field(33048920; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; Class; Code[10])
        {
            Caption = 'Class';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048922; Section; Code[10])
        {
            Caption = 'Section';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048923; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048924; Course; Code[20])
        {
            Caption = 'Course';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(33048925; Semester; Code[10])
        {
            Caption = 'Semester';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
    }
}