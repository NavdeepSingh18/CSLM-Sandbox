tableextension 50513 "tableextension50513" extends "Sales Shipment Header"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    fields
    {
        field(33048920; "Fee Code"; Code[20])
        {
            Caption = 'Fee Code';
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048921; Class; Code[10])
        {
            Caption = 'Class';
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048922; Section; Code[10])
        {
            Caption = 'Section';
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048923; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048924; Course; Code[20])
        {
            Caption = 'Course';
            Description = 'CS Field Added 03-05-2019';
        }
        field(33048925; Semester; Code[10])
        {
            Caption = 'Semester';
            Description = 'CS Field Added 03-05-2019';
        }
    }
}

