page 50713 "Immigration Approved list"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    DelayedInsert = false;
    InsertAllowed = false;
    CardPageId = "Immigration Approved Card";
    SourceTable = "Immigration Header";
    DataCaptionFields = "Document No.", "Student Name";
    SourceTableView = sorting("Document No.") order(Descending) where("Document Status" = filter(Verified | Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("AUA Email ID"; Rec."AUA Email ID")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    ApplicationArea = All;
                }
                field("Immigration Application Date"; Rec."Immigration Application Date")
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
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }
}

