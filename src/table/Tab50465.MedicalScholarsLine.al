table 50465 "Medical Scholars Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Semster No"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Course Sem. Master-CS"."Semester Code" where("Course Code" = field("Course Code"), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(4; Subject; Text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Course Wise Subject Line-CS"."Subject Code" where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Course Code" = field("Course Code"), Semester = field("Semster No"));
            // trigger OnValidate()
            // var
            //     SubjectMaster: Record "Course Wise Subject Line-CS";
            // begin
            //     Clear(SubjectMaster);
            //     if SubjectMaster.Get(Subject) then
            //         Validate(Description, SubjectMaster.Description)
            //     else
            //         Description := '';
            // end;
            // end;
        }
        field(5; "Course Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Course Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
        }
        field(6; "Subect Name "; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subject Name';
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(8; "Role Applied"; Option)
        {
            OptionMembers = " ",TA,Tutor,Both;


        }
        Field(9; "Student No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(10; Term; Option)
        {
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = Fall,SPRING,SUMMER;
        }
        Field(11; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(12; "End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(13; "Expected End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(14; Grade; Code[10])
        {
            DataClassification = CustomerContent;
        }
        Field(15; Level; Integer)
        {
            DataClassification = CustomerContent;

        }
        Field(16; Credit; Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(17; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(18; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(19; Position; Option)
        {
            OptionMembers = " ",TA,Tutor,Both;
            //DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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