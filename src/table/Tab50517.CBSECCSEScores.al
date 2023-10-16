table 50517 "CBSE CCSE Scores"
{
    DataClassification = CustomerContent;
    Caption = 'CBSE/CCSE Scores';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Institution ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Institution ID';
        }
        field(3; "Test Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Test Date';
        }
        field(4; "Order Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order Number';

        }
        field(5; "Exam"; Text[100])
        {
            Caption = 'Exam';
            DataClassification = CustomerContent;

        }
        field(6; "ID"; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            Var
                StudentMaster_lRec: Record "Student Master-CS";
            Begin
                IF ID <> '' then begin
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", ID);
                    IF StudentMaster_lRec.FindFirst() then
                        Examinee := StudentMaster_lRec."Student Name";

                end Else
                    Examinee := '';
            End;
        }
        field(7; "Examinee"; Text[100])
        {
            Caption = 'Examinee';
            DataClassification = CustomerContent;
        }
        field(8; "Total Test"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Test';
        }
        field(9; "Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = ' ,CBSE,CCSE,CCSSE';
            OptionMembers = " ",CBSE,CCSE,CCSSE;
        }
        field(10; "Published"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(11; "Published Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Result Matched"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(13; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            //     TableRelation = "Subject Master-CS".Code where(Code = field("Core Subject Groups"));
            //     trigger OnValidate()
            //     begin
            //         SubjectMasterRec.Reset();
            //         SubjectMasterRec.SetRange(Code, "Subject Code");
            //         if SubjectMasterRec.FindFirst() then
            //             Exam := SubjectMasterRec.Description
            //         else
            //             Exam := '';
            //     end;
        }
        Field(14; Duplicate; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Core Subject Groups"; Code[1024])
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    Trigger OnModify()
    Begin
        IF (Duplicate = True) and ("Result Matched" = true) then
            Error('Entry No : %1 can not be modified', Rec."Entry No.");
    End;

    var
        SubjectMasterRec: Record "Subject Master-CS";


}
