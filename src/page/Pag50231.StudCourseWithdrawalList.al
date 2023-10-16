page 50231 "Stud. Course Withdrawal List"
{
    // version V.001-CS
    Caption = 'Withdrawal Application Form List';
    CardPageID = "Stud. Withdrawal-CS";
    PageType = List;
    SourceTable = "Withdrawal Student-CS";
    SourceTableView = WHERE("Withdrawal Status" = FILTER(Open | "Pending for Approval"), "Type of Withdrawal" = filter("Course-Withdrawal"));
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Status"; Rec."Withdrawal Status")
                {
                    ApplicationArea = All;
                }

                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Student Subject")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Subject';
                // Runobject = page "Withdrawal Student Subject";
                // RunPageLink = "Withdrawal Request No." = field("No."), "Student No." = FIELD("Student No.");
            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        EducationSetupRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        UserSetupRec.Get(UserId());
        /*
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        if EducationSetupRec."Course Withdrawal Applicable" = false then
            Error('Course withdrawal is not applicable for the Institute %1', UserSetupRec."Global Dimension 1 Code");
        */
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Type of Withdrawal" := Rec."Type of Withdrawal"::"Course-Withdrawal";
    end;
}