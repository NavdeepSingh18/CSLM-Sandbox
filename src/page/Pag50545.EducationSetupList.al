page 50545 "Education Setup List"
{
    Caption = 'Education Setup List';
    PageType = List;
    ApplicationArea = all;
    Editable = false;
    CardPageId = "Education Setup-CS";
    UsageCategory = Lists;
    SourceTable = "Education Setup-CS";

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                Editable = EditList;
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Key';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Session';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Rank Generation No."; Rec."Rank Generation No.")
                {
                    ApplicationArea = All;
                }
                field("Even/Odd Semester"; Rec."Even/Odd Semester")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Image File Path"; Rec."Image File Path")
                {
                    ApplicationArea = All;
                }
                field("XML File Path"; Rec."XML File Path")
                {
                    ApplicationArea = All;
                }
                field("Class Attendance Days"; Rec."Class Attendance Days")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks Days"; Rec."Internal Marks Days")
                {
                    ApplicationArea = All;
                }
                field("External Marks Days"; Rec."External Marks Days")
                {
                    ApplicationArea = All;
                }

                field("Task No."; Rec."Task No.")
                {
                    ApplicationArea = All;
                }
                field("Announcement No."; Rec."Announcement No.")
                {
                    ApplicationArea = All;
                }
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = All;
                }
                field("Logo Image"; Rec."Logo Image")
                {
                    ApplicationArea = All;
                }

                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                }
                field("Detainee List Prepaired"; Rec."Detainee List Prepaired")
                {
                    ApplicationArea = All;
                }
                field("Internal Exam Generated"; Rec."Internal Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("Assignment  Generated"; Rec."Assignment  Generated")
                {
                    ApplicationArea = All;
                }
                field("Exam Schedule Generated"; Rec."Exam Schedule Generated")
                {
                    ApplicationArea = All;
                }
                field("External Exam Generated"; Rec."External Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("End Semester Marks Published"; Rec."End Semester Marks Published")
                {
                    ApplicationArea = All;
                }
                field("Grade Generated"; Rec."Grade Generated")
                {
                    ApplicationArea = All;
                }
                field("Regular Exam Grade Alloted"; Rec."Regular Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Regular Exam Grade Published"; Rec."Regular Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Makeup Exam Grade Alloted"; Rec."Makeup Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Makeup Exam Grade Published"; Rec."Makeup Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Rev. 1 Exam Grade Alloted"; Rec."Rev. 1 Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Rev. 1  Exam Grade Published"; Rec."Rev. 1  Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Rev. 2  Exam Grade Published"; Rec."Rev. 2  Exam Grade Published")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Grade Alloted"; Rec."Special Exam Grade Alloted")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Grade published"; Rec."Special Exam Grade published")
                {
                    ApplicationArea = All;
                }
                field("GPA & CGPA Generated"; Rec."GPA & CGPA Generated")
                {
                    ApplicationArea = All;
                }
                field("MakeUp Exam Schedule Generated"; Rec."MakeUp Exam Schedule Generated")
                {
                    ApplicationArea = All;
                }
                field("MakeUp External Exam Generated"; Rec."MakeUp External Exam Generated")
                {
                    ApplicationArea = All;
                }
                field("Students Attendance Updated"; Rec."Students Attendance Updated")
                {
                    ApplicationArea = All;
                }
                field("Internal Marks Published"; Rec."Internal Marks Published")
                {
                    ApplicationArea = All;
                }
                field("Update Detained List"; Rec."Update Detained List")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Sche. Generated"; Rec."Special Exam Sche. Generated")
                {
                    ApplicationArea = All;
                }
                field("Housing Mail Terms"; Rec."Housing Mail Terms")
                {
                    ApplicationArea = All;
                }
                field("Housing Parking No."; Rec."Housing Parking No.")
                {
                    ApplicationArea = All;
                }
                field("Parking AICASA/AUA No."; Rec."Parking AICASA/AUA No.")
                {
                    ApplicationArea = All;
                }
                field("Parking BSIC No."; Rec."Parking BSIC No.")
                {
                    ApplicationArea = All;
                }
                field("Financial Accountability No."; Rec."Financial Accountability No.")
                {
                    ApplicationArea = All;
                }

                field("Housing Opt Out No."; Rec."Housing Opt Out No.")
                {

                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {

                    ApplicationArea = All;
                }
                field(url; Rec.url)
                {

                    ApplicationArea = All;
                }
                field("domain name"; Rec."domain name")
                {

                    ApplicationArea = All;
                }

                field("TG Number"; Rec."TG Number")
                {

                    ApplicationArea = All;
                }
                Field("E-mail ID (SalesForce Log)"; Rec."E-mail ID (SalesForce Log)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Education Setup Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;

    end;

    var
        UserSetup: Record "User Setup";
        EditList: Boolean;

}