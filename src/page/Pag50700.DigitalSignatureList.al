page 50700 "Digital Signature List"
{

    ApplicationArea = All;
    Caption = 'Digital Signature List';
    PageType = List;
    SourceTable = "Digital Signature Details";
    UsageCategory = Lists;
    InsertAllowed = False;
    DeleteAllowed = false;
    Editable = False;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = all;
                }
                field("Document Category"; Rec."Document Category")
                {
                    ApplicationArea = all;
                }
                field("Document Sub Category"; Rec."Document Sub Category")
                {
                    ApplicationArea = all;
                }

                field("Hello Sign ID"; Rec."Hello Sign ID")
                {
                    ApplicationArea = all;
                }
                field("Signatory/User ID"; Rec."Signatory/User ID")
                {
                    ApplicationArea = all;
                }
                field("Signature Request Sent Date"; Rec."Signature Request Sent Date")
                {
                    ApplicationArea = all;
                }
                field("Signature Request Sent Time"; Rec."Signature Request Sent Time")
                {
                    ApplicationArea = all;
                }
                field("Signature Status"; Rec."Signature Status")
                {
                    ApplicationArea = all;
                }
                field("Signed Date"; Rec."Signed Date")
                {
                    ApplicationArea = all;
                }
                field("Signed Time"; Rec."Signed Time")
                {
                    ApplicationArea = all;
                }
                field("Verified Required"; Rec."Verified Required")
                {
                    ApplicationArea = all;
                }
                field("Digital Signature Required"; Rec."Digital Signature Required")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
