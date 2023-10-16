page 50071 "Fee Course Hdr List-CS"
{
    // version V.001-CS

    Caption = 'Program Fee List';
    CardPageID = "Fee Course Hdr-CS";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Fee Course Head-CS";

    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'College Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {

        area(navigation)
        {
            group("&Course Fee ")
            {
                Caption = '&Course Fee ';
                /*   action("&Card")
                   {

                       Caption = '&Card';
                       Image = EditLines;
                       //RunObject = Page 33049446;
                       ShortCutKey = 'Shift+F7';
                       ApplicationArea = All;
                   }*/
                action(CopyFees)
                {
                    Caption = 'Copy Fees';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        CopyFeePage: Page "Copy Fee Document";
                    begin
                        CopyFeePage.VariablePassing('');
                        CopyFeePage.RunModal();
                    end;
                }
            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}