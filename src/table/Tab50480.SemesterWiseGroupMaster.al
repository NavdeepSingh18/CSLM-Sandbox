table 50480 "Semester Wise Group Master"
{
    DataClassification = CustomerContent;
    LookupPageId = "Semester Wise Group";
    DrillDownPageId = "Semester Wise Group";

    fields
    {

        Field(2; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        Field(3; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        Field(4; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = "FALL","SPRING","SUMMER";
        }
        field(5; Groups; Code[10])
        {
            Dataclassification = CustomerContent;
            Caption = 'Group';

        }
        Field(6; "No. of Students"; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(7; "Facilitator ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Caption = 'Facilitator ID 1';
        }
        Field(8; "Home Room"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Rooms-CS";
        }
        Field(9; "Subject Classification Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Small Group,ICM Lab,Anatomy Lab';
            OptionMembers = " ","Small Group","ICM Lab","Anatomy Lab";
        }
        Field(10; Section; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
            Caption = 'Groups';
        }
        Field(11; "Facilitator ID 2"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;

        }
        Field(12; "Facilitator ID 3"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;

        }
        Field(13; "Facilitator ID 4"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;

        }
        field(14; "Blackboard Group Code"; Text[50])////GAURAV//////8.6.22//
        {
            DataClassification = CustomerContent;
        }
        field(15; "Blackboard Group Name"; Text[100])
        {
            DataClassification = CustomerContent;////END//
        }
    }

    keys
    {
        key(Key1; Semester, "Academic Year", Term, Groups)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        EducationSetup: Record "Education Setup-CS";
        NoseriesMgmt: Codeunit NoSeriesManagement;
    begin
        IF Groups = '' then begin
            EducationSetup.Reset();
            EducationSetup.SetRange("Global Dimension 1 Code", '9000');
            IF EducationSetup.FindFirst() then
                Groups := NoseriesMgmt.GetNextNo(EducationSetup."Semester Group Mapping No.", Today(), true);
        end;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}