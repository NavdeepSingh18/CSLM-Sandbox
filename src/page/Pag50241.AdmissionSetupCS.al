page 50241 "Admission Setup-CS"
{
    // version V.001-CS

    Caption = 'Admission Setup';
    PageType = Card;
    SourceTable = "Admission Setup-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appl Cost Method"; Rec."Appl Cost Method")
                {
                    ApplicationArea = All;
                }
                field("Application Cost For Reserve"; Rec."Application Cost For Reserve")
                {
                    ApplicationArea = All;
                }
                field("Application Cost For Others"; Rec."Application Cost For Others")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost For Reserve"; Rec."Registration Cost For Reserve")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost For Others"; Rec."Registration Cost For Others")
                {
                    ApplicationArea = All;
                }
                field("Application Cost Account No."; Rec."Application Cost Account No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost Account No."; Rec."Registration Cost Account No.")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Application Sales Batch Name"; Rec."Application Sales Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Registration Batch Name"; Rec."Registration Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Admission Year"; Rec."Admission Year")
                {
                    ApplicationArea = All;
                    Caption = 'Session';
                }
                field("Total Marks Category Code"; Rec."Total Marks Category Code")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Category Code"; Rec."Evaluation Category Code")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Category Code"; Rec."Stage1 Category Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Application Sales Posting No."; Rec."Application Sales Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Posting No."; Rec."Registration Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Sel Process Stage1 No."; Rec."Sel Process Stage1 No.")
                {
                    ApplicationArea = All;
                }
                field("Mess Attendance"; Rec."Mess Attendance")
                {
                    ApplicationArea = All;
                }
                field("Sel Process Stage2 No."; Rec."Sel Process Stage2 No.")
                {
                    ApplicationArea = All;
                }
                field("Prospectus No."; Rec."Prospectus No.")
                {
                    ApplicationArea = All;
                }
                field("Time Slot No."; Rec."Time Slot No.")
                {
                    ApplicationArea = All;
                }
                field("Time Table No."; Rec."Time Table No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Housing Issue No."; Rec."Housing Issue No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Setup)
            {
                Caption = '&Setup';
                action("&Initial Fee Setup")
                {
                    Caption = '&Initial Fee Setup';
                    RunObject = Page 50167;
                    ApplicationArea = All;
                }
            }
        }
    }
}

