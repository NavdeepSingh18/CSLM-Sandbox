table 50095 "Sessional Exam Group-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    20-05-2019    OnInsert                      User Id Assign in User Id Field.
    // 2         CSPL-00092    20-05-2019    Exam Method Code OnValidate   Assign in Description and Exam Order Field

    Caption = 'Sessional Exam Group-CS';
    DrillDownPageID = "Group(Exam)-CS";
    LookupPageID = "Group(Exam)-CS";

    fields
    {
        field(1; "Exam Method Code"; Code[20])
        {
            Caption = 'Exam Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Exam Group Code-CS";

            trigger OnValidate()
            begin
                //Code added for User Id Assign in Description and Exam Order Field::CSPL-00092::20-05-2019: Start
                IF ExamMethod.GET("Exam Method Code") THEN BEGIN
                    Description := ExamMethod.Description;
                    "Exam Order" := ExamMethod."Exam Order";
                END ELSE BEGIN
                    Description := '';
                    "Exam Order" := 0;
                END;
                //Code added for User Id Assign in Description and Exam Order Field::CSPL-00092::20-05-2019: End
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Group; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            OptionCaption = ' ,Internal Exam,External Exam,Assignment,Internal Lab,External Lab,Project,Industrial Training';
            OptionMembers = " ","Internal Exam","External Exam",Assignment,"Internal Lab","External Lab",Project,"Industrial Training";
        }
        field(50004; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            TableRelation = "Subject Classification-CS";
        }
        field(50005; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50006; "Maximum Marks"; Decimal)
        {
            Caption = 'Maximum Marks';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
        }
        field(50007; "Maximum Weightage"; Decimal)
        {
            Caption = 'Maximum Weightage';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
        }
        field(50008; "Exam Order"; Integer)
        {
            BlankZero = true;
            Caption = 'Exam Order';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
            Editable = false;
        }
        field(50009; "Applicable Exam"; Boolean)
        {
            Caption = 'Applicable Exam';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-05-2019';
        }
    }

    keys
    {
        key(Key1; "Exam Method Code", "Academic Year", Group, "Document Type")
        {
        }
        key(Key2; Group)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::20-05-2019: End
    end;

    var

        ExamMethod: Record "Exam Group Code-CS";

}

