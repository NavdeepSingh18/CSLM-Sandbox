page 50852 "Residency Plac. Result Lines"
{

    ApplicationArea = All;
    Caption = 'Residency Placement Result Lines';
    PageType = List;
    SourceTable = "Residency Plac. Result Lines";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
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
                field("ERAS Applied"; Rec."ERAS Applied")
                {
                    ApplicationArea = All;
                }
                field("ERAS Interview Attended"; Rec."ERAS Interview Attended")
                {
                    ApplicationArea = All;
                }
                field("ERAS Interview Offered"; Rec."ERAS Interview Offered")
                {
                    ApplicationArea = All;
                }
                field("ERAS Program Ranked"; Rec."ERAS Program Ranked")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Applied"; Rec."CaRMS Applied")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Interview Attended"; Rec."CaRMS Interview Attended")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Interview Offered"; Rec."CaRMS Interview Offered")
                {
                    ApplicationArea = All;
                }
                field("CaRMS Program Ranked"; Rec."CaRMS Program Ranked")
                {
                    ApplicationArea = All;
                }
                field("Subject_Speciality Name"; Rec."Subject_Speciality Name")
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
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
