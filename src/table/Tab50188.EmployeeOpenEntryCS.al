table 50188 "Employee Open Entry-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   27/05/2019       OnInsert()                                 Get Auto Created On Values
    // 02    CSPL-00114   27/05/2019       OnModify()                                 Code added for Data Modification Flag & Validation
    // 03    CSPL-00114   27/05/2019       OnDelete()                                 Code added for Delete related Permission.
    // 04    CSPL-00114   27/05/2019       OnRename()                                 Code added for Updated related permission.
    // 05    CSPL-00114   27/05/2019       Employee Code - OnValidate()               Code added for Get Value Employee Name & End Date

    Caption = 'Employee Open Entry-CS';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";


            trigger OnValidate()
            begin
                //Code added for Get Value Employee Name & End Date::CSPL-00114::27052019: Start
                EmployeeCS.Reset();
                EmployeeCS.SETRANGE(EmployeeCS."No.", "Employee Code");
                IF EmployeeCS.FINDFIRST() THEN BEGIN
                    "Employee Name" := EmployeeCS."First Name";
                    "Global Dimension 1 Code" := EmployeeCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := EmployeeCS."Global Dimension 2 Code";
                    "End Date" := WORKDATE();
                END;
                //Code added for Get Value Employee Name & End Date::CSPL-00114::27052019: End
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
            caption = 'Employee Name';
            DataClassification = CustomerContent;

        }
        field(3; "Start Date"; Date)
        {
            caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD("Start Date");
            end;
        }
        field(4; "End Date"; Date)
        {
            caption = 'End Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Open Entry Type"; Option)
        {
            caption = 'Open Entry Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal Marks Entry,External Marks Entry,Assignment Marks Entry,Attendance Entry,Lab';
            OptionMembers = " ","Internal Marks Entry","External Marks Entry","Assignment Marks Entry","Attendance Entry",Lab;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(8; "Created By"; Code[20])
        {
            caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(9; "Created On"; Date)
        {
            caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(10; "Updated By"; Code[20])
        {
            caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(11; "Updated On"; Date)
        {
            caption = 'Updated On';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Start Date", "End Date", "Open Entry Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete related Permission::CSPL-00114::27052019: Start
        IF UserSetupCS.GET(UserId()) THEN
            IF UserSetupCS."Student Subject Permission" THEN
                MESSAGE('Record Delete Successfully')
            ELSE
                ERROR('You Do Not have Permission for Record Deletion');

        //Code added for Delete related Permission::CSPL-00114::27052019: End
    end;

    trigger OnInsert()
    begin
        //Get Auto Created On Values ::CSPL-00114::27052019: Start
        "Created On" := TODAY();
        //Get Auto Created On Values ::CSPL-00114::27052019: End
    end;

    trigger OnModify()
    begin
        //Get Auto Created On Values ::CSPL-00114::27052019: Start
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        IF ("Updated On" <> 0D) AND ("Updated By" <> '') THEN
            ERROR('You Do Not have Permission for Record Modify');
        //Get Auto Created On Values ::CSPL-00114::27052019: End
    end;

    trigger OnRename()
    begin
        //Code added for Updated related permission::CSPL-00114::27052019: Start
        IF ("Updated On" <> 0D) AND ("Updated By" <> '') THEN
            ERROR('You Do Not have Permission for Record Modify');

        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());
        //Code added for Updated related permission::CSPL-00114::27052019: End
    end;

    var
        EmployeeCS: Record "Employee";
        UserSetupCS: Record "User Setup";

}

