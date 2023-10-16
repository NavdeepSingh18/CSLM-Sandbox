table 50176 "User Role-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   17/06/2019       OnModify()                                 Code added for any record change then assign value in Updated field
    // 02    CSPL-00114   17/06/2019       Course Code - OnValidate()                 Code added for Course name Get
    // 03    CSPL-00114   17/06/2019       Faculty Code - OnValidate()                Code added for Faculty Name

    Caption = 'User Role-CS';

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";

            trigger OnValidate()
            begin
                //Code added for Course name Get::CSPL-00114::17062019: Start
                IF CourseMasterCS.GET("Course Code") THEN
                    "Course Name" := CourseMasterCS.Description
                ELSE
                    "Course Name" := '';
                //Code added for Course name Get::CSPL-00114::17062019: End
            end;
        }
        field(5; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(6; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code"';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Faculty Name::CSPL-00114::17062019: Start
                IF Employee.GET("Faculty Code") THEN
                    "Faculty Name" := Format(Copystr(Employee."Search Name", 1, 50))
                ELSE
                    "Faculty Name" := '';
                //Code added for Faculty Name::CSPL-00114::17062019: End
            end;
        }
        field(7; "Faculty Name"; Text[50])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(8; Role; Code[10])
        {
            Caption = 'Role';
            DataClassification = CustomerContent;
        }
        field(9; "Subject code"; Code[20])
        {
            caption = 'Subject code';
            DataClassification = CustomerContent;
        }
        field(10; "Subject Name"; Text[30])
        {
            caption = 'Subject Name';
            DataClassification = CustomerContent;
        }
        field(11; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(12; Updated; Boolean)
        {
            Caption = 'Updated;';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for any record change then assign value in Updated field::CSPL-00114::17062019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for any record change then assign value in Updated field::CSPL-00114::17062019: End
    end;

    var
        CourseMasterCS: Record "Course Master-CS";
        Employee: Record "Employee";
}

