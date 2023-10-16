page 50298 "Subject Detail -CS"
{
    // version V.001-CS

    // Sr.No      Emp. ID        Date          Trigger        Remarks
    // --------------------------------------------------------------------------------------------------------------------------------
    // 1.        CSPL-00174     01-01-19      OnOpenPage()    Code added for college wise page filter and editable or non-editable list

    Caption = 'Subject Master List';
    CardPageID = "Subject Detail Card-CS";
    Editable = false;
    PageType = List;
    SourceTable = "Subject Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Enabled = EditList;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = all;
                }
                field("Subject Group Description"; Rec."Subject Group Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Level Description"; Rec."Level Description")
                {
                    ApplicationArea = all;
                }
                field(Examination; Rec.Examination)
                {
                    ApplicationArea = all;
                }
                field("Core Rotation Group"; Rec."Core Rotation Group")
                {
                    ApplicationArea = all;
                }
                field("Subject Prefix"; Rec."Subject Prefix")
                {
                    ApplicationArea = all;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = all;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Program/Open Elective Temp"; Rec."Program/Open Elective Temp")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Common Subject"; Rec."Common Subject")
                {
                    ApplicationArea = All;
                }
                field("Subject Not Required"; Rec."Subject Not Required")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }
                field("Maximum Weightage"; Rec."Maximum Weightage")
                {
                    ApplicationArea = All;
                }
                field("External Pass"; Rec."External Pass")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Total Pass"; Rec."Total Pass")
                {
                    ApplicationArea = All;
                }
                field("Total Maximum"; Rec."Total Maximum")
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
                field("Re-Apply"; Rec."Re-Apply")
                {
                    ApplicationArea = All;
                }
                field("Subject Wise Examination"; Rec."Subject Wise Examination")
                {
                    ApplicationArea = All;
                }
                field("Applicable Batch"; Rec."Applicable Batch")
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
            action("Subject Wise Goal List")
            {
                Caption = '&Subject Wise Goal List';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                RunObject = Page "Subject Goal List";
                RunPageLink = "Subject Code" = FIELD(Code);

            }
            action("Course Wise Faculty List")
            {
                ApplicationArea = All;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Faculty-Course Wise";
                RunPageLink = "Subject Code" = FIELD(Code);
            }
            action("Exam Passing Criteria")
            {
                Caption = '&Exam Passing Criteria';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                // RunObject = Page "Exam Passing Criteria";
                // RunPageLink = "Subject Code" = FIELD(Code);

            }
            group("Clerkship Assesment Setup")
            {
                action("Clerkship Assessment Weightage")
                {
                    Caption = 'Clerkship Assessment Weightage';
                    Image = OpportunityList;
                    // RunObject = page "Clerkship Assessment Weightage";
                    // RunPageLink = "Course Code" = field(Code);
                }
                action("CCSSE Score Conversion")
                {
                    Caption = 'CCSSE Score Conversion';
                    Image = Opportunity;
                    // RunObject = page "CCSSE Score Conversion";
                    // RunPageLink = "Course Code" = field(Code);
                }

                action("Clerkship Grading")
                {
                    Caption = 'Clerkship Grading';
                    Image = OpportunitiesList;
                    // RunObject = page "Clerkship Grading";
                    // RunPageLink = "Course Code" = field(Code);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for college wise page filter and editable or non-editable list::CSPL-00174::010119: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        IF recUserSetup.GET(UserId()) THEN
            IF recUserSetup."Student Subject Permission" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;
        //Code added for college wise page filter and editable or non-editable list::CSPL-00174::010119: End
    end;

    var
        recUserSetup: Record "User Setup";
        EditList: Boolean;
}