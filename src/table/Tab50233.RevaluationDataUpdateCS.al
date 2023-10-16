table 50233 "Revaluation Data Update-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   12/06/2019       OnInsert()                                 Get Subject Type Values from Subject master

    Caption = 'Revaluation Data Update-CS';

    fields
    {
        field(1; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(2; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get Subject Type Values from Subject master::CSPL-00114::12062019: Start
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS.Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Subject Type" := SubjectMasterCS."Subject Type";

                //Code added for Get Subject Type Values from Subject master::CSPL-00114::12062019: End
            end;
        }
        field(3; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Enrollment No.", "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SubjectMasterCS: Record "Subject Master-CS";
}

