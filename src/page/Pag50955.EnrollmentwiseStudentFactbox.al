page 50955 "EnrollmentwiseStudentFactbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    SourceTableView = sorting("Original Student No.", "Enrollment Order");
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Caption = 'Enrollment Details';
    Editable = false;
    CardPageId = "Student Detail Card-CS";
    layout
    {
        area(Content)
        {
            group(Enrollwisecount)
            {
                caption = 'Student Enrollments';
                Field("No. of Enrollments"; Rec."No. of Enrollments")
                {
                    Caption = 'Total Enrollments';
                    ApplicationArea = All;
                }
                repeater(GroupName)
                {
                    field("Enrollment No."; Rec."Enrollment No.")
                    {
                        ApplicationArea = All;

                    }
                    Field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                    }
                    Field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Enrollment Order"; Rec."Enrollment Order")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}