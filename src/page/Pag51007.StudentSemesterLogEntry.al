page 51007 "Student Semester Log Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Semester Log Entry";
    Editable = False;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Original Student No."; Rec."Original Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                Field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                }
                Field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                Field("Semester Decision"; Rec."Semester Decision")
                {
                    ApplicationArea = All;

                }
            }
        }

    }

}