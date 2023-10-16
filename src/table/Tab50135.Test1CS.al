table 50135 "Test1-CS"
{
    // version V.001-CS

    Caption = 'Assistant Registrar Mapping';

    fields
    {
        field(1; "Entry no"; Integer)
        {
            Caption = 'Entry no';
            DataClassification = CustomerContent;
        }
        field(2; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(3; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Application no"; Integer)
        {
            Caption = 'Application no';
            DataClassification = CustomerContent;
        }
        field(5; "Line Naration"; Text[30])
        {
            Caption = 'Line Naration';
            DataClassification = CustomerContent;
        }
        field(6; DebitBankAct1; Code[20])
        {
            Caption = 'DebitBankAct1';
            DataClassification = CustomerContent;
        }
        field(7; DebitBankAct2; Code[20])
        {
            Caption = 'DebitBankAct2';
            DataClassification = CustomerContent;
        }
        field(8; DebitAmt1; Decimal)
        {
            Caption = 'DebitAmt1';
            DataClassification = CustomerContent;
        }
        field(9; DebitAmt2; Decimal)
        {
            Caption = 'DebitAmt2';
            DataClassification = CustomerContent;
        }
        field(10; CreditACT1; Code[20])
        {
            Caption = 'CreditACT1';
            DataClassification = CustomerContent;
        }
        field(11; CreditACT2; Code[20])
        {
            Caption = 'CreditACT2';
            DataClassification = CustomerContent;
        }
        field(12; CreditACT3; Code[20])
        {
            Caption = 'CreditACT3';
            DataClassification = CustomerContent;
        }
        field(13; CreditACT4; Code[20])
        {
            Caption = 'CreditACT4';
            DataClassification = CustomerContent;
        }
        field(14; CreditACT5; Code[20])
        {
            Caption = 'CreditACT5';
            DataClassification = CustomerContent;
        }
        field(15; CreditACT6; Code[20])
        {
            Caption = 'CreditACT6';
            DataClassification = CustomerContent;
        }
        field(16; Amount1; Decimal)
        {
            Caption = 'Amount1';
            DataClassification = CustomerContent;
        }
        field(17; Amount2; Decimal)
        {
            Caption = 'Amount2';
            DataClassification = CustomerContent;
        }
        field(18; Amount3; Decimal)
        {
            Caption = 'Amount3';
            DataClassification = CustomerContent;
        }
        field(19; Amount4; Decimal)
        {
            Caption = 'Amount4';
            DataClassification = CustomerContent;
        }
        field(20; Amount5; Decimal)
        {
            Caption = 'Amount5';
            DataClassification = CustomerContent;
        }
        field(21; Amount6; Decimal)
        {
            Caption = 'Amount6';
            DataClassification = CustomerContent;
        }
        field(22; SLCTRID; Code[20])
        {
            Caption = 'SLCTRID';
            DataClassification = CustomerContent;
        }
        field(23; Line1RefType; Text[30])
        {
            Caption = 'Line1RefType';
            DataClassification = CustomerContent;
        }
        field(24; Line2RefType; Text[30])
        {
            Caption = 'Line2RefType';
            DataClassification = CustomerContent;
        }
        field(25; Line1RefNo; Code[20])
        {
            Caption = 'Line1RefNo';
            DataClassification = CustomerContent;
        }
        field(26; Line2RefNo; Code[20])
        {
            Caption = 'Line2RefNo';
            DataClassification = CustomerContent;
        }
        field(27; Line1RefDate; DateTime)
        {
            Caption = 'Line1RefDate';
            DataClassification = CustomerContent;
        }
        field(28; Line2RefDate; DateTime)
        {
            Caption = 'Line2RefDate';
            DataClassification = CustomerContent;
        }
        field(29; Line1Bank; Code[20])
        {
            Caption = 'Line1Bank';
            DataClassification = CustomerContent;
        }
        field(30; Line2Bank; Code[20])
        {
            Caption = 'Line2Bank';
            DataClassification = CustomerContent;
        }
        field(31; Line1Branch; Code[20])
        {
            Caption = 'Line1Branch';
            DataClassification = CustomerContent;
        }
        field(32; Line2Branch; Code[20])
        {
            Caption = 'Line2Branch';
            DataClassification = CustomerContent;
        }
        field(33; Line1RefAmount; Decimal)
        {
            Caption = 'Line1RefAmount';
            DataClassification = CustomerContent;
        }
        field(34; Line2RefAmount; Decimal)
        {
            Caption = 'Line2RefAmount';
            DataClassification = CustomerContent;
        }
        field(35; "Start Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(36; "End Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckDuplicateRange();
                ;
            end;
        }
        field(37; "User ID"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';
            trigger OnValidate()
            begin
                CheckDuplicateRange();

            end;
        }
        field(38; "User Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'User Name';
            trigger OnValidate()
            begin
                CheckDuplicateRange();
            end;
        }
        field(39; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Active,Inactive;
            trigger OnValidate()
            begin
                CheckDuplicateRange();

            end;
        }
        field(40; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(41; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Entry no")
        {
        }
    }

    fieldgroups
    {
    }
    Trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        Updated := true;
    end;

    procedure CheckDuplicateRange()
    var
        Users: Record User;
        AssistantRegistrarPlanning: Record "Test1-CS";
    begin
        Users.Reset();
        Users.SetRange("User Name", "User ID");
        if Users.FindFirst() then
            "User Name" := Users."Full Name";

        AssistantRegistrarPlanning.Reset();
        AssistantRegistrarPlanning.SetRange(Status, AssistantRegistrarPlanning.Status::Active);
        AssistantRegistrarPlanning.SetFilter("Entry no", '<>%1', "Entry No");
        if AssistantRegistrarPlanning.FindSet() then
            repeat
                if ("Start Alpha Range" >= AssistantRegistrarPlanning."Start Alpha Range") and ("End Alpha Range" <= AssistantRegistrarPlanning."End Alpha Range") then
                    Error('%1 No. Alpha Range already exist with Start Alpha Range: %2.\End Alpha Range %3.', AssistantRegistrarPlanning."Entry no", AssistantRegistrarPlanning."Start Alpha Range", AssistantRegistrarPlanning."End Alpha Range");
            until AssistantRegistrarPlanning.Next() = 0;
    end;

    procedure ViewStudentsWithUserList()
    var
        StudentMaster: Record "Student Master-CS";
    // StudentsWithClinicalUsers: Page "Students With Clinical Users";
    begin
        // Clear(StudentsWithClinicalUsers);
        StudentMaster.Reset();
        StudentMaster.FilterGroup(2);
        StudentMaster.SetRange("Assistant Registrar", "User ID");
        StudentMaster.FilterGroup(0);
        // StudentsWithClinicalUsers.SetVariable(false, false, false);
        // StudentsWithClinicalUsers.Caption('Student With Assistant Registrar');
        // StudentsWithClinicalUsers.SetTableView(StudentMaster);
        // StudentsWithClinicalUsers.RunModal();
    end;
}

