page 50034 "Sem. Reg. list-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = false;
    SourceTable = "Student Registration-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Pass Port No. 1"; Rec."Pass Port No. 1")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Issued Date 1"; Rec."Pass Port Issued Date 1")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 1"; Rec."Pass Port Issued By 1")

                {
                    ApplicationArea = all;

                }
                field("Pass Port Expiry Date 1"; Rec."Pass Port Expiry Date 1")

                {
                    ApplicationArea = all;
                }
                field("Pass Port No. 2"; Rec."Pass Port No. 2")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Issued Date 2"; Rec."Pass Port Issued Date 2")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 2"; Rec."Pass Port Issued By 2")

                {
                    ApplicationArea = all;

                }
                field("Pass Port Expiry Date 2"; Rec."Pass Port Expiry Date 2")

                {
                    ApplicationArea = all;
                }
                field("Pass Port No. 3"; Rec."Pass Port No. 3")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Issued Date 3"; Rec."Pass Port Issued Date 3")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 3"; Rec."Pass Port Issued By 3")

                {
                    ApplicationArea = all;

                }
                field("Pass Port Expiry Date 3"; Rec."Pass Port Expiry Date 3")

                {
                    ApplicationArea = all;
                }
                field("Visa No."; Rec."Visa No.")
                {

                    ApplicationArea = all;
                }
                field("Visa Issued Date"; Rec."Visa Issued Date")

                {
                    ApplicationArea = all;

                }
                field("Visa Extension Date"; Rec."Visa Extension Date")
                {
                    ApplicationArea = all;
                }
                field("Visa Expiry Date"; Rec."Visa Expiry Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

