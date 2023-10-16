table 50365 "Student Wise Holds"
{
    Caption = 'Student Wise Holds';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate();
            begin
                if StudentMasterRec.Get("Student No.") then begin
                    "Student Name" := StudentMasterRec."Student Name";
                    Semester := StudentMasterRec.Semester;
                    "Admitted Year" := StudentMasterRec."Admitted Year";
                    "Academic Year" := StudentMasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                end else begin
                    "Student Name" := '';
                    Semester := '';
                    "Admitted Year" := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                end;
            end;

        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;

        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;

        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;

        }
        field(5; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;

        }
        field(6; "Hold Code"; Code[20])
        {
            Caption = 'Hold Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Hold"."Hold Code";
            trigger OnValidate()
            begin
                if StudentHoldRec.get("Hold Code", "Global Dimension 1 Code") then begin
                    "Hold Description" := StudentHoldRec."Hold Description";
                    "Hold Type" := StudentHoldRec."Hold Type";
                    "Potal Login Restriction" := StudentHoldRec."Potal Login Restriction";
                    "Clinical Rotation" := StudentHoldRec."Clinical Rotation";
                    "Transcript Print" := StudentHoldRec."Transcript Print";
                    Progression := StudentHoldRec.Progression;
                    Billing := StudentHoldRec.Billing;
                end else begin
                    "Hold Description" := '';
                    "Hold Type" := "Hold Type"::" ";
                    "Potal Login Restriction" := false;
                    "Clinical Rotation" := false;
                    "Transcript Print" := false;
                    Progression := false;
                    Billing := false;
                end;
            end;

        }
        field(7; "Hold Description"; Text[250])
        {
            Caption = 'Hold Message';
            DataClassification = CustomerContent;

        }
        field(8; "Hold Type"; Option)
        {
            Caption = 'Hold Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Housing,Financial Aid,Bursar,Registrar,Registrar Sign-off,Immigration,Clinical,OLR Finance'; //CS_SG 20230523 Added OLR Finance
            OptionMembers = " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";//CS_SG 20230523 Added OLR Finance
        }
        field(9; "Potal Login Restriction"; Boolean)
        {
            Caption = 'Potal Login Restriction';
            DataClassification = CustomerContent;

        }
        field(10; "Clinical Rotation"; Boolean)
        {
            Caption = 'Clinical Rotation';
            DataClassification = CustomerContent;

        }
        field(11; "Transcript Print"; Boolean)
        {
            Caption = 'Transcript Print';
            DataClassification = CustomerContent;

        }
        field(12; Progression; Boolean)
        {
            Caption = 'Progression';
            DataClassification = CustomerContent;

        }
        field(13; Billing; Boolean)
        {
            Caption = 'Billing';
            DataClassification = CustomerContent;

        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

        }
        field(16; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';

            OptionCaption = 'Enable,Disable';
            OptionMembers = Enable,Disable;

        }
        field(17; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';


        }
        field(18; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';


        }
        field(19; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';


        }
        field(20; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';


        }
        field(21; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';


        }
        field(22; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';


        }
        field(23; "Sign-off"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sign-off';

        }
        field(24; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Group.Code;
            Editable = false;
        }
        field(25; "First Name"; Text[35])
        {
            Caption = 'First Name';
            FieldClass = Flowfield;
            CalcFormula = lookup("Student Master-CS"."First Name" where("No." = field("Student No.")));
        }

        field(26; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            FieldClass = Flowfield;
            CalcFormula = lookup("Student Master-CS"."Last Name" where("No." = field("Student No.")));
        }

    }
    keys
    {
        key(key1; "Student No.", "Hold Code")
        {
            Clustered = true;
        }
        key(StatusSorting; "Student No.", Status)
        {
            Clustered = false;
        }
        Key(Key3; "Created On")
        {

        }
    }

    Var
        StudentMasterRec: Record "Student Master-CS";
        StudentHoldRec: Record "Student Hold";

        StudentGroup: Record "Student Group";

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
        StudentGroup.EnableStudentGroupCodeHoldWise(Rec);
        StudentGroup.EnableDisableGroupCodeHold(Rec, 1);
    end;

    trigger OnDelete()
    begin
        StudentGroup.EnableDisableGroupCodeHold(Rec, 2);
        StudentGroup.DeleteStudentGroupCodeHoldWise(Rec);
    end;

    TRigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}
